---
name: raven-assembler
description: Raven is a fast and memory-efficient de novo assembler designed for third-generation sequencing data. Use when user asks to perform de novo assembly of long reads, generate assembly graphs in GFA format, or polish genomic sequences using GPU acceleration.
homepage: https://github.com/lbcb-sci/raven
metadata:
  docker_image: "quay.io/biocontainers/raven-assembler:1.8.3--h5ca1c30_3"
---

# raven-assembler

## Overview
Raven is a fast and memory-efficient de novo assembler designed specifically for third-generation sequencing data. It processes raw, uncorrected reads by finding overlaps using minimizers, constructing a simplified assembly graph, and performing automated polishing rounds. It is particularly useful for rapid assembly of bacterial and small eukaryotic genomes where high-accuracy long reads or error-correction pre-processing might be unavailable.

## Installation and Setup
The most reliable way to deploy Raven is via Bioconda:
```bash
conda install -c bioconda raven-assembler
```

## Core CLI Usage
The basic syntax requires one or more input files (FASTA/FASTQ, can be gzipped). By default, Raven outputs the assembled contigs in FASTA format to `stdout`.

### Basic Assembly
```bash
raven -t 8 reads.fastq.gz > assembly.fasta
```

### Generating Assembly Graphs
To inspect the assembly structure or use downstream visualization tools (like Bandage), output the graph in GFA format:
```bash
raven -t 16 --graphical-fragment-assembly assembly.gfa reads.fastq.gz > assembly.fasta
```

### GPU Acceleration
If Raven was built with CUDA support, you can significantly speed up the polishing (Racon) phase:
```bash
raven -t 16 -c 1 -b reads.fastq.gz > assembly.fasta
```
*   `-c`: Number of batches for CUDA accelerated polishing.
*   `-b`: Enables banded alignment on GPU.

## Expert Parameters and Best Practices

### Tuning Overlap Sensitivity
*   **K-mer Length (`-k`)**: Default is 15. For very high error rates, decreasing this might find more overlaps, but increases noise.
*   **Window Length (`-w`)**: Default is 5. Controls the density of minimizers.
*   **Frequency Threshold (`-f`)**: Default is 0.001. Ignores the top 0.1% most frequent minimizers to avoid repetitive regions. Increase this if the assembly is missing genomic content due to high-copy repeats.

### Polishing and Unitigs
*   **Polishing Rounds (`-p`)**: Raven runs Racon internally. The default is 2 rounds. For higher consensus accuracy, you can increase this to 4, though returns diminish quickly.
*   **Minimum Unitig Size (`-u`)**: Default is 9999. Raven filters out small, likely spurious unitigs. For very small viral genomes or plasmids, you may need to lower this value.

### Workflow Management
*   **Checkpoints**: Raven creates a `raven.cereal` file in the working directory to store intermediate states.
*   **Resuming**: If a run is interrupted, use the `--resume` flag to pick up from the last completed stage.
*   **Cleanup**: If you do not want the checkpoint file (e.g., in automated pipelines with limited disk space), use `--disable-checkpoints`.

## Common Troubleshooting
*   **No Output**: Ensure the input file format is correct. Raven expects FASTA or FASTQ. If the input is too small or the overlap parameters are too stringent, it may fail to find enough overlaps to form unitigs.
*   **Memory Issues**: While efficient, large genomes (e.g., human) still require significant RAM. Monitor the `raven.cereal` file size as it can grow quite large during the overlap phase.
*   **Identity Threshold (`-i`)**: If you have very high-quality reads (e.g., PacBio HiFi), you can set a minimum identity threshold (e.g., `-i 0.95`) to reduce the complexity of the overlap graph.

## Reference documentation
- [github_com_lbcb-sci_raven.md](./references/github_com_lbcb-sci_raven.md)
- [anaconda_org_channels_bioconda_packages_raven-assembler_overview.md](./references/anaconda_org_channels_bioconda_packages_raven-assembler_overview.md)