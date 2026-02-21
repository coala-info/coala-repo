---
name: probcons
description: Probcons is a specialized tool for generating multiple alignments of protein sequences.
homepage: http://probcons.stanford.edu/
---

# probcons

## Overview
Probcons is a specialized tool for generating multiple alignments of protein sequences. It distinguishes itself from traditional heuristic methods by using a combination of probabilistic modeling (Hidden Markov Models) and consistency-based alignment. This approach significantly increases alignment accuracy, particularly for divergent sequences, by incorporating information from all pairs of sequences into the final alignment.

## Usage Guidelines

### Basic Command Line Pattern
The standard usage requires an input file in Multi-FASTA (MFA) format. By default, the alignment is sent to standard output.

```bash
probcons [options] input.mfa > output.aln
```

### Common Parameter Configurations
Adjust these parameters to balance alignment quality versus computational time:

- **Consistency Transformation**: Use `-c <reps>` (default 2) to specify the number of passes of consistency transformation. Increasing this can improve accuracy for difficult alignments.
- **Iterative Refinement**: Use `-ir <reps>` (default 100) to set the number of iterative refinement passes.
- **Pre-training**: Use `-pre <reps>` (default 0) to specify rounds of unsupervised training on the specific input sequences before alignment.
- **Output Format**: 
  - Default is MFA.
  - Use `-clustalw` to generate output in ClustalW format.

### Expert Tips
- **Protein Only**: Probcons is optimized specifically for amino acid sequences. For nucleotide sequences, ensure you are using the experimental "Probcons RNA" variant if available, as the standard version uses protein-specific transition and emission probabilities.
- **Large Datasets**: Because the consistency transformation is $O(N^3)$ relative to the number of sequences, very large datasets may require reducing the `-c` and `-ir` parameters to finish in a reasonable timeframe.
- **Annotation**: Use the `-annot <filename>` flag if you need to write alignment confidence scores to a specific file.

## Reference documentation
- [Probcons Help and FAQ](./references/probcons_stanford_edu_help.html.md)
- [Probcons Project Overview](./references/probcons_stanford_edu_about.html.md)
- [Bioconda Probcons Package](./references/anaconda_org_channels_bioconda_packages_probcons_overview.md)