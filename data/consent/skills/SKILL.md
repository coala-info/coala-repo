---
name: consent
description: CONSENT performs self-correction of long-read sequencing data and assembly polishing using a combination of multiple sequence alignment and local de Bruijn graphs. Use when user asks to correct errors in PacBio or Oxford Nanopore reads, improve the base-level accuracy of draft assemblies, or perform assembly polishing.
homepage: https://github.com/morispi/CONSENT
---


# consent

## Overview
CONSENT (Scalable long read self-correction and assembly polishing) is a tool designed to handle the high error rates associated with long-read sequencing technologies. It functions by computing overlaps between reads to create alignment piles, which are then processed in independent windows. The tool uses a two-step correction strategy: first, it computes a consensus sequence using multiple sequence alignment (MSA), and then it refines that consensus using a local de Bruijn graph to eliminate remaining errors. Use this skill to prepare high-quality reads for downstream assembly or to improve the base-level accuracy of existing contigs.

## Installation and Environment
CONSENT is available via Bioconda or manual compilation.
*   **Conda**: `conda install bioconda::consent`
*   **Manual**: Requires Python 3, g++ (>= 5.5.0), CMake (>= 2.8.2), and Minimap2.
*   **Path**: Ensure `minimap2` is available in your system PATH, as CONSENT relies on it for overlap computation.

## Self-Correction Workflow
To correct raw long reads, use the `CONSENT-correct` command.

### Basic Usage
```bash
./CONSENT-correct --in longReads.fasta --out correctedReads.fasta --type [PB|ONT]
```
*   `--type PB`: Use for PacBio reads.
*   `--type ONT`: Use for Oxford Nanopore reads.

### Performance Tuning
*   **Parallelization**: Use `--nproc` (or `-j`) to specify the number of threads. It defaults to the number of available cores.
*   **Memory Management**: If running on a machine with limited RAM, use `--minimapIndex` (default 500M) to control the size of the Minimap2 index splits.
*   **Temporary Storage**: CONSENT generates large overlap files. Use `--tmpdir` (or `-t`) to point to a high-capacity scratch disk to avoid filling up the working directory.

## Assembly Polishing Workflow
To improve a draft assembly using raw long reads, use the `CONSENT-polish` command.

### Basic Usage
```bash
./CONSENT-polish --contigs draft_assembly.fasta --reads raw_reads.fasta --out polished_assembly.fasta
```

## Advanced Parameter Optimization
Adjust these parameters to balance sensitivity and execution time:

*   **Window Configuration**:
    *   `--windowSize` (default: 500): Smaller windows may increase sensitivity in highly divergent regions but increase overhead.
    *   `--windowOverlap` (default: 50): Ensures continuity between processed windows.
*   **Support Thresholds**:
    *   `--minSupport` (default: 4): Minimum number of overlapping reads required to attempt correction on a window.
    *   `--maxSupport` (default: 150): Caps the number of overlaps in a pile to prevent bottlenecks in high-coverage regions.
*   **Polishing Logic**:
    *   `--merSize` (default: 9): The k-mer size used for the local de Bruijn graph.
    *   `--solid` (default: 4): The minimum frequency for a k-mer to be considered "solid" during the graph-based polishing phase.

## Expert Tips
*   **Input Formats**: CONSENT accepts both FASTA and FASTQ formats for input reads and contigs.
*   **Resource Estimation**: For a standard 10x coverage dataset, correction typically requires ~750 MB of RAM and takes a few minutes. Scale your resource requests linearly with coverage and genome size.
*   **Cleanup**: If a run fails, check the `--tmpdir` for leftover `.paf` files which can consume significant disk space.

## Reference documentation
- [CONSENT GitHub Repository](./references/github_com_morispi_CONSENT.md)
- [Bioconda CONSENT Package](./references/anaconda_org_channels_bioconda_packages_consent_overview.md)