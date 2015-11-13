# A collection of senses
class SensorSuite
  def initialize
    @senses = []
  end

  def <<(sense)
    @senses << sense
  end

  def to_a
    @senses
  end

  def each(&block)
    to_a.each { |sense| block.call(sense) }
  end

  def read
    environment = {}
    each do |sense|
      environment[sense.name] = sense.read
    end
    environment
  end
end
