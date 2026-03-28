---
name: metaphlan2
description: MetaPhlAn2 performs taxonomic profiling of microbial communities from metagenomic shotgun sequencing data. Use when user asks to profile metagenomic samples, generate taxonomic abundance tables, or merge multiple profiling results into a single matrix.
homepage: https://bitbucket.org/biobakery/metaphlan2
---


# metaphlan2

## Overview
MetaPhlAn2 (Metagenomic Phylogenetic Analysis) is a computational tool designed to profile the composition of microbial communities from metagenomic samples. It maps DNA reads against a pre-computed database of unique marker genes to provide fast, accurate, and species-level taxonomic quantification. This skill provides the necessary command-line patterns to process raw sequencing files into abundance tables.

## Common CLI Patterns

### Basic Taxonomic Profiling
To profile a single metagenomic sample (fastq or fastq.gz):
```bash
metaphlan2.py input_file.fastq --input_type fastq > abundance_table.txt
```

### Processing Multiple Samples
For paired-end reads, it is recommended to concatenate them or provide them as a comma-separated list:
```bash
metaphlan2.py forward.fastq,reverse.fastq --input_type fastq --nproc 4 > merged_abundance.txt
```

### Generating Bowtie2 Outputs
To save the intermediate mapping file for re-analysis or different formatting:
```bash
metaphlan2.py input.fastq --bowtie2out sample.bowtie2.bz2 --nproc 8 > abundance.txt
```

### Profiling from Pre-computed Bowtie2 Results
If you already have the `.bowtie2.bz2` file, you can regenerate the abundance table quickly without re-mapping:
```bash
metaphlan2.py sample.bowtie2.bz2 --input_type bowtie2out > abundance.txt
```

## Expert Tips & Best Practices

- **Taxonomic Resolution**: By default, MetaPhlAn2 provides all taxonomic levels. Use the `-t` or `--analysis_type` flag to specify a different output (e.g., `rel_ab` for relative abundance, `clade_profiles` for marker-level details).
- **Merging Results**: When processing multiple samples in a project, use the utility script `merge_metaphlan_tables.py` to combine individual output files into a single large matrix for downstream statistical analysis.
- **Sensitivity**: If dealing with low-biomass samples or looking for rare taxa, consider adjusting the `--stat_q` parameter (default is 0.1) to change the quantile used for the clade-level abundance calculation.
- **Database Path**: Ensure the `--bt2_ps` parameter points to the correct location of the MetaPhlAn2 marker database if it is not in the default system path.



## Subcommands

| Command | Description |
|---------|-------------|
| merge_metaphlan_tables.py | Performs a table join on one or more metaphlan output files. |
| metaphlan2.py | METAgenomic PHyLogenetic ANalysis for metagenomic taxonomic profiling. |

## Reference documentation
- [MetaPhlAn2 Overview](./references/anaconda_org_channels_bioconda_packages_metaphlan2_overview.md)