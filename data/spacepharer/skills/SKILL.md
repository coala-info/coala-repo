---
name: spacepharer
description: SpacePHARER detects interactions between prokaryotes and phages by performing sensitive homology searches between CRISPR spacers and viral genomes. Use when user asks to predict phage-host interactions, identify which phages infect specific hosts, or search CRISPR spacer databases against phage sequences.
homepage: https://github.com/soedinglab/spacepharer
---


# spacepharer

## Overview

SpacePHARER (Space Phage-Host pAiRs findER) is a specialized toolkit designed to detect interactions between prokaryotes and phages. It leverages the speed of MMseqs2 but optimizes the homology search for the short, often fragmented nature of CRISPR spacers. By translating spacers in six frames and aggregating multiple hits across a set, it provides a sensitive method for predicting which phages infect specific hosts while maintaining statistical rigor through False Discovery Rate (FDR) control.

## Installation

The tool is available via Bioconda or as precompiled binaries:

```bash
# Conda installation
conda install -c conda-forge -c bioconda spacepharer

# Static binary (Linux AVX2)
wget https://mmseqs.com/spacepharer/spacepharer-linux-avx2.tar.gz
tar xvzf spacepharer-linux-avx2.tar.gz
export PATH=$(pwd)/spacepharer/bin/:$PATH
```

## Core Workflows

### 1. The "Easy" Prediction Workflow
For most users, `easy-predict` handles the entire pipeline from raw files to a prediction table.

```bash
# Predict from FASTA files
spacepharer easy-predict queries/*.fasta targetSetDB predictions.tsv tmpFolder

# Predict from CRISPR array tool outputs (CRT, PILER-CR, CRISPRDetect)
spacepharer easy-predict examples/crisprdetect_test targetSetDB predictions.tsv tmpFolder
```

### 2. Manual Database Creation
If you need more control, create query and target databases separately.

**Critical Parameter:** When creating a database from spacers, you **must** use `--extractorf-spacer 1` to properly handle short, partial ORFs.

```bash
# Create Query DB (Spacers)
spacepharer createsetdb Query.fasta querySetDB tmpFolder --extractorf-spacer 1

# Create Target DB (Phage Genomes)
spacepharer createsetdb Phage.fasta targetSetDB tmpFolder
```

### 3. Generating Control Sets for FDR
SpacePHARER requires a control (decoy) database to calibrate the match reporting threshold.

```bash
# Create a control set by reversing protein fragments
spacepharer createsetdb Phage.fasta targetSetDB_rev tmpFolder --reverse-fragments 1
```

## Command Reference & Parameters

| Command | Purpose |
|---------|---------|
| `easy-predict` | End-to-end prediction from multiFASTA or CRISPR tool files. |
| `createsetdb` | Converts FASTA files into the optimized SpacePHARER database format. |
| `downloaddb` | Downloads pre-indexed spacers or GenBank phage genomes. |
| `predictmatch` | Performs the actual search between two pre-built databases. |
| `parsespacer` | Extracts spacers from CRT, PILER-CR, or CRISPRDetect formats. |

### Key Parameters
- `--fdr [float]`: Sets the false discovery rate cut-off (e.g., `0.05`).
- `--fmt [0, 1, 2]`: Output format.
    - `0`: Short (matches only).
    - `1`: Long (matches and individual hits).
    - `2`: Long with nucleotide alignments.
- `--extractorf-spacer 1`: Essential for spacer databases to extract putative protein fragments.

## Expert Tips
- **Multi-core execution:** SpacePHARER is designed for multi-threading. Ensure your environment supports OpenMP (especially on macOS, where `gcc` from Homebrew is preferred over the default `clang`).
- **Input Organization:** For spacers, provide one FASTA file per genome. SpacePHARER treats each file as a single host entity when aggregating hits.
- **Memory Management:** Use a dedicated `tmpFolder` on a fast disk (SSD) to handle intermediate MMseqs2 files efficiently.

## Reference documentation
- [SpacePHARER GitHub Repository](./references/github_com_soedinglab_spacepharer.md)
- [Bioconda SpacePHARER Overview](./references/anaconda_org_channels_bioconda_packages_spacepharer_overview.md)