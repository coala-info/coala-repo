---
name: spades
description: SPAdes is a genome assembly toolkit designed to reconstruct sequences from various sequencing technologies, particularly for small genomes like bacteria and viruses. Use when user asks to assemble genomes from Illumina or long-read data, perform metagenomic or single-cell assembly, or identify plasmids and transcriptomes.
homepage: https://github.com/ablab/spades
metadata:
  docker_image: "quay.io/biocontainers/spades:4.2.0--h8d6e82b_2"
---

# spades

## Overview
SPAdes (St. Petersburg genome assembler) is a versatile assembly toolkit optimized for small genomes, such as bacteria and viruses. It is particularly effective at handling the non-uniform coverage depth typical of single-cell sequencing (MDA) and the complexity of metagenomic samples. While primarily designed for Illumina data, it supports multiple sequencing technologies and provides specialized pipelines for plasmids, RNA-seq, and viral discovery.

## Core CLI Patterns

### Basic Assembly
For a standard paired-end library:
```bash
spades.py -1 left.fastq.gz -2 right.fastq.gz -o output_dir
```

### Hybrid Assembly
To improve assembly continuity using long reads as supplementary data:
```bash
spades.py -1 left.fastq.gz -2 right.fastq.gz --pacbio long_reads.fastq -o output_dir
# OR
spades.py -1 left.fastq.gz -2 right.fastq.gz --nanopore long_reads.fastq -o output_dir
```

### Specialized Modes
Select the appropriate pipeline based on the biological context:
- **Isolates**: `--isolate` (Recommended for high-coverage cultured bacteria; uses a different error correction and assembly graph approach).
- **Metagenomes**: `--meta` (Optimized for highly non-uniform coverage and multiple species).
- **Single-cell**: `--sc` (Designed for MDA-amplified data with extreme coverage bias).
- **Plasmids**: `--plasmid` (Extracts and assembles plasmidic sequences from isolate data).
- **Transcriptomes**: `--rna` (Handles varying expression levels and alternative splicing).
- **Viruses**: `--metaviral` or `--rnaviral` (Specific for viral discovery in meta-genomic or transcriptomic data).

## Resource Management
SPAdes is memory-intensive. Always specify limits to prevent system crashes:
- `-t <int>`: Number of threads (default is 16).
- `-m <int>`: Memory limit in Gb (default is 250 Gb).

## Expert Tips and Best Practices
- **Input Validation**: Use `spades.py --test` to verify the installation and environment before running on real data.
- **Error Correction**: By default, SPAdes runs BayesHammer for read error correction. If you have already pre-processed your reads with other tools, you can skip this step using `--only-assembler`.
- **Restarting**: If a run is interrupted, use the same command with the `--continue` flag or point to the existing output directory to resume from the last checkpoint.
- **IonTorrent Data**: Use the `--iontorrent` flag specifically when working with IonTorrent reads to adjust the internal error model.
- **Output Files**: 
    - `contigs.fasta`: The resulting assembled sequences.
    - `scaffolds.fasta`: Contigs joined by paired-end/long-read information (recommended for most downstream analyses).
    - `assembly_graph_with_scaffolds.gfa`: Useful for visualizing the assembly in tools like Bandage.
- **Troubleshooting**: If an assembly fails, always check `params.txt` to verify the parameters used and `spades.log` for the specific error message.

## Reference documentation
- [SPAdes GitHub README](./references/github_com_ablab_spades.md)
- [Anaconda Bioconda SPAdes Overview](./references/anaconda_org_channels_bioconda_packages_spades_overview.md)