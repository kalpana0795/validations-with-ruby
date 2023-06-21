require './validation/validator'
require './validation/presence_validator'
require './validation/format_validator'
require './validation/type_validator'
require './validation/error'

module Validation
  def self.included(base)
    base.extend(ClassMethods)
  end

  attr_accessor :errors

  def initialize
    @errors = []
  end

  module ClassMethods
    # { class_name: { validation_type: [rules] } }
    @@_validators = Hash.new { |h, k| h[k] = Hash.new { |h, k| h[k] = [] } }

    VALIDATION_TYPES = %i(presence format type).freeze

    def validate(attribute, options)
      validation_types = VALIDATION_TYPES & options.keys
      validation_hash = @@_validators[class_name_key]

      validation_types.each do |validation_type|
        rules = {
          attribute: attribute,
          value: options[validation_type],
        }
        validation_hash[validation_type] << rules
      end

      @@_validators[class_name_key].merge! validation_hash
    end

    def validators
      @@_validators[class_name_key]
    end

    private

    def class_name_key
      self.to_s.downcase.to_sym
    end
  end

  def validate!
    self.class.validators.each_pair do |validation_type, options|
      run_validator(validation_type, options)

      raise Error.new(errors.join(', ')) if errors.any?
    end
  end

  def valid?
    self.class.validators.each_pair do |validation_type, options|
      run_validator(validation_type, options)
    end

    errors.empty?
  end
  
  private

  def run_validator(validation_type, options)
    validator = Validation.const_get "#{validation_type.to_s.capitalize}Validator"
    validator.new(options).validate(self)
  end
end
