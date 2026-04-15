---
name: lamassemble
description: lamassemble produces a high-accuracy consensus sequence from a set of overlapping long DNA reads using a probabilistic framework. Use when user asks to generate a consensus sequence from long reads, perform multiple sequence alignment for error correction, or merge overlapping sequences into a single accurate sequence.
homepage: https://gitlab.com/mcfrith/lamassemble
metadata:
  docker_image: "quay.io/biocontainers/lamassemble:1.7.2--pyh7cba7a3_0"
---

# lamassemble

## Overview

lamassemble is a bioinformatics tool designed to produce a single, accurate consensus sequence from a set of overlapping "long" DNA reads. Unlike simple consensus methods, it utilizes a probabilistic framework—incorporating pairwise alignments from LAST and multiple alignments from MAFFT—to account for the specific error profiles of long-read sequencing technologies. It is particularly effective when high-fidelity consensus is required for structural variant analysis or complex genomic regions.

## Installation

The tool is primarily distributed via Bioconda:

```bash
conda install -c bioconda lamassemble
```

## Core Usage and CLI Patterns

The basic command structure requires a training file (representing the error profile) and the input reads:

```bash
lamassemble [options] train_file reads.fasta > consensus.fasta
```

### Training Files (.mat)
lamassemble requires a transition probability matrix produced by `last-train`. You can provide a path to a custom `.mat` file or use built-in keywords for common platforms:
- `promethion` (Oxford Nanopore PromethION)
- `sequel-II-CLR` (PacBio Sequel II Continuous Long Reads)

### Common Options
- `-f`: Output the consensus in FASTQ format, including calculated quality scores.
- `-u`: Use this option to potentially increase processing speed (added in v1.7.0).
- `--seq-min <N>`: Set the minimum number of sequences required to attempt an assembly.
- `--end`: Use this flag when dealing with PCR-amplified sequences or when specific end-alignment logic is required (replaces the older `--pcr` flag).

## Expert Tips and Best Practices

### Probabilistic Scoring
lamassemble calculates the probability of a base at a specific column using Bayes' rule. The quality scores in the FASTQ output (`-f`) represent the probability of the most likely base. If you see a `~` in the quality section, it indicates a very high confidence score (Q93).

### Dependencies
Ensure that the following tools are installed and available in your system's `PATH`, as lamassemble relies on them for the underlying alignment logic:
- **LAST**: Specifically `lastal`.
- **MAFFT**: Used for the multiple sequence alignment step.

### Handling Ambiguity
The tool is capable of handling ambiguous base letters in input sequences. If your input contains "U", lamassemble automatically treats it as "T".

### Error Troubleshooting
If the tool crashes with an "error in aa matrix" message, ensure you are using version 1.6.1 or later, which addressed specific matrix handling bugs. Always verify that your `last-train` file matches the sequencing chemistry of your input reads for the most accurate consensus.

## Reference documentation
- [lamassemble Overview](./references/anaconda_org_channels_bioconda_packages_lamassemble_overview.md)
- [lamassemble README](./references/gitlab_com_mcfrith_lamassemble_-_blob_master_README.md)
- [lamassemble Commits](./references/gitlab_com_mcfrith_lamassemble_-_commits_master.md)