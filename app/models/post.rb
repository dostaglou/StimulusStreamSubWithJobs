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
  after_create_commit :set_extra_data

  def set_extra_data
    UpdatePostJob.perform_later(self.id)
  end

  def update_and_broadcast
    if self.extra_data.nil?
      self.update(extra_data: "data after create")
    else
      self.update(extra_data: "This is extra data updated at #{Time.now.strftime("%Y-%m-%d %H:%M")}")
    end
    PostChannel.broadcast_to(self, ApplicationController.new.render_to_string(partial: "posts/post", locals: { post: self }))
  end
end
