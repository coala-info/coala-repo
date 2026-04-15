---
name: hdmi
description: HDMI is a bioinformatics pipeline designed to identify and validate horizontal gene transfer events within metagenomic datasets using read-spanning evidence. Use when user asks to detect HGT events, profile HGT candidates using metagenomic reads, or analyze gene movement between species in MAGs.
homepage: https://github.com/HaoranPeng21/HDMI
metadata:
  docker_image: "quay.io/biocontainers/hdmi:1.0.0--pyhdfd78af_0"
---

# hdmi

## Overview

HDMI (HGT Detection from MAGs in Individual) is a bioinformatics pipeline designed to identify horizontal gene transfer events within metagenomic datasets. It moves beyond simple sequence similarity by incorporating read-spanning validation, ensuring that detected HGT events are supported by physical evidence in the sequencing data. This skill should be used when analyzing microbial evolution, antibiotic resistance spread, or functional gene movement between species in a metagenomic context.

## Core Workflow

The HDMI pipeline follows a strict four-step sequence. Each step depends on the output of the previous one.

### 1. Candidate Detection (`detect`)
Identifies potential HGT events using BLAST-based similarity searches between MAGs.

```bash
HDMI detect -i <genome_folder> -o <output_dir> -m <group_info.txt> -t <threads>
```

*   **Best Practice**: Always run with `--count-only` first to estimate the number of genome pairs and projected runtime.
*   **Parallelization**: For large datasets, use `-n <batch_number>` and `--total <total_batches>` to split the workload across multiple nodes or sessions.

### 2. Indexing (`index`)
Builds Bowtie2 indices for the contigs identified as containing HGT candidates.

```bash
HDMI index -g <genome_folder> -m <group_info.txt> -o <output_dir> -t <threads>
```

### 3. Event Profiling (`profile`)
Validates HGT events by mapping raw metagenomic reads to the HGT regions. This step confirms the event exists in the specific sample.

```bash
HDMI profile -r1 <sample_R1.fq.gz> -r2 <sample_R2.fq.gz> -o <output_dir> -g <genome_folder> -m <group_info.txt> -t <threads>
```

*   **Validation Threshold**: Use `--sth` (default: 2) to adjust the required number of spanning reads for an event to be considered valid.

### 4. Result Summary (`summary`)
Merges results across multiple samples and generates the final HGT element table.

```bash
HDMI summary -o <output_dir> -group <group_info.txt>
```

## Input Requirements

*   **Genome Folder**: A directory containing MAGs in FASTA format.
*   **Group Info File**: A tab-separated or space-separated file mapping MAG filenames to species/group IDs.
    *   *Example format*: `bin.1.fa 1`
*   **Quality Control**: It is highly recommended to use high-quality MAGs (e.g., those passing GUNC quality control) to avoid false positives caused by contamination.

## Expert Tips

*   **Resource Management**: Step 1 (detect) is CPU-intensive due to BLAST. Step 3 (profile) is I/O and CPU intensive. Ensure at least 16GB of RAM is available, though 32GB is recommended for large-scale metagenomic samples.
*   **Storage**: Intermediate files (indices and temporary BLAST results) can take 2-3x the size of your input data. Monitor disk space in the `<output_dir>`.
*   **Batch Processing**: If processing hundreds of MAGs, the number of pairs grows quadratically. Use the batching parameters (`-n` and `--total`) to prevent single-process bottlenecks.



## Subcommands

| Command | Description |
|---------|-------------|
| HDMI index | Index a genome for HDMI analysis. |
| hdmi_detect | Directory containing genome FASTA files |
| hdmi_profile | Profile HDMI sequencing data |
| hdmi_summary | Generates a summary of HDMI validation results. |

## Reference documentation
- [HDMI GitHub README](./references/github_com_HaoranPeng21_HDMI_blob_main_README.md)
- [HDMI Environment Configuration](./references/github_com_HaoranPeng21_HDMI_blob_main_environment.yml.md)
- [Group Info Example](./references/github_com_HaoranPeng21_HDMI_blob_main_Group_info_test.txt.md)