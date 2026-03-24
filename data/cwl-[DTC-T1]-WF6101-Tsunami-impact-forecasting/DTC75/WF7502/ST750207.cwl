#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

inputs: 
  SETUP_PARAMETERS:
    type: File
  INFERENCE_PARAMETERS:
    type: File
  PLOTS_PARAMETERS:
    type: File
  DAL:
    type: File
  SSH_KNOWN_HOSTS:
    type: File
  SSH_AUTH_SOCK:
    type: string
outputs: 
  MLESMAP_RESULTS:
    type: Directory

steps:
  start_mlesmap_service:
    in:
      DAL: DAL
      SSH_KNOWN_HOSTS: SSH_KNOWN_HOSTS
      SSH_AUTH_SOCK: SSH_AUTH_SOCK
    run:
      class: CommandLineTool
      baseCommand: ["sh", "-c"]
      arguments: ["docker network create ucis4eq && \
                  docker run -d \
                    --name dal \
                    --restart always \
                    --network ucis4eq \
                    mongo:4.2 \
                    mongod --quiet --logpath /dev/null && \
                  docker run -d \
                    --name mlesmap \
                    -p 5005:5005 \
                    --env SSH_AUTH_SOCK=$(inputs.SSH_AUTH_SOCK) \
                    -v $(inputs.DAL.path):/opt/DAL.json \
                    -v $(inputs.SSH_AUTH_SOCK):$(inputs.SSH_AUTH_SOCK) \
                    -v $(inputs.SSH_KNOWN_HOSTS.path):/root/.ssh/known_hosts \
                    --restart always \
                    --network ucis4eq \
                    registry.gitlab.com/gdiezven/ucis4eq-dt-geo/mlesmap:latest"]
      stdout: service_ok.txt
      inputs: 
        DAL: 
          type: File
        SSH_KNOWN_HOSTS:
          type: File
        SSH_AUTH_SOCK:
          type: string
      outputs:
        SERVICE_OK:
          type: File
          outputBinding:
            glob: service_ok.txt
    out:
    - SERVICE_OK
  
  query_mlesmap_service_setup:
    in:
      SERVICE_OK: start_mlesmap_service/SERVICE_OK
      SETUP_PARAMETERS: SETUP_PARAMETERS
    run:
      class: CommandLineTool
      baseCommand: ["sh", "-c"]
      arguments: ["until curl -X POST -H 'Content-Type: application/json' -d @$(inputs.SETUP_PARAMETERS.path) http://127.0.0.1:5005/mlesmapSetup; do sleep 20; done"]
      stdout: response1.txt
      inputs: 
        SERVICE_OK: File
        SETUP_PARAMETERS: File
      outputs:
        response1:
          type: File
          outputBinding:
            glob: response1.txt
    out:
      - response1

  query_mlesmap_service_inference:
    in:
      response1: query_mlesmap_service_setup/response1
      INFERENCE_PARAMETERS: INFERENCE_PARAMETERS
    run:
      class: CommandLineTool
      baseCommand: ["sh", "-c"]
      arguments: ["until curl -X POST -H 'Content-Type: application/json' -d @$(inputs.INFERENCE_PARAMETERS.path) http://127.0.0.1:5005/mlesmapInference; do sleep 5; done"]
      stdout: response2.txt
      inputs: 
        response1: File
        INFERENCE_PARAMETERS: File
      outputs:
        response2:
          type: File
          outputBinding:
            glob: response2.txt
    out:
      - response2

  query_mlesmap_service_plots:
    in:
      response2: query_mlesmap_service_inference/response2
      PLOTS_PARAMETERS: PLOTS_PARAMETERS
    run:
      class: CommandLineTool
      baseCommand: ["sh", "-c"]
      arguments: ["until curl -X POST -H 'Content-Type: application/json' -d @$(inputs.PLOTS_PARAMETERS.path) http://127.0.0.1:5005/mlesmapPlots; do sleep 5; done"]
      stdout: response3.txt
      inputs: 
        response2: File
        PLOTS_PARAMETERS: File
      outputs:
        response3:
          type: File
          outputBinding:
            glob: response3.txt
    out:
      - response3
  
  stop_mlesmap_service:
    in:
      response3: query_mlesmap_service_plots/response3
    run:
      class: CommandLineTool
      baseCommand: ["sh", "-c"]
      arguments: ["docker stop dal mlesmap && docker rm dal mlesmap && docker network rm ucis4eq"]
      stdout: output.txt
      inputs:
        response3: File
      outputs: 
        MLESMAP_RESULTS:
          type: File
          outputBinding:
            glob: output.txt
    out:
      - MLESMAP_RESULTS