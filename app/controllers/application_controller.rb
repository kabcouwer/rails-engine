class ApplicationController < ActionController::API
  def not_found
    render json: { error: 'Not found' }, status: :not_found
  end

  def bad_request(errors)
    render json: { errors: errors }, status: :bad_request
  end
end
