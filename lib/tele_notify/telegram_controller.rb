module TeleNotify
  module Controller
    def webhook
      if params[:message]
        user = TelegramUser.create( { telegram_id: params[:message][:from][:id], first_name: params[:message][:from][:first_name], username: params[:message][:from][:username] } )
        if user
          user.send_message("Enhorabuena tus notificaciones estan activadas.")
        end
        render :nothing => true, :status => :ok
      end
    end
  end
end
