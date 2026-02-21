---
name: pbaa
description: The PacBio Amplicon Analysis (pbaa) tool is a specialized suite for processing HiFi (High Fidelity) amplicon data.
homepage: https://github.com/PacificBiosciences/pbAA
---

# pbaa

## Overview

The PacBio Amplicon Analysis (pbaa) tool is a specialized suite for processing HiFi (High Fidelity) amplicon data. It employs a reference-aided, pseudo de-novo approach to separate complex mixtures of sequences. By clustering reads based on shared variants and generating consensus sequences, pbaa can resolve alleles with single-nucleotide variants (SNVs) or large indels. This tool is essential for researchers working with highly polymorphic regions where traditional assembly or variant calling might fail to distinguish between closely related alleles.

## Core CLI Usage

### 1. Clustering and Consensus
The primary command is `pbaa cluster`. It requires indexed guide sequences and indexed HiFi reads.

```bash
pbaa cluster [options] <guide.fasta> <reads.fastq> <output_prefix>
```

**Required Inputs:**
- **Guide Input**: Reference sequences in FASTA format. Must be indexed with `samtools faidx`.
- **Read Input**: De-multiplexed HiFi reads in FASTQ format. Must be indexed with `samtools fqidx`.
- **Prefix**: String used for naming the three output files: `{prefix}_passed_cluster_sequences.fasta`, `{prefix}_failed_cluster_sequences.fasta`, and `{prefix}_read_info.txt`.

### 2. Visualizing Clusters (BAM Painting)
To visualize results in IGV, use `bampaint` to add color tags to an existing BAM file based on the pbaa clustering results.

```bash
pbaa bampaint <read_info.txt> <input.bam> <output.bam>
```
This adds `HP` (grouping) and `YC` (coloring) tags to the BAM records.

## Expert Tips and Best Practices

### Guide Sequence Selection
- **Avoid Whole Chromosomes**: Do not use large genomic regions or chromosomes as guides. Guides should contain the amplified region and minimal flanking sequence.
- **Locus Grouping**: Use the naming convention `AlleleName|LocusName` in your guide FASTA. pbaa will group all reads assigned to any allele with the same `LocusName` into a single clustering pool.
- **Divergence**: Ensure guide sequences are sufficiently divergent. If guides are too similar, the number of un-placed reads will increase due to a lack of informative k-mers.

### Input Preparation
- **HiFi Only**: pbaa is strictly for HiFi data (>QV20). It will not work on CLR (Continuous Long Read) data.
- **Indexing**: Always run `samtools faidx guide.fasta` and `samtools fqidx reads.fastq` before starting.
- **Batching**: For multiple samples, you can provide a FOFN (File Of File Names) containing the full paths to your input files instead of a single file path.

### Parameter Tuning
- **--min-read-qv**: Default is 20. If you have extremely high-quality data, increasing this can reduce noise, but may lower yield.
- **--max-amplicon-size**: Default is 15000. Ensure this is set higher than your longest expected fragment.
- **--min-cluster-frequency**: Default is 0.1. For detecting rare alleles or minor variants in a population, lower this value (e.g., 0.01 or 0.02), but be prepared for more potential noise.
- **--max-uchime-score**: Default is 1. This filters chimeric sequences. If you suspect valid alleles are being filtered as chimeras, check the `{prefix}_failed_cluster_sequences.fasta` file.

### Interpreting Results
- **uchime_score**: Higher scores indicate a higher probability of a chimera.
- **cluster_freq**: Represents the fraction of reads in the locus assigned to that specific cluster.
- **diversity**: Indicates the internal variation within the cluster; high diversity might suggest the cluster should have been split further or contains significant noise.

## Reference documentation
- [pbaa README](./references/github_com_PacificBiosciences_pbAA_blob_main_README.md)
- [Guide Reference Documentation](./references/github_com_PacificBiosciences_pbAA_blob_main_guide_reference.md)