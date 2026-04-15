---
name: jccirc
description: JCcirc reconstructs full-length circular RNA sequences by integrating back-splice junction information with de novo assembled transcript contigs. Use when user asks to reconstruct full-length circRNA sequences, identify alternative splicing isoforms in circRNAs, or simulate circRNA datasets for benchmarking.
homepage: https://github.com/cbbzhang/JCcirc
metadata:
  docker_image: "quay.io/biocontainers/jccirc:1.0.0--hdfd78af_1"
---

# jccirc

## Overview

JCcirc is a specialized Perl-based tool designed to overcome the limitations of short-read RNA-seq in circRNA characterization. By combining back-splice junction (BSJ) information with junction contigs (JC) generated from de novo assemblers like Trinity or SPAdes, it accurately defines circRNA boundaries and fills in internal sequences. It is particularly effective for low-expression circRNAs and identifying alternative splicing isoforms.

## Core Workflow

### 1. Prepare Upstream Inputs
Before running JCcirc, you must generate a contig file using a de novo transcript assembler and a list of predicted circRNAs.
- **Supported Assemblers**: Trinity (`inchworm.DS.fa`), SPAdes (`transcripts.fasta`), or SOAPdenovo-Trans (`soap.contig`).
- **CircRNA List**: A file containing chromosome, start, end, host gene, strand, and junction read IDs.

### 2. Execute Assembly
Run the main assembly script using the following command pattern:

```bash
perl JCcirc.pl -C circ_list.txt -G genome.fa -F annotation.gtf -O output_dir -P 8 --read1 reads_1.fq --read2 reads_2.fq --contig assembler_contigs.fa -D 0
```

### 3. Parameter Optimization
- **Threads (`-P`)**: Set based on available CPU cores (default is 4).
- **Difference (`-D`)**: Controls the strictness of isoform generation based on support numbers between adjacent fragments.
    - Set to **0** for human data.
    - Set to **2** for plant data or genomes with short introns.
    - Valid range is 0, 1, or 2.

## Best Practices

- **File Consistency**: Ensure the genome FASTA (`-G`) and GTF annotation (`-F`) are identical to those used in the upstream circRNA prediction and assembly steps.
- **Paired-End Data**: Always use paired-end RNA-seq data. The FASTQ files provided to JCcirc must be the same files used for the de novo assembly.
- **Output Interpretation**:
    - `circ_full_seq.fa`: Contains the final reconstructed full-length circRNA sequences.
    - `fragment_final.txt`: Provides the mapping of circRNA locations to their genomic fragment coordinates.

## Simulation for Benchmarking
Use the included `CircSimu.pl` script to generate simulated circRNA datasets for testing:

```bash
perl CircSimu.pl -O prefix -G annotation.gtf -D /path/to/references/ -C [coverage] -L [read_length] -E [error_rate]
```
- **Random Modes**: Use `-R 1` for constant coverage or `-R 2` for random coverage.
- **Insert Length**: Set the average insert length with `-M` and standard deviation with `-S`.



## Subcommands

| Command | Description |
|---------|-------------|
| jccirc_CircSimu.pl | a simulation tool for circRNAs. |
| perl cFLSeq.pl | CIRCSeq (circRNA sequence) |

## Reference documentation
- [JCcirc README](./references/github_com_cbbzhang_JCcirc_blob_master_README.md)
- [JCcirc Main Script Documentation](./references/github_com_cbbzhang_JCcirc_blob_master_JCcirc.pl.md)
- [CircSimu Simulation Documentation](./references/github_com_cbbzhang_JCcirc_blob_master_CircSimu.pl.md)