---
name: mccortex
description: McCortex is a suite of tools that uses colored de Bruijn graphs for population-scale de novo assembly and variant calling. Use when user asks to build or clean genomic graphs, call variants in reference-guided or reference-free contexts, or generate automated pipelines for joint calling.
homepage: https://github.com/mcveanlab/mccortex
metadata:
  docker_image: "quay.io/biocontainers/mccortex:1.0--h24782f9_7"
---

# mccortex

## Overview

McCortex is a powerful suite of modular tools designed for population-scale genomics. It utilizes colored de Bruijn graphs to represent multiple samples within a single data structure, enabling efficient de novo assembly and variant calling. Unlike traditional mappers, McCortex can identify variants (SNPs, indels, and large structural events) in both reference-guided and reference-free contexts. It is particularly effective for resolving complex genomic regions by integrating "links" (long-range connectivity information from reads) into the graph structure.

## Installation and Compilation

McCortex is compiled for specific maximum k-mer sizes. If you need k-mers larger than 31, you must ensure the binary is compiled accordingly.

- **Conda**: `conda install bioconda::mccortex`
- **Source**: 
  - For k up to 31: `make all MAXK=31`
  - For k up to 63: `make all MAXK=63`
- **Executables**: The resulting binaries are named by their k-mer limit (e.g., `mccortex31`, `mccortex63`).

## Core Workflow Patterns

### 1. Project Configuration
Create a `samples.txt` file to define your population. The format is:
`#sample_name SE_files PE_files interleaved_files`
Example:
`SampleA read1.fq,read2.fq read_R1.fq:read_R2.fq .`

### 2. Automated Pipeline Generation
For complex workflows (multi-kmer, joint calling), use the `make-pipeline.pl` script to generate a Makefile. This is the most reliable way to ensure all intermediate steps (build, clean, join, link) are executed in the correct order.

```bash
# Generate a pipeline for k=31 and k=61
mccortex/scripts/make-pipeline.pl -r ref.fa --ploidy 2 31,61 output_dir samples.txt > job.mk

# Execute the pipeline
make -f job.mk CTXDIR=/path/to/mccortex MEM=70GB NTHREADS=8 JOINT_CALLING=yes brk-geno-vcf
```

### 3. Manual Command Usage
If running individual modules, follow these common patterns:

- **Build a graph**:
  `mccortex31 build -m 2GB -t 4 -k 31 --sample Sample1 --seq reads.fq sample1.ctx`
- **Clean a graph** (remove low-coverage tips and unitigs):
  `mccortex31 clean -m 2GB -o cleaned.ctx raw.ctx`
- **View graph statistics**:
  `mccortex31 view --info sample.ctx`
- **Call variants (Bubbles)**:
  `mccortex31 bubbles -m 10GB -o calls.txt graph.ctx`

## Expert Tips and Best Practices

- **Memory Allocation**: Always specify memory explicitly with `-m`. For human genomes, 70GB-100GB is typical. For small bacterial genomes, 2GB-5GB is usually sufficient.
- **K-mer Selection**: Use smaller k-mers (e.g., 31) for sensitivity in low-coverage regions and larger k-mers (e.g., 61 or 91) to resolve repeats in high-coverage data.
- **Ploidy Handling**: When working with human data, use the `-P` flag in the pipeline script to correctly handle sex chromosomes (e.g., `-P Mickey:chrX:1` for a male sample).
- **Links**: Use the `thread` command to create `.ctp` (link) files from reads. This significantly improves assembly contiguity by allowing the assembler to "jump" over small repeats that would otherwise cause branches in the graph.
- **VCF Genotyping**: If you have an existing VCF of known variants, use `vcfcov` and `vcfgeno` to genotype those variants across your Cortex population graph without re-mapping reads.

## Reference documentation
- [McCortex GitHub Repository](./references/github_com_mcveanlab_mccortex.md)
- [McCortex Wiki](./references/github_com_mcveanlab_mccortex_wiki.md)