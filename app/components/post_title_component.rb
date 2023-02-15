class PostTitleComponent < ViewComponent::Base
    def initialize(post:, group:, current_user:)
      @post = post
      @group = group
      @current_user = current_user
    end
end