---
name: probcons-extra
description: PROBCONS performs multiple protein sequence alignment using hidden Markov models and consistency-based scoring to maximize accuracy. Use when user asks to align multiple protein sequences, perform iterative refinement, generate MFA or ClustalW outputs, or compute EM parameter training.
homepage: http://probcons.stanford.edu/
metadata:
  docker_image: "biocontainers/probcons-extra:v1.12-12-deb_cv1"
---

# probcons-extra

## Overview
PROBCONS is a specialized tool for aligning multiple protein sequences by combining hidden Markov models with a consistency-based scoring function. It is designed to maximize the expected number of correctly aligned residues. Use this skill to execute command-line alignments, optimize refinement parameters, and generate outputs in MFA or ClustalW formats.

## Command Line Usage
The basic syntax for running PROBCONS is:
`probcons [OPTIONS] [MFA_FILE] > [OUTPUT_FILE]`

### Common Options
- `-c, --consistency REPS`: Set the number of passes of consistency transformation (default: 2). Increasing this can improve accuracy for distant homologs.
- `-ir, --iterative-refinement REPS`: Set the number of passes of iterative refinement (default: 100).
- `-pre, --pre-training REPS`: Set the number of rounds of pre-training (default: 0).
- `-clustalw`: Output the alignment in CLUSTALW format instead of the default MFA (Multi-Fasta Alignment).
- `-annot FILENAME`: Write alignment reliability annotations to a file.
- `-t, --train FILENAME`: Compute EM parameter training from a multi-fasta file.

## Expert Tips
- **Accuracy vs. Speed**: For maximum accuracy on difficult datasets, increase consistency reps (`-c 5`) and iterative refinement (`-ir 1000`), though this significantly increases computation time.
- **Nucleotide Sequences**: While optimized for proteins, an experimental version called "PROBCONS RNA" exists for nucleotide sequences. Ensure you are using the correct parameter set if working with RNA.
- **Large Datasets**: PROBCONS is computationally intensive. For very large sets of sequences (>500), consider using faster heuristics or ensuring the machine has sufficient memory for the consistency transformation matrix.

## Reference documentation
- [PROBCONS Help and FAQ](./references/probcons_stanford_edu_help.html.md)
- [PROBCONS About and Methodology](./references/probcons_stanford_edu_about.html.md)
- [PROBCONS Download and Manual Info](./references/probcons_stanford_edu_download.html.md)