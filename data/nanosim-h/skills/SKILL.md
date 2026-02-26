---
name: nanosim-h
description: "NanoSim-H simulates Oxford Nanopore sequencing reads by capturing technology-specific error profiles and read length distributions. Use when user asks to simulate ONT reads, generate perfect reads from a reference, model circular genomes, or adjust specific error rates for nanopore data."
homepage: https://github.com/karel-brinda/NanoSim-H
---


# nanosim-h

## Overview

NanoSim-H is a specialized simulator for Oxford Nanopore reads, derived from the original NanoSim package. It captures technology-specific features of ONT data, including complex error profiles (mismatches, insertions, and deletions) and read length distributions. This skill provides the procedural knowledge to execute simulations, select appropriate error profiles, and configure parameters for specific genomic contexts like circular chromosomes or perfect read generation.

## Installation and Setup

The tool is most reliably installed via Bioconda, which handles the necessary Python and R dependencies automatically.

```bash
conda install -c bioconda nanosim-h
```

## Common CLI Patterns

### Basic Read Simulation
To generate a standard set of reads (default 1000) using the E. coli R9 2D profile:
```bash
nanosim-h -p ecoli_R9_2D -o my_simulated_reads reference.fasta
```

### Simulating Circular Genomes
For bacterial genomes or plasmids, use the `--circular` flag to ensure the simulator handles the start/end of the sequence correctly without artificial coverage drops.
```bash
nanosim-h --circular -n 5000 -p ecoli_R9_1D reference.fasta
```

### Generating Perfect Reads
If you need reads that follow the ONT length distribution but contain no sequencing errors (useful for testing "best-case" assembly scenarios):
```bash
nanosim-h --perfect -n 2000 reference.fasta
```

### Standardized Naming (RNF)
For integration into evaluation pipelines that require Read Name Format (RNF) compliance:
```bash
nanosim-h --rnf --rnf-add-cigar reference.fasta
```

## Parameter Tuning and Best Practices

- **Profile Selection**: Choose from precomputed profiles including `ecoli_R7.3`, `ecoli_R7`, `ecoli_R9_1D`, `ecoli_R9_2D`, `yeast`, and `ecoli_UCSC1b`. If no profile is specified, `ecoli_R9_2D` is the default.
- **Error Rate Adjustment**: You can fine-tune the weight of specific error types using the following flags:
  - `-m [float]`: Mismatch rate (default 1.0)
  - `-i [float]`: Insertion rate (default 1.0)
  - `-d [float]`: Deletion rate (default 1.0)
- **K-mer Bias**: Use `--kmer-bias [int]` to prohibit homopolymers longer than the specified length (default is 6). Set to 0 to disable this restriction.
- **Read Length Constraints**: Use `--max-len` and `--min-len` to bound the simulation. Note that setting these too close together will significantly slow down the simulation process as the tool struggles to find valid fragments within the distribution.
- **Reproducibility**: Always set a seed using `-s [int]` (e.g., `-s 42`) to ensure that the pseudorandom number generation is deterministic across runs.

## Output Files

The tool produces two primary files based on the `-o` (output prefix) argument:
1. `[prefix].fa`: The FASTA file containing the simulated reads.
2. `[prefix].log`: A log file detailing the simulation parameters and process.

## Reference documentation
- [NanoSim-H GitHub Repository](./references/github_com_karel-brinda_NanoSim-H.md)
- [NanoSim-H Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_nanosim-h_overview.md)