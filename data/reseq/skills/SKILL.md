---
name: reseq
description: ReSeq simulates Illumina sequencing reads by extracting error profiles and biases from real BAM mappings to create realistic synthetic datasets. Use when user asks to simulate genomic reads, replicate sequencing biases from a BAM file, or generate ground truth datasets with specific variants.
homepage: https://github.com/schmeing/ReSeq/tree/devel
metadata:
  docker_image: "quay.io/biocontainers/reseq:1.1--py310hfb68e69_5"
---

# reseq

## Overview
ReSeq (Real Sequence Reproducer) is a specialized genomic simulator designed to bridge the gap between synthetic and real-world Illumina sequencing data. Unlike general simulators that use idealized models, ReSeq extracts key statistics from existing BAM mappings to replicate the specific biases of a sequencer, chemistry, or library preparation. It is particularly effective for creating "ground truth" datasets that maintain the complexity of real sequencing experiments, including systematic errors and GC-content biases.

## Core Workflows

### Full Simulation Pipeline
To generate simulated reads from a reference genome based on a real dataset, use the `illuminaPE` command. This performs stats creation, probability estimation, and simulation in one pass.

```bash
reseq illuminaPE -j <threads> -r <ref.fa> -b <mappings.bam> -1 <out_R1.fq> -2 <out_R2.fq>
```

### Modular Execution
For iterative testing or large-scale simulations, it is more efficient to split the process. This allows you to reuse the estimated error profiles (`.reseq` file) without re-processing the original BAM.

1. **Generate Statistics Only**:
   ```bash
   reseq illuminaPE -j 32 -r reference.fa -b real_mappings.bam --statsOnly
   ```
2. **Estimate Probabilities**:
   ```bash
   reseq illuminaPE -j 32 -s real_mappings.bam.reseq --stopAfterEstimation
   ```
3. **Simulate Reads (Repeatable Step)**:
   ```bash
   reseq illuminaPE -j 32 -R reference.fa -s real_mappings.bam.reseq --ipfIterations 0 -1 sim_R1.fq -2 sim_R2.fq
   ```

### Simulating Populations and Variants
To simulate diploid genomes or specific populations, provide a VCF file containing the desired variations.

```bash
reseq illuminaPE -j 32 -R ref.fa -s profile.reseq -V variations.vcf -1 out_1.fq -2 out_2.fq
```

## Expert Tips & Best Practices

- **Read Name Preparation**: If your simulation requires tile-specific information (e.g., for optical duplicate analysis), ensure read names in your input FASTQ/BAM do not contain spaces. Use the provided helper script to sanitize names before mapping:
  ```bash
  reseq-prepare-names.py data_1.fq data_2.fq
  ```
- **Profile Selection**: Always train ReSeq on a dataset that matches your target experiment's parameters (sequencer model, PCR cycles, fragmentation method). Training on a closely related species ensures the GC-content profile space is adequately populated.
- **Performance**: Use the `-j` flag to specify the number of threads. ReSeq is highly parallelizable, especially during the stats creation and simulation phases.
- **Memory Management**: When mapping real data for profile creation (e.g., with `bowtie2`), ensure the BAM is sorted by coordinate to allow ReSeq to process the genome efficiently.



## Subcommands

| Command | Description |
|---------|-------------|
| reseq illuminaPE | ReSeq version 1.1 in illuminaPE mode |
| reseq queryProfile | Runs ReSeq in queryProfile mode |
| reseq replaceN | Replace Ns in reference sequences |
| reseq seqToIllumina | Converts a FASTA file to FASTQ format with simulated sequencing errors. |
| reseq test | Runs ReSeq in test mode |

## Reference documentation
- [ReSeq GitHub README](./references/github_com_schmeing_ReSeq_blob_master_README.md)