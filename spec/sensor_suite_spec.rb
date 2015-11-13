require 'spec_helper'
require_relative '../lib/sensor_suite'

describe SensorSuite do
  let(:senses) { SensorSuite.new }
  it 'is an object of class SensorSuite' do
    expect(senses).to be_an_instance_of SensorSuite
  end
  it '.to_a starts as an empty array' do
    expect(senses.to_a).to match_array([])
  end
  it '.<< adds to the collection' do
    senses << 9
    senses << 8
    senses << 7
    expect(senses.to_a).to match_array([9, 8, 7])
  end
  it '.each' do
    allow(senses).to receive(:to_a).and_return([1, 2, 3])
    total = 0
    senses.each do |value|
      total += value
    end
    expect(total).to eq(6)
  end
  it '.read' do
    sense_a = double
    allow(sense_a).to receive(:name).and_return('Sense A')
    allow(sense_a).to receive(:read).and_return(1)
    senses << sense_a
    sense_b = double
    allow(sense_b).to receive(:name).and_return('Sense B')
    allow(sense_b).to receive(:read).and_return(2)
    senses << sense_b
    expect(senses.read).to include(
      'Sense A' => 1,
      'Sense B' => 2
    )
  end
end
