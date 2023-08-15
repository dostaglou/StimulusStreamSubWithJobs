namespace :posts do
  desc 'Update all posts with new extra data'
  task update_posts: :environment do
    Post.update_all_extra_data
  end
end
