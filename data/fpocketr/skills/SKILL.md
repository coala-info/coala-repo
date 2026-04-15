---
name: fpocketr
description: fpocketr is an RNA-centric pocket detection tool that predicts potential small molecule binding sites in RNA structures using alpha-sphere clustering. Use when user asks to predict RNA binding pockets, analyze multi-state structural ensembles, visualize pockets on secondary structures, or perform apo/holo structural comparisons.
homepage: https://github.com/Weeks-UNC/fpocketR
metadata:
  docker_image: "quay.io/biocontainers/fpocketr:1.3.4--pyhdfd78af_0"
---

# fpocketr

## Overview
fpocketR is a specialized RNA-centric wrapper for the fpocket 4.0 pocket detection suite. It provides a command-line interface to predict where drug-like small molecules might bind to RNA by analyzing alpha-sphere clusters. It extends basic pocket detection by integrating secondary structure visualization, handling multi-state structural ensembles (like NMR models), and performing automated alignments for apo/holo comparisons.

## Installation and Environment
The tool is primarily distributed via Bioconda. Ensure the environment is active before running commands.
```bash
conda create -n fpocketR fpocketr
conda activate fpocketR
```
*Note: Native support is limited to x86_64 architectures on Linux and MacOS.*

## Common CLI Patterns

### Basic Pocket Detection
To analyze a local file or fetch a structure by PDB ID:
```bash
python -m fpocketR -pdb 3e5c.pdb
```

### Integrating Secondary Structure
To generate figures that map predicted pockets onto a secondary structure diagram, provide an `.ss` or `.nsd` file:
```bash
python -m fpocketR -pdb 2l1v.pdb -ss 2l1v.nsd
```

### Multi-state (Ensemble) Analysis
For NMR or Cryo-EM structures containing multiple models, use `--state 0` to analyze the entire ensemble and generate pocket density maps:
```bash
python -m fpocketR -pdb 2l1v.pdb --state 0
```

### Apo/Holo Comparison
To align a ligand-free structure to a ligand-bound structure and compare pockets:
```bash
python -m fpocketR -pdb apo_structure.pdb --alignligand holo_structure.pdb --knownnt 19,20,42
```

## Parameter Tuning
If default pocket detection is too restrictive or too broad, adjust the fpocket engine parameters:
- **Alpha-sphere radii**: Use `-m` (default 3.0) for minimum and `-M` (default 5.70) for maximum radius. Smaller values find tighter pockets.
- **Pocket Size**: Use `-i` (default 42) to set the minimum number of alpha-spheres required to define a pocket.
- **Clustering**: Use `-D` (default 1.65) to adjust the distance for clustering alpha-spheres into a single pocket.

## Expert Tips
- **Chain Specificity**: In multi-chain complexes, always specify the RNA chain using `-c` or `--chain` to avoid processing irrelevant proteins or DNA.
- **Ligand Validation**: When analyzing a holo structure, use `-l <LIGAND_ID>` to specifically characterize the pocket containing that ligand.
- **Performance**: For large ensembles or batch processing, reduce the figure resolution with `-dpi 10` to significantly speed up the raytracing and output generation.
- **Output Management**: Use `-o` to define a parent directory for results, especially when running batch scripts, to prevent cluttering the working directory.

## Reference documentation
- [fpocketR Overview](./references/anaconda_org_channels_bioconda_packages_fpocketr_overview.md)
- [fpocketR GitHub Repository](./references/github_com_Weeks-UNC_fpocketR.md)