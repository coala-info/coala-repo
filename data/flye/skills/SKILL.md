---
name: flye
description: Flye is a de novo assembler designed to transform long-read sequencing data into high-quality contigs using a repeat graph approach. Use when user asks to perform de novo assembly of long reads, assemble metagenomes, or resolve complex genomic repeats from Oxford Nanopore or PacBio data.
homepage: https://github.com/fenderglass/Flye/
---


# flye

## Overview
Flye is a specialized de novo assembler designed for single-molecule sequencing (SMS) reads. Unlike traditional assemblers that rely on exact k-mer matches, Flye utilizes a repeat graph approach that handles the higher error rates typical of long-read technologies. It provides an end-to-end pipeline that transforms raw reads into polished, high-quality contigs. It is particularly effective for resolving complex genomic repeats and is a standard choice for both isolate and metagenomic assembly projects.

## Usage Patterns

### Basic Assembly Commands
Select the input flag based on your specific sequencing technology:

*   **Oxford Nanopore (ONT) High Quality (Guppy5+, Q20, R10.4):**
    `flye --nano-hq reads.fastq.gz --out-dir assembly_output --threads 16`
*   **Standard Oxford Nanopore (Older/Regular):**
    `flye --nano-raw reads.fastq.gz --out-dir assembly_output`
*   **PacBio HiFi (CCS):**
    `flye --pacbio-hifi reads.fastq.gz --out-dir assembly_output`
*   **PacBio Raw (CLR):**
    `flye --pacbio-raw reads.fastq.gz --out-dir assembly_output`

### Metagenome Assembly
For environmental samples or mixed microbial communities, use the `--meta` flag to handle highly non-uniform coverage:
`flye --nano-hq reads.fastq.gz --meta --out-dir meta_assembly`

### Specialized Parameters
*   **Estimated Genome Size:** Providing an estimate helps with initial overlap parameters.
    `--genome-size 5m` (for a typical bacterium)
*   **Minimum Overlap:** Flye automatically selects this, but you can override it for difficult assemblies.
    `--min-overlap 5000`
*   **Iterative Polishing:** By default, Flye performs one round of polishing. Increase this for higher consensus accuracy.
    `--iterations 3`
*   **Resuming a Run:** If a run was interrupted, use the same output directory to resume from the last completed stage.
    `flye --nano-hq reads.fastq.gz --out-dir assembly_output --resume`

## Expert Tips
*   **Read Quality:** For ONT data, `--nano-hq` is now the recommended default for most modern datasets (3-5% error rate). Use `--nano-raw` only for very old or high-error datasets (>10%).
*   **Haplotype Resolution:** Flye typically produces collapsed diploid assemblies. If you need to recover phased haplotypes, run a tool like HapDup on the Flye output.
*   **Short Sequences:** Version 2.9+ has improved recovery for small plasmids and viruses. The `--plasmid` flag is deprecated as these are now captured by the default pipeline.
*   **Memory Management:** For large mammalian genomes, ensure you have significant RAM (e.g., 400GB+ for human ONT). Use `--asm-coverage` (e.g., `--asm-coverage 50`) to limit the data used for initial graph construction if memory is a bottleneck.

## Reference documentation
- [Flye GitHub Repository](./references/github_com_mikolmogorov_Flye.md)
- [Flye Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_flye_overview.md)