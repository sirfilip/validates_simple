module Validation
  module Rules

    def validates(field, callback, message)
      @rules << {:callback => callback, :message => Error.new(field, message)}
    end

    def validates_presence_of(field, message='')
      callback = lambda do |data|
        if data.has_key?(field) && data[field].to_s !~ /^\s*$/
          true
        else
          false
        end
      end
      validates(field, callback, message)
    end

    def validates_confirmation_of(field, message='')
      validates_presence_of(field, message)

      callback = lambda do |data|
        field_confirmation = data.fetch("#{field}_confirmation", nil)
        if field_confirmation == data[field]
          true
        else
          false
        end
      end
      validates(field, callback, message)
    end

    def validates_format_of(field, regex, message='')
      validates_presence_of(field, message)

      callback = lambda do |data| 
        if data[field].to_s =~ regex
          true
        else
          false
        end
      end
      validates(field, callback, message)
    end

    def validates_numericality_of(field, message='')
      validates_presence_of(field, message)
      validates_format_of(field, /^\d+(\.\d+)?$/, message)
    end

    def validates_greather_then(field, number, message='')
      validates_numericality_of(field, message)
      callback = lambda do |data|
        if data[field] > number
          true
        else
          false
        end
      end
      validates(field, callback, message)
    end

    def validates_greather_or_equal_then(field, number, message='')
      validates_numericality_of(field, message)
      callback = lambda do |data|
        if data[field] >= number
          true
        else
          false
        end
      end
      validates(field, callback, message)
    end

    def validates_less_then(field, number, message='')
      validates_numericality_of(field, message)
      callback = lambda do |data|
        if data[field] < number
          true
        else
          false
        end
      end
      validates(field, callback, message)
    end

    def validates_less_or_equal_then(field, number, message='')
      validates_numericality_of(field, message)
      callback = lambda do |data|
        if data[field] <= number
          true
        else
          false
        end
      end
      validates(field, callback, message)
    end

    def validates_length_of_within(field, min, max, message='')
      validates_presence_of(field, message)
      callback = lambda do |data|
        length = data[field].length
        if length >= min && length <= max
          true
        else
          false
        end
      end
      validates(field, callback, message)
    end

    def validates_option_in(field, options, message='')
      validates_presence_of(field, message)
      callback = lambda do |data|
        if options.include? data[field]
          true
        else
          false
        end
      end
      validates(field, callback, message)
    end

  end 
end
