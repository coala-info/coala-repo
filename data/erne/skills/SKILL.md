---
name: erne
description: ERNeRF is an end-to-end pipeline for high-fidelity talking-head synthesis that creates digital avatars from video and synchronizes them to audio. Use when user asks to train a new avatar model from a source video, generate realistic video output from audio input, or perform face tracking and 3DMM conversion for digital avatars.
homepage: https://github.com/chengyuanba/avatar_ernerf
metadata:
  docker_image: "quay.io/biocontainers/erne:2.1.1--boost1.61_0"
---

# erne

## Overview
ERNeRF (Avatar ERNeRF) is an end-to-end pipeline designed for high-fidelity talking-head synthesis. It "sutures" together various state-of-the-art modules—including face tracking, parsing, and background matting—to create a digital avatar from a single continuous video. Once a model is trained on a specific subject, it can generate realistic video output synchronized to any provided audio input.

## Usage Patterns

### Environment Setup
Before running any tasks, ensure the project root is in your Python path:
```bash
export PYTHONPATH=./
```

### Training a New Avatar Model
To train a model on a specific person, you need a high-quality source video (ideally 5-10 minutes, single shot, one person).
```bash
python -u create_train_task.py -i <path_to_input_video> --model_uid <unique_model_id>
```

### Generating Video (Inference)
Once a model is trained, use an audio file to drive the avatar's speech:
```bash
python -u create_infer_task.py -i <path_to_input_audio> -c <unique_model_id_or_config_file>
```

## Best Practices and Tips
- **Video Quality**: The source video must be a single continuous shot. Avoid cuts, transitions, or multiple people in the frame, as this will break the face tracking and landmark detection modules.
- **3DMM Requirements**: The system relies on 3D Morphable Models (3DMM) for head pose estimation. Ensure the following files are present in `pretrained_weights/3DMM/`:
  - `exp_info.npy`, `keys_info.npy`, `sub_mesh.obj`, and `topology_info.npy`.
- **BFM Conversion**: If using the Basel Face Model 2009, you must convert the `.mat` file using the provided utility:
  ```bash
  cd modules/face_tracking
  python convert_BFM.py
  ```
- **Hardware Constraints**: This tool is optimized for CUDA 11.3. Using different CUDA versions may require recompiling the third-party extensions found in `install_ext.sh`.
- **Audio Input**: For best results during inference, ensure the input audio is clear and free of heavy background noise, as the ER-NeRF algorithm uses these features to drive lip-syncing.

## Reference documentation
- [Avatar ERNeRF Overview](./references/github_com_chengyuanba_avatar_ernerf.md)