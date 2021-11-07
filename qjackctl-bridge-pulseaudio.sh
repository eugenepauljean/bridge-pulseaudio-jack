#!/bin/bash
#BRIDGE JACK out <----> PULSEAUDIO in
#BRIDGE JACK in  <----> PULSEAUDIO out
#
# WHy ?  and why not?!!!  because Discord only support Pulseaudio
#                         because Firefox binary arch are not compiled with jack support
bridge1="Discord"
bridge2="Firefox"
bridge3="DIY"
# DISCORD  BRIDGE PULSEAUDIO - JACK
pacmd load-module module-jack-source client_name=$bridge1 channels=2
pacmd load-module module-jack-sink client_name=$bridge1 channels=2

# FIREFOX BRIDGE PULSEAUDIO - JACK
pacmd load-module module-jack-source client_name=$bridge2 channels=2
pacmd load-module module-jack-sink client_name=$bridge3 channels=2

# SDR BRIDGE PULSEAUDIO - JACK
pacmd load-module module-jack-source client_name=$bridge3 channels=2
pacmd load-module module-jack-sink client_name=$bridge3 channels=2
