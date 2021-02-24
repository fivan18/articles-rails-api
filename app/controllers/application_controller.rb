class ApplicationController < ActionController::API
  include JsonapiErrorsHandler

  ErrorMapper.map_errors!(
    'ActiveRecord::RecordNotFound' =>
      'JsonapiErrorsHandler::Errors::NotFound'
  )
  rescue_from ::StandardError, with: ->(error) { handle_error(error) }
end
