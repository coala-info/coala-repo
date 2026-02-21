---
name: tatajuba
description: Tatajuba is a specialized bioinformatics tool designed to explore the heterogeneity of homopolymeric tracts within sequencing data.
homepage: https://github.com/quadram-institute-bioscience/tatajuba
---

# tatajuba

## Overview
Tatajuba is a specialized bioinformatics tool designed to explore the heterogeneity of homopolymeric tracts within sequencing data. Unlike tools that assume a fixed length for a given tract, tatajuba captures the full distribution of lengths. This is particularly useful for studying phase variation in microbial populations or distinguishing true biological variation from common sequencing artifacts. It identifies tracts based on specific flanking sequences and provides mechanisms to minimize strand bias by comparing forward and reverse reads.

## Common CLI Patterns and Usage

### Basic Execution
The primary way to interact with tatajuba is through the command line. To see all available options and parameters:
```bash
tatajuba --help
```

### Core Workflow
Tatajuba typically requires input reads (often in FASTQ format) and a reference or set of target flanking sequences to define the tracts of interest.

1.  **Identification**: The tool scans reads for homopolymeric bases flanked by user-defined sequences.
2.  **Distribution Analysis**: Instead of reporting a single consensus length, it outputs the frequency of different observed lengths.
3.  **Filtering**: Use built-in options to discard tracts that do not appear in both forward and reverse reads to reduce false positives caused by strand bias.

### Output Files
The tool generates tabular data for downstream analysis:
*   `tract_list.tsv`: A tab-separated file containing the identified tracts and their length distributions across samples.
*   **VCF Output**: Recent versions support generating VCF files for integration with standard genomic pipelines, though users should verify if the output is directed to `traits_list.tsv` or a standard `.vcf` file depending on the specific version (v1.0.4+).

## Expert Tips and Best Practices

### Handling Sequencing Uncertainty
Because sequencing errors (especially in technologies like Oxford Nanopore or Ion Torrent) are frequent within homopolymers, do not pre-process or "clean" the reads in a way that collapses these distributions before running tatajuba. Let the tool analyze the raw distribution to better distinguish signal from noise.

### Defining Flanking Sequences
The accuracy of tract identification depends heavily on the uniqueness of the flanking sequences. Ensure that the sequences provided to define the "start" and "end" of a tract are long enough to be specific within the genome of interest.

### Version Considerations
*   **v1.0.4 (Conda/Container)**: The most stable distributed version.
*   **v1.0.5 (Source)**: Includes improved warnings when no homopolymeric tracts (HTs) are found and better handling for single-sample runs. If your analysis involves a single sample, consider compiling from source for better feedback, though results are most robust when comparing multiple samples.

### Performance and Memory
When working with very large datasets, monitor memory usage. The tool relies on the `biomcmc-lib` and a modified version of `BWA` for internal processing. If memory is a constraint, consider sub-sampling reads if the depth is excessively high, as the distribution of HTs often stabilizes at moderate coverage.

## Reference documentation
- [github_com_quadram-institute-bioscience_tatajuba.md](./references/github_com_quadram-institute-bioscience_tatajuba.md)
- [anaconda_org_channels_bioconda_packages_tatajuba_overview.md](./references/anaconda_org_channels_bioconda_packages_tatajuba_overview.md)