class Vehicle < Base
  attr_accessor :owner, :vin

  def initialize(owner = nil, vin = nil)
    @owner = owner
    @vin = vin
    super
  end

  validate :vin, presence: true, format: /\d{5}/
  validate :owner, type: Person
end
