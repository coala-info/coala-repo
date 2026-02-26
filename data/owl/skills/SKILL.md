---
name: owl
description: Owl detects microsatellite instability in high-fidelity long-read sequencing data by analyzing repeat length variation across haplotypes. Use when user asks to detect microsatellite instability, profile repeats from phased BAM files, or calculate MSI scores.
homepage: https://github.com/PacificBiosciences/owl
---


# owl

## Overview
`owl` is a specialized bioinformatics tool developed by Pacific Biosciences for detecting microsatellite instability (MSI) in high-fidelity (HiFi) long-read sequencing data. It analyzes the coefficient of variation (CV) in repeat lengths across haplotypes to determine stability. The tool is essential for cancer genomics workflows where MSI is a key biomarker.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::owl
```

## Core Workflow
The analysis consists of two primary steps: profiling the repeats and then scoring the results.

### 1. Profile Repeats
Generate a profile of microsatellite repeats from a phased BAM file.
```bash
owl profile --bam input.haplotagged.bam --regions markers.bed.gz --sample sample_name > sample.results.txt
```
**Best Practice**: Ensure reads are phased (using tools like HiPhase or WhatsHap) before profiling. Un-phased data will lead to falsely elevated MSI levels.

### 2. Summarize and Score
Calculate the MSI score based on the profile generated in the previous step.
```bash
owl score --file sample.results.txt --prefix output_prefix
```

## Output Interpretation
The scoring step produces two primary files:
- `{prefix}.owl-scores.txt`: Contains the summary MSI score per sample.
- `{prefix}.owl-motif-counts.txt`: Breaks down the scores by specific repeat motifs.

### Key Metrics
- **%high**: The proportion of loci with a high coefficient of variation. This is the primary MSI metric.
- **%passing**: The percentage of sites with reliable measurements.
- **qc**: A "pass" or "fail" label based on data completeness.

## Expert Tips
- **Phasing Requirement**: While the tool will run on un-phased data, it will issue a warning. Always use phased data for publication-quality results.
- **Marker Selection**: Use the standard markers provided in the `data/` directory of the repository (e.g., `GRCh38_owl_markers.bed.gz`) for human genomic analysis.
- **Compressed Inputs**: The tool supports `bgzip` compressed BED files for the `--regions` parameter.

## Reference documentation
- [Owl GitHub Repository](./references/github_com_PacificBiosciences_owl.md)
- [Bioconda Owl Overview](./references/anaconda_org_channels_bioconda_packages_owl_overview.md)