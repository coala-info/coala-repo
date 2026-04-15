---
name: necat
description: NECAT is a bioinformatics pipeline designed for error correction and de-novo assembly of Nanopore long-read sequencing data. Use when user asks to initialize an assembly project, correct noisy long reads, assemble contigs, or bridge and polish genomic sequences.
homepage: https://github.com/xiaochuanle/NECAT
metadata:
  docker_image: "quay.io/biocontainers/necat:0.0.1_update20200803--h5ca1c30_6"
---

# necat

## Overview

NECAT is a specialized bioinformatics pipeline designed to handle the high error rates associated with Nanopore long-read sequencing. It excels at producing high-quality de-novo assemblies by first performing a rigorous error-correction step on the raw noisy reads before proceeding to assembly. The tool is particularly effective for various genome sizes, from bacteria to large plant genomes, and supports distributed computing on PBS or SGE grid systems.

## Core Workflow

The `necat.pl` script manages the entire pipeline through four primary commands. Each step automatically triggers preceding steps if their outputs are missing.

### 1. Project Initialization
Generate a configuration template to define project parameters.
```bash
necat.pl config config.txt
```

### 2. Read Correction
Corrects the longest raw reads (default 40X coverage).
```bash
necat.pl correct config.txt
```
*   **Output**: Corrected reads are stored in `./[PROJECT]/1-consensus/cns_final.fasta`.

### 3. Contig Assembly
Assembles the corrected reads into contigs.
```bash
necat.pl assemble config.txt
```
*   **Output**: Assembled contigs are found in `./[PROJECT]/4-fsa/contigs.fasta`.

### 4. Bridging and Polishing
Bridges contigs to improve continuity and optionally polishes them using corrected reads.
```bash
necat.pl bridge config.txt
```
*   **Output**: Final bridged/polished results in `./[PROJECT]/6-bridge_contigs/polished_contigs.fasta`.

## Configuration Best Practices

The `config.txt` file is the central control for the assembly. Key parameters to optimize:

| Parameter | Description | Expert Tip |
| :--- | :--- | :--- |
| `ONT_READ_LIST` | Path to a file listing full paths of read files. | Supports mixed FASTA/FASTQ and gzipped files. |
| `GENOME_SIZE` | Estimated size of the target genome. | Accuracy here improves coverage calculations for correction. |
| `PREP_OUTPUT_COVERAGE` | Coverage of raw reads to correct. | Default is 40. Increase for very high-error or complex datasets. |
| `CNS_OUTPUT_COVERAGE` | Coverage of corrected reads for assembly. | Default is 30. Ensure this is sufficient for the `GENOME_SIZE`. |
| `POLISH_CONTIGS` | Boolean (true/false). | Set to `true` to enable the final polishing step during bridging. |

## High-Performance Computing (Grid)

To run NECAT across multiple nodes on PBS or SGE clusters, modify these fields in the config:
*   `USE_GRID=true`
*   `GRID_NODE=4` (Number of computation nodes)
*   `THREADS=20` (CPUs per node)



## Subcommands

| Command | Description |
|---------|-------------|
| necat.pl | NECAT is a tool for assembling long reads. |
| necat.pl | necat.pl correct\|assemble\|bridge\|config cfg_fname |
| necat.pl bridge | bridge contigs |
| necat.pl config | generate default config file |

## Reference documentation
- [NECAT README](./references/github_com_xiaochuanle_NECAT_blob_master_README.md)