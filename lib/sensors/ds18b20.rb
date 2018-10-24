# The DS18B20 temperature sensor
class DS18B20
  DEVICES_LOCATION = '/sys/bus/w1/devices'
  def handles
    unless @handles
      @handles = Dir.entries(DEVICES_LOCATION).select do |entry|
        File.directory?(File.join(DEVICES_LOCATION, entry)) && !(
          entry == '.' || entry == '..' || entry == 'w1_bus_master1'
        )
      end
    end
    @handles
  end

  def resource
    unless @resource
      @resource = File.join(DEVICES_LOCATION, handles.shift, 'w1_slave')
    end
    @resource
  end

  def read
    data = parse(raw_poll)
    raise IOError, 'Cannot read from device' unless data[:status]

    data[:value]
  end

  private

  def raw_poll
    File.read(resource)
  end

  def parse(data)
    line1, line2 = data.split(/\n/)
    data1 = line1.split(/ /)
    data2 = line2.split(/ /)
    raise IOError, 'Cannot read from device' unless data1[11] && data2[9]

    _, temperature = data2[9].split(/=/)
    {
      status: data1[11],
      value: temperature.to_f / 1000.0,
      data: data
    }
  end
end
