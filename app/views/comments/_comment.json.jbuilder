json.extract! comment, :id, :content, :parent_id, :user_id, :post_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
