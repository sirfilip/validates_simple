module Validation
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
        next if @errors[rule[:message].field]
        @errors[rule[:message].field] = rule[:message] unless rule[:callback].call(data)
      end
      valid?
    end

    def valid?
      @errors.empty?
    end
  end
end
