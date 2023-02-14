class PostsController < ApplicationController
  before_action :set_post, :check_is_creator, only: %i[show edit update destroy]
  before_action :set_group, :check_is_member, :check_is_group_creator, only: %i[create update]
  # after_action :update_group_activity, only: %i[ create update ]

  # GET /posts or /posts.json
  def index
    @posts = Post.order(created_at: :desc)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comment = @post.comments.build
    @comments = @post.comments.order(created_at: :desc)
    @group = @post.group
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params.merge(user_id: current_user.id))

    respond_to do |format|
      unless @is_member || @is_group_creator
        redirect_to group_url(@group),
                    alert: 'Unable to create post as you are not a member of the group' and return
      end

      if @post.save
        update_group_activity
        format.html { redirect_to post_url(@post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to group_url(@group), status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      redirect_to post_url(@post), alert: 'You cannot edit this post' and return unless @is_creator || @is_group_creator

      if @post.update(post_params)
        update_group_activity
        format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    # redirect_to post_url(@post), alert: 'You cannot delete this post' and return unless @is_group_creator || @is_creator
    @group = @post.group
    unless @is_creator || @group.creator_id == current_user.id
      redirect_to post_url(@post), alert: 'You cannot delete this post' and return
    end

    @post.destroy
    update_group_activity

    respond_to do |format|
      format.html { redirect_to group_url(@group), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def set_group
    @group = Group.find(post_params[:group_id])
  end

  def update_group_activity
    @group.last_activity = Time.now
    @group.save
  end

  def check_is_member
    @is_member = current_user.memberships.where(group_id: post_params[:group_id]).exists?
  end

  def check_is_group_creator
    @is_group_creator = @group.creator_id == current_user.id
  end

  def check_is_creator
    @is_creator = @post.user_id == current_user.id
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :content, :group_id)
  end
end
