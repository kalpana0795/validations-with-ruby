module Validation  
  class Validator
    attr_reader :options
    private :options

    def initialize(options)
      @options = options
      attributes = options.map { |option| option[:attribute] }
      raise ArgumentError, ":attributes cannot be blank" if attributes.empty?
    end

    def validate(record)
      options.each do |rule|
        attribute = rule[:attribute]
        expected_value = rule[:value]
        actual_value = record.public_send(attribute)
        validate_each(record, attribute, actual_value, expected_value)
      end
    end
  end
end
