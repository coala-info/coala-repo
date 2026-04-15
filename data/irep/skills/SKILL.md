---
name: irep
description: The irep tool calculates bacterial replication rates by measuring genome copy number variation from metagenomic data. Use when user asks to measure microbial replication rates, analyze draft or complete genomes for growth activity, or calculate peak-to-trough ratios and GC skew.
homepage: https://github.com/christophertbrown/iRep
metadata:
  docker_image: "quay.io/biocontainers/irep:1.1.7--pyh24bf2e0_1"
---

# irep

## Overview
The `irep` skill enables the calculation of bacterial replication rates by measuring population genome copy number variation. In a growing population, DNA closer to the origin of replication is more abundant than DNA near the terminus; this tool quantifies that gradient. Use this skill when analyzing microbial communities to determine which organisms are actively replicating. It supports high-quality draft genomes (via `iRep`) and complete, closed genomes (via `bPTR`).

## Installation
The tool is available via Bioconda or pip:
```bash
conda install -c bioconda irep
# OR
pip install iRep
```

## Core Workflows

### 1. Measuring Replication in Draft Genomes (iRep)
Use the `iRep` command for draft-quality genomes.
*   **Requirements**: >=75% completeness, <=175 fragments/Mbp, and <=2% contamination.
*   **Input**: FASTA files of genomes and SAM files of reads mapped to those genomes.

```bash
# Basic usage with single genome and SAM file
iRep -f genome.fna -s mapping.sam -o output.iRep

# Analyzing multiple genomes against a mapping
iRep -f genome1.fna genome2.fna -s sample_data/*.sam -o results.iRep
```

### 2. Measuring Replication in Complete Genomes (bPTR)
Use `bPTR` for closed, circular genomes. This method is based on the peak-to-trough ratio.

```bash
bPTR -f complete_genome.fna -s mapping.sam -o results.bPTR.tsv -plot results.bPTR.pdf
```

### 3. Calculating GC Skew
To identify the origin and terminus of replication in complete genomes:

```bash
gc_skew.py -f genome.fna
```

## Expert Tips and Best Practices

### Input Preparation
*   **SAM File Ordering**: Both `iRep` and `bPTR` require ordered SAM files to correctly filter reads by mapping quality. Use the `--reorder` flag in Bowtie2 during mapping. If the SAM is already generated and unordered, use the `--sort` option within iRep.
*   **Scaffold Length**: `iRep` only utilizes scaffolds ≥5 Kbp. Ensure your genome completeness estimates are calculated based on scaffolds passing this threshold.
*   **Mapping Quality**: Always use a mapping quality cutoff (e.g., `-mm` option) to prevent off-target read mapping from confounding results.

### Troubleshooting Common Issues
*   **Tkinter Errors**: If you encounter `ImportError: No module named '_tkinter'`, set the Matplotlib backend to non-interactive mode:
    ```bash
    export MPLBACKEND="agg"
    ```
*   **Performance**: Large SAM files containing many unmapped reads significantly slow down execution. Filter unmapped reads using `shrinksam` or `samtools` before running iRep.
*   **N/A Values**: If results return "n.a.", it often indicates the genome did not meet the quality thresholds (min coverage = 5, min windows = 0.98, min r^2 = 0.9) or there is insufficient coverage to determine a replication trend.

### Filtering Results
Use `iRep_filter.py` to aggregate or clean up output files after multiple runs.

## Reference documentation
- [iRep GitHub Repository](./references/github_com_christophertbrown_iRep.md)
- [Bioconda iRep Package](./references/anaconda_org_channels_bioconda_packages_irep_overview.md)