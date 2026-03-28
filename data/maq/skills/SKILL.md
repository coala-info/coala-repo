---
name: maq
description: "Maq maps short DNA sequencing reads to a reference genome and calls consensus sequences and SNPs. Use when user asks to map short reads, convert sequence formats to binary, call SNPs, or merge alignment files."
homepage: https://maq.sourceforge.net/maq-man.shtml
---


# maq

## Overview
Maq (Mapping and Assembly with Qualities) is a specialized suite for handling next-generation sequencing data. It is designed to map short reads to a reference sequence and derive a consensus with associated Phred qualities. This skill provides the procedural knowledge required to navigate the Maq workflow, from format conversion (BFA/BFQ) to final SNP calling and alignment viewing.

## Core Workflow
For most standard tasks, use the `maq.pl` wrapper script. For large-scale or custom data processing, execute the binary commands individually.

### 1. Data Preparation
Maq uses binary formats to optimize I/O. You must convert your FASTA and FASTQ files before processing.

- **Reference Conversion**: `maq fasta2bfa ref.fasta ref.bfa`
- **Read Conversion**: `maq fastq2bfq reads.fastq reads.bfq`
- **Solexa to Sanger**: If using raw Solexa pipeline output, convert qualities first:
  `maq sol2sanger s_1_sequence.txt s_1_sequence.fastq`

### 2. Alignment (match)
The `match` command performs ungapped alignment.

- **Single-end**: `maq match out.map ref.bfa reads.bfq`
- **Paired-end**: `maq match out.map ref.bfa reads1.bfq reads2.bfq`
  - *Note*: Ensure both BFQ files have the same number of reads and identical sequence names in the same order.
- **Parameters**:
  - `-n`: Max mismatches (default 2).
  - `-a`: Max insert size for paired-end.
  - `-i`: Minimum insert size for paired-end.

### 3. Assembly and SNP Calling
Once reads are mapped, build the assembly to call the consensus.

- **Assemble**: `maq assemble out.cns ref.bfa out.map`
- **Extract SNPs**: `maq cns2snp out.cns > out.snp`
- **Extract Consensus (FASTQ)**: `maq cns2fq out.cns > out.cns.fq`

### 4. Viewing and Merging
- **View Alignments**: `maq mapview out.map` (outputs TAB-delimited text).
- **Merge Maps**: For large datasets (e.g., > 2 million reads), process in batches and merge:
  `maq mapmerge merged.map in1.map in2.map in3.map`

## Expert Tips
- **Memory and Performance**: Maq is optimized for 64-bit architectures. While it runs on 32-bit systems, performance is significantly degraded.
- **Batching**: For datasets exceeding 2 million reads, parallelize the `match` step across multiple batches and use `mapmerge` to combine them.
- **Quality Scaling**: Always ensure your FASTQ qualities are in Sanger/Phred scale. Using Solexa-scaled qualities without the `sol2sanger` conversion will result in incorrect SNP calls.



## Subcommands

| Command | Description |
|---------|-------------|
| maq bfq2fastq | Convert .bfq files to .fastq files |
| maq cns2win | Convert consensus sequences to windowed format. |
| maq csmap2nt | Convert cs.map to nt.map |
| maq fasta2bfa | (No description) |
| maq fastq2bfq | Convert FASTQ to bfq format |
| maq indelpe | Estimate indel polymorphism rate |
| maq indelsoa | Detect indel candidates from alignments. |
| maq mapass2maq | Convert mapass2.map to maq.map format |
| maq mapmerge | Merge multiple map files. |
| maq mapview | View alignments in a map file |
| maq pileup | Generate pileup from Maq alignments |
| maq rmdup | Remove duplicate reads from a maq map file. |
| maq simucns | Simulate consensus sequences from true SNPs. |
| maq simutrain | Simulate reads from a reference genome. |
| maq snpreg | Call SNPs using consensus and SNP information. |
| maq sol2sanger | Convert Sanger FASTQ to MAQ FASTQ |
| maq_assemble | Assemble genome sequences |
| maq_cns2fq | Convert consensus sequence to FASTQ format. |
| maq_glfgen | Generate GLF file from maq assembly |
| maq_map | Map reads to a reference genome |
| maq_mapcheck | Check mapping quality of reads. |

## Reference documentation
- [Maq Manual](./references/maq_sourceforge_net_maq-man.shtml.md)