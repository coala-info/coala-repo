---
name: msaprobs
description: MSAProbs is a protein multiple sequence alignment tool that uses pair hidden Markov models and partition functions to achieve high accuracy. Use when user asks to align protein sequences, generate alignments in FASTA or ClustalW format, or optimize alignment performance using multi-threading.
homepage: http://msaprobs.sourceforge.net/homepage.htm
metadata:
  docker_image: "quay.io/biocontainers/msaprobs:0.9.7--h5ca1c30_5"
---

# msaprobs

## Overview
MSAProbs is a sophisticated protein multiple sequence alignment tool that combines pair hidden Markov models (HMMs) and partition functions to calculate posterior probabilities. It is designed for high accuracy and high performance, utilizing OpenMP for multi-threaded execution on shared-memory CPUs. This skill provides the necessary command-line patterns to execute alignments, manage output formats, and optimize resource usage.

## Common CLI Patterns

### Basic Alignment
The simplest way to align a set of protein sequences in a FASTA file:
```bash
msaprobs input.fa > alignment.fa
```
Alternatively, use the `-o` flag to specify the output file:
```bash
msaprobs input.fa -o alignment.fa
```

### Performance Optimization
MSAProbs automatically detects the number of available CPU cores, but you can manually override this for specific resource allocation:
```bash
msaprobs -num_threads 8 input.fa -o alignment.fa
```

### Output Customization
By default, MSAProbs outputs in FASTA format. To generate a ClustalW formatted file:
```bash
msaprobs -clustalw input.fa -o alignment.aln
```

To preserve the original sequence order from the input file (rather than the alignment-grouped order):
```bash
msaprobs -a input.fa -o alignment.fa
```

## Advanced Parameters
- **Consistency and Refinement**: Use `-c <REPS>` or `--consistency <REPS>` and `-ir <REPS>` or `--iterative-refinement <REPS>` to adjust the number of passes. Setting these to `0` can speed up the process at the cost of some accuracy.
- **Annotation**: To write alignment annotations to a specific file:
  ```bash
  msaprobs -annot alignment.annot input.fa -o alignment.fa
  ```
- **Verbose Mode**: Use `-v` or `--verbose` to monitor progress during long-running alignments of large datasets.

## Expert Tips
- **Memory Management**: For extremely large datasets (thousands of sequences) that exceed the memory of a single machine, consider the MPI version (MSAProbs-MPI) if available in your environment.
- **Input Format**: Ensure input files are in standard FASTA format. MSAProbs is specifically optimized for protein sequences; do not use it for nucleotide (DNA/RNA) alignments.
- **Benchmarking**: If accuracy is the primary concern, MSAProbs is often preferred over faster but less rigorous tools like Kalign or standard MUSCLE.

## Reference documentation
- [MSAProbs Homepage](./references/msaprobs_sourceforge_net_homepage.htm.md)
- [Bioconda MSAProbs Overview](./references/anaconda_org_channels_bioconda_packages_msaprobs_overview.md)