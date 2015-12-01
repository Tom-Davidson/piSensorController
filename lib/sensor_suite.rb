# A collection of senses
class SensorSuite
  def initialize
    @senses = {}
  end

  def to_hash
    @senses
  end

  def <<(args)
    name = args[0]
    sense = args[1]
    fail ArgumentError, 'sense is not a Sense' unless sense.respond_to?(:read)
    @senses[name.to_sym] = sense
    true
  end

  def read
    readings = {}
    @senses.each do |name, sense|
      readings[name] = sense.read
    end
    readings
  end
end
