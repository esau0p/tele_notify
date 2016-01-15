module TeleNotify
  module Controller
    def webhook
      if params[:message]
        user = TelegramUser.find_by(telegram_id: params[:message][:from][:id])

        if user.blank?
          user = TelegramUser.create( { telegram_id: params[:message][:from][:id], first_name: params[:message][:from][:first_name], username: params[:message][:from][:username] } )

          if user
            if (params[:message][:from][:username]).length > 0
              user.send_message("Enhorabuena tus notificaciones estan activadas.")
            else
              user.send_message("Es necesario un @Username (Alias) para interactuar con tu cuenta, ajustalo y enviame nuevamente el mensaje /start.")
              user.destroy
            end
          end
        end
        
        render :nothing => true, :status => :ok
      end
    end
  end
end
