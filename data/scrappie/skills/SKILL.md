---
name: scrappie
description: Scrappie is a technology demonstrator developed by the Oxford Nanopore Research Algorithms group.
homepage: https://github.com/nanoporetech/scrappie
---

# scrappie

## Overview

Scrappie is a technology demonstrator developed by the Oxford Nanopore Research Algorithms group. It serves as a specialized tool for basecalling nanopore sequencing data and simulating signal (squiggles) from known sequences. While it has been largely superseded by newer tools like Bonito, Scrappie remains relevant for research workflows requiring specific event-based calling or legacy model support (R9.4, R10).

## Command Line Usage

### Basecalling from Raw Signal
The `raw` subcommand is used to call sequences directly from the raw signal stored in .fast5 files.

```bash
# Call a directory of reads
scrappie raw path/to/reads/ > basecalls.fa

# Call specific files
scrappie raw read1.fast5 read2.fast5 > basecalls.fa

# Specify a specific model (e.g., R10)
scrappie raw --model rgrgr_r10 path/to/reads/ > basecalls.fa
```

### Basecalling from Events
The `events` subcommand performs basecalling based on pre-processed event data.

```bash
scrappie events path/to/reads/ > basecalls.fa
```

### Squiggle Simulation
The `squiggle` subcommand predicts the expected nanopore signal (squiggle) from a given FASTA sequence.

```bash
scrappie squiggle --model squiggle_r94 input.fasta > simulated_signal.txt
```

## Performance and Optimization

### Threading and Parallelization
Scrappie uses OpenMP for multi-processing. For optimal performance on multi-core systems:

1.  **System-wide threads**: Set `OMP_NUM_THREADS` to the number of available cores.
2.  **BLAS optimization**: Set `OPENBLAS_NUM_THREADS=1` to prevent thread contention between the application and the linear algebra library.
3.  **Internal threading**: Use the `-#` or `--threads` flag to specify how many reads to process in parallel.

```bash
export OMP_NUM_THREADS=$(nproc)
export OPENBLAS_NUM_THREADS=1
scrappie raw --threads 4 path/to/reads/ > basecalls.fa
```

### Large Scale Processing
For very large datasets, use `parallel` to manage multiple instances of Scrappie in single-threaded mode to maximize throughput:

```bash
find path/to/reads/ -name "*.fast5" | parallel -P ${OMP_NUM_THREADS} scrappie raw --threads 1 > basecalls.fa
```

## Common Options and Best Practices

*   **Output Formats**: Use `-f` or `--format` to toggle between `FASTA` (default) and `SAM`.
*   **Model Selection**: Always verify the chemistry of your flowcell. Available raw models include `raw_r94`, `rgrgr_r94`, `rgrgr_r941`, `rgrgr_r10`, and `rnnrf_r94`.
*   **Metadata Extraction**: To extract read metadata into a TSV format, pipe the output through the provided utility script:
    ```bash
    scrappie raw path/to/reads/ | grep '^>' | cut -d ' ' -f 2- | python3 misc/json_to_tsv.py > metadata.tsv
    ```
*   **Trimming**: Use `-t start:end` to trim a specific number of samples or events from the beginning and end of reads to remove adapters or low-quality signal.

## Reference documentation
- [Scrappie GitHub Repository](./references/github_com_nanoporetech_scrappie.md)
- [Scrappie Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_scrappie_overview.md)