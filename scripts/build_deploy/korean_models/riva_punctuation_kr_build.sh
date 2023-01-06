#!/bin/bash

# https://docs.nvidia.com/deeplearning/riva/user-guide/docs/nlp/nlp-customizing.html

riva-build punctuation \
    /servicemaker-dev/outputs/woojin_punctuation_kr.rmir \
    /servicemaker-dev/models/korean/punctuationcapitalization_ko_kr_bert_base_vdeployable_v1.1/bert-base_ko-KR_Riva-PnC-SET-1.1.riva \
    --name=woojin-punctuation-KR \
 