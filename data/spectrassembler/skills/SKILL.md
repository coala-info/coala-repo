---
name: spectrassembler
description: spectrassembler computes genome assembly layouts and consensus sequences from uncorrected long-reads using a spectral algorithm. Use when user asks to assemble genomes from long-reads, compute read ordering layouts, or generate consensus sequences from pairwise overlaps.
homepage: https://github.com/antrec/spectrassembler
metadata:
  docker_image: "quay.io/biocontainers/spectrassembler:0.0.1a1--py27_1"
---

# spectrassembler

## Overview
spectrassembler is an experimental tool designed to compute genome assembly layouts from uncorrected long-reads. It utilizes a spectral algorithm to determine the linear ordering of reads based on pairwise overlap information. This ordering serves as a coarse-grained layout, which is then refined into a final consensus sequence using a sliding window approach powered by the `spoa` (Simplicial Partial Order Alignment) library. It is particularly effective for bacterial genomes but can be tuned for more complex eukaryotic data.

## Installation and Dependencies
Before running spectrassembler, ensure the following dependencies are available:
- **Python Packages**: `numpy`, `scipy`, `biopython`.
- **External Tools**: `minimap` (for overlap detection) and `spoa` (included in the `tools/` directory of the repository).

## Standard Workflow

### 1. Generate Overlaps
Use `minimap` to generate a Pairwise Mapping Format (PAF) file.
```bash
minimap -Sw5 -L100 -m0 reads.fasta reads.fasta > overlaps.paf
```

### 2. Run Assembly
Execute the main script to compute the layout and generate contigs.
```bash
python spectrassembler.py -f reads.fasta -m overlaps.paf -r output_dir --nproc 8 > contigs.fasta
```

## Command Line Options
- `-f`: Input reads in FASTA or FASTQ format.
- `-m`: Overlap file from `minimap` in PAF format.
- `-r`, `--root`: Directory where layout files and intermediate consensus files are written.
- `--nproc`: Number of threads to use for processing.
- `--spoapath`: Path to the `spoa` executable. Set to an empty string (`--spoapath ''`) to skip the consensus stage and only compute the layout.

## Expert Tuning and Best Practices

### Adjusting Similarity Thresholds
The `--sim_qtile` parameter is the most critical for assembly quality. It sets a threshold on the similarity matrix to remove false overlaps.
- **Bacterial Genomes (Standard Coverage)**: Use the default `0.4` (removes the 40% lowest values).
- **Eukaryotic Genomes / High Coverage (>80x)**: Increase to `0.9`. A higher value reduces the risk of erroneous layouts but may result in more fragmented assemblies.
- **PacBio Data**: Generally requires a higher `--sim_qtile` (e.g., `0.9`) due to different error profiles compared to Nanopore.

### Handling Repetitive Regions
If the assembly appears misassembled or contains chimeric contigs, increase the `--sim_qtile` value. While the tool has a heuristic to auto-increase this parameter if the layout looks inconsistent, manual adjustment is often more efficient for known complex samples.

### Consensus Stage
The tool creates subdirectories (e.g., `cc0`, `cc1`) for each connected component found in the similarity graph. These contain the input files for the sliding window consensus. If you only need the read ordering (e.g., for visualization or use in another pipeline), disable the consensus stage to save time.

## Reference documentation
- [spectrassembler README](./references/github_com_antrec_spectrassembler.md)