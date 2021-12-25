class ApplicationMailbox < ActionMailbox::Base
  # routing /something/i => :somewhere
  routing app: :posts
end
