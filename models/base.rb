require './validation'

class Base
  include Validation

  def initialize(*args)
    super()
  end
end
