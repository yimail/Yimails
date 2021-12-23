class LetterMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.letter_mailer.new_letter.subject
  #
  def new_letter(letter)
    @letter = letter
    mail to: [@letter.recipient], cc: [@letter.carbon_copy], bcc: [@letter.blind_carbon_copy], subject: @letter.subject
  end
end
