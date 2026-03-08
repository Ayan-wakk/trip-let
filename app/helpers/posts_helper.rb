module PostsHelper
  def post_og_image(post)
    return unless post.images.attached?

    rails_blob_url(post.images.first)
  end
end
