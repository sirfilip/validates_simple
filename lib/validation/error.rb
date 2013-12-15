module Validation
  class Error 
    attr_reader :field

    def initialize(field, message)
      @field = field
      @message = message
    end

    def message
      @message.gsub(':field', @field)
    end
  end 
end
