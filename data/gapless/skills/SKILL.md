---
name: gapless
description: Gapless bridges fragmented genome assemblies by using long-read data to scaffold contigs, fill gaps, and correct assembly errors. Use when user asks to scaffold contigs, fill assembly gaps, or improve a short-read assembly using PacBio or Nanopore reads.
homepage: https://github.com/schmeing/gapless
---


# gapless

## Overview
Gapless is a specialized bioinformatics tool used to bridge the gap between fragmented genome assemblies and high-quality finished genomes. It leverages the long-range information provided by PacBio (CLR or HiFi) and Oxford Nanopore reads to simultaneously scaffold contigs, fill internal gaps, and correct assembly errors. This tool is particularly effective when long-read coverage is insufficient for a de novo long-read-only assembly but can be used to significantly upgrade an existing short-read or hybrid assembly.

## Core Workflows

### Standard Pipeline Execution
The primary way to use gapless is through the `gapless.sh` wrapper script, which automates the multi-step process of splitting, mapping, scaffolding, and polishing.

**Basic Command Structure:**
```bash
gapless.sh -i <assembly.fasta> -t <read_type> -j <threads> <long_reads.fastq>
```

**Read Type Options (`-t`):**
- `pb_clr`: PacBio Continuous Long Reads
- `pb_hifi`: PacBio High-Fidelity (CCS) reads
- `nanopore`: Oxford Nanopore reads

### Common CLI Patterns

**1. High-Performance Run (Human-sized genome)**
For large genomes, increase the thread count and ensure the input is indexed.
```bash
gapless.sh -j 30 -i assembly.fa.gz -t pb_hifi data_hifi.fq.gz
```

**2. Iterative Refinement**
By default, the tool runs 3 iterations. You can adjust this based on the complexity of the assembly.
```bash
gapless.sh -n 5 -i assembly.fa -t nanopore reads.fq
```

**3. Restarting or Resuming**
If a run was interrupted or you wish to change parameters starting from a specific iteration:
- Use `-s <int>` to start at a specific iteration (previous results must exist in the output directory).
- Use `-r` to force a restart and overwrite existing files.

## Expert Tips and Best Practices

- **External Dependencies**: Ensure `minimap2`, `racon`, and `seqtk` are in your PATH. These are required by the shell script for mapping and consensus generation.
- **Memory Management**: For very large genomes (e.g., >2.1 Gb), use the `--largeGenome` flag if calling the underlying `gapless.py scaffold` step manually to handle large coordinate values.
- **Output Location**: The final improved assembly is always linked to `gapless_run/gapless.fa`. Intermediate files, including statistics and split contigs, are stored within the `gapless_run` directory.
- **Quality Assessment**: Use the `-s` flag in the scaffolding step to generate a PDF of statistics. This helps visualize how many contigs were successfully bridged or broken.
- **Contig Breaking**: Gapless can break contigs where long-read evidence suggests a misassembly. If the tool is being too aggressive or too conservative, adjust `--minLenBreak` (default 600bp).

## Reference documentation
- [github_com_schmeing_gapless.md](./references/github_com_schmeing_gapless.md)
- [anaconda_org_channels_bioconda_packages_gapless_overview.md](./references/anaconda_org_channels_bioconda_packages_gapless_overview.md)