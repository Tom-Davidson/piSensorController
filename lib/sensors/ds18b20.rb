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
    data = File.read(resource)
    line1, line2 = data.split(/\n/)
    data1 = line1.split(/ /)
    status = data1[11]
    if status == 'YES'
      data2 = line2.split(/ /)
      _, temperature = data2[9].split(/=/)
      temperature.to_f / 1000.0
    else
      fail IOError, 'Cannot read from device'
    end
  end
end
