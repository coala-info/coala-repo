---
name: fastq-screen
description: FastQ Screen is a diagnostic tool used to assess the composition of a sequencing library.
homepage: https://www.bioinformatics.babraham.ac.uk/projects/fastq_screen
---

# fastq-screen

## Overview

FastQ Screen is a diagnostic tool used to assess the composition of a sequencing library. It works by mapping a subset of reads against a user-defined panel of reference genomes and reporting the percentage of reads that map uniquely or to multiple genomes. This is essential for identifying contamination (such as Mycoplasma or laboratory vectors) and ensuring that the sequencing results align with the expected biological source.

## Core CLI Usage

The basic syntax for running FastQ Screen is:
`fastq_screen [options] [fastq_files]`

### Common Command Patterns

*   **Standard QC Run**: Processes a subset of reads (default 100,000) to provide a quick overview of library composition.
    `fastq_screen --outdir results/ sample.fastq.gz`
*   **Full File Processing**: Use for comprehensive filtering or when precise counts are required.
    `fastq_screen --subset 0 sample.fastq.gz`
*   **Filtering for Contaminants**: Use the `--tag` and `--filter` options to create a new FastQ file containing only reads that do not map to any of the screened databases (e.g., removing all known genomes).
    `fastq_screen --tag --filter 0000 sample.fastq.gz`
    *(Note: The number of zeros in the filter must match the number of databases in your config file.)*
*   **Bisulfite Sequencing**: Enable specific mapping for epigenetic studies.
    `fastq_screen --bisulfite sample.fastq.gz`

### Performance and Optimization

*   **Multithreading**: Speed up the alignment process by specifying multiple cores.
    `fastq_screen --threads 8 sample.fastq.gz`
*   **Processing Speed**: Use the `--top` option to limit the number of reads processed even further when speed is the highest priority.
*   **Aligner Selection**: While Bowtie2 is the default, you can specify others if your indices are built differently.
    `fastq_screen --aligner bwa sample.fastq.gz`

### Configuration and Setup

*   **Database Management**: Use `--get_genomes` to download a pre-configured set of common contaminant and model organism genomes.
*   **Custom Config**: If not using the default location, specify your configuration file.
    `fastq_screen --conf custom_screen.conf sample.fastq.gz`

## Expert Tips

*   **Subset Default**: Remember that FastQ Screen defaults to `--subset 100000`. This is usually sufficient for QC, but if you are using the tool to filter reads for downstream analysis, you must set `--subset 0`.
*   **Output Interpretation**: The tool generates an HTML report with Plotly graphs. Look for "One hit, one library" for your target organism and "No hits" for the remainder. High percentages in "Multiple hits, multiple libraries" often indicate common adapter contamination or highly conserved sequences.
*   **Directory Creation**: Use `--outdir`. FastQ Screen will automatically create the directory if it does not exist, preventing errors in automated pipelines.
*   **Overwriting Results**: Use `--force` if you need to re-run an analysis and overwrite existing output files in the same directory.

## Reference documentation
- [FastQ Screen Project Home](./references/www_bioinformatics_babraham_ac_uk_projects_fastq_screen.md)
- [FastQ Screen Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fastq-screen_overview.md)