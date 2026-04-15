---
name: s4pred
description: S4PRED is a deep learning framework for high-accuracy protein secondary structure prediction directly from primary amino acid sequences. Use when user asks to predict protein secondary structures, perform fast sequence-to-structure inference without homology searches, or generate PSIPRED-style secondary structure files.
homepage: https://github.com/psipred/s4pred
metadata:
  docker_image: "quay.io/biocontainers/s4pred:1.2.1--pyhdfd78af_1"
---

# s4pred

## Overview
S4PRED is a deep semi-supervised learning framework for high-accuracy protein secondary structure prediction. Unlike traditional methods that rely on time-consuming homology searches, S4PRED operates directly on the primary amino acid sequence. It provides 3-state predictions (Helix, Strand, Coil) and is capable of processing sequences in less than a second on standard hardware.

## Installation and Setup
The tool can be installed via Bioconda or manually from source.

**Conda Installation:**
```bash
conda install bioconda::s4pred
```

**Manual Setup:**
1. Clone the repository and navigate to the directory.
2. Download and extract the model weights (required for inference):
```bash
wget http://bioinfadmin.cs.ucl.ac.uk/downloads/s4pred/weights.tar.gz
tar -xvzf weights.tar.gz
```

## Command Line Usage

### Basic Prediction
The standard execution takes a FASTA file and pipes the results to an `.ss2` file (the default PSIPRED-style format).
```bash
python run_model.py input.fas > output.ss2
```

### Batch Processing
When handling a FASTA file containing multiple sequences, use the `--save-files` flag to generate individual outputs.
```bash
python run_model.py --save-files --outdir ./results/ input_multi.fas
```

### Hardware Acceleration
By default, S4PRED runs on the CPU and uses less than 1GB of memory. For large-scale datasets, use a GPU:
```bash
python run_model.py --device gpu input.fas
```

### Output Formats
S4PRED supports three output formats via the `-t` or `--outfmt` flag:
- `ss2`: (Default) Detailed table with residue-level probabilities for Coil, Helix, and Strand.
- `fas`: FASTA-like format where the sequence is followed by the predicted structure string.
- `horiz`: Horizontal alignment format, useful for visual inspection of structural elements.

**Example for horizontal output:**
```bash
python run_model.py --outfmt horiz input.fas
```

## Expert Tips and Best Practices

- **Confidence Scores:** When using the FASTA output format, include the `--fas-conf` flag to append three additional lines representing the probabilities for each class (Loop, Helix, Strand).
- **Handling Messy Headers:** Biopython's interpretation of FASTA headers can sometimes lead to problematic filenames. Use the `--save-by-idx` flag to name output files numerically (e.g., `s4_out_0.ss2`) instead of using the sequence ID.
- **Silent Mode:** Use the `-s` or `--silent` flag when processing large batches with `--save-files` to prevent the terminal from being flooded with prediction text.
- **Environment:** If using a virtual environment with Torch, ensure your `LD_LIBRARY_PATH` includes the paths to the virtualenv's `cudnn/lib/` and `nccl/lib/` if you encounter GPU execution issues.

## Reference documentation
- [s4pred GitHub Repository](./references/github_com_psipred_s4pred.md)
- [s4pred Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_s4pred_overview.md)