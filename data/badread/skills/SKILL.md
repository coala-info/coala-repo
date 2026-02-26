---
name: badread
description: "Badread simulates long-read sequencing data with fine-grained control over error profiles and structural artifacts. Use when user asks to generate synthetic Oxford Nanopore or PacBio reads, stress-test bioinformatics pipelines with imperfect data, or simulate sequencing artifacts like chimeras and junk reads."
homepage: https://github.com/rrwick/Badread
---


# badread

## Overview
Badread is a long-read simulation tool designed to generate "imperfect" data. Unlike simulators that aim for perfect realism, Badread provides fine-grained control over the types and frequencies of errors. This makes it an essential tool for stress-testing bioinformatics pipelines against the messy realities of long-read sequencing, such as adapter contamination, varying read identities, and structural artifacts.

## Command Line Usage

The primary command is `badread simulate`. Output is written to stdout in FASTQ format.

### Basic Simulation
Generate 50x coverage of a reference using default settings (mimics mediocre Oxford Nanopore R10.4.1 reads):
```bash
badread simulate --reference ref.fasta --quantity 50x > reads.fastq
```

### Simulating Specific Technologies
*   **Oxford Nanopore (R9.4.1 style):**
    ```bash
    badread simulate --reference ref.fasta --quantity 50x --error_model nanopore2020 --qscore_model nanopore2020 --identity 90,98,5
    ```
*   **PacBio HiFi:**
    ```bash
    badread simulate --reference ref.fasta --quantity 50x --error_model pacbio2021 --qscore_model pacbio2021 --identity 30,3
    ```
*   **Ideal/Perfect Reads:**
    ```bash
    badread simulate --reference ref.fasta --quantity 50x --error_model random --qscore_model ideal --glitches 0,0,0 --junk_reads 0 --random_reads 0 --chimeras 0 --identity 30,3 --length 40000,20000
    ```

## Parameter Tuning

### Quantity (`--quantity`)
Accepts absolute values (e.g., `1000000` or `1M` for 1 million bases) or relative depth (e.g., `25x`).

### Read Identity (`--identity`)
Controls the accuracy of the reads. It typically takes three values: `mean, max, stdev`.
*   Example: `--identity 85,95,5` (Mean 85%, Max 95%, SD 5%).
*   For high-accuracy reads (like HiFi), use two values: `mean, stdev` (e.g., `--identity 99,1`).

### Fragment Length (`--length`)
Controls the read length distribution using `mean, stdev`.
*   Example: `--length 15000,10000`

### Artifacts and Noise
*   **--junk_reads**: Percentage of reads that are low-complexity junk (default: 1%).
*   **--random_reads**: Percentage of reads that are completely random sequences (default: 1%).
*   **--chimeras**: Percentage of reads that are chimeric (joined fragments) (default: 1%).
*   **--glitches**: Frequency and size of sequencing glitches (e.g., `1000,100,100` for frequent, large glitches).

## Expert Tips
*   **Pipe to Gzip**: Badread outputs uncompressed FASTQ. Always pipe to gzip for large simulations: `badread simulate ... | gzip > reads.fastq.gz`.
*   **Parallelization**: Badread is single-threaded and can be slow because it performs periodic alignments to ensure identity precision. To speed up large datasets, run multiple instances of Badread with different `--seed` values and concatenate the outputs.
*   **Small Plasmid Bias**: Use the `--small_plasmid_bias` flag if your reference contains small circular sequences that are over-represented in real library preps.

## Reference documentation
- [Badread GitHub Repository](./references/github_com_rrwick_Badread.md)
- [Badread Wiki](./references/github_com_rrwick_Badread_wiki.md)