---
name: mimseq
description: The `mimseq` skill provides a specialized workflow for the comprehensive analysis of tRNA pools.
homepage: https://github.com/nedialkova-lab/mim-tRNAseq
---

# mimseq

## Overview
The `mimseq` skill provides a specialized workflow for the comprehensive analysis of tRNA pools. It automates the transition from raw sequencing reads to high-resolution profiles of tRNA abundance and modification status. By leveraging modification-induced misincorporation patterns, it allows for the detection of tRNA modifications that typically interfere with reverse transcription. This skill is essential for researchers working on translational regulation, tRNA biology, and epitranscriptomics who need to deconvolve complex tRNA clusters and quantify modification coordination.

## Installation and Setup
The tool is best managed via Conda/Mamba. Note that `usearch` is a required dependency that must be installed manually.

```bash
# Environment setup
mamba create -n mimseq python=3.7
mamba activate mimseq
mamba install -c conda-forge -c bioconda mimseq

# Manual usearch installation (required)
wget https://drive5.com/downloads/usearch10.0.240_i86linux32.gz
gunzip usearch10.0.240_i86linux32.gz
chmod +x usearch10.0.240_i86linux32
mv usearch10.0.240_i86linux32 usearch
export PATH=$PATH:/path/to/usearch_directory
```

## Common CLI Patterns

### Standard Analysis Pipeline
A typical run compares two conditions (e.g., Mutant vs Wildtype) and performs remapping to improve alignment accuracy.

```bash
mimseq --species Hsap \
    --cluster-id 0.97 \
    --threads 15 \
    --min-cov 0.0005 \
    --max-mismatches 0.075 \
    --control-condition ControlName \
    -n experiment_prefix \
    --out-dir output_directory \
    --max-multi 4 \
    --remap \
    --remap-mismatches 0.05 \
    sampleData.txt
```

### Advanced Modification Analysis (SLAC)
To analyze coordination between pairs of modifications or modification-aminoacylation crosstalk, append the `--crosstalks` flag.

```bash
mimseq --species Hsap --cluster-id 0.97 --threads 15 --crosstalks sampleData.txt
```

## Expert Tips and Best Practices
- **Input Formatting**: The `sampleData.txt` file is a tab-delimited file. Ensure it correctly maps your sample names to their respective trimmed FASTQ files and conditions.
- **Resource Allocation**: tRNA alignment and deconvolution are computationally intensive. Use the `--threads` argument to match your available CPU cores; 15+ threads are recommended for standard human datasets.
- **Clustering Threshold**: The `--cluster-id` (default often 0.97) determines how similar tRNA sequences must be to be grouped. Adjust this if working with non-standard genomes or highly divergent tRNA isodecoders.
- **Remapping**: Always use `--remap` for higher sensitivity in modification detection. This second pass helps resolve reads that initially failed alignment due to high modification density.
- **Version Check**: If using Mamba, verify the version with `mimseq --version`. If an outdated version is installed, force the update using `mamba install mimseq=1.3.11`.

## Reference documentation
- [mim-tRNAseq GitHub Repository](./references/github_com_nedialkova-lab_mim-tRNAseq.md)
- [Bioconda mimseq Package](./references/anaconda_org_channels_bioconda_packages_mimseq_overview.md)