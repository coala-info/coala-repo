---
name: virema
description: ViReMa identifies non-linear genomic events, recombination breakpoints, and fusion transcripts in viral populations using a moving-seed alignment strategy. Use when user asks to detect viral recombination events, map non-linear genomic motifs, or identify virus-host fusion transcripts.
homepage: https://sourceforge.net/projects/virema/
---


# virema

## Overview

ViReMa (Viral Recombination Mapper) is a specialized bioinformatic tool designed to identify non-linear genomic events that standard aligners often miss. It is particularly effective for discovering functional genomic motifs, recombination breakpoints, and fusion transcripts in viral populations. By employing a moving-seed strategy, it can map reads that span distant parts of a genome or join different segments entirely.

## Prerequisites and Environment

- **Python**: Requires Python 3.7.
- **Alignment Tool**: Requires Bowtie version 0.12.9.
- **Pathing**: Both `bowtie` and `bowtie-inspect` must be available in your system `$PATH`.
- **Dependencies**: Uses standard Python libraries; no complex external package installation is typically required.

## Reference Genome Preparation

A critical step for ViReMa's sensitivity is the preparation of the virus reference index.

1.  **Terminal Padding**: Before building the index, manually add a terminal pad of 'A' nucleotides to the 3' end of your viral genome sequence.
2.  **Pad Length**: The pad must be longer than the maximum length of the reads in your dataset.
3.  **Reasoning**: Without this padding, ViReMa often fails to detect recombination events occurring near the edges of the viral genome.
4.  **Indexing**: Build the index using `bowtie-build`:
    `bowtie-build padded_genome.fasta Index_Name`

## Command Line Usage

### Basic Syntax
Run ViReMa using the following structure:
`python ViReMa.py <Virus_Index> <Input_Data> <Output_Data> [options]`

- **Virus_Index**: Full path to the Bowtie index (even if in the current directory).
- **Input_Data**: Single-end reads in FASTQ or FASTA format.
- **Output_Data**: The filename for the results (saved in the current working directory).

### Example Command
`python ViReMa.py /path/to/index/FHV_padded sample_reads.fastq results.txt --Seed 20 --MicroInDel_Length 5`

## Key Parameters and Optimization

- **--Seed**: Sets the initial alignment seed length. Smaller seeds increase sensitivity for detecting small fragments but increase runtime.
- **--MicroInDel_Length**: Defines the threshold for what is considered a micro-insertion or deletion versus a larger recombination event.
- **--Host_Index**: (Optional) Provide a host genome index to filter out host-derived reads or detect virus-host fusion events.

## Post-Processing

ViReMa includes auxiliary scripts for managing results:
- **Compiler_Module.py**: Used to compile and summarize output results from multiple runs or complex datasets.
- **ViReMa_GUI.py**: A graphical interface alternative (requires the `GOOEY` library).

## Expert Tips

- **Path Specificity**: Always provide the full path to the `Virus_Index`. ViReMa may fail to locate indices if only a relative path or local name is provided, even if Bowtie usually recognizes it.
- **Read Trimming**: ViReMa handles unaligned segments by trimming one nucleotide and re-attempting alignment. This is computationally intensive; ensure your input data is quality-trimmed to remove adapters before running ViReMa to improve efficiency.



## Subcommands

| Command | Description |
|---------|-------------|
| Compiler_Module.py | Viral Recombination Mapper - Compilation Module |
| ViReMa.py | ViReMa Version 0.6 - written by Andrew Routh |

## Reference documentation

- [ViReMa Files and README](./references/sourceforge_net_projects_virema_files.md)