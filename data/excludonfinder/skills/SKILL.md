---
name: excludonfinder
description: ExcludonFinder maps transcriptional overlaps between adjacent genes to identify and annotate excludons from RNA-seq data. Use when user asks to map transcriptional overlaps, identify excludons, define transcriptional units, or analyze antisense regulation between convergent and divergent gene pairs.
homepage: https://github.com/Alvarosmb/ExcludonFinder
---


# excludonfinder

## Overview

ExcludonFinder is a specialized bioinformatics tool used to map transcriptional overlaps between adjacent genes, a phenomenon known as an "excludon." The tool automates a multi-step workflow: it aligns RNA-seq reads to a reference genome, calculates per-nucleotide coverage, and defines Transcriptional Units (TUs) based on where expression decays below a user-defined threshold. By comparing the boundaries of these TUs for convergent (-> <-) and divergent (<- ->) gene pairs, it identifies and annotates overlapping regions. This is essential for researchers studying antisense regulation, operon structures, and complex transcriptional landscapes in both prokaryotic and eukaryotic genomes.

## Installation and Setup

The most reliable way to use ExcludonFinder is via the Bioconda package:

```bash
conda install -c bioconda excludonfinder
```

If working from a source clone, ensure the environment is activated using the provided `environment.yml` and run the script directly from the `scripts/` directory.

## Command Line Usage

### Basic Execution
To run a standard analysis with paired-end short-read data:

```bash
ExcludonFinder -f reference.fasta -1 reads_R1.fastq -2 reads_R2.fastq -g annotation.gff
```

### Core Arguments
- `-f`: Reference genome in FASTA format.
- `-1` / `-2`: Input FASTQ files for Read 1 and Read 2 (paired-end).
- `-g`: Genomic annotation in GFF format.
- `-o`: Custom output directory (defaults to `./output`).

### Advanced Options and Tuning
- **Coverage Threshold (`-t`)**: The default is `0.5`. This value determines where a Transcriptional Unit (TU) ends. If the tool is failing to detect known overlaps, try lowering this threshold; if TUs are merging incorrectly, increase it.
- **Long-Read Support (`-l`)**: Use this flag if your input data comes from platforms like Oxford Nanopore or PacBio.
- **Performance (`-j`)**: Set the number of threads (default is 8). Increase this for large datasets to speed up the alignment and coverage calculation phases.
- **Debugging (`-k`)**: Use the "keep" flag to prevent the tool from deleting intermediate BAM and coverage files. This is useful for verifying the alignment quality in a genome browser like IGV.

## Best Practices and Expert Tips

1. **Header Consistency**: Ensure that the chromosome/contig names in your FASTA file exactly match the first column of your GFF file. Mismatched headers are the most common cause of empty output.
2. **Memory Management**: For very large genomes or high-depth RNA-seq, ensure your environment has sufficient RAM, as the per-nucleotide coverage calculation can be memory-intensive.
3. **Interpreting Results**: The primary output is an annotated list of excludons. Review the median coverage values provided in the output to assess the strength of the evidence for each detected overlap.
4. **GFF Formatting**: ExcludonFinder is optimized for standard GFF3. If using non-standard GFFs, ensure that "gene" features are clearly defined, as the tool uses these to subtract and analyze neighboring pairs.

## Reference documentation
- [ExcludonFinder GitHub Repository](./references/github_com_Alvarosmb_ExcludonFinder.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_excludonfinder_overview.md)