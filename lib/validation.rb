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

  module Rules
    def validates_presence_of(field, message='')
      callback = lambda do |data|
        if data.has_key? field
          true
        else
          false
        end
      end
      @rules << {:callback => callback, :message => Error.new(field, message)}
    end

    def validates_confirmation_of(field, message='')
      callback = lambda do |data|
        field_confirmation = data.fetch("#{field}_confirmation", nil)
        if field_confirmation == data[field]
          true
        else
          false
        end
      end
      @rules << {:callback => callback, :message => Error.new(field, message)}
    end
  end

  class Validator
    include Rules

    attr_reader :errors

    def initialize
      @rules = []
      @errors = {}
    end

    def validates(field, callback, message)
      @rules << {:callback => callback, :message => Error.new(field, message)}
    end

    def validate data
      @errors = {}
      @rules.each do |rule|
        @errors[rule[:message].field] = rule[:message] unless rule[:callback].call(data)
      end
      valid?
    end

    def valid?
      @errors.empty?
    end
  end

end
