class MessagesController < ActionController::Base
  def send_message
    email = params[:email] || 'shaoshijie830413@gmail.com'
    if user = User.find_by_email(email)
      # if user'access token has expired, then refresh that token
      user.refresh_token_if_expired

      begin
        @message = {
          client: params[:client] || '',
          type: params[:type] || '',
          invno: params[:invno] || '',
          cash: params[:cash] || '',
          duedate: params[:duedate] || '',
          img: params[:img] || ''
        }

        @message_timeline_object = Glass::Message.new(google_account_id: user.google_account.id)
        @message_timeline_object.serialize(template_variables: { client_name: @message[:client], 
                                                                 title: @message[:title],
                                                                 type: @message[:type],
                                                                 invoice_name: @message[:invno],
                                                                 cash: @message[:cash],
                                                                 duedate: @message[:duedate],
                                                                 image_url: @message[:img]
                                                                })

        @message_timeline_object.insert()

        render json: {result: "success"}
      rescue Exception => e
        render json: {result: "Token expired, please reauth"}
      end

    else
      render json: {result: "user doesn't exist"}
    end
  end
end
