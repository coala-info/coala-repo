---
name: jali
description: Performs sensitive protein database searches and compares protein sequences to protein families using a generalized Smith-Waterman algorithm. Use when user asks to compare a protein sequence against a multiple sequence alignment (MSA) of a protein family or conduct sensitive protein database searches.
homepage: http://bibiserv.cebitec.uni-bielefeld.de/jali
metadata:
  docker_image: "quay.io/biocontainers/jali:1.3--0"
---

# jali

Performs sensitive protein database searches and compares protein sequences to protein families using a generalized Smith-Waterman algorithm.
  Use when Claude needs to:
  - Compare a protein sequence against a multiple sequence alignment (MSA) of a protein family.
  - Conduct sensitive protein database searches.
  - Utilize an algorithm that generalizes Smith-Waterman for enhanced sensitivity.
---
## Overview

The `jali` tool is designed for advanced protein sequence analysis. It excels at comparing a single protein sequence against a protein family represented by a multiple sequence alignment (MSA). Furthermore, it can be employed for highly sensitive protein database searches, leveraging a generalized Smith-Waterman algorithm for improved detection of homologous sequences.

## Usage Instructions

### Installation

To install `jali` via conda:

```bash
conda install bioconda::jali
```

### Basic Usage

`jali` compares a query sequence against a target alignment. The general command structure is:

```bash
jali <query_sequence_file> <target_alignment_file> [options]
```

### Key Options and Patterns

*   **Query Sequence File**: This should be a FASTA file containing the protein sequence you want to search or compare.
*   **Target Alignment File**: This should be a FASTA file containing a multiple sequence alignment (MSA) of the protein family you are comparing against.
*   **Output Format**: By default, `jali` outputs results in a format similar to BLAST. Specific output format options might be available; consult the tool's detailed documentation if needed for custom formatting.
*   **Sensitive Database Searches**: For sensitive database searches, the `target_alignment_file` would typically be a pre-computed MSA of a large protein family or database.

### Expert Tips

*   **MSA Quality**: The performance and sensitivity of `jali` are highly dependent on the quality of the input multiple sequence alignment. Ensure your target alignment is well-curated and representative of the protein family.
*   **FASTA Format**: Always ensure your input sequence and alignment files are in valid FASTA format.
*   **Algorithm Generalization**: Understand that `jali`'s generalized Smith-Waterman algorithm aims for higher sensitivity than standard local alignment algorithms. This can be beneficial for detecting distantly related proteins but may also increase computation time.

## Reference documentation

- [Jali Overview on Anaconda.org](./references/anaconda_org_channels_bioconda_packages_jali_overview.md)