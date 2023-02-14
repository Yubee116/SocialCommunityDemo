class CommentsController < ApplicationController
  before_action :set_comment, :check_is_creator, only: %i[show edit update destroy]
  before_action :set_post, :set_group, :check_is_member, :check_is_group_creator, only: %i[create update]
  # after_action :update_post_activity, only: %i[create update]

  # GET /comments or /comments.json
  def index
    @comments = Comment.order(created_at: :desc)
  end

  # GET /comments/1 or /comments/1.json
  def show; end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit; end

  # POST /comments or /comments.json
  def create
    @post = Post.find(comment_params[:post_id])
    @comment = Comment.new(comment_params.merge(user_id: current_user.id))

    respond_to do |format|
      unless @is_member || @is_group_creator
        redirect_to post_url(@post),
                    alert: 'Unable to comment as you are not a member of the group' and return
      end

      if @comment.save
        update_post_and_group_activity
        format.html { redirect_to post_url(@post), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to post_url(@post), status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      unless @is_creator || @is_group_creator
        redirect_to post_url(@post),
                    alert: 'You cannot edit this comment' and return
      end

      if @comment.update(comment_params)
        format.html { redirect_to post_url(@post), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { redirect_to post_url(@post), status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @post = @comment.post
    @group = @post.group
    unless @is_creator || @group.creator_id == current_user.id
      redirect_to post_url(@post), alert: 'You cannot delete this comment' and return
    end

    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_post
    @post = Post.find(comment_params[:post_id])
  end

  def set_group
    @group = Group.find(@post.group_id)
  end

  def check_is_member
    @is_member = current_user.memberships.where(group_id: @group.id).exists?
  end

  def check_is_group_creator
    @is_group_creator = @group.creator_id == current_user.id
  end

  def check_is_creator
    @is_creator = @comment.user_id == current_user.id
  end

  def update_post_and_group_activity
    @post.last_activity = Time.now
    @post.save

    @group.last_activity = Time.now
    @group.save
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:content, :parent_id, :post_id)
  end
end
