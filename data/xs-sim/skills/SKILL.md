---
name: xs-sim
description: xs-sim generates synthetic FASTQ reads based on user-defined parameters for various sequencing technologies. Use when user asks to generate synthetic FASTQ reads, simulate Illumina, Ion Torrent, Roche-454, or ABI-SOLiD reads, define read length, set nucleotide frequencies, simulate repetitive DNA, or model quality scores.
homepage: https://github.com/pratas/xs
metadata:
  docker_image: "quay.io/biocontainers/xs-sim:2--hec16e2b_0"
---

# xs-sim

## Overview
The `xs-sim` tool (XS) is a specialized FASTQ read simulator designed for portability and flexibility. Unlike many simulators that require a reference sequence, XS generates reads based on user-defined nucleotide frequencies, sequence lengths, and quality score distributions. It supports major sequencing technologies including Illumina, Ion Torrent, Roche-454, and ABI-SOLiD. This skill provides guidance on configuring the command-line interface (CLI) to generate realistic synthetic datasets for benchmarking and tool development.

## Command Line Usage

The basic syntax for running the simulator is:
`./XS [parameters] [outFile]`

### Core Sequencing Configuration
Select the sequencing technology and read volume to define the basic structure of the FASTQ file:
- **Technology (-t):** 1=Roche-454 (default), 2=Illumina, 3=ABI SOLiD, 4=Ion Torrent.
- **Read Count (-n):** Specify the total number of reads to generate (e.g., `-n 1000000`).
- **Instrument Name (-i):** Set a custom instrument string in the header using `n=` (e.g., `-i n=HiSeq2500`).

### Read Length and Geometry
- **Static Length (-ls):** Use for fixed-length reads (e.g., `-ls 150` for standard Illumina).
- **Dynamic Length (-ld):** Use for technologies with variable read lengths like Ion Torrent or 454. Format is `min:max` (e.g., `-ld 30:450`).
- **Paired-End Headers (-hf 2):** Enables paired-end naming conventions in the headers (compatible with types 2 and 3).

### Sequence Complexity and DNA Options
Fine-tune the biological properties of the synthetic reads:
- **Nucleotide Frequency (-f):** Define the distribution of A,C,G,T,N. For human-like DNA, use `-f 0.29,0.19,0.19,0.29,0.04`.
- **Repeat Simulation:** Simulate transposable elements or repetitive regions using:
    - `-rn`: Number of repeat copies.
    - `-ri` / `-ra`: Minimum and maximum size of repeats.
    - `-rm`: Mutation rate within repeats (e.g., `0.01` for 1% divergence).
    - `-rr`: Include reverse complement (inverted) repeats.

### Quality Score Modeling
- **Distribution Type (-qt):** Choose `1` for uniform distribution or `2` for Gaussian (normal) distribution.
- **Custom Alphabet (-qc):** Define specific ASCII ranges for quality scores (e.g., `-qc 33:36,55,57:59`).
- **Statistical Profiles (-qf):** Load a file containing mean and standard deviation values for Gaussian distributions to mimic specific run qualities.

## Common CLI Patterns

### Standard Illumina Simulation
Generate 100,000 Illumina-style reads with fixed 100bp length and uniform quality:
```bash
./XS -v -t 2 -i n=Illumina_Unit -ls 100 -n 100000 -qt 1 output.fastq
```

### Variable Length Ion Torrent Simulation
Simulate 50,000 reads with lengths between 30bp and 400bp:
```bash
./XS -v -t 4 -ld 30:400 -n 50000 -qt 2 output.fastq
```

### High-Complexity Repeat Simulation
Simulate 10,000 reads containing repetitive elements (300-3000bp) with a 10% mutation rate, excluding quality scores to focus on sequence analysis:
```bash
./XS -v -ls 100 -n 10000 -es -f 0.3,0.2,0.2,0.3,0.0 -rn 50 -ri 300 -ra 3000 -rm 0.1 output.fastq
```

## Expert Tips
- **Reproducibility:** Always use the `-s <seed>` flag when generating datasets for benchmarks to ensure the same "random" sequence can be recreated later.
- **Component Filtering:** Use the filtering flags (`-eh`, `-eo`, `-ed`, `-es`) to isolate specific FASTQ components. For example, `-es` (exclude scores) and `-eh` (exclude headers) can be used to generate raw DNA symbol streams for testing compression algorithms.
- **Header Consistency:** Use the `-o` flag if your downstream tool requires the optional header (the "+" line) to be a duplicate of the primary header.

## Reference documentation
- [XS GitHub Repository](./references/github_com_pratas_xs.md)
- [Bioconda xs-sim Overview](./references/anaconda_org_channels_bioconda_packages_xs-sim_overview.md)