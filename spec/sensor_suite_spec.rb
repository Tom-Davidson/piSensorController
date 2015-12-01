require 'spec_helper'
require_relative '../lib/sensor_suite'

describe SensorSuite do
  let(:senses) { SensorSuite.new }
  it 'is an object of class SensorSuite' do
    expect(senses).to be_a SensorSuite
  end
  it '.to_hash starts as an empty hash' do
    expect(senses.to_hash).to eq({})
  end
  it '.<< adds to the collection' do
    double_one = double('Sensor')
    allow(double_one).to receive(:read).and_return(1)
    double_two = double('Sensor')
    allow(double_two).to receive(:read).and_return(2)
    senses << ['one', double_one]
    senses << ['two', double_two]
    expect(senses.to_hash).to include(
      one: respond_to(:read),
      two: respond_to(:read)
    )
  end
  it '.<< fails if not passed a sense' do
    expect { senses << ['one', 'no-read'] }.to raise_exception(ArgumentError)
  end
  it '.read produces a hash or senses and readings' do
    double_one = double('Sensor')
    allow(double_one).to receive(:read).and_return(1)
    double_two = double('Sensor')
    allow(double_two).to receive(:read).and_return(2)
    senses << ['one', double_one]
    senses << ['two', double_two]
    expect(senses.read).to eq(
      one: 1,
      two: 2
    )
  end
end
