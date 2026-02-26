---
name: skesa
description: "skesa performs de novo sequence assembly using strategic kmer extension. Use when user asks to assemble genomes from sequencing reads."
homepage: https://ftp.ncbi.nlm.nih.gov/pub/agarwala/skesa
---


# skesa

skesa/
├── SKILL.md
└── references/
    ├── anaconda_org_channels_bioconda_packages_skesa_overview.md
    ├── ftp_ncbi_nlm_nih_gov_pub_agarwala_skesa.md
    ├── ftp_ncbi_nlm_nih_gov_pub_agarwala_skesa_datasets.md
    ├── ftp_ncbi_nlm_nih_gov_pub_agarwala_skesa_skesa.centos6.9.md
    └── ftp_ncbi_nlm_nih_gov_pub_agarwala_skesa_skesa.centos7.4.md
```
name: skesa
description: |
  A command-line tool for de novo sequence assembly using strategic kmer extension.
  Use when Claude needs to perform high-quality genome assembly from sequencing reads,
  especially for targeted enrichment data or when precise assembly is critical.
  This skill is suitable for tasks involving bacterial genomes, metagenomics, or
  any scenario requiring robust and accurate sequence reconstruction.

## Overview

skesa is a powerful tool designed for de novo sequence assembly, focusing on strategic kmer extension to achieve scrupulous assemblies. It is particularly effective when working with target enrichment data and aims to produce highly accurate genome reconstructions. Use skesa when you need to assemble genomes from sequencing reads, especially in research areas like microbial genomics, metagenomics, or when dealing with complex genomic regions where precision is paramount.

## Usage Instructions

skesa is a command-line tool. The primary command involves specifying input FASTA/FASTQ files and output directories.

### Basic Assembly

The most common usage involves providing one or more input read files and specifying an output directory.

```bash
skesa --reads <input_reads_1.fastq.gz>[,<input_reads_2.fastq.gz>...] --output <output_directory>
```

**Key Parameters:**

*   `--reads`: Comma-separated list of input read files (FASTQ or FASTA, gzipped or uncompressed). Can include paired-end reads.
*   `--output`: Directory where assembly results (contigs, assembly graph, etc.) will be saved.
*   `--contigs_out`: Specify a filename for the output contigs FASTA file. If not provided, a default name will be used within the output directory.
*   `--graph_out`: Specify a filename for the assembly graph output (e.g., GFA format).
*   `--kmer_size`: The kmer size to use for assembly. Defaults to 31. Larger values can improve accuracy for longer reads but increase memory usage.
*   `--threads`: Number of threads to use for computation.
*   `--memory_usage`: Maximum memory to use (e.g., `4G`, `8G`).

### Advanced Options

*   **Specifying Read Pairs:** If you have paired-end reads, list them separated by commas. skesa can infer pairing if files are named conventionally (e.g., `_1.fastq.gz`, `_2.fastq.gz`).

    ```bash
    skesa --reads read_pair1_R1.fastq.gz,read_pair1_R2.fastq.gz --output ./assembly_output
    ```

*   **Using a Reference Genome (for evaluation/comparison, not guided assembly):** While skesa is primarily for de novo assembly, it can be used with reference data for benchmarking or specific analyses.

    ```bash
    skesa --reads reads.fastq.gz --reference <reference.fasta> --output ./assembly_output
    ```
    *Note: The `--reference` flag is primarily for internal testing and benchmarking by the skesa developers. For guided assembly, other tools are more appropriate.*

*   **Contamination Filtering:** skesa has built-in capabilities to handle and potentially filter contamination. Refer to the official documentation for specific flags related to contamination.

### Expert Tips

*   **Input File Formats:** skesa supports both gzipped and uncompressed FASTA and FASTQ files. Ensure your input files are correctly formatted.
*   **Memory Management:** Genome assembly is memory-intensive. Monitor your system's memory and adjust the `--memory_usage` parameter accordingly. For large datasets, consider using a machine with ample RAM.
*   **Kmer Size Selection:** The default kmer size of 31 is a good starting point. For very long reads (e.g., PacBio HiFi, Oxford Nanopore), you might experiment with larger kmer sizes. For shorter reads, smaller kmer sizes might be necessary.
*   **Output Interpretation:** The output directory will contain several files, including contigs (in FASTA format), and potentially an assembly graph. Familiarize yourself with the skesa output formats to effectively use the results.
*   **Benchmarking:** The `datasets` directory mentioned in the documentation contains benchmark sets that can be useful for evaluating skesa's performance.

## Reference documentation
- [skesa Overview](./references/anaconda_org_channels_bioconda_packages_skesa_overview.md)
- [skesa FTP Index](./references/ftp_ncbi_nlm_nih_gov_pub_agarwala_skesa.md)
- [skesa Datasets Index](./references/ftp_ncbi_nlm_nih_gov_pub_agarwala_skesa_datasets.md)