---
name: refseq_masher
description: refseq_masher searches nucleotide sequences against the NCBI RefSeq database using Mash MinHash to provide taxonomic classifications. Use when user asks to find the closest matching reference genomes for an isolate, detect the presence of specific genomes in metagenomic samples, or screen sequences for contamination.
homepage: https://github.com/phac-nml/refseq_masher
metadata:
  docker_image: "quay.io/biocontainers/refseq-plasmid-dl:0.1.0--pyhdfd78af_0"
---

# refseq_masher

## Overview

`refseq_masher` is a bioinformatics tool that leverages Mash MinHash to rapidly search nucleotide sequences against a curated database of over 50,000 NCBI RefSeq genomes. Unlike raw Mash outputs, this tool automatically merges search results with NCBI taxonomic information, providing a comprehensive table that includes species, genus, and strain-level classifications. It is particularly effective for high-throughput taxonomic screening where traditional alignment-based methods (like BLAST) would be too computationally expensive.

## Command Line Usage

The tool provides two primary subcommands based on the nature of the input data: `matches` and `contains`.

### Finding Closest Matches (Isolates)
Use the `matches` command when you have a relatively pure sample (e.g., a sequenced isolate) and want to find the most similar reference genomes.

```bash
# Basic search for a single FASTA/FASTQ file
refseq_masher matches input_sequence.fasta

# Search multiple files and output to a CSV
refseq_masher matches -o results.csv --output-type csv sample1.fastq.gz sample2.fastq.gz

# Limit results to the top 3 matches to reduce noise
refseq_masher matches -n 3 isolate_genomic.fna
```

### Detecting Containment (Metagenomics/Contamination)
Use the `contains` command for metagenomic samples or to check if specific genomes are present within a larger, potentially mixed, sequence set. This uses `mash screen` logic.

```bash
# Screen a metagenomic sample for RefSeq genome containment
refseq_masher contains metagenome_reads.fastq.gz
```

## Expert Tips and Best Practices

*   **Noise Filtering**: When working with raw sequencing reads, use the `-m` (minimum k-mer threshold) option to filter out low-abundance k-mers that likely represent sequencing errors. The default is 8.
    *   `refseq_masher matches -m 10 reads.fastq`
*   **Verbosity for Debugging**: If a search is taking longer than expected or you want to see the Mash sketch creation progress, use the `-vv` or `-vvv` flags.
*   **Interpreting Results**:
    *   **Distance**: A distance of `0.0` indicates a perfect match. Values closer to `0.0` represent higher genomic similarity.
    *   **Matching**: This column (e.g., `400/400`) shows how many MinHash sketches from the query matched the reference.
*   **Input Flexibility**: The tool accepts FASTA and FASTQ formats, and files can be gzipped (`.gz`). You can also pass entire directories as input.
*   **Output Handling**: By default, results are printed to `stdout`. Use the `-o` flag to save to a file, which is recommended for large-scale screenings to avoid terminal overflow.

## Reference documentation
- [RefSeq Masher GitHub Repository](./references/github_com_phac-nml_refseq_masher.md)
- [RefSeq Masher Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_refseq_masher_overview.md)