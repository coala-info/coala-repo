---
name: derna
description: The derna tool generates Pareto optimal RNA sequences from protein inputs by balancing structural stability and translation efficiency. Use when user asks to design RNA sequences, perform lambda sweeps for energy and codon optimization trade-offs, or evaluate the MFE and CAI of existing sequences.
homepage: https://github.com/elkebir-group/derna
metadata:
  docker_image: "quay.io/biocontainers/derna:1.0.4--h503566f_1"
---

# derna

## Overview
The `derna` tool is a specialized utility for researchers working on RNA design. It takes a protein sequence as input and generates RNA sequences that are Pareto optimal, balancing structural stability (MFE) and translation efficiency (CAI). It supports multiple folding models (Nussinov and Zuker) and allows for "lambda sweeps" to explore the trade-offs between energy and codon optimization.

## Command Line Usage

### Core Arguments
- `-i`: Path to the input protein sequence file (FASTA format).
- `-o`: Path to the output text file.
- `-m`: Model selection: `0` (Nussinov), `1` (Zuker), `-1` (Evaluation mode).
- `-s`: Mode selection: `1` (MFE only), `2` (MFE + CAI), `3` (Lambda sweep).
- `-l`: Lambda value `[0,1]` (weighting factor for MFE vs CAI).
- `-c`: Path to a custom codon usage table (CSV).
- `-d`: Directory containing energy parameters (for Zuker model).

### Common Workflows

#### 1. Pareto Optimal RNA Design (Fixed Weight)
To design an RNA sequence where you want to balance structural stability and codon usage equally:
```bash
derna -i protein.fasta -o output.txt -m 1 -s 2 -l 0.5
```

#### 2. Lambda Sweep (Exploration)
To generate a collection of solutions across the entire Pareto front (varying lambda from 0 to 1):
```bash
derna -i protein.fasta -o results.txt -O sweep_results -m 1 -s 3 -a 0.1
```
*Note: `-a` sets the increment interval for the sweep.*

#### 3. Evaluating an Existing RNA Sequence
To calculate the MFE and CAI for a specific RNA sequence against a target protein:
```bash
derna -i protein.fasta -r sequence.rna -o evaluation.txt -m -1
```

#### 4. MFE-Only Optimization
To find the most stable structure regardless of codon usage:
```bash
derna -i protein.fasta -o mfe_only.txt -m 1 -s 1
```

## Expert Tips
- **Model Selection**: Use the Zuker model (`-m 1`) for more biologically accurate energy calculations. The Nussinov model (`-m 0`) is faster but only considers base-pair maximization.
- **Gap Constraints**: When using the Nussinov model, use `-g` to specify the minimal gap allowed for hairpins.
- **Custom Codon Tables**: For non-standard organisms, always provide a custom table via `-c` to ensure the CAI calculation is relevant to your target host.
- **Thresholding**: Use `-t` (tau) and `-p` (tau2) to set thresholds for the optimization algorithm if the default Pareto search is too broad.

## Reference documentation
- [derna GitHub README](./references/github_com_elkebir-group_derna.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_derna_overview.md)