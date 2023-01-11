# reference: https://ruslanmv.com/blog/Record-your-voice-to-text-using-Flask

from flask import Flask, render_template, request, redirect, url_for
import librosa
import io
import os
import riva.client

FILE_ROOT = "./samples/simple_kr_asr/recording_samples"

app = Flask(__name__)

auth = riva.client.Auth(uri="riva-speech:50051")
riva_asr = riva.client.ASRService(auth)


@app.route("/save-audio", methods=["POST"])
def saveAudio():
    if "file" not in request.files:
        print("No files")
        return redirect(url_for('/'))
    
    file = request.files["file"]
    if file.filename == "":
        return redirect(url_for('/'))

    if file:
        app.config['filepath'] = FILE_ROOT + "/" + file.filename
        file.save(app.config['filepath'])       
        print("Audio file persisted")
    
    return 'Successfully recorded'
    

@app.route("/", methods=["GET", "POST"])
def index():
    transcript = ""
    if request.method == "POST":
        # load the record file
        audio, sr = librosa.core.load(app.config['filepath'], sr=None)
        with io.open(app.config['filepath'], 'rb') as fh:
            content = fh.read()
            
        model = request.form['model-select']
        offline_config = riva.client.RecognitionConfig(
            encoding=riva.client.AudioEncoding.LINEAR_PCM,        
            sample_rate_hertz = sr,                                            
            max_alternatives=1,                                                
            enable_automatic_punctuation=True,                                 
            audio_channel_count = 1,                                           
            verbatim_transcripts=False,
            model=model                               
        )
        response = riva_asr.offline_recognize(content, offline_config)
        try:
            transcript = response.results[0].alternatives[0].transcript
        except IndexError as e:
            print("voice is unclear, please record your voice again")
        print('selected model: ', model)
        print("transcription: ", transcript)
                                  
    return render_template('index.html', transcript=transcript)


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=8009, threaded=True)
