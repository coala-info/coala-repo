---
name: tir-learner
description: The tir-learner tool is an ensemble pipeline designed for the automated annotation of Terminal Inverted Repeat (TIR) transposable elements. Use when user asks to 'annotate Terminal Inverted Repeat (TIR) transposable elements', 'analyze TIRs in a genome', 'identify TIR superfamilies', or 'configure the TIR annotation pipeline'.
homepage: https://github.com/lutianyu2001/TIR-Learner
metadata:
  docker_image: "quay.io/biocontainers/tir-learner:3.0.7--hdfd78af_0"
---

# tir-learner

## Overview

The `tir-learner` tool is an ensemble pipeline designed for the automated annotation of Terminal Inverted Repeat (TIR) transposable elements. It combines homology-based detection using curated libraries, de novo structural identification, and machine learning (CNN) classification to identify TIR superfamilies with high precision. It is particularly effective for eukaryotic genomes and includes optimized processing paths for specific model organisms like rice and maize.

## Installation and Setup

The recommended way to install `tir-learner` is via Conda or Mamba. Ensure `conda-forge` has higher priority than `bioconda` to avoid dependency conflicts.

```bash
# Create a new environment and install
mamba create -n TIRLearner_env -c conda-forge -c bioconda tir-learner

# For systems without GPU access, enforce a CPU-only PyTorch build
mamba create -n TIRLearner_env -c conda-forge -c bioconda tir-learner "pytorch=*=*cpu*"
```

## Core Usage Patterns

### Basic Execution
The minimum requirement is a genome file in FASTA format and a species designation.

```bash
TIR-Learner -f genome.fasta -s others -n my_project -o ./results
```

### Species-Specific Analysis
Selecting the correct `-s` (species) flag determines whether the pipeline uses specialized reference libraries (Part A) or a general analysis path (Part B).
- `rice`: Uses rice-specific TIR reference library.
- `maize`: Uses maize-specific TIR reference library.
- `others`: Uses the general analysis pipeline for all other eukaryotic species.

### Resource Management
`tir-learner` supports multiprocessing for tools like TIRvish and GRF. By default, it uses all available CPU cores.
- Use `-p` or `-t` to limit processor usage on shared systems.
- Use `-a NO_PARALLEL` to force serial execution if memory is constrained.

### Handling Large Genomes and Long Runs
For large eukaryotic genomes, use the checkpoint and working directory options to manage stability and disk space.

- **Checkpoints**: Use `-c` to enable progress recovery. If the program is interrupted, re-running with the same checkpoint directory will resume from the last saved state.
- **Working Directory**: Use `-w` to specify a high-speed scratch disk for temporary files, as the pipeline generates significant I/O.
- **Debug Mode**: Use `-d` to keep temporary files for troubleshooting if the pipeline fails during the GRF or TIRvish steps.

## Advanced Configuration Flags

The `-a` (additional arguments) flag allows for fine-tuning the pipeline behavior:

| Flag | Description |
| :--- | :--- |
| `CHECKPOINT_OFF` | Disables the checkpoint system entirely to save disk space. |
| `NO_PARALLEL` | Disables multi-processing; useful for debugging or low-RAM environments. |
| `SKIP_TIRVISH` | Skips the TIRvish structural analysis to reduce runtime (may decrease sensitivity). |

## Expert Tips

1. **Sequence Naming**: Ensure the input FASTA file has unique, simple sequence names. Special characters in headers can cause failures in the BLAST or GenomeTools modules.
2. **Disk Space**: The pipeline performs heavy I/O. Ensure the `--working_dir` (default `/tmp`) has sufficient space, or redirect it to a high-capacity volume using `-w`.
3. **Memory Errors**: If the process is killed during "Getting GRF result," it is often a memory exhaustion issue. Try reducing the number of processors (`-p`) or using `-a NO_PARALLEL`.
4. **Output Prefix**: Always use `-n` to provide a meaningful prefix, especially when running multiple versions of an assembly, to prevent overwriting results in the default directory.

## Reference documentation
- [TIR-Learner GitHub Repository](./references/github_com_lutianyu2001_TIR-Learner.md)
- [TIR-Learner Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_tir-learner_overview.md)