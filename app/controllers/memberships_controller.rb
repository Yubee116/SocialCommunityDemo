class MembershipsController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @memberships = current_user.groups.all
    end

    # POST /memberships or /membership.json
    def create
        @membership = Membership.new(membership_params.merge(user_id: current_user.id))

        respond_to do |format|
            if @membership.save
                format.html { redirect_to group_url(@membership.group), notice: "You have joined the group." }
                format.json { render :show, status: :created, location: @membership }
            else
                format.html { redirect_to groups_url, alert: "Unable to join. You are probably already a member of this group" }
                format.json { render json: @membership.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @membership = Membership.where(group_id: params[:id], user_id: current_user.id).first

        @membership.destroy

        respond_to do |format|
        format.html { redirect_to groups_url, notice: "You have left the group." }
        format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
        @membership = Membership.find(membership_params[:group_id])
    end

    def membership_params
      params.fetch(:memberships, {}).permit(:group_id)
    end
end