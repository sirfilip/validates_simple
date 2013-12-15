module Validation
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
end
