# Preview all emails at http://localhost:3000/rails/mailers/letter_mailer
class LetterMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/letter_mailer/new_letter
  def new_letter
    LetterMailer.new_letter
  end

end
