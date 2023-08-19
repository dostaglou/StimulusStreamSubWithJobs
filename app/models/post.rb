# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  content    :string
#  extra_data :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Post < ApplicationRecord
  # This is a callback that will be called when the post is created ( not updated or deleted)
  after_create_commit :set_extra_data

  # This is a wrapper to call a background job asynchronously
  # THe job will then internally call update_and_broadcast
  def set_extra_data
    UpdatePostJob.set(wait: 5.seconds).perform_later(self.id)
  end

  def update_and_broadcast
    if self.extra_data.nil?
      self.update(extra_data: "data after create")
    else
      self.update(extra_data: "This is extra data updated at #{Time.now.strftime("%Y-%m-%d %H:%M")}")
    end
    self.broadcast
  end

  def self.update_all_extra_data
    Post.all.each do |post|
      post.update(extra_data: "this is extra data updated at #{Time.now.strftime("%Y-%m-%d %H:%M")} using the update_posts rake task")
      post.broadcast
    end
  end

  #
  # This will use the websocket connection to broadcast to anyone listening to the  PostChannel with id of this post.
  # The content being broadcasted is an HTML string. This string is then consumed by the Stimulus controller in the receieved method
  # That method then processes and updates the view
  #
  def broadcast
    PostChannel.broadcast_to(self, ApplicationController.new.render_to_string(partial: "posts/post", locals: { post: self }))
  end
end
