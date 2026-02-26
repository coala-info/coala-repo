---
name: deepmedic
description: DeepMedic is a deep learning platform designed for the 3D segmentation of volumetric medical images using multi-scale convolutional neural networks. Use when user asks to train segmentation models on NIfTI scans, perform inference on 3D medical datasets, or configure multi-resolution convolutional pathways for image analysis.
homepage: https://github.com/Kamnitsask/deepmedic
---


# deepmedic

## Overview
DeepMedic is a deep learning platform tailored for volumetric medical image segmentation. It excels at identifying structures in 3D scans by processing data through multiple parallel convolutional pathways at different resolutions. This allows the model to maintain high-resolution local accuracy while incorporating broader spatial context. It natively supports NIfTI files and integrates with TensorFlow for GPU-accelerated computation.

## Core Workflows

### 1. Environment Setup
DeepMedic requires specific versions of TensorFlow and NiBabel to function correctly.
- **Installation**: Use `pip install .` from the source directory or `conda install -c bioconda deepmedic`.
- **Dependencies**: Ensure `tensorflow-gpu` (v2.0+ recommended), `nibabel`, `numpy`, and `scipy` are installed.
- **Verification**: Run the "tiny CNN" example provided in the repository to ensure the backend and GPU drivers are correctly linked.

### 2. Command Line Interface (CLI)
The primary entry point is the `deepMedicRun` command. It operates by reading configuration files that define the model architecture, training parameters, and testing datasets.

- **Training a Model**:
  `deepMedicRun -train <path_to_trainConfig.cfg> -model <path_to_modelConfig.cfg>`
- **Running Inference (Testing)**:
  `deepMedicRun -test <path_to_testConfig.cfg> -model <path_to_modelConfig.cfg> -load <path_to_saved_model.ckpt>`
- **Monitoring Progress**:
  DeepMedic includes a utility to visualize training metrics from the log files:
  `python plotTrainingProgress.py <path_to_training_log.txt>`

### 3. Configuration Structure
DeepMedic uses a specific configuration format (typically `.cfg` files) rather than standard YAML. There are three essential components:

- **Model Config**: Defines the CNN architecture, including the number of pathways (e.g., normal and downsampled), kernels per layer, and activation functions.
- **Train Config**: Contains paths to the training data (input channels, ground truth, and ROI masks), learning rate schedules, and batch sizes.
- **Test Config**: Specifies the list of subjects for inference and the output directory for the generated segmentation maps.

### 4. Data Preparation and Best Practices
- **File Format**: All input volumes must be in NIfTI format (.nii or .nii.gz).
- **Normalization**: Intensity values should be normalized. While DeepMedic v0.8.0+ supports on-the-fly z-score normalization, pre-processing data to have zero mean and unit variance is a standard expert practice.
- **ROI Masks**: Always use Region of Interest (ROI) masks. This restricts sampling to relevant areas (e.g., the brain volume), significantly speeding up training and improving segmentation accuracy.
- **Multi-Scale Processing**: For complex structures, configure a secondary pathway with downsampled input (e.g., factor of 3) to provide the network with a larger receptive field.

### 5. Troubleshooting and Optimization
- **Memory Management**: 3D CNNs are extremely VRAM-intensive. If you encounter Out-of-Memory (OOM) errors, reduce the `batchSize` in the training config or decrease the `segmentsDim` (the size of the 3D patches being processed).
- **Class Imbalance**: Use the `sampling` parameters in the training config to oversample foreground classes (lesions) if they occupy a very small percentage of the total volume.
- **Tensorboard**: Enable Tensorboard logging in the training configuration for real-time monitoring of loss and accuracy metrics.

## Reference documentation
- [DeepMedic GitHub Repository](./references/github_com_deepmedic_deepmedic.md)
- [Bioconda DeepMedic Package Overview](./references/anaconda_org_channels_bioconda_packages_deepmedic_overview.md)