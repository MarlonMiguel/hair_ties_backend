class AuthController < ApplicationController
    skip_before_action :authorize_request, only: [:login]

    def login
      user = User.find_by(email: params[:email])
      if user&.authenticate(params[:password])
        payload = { user_id: user.id, role: user.role, exp: 2.hours.from_now.to_i }
        token = JWT.encode(payload, Rails.application.secret_key_base)
        render json: { token: token }, status: :ok
      else
        render json: { error: "Acesso não autorizado" }, status: :unauthorized
      end
    end
end
