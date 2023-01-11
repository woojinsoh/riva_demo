# Simple Korean Riva ASR sample

## Pre-requisites
1. You should have **riva-server** launched in advance.

2. Adjust the **riva-server** uri of `auth` parameter into yours in `app.py`.

3. Modify the value of *select* tag in `index.html` located in `templates` directory. Deployed ASR model names may be different from what your **riva-server** have.

4. Install Flask and some dependencies.
```
!apt-get update
!apt-get install -y libsndfile1-dev
!pip install nvidia-pyindex nvidia-riva-client librosa flask
```

## Quick start
At your workspace home directory, Execute:

`python3 ./samples/simple_kr_asr/app.py`

Just so you know, the microphone couldn't be activated with the **Chrome browser** without SSL(i.e., `https` connection is **mandatory** to activate devices). To handle this, applying SSL to Flask should be required. Or, **Mozilla Firefox** allows device activation without `https` by modifying its configuration. Please refer to https://stackoverflow.com/questions/60957829/navigator-mediadevices-is-undefined).
