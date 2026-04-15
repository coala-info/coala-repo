---
name: cycle
description: The cycle tool provides a specialized workflow for image-to-image translation using PyTorch implementations of CycleGAN and pix2pix. Use when user asks to train models on paired or unpaired image datasets, perform inference with pre-trained models, or set up multi-GPU training environments for image translation tasks.
homepage: https://github.com/junyanz/pytorch-CycleGAN-and-pix2pix
metadata:
  docker_image: "biocontainers/cycle:v0.3.1-14-deb_cv1"
---

# cycle

## Overview
The `cycle` skill provides a specialized workflow for the PyTorch implementation of CycleGAN and pix2pix. This tool is essential for image-to-image translation projects, such as converting sketches to photos (paired) or transforming horses into zebras (unpaired). It leverages high-performance features including PyTorch 2.4+ support, `torch.compile` for speed, and DDP for multi-GPU training environments.

## Core Workflows

### Environment Setup
The tool requires Python 3 and PyTorch 2.4+. For multi-GPU setups, use `torchrun`.
```bash
# Activate environment
conda activate pytorch-img2img
```

### Training Models
Training requires a defined `dataroot` and a unique `name` for the experiment.

**CycleGAN (Unpaired Data):**
Used when you have two sets of images (Domain A and Domain B) without direct one-to-one correspondences.
```bash
python train.py --dataroot ./datasets/horse2zebra --name h2z_model --model cycle_gan
```

**pix2pix (Paired Data):**
Used when you have exact pairs (e.g., a map and its corresponding satellite view).
```bash
python train.py --dataroot ./datasets/facades --name facades_pix2pix --model pix2pix --direction BtoA
```

**Multi-GPU Training:**
Utilize DDP for faster training on machines with multiple GPUs.
```bash
torchrun --nproc_per_node=4 train.py --dataroot ./datasets/maps --name maps_cyclegan --model cycle_gan
```

### Testing and Inference
Testing generates results based on the latest checkpoints.

**Standard Test:**
```bash
python test.py --dataroot ./datasets/maps --name maps_cyclegan --model cycle_gan
```

**Applying Pre-trained CycleGAN (One-way):**
To apply a model to a single directory of images without needing the full cycle:
```bash
python test.py --dataroot datasets/horse2zebra/testA --name horse2zebra_pretrained --model test --no_dropout
```
*Note: `--model test` automatically sets `--dataset_mode single`.*

## Expert Tips and Configurations

- **Logging:** Always include the `--use_wandb` flag to sync training progress and intermediate image results to the Weights & Biases dashboard.
- **Colorization:** For colorization-specific tasks, you must set both the model and dataset mode:
  `python train.py --model colorization --dataset_mode colorization [other options]`
- **Intermediate Results:** Check `./checkpoints/{experiment_name}/web/index.html` during training to view real-time visual updates of the model's performance.
- **Memory Efficiency:** If training is slow or memory-intensive, consider using the `CUT` (Contrastive Unpaired Translation) model variant if available in the environment, as it is more memory-efficient than standard CycleGAN.

## Reference documentation
- [CycleGAN and pix2pix in PyTorch](./references/github_com_junyanz_pytorch-CycleGAN-and-pix2pix.md)