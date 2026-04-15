---
name: probconsrna
description: probconsrna generates high-accuracy multiple sequence alignments for RNA sequences using a consistency-based algorithm. Use when user asks to align RNA sequences, perform multiple sequence alignment with structural conservation, or generate alignments in ClustalW or MFA formats.
homepage: http://probcons.stanford.edu/
metadata:
  docker_image: "quay.io/biocontainers/probconsrna:1.10--h9f5acd7_4"
---

# probconsrna

## Overview
The `probconsrna` skill provides a specialized workflow for generating multiple sequence alignments of nucleotide sequences. Based on the PROBCONS protein alignment algorithm, this experimental version uses parameters trained on BRAliBASE II to optimize alignments for RNA. It is particularly effective for sequences where structural conservation or evolutionary distance makes standard heuristic alignments unreliable.

## Usage Guidelines

### Basic Alignment
To perform a standard alignment of RNA sequences in a FASTA file:
```bash
probconsrna input.fasta > alignment.mfa
```

### Optimization Parameters
Adjust these flags to balance alignment quality and computational time:

- **Consistency Transformation**: Increase the number of passes to improve accuracy by incorporating information from other sequences.
  - `-c 2` (Default is 2; higher values like 3 can improve accuracy but increase runtime).
- **Iterative Refinement**: Use refinement to polish the final alignment.
  - `-ir 100` (Performs 100 rounds of iterative refinement).
- **Pre-training**: If the sequences have unique characteristics, use pre-training to adjust model parameters.
  - `-pre 10` (Performs 10 rounds of unsupervised training).

### Output Formats
By default, `probconsrna` outputs in MFA (Multi-FASTA) format. For compatibility with other phylogenetic or visualization tools:
- **ClustalW Format**: Use the `-clustalw` flag.
  ```bash
  probconsrna -clustalw input.fasta > alignment.aln
  ```

### Expert Tips
- **RNA Specificity**: Unlike the base `probcons` tool which is for proteins, `probconsrna` is specifically tuned for nucleotides. Do not use it for amino acid sequences.
- **Large Datasets**: Because the consistency-based approach is computationally intensive ($O(N^3)$), for very large datasets (hundreds of sequences), consider reducing consistency reps (`-c 0`) if the process hangs.
- **Pipe Support**: The tool accepts input from stdin, allowing for integration into command-line pipes.

## Reference documentation
- [PROBCONS RNA Overview](./references/anaconda_org_channels_bioconda_packages_probconsrna_overview.md)
- [PROBCONS Help and FAQ](./references/probcons_stanford_edu_help.html.md)
- [PROBCONS Download and Manual](./references/probcons_stanford_edu_download.html.md)