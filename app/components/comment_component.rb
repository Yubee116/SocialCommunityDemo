class CommentComponent < ViewComponent::Base
    def initialize(comment:, group:, current_user:)
      @comment = comment
      @current_user = current_user
      @group = group
    end
end