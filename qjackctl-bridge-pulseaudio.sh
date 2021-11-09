#!/bin/bash
#BRIDGE JACK out <----> PULSEAUDIO in
#BRIDGE JACK in  <----> PULSEAUDIO out
#
# WHy ?  and why not?!!!  because Discord only support Pulseaudio
#                         because Firefox binary arch are not compiled with jack support
#                         because I need to use JACK for audio pro and having fun with my friend the same time on the same computer
bridge1="Discord"
bridge2="Firefox"
bridge3="DIY"
bridge4="VLC"
# DISCORD  BRIDGE PULSEAUDIO - JACK
pacmd load-module module-jack-source client_name=$bridge1 channels=2
pacmd load-module module-jack-sink client_name=$bridge1 channels=2
#
# FIREFOX BRIDGE PULSEAUDIO - JACK
pacmd load-module module-jack-source client_name=$bridge2 channels=2
pacmd load-module module-jack-sink client_name=$bridge2 channels=2
#
# DIY BRIDGE PULSEAUDIO - JACK
pacmd load-module module-jack-source client_name=$bridge3 channels=2
pacmd load-module module-jack-sink client_name=$bridge3 channels=2
#
# VLC BRIDGE PULSEAUDIO - JACK   or  using Jack support in VLC
#pacmd load-module module-jack-source client_name=$bridge4 channels=2
#pacmd load-module module-jack-sink client_name=$bridge4 channels=2
#
#############################################################
############## HOW TO USE - README - HOWTO ##################
#############################################################
#
# OPEN QJACKCTL SETUP
#        |
#        |---> Driver : ALSA
#        |---> Realtime (checked)
#        |---> Support Midi : SEQ
#        |
#        |     ----------------------------------------------
#        |---> Choose INTERFACE      (audio card, headset...)
#        |---> Choose SAMPLERATE     (44100, 48000, 96000...)
#        |---> Choose FRAMES/PERIOD  ( 1024, 512, 256, 128..)
#        |---> Choose PERIOD/BUFFER  (       1  or  2       )
#        |        ---(depends hardware specification)---
#        |
#        |---> OPTIONS --->  Execute Script After Startup   (Checked)
#        |                    (put Bridge script )
#        |
#        |---> MISC ------>  Activate D-Bus                 (Checked)
#                            Activate JACK-D-Bus            (Checked)
#
#############################################################
############## OPTIONAL  TIPS  AND  TRICKS ##################
#############################################################
#
# How to list audio cards ?
#   --->  cat /proc/asound/cards
# 
# How to get the hardware audio specification
#   --->  cat /proc/asound/cardXXXXXX/pcm0c/sub0/hw_params  (for capture)
#   --->  cat /proc/asound/cardXXXXXX/pcm0p/sub0/hw_params  (for playing)
#
# If like me, you don't want to waste resources doing downsampling
# you can edit manually pulseaudio and alsa for handling the right samplerate
# 
# Example for my headset at 44100 KHz
#
# in file  /etc/pulse/daemon.conf
#          Uncomment and change :
#                  default-sample-format = s16le
#                  default-sample-rate = 44100
#
# in file  ~/.asoundrc
#          pcm.device{
#                  format S16_LE
#                  rate 44100
#                  type hw
#                  card 2
#                  device 0
#          }
#
# How to edit CARD NAME in Pulseaudio Mixer ?
#
# in file   ~/.config/pulse/default.pa
#       .include /etc/pulse/default.pa
#       # External Headset USB
#       update-sink-proplist alsa_output.usb-Logitech_Logitech_G35_Headset-00.analog-stereo device.description="CASQUE"
#       update-source-proplist alsa_input.usb-Logitech_Logitech_G35_Headset-00.mono device.description="MIC G35"
#       # Internal Audio Laptop
#       update-sink-proplist alsa_output.pci-0000_00_1f.3.analog-stereo device.description="Laptop HP"
#       update-source-proplist alsa_input.pci-0000_00_1f.3.analog-stereo device.description="Laptop IN"
#
# LINUX AUDIO STACK
#   before
#    (AUDIO CARD)  <--44100-->  [[ HARDWARE INTERFACE  <kernel> DEVICE CONTROLL ]]  <--48000-->  ALSA <--> PULSEAUDIO
#   after
#    (AUDIO CARD)  <--44100-->  [[ HARDWARE INTERFACE  <kernel> DEVICE CONTROLL ]]  <--44100-->  ALSA <--> JACK <--> PULSEAUDIO
#
