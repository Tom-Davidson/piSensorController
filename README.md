[![Stories in Ready](https://badge.waffle.io/Tom-Davidson/piSensorController.png?label=ready&title=Ready)](https://waffle.io/Tom-Davidson/piSensorController) [![Circle CI](https://circleci.com/gh/Tom-Davidson/piSensorController.svg?style=svg)](https://circleci.com/gh/Tom-Davidson/piSensorController)
# piSensorController
Simple home automation project for my daughter's room.

## Preparing the pi
 - I used a fresh install of [Raspbian (Jessie)](https://www.raspberrypi.org/downloads/raspbian/)
 - `sudo raspi-config` to Expand the filesystem and enable SSH
 - if using wireless
   - `sudo nano /etc/wpa_supplicant/wpa_supplicant.conf` to add `network={ ssid="Your_Wifi_Name" psk="Your_Wifi_password" }`
   - `sudo nano /etc/network/interfaces` to modify `iface wlan0 inet manual` to `iface wlan0 inet dhcp`
   - `sudo reboot`
 - Set up your ssh keys

## Getting Started:
 - Checkout the code: `git clone git@github.com:Tom-Davidson/piSensorController.git ~/Documents/piSensorController`
 - `sudo apt-get install ansible`
 - `clear && ansible-playbook -i "localhost," -c local systemDependancies.yml`
 - `bundle install`
 - Modify `config.yml` to set the host, username and password for your InfluxDB server
 - `bundle exec bin/monitor_cpu &` to test the link to InfluxDB
 - `sudo reboot` (if you want OneWire support immediately)

## Raspberry Pi Wiring
 - [Temperature sensor](https://learn.adafruit.com/adafruits-raspberry-pi-lesson-11-ds18b20-temperature-sensing?view=all#hardware)

## Applications
 - `bin/gpio_test` turns pin 17 on, off then watches pin 23 sending output to the command line, this is for test/validation purposes only
 - `bin/monitor_cpu` polls the cpu load (1 minute average) every minute and sends the data to InfluxDB
 - `bin/temperature` polls the DS18B20 every 'poll_frequency' and sends the data to InfluxDB

## Notes:
Useful links
 - [InfluxDB Admin Interface](http://influxdb-server:8083/)
 - [Grafana](http://grafana-server:3000/)
