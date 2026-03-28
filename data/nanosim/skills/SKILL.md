---
name: nanosim
description: NanoSim simulates realistic Oxford Nanopore sequencing reads by learning statistical profiles from real datasets. Use when user asks to simulate nanopore reads, characterize ONT datasets, or generate synthetic genomic and transcriptomic data for benchmarking.
homepage: https://github.com/bcgsc/NanoSim
---


# nanosim

## Overview

NanoSim is a high-performance simulation suite designed to capture the technology-specific features of Oxford Nanopore sequencing. Unlike general-purpose simulators, NanoSim employs a two-stage workflow: it first "characterizes" real ONT datasets to learn their statistical properties (such as match/mismatch rates and indel distributions) and then "simulates" new reads based on those learned profiles. This allows researchers to generate realistic long-read data for benchmarking assemblers, aligners, and variant callers across various biological contexts, including complex metagenomes and transcriptomes.

## Characterization Stage

The characterization stage analyzes real nanopore reads to build a model.

- **Input Requirements**: Provide a set of real ONT reads (FASTQ) and a corresponding reference genome (FASTA).
- **Alignment**: Use `minimap2` (default in v2.0+) for the alignment step to significantly reduce runtime.
- **Output**: This stage produces a set of model files (profiles) that describe the read length distribution, error rates, and quality scores.
- **Command Pattern**:
  `python src/read_analysis.py genome -i <input_reads.fastq> -r <reference.fasta> -o <output_model_prefix>`

## Simulation Stage

The simulation stage generates synthetic reads using the profiles created during characterization or provided in the `pre-trained_models` directory.

- **Genomic Simulation**: Generates reads from a reference genome.
  `python src/simulator.py genome -rg <reference.fasta> -c <model_prefix> -n <number_of_reads>`
- **Transcriptome Simulation**: Supports cDNA and direct RNA reads, including modeling of intron retention (IR) events.
- **Metagenome Simulation**: Quantifies abundance and simulates chimeric reads to mimic complex microbial communities.
- **Base Quality**: Use the `--fastq` flag to output reads with simulated base quality scores based on truncated log-normal distributions.
- **Coverage-based Simulation**: Use the `-cv` or `--coverage` option to simulate reads to a specific depth rather than a fixed number of reads.

## Expert Tips and Best Practices

- **Version Compatibility**: If using pre-trained models provided in v3.0.2 or earlier, ensure `scikit-learn` is version 0.22.1. Newer versions of scikit-learn may cause errors regarding `sklearn.neighbors.kde`.
- **Homopolymer Simulation**: Enable homopolymer expansion and contraction modeling to better reflect the performance of specific basecallers (e.g., Guppy or Dorado).
- **Chimeric Reads**: When simulating metagenomes or using the latest genome mode, enable chimeric read simulation to test the robustness of assembly and mapping pipelines.
- **Performance**: Utilize the multiprocessing options for large-scale library simulations to distribute the workload across multiple CPU cores.
- **Pre-trained Models**: For common organisms (H. sapiens, E. coli, ZymoBIOMICS mock communities), use the models in the `pre-trained_models/` folder to skip the characterization stage.



## Subcommands

| Command | Description |
|---------|-------------|
| read_analysis.py | Read characterization step Given raw ONT reads, reference genome, metagenome, and/or transcriptome, learn read features and output error profiles |
| simulator.py | Given error profiles, reference genome, metagenome, and/or transcriptome, simulate ONT DNA or RNA reads |

## Reference documentation

- [NanoSim Main Repository](./references/github_com_bcgsc_NanoSim.md)
- [NanoSim Wiki Home](./references/github_com_BirolLab_NanoSim_wiki.md)