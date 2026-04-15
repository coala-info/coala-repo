---
name: mashtree
description: Mashtree generates phylogenetic trees from genomic sequences using the Mash algorithm to estimate distances without multiple sequence alignment. Use when user asks to create a phylogenetic tree from raw reads or assemblies, calculate genomic distance matrices, or perform bootstrapping and jackknifing for tree confidence.
homepage: https://github.com/lskatz/mashtree
metadata:
  docker_image: "quay.io/biocontainers/mashtree:1.4.6--pl5321h7b50bb2_3"
---

# mashtree

## Overview

Mashtree is a bioinformatics tool designed for the high-speed generation of phylogenetic trees. Instead of performing computationally expensive multiple sequence alignments, it utilizes the Mash algorithm (MinHash) to estimate genomic distances. It is highly versatile, accepting raw sequencing reads (Fastq) or assemblies (Fasta, GenBank, EMBL) as input, and produces standard Newick files (.dnd) that can be used in any tree-viewing software.

## Core CLI Usage

### Basic Tree Generation
The simplest way to create a tree from a directory of genomic files:
```bash
mashtree *.fastq.gz > tree.dnd
```

### High-Accuracy Mode
For more reliable trees, especially when working with raw reads, use the smart minimum abundance finder to filter out k-mers likely to be sequencing errors:
```bash
mashtree --mindepth 0 --numcpus 12 *.fastq.gz > mashtree.dnd
```

### Generating Distance Matrices
If you require the raw distance values in addition to the tree:
```bash
mashtree --outmatrix distances.tab *.fasta > tree.dnd
```

## Confidence Values (Bootstrapping & Jackknifing)

Mashtree includes specialized Perl wrappers to add support for branch confidence.

### Bootstrapping
Runs the sketching process multiple times with different random seeds:
```bash
mashtree_bootstrap.pl --reps 100 --numcpus 12 *.fastq.gz -- --min-depth 0 > mashtree.bootstrap.dnd
```

### Jackknifing
Uses 50% of the hashes for each iteration to calculate confidence:
```bash
mashtree_jackknife.pl --reps 100 --numcpus 12 *.fastq.gz -- --min-depth 0 > mashtree.jackknife.dnd
```
*Note: Arguments following the double-dash (`--`) are passed directly to the underlying mashtree call.*

## Expert Tips and Best Practices

- **Input Interpretation**: Mashtree automatically distinguishes between reads and assemblies. `.fastq` files are treated as raw reads (where k-mer abundance matters), while `.fasta`, `.gbk`, and `.embl` are treated as assemblies.
- **Caching for Iterative Runs**: Use the `--tempdir` flag to point to a persistent directory. Mashtree will store sketches (.msh files) there, allowing subsequent runs with new samples to skip re-processing existing ones.
- **Handling Large Datasets**: If you have thousands of files, avoid shell "argument list too long" errors by using a file-of-files:
  ```bash
  ls *.fastq.gz > file_list.txt
  mashtree --file-of-files file_list.txt > tree.dnd
  ```
- **Memory and CPU**: Mashtree is threaded. Always specify `--numcpus` to match your environment, as the default is often 1.
- **Filename Truncation**: If your filenames are long and causing issues in the Newick output, use `--truncLength` to control the number of characters preserved in the tree leaf labels.

## Reference documentation
- [Mashtree GitHub Repository](./references/github_com_lskatz_mashtree.md)
- [Bioconda Mashtree Overview](./references/anaconda_org_channels_bioconda_packages_mashtree_overview.md)