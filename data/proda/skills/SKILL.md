---
name: proda
description: ProDA aligns protein sequences with non-global homology to identify conserved local blocks, repeats, and shuffled domains. Use when user asks to align proteins with multiple domains, find local homology blocks, or handle sequences with shuffled architectures and repeats.
homepage: http://proda.stanford.edu/
metadata:
  docker_image: "quay.io/biocontainers/proda:1.0--hdbdd923_5"
---

# proda

## Overview
ProDA (Protein Domain Aligner) is a specialized tool for aligning protein sequences that do not share a single global homology. Unlike standard aligners that assume sequences are homologous from end-to-end, ProDA identifies local homology blocks. It is particularly effective for proteins with multiple domains, repeats, or shuffled architectures. It outputs alignments as a series of "blocks," where each block represents a conserved region shared by a subset of the input sequences.

## Usage Guidelines

### Basic Alignment
The simplest way to run ProDA is by providing an input file in Multi-FASTA (MFA) format:
```bash
proda input.mfa > output.aln
```
The default output is in ClustalW (ALN) format, sent to stdout.

### Handling Repeats and Shuffled Domains
ProDA's strength lies in its ability to find multiple occurrences of a domain within the same or different sequences.
- **Minimal Block Length**: By default, ProDA identifies blocks of at least 30 residues. If your domains are smaller, adjust this threshold:
  ```bash
  proda -L 20 input.mfa > output.aln
  ```
- **Transitivity**: To increase the sensitivity of block formation, use the `-tran` flag. This considers two fragments alignable if they both align to a common third fragment, even if they don't align directly to each other:
  ```bash
  proda -tran input.mfa > output.aln
  ```

### Improving Alignment Accuracy
- **Posterior Decoding**: For higher accuracy at the cost of speed, use posterior decoding instead of the default Viterbi decoding:
  ```bash
  proda -posterior input.mfa > output.aln
  ```
- **Silent Mode**: When running ProDA in automated pipelines or scripts, use `-silent` to suppress progress reports:
  ```bash
  proda -silent input.mfa > output.aln
  ```

### Output Formats
- **ClustalW (Default)**: Provides a human-readable alignment with conservation annotations (*, :, .).
- **FASTA Output**: If your sequences **do not** contain repeats and you need a standard FASTA alignment file, use the `-fasta` option. This creates an additional file with a `.fasta` extension:
  ```bash
  proda -fasta input.mfa > output.aln
  ```
  *Note: In the FASTA output, aligned residues are uppercase and unaligned residues are lowercase.*

## Best Practices
- **Input Format**: Ensure your input is in MFA format (standard FASTA).
- **Interpreting Blocks**: ProDA outputs blocks sequentially. Each block header indicates the sequence name and the specific residue range (e.g., `SEQ_NAME(50-146)`) included in that alignment block.
- **Domain Analysis**: Use ProDA when you suspect your proteins have "shuffled" architectures where Domain A comes before Domain B in one protein, but after it in another.

## Reference documentation
- [ProDA User Manual](./references/proda_stanford_edu_proda.md)
- [ProDA Homepage and Citations](./references/proda_stanford_edu_index.md)