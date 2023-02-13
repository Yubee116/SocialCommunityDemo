class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit join update destroy]
  before_action :authenticate_user!

  # GET /groups or /groups.json
  def index
    @groups = Group.order(created_at: :desc)
  end

  # GET /groups/1 or /groups/1.json
  def show
    @post = @group.posts.new
    @posts = @group.posts.all.order(created_at: :desc)
    @members = @group.users.all
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit; end

  # POST /groups or /groups.json
  def create
    # @group = Group.new(group_params)
    @group = current_user.created_groups.create(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to group_url(@group), notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      unless current_user.id == @group.creator_id
        redirect_to group_url(@group), alert: 'You cannot edit this group as you are not the creator' and return
      end

      if @group.update(group_params)
        format.html { redirect_to group_url(@group), notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def created_by_me
    @groups = Group.where(creator_id: current_user.id).all
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:name)
  end
end
