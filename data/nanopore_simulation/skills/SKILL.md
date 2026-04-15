---
name: nanopore_simulation
description: Nanopore SimulatION generates raw ONT MinION signal data in Fast5 format by applying a pore model to a reference genome. Use when user asks to simulate nanopore sequencing data, generate raw Fast5 signals, or test basecalling and mapping pipelines.
homepage: https://github.com/crohrandt/nanopore_simulation
metadata:
  docker_image: "quay.io/biocontainers/nanopore_simulation:0.3--py35_0"
---

# nanopore_simulation

## Overview
Nanopore SimulatION is a specialized tool designed to mimic the output of an ONT MinION device. It generates raw signal data (Fast5 format) by applying a pore model to a reference genome, guided by parameters from a real experiment. This is essential for developers who need to test basecalling algorithms or mapping pipelines without the cost and time of physical sequencing.

## Core Workflow
To perform a simulation, you must provide four primary components:
1. **Reference Genome**: A FASTA file containing the sequences to be simulated.
2. **Model File**: An ONT-provided model file that describes the signal characteristics of specific pores.
3. **Configuration File**: A file derived from a real experiment to set simulation parameters.
4. **Basecallable Fast5s**: Files containing raw values to serve as templates.

## Installation
The tool can be installed via Bioconda or from source:

```bash
# Via Conda
conda install bioconda::nanopore_simulation

# From Source
git clone https://github.com/crohrandt/nanopore_simulation
cd nanopore_simulation
pip3 install -e .
```

Note: System-level dependencies include `python3-tk` (Debian/Ubuntu) or `python3-tkinter` (CentOS/RedHat).

## Usage Patterns
The tool typically utilizes shell scripts to orchestrate the simulation process.

### Running Examples
Navigate to the `examples` directory to run pre-configured simulations:

```bash
# Quick DNA simulation
cd examples/DNA
./DNA_quick_example_run.sh

# Full DNA simulation
./DNA_full_example_run.sh
```

### Downstream Integration
After generating simulated Fast5 files, the standard workflow involves basecalling and mapping:

1. **Basecalling (e.g., using Albacore)**:
   ```bash
   read_fast5_basecaller.py -i [input_dir] -o fast5,fastq -s [output_dir] -f FLO-MIN106 -k SQK-LSK108 -t 4 -r
   ```

2. **Mapping (e.g., using Minimap2)**:
   ```bash
   minimap2 -ax map-ont [reference.fa] [basecalled.fastq] > output.sam
   ```

## Best Practices
- **Model Selection**: Ensure the model file matches the specific flow cell (e.g., FLO-MIN106) and sequencing kit (e.g., SQK-LSK108) you intend to simulate.
- **Config Derivation**: For the most realistic results, use a configuration file generated from a successful real-world MinION run.
- **Environment**: Ensure all Python dependencies (numpy, scipy, biopython, argparse, pandas, h5py) are available in your environment; these are typically handled automatically by the pip or conda installation.

## Reference documentation
- [Nanopore SimulatION GitHub Repository](./references/github_com_crohrandt_nanopore_simulation.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_nanopore_simulation_overview.md)