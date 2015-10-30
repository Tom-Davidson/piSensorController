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
end
