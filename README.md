# Simple validator that validates hashes

I needed a simple validation utility that i can use to validate params,
json etc. So i am creating one.

1. It should provide an easy way to add additional validations

        module Validation
          module Rules
            def my_custom_validation(field, message='')
              callback = lambda do | data |
                if data[field] == something_special
                  true
                else
                  false
                end
              validates(field, callback, message)
            end
          end
        end

2. It can reuse defined validations when defining one

        module Validation
          module Rules
            def validates_numericality_of(field, message='')
              validates_presence_of(field)
              validates_format_of(field, /^\d+(\.\d+)?$/
            end
          end
        end

3. It should provide some predefined validations
  * validates_presence_of - checks if the field is present and it is not nil or empty string
  * validates_confirmation_of - checks if a field is confirmed by checking filed\_confirmation value
  * validates_format_of - checks if a field is in a given format
  * validates_numericality_of - checks if a field is a correct number format
  * validates_greather_then - checks if a field is greather then some value
  * validates_less_then - checks if a field is less then some value
  * etc

For additional info check the specs for usage [validates simple specs](https://github.com/sirfilip/validates_simple/blob/master/spec/validation_spec.rb)


License: MIT

[![Gem Version](https://badge.fury.io/rb/validates_simple.png)](http://badge.fury.io/rb/validates_simple)
