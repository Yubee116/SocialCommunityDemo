class MembershipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @memberships = current_user.groups.all.order(created_at: :desc)
  end

  # POST /memberships or /membership.json
  def create
    @membership = Membership.new(membership_params.except(:post_id).merge(user_id: current_user.id))

    respond_to do |format|
    if @membership.save
        if membership_params[:post_id]
            format.html { redirect_to post_url(membership_params[:post_id]), notice: 'You have joined the group.' }
            format.json { render :show, status: :created, location: @membership }
        else
            format.html { redirect_to group_url(@membership.group), notice: 'You have joined the group.' }
            format.json { render :show, status: :created, location: @membership }
        end
      else
        format.html do
          redirect_to groups_url, alert: 'Unable to join. You are probably already a member of this group'
        end
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if params[:user_id]
      @membership = Membership.where(group_id: params[:group_id], user_id: params[:user_id]).first
      @membership.destroy
      respond_to do |format|
        format.html { redirect_to group_url(params[:group_id]), notice: 'User removed from the group.' }
        format.json { head :no_content }
      end
    else
      @membership = Membership.where(group_id: params[:id], user_id: current_user.id).first
      @membership.destroy
      respond_to do |format|
        format.html { redirect_to groups_url, notice: 'You have left the group.' }
        format.json { head :no_content }
      end

    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_membership
    @membership = Membership.find(membership_params[:group_id])
  end

  def membership_params
    params.fetch(:memberships, {}).permit(:group_id, :post_id)
  end
end
