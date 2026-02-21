---
name: seqan_tcoffee
description: `seqan_tcoffee` is a powerful multiple sequence alignment tool that combines the consistency-based approach of T-Coffee with the efficient data structures of the SeqAn library.
homepage: http://www.seqan.de/apps/seqan-t-coffee/
---

# seqan_tcoffee

## Overview
`seqan_tcoffee` is a powerful multiple sequence alignment tool that combines the consistency-based approach of T-Coffee with the efficient data structures of the SeqAn library. It is designed to produce high-quality alignments by considering information from all pairwise alignments to inform the final multiple alignment. This tool is particularly effective for divergent sequences where traditional progressive aligners (like ClustalW) might fail to capture the correct evolutionary or structural relationships.

## Usage Patterns

### Basic Alignment
The most common use case is generating an MSA from a single FASTA file containing multiple sequences.
```bash
seqan_tcoffee -i sequences.fasta -o alignment.fasta
```

### Specifying Sequence Type
While the tool often auto-detects sequence types, explicitly defining the alphabet can prevent errors in ambiguous cases.
- **Protein:** `-a protein`
- **DNA:** `-a dna`
- **RNA:** `-a rna`

### Method Integration
`seqan_tcoffee` can build its library using different pairwise alignment methods. You can influence the sensitivity and speed by choosing specific methods:
- **Global Alignment (Needleman-Wunsch):** Best for sequences of similar length.
- **Local Alignment (Smith-Waterman):** Best for sequences sharing only conserved domains.

### Output Formats
The tool supports various formats for downstream analysis. Use the `-f` or `--format` flag:
- `fasta` (Default)
- `msf`
- `saf` (Standard Alignment Format)

## Expert Tips
- **Memory Management:** For very large datasets, monitor memory usage as consistency-based methods are more resource-intensive than simple progressive aligners.
- **Refinement:** If the initial alignment is unsatisfactory, consider adjusting the gap open (`-go`) and gap extension (`-ge`) penalties to better suit your specific sequence set.
- **Consistency Library:** The strength of this tool lies in the "library" of pairwise alignments. If you have pre-computed structural information or specific pairwise constraints, ensure they are compatible with the input to leverage the consistency engine fully.

## Reference documentation
- [SeqAn T-Coffee Overview](./references/anaconda_org_channels_bioconda_packages_seqan_tcoffee_overview.md)