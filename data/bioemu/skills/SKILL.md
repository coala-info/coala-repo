---
name: bioemu
description: BioEmu (Biomolecular Emulator) is a generative AI tool designed to sample the approximated equilibrium distribution of protein monomer structures.
homepage: https://github.com/microsoft/bioemu
---

# bioemu

## Overview
BioEmu (Biomolecular Emulator) is a generative AI tool designed to sample the approximated equilibrium distribution of protein monomer structures. Unlike traditional folding tools that predict a single static structure, BioEmu generates ensembles that represent the structural diversity of a protein in equilibrium. It utilizes diffusion models and can be "steered" using Sequential Monte Carlo (SMC) to ensure physical realism, such as avoiding steric clashes and chain breaks.

## Installation and Setup
- **Platform**: Linux-only.
- **Python**: 3.10 to 3.12.
- **Command**: `pip install bioemu` or `conda install bioconda::bioemu`.
- **First Run**: The tool automatically sets up a Colabfold environment in `~/.bioemu_colabfold`. To change this location, set the `BIOEMU_COLABFOLD_DIR` environment variable before the first run.

## Common CLI Patterns

### Basic Sampling
Generate a set of structures for a specific sequence:
`python -m bioemu.sample --sequence GYDPETGTWG --num_samples 10 --output_dir ./output`

### Sampling with Steering
To significantly reduce unphysical samples (clashes/breaks), use steering. This requires specifying a denoiser and a steering configuration file (typically found in the source `config` directory):
`python -m bioemu.sample --sequence <SEQ> --num_samples 100 --output_dir ./steered --steering_config <PATH_TO_STEERING_YAML> --denoiser_config <PATH_TO_DENOISER_YAML>`

### Using Custom MSAs
If you have a pre-generated Multiple Sequence Alignment (MSA), pass the `.a3m` file directly to the sequence argument. Ensure the query sequence is the first row:
`python -m bioemu.sample --sequence path/to/alignment.a3m --num_samples 50 --output_dir ./msa_output`

### Disabling Physical Filtering
By default, BioEmu filters out structures with clashes or discontinuities. To keep all generated samples regardless of physical validity:
`python -m bioemu.sample --sequence <SEQ> --num_samples 10 --output_dir ./all_samples --filter_samples False`

## Python API Usage
For integration into Python workflows:
```python
from bioemu.sample import main as sample
sample(sequence='GYDPETGTWG', num_samples=10, output_dir='test_dir')
```

## Best Practices and Tips
- **Steering Particles**: Use 3 to 10 steering particles per output sample for the best balance between physical validity and computational cost.
- **GPU Memory**: For long sequences (e.g., 600 residues), high VRAM (A100 80GB) is recommended. If memory errors occur, reduce the batch size.
- **Monomers Only**: BioEmu is optimized for monomers. Multimer sampling using linkers is currently not officially supported and often yields poor results.
- **Checkpoints**: The model automatically downloads weights from Hugging Face. Version 1.2 is the current standard, trained on an extended set of MD simulations and experimental folding free energies.
- **Reproducibility**: By default, the tool uses system time for the seed. For reproducible runs, manually specify a seed if the specific implementation allows or check the `sample.py` options.

## Reference documentation
- [BioEmu GitHub Repository](./references/github_com_microsoft_bioemu.md)
- [BioEmu Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_bioemu_overview.md)