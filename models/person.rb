class Person < Base
  EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.freeze
 
  attr_accessor :name, :email, :owner

  def initialize(name = nil, email = nil)
    @name = name
    @email = email
    super
  end

  validate :name, presence: true
  validate :email, presence: true, format: EMAIL_REGEXP
end
