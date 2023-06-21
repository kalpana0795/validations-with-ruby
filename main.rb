Dir["./models/*.rb"].each {|file| require file }

# Sample Tests
# -------------------
puts Person.new().valid? # false

Person.new("Ritesh").validate! # raises: Email can't be blank (Validation::Error)

Person.new("Ritesh", "ritesh.com").validate! # raises: Email is invalid (Validation::Error)

Person.new("Ritesh", "ritesh@example.com").validate! # No exception
puts Person.new("Ritesh", "ritesh@example.com").valid? # true

owner = Person.new
Vehicle.new(owner, ).validate! # raises: Vin can't be blank (Validation::Error)

Vehicle.new("Ritesh", 12345).validate! # raises: Owner is not valid type (Validation::Error)

Vehicle.new(owner, 12345).validate! # No exception
puts Vehicle.new(owner, 12345).valid? # true
