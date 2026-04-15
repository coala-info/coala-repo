---
name: cenmap
description: CenMAP maps and characterizes centromeres in Telomere-to-Telomere genome assemblies by identifying alpha-satellite structures and generating visualization plots. Use when user asks to map centromeres, identify alpha-satellite HOR structures, validate assemblies with HiFi reads, or detect centromere dip regions using ONT methylation data.
homepage: https://github.com/logsdon-lab/CenMAP
metadata:
  docker_image: "quay.io/biocontainers/cenmap:1.2.0--h577a1d6_0"
---

# cenmap

## Overview
CenMAP is a specialized bioinformatics pipeline designed for the complex task of mapping and characterizing centromeres in Telomere-to-Telomere (T2T) genome assemblies. It automates the identification of alpha-satellite HOR structures, calculates array lengths, and generates visualization plots (ideograms and self-identity plots). It is particularly effective for human and non-human primate (NHP) samples and can integrate PacBio HiFi reads for validation and ONT reads for epigenetic profiling of centromere dip regions.

## Installation
Install via Bioconda:
```bash
conda install bioconda::cenmap
```

## Common CLI Patterns

### Basic Centromere Mapping
For standard human assembly analysis:
```bash
cenmap -i assembly.fa.gz -s SAMPLE_ID
```

### Primate Assembly Analysis
Use the `--mode nhp` flag for non-human primate samples (e.g., Chimpanzee, Gorilla):
```bash
cenmap -i assembly.fa.gz -s SAMPLE_ID --mode nhp
```

### Assembly Validation (NucFlag)
To validate the centromere assembly using PacBio HiFi reads:
```bash
cenmap -i assembly.fa.gz -s SAMPLE_ID --hifi reads.fq.gz
```

### Identifying Centromere Dip Regions (CDRs)
To determine CDRs using ONT reads (typically unaligned BAMs with 5mC modifications):
```bash
cenmap -i assembly.fa.gz -s SAMPLE_ID --ont methylation_calls.bam
```

### Full Analysis Pipeline
To run mapping, validation, and CDR detection simultaneously:
```bash
cenmap -i assembly.fa.gz -s SAMPLE_ID --hifi reads.fq.gz --ont methylation_calls.bam
```

## Expert Tips
- **Input Requirements**: CenMAP is optimized for high-quality assemblies produced by Verkko or hifiasm.
- **Sample Naming**: Ensure the `-s` (sample ID) matches the prefix used in your input files for consistent output naming.
- **Output Assets**: The pipeline generates several high-utility files:
    - `censtats`: HOR array lengths.
    - `cenplot`: Combined sequence identity and HOR structure plots.
    - `ModDotPlot`: Sequence identity visualizations.
- **Resource Management**: Since the pipeline is implemented in Snakemake, it can be computationally intensive; ensure your environment has sufficient memory for large-scale repeat masking and alignment tasks.

## Reference documentation
- [CenMAP GitHub Repository](./references/github_com_logsdon-lab_CenMAP.md)
- [CenMAP Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cenmap_overview.md)
- [CenMAP Wiki](./references/github_com_logsdon-lab_CenMAP_wiki.md)