# piSensorController
Simple home automation project for my daughter's room.

## Getting Started:
 - `sudo apt-get install ansible`
 - `clear && ansible-playbook -i "localhost," -c local systemDependancies.yml`
 - `sudo reboot` (if you want OneWire support immediately)
 - `bundle install`
 - Modify `config.yml` to set the host, username and password for your InfluxDB server
 - `bundle exec bin/monitor_cpu &` to test the link to InfluxDB

## Raspberry Pi Wiring
 - [Temperature sensor](https://learn.adafruit.com/adafruits-raspberry-pi-lesson-11-ds18b20-temperature-sensing?view=all#hardware)

## Applications
 - `bin/gpio_test` turns pin 17 on, off then watches pin 23 sending output to the command line, this is for test/validation purposes only
 - `bin/monitor_cpu` polls the cpu load (1 minute average) every minute and sends the data to InfluxDB

## Notes:
Useful links
 - [InfluxDB Admin Interface](http://influxdb-server:8083/)
 - [Grafana](http://grafana-server:3000/)
