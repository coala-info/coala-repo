---
name: necat
description: NECAT is an integrated assembly pipeline optimized for performing de-novo assembly and error correction on Oxford Nanopore Technologies long-read data. Use when user asks to generate configuration templates, correct noisy long reads, assemble contigs, or bridge and polish genomic datasets.
homepage: https://github.com/xiaochuanle/NECAT
---


# necat

## Overview

NECAT is an integrated assembly pipeline specifically optimized for Oxford Nanopore Technologies (ONT) data. It addresses the high error rate of long noisy reads through a progressive workflow that focuses on the highest-quality data subsets. The tool is particularly effective for users who need a streamlined path from raw FASTQ/FASTA files to polished, bridged contigs. You should use this skill to generate configuration templates, execute error correction, and perform de-novo assembly on genomic datasets.

## Core CLI Workflow

The NECAT pipeline is managed through the `necat.pl` wrapper script. Ensure the `bin` directory of your NECAT installation is in your system PATH before execution.

### 1. Configuration Setup
Every project begins with a configuration file. Generate a template to define your project parameters:

```bash
necat.pl config ecoli_config.txt
```

**Essential Parameters to Edit:**
- `PROJECT`: Name of the output directory.
- `ONT_READ_LIST`: Path to a text file containing full paths to your raw read files (one per line).
- `GENOME_SIZE`: Estimated size of the target genome in base pairs (e.g., 4600000 for E. coli).
- `THREADS`: Number of CPU cores to allocate.

### 2. Error Correction
Correct raw noisy reads based on the `PREP_OUTPUT_COVERAGE` (default 40X) specified in your config:

```bash
necat.pl correct ecoli_config.txt
```
*Output:* Corrected reads are stored in `./[PROJECT]/1-consensus/cns_final.fasta`.

### 3. Contig Assembly
Assemble the corrected reads into contigs. This step will automatically run the correction step if it has not been completed:

```bash
necat.pl assemble ecoli_config.txt
```
*Output:* Assembled contigs are found in `./[PROJECT]/4-fsa/contigs.fasta`.

### 4. Bridging and Polishing
The final stage bridges contigs and, if `POLISH_CONTIGS=true` is set in the config, performs polishing using the corrected reads:

```bash
necat.pl bridge ecoli_config.txt
```
*Output:* Bridged contigs are in `./[PROJECT]/6-bridge_contigs/bridged_contigs.fasta`. Polished versions are in `polished_contigs.fasta` in the same directory.

## Expert Tips and Best Practices

- **Read List Flexibility**: The `ONT_READ_LIST` file can point to a mix of FASTA and FASTQ files, and they can be gzipped (`.gz`). You do not need to decompress or convert them beforehand.
- **Coverage Settings**: 
    - `PREP_OUTPUT_COVERAGE`: Controls how many of the longest raw reads are corrected (default 40X).
    - `CNS_OUTPUT_COVERAGE`: Controls how many corrected reads are used for assembly (default 30X).
- **Grid Computing**: For large genomes, enable distributed computing in the config file by setting `USE_GRID=true` and specifying `GRID_NODE` (number of nodes). NECAT supports PBS and SGE systems.
- **Memory Management**: If running on a machine with limited RAM, set `SMALL_MEMORY=1` in the configuration file to reduce the memory footprint during the assembly phase.
- **Incremental Execution**: Each command (`correct`, `assemble`, `bridge`) is aware of the previous steps. You can jump straight to `necat.pl bridge` and the script will trigger all necessary preceding steps automatically.

## Reference documentation
- [NECAT GitHub Repository](./references/github_com_xiaochuanle_NECAT.md)
- [NECAT Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_necat_overview.md)