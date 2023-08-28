class ApplicationController < ActionController::Base
	include JsonWebToken

	before_action :authenticate_request

  # ...................Authenticate User..................
  def authenticate_request
    begin
      header = request.headers['Authorization']
      header = header.split(" ").last if header
      decoded = jwt_decode(header)
      @current_user = User.find(decoded[:user_id])
    rescue JWT::DecodeError => e
      render json: { error: 'Invalid token' }, status: :unprocessable_entity
    rescue ActiveRecord::RecordNotFound
      render json: "No record found.."
    end
  end

  # ..............Check user.....................
	def current_user
		@current_user
	end

  def render_404
    render json: { error: "Invalid URL" }, status: :not_found
  end
end
