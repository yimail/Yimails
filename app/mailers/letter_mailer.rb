class LetterMailer < ApplicationMailer
  def new_letter(letter)
    @letter = letter
    byebug
    mail(
      from: @letter.sender,
      to: [@letter.recipient],
      cc: [@letter.carbon_copy],
      bcc: [@letter.blind_carbon_copy],
      subject: @letter.subject,
      status: @letter.sent!
    )
  end
end
