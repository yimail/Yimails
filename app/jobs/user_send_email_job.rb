class UserSendEmailJob < ApplicationJob
  queue_as :default

  def perform(letter)
    LetterMailer.new_letter(letter).deliver_now
  end
end
