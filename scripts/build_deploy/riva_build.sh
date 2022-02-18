#!/bin/bash

# riva-build speech_synthesis \
#        /servicemaker-dev/<rmir_filename>:<encryption_key> \
#        /servicemaker-dev/<FastPitch_riva>:<encryption_key> \
#        /servicemaker-dev/<HiFi-GAN_riva>:<encryption_key> \
#        --options 


riva-build speech_synthesis \
	/servicemaker-dev/outputs/FastPitch_HifiGan_Finetuned_FebMeetup.rmir \
	/servicemaker-dev/outputs/FastPitch_Finetuned_FebMeetup.riva \
	/servicemaker-dev/outputs/Hifigan_Finetuned_FebMeetup.riva \
	--voice_name=woojin


