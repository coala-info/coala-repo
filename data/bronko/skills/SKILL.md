---
name: bronko
description: bronko is a k-mer based bioinformatics tool designed for high-speed viral variant detection and reference mapping. Use when user asks to build a reference database, perform viral variant calling, generate consensus sequences, or detect minor variants.
homepage: https://github.com/treangenlab/bronko
---


# bronko

## Overview

bronko is a specialized bioinformatics tool designed for high-speed viral variant detection. Unlike traditional pipelines that rely on computationally expensive read mapping (e.g., BWA, Bowtie2) followed by variant calling (e.g., iVar, LoFreq), bronko uses a k-mer based approach to map reads directly to a pileup. This allows it to process hundreds of samples against diverse reference genomes significantly faster than standard methods while maintaining comparable precision for SNPs and minor variants.

## Core Workflows

### 1. Building a Reference Database
Use `bronko build` to create a searchable index (`.bkdb`) from one or more viral genomes. This is essential for multi-strain analysis where bronko automatically selects the best reference for each sample.

```bash
# Build from a directory of fasta files
bronko build -g /path/to/genomes/*.fa -o viral_db

# Build using a text file containing paths to genomes
bronko build --file-input genomes_list.txt -o viral_db
```

### 2. Variant Calling
Use `bronko call` to perform mapping and variant calling. You can provide a pre-built database (`-d`) or raw fasta files (`-g`).

```bash
# Paired-end reads with a pre-built database
bronko call -d viral_db.bkdb -1 sample_R1.fq -2 sample_R2.fq -o output_dir

# Single-end reads with consensus and pileup generation
bronko call -d viral_db.bkdb -r sample.fq --consensus --pileup -o output_dir
```

## Expert Tips and Best Practices

### Input Quality Control
* **Remove Primers**: Always trim primer sequences before running bronko. K-mer based mapping is highly sensitive to primer contamination, which can lead to false variant calls.
* **Base Quality**: Use a high base quality threshold (>25 or >30) during preprocessing. bronko does not natively incorporate Phred scores into its k-mer transformation.

### Tuning for Sensitivity vs. Precision
* **Minor Variants (iSNVs)**: To detect low-frequency variants, lower the `--min-af` (e.g., `0.005` for 0.5%). Keep `--n-fixed` at the default (2) to minimize false positives in these low-frequency ranges.
* **High Depth Data**: For datasets with >10,000x depth, increase `--min-kmers` (e.g., to `10`) to speed up processing and filter out sequencing noise.
* **Mutation-Dense Regions**: If you suspect many variants within a short window, use `--use-full-kmer`. This disables the fixed-end constraint, increasing sensitivity at the cost of a potential slight increase in false positives.

### Parameter Heuristics
* **K-mer Size (`-k`)**: The default is 21. Use smaller values (15-19) for higher sensitivity in highly divergent samples, or larger values (23-25) to avoid spurious matches in genomes with repetitive regions.
* **Noise Filtering**: Adjust `--noise-multiplier` (default 1.5) to control stringency. Values closer to 1.2 increase sensitivity; values closer to 2.0 increase precision.

## Interpreting Outputs
* **bronko_overview.tsv**: Check `breadth_coverage`. For amplicon sequencing, aim for 95-99%. Low breadth suggests the reference genome in your database is not a good match for the sample.
* **VCF Files**: Standard VCFv4.5. The `SOR` (Strand Odds Ratio) is the primary filter for strand bias; if you have extremely unbalanced library prep, you may need to use `--no-strand-filter`.
* **.mfa Files**: These are "masked" alignments containing only polymorphic positions. They are ready for direct input into phylogenetic tools like IQ-TREE or RAxML.



## Subcommands

| Command | Description |
|---------|-------------|
| build | Create an bronko index of existing viral references for a given species |
| call | Perform rapid viral variant calling of viral sequencing data |

## Reference documentation
- [Command Parameters](./references/github_com_treangenlab_bronko_wiki_Command-Parameters.md)
- [Description of Outputs](./references/github_com_treangenlab_bronko_wiki_Description-of-Outputs.md)
- [Tips and Tricks](./references/github_com_treangenlab_bronko_wiki_Tips-and-Tricks.md)