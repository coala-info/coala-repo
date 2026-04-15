---
name: contignet
description: ContigNet uses a convolutional neural network to predict the likelihood of interactions between phage and bacterial contigs. Use when user asks to predict phage-host interactions, analyze viral ecology, or identify potential hosts for viral sequences in fragmented genomic data.
homepage: https://github.com/tianqitang1/ContigNet
metadata:
  docker_image: "quay.io/biocontainers/contignet:1.0.1.post3--pyh7cba7a3_0"
---

# contignet

## Overview
ContigNet is a deep learning tool that utilizes a convolutional neural network (CNN) to predict the likelihood of interaction between phage and bacterial contigs. While traditional methods often perform poorly on fragmented genomic data, ContigNet is specifically optimized for contig-to-contig interaction prediction, making it a valuable asset for viral ecology and microbiome studies.

## Installation
The tool can be installed via Conda or Pip:

```bash
# Using Conda (recommended)
conda install -c bioconda contignet

# Using Pip
pip install ContigNet
```

## Command Line Usage

### Basic Syntax
The primary command for running predictions is `ContigNet`. You must provide directories for both host and virus sequences.

```bash
ContigNet --host_dir path/to/hosts --virus_dir path/to/viruses -o results.csv
```

### Arguments
- `--host_dir`: Directory containing host contig sequences in FASTA format.
- `--virus_dir`: Directory containing virus contig sequences in FASTA format.
- `--output` or `-o`: Path to the output CSV file (default: `result.csv`).
- `--cpu`: Force the tool to use the CPU. Use this if a compatible GPU is not available or if you encounter CUDA-related errors.

### Windows Usage
On Windows systems, if the `ContigNet` command is not directly recognized in the terminal, use the Python module flag:

```bash
python -m ContigNet --host_dir host_folder --virus_dir virus_folder
```

## Best Practices and Tips
- **Input Preparation**: Ensure that your FASTA files are properly formatted and grouped into directories. ContigNet processes all FASTA files within the specified directories.
- **Hardware Acceleration**: By default, the tool attempts to use a GPU. For large-scale metagenomic predictions, ensuring GPU availability will significantly reduce processing time.
- **Interpreting Results**: The output CSV provides a likelihood score for every possible phage-host pair from the input directories. These scores represent the model's confidence in a potential interaction; higher scores indicate a higher probability of a true biological interaction.
- **Metagenomic Workflow**: When working with assembly outputs (e.g., from SPAdes or MEGAHIT), binning your contigs first can help you provide more specific host directories for more targeted interaction analysis.

## Reference documentation
- [ContigNet GitHub Repository](./references/github_com_tianqitang1_ContigNet.md)
- [ContigNet Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_contignet_overview.md)