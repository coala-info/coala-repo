---
name: efishent
description: eFISHent is a command-line utility designed to streamline the creation of high-performance RNA FISH probes.
homepage: https://github.com/bbquercus/eFISHent/
---

# efishent

## Overview
eFISHent is a command-line utility designed to streamline the creation of high-performance RNA FISH probes. It transforms a target gene sequence into a set of non-overlapping, filtered oligonucleotides by applying thermodynamic constraints and genomic specificity checks. Use this skill to generate probe sets that are optimized for maximum coverage while minimizing background noise and off-target hybridization.

## Core Workflows

### 1. Reference Index Preparation
Before designing probes, you must build indices for your reference genome. This is a one-time requirement per genome.
```bash
eFISHent --reference-genome <path_to_fasta> --build-indices True
```

### 2. Probe Design Patterns
Probes can be designed using three different input methods for the target sequence.

**Via Gene Name and Organism (Automatic Download):**
```bash
eFISHent --reference-genome <genome.fa> --gene-name GAPDH --organism-name "Homo sapiens"
```

**Via Ensembl ID:**
```bash
eFISHent --reference-genome <genome.fa> --ensembl-id ENSG00000111640 --organism-name "Homo sapiens"
```

**Via Local FASTA File:**
```bash
eFISHent --reference-genome <genome.fa> --sequence-file <target_gene.fa>
```

### 3. Optimization Selection
Choose an optimization method based on the gene length and required precision:
*   **Greedy (`--optimization-method greedy`):** Faster (O(n)), suitable for very long transcripts or quick iterations.
*   **Mathematical:** More computationally intensive but ensures theoretically optimal coverage.

## Expert Tips and Best Practices
*   **Resource Preparation:** Ensure you have the reference genome (.fa) and annotations (.gtf) unzipped before running the tool.
*   **Off-target Weighting:** If working with short genes where off-targets are difficult to avoid, provide a count table to weight off-targets against highly expressed genes in your specific cell line.
*   **Environment:** eFISHent requires a Linux or macOS environment due to dependencies like `bowtie`, `jellyfish`, and `RNAstructure`. On Windows, use WSL.
*   **Sequence Retrieval:** When using `--gene-name`, always provide the `--organism-name` to prevent Entrez from fetching orthologs from unintended species.

## Reference documentation
- [eFISHent GitHub Repository](./references/github_com_BBQuercus_eFISHent.md)