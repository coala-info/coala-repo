---
name: artfastqgenerator
description: ArtificialFastqGenerator generates synthetic paired-end FASTQ files from a reference genome with customizable sequencing parameters and error profiles. Use when user asks to simulate NGS data, create ground truth datasets for pipeline validation, or replicate the quality score profiles of existing sequencing runs.
homepage: 
metadata:
  docker_image: "biocontainers/artfastqgenerator:v0.0.20150519-3-deb_cv1"
---

# artfastqgenerator

## Overview
ArtificialFastqGenerator is a specialized tool for creating artificial Next-Generation Sequencing (NGS) data. It transforms a reference genome into paired-end FASTQ files while allowing fine-grained control over sequencing parameters like read length, template size, and coverage depth. Its primary strength lies in its ability to simulate GC-content bias and replicate the quality score profiles of existing datasets, making it ideal for creating "ground truth" datasets for pipeline validation.

## Core Usage Patterns

### Basic Simulation
To generate a standard set of reads from a specific chromosome or scaffold:
java -jar ArtificialFastqGenerator.jar -R reference.fasta -O output_prefix -S "chr1"

### High-Fidelity Simulation
To mimic a specific sequencing run's error profile and quality scores:
java -jar ArtificialFastqGenerator.jar -R reference.fasta -O output_prefix -S "chr1" -URQS true -F1 real_reads_1.fastq -F2 real_reads_2.fastq -SE true

### Customizing Coverage and Library Prep
Adjust the depth and insert size to match specific library protocols (e.g., 50x coverage, 150bp reads):
java -jar ArtificialFastqGenerator.jar -R reference.fasta -O output_prefix -S "chr1" -CMP 50 -RL 150 -TLM 300 -TLSD 50

## Parameter Optimization and Best Practices

- **Reference Identifiers (-S and -E)**: The tool requires a starting sequence identifier. Ensure the string provided to `-S` matches the beginning of the FASTA header (e.g., if the header is `>chrM_human`, `-S chrM` is usually sufficient).
- **Quality Scores (-URQS)**: By default, the tool sets all quality scores to the maximum. For realistic testing, always set `-URQS true` and provide source FASTQ files via `-F1` and `-F2` to extract real-world quality distributions.
- **Error Simulation (-SE)**: Simply providing quality scores does not create mismatches. You must explicitly set `-SE true` to force the tool to simulate sequencing errors based on those quality scores.
- **GC Bias (-GCC)**: Enabled by default (`true`). This simulates the common phenomenon where regions with very high or low GC content have lower coverage. Adjust `-CMPGC` (default 0.45) to shift the peak coverage to a different GC percentage if your target organism has a biased genome.
- **N-Filter (-RCNF)**: Use `-RCNF 2` to filter out any reads containing ambiguous 'N' bases. This is often necessary for downstream tools or aligners that do not handle 'N' characters gracefully.
- **Output Path (-O)**: This parameter is a prefix, not just a directory. If you provide `-O /data/sim_run`, the tool will generate `/data/sim_run.1.fastq` and `/data/sim_run.2.fastq`.

## Expert Tips
- **Memory Management**: For large genomes, increase the `-N` (nucleobaseBufferSize) from the default 5000 to a higher value to improve performance, provided your environment has sufficient RAM.
- **Coordinate Systems**: The `-X` and `-Y` parameters allow you to set the starting coordinates for the FASTQ headers, which can be useful if you are merging multiple simulated runs and need unique read identifiers.
- **Debugging**: If the simulation is failing or producing unexpected results, change `-OF` to `debug_nucleobases` to output the internal representation of the reference traversal.