module Validation
  class TypeValidator < Validator
    def validate_each(record, attr_name, value, expected_type)
      record.errors << "#{attr_name.capitalize} is not valid type" unless value.is_a?(expected_type)
    end
  end
end
