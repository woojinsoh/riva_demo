#!/bin/bash

# https://docs.nvidia.com/deeplearning/riva/user-guide/docs/asr/asr-pipeline-configuration.html#

riva-build speech_recognition \
    /servicemaker-dev/outputs/woojin_citrinet_kr_asr.rmir \
    /servicemaker-dev/models/korean/speechtotext_ko_kr_citrinet_vdeployable_v1.0/ko_kr_citrinet_1024_spe2048_gamma_0_25_asrset_1_0.riva \
    --name=woojin-citrinet-1024-ko-KR-asr-streaming \
    --featurizer.use_utterance_norm_params=False \
    --featurizer.precalc_norm_time_steps=0 \
    --featurizer.precalc_norm_params=False \
    --ms_per_timestep=80 \
    --endpointing.residue_blanks_at_start=-2 \
    --chunk_size=0.16 \
    --left_padding_size=1.92 \
    --right_padding_size=1.92 \
    --decoder_type=flashlight \
    --decoding_language_model_binary=/servicemaker-dev/models/korean/speechtotext_ko_kr_lm_vdeployable_v1.0/language_model_1p0.bin \
    --decoding_vocab=/servicemaker-dev/models/korean/speechtotext_ko_kr_lm_vdeployable_v1.0/dict_vocab_1p0.txt \
    --flashlight_decoder.lm_weight=0.2 \
    --flashlight_decoder.word_insertion_score=0.2 \
    --flashlight_decoder.beam_threshold=20. \
    --language_code=ko-KR \