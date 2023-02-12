class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :set_group, :check_is_member, :check_is_group_creator, only: %i[ create update ]
  after_action :update_group_activity, only: %i[ create update ]

  # GET /posts or /posts.json
  def index
    @posts = Post.order(created_at: :desc)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comment = @post.comments.build
    @comments = @post.comments.all
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params.merge(user_id: current_user.id))

    respond_to do |format|
      if (@is_group_creator && @post.save) || (@is_member && @post.save)
        format.html { redirect_to group_url(@group), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        validation_message = @is_member ?  @post.errors : "Unable to create post as you are not a member of the group"
        format.html { redirect_to group_url(@group), status: :unprocessable_entity, alert: validation_message  }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
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
