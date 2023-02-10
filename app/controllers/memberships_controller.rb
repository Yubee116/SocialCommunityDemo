class MembershipsController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @memberships = current_user.groups.all
    end

end