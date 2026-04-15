---
name: babappalign
description: BABAPPAlign is a progressive multiple sequence alignment engine that uses protein language model embeddings and neural scoring to align protein sequences. Use when user asks to install the tool, set up neural scoring weights, perform protein sequence alignments, or configure alignment parameters like gap penalties and hardware acceleration.
homepage: https://github.com/sinhakrishnendu/BABAPPAlign
metadata:
  docker_image: "quay.io/biocontainers/babappalign:1.2.0--py313h9ee0642_0"
---

# babappalign

## Overview
BABAPPAlign is a progressive multiple sequence alignment engine designed specifically for protein sequences. Unlike traditional tools that rely on static substitution matrices (like BLOSUM), it integrates pretrained protein language model embeddings with a learned neural residue-residue scoring function (BABAPPAScore). It utilizes the Gotoh algorithm for exact affine-gap dynamic programming, ensuring methodological transparency and reproducibility. Use this skill to guide the installation, model setup, and execution of high-fidelity protein alignments.

## Installation
The tool can be installed via Bioconda or PyPI.

**Using Conda:**
```bash
conda install bioconda::babappalign
```

**Using Pip:**
```bash
pip install babappalign
```

## Required Model Setup
BABAPPAlign requires external trained neural scoring weights (BABAPPAScore) to function. These must be downloaded manually before the first run.

1. **Create the cache directory:**
   ```bash
   mkdir -p ~/.cache/babappalign/models
2. **Download the weights:**
   ```bash
   wget https://zenodo.org/record/18053201/files/babappascore.pt -O ~/.cache/babappalign/models/babappascore.pt
   ```

## Command Line Usage
The basic syntax requires an input FASTA file and the specification of the scoring model.

### Basic Alignment
```bash
babappalign input.fasta -o aligned.fasta --model babappascore
```

### Advanced Configuration
You can fine-tune the alignment by adjusting gap penalties or forcing specific hardware execution.

*   **Adjusting Gap Penalties:**
    ```bash
    babappalign input.fasta -o aligned.fasta --model babappascore --gap-open 10.5 --gap-extend 0.5
    ```
*   **Hardware Selection:**
    By default, the tool runs on CPU. Use `--device cuda` for GPU acceleration (affects speed only, not alignment results).
    ```bash
    babappalign input.fasta -o aligned.fasta --model babappascore --device cuda
    ```

## Expert Tips
*   **Model Paths:** If the model is not in the default cache directory, you can provide an absolute path to the `.pt` file using the `--model` flag.
*   **Reproducibility:** BABAPPAlign prints a SHA-256 checksum of the model weights at runtime. Always record this checksum in your lab notes to ensure alignment reproducibility.
*   **Input Format:** Ensure input files are in standard FASTA format. While there are no strict limits on sequence length, runtime scales with the number of sequences and hardware capabilities.

## Reference documentation
- [BABAPPAlign Overview](./references/github_com_sinhakrishnendu_BABAPPAlign.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_babappalign_overview.md)