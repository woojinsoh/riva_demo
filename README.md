# NVIDIA Riva SDK Demonstration

The contents in this repository is for demonstrating Riva SDK workflow. Please execute the notebook files described below in sequence to avoid some dependencies.

##### 1_riva_api_demo.ipynb
It shows how to use basic riva api with simple examples.

##### 2_dev_with_NeMo.ipynb
It shows how to finetune the existing pre-trained model to your target task using NeMo toolkit based on TTS example(fastptich-HifiGan).

##### 3_build_and_deploy_to_riva.ipynb
It contains how to convert NeMo to Riva format, how to build Riva to get RMIR, and finally, how to deploy it to the Riva Service.

##### 4_supplement_NeMo.ipynb (optional)
Some additional information about NeMo is included.

##### 5_riva_korean_asr.ipynb (newly added at Jan.2023)
Korean ASR models(Conformer-CTC, Citrinet) demonstration with Riva.

## Demo environment
Note that the RIVA Server and Client are using the same docker image. I'd like to make sure that the **docker network** `riva-speech` might not be actually needed according to the environment(anyone who tires this demo can adjust it according to your own enviornment). In this demo case, the remote machine is running within the VPN, which requires the private docker network defined to connect with each other, and to the browser for the Juptyerlab. 
<img src="./resources/images/demo_env.png" width="100%" height="100%" title="Demo Env" alt="Demo"></img>


## Prerequisite
1. Clone the repository.
    ```bash
    git clone https://github.com/woojinsoh/riva_demo.git
    cd riva_demo
    ```

2. Get access to NGC and install NGC CLI tools.
   - https://docs.nvidia.com/ngc/ngc-overview/index.html#registering-activating-ngc-account

3. Download Riva resources from NGC.
    ```bash
    mkdir –p ./resources && cd resources
    ngc registry resource download-version "nvidia/riva/riva_quickstart:2.8.1" # updated(2023.01.02)
    ```

4. Create docker network.
    ```bash
    docker network create riva-speech
    ```

5. Initialize and start Riva Server.
    - Move to the resource directory.
    ```bash
    cd riva_quickstart:2.8.1
    ```
    - Modify `config.sh` with your preffered configuration from downloaded resources. Then, run:
    ```bash
    bash riva_init.sh  # it usually takes over 40 mins by default.
    ```

6. Start Riva Server.
    - Add `--net=riva-speech` option to docker running command in `riva_start.sh` from downloaded resources. Then, run:
    ```bash
    bash riva_start.sh
    ```

7. Start Riva Client.
    - Add some options to docker running command in `riva_start_client.sh`. For example, 
        - Mount your workspace to the docker container(i.e., `-v <myworkspace_path>:/workspace`) 
        - Apply the same docker network(`--net=riva-speech`) with that of the Riva server. 
        - Additional port mappings(`-p 1005:8888` for jupyterlab, `-p 8009:8009` for additional usage) are also required. 
    - Then, run:
    ```bash
    bash riva_start_client.sh
    ```

## Riva Resources
##### nemo2riva-2.8.1-py3-none-any.whl
- Binary wheel for format converter from NeMo to Riva.

##### riva_init.sh
- Automatically initialize and setup runnable riva environment.
    1. Pull riva container images(server, client, servicemaker)
    2. Download default built models(RMIRs) enabled in `config.sh` from NGC. 
         - Download location: `$riva_model_loc/rmir`, which is defined as docker volume.
    3. Optimize the downloaded models and deploy them to model repository.
         - Deploy location: `$riva_model_loc/models`

##### riva_start.sh
- Start riva server
port # 8000, 8001, 8002 for triton, port 50051(default) for riva-speech api.
- Preload model repos based on desired services.

##### riva_start_client.sh
- Start the riva client.

##### riva_stop.sh
- Shut down the riva server container.

##### riva_clean.sh
- Clean up local riva installation.
- You might need to remove docker volume manually after this shell script is done.
