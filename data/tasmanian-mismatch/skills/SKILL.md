---
name: tasmanian-mismatch
description: Tasmanian-mismatch identifies and categorizes systematic reference mismatches and sequencing artifacts in DNA sequencing data. Use when user asks to identify systematic artifacts, evaluate mismatch rates in specific genomic regions, or perform positional analysis of sequencing errors across reads.
homepage: https://github.com/nebiolabs/tasmanian-mismatch
---


# tasmanian-mismatch

## Overview
Tasmanian is a specialized diagnostic toolset designed to identify and categorize reference mismatches in DNA sequencing data. Unlike standard variant callers, it focuses on identifying systematic artifacts that can confound SNP analysis. It is particularly effective at evaluating how specific genomic regions (such as repeats) influence mismatch rates. The tool classifies every base in a read based on its overlap with regions of interest and provides a positional analysis of artifacts across Read 1 and Read 2.

## Installation
The tool can be installed via Bioconda or Pip:
```bash
# Via Conda
conda install -c bioconda tasmanian-mismatch

# Via Pip
pip install tasmanian-mismatch
```

## Common CLI Patterns

### Basic Analysis Pipeline
The standard workflow involves piping SAM data through the intersection engine into the main Tasmanian analyzer.
```bash
samtools view -h input.bam | run_intersections --bed regions.bed | run_tasmanian --outdir results/
```

### Analyzing Specific Regions
To evaluate how repetitive elements or specific genomic features affect your mismatch profile, provide a BED or bedGraph file to `run_intersections`.
- **Overlapping bases**: Classified as "contained" or "boundary".
- **Non-overlapping bases**: Analyzed as the baseline control.

### Positional Artifact Detection
Tasmanian automatically splits analysis by Read 1 and Read 2. This is essential for identifying:
- Cycle-dependent sequencing errors (errors increasing toward the end of a read).
- Strand-specific artifacts.
- Systematic mismatches that appear only in specific genomic contexts.

## Expert Tips and Best Practices
- **Header Preservation**: When using `samtools view`, ensure you include the header (`-h`) if the downstream tools require it for coordinate processing.
- **Region Selection**: Use this tool specifically when you suspect that "variants" in your call set are actually localized artifacts caused by mapping issues in repetitive regions.
- **Output Interpretation**: Tasmanian produces tables and a built-in HTML report. Use the tables for custom plotting in R or Python and the HTML report for a rapid overview of artifact distribution.
- **Systematic Error Filtering**: If a mismatch is consistently associated with a specific position in the read across many different genomic locations, it is likely a sequencing artifact rather than a biological variant.

## Reference documentation
- [Tasmanian GitHub Repository](./references/github_com_nebiolabs_tasmanian-mismatch.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_tasmanian-mismatch_overview.md)