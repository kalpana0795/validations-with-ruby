module Validation
  class PresenceValidator < Validator
    def validate_each(record, attr_name, value, _expected_value)
      record.errors << "#{attr_name.capitalize} can't be blank" if value.nil? || value.to_s.empty?
    end
  end
end
