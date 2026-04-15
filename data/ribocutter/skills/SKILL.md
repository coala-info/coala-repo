---
name: ribocutter
description: Ribocutter identifies high-abundance contaminant sequences in sequencing libraries and designs sgRNA oligos for their depletion. Use when user asks to design sgRNAs for sequence depletion, identify library contaminants, or generate reports on abundant sequences in fastq files.
homepage: https://github.com/Delayed-Gitification/ribocutter.git
metadata:
  docker_image: "quay.io/biocontainers/ribocutter:0.1.1--pyh5e36f6f_0"
---

# ribocutter

## Overview
Ribocutter is a specialized bioinformatics tool designed to improve the signal-to-noise ratio in sequencing libraries by targeting and depleting unwanted, high-abundance sequences. It analyzes adaptor-trimmed fastq files to identify the most prevalent contaminants and outputs the specific oligo sequences required to create sgRNAs for their depletion. This is particularly useful in Ribo-seq experiments where ribosomal RNA often dominates the library.

## Usage Guidelines

### Core Command Pattern
The basic execution requires an input file and an output prefix:
```bash
ribocutter <input.fastq.gz> <output_prefix>
```

### Key Parameters and Optimization
- **Guide Count**: Control the number of oligos designed using the `-n` or `--num_guides` flag. Increasing the number of guides increases the fraction of the library targeted ($f$), which improves the fold-increase in useful reads ($1/(1-f)$).
- **Flanking Sequences**: If targeting very short sequences, use `--five_prime` or `--three_prime` to provide context. Note that this increases off-target risks; keep these additions as short as possible.
- **Library Statistics**: Use the `--save_stats` flag to generate detailed reports on the copy numbers of abundant sequences within your library.
- **Background Avoidance**: While a background fasta can be provided to avoid specific targets, it is generally recommended to prioritize depletion efficiency over minor off-target effects in Ribo-seq workflows.

### Critical Requirements
- **Pre-processing**: Input fastq files **must** be adaptor-trimmed before running ribocutter.
- **Efficiency Rule of Thumb**: Ribocutter is most effective when the targeted fraction ($f$) is $>50\%$. If $f = 0.67$, you achieve a 3-fold increase in useful data. If $f$ is significantly lower than $0.5$, the experimental overhead of the depletion protocol may outweigh the sequencing gains.

## Reference documentation
- [Ribocutter GitHub Repository](./references/github_com_Delayed-Gitification_ribocutter.md)