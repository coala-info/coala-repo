---
name: rock
description: ROCK reduces over-covering k-mers in sequencing data for improved genome assembly. Use when user asks to reduce over-covering k-mers, prepare k-mer counts for genome assembly, or analyze k-mer coverage distributions.
homepage: https://gitlab.pasteur.fr/vlegrand/ROCK
---


# rock

yaml
name: rock
description: |
  ROCK (Reducing Over-Covering K-mers) is a bioinformatics tool used for
  genome assembly and analysis. Use this skill when you need to:
  - Reduce over-covering k-mers in sequencing data.
  - Prepare k-mer counts for genome assembly pipelines.
  - Analyze k-mer coverage distributions.
  - Work with large genomic datasets where k-mer analysis is crucial.
```
## Overview
ROCK is a bioinformatics tool designed to address the issue of over-covering k-mers in sequencing data, which can be problematic for genome assembly. It helps in reducing these redundant k-mers, thereby improving the quality and efficiency of downstream assembly processes. This skill is useful when you are working with raw sequencing reads and need to preprocess them for assembly, or when you need to analyze k-mer coverage statistics.

## Usage Instructions

ROCK is a command-line tool. The primary command is `rock`.

### Basic Usage

The most common use case involves providing input FASTQ files and specifying an output directory.

```bash
rock -i input1.fastq.gz input2.fastq.gz -o output_directory
```

### Key Options

*   **`-i` or `--input`**: Specify one or more input FASTQ files (gzipped or uncompressed).
*   **`-o` or `--output`**: Specify the directory where ROCK will store its output files.
*   **`-k` or `--kmer-size`**: The size of the k-mers to consider. Default is 21.
*   **`--PE-separated`**: Process paired-end reads separately. This can be useful for certain assembly strategies.
*   **`--low`**: Filter out k-mers with coverage below a specified threshold. This helps in removing low-frequency k-mers that might be errors.
*   **`--high`**: Filter out k-mers with coverage above a specified threshold. This is the core functionality for reducing over-coverage.
*   **`--min-useful-read-length`**: Minimum read length to consider for k-mer extraction.
*   **`--max-useful-read-length`**: Maximum read length to consider for k-mer extraction.

### Example Workflows

1.  **Reducing over-coverage with default k-mer size:**

    ```bash
    rock -i reads_R1.fastq.gz reads_R2.fastq.gz -o rock_output
    ```

2.  **Using a specific k-mer size and filtering low-coverage k-mers:**

    ```bash
    rock -k 31 -i genome_reads.fq -o rock_filtered --low 2
    ```

3.  **Processing paired-end reads separately and setting maximum useful read length:**

    ```bash
    rock -i PE_reads_1.fastq.gz PE_reads_2.fastq.gz -o rock_pe_sep --PE-separated --max-useful-read-length 150
    ```

### Expert Tips

*   **Understand your data:** The optimal k-mer size (`-k`) depends on your genome size and sequencing depth. Experiment with different values if unsure.
*   **Iterative filtering:** For very high coverage data, you might consider running ROCK multiple times with adjusted `--high` values or using `--low` to clean up noise before aggressive over-coverage reduction.
*   **Output files:** ROCK typically generates files related to k-mer counts and filtered k-mer lists. Familiarize yourself with these outputs for downstream use in assemblers like SPAdes or MEGAHIT.
*   **Memory considerations:** Processing large FASTQ files can be memory-intensive. Ensure your system has sufficient RAM, especially when using larger k-mer sizes or high coverage data. The `make check` failures related to memory in the commit history suggest this is a critical factor.

## Reference documentation
- [ROCK - Reducing Over-Covering K-mers](./references/gitlab_pasteur_fr_vlegrand_ROCK.md)
- [ROCK installation and overview](./references/anaconda_org_channels_bioconda_packages_rock_overview.md)