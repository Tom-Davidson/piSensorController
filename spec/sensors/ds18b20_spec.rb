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
  context 'device reads ok' do
    it '.read' do
      allow(sensor).to receive(:resource).and_return('/tmp/resource')
      allow(File).to receive(:read).with('/tmp/resource').and_return(
        "75 01 55 00 7f ff 0c 10 2b : crc=2b YES\n75 01 55 00 7f ff 0c 10 2b t=23312"
      )
      expect(sensor.read).to eq(23_312.0 / 1000.0)
    end
  end
  context 'device read fails' do
    it '.read' do
      allow(sensor).to receive(:resource).and_return('/tmp/resource')
      allow(File).to receive(:read).with('/tmp/resource').and_return(
        "75 01 55 00 7f ff 0c 10 2b : crc=2b NO\n75 01 55 00 7f ff 0c 10 2b"
      )
      expect { sensor.read }.to raise_error(IOError, 'Cannot read from device')
    end
  end
end
