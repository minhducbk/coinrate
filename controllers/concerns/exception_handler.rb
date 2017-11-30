require 'active_support/all'

module ExceptionHandler
  # provides the more graceful `included` method
  # extend ActiveSupport::Rescuable
  extend ActiveSupport::Concern

  included do
    begin
    rescue ActiveRecord::RecordNotFound 
      json_response({ message: "RecordNotFound" }, :not_found)
    rescue ActiveRecord::RecordInvalid 
      json_response({ message: "RecordInvalid"}, :unprocessable_entity)
    end
  end
end