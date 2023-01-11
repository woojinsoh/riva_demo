#!/bin/bash

# https://docs.nvidia.com/deeplearning/riva/user-guide/docs/asr/asr-pipeline-configuration.html#

riva-build speech_recognition \
    /servicemaker-dev/outputs/woojin_conformer_kr_asr.rmir \
    /servicemaker-dev/models/korean/speechtotext_ko_kr_conformer_vdeployable_v1.0/Conformer-CTC-L-spe256-ko-KR-ASR-set-1.0.riva \
    --name=woojin-conformer-ko-KR-asr-streaming \
    --featurizer.use_utterance_norm_params=False \
    --featurizer.precalc_norm_time_steps=0 \
    --featurizer.precalc_norm_params=False \
    --ms_per_timestep=40 \
    --endpointing.start_history=200 \
    --nn.fp16_needs_obey_precision_pass \
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
    --flashlight_decoder.beam_size=32 \
    --language_code=ko-KR \