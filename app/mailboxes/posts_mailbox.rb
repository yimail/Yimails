class PostsMailbox < ApplicationMailbox
  before_processing :users
  def process
    return if users.nil?

    users.each do |user|
      user.letters.create(
        subject: mail.subject,
        recipient: recipient,
        recipient_name: mail[:from].display_names.first,
        sender: mail.from.to_s[2..-3],
        body: body,
        attachments: attachments.map{ |a| a[:blob] },
        status: 0
      )
    end
  end

  def attachments
    @_attachments = mail.attachments.map do |attachment|
      blob = ActiveStorage::Blob.create_after_upload!(
        io: StringIO.new(attachment.body.to_s),
        filename: attachment.filename,
        content_type: attachment.content_type,
      )
      { original: attachment, blob: blob }
    end
  end

  def body
    if mail.multipart? && mail.html_part
      document = Nokogiri::HTML(mail.html_part.body.decoded)

      attachments.map do |attachment_hash|
        byebug  
        attachment = attachment_hash[:original]
        blob = attachment_hash[:blob]

        if attachment.content_id.present?
          child_div = Nokogiri::XML::Node.new('div', document)

          child_div.content = "<action-text-attachment sgid=\"#{blob.attachable_sgid}\" content-type=\"#{attachment.content_type}\" filename=\"#{attachment.filename}\"></action-text-attachment>"
        end
      end

      document.at_css("body").inner_html.encode('utf-8')
    elsif mail.multipart? && mail.text_part
      mail.text_part.body.decoded
    else
      mail.decoded
    end
  end

  def recipient
    if mail.to.length > 1
      mail.to.to_s.gsub(/[","]/,"")[1..-2]
    else
      mail.to.to_s[2..-3]
    end
  end

  private
  def users
    users = mail.to.map {|r| User.find_by(email: r)}
  end
end