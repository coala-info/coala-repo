---
name: seaview
description: Seaview identifies and localizes road infrastructure issues using an ensemble of object detection models including YOLO and MMDetection variants. Use when user asks to detect road damage, train infrastructure inspection models, or ensemble multiple object detection results.
homepage: https://github.com/berry-ding/ShiYu_SeaView_GRDDC2022
---


# seaview

## Overview
The seaview skill provides a specialized workflow for identifying road infrastructure issues using an ensemble of state-of-the-art object detection models. It streamlines the process of managing multiple architectures—including YOLO variants and MMDetection-based Swin Transformers—to achieve high-precision results in road damage classification and localization. Use this skill to replicate the GRDDC2022 competition pipeline or to apply these models to similar infrastructure inspection tasks.

## Environment Setup
To ensure compatibility with the pre-trained weights and the ensemble logic, use the following environment configuration:

```bash
# Create and activate the environment
conda create -n crddc2022 python=3.8 -y
conda activate crddc2022

# Install PyTorch LTS 1.8.2 with CUDA 11.1 support
pip3 install torch==1.8.2+cu111 torchvision==0.9.2+cu111 torchaudio===0.8.2 -f https://download.pytorch.org/whl/lts/1.8/torch_lts.html

# Install dependencies for YOLO components
pip install -r yolov5/requirements.txt
pip install -r yolov7/requirements.txt

# Install MMDetection (v2.25.0) components
pip install openmim
mim install mmcv-full==1.6.0
mim install mmcls
cd mmdetection
pip install -r requirements/build.txt
pip install -v -e .
```

## Core Workflow Patterns

### 1. Data Organization
Place the RDD2022 datasets in the `datasets/RDD2022/` directory. The framework expects standard object detection formats compatible with the respective model subdirectories (YOLO or MMDetection).

### 2. Model Execution
The primary entry point for the detection pipeline is the `crddc.ipynb` notebook. For CLI-based execution, navigate to the specific model directories:
- **YOLOv5/v7**: Use standard `train.py` or `detect.py` scripts within their respective folders.
- **MMDetection**: Use `tools/train.py` or `tools/test.py` within the `mmdetection` directory.

### 3. Ensembling Results
After generating predictions from multiple models (e.g., YOLOv5x6 and Faster Swin-L), use the merging utility to improve overall mAP:

```bash
python merge.py
```
This script is designed to consolidate detection results from different architectures into a single submission or output file.

## Expert Tips and Best Practices
- **Resolution Selection**: For maximum accuracy on road cracks and small defects, prioritize the `YOLOv5x6_1280` or `YOLOv5x_1600` configurations.
- **MMDetection Backbone**: The `Faster_Swin_l_w12_DeformRoI` model provides the strongest localization for complex damage patterns but requires significant VRAM.
- **Weight Compatibility**: Ensure you are using the specific PyTorch 1.8.2 LTS version; newer versions of PyTorch may encounter serialization issues with the provided `.pt` or `.pth` weights.
- **Inference**: When running inference on large datasets, use the `merge.py` script to handle the Weighted Boxes Fusion (WBF) or NMS across the different model outputs.

## Reference documentation
- [Main Repository README](./references/github_com_berry-ding_ShiYu_SeaView_GRDDC2022.md)
- [MMDetection Configuration](./references/github_com_berry-ding_ShiYu_SeaView_GRDDC2022_tree_master_mmdetection.md)