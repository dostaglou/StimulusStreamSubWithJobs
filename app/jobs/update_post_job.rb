class UpdatePostJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find_by(id: post_id)
    return unless post.present?

    post.update_and_broadcast
  end
end
