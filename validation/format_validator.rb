module Validation
  class FormatValidator < Validator
    def validate_each(record, attr_name, value, regexp)
      record.errors << "#{attr_name.capitalize} is invalid" unless regexp.match?(value.to_s)
    end
  end
end
