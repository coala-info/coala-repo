---
name: endorspy
description: endorspy calculates sequencing metrics such as endogenous DNA percentage, clonality, and duplication rates by analyzing samtools flagstat outputs. Use when user asks to calculate endogenous DNA content, determine library complexity, or generate MultiQC-compatible sequencing metrics from flagstat files.
homepage: https://github.com/aidaanva/endorS.py
metadata:
  docker_image: "quay.io/biocontainers/endorspy:1.4--hdfd78af_0"
---

# endorspy

## Overview
The `endorspy` skill enables the calculation of key sequencing metrics by comparing different stages of a bioinformatics pipeline. By analyzing `samtools flagstat` outputs from raw, quality-filtered, and deduplicated BAM files, the tool determines the proportion of "on-target" (endogenous) DNA versus environmental or laboratory contamination. It also provides insights into library complexity through clonality and duplication rate calculations.

## CLI Usage and Patterns

### Basic Endogenous DNA Calculation
To calculate the percentage of endogenous DNA from a single flagstat file (assuming no filtering has been performed):
```bash
python endorS.py --raw sample_raw.stats
```

### Comprehensive Metric Calculation
To calculate endogenous DNA, clonality, and duplication metrics simultaneously, provide the flagstat files for each processing stage:
```bash
python endorS.py --raw sample_raw.stats --qualityfiltered sample_q30.stats --deduplicated sample_dedup.stats
```

### MultiQC Integration
For large-scale projects, export the results in JSON format compatible with MultiQC for aggregate reporting:
```bash
python endorS.py -r sample_raw.stats -q sample_q30.stats -d sample_dedup.stats --output json --name Sample_A1
```

## Expert Tips and Best Practices

- **Input Requirements**: The tool specifically parses the text output of `samtools flagstat`. Ensure your input files are generated using `samtools flagstat input.bam > output.stats`.
- **Flag Combinations**: 
    - Providing only `--raw` calculates endogenous DNA based on total reads.
    - Providing `--qualityfiltered` requires at least one other flag (`--raw` or `--deduplicated`) to calculate relative percentages.
    - Providing `--deduplicated` alongside a non-deduplicated file allows the tool to calculate the **Cluster Factor** (Mapped Reads / Unique Mapped Reads).
- **Zero-Read Handling**: The tool includes logic to handle samples with zero reads or zero mapped reads, returning 0% and a warning rather than crashing, which is common in low-template DNA samples.
- **Naming**: Use the `--name` flag to ensure that MultiQC reports or screen outputs use your internal sample IDs rather than the filename of the first stats file provided.

## Reference documentation
- [github_com_aidaanva_endorS.py.md](./references/github_com_aidaanva_endorS.py.md)
- [anaconda_org_channels_bioconda_packages_endorspy_overview.md](./references/anaconda_org_channels_bioconda_packages_endorspy_overview.md)