---
name: arcsv
description: ArcSV is a bioinformatics pipeline designed to detect structural variants in archaic human genomes by accounting for the unique properties of ancient DNA. Use when user asks to install ArcSV via Conda, prepare reference genomes, or execute the pipeline for structural variant discovery in high-quality archaic samples.
homepage: https://github.com/xuxif/ArcSV
---


# arcsv

## Overview
ArcSV is a specialized bioinformatics pipeline designed specifically for the challenges of archaic human genomics. It addresses the unique properties of ancient DNA—such as fragmentation, low coverage, and post-mortem damage—to accurately detect structural variants. Use this skill to navigate the installation via Conda and execute the pipeline for SV discovery in high-quality archaic genomes (e.g., Neanderthal or Denisovan samples).

## Installation
The recommended method for installing ArcSV is through the Bioconda channel. Ensure you have a Conda-based package manager (Conda or Mamba) configured.

```bash
conda install -c bioconda arcsv
```

## Usage Patterns
ArcSV typically operates as a multi-stage pipeline. While specific subcommands depend on the version, the general workflow involves:

1.  **Reference Preparation**: Indexing the reference genome (usually hg19 or GRCh37 for archaic studies).
2.  **Data Preprocessing**: Ensuring input BAM files are sorted and indexed.
3.  **SV Calling**: Running the core `arcsv` command to identify deletions, duplications, inversions, and insertions.

### Common CLI Arguments
*   `--input`: Path to the coordinate-sorted BAM file.
*   `--reference`: Path to the reference FASTA file.
*   `--outdir`: Directory for output VCFs and intermediate files.
*   `--min-support`: Minimum number of reads required to support a variant call (crucial for low-coverage ancient samples).

## Best Practices
*   **Coverage Awareness**: For archaic samples with low coverage, adjust the sensitivity parameters to avoid high false-negative rates, though this may increase false positives.
*   **Reference Consistency**: Always use the same reference genome version that was used for the initial read mapping to prevent coordinate shifts.
*   **Filter Post-Processing**: Use the quality scores provided in the output VCF to filter variants, especially in regions known for high mapping ambiguity (e.g., centromeres or telomeres).

## Reference documentation
- [ArcSV Overview](./references/anaconda_org_channels_bioconda_packages_arcsv_overview.md)