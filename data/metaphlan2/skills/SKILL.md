---
name: metaphlan2
description: MetaPhlAn2 is a computational pipeline for profiling the relative abundance of microbial populations from metagenomic samples.
homepage: https://bitbucket.org/biobakery/metaphlan2
---

# metaphlan2

## Overview
MetaPhlAn2 is a computational pipeline for profiling the relative abundance of microbial populations from metagenomic samples. It utilizes a set of clade-specific marker genes to provide fast and accurate taxonomic assignments. This skill helps in configuring the tool for standard profiling, strain identification, and comparative metagenomics.

## Common CLI Patterns

### Basic Taxonomic Profiling
To generate a taxonomic profile from a single metagenomic fastq file:
```bash
metaphlan2.py input.fastq --input_type fastq > abundance_profile.txt
```

### Processing Multiple Samples
For faster processing of multiple files, use the bowtie2 output to avoid re-mapping:
```bash
# Step 1: Generate bowtie2 output
metaphlan2.py sample.fastq --input_type fastq --bowtie2out sample.bowtie2.bz2 --nproc 4 > abundance_profile.txt

# Step 2: Re-run profiling using the intermediate file (much faster)
metaphlan2.py sample.bowtie2.bz2 --input_type bowtie2out > abundance_profile_refined.txt
```

### Strain Tracking and Marker Analysis
To output the presence/absence of specific markers for strain-level analysis:
```bash
metaphlan2.py input.fastq --input_type fastq --sample_id MySample -t marker_pres_table > marker_presence.txt
```

## Expert Tips
- **Database Management**: Ensure the `mpa_dir` points to the directory containing the MetaPhlAn2 database files if they are not in the default path.
- **Merged Abundance**: When comparing multiple samples, use the `merge_metaphlan_tables.py` utility script to combine individual output files into a single matrix for downstream statistical analysis.
- **Sensitivity**: Use the `--stat_q` parameter to adjust the quantile value for the confidence of the abundance estimation (default is 0.1).
- **Read Length**: MetaPhlAn2 is optimized for reads >70bp. For shorter reads, false positive rates may increase.

## Reference documentation
- [Metaphlan2 Overview](./references/anaconda_org_channels_bioconda_packages_metaphlan2_overview.md)