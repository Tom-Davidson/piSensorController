require 'spec_helper'
require_relative '../../lib/sensors/ds18b20.rb'

describe DS18B20 do
  let(:sensor) { DS18B20.new }
  it 'is an object of class DS18B20' do
    expect(sensor).to be_an_instance_of DS18B20
  end
  # For me its handle is 28-0414514b4eff
  it '.handles' do
    allow(Dir).to receive(:entries).and_return(
      ['.', '..', '28-XXXX', 'w1_bus_master1']
    )
    allow(File).to receive(:directory?).and_return(true)
    expect(sensor.handles).to eq(['28-XXXX'])
  end
  it '.resource' do
    allow(sensor).to receive(:handles).and_return(['28-YYYY'])
    expect(sensor.resource).to eq('/sys/bus/w1/devices/28-YYYY/w1_slave')
  end
end
