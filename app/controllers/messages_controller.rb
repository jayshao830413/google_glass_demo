class MessagesController < ActionController::Base
  def send_message
    email = params[:email] || 'shaoshijie830413@gmail.com'
    title = params[:title] || ''
    content = params[:content] || ''

    if user = User.find_by_email(email)
      @message = {
        title: title,
        content: content
      }

      @message_timeline_object = Glass::Message.new(google_account_id: user.google_account.id)
      @message_timeline_object.serialize(template_variables: {content: @message[:content], title: @message[:title]})
      @message_timeline_object.insert()
    else

    end
  end
end
