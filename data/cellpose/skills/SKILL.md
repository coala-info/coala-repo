---
name: cellpose
description: Cellpose is a versatile algorithm designed for the precise segmentation of cells and nuclei across a wide variety of image types.
homepage: https://github.com/MouseLand/cellpose
---

# cellpose

## Overview
Cellpose is a versatile algorithm designed for the precise segmentation of cells and nuclei across a wide variety of image types. It utilizes a deep learning approach based on vector flows to handle diverse morphologies and crowded environments. The tool is particularly effective for biological researchers who need to automate the extraction of cellular boundaries from microscopy datasets. It supports advanced features like 3D volume segmentation, image restoration (Cellpose3), and human-in-the-loop fine-tuning to improve accuracy on specific datasets.

## Installation and Setup
Cellpose can be installed via pip or conda. For most users, the version with GUI support is recommended for initial parameter testing.

- **Standard Install**: `python -m pip install cellpose`
- **GUI Support**: `python -m pip install cellpose[gui]`
- **GPU Acceleration**: Ensure `torch` is installed with CUDA support to significantly speed up processing.

## Command Line Interface (CLI) Usage
The CLI is the primary method for batch processing large datasets.

### Basic Segmentation
To run segmentation on a directory of images using the generalist `cyto3` model:
```bash
python -m cellpose --dir /path/to/images --pretrained_model cyto3 --diameter 30. --save_png
```

### Nuclear Segmentation
For images containing only nuclei:
```bash
python -m cellpose --dir /path/to/images --pretrained_model nuclei --diameter 10. --save_png
```

### 3D Segmentation
To process 3D stacks (TIF or multi-page files), use the `--do_3D` flag.
```bash
python -m cellpose --dir /path/to/images --pretrained_model cyto3 --do_3D --flow3D_smooth
```

### Image Restoration (Cellpose3)
Cellpose3 introduces image restoration models that can be applied before segmentation to handle noise or blur.
```bash
python -m cellpose --dir /path/to/images --pretrained_model cyto3 --restore_type denoise
```

## Key Parameters and Best Practices
- **Diameter**: This is the most critical parameter. If set to 0, the model will attempt to auto-estimate the size, but providing an approximate pixel diameter (e.g., `--diameter 30.0`) usually yields more consistent results.
- **Channels**: Specify which channels to use for segmentation.
  - `--chan 0`: Grayscale
  - `--chan 1`: Red (Cytoplasm/Membrane)
  - `--chan 2`: Green (Nuclei)
  - Example for Cyto + Nuclei: `python -m cellpose --dir <path> --pretrained_model cyto3 --chan 1 --chan2 2`
- **GPU Usage**: Always include `--use_gpu` if a compatible NVIDIA or Apple Silicon (MPS) chip is available.
- **3D Optimization**: For 3D volumes, use `--flow3D_smooth` to reduce artifacts and `--pretrained_model_ortho` for better generalization across planes.
- **Data Types**: Cellpose 4.0+ handles `float32` training and improved `dtype` handling for high-bit depth images.

## Training Custom Models
If pretrained models fail to segment your specific cell type, you can fine-tune a model using labeled data.
```bash
python -m cellpose --train --dir /path/to/train_images --pretrained_model cyto3 --n_epochs 100 --learning_rate 1e-5
```
*Note: Training data should include images and corresponding `_masks.tif` files.*

## Troubleshooting Common Issues
- **Memory Errors**: 3D volumes and large 2D images require significant RAM (16GB-32GB). If you encounter OOM (Out of Memory) errors on the GPU, try processing without `--use_gpu` or tiling the image.
- **Axis Inconsistency**: Ensure your input images have consistent channel axes. Use `--channel_axis` if your data does not follow the standard `(Channels, Z, Y, X)` or `(Z, Y, X, Channels)` formats.
- **Empty Masks**: If the output masks are empty, the diameter may be set incorrectly. Check the scale of your cells in pixels.

## Reference documentation
- [Cellpose Main Repository](./references/github_com_MouseLand_cellpose.md)
- [Cellpose Issues and Bug Reports](./references/github_com_MouseLand_cellpose_issues.md)
- [Cellpose Commit History and Updates](./references/github_com_MouseLand_cellpose_commits_main.md)