puts "Running test for #{Rails.version}"
user = User.create!
post = Post.create!
user.posts << post
post.reload.users.include?(user) || (raise StandardError.new('User not loaded'))
user.reload.posts.include?(post) || (raise StandardError.new('Post not loaded'))
