# Command LED IoT Project
This project demonstrates a simple way to control the luminosity of an LED.

# Technologies Used
- [InfluxDB](https://www.influxdata.com/): A time-series database which will store the luminosity of the LED.
- [Grafana](https://grafana.com/): A visualization tool used to turn data into graphs. We will use the data stored in InfluxDB.
- [Mosquitto](https://mosquitto.org/): A M-to-M message broker. We will use this push data from the Ardunio device as well as recieve instructions.

# The Project
- [Command Bridge](https://github.com/APiercey/command-led-iot/tree/master/command-bridge): The custom Elixir application will push data into InfluxDB and issue commands to the device.
- [Arduino Project](https://github.com/APiercey/command-led-iot/tree/master/arduino-project): The Arduino build. This includes ZIPed libraries needed for it to work.

# The Build
The arduino will `analogWrite` to pin 9. Anode (long end) is hooked up to the pin. For the cathode, I used a 220 ohm resistor.

For this project, I used an (deprecated) Ardunio Ethernet shield because that was all I had! I'm 100% positive this can be done with any sort of shield used to connect the ardunio to the internet - you will just need a different library other than the Ethernet one.

Here is a picture, quite simple:
![arduino_led.jpg](arduino_led.jpg)

# Graphing the Data
The project only records luminosity. The data will be stored into a InfluxDB named `devices` under the measurment `led`.

Using the query:
```
SELECT last(luminosity) FROM led
```

I produced this graph:
