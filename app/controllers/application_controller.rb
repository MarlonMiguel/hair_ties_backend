class ApplicationController < ActionController::API
    before_action :authorize_request
  
    attr_reader :current_user
  
    def authorize_request
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        decoded = JWT.decode(header, Rails.application.secret_key_base)[0]
        @current_user = User.find(decoded['user_id'])
      rescue
        render json: { error: "Acesso não autorizado" }, status: :unauthorized
      end
    end
end
