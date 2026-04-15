---
name: fsa
description: FSA is a distance-based alignment tool that uses sequence annealing and machine learning to perform multiple sequence alignments with high accuracy. Use when user asks to align sequences in FASTA or Stockholm format, perform large-scale or genomic alignments, or visualize alignment reliability using posterior probabilities.
homepage: http://fsa.sourceforge.net/
metadata:
  docker_image: "quay.io/biocontainers/fsa:1.15.9--h5ca1c30_5"
---

# fsa

## Overview
FSA is a distance-based alignment algorithm that uses sequence annealing and machine learning to estimate parameters on the fly. Unlike many aligners that prioritize sensitivity (often leading to "over-alignment" of non-homologous regions), FSA maximizes expected accuracy, which naturally penalizes the alignment of unrelated characters. It is particularly effective for large-scale datasets and long sequences where traditional progressive alignment methods may fail or become computationally prohibitive.

## Common CLI Patterns

### Basic Alignment
Align sequences in a FASTA file and output to multi-FASTA (MFA) or Stockholm format:
```bash
# Default Multi-FASTA output
fsa input.fa > output.mfa

# Stockholm format output
fsa --stockholm input.fa > output.stk
```

### Large-Scale Alignments
For datasets with hundreds or thousands of sequences, use the randomized inference algorithm to reduce computational cost:
```bash
# Fast mode for many sequences
fsa --fast input.fa > output.mfa

# Fine-grained control over pairwise comparisons (N = number of sequences)
# Range: (N-1) to (N*(N-1)/2)
fsa --alignment-number 100 input.fa > output.mfa
```

### Long Sequence (Genomic) Alignment
FSA uses "anchor annealing" for megabase-long sequences. This requires MUMmer (for unique matches) or Exonerate (for remote homology) to be installed and accessible.
```bash
# Align long sequences using MUMmer anchors
fsa --mummer input.fa > output.mfa

# Use Mercator homology map constraints for rearranged genomes
fsa --mercator constraints.txt input.fa > output.mfa
```

## Expert Tips and Tuning

### Sensitivity vs. Specificity
FSA is conservative by default. If your alignment has too many gaps, you can adjust the sensitivity:
- **Maximum Sensitivity**: Use `--maxsn` to align characters even if the probability of homology is lower.
- **Fine Control**: Use `--gapfactor <int>`. 
    - `--gapfactor 0` is equivalent to `--maxsn`.
    - `--gapfactor 1` is the default.
    - `--gapfactor > 1` increases specificity (fewer aligned columns, more gaps).

### Troubleshooting Performance
If an alignment is slow or you suspect it is hung, use the logging system to monitor progress:
- **DP Algorithm Progress**: `fsa --log 7 input.fa`
- **Anchoring Progress**: `fsa --log 6 input.fa` (useful for long sequences)
- *Note: Lower log numbers are more verbose (0-10).*

### Visualization and Reliability
To identify which parts of the alignment are most reliable, use the GUI output:
1. Run `fsa --gui input.fa`.
2. This generates `.gui` and `.probs` files.
3. Visualize using the MAD (Multiple Alignment Display) tool: `java -jar display/mad.jar input.fa`.
4. Characters are colored by their posterior probability of being correctly aligned.

## Reference documentation
- [FSA Frequently Asked Questions](./references/fsa_sourceforge_net_FAQ.html.md)
- [FSA: Fast Statistical Alignment Overview](./references/fsa_sourceforge_net_index.md)