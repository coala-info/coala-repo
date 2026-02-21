---
name: reseq
description: ReSeq is a high-fidelity genomic sequence simulator designed to bridge the gap between synthetic and real-world sequencing data.
homepage: https://github.com/schmeing/ReSeq/tree/devel
---

# reseq

## Overview
ReSeq is a high-fidelity genomic sequence simulator designed to bridge the gap between synthetic and real-world sequencing data. While many simulators produce "optimistic" data that lacks the complexity of real sequencer output, ReSeq reproduces key statistics from real datasets—specifically coverage profiles, systematic errors, and k-mer spectra. It operates by learning these characteristics from existing BAM alignments and applying them to generate new, realistic FASTQ files.

## CLI Usage and Best Practices

### Prerequisites
Before running ReSeq, you must map your real sequencing data to a reference genome to provide the simulator with a baseline for error and coverage profiles.
```bash
# Example mapping with bowtie2
bowtie2 -x reference -1 data_1.fq -2 data_2.fq | samtools sort -o mappings.bam -
```

### The Full Simulation Pipeline
The most common entry point is the `illuminaPE` command, which handles stats creation, probability estimation, and simulation in one go.
```bash
reseq illuminaPE -j 32 -r reference.fa -b mappings.bam -1 sim_1.fq -2 sim_2.fq
```

### Modular Workflow (Recommended for Iteration)
If you plan to run multiple simulations from the same real data profile, split the process into three steps to save time:

1.  **Generate Statistics**: Creates a `.reseq` file from the BAM.
    ```bash
    reseq illuminaPE -j 32 -r reference.fa -b mappings.bam --statsOnly
    ```
2.  **Estimate Probabilities**: Refines the model based on the statistics.
    ```bash
    reseq illuminaPE -j 32 -s mappings.bam.reseq --stopAfterEstimation
    ```
3.  **Simulate Reads**: Generates the final FASTQ files using the estimated model.
    ```bash
    reseq illuminaPE -j 32 -R reference.fa -s mappings.bam.reseq --ipfIterations 0 -1 sim_1.fq -2 sim_2.fq
    ```

### Simulating Biological Variation
To simulate diploid genomes or population-level variation, provide a VCF file using the `-V` flag.
```bash
reseq illuminaPE -j 32 -r reference.fa -b mappings.bam -V variation.vcf -1 sim_1.fq -2 sim_2.fq
```

### Expert Tips
- **Thread Management**: Always use the `-j` flag to specify the number of threads, as ReSeq is computationally intensive.
- **Read Name Formatting**: If your simulation requires tile information (e.g., for flowcell-specific bias), ensure your input read names do not contain spaces. Use the provided helper script to fix names on the fly:
  ```bash
  reseq-prepare-names.py input.fq > fixed.fq
  ```
- **Memory Allocation**: When sorting BAM files for ReSeq, ensure you provide enough memory to `samtools sort` (e.g., `-m 10G`) to prevent bottlenecks during the stats creation phase.

## Reference documentation
- [ReSeq GitHub Repository](./references/github_com_schmeing_ReSeq.md)
- [ReSeq Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_reseq_overview.md)