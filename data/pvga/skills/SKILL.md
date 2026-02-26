---
name: pvga
description: PVGA performs precise assembly and polishing of viral sequences using an iterative alignment graph approach. Use when user asks to assemble viral genomes, polish viral sequences, or perform iterative refinement of a consensus sequence using a backbone.
homepage: https://github.com/SoSongzhi/PVGA
---


# pvga

## Overview

PVGA (Precise Viral Genome Assembler) is a specialized tool designed for the assembly and polishing of viral sequences. Unlike general-purpose assemblers, PVGA focuses on high-accuracy results by using an iterative alignment graph approach. It requires an initial backbone sequence (reference) and sequencing reads. The tool aligns reads to the backbone, constructs an alignment graph, and uses dynamic programming to determine the optimal path (the new consensus). This process repeats, using the updated sequence as the new backbone, until the assembly is refined.

## Installation and Dependencies

PVGA requires `blasr` for alignments. It is recommended to install via Conda to manage dependencies automatically.

```bash
# Recommended installation
conda create -n pvga python=3.10
conda activate pvga
conda install bioconda::blasr
conda install bioconda::pvga
```

## Command Line Usage

The primary command is `pvga`. You must provide the reads, a backbone sequence, and an output directory.

### Basic Assembly
To run a standard assembly with default settings:
```bash
pvga -r reads.fastq -b reference.fa -o assembly_results
```

### Refined Iterative Assembly
To control the depth of refinement, specify the number of iterations using the `-n` flag:
```bash
pvga -r reads.fastq -b reference.fa -n 10 -o assembly_results
```

### Argument Reference
- `-r`, `--reads`: Path to input reads (FASTQ or FASTA).
- `-b`, `--backbone`: Path to the reference genome or backbone sequence (FASTA).
- `-n`, `--iterations`: (Optional) Number of refinement cycles.
- `-o`, `--output_dir`: Directory for output sequences, logs, and reports.

## Best Practices and Expert Tips

### Handling Paired-End Reads
PVGA processes reads in a single-end format. For paired-end data, do not simply concatenate files if you wish to preserve merging information. The recommended workflow is to merge reads using `bbmerge` before running PVGA:

```bash
# Merge paired-end reads
bbmerge.sh in1=r1.fastq in2=r2.fastq out=merged.fastq outu1=un1.fastq outu2=un2.fastq

# Combine all for PVGA input
cat merged.fastq un1.fastq un2.fastq > all_reads.fastq

# Run PVGA
pvga -r all_reads.fastq -b ref.fa -o output_dir
```

### Iteration Constraints
Avoid setting `-n 1` if you encounter an `UnboundLocalError`. There is a known issue where the tool may fail to assign specific result variables when only one iteration is requested. If you only need a quick pass, use the default or a small number like 2 or 3.

### Performance with Long Reads
When using Oxford Nanopore (ONT) long reads, be aware that assembly time may increase significantly. Ensure your backbone sequence is as closely related to the target as possible to speed up the alignment graph construction.

### Troubleshooting Common Issues
- **IndexError**: If assembling very small segments (e.g., specific viral segments from Flongle runs), the tool may occasionally throw an index error if read coverage or alignment density is insufficient.
- **Snakemake Integration**: If running PVGA within a Snakemake workflow, ensure the shell environment correctly points to the `blasr` executable, as some users report failures when run inside automated rules compared to manual bash execution.

## Reference documentation
- [PVGA Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pvga_overview.md)
- [PVGA GitHub Repository](./references/github_com_SoSongzhi_PVGA.md)
- [PVGA Known Issues](./references/github_com_SoSongzhi_PVGA_issues.md)