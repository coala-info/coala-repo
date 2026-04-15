---
name: ribodiff
description: RiboDiffusion is a generative diffusion model that performs RNA inverse folding by generating sequences that match a specific 3D tertiary structure. Use when user asks to design RNA sequences for a given PDB structure, perform RNA inverse folding, or generate multiple candidate sequences for a specific RNA shape.
homepage: https://github.com/ml4bio/RiboDiffusion
metadata:
  docker_image: "quay.io/biocontainers/ribodiff:0.2.2--0"
---

# ribodiff

## Overview

RiboDiffusion is a generative diffusion model designed for tertiary structure-based RNA inverse folding. It takes a PDB file representing an RNA structure as input and generates one or more candidate RNA sequences that are predicted to fold into that specific 3D shape. This tool is particularly useful for RNA design and engineering, providing a probabilistic approach to sequence discovery that accounts for structural constraints.

## Command Line Usage

The tool is executed via `main.py`. Ensure that model checkpoints are placed in the `ckpts/` directory before running.

### Basic Sequence Generation
To generate a single RNA sequence for a given structure:
```bash
CUDA_VISIBLE_DEVICES=0 python main.py --PDB_file path/to/your_structure.pdb
```
The output will be saved as a FASTA file in `exp_inf/fasta/`.

### Generating Multiple Samples
To generate a library of candidate sequences for the same structure, use the `n_samples` configuration:
```bash
CUDA_VISIBLE_DEVICES=0 python main.py --PDB_file path/to/your_structure.pdb --config.eval.n_samples 10
```

### Adjusting Sequence Diversity
For greater diversity in the generated sequences, you can adjust the conditional scaling weight and enable dynamic thresholding:
```bash
CUDA_VISIBLE_DEVICES=0 python main.py --PDB_file path/to/your_structure.pdb --config.eval.dynamic_threshold --config.eval.cond_scale 0.4
```

## Best Practices and Tips

- **GPU Acceleration**: Always specify `CUDA_VISIBLE_DEVICES` to ensure the diffusion model runs on the GPU, as CPU inference is significantly slower.
- **Model Selection**: Use the checkpoint trained on the full dataset (often including 0.1 Gaussian noise) for better generalization to experimental structures.
- **Conditional Scaling**: The `--config.eval.cond_scale` parameter controls how strictly the model adheres to the input structure. Lower values (e.g., 0.4) typically increase sequence diversity, while higher values focus on structural fidelity.
- **Output Management**: Generated files follow the naming convention `[PDB_NAME]_[SAMPLE_INDEX].fasta`. Monitor the `exp_inf/fasta/` directory to collect results.

## Reference documentation
- [RiboDiffusion Main Repository](./references/github_com_ml4bio_RiboDiffusion.md)