require 'sendgrid-ruby'

class SendgridApiDelivery
  def initialize(values = {})
    @values = values
  end

  def deliver!(mail)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

    from_email = mail.from&.first || 'noreply@toy-app-4-yajg.onrender.com'
    to_email   = mail.to&.first
    subject    = mail.subject
    content    = mail.body.raw_source

    message = SendGrid::Mail.new(
      from_email: SendGrid::Email.new(email: from_email),
      subject: subject,
      to_emails: SendGrid::Email.new(email: to_email),
      plain_text_content: content
    )

    sg.client.mail._('send').post(request_body: message.to_json)
  end
end
