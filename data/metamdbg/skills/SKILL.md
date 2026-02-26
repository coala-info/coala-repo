---
name: metamdbg
description: MetaMDBG is a memory-efficient assembler designed for large-scale long-read metagenomics using a minimizer de-Bruijn graph framework. Use when user asks to assemble PacBio HiFi or Nanopore metagenomic reads, perform multi-sample co-assembly, or generate assembly graphs in GFA format.
homepage: https://github.com/GaetanBenoitDev/metaMDBG
---


# metamdbg

## Overview

MetaMDBG is a lightweight, memory-efficient assembler tailored for long-read metagenomics. It leverages a minimizer de-Bruijn graph (MDBG) framework to handle the high complexity and uneven species coverage typical of metagenomic samples. It is particularly useful for researchers working with PacBio HiFi or high-accuracy Nanopore (R10.4+) data who require a fast assembly pipeline that includes built-in polishing and a robust checkpoint system for large-scale runs.

## Core Workflows

### Basic Assembly

The primary command is `metaMDBG asm`. You must specify an output directory and at least one input file.

**PacBio HiFi Assembly:**
```bash
metaMDBG asm --out-dir ./output_hifi --in-hifi reads.fastq.gz --threads 8
```

**Nanopore (R10.4+) Assembly:**
```bash
metaMDBG asm --out-dir ./output_ont --in-ont reads.fastq.gz --threads 8
```

**Multi-sample Co-assembly:**
Pass multiple filenames separated by spaces to the input flag.
```bash
metaMDBG asm --out-dir ./coassembly --in-ont sample1.fq sample2.fq sample3.fq --threads 16
```

### Generating Assembly Graphs

After a successful assembly, you can generate a GFA file to inspect the graph topology.

1. **Identify available k-values:**
   ```bash
   metaMDBG gfa --assembly-dir ./outputDir --k 0
   ```
2. **Generate the graph:**
   Choose a k-value from the previous step (e.g., 21).
   ```bash
   metaMDBG gfa --assembly-dir ./outputDir --k 21 --threads 4
   ```
   *Optional flags:* Use `--contigpath` and `--readpath` to map contigs and reads onto the graph.

## Expert Tips and Best Practices

### Performance and Resource Management
- **Checkpoint System:** MetaMDBG automatically saves progress. If a run is interrupted, simply re-run the exact same command to resume from the last completed step.
- **Memory Scaling:** For extremely large datasets, use `--min-abundance 2` to filter out unique k-min-mers. This significantly reduces memory usage and speeds up the process, though it may slightly impact the assembly of very low-abundance species.
- **K-mer Density:** You can adjust `--density-assembly` (default is often sufficient) to control the fraction of k-mers used. For example, `--density-assembly 0.002` uses 0.2% of total k-mers.

### Data Quality and Filtering
- **Read Quality:** If working with lower quality ONT data, use `--min-read-quality 10` to filter reads by Phred score before assembly.
- **Correction Step:** For Nanopore data, MetaMDBG performs a correction step by default. If you have pre-corrected reads or want to save time, use `--skip-correction`.
- **Tuning Correction:** You can refine the ONT correction by adjusting `--min-read-identity` (e.g., 0.97) and `--min-read-overlap` (e.g., 2000).

### Interpreting Results
The primary output is `contigs.fasta.gz` in the output directory. Contig headers contain metadata:
- `length`: Total base pairs.
- `coverage`: Estimated read coverage.
- `circular`: `yes` or `no` (useful for identifying complete circular genomes/plasmids).

## Reference documentation
- [MetaMDBG GitHub Repository](./references/github_com_GaetanBenoitDev_metaMDBG.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_metamdbg_overview.md)