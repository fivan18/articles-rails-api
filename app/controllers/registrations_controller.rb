class RegistrationsController < ApplicationController
  skip_before_action :authorize!, only: :create

  def create
    user = User.new(registration_params.merge(provider: 'standard'))
    user.save!
    render json: user_serializer.new(user), status: :created
  rescue ActiveRecord::RecordInvalid
    render json: { errors: user.errors }, status: :unprocessable_entity
  end

  def user_serializer
    UserSerializer
  end

  private

  def registration_params
    params.require(:data).require(:attributes)
      .permit(:login, :password) ||
      ActionController::Parameters.new
  end
end
