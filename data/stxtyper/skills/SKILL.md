---
name: stxtyper
description: StxTyper is a specialized bioinformatic tool developed by NCBI for the precise classification of Shiga toxin genes from nucleotide sequences.
homepage: https://github.com/ncbi/stxtyper
---

# stxtyper

## Overview

StxTyper is a specialized bioinformatic tool developed by NCBI for the precise classification of Shiga toxin genes from nucleotide sequences. It uses a standardized algorithm to detect both A and B subunits, providing high-resolution typing (e.g., stx1a, stx2c) or identifying structural issues like frameshifts, internal stops, or contig-edge truncations. Use this skill to automate the detection of Shiga-toxin producing E. coli (STEC) and to characterize the specific toxin profile of an assembly.

## Installation and Requirements

StxTyper requires NCBI BLAST+ (specifically `tblastn`) to be in your PATH.

*   **Bioconda**: `conda install bioconda::stxtyper`
*   **AMRFinderPlus**: If you have AMRFinderPlus 4.0+ installed, StxTyper is included and runs automatically when using `--organism Escherichia`.

## Common CLI Patterns

### Basic Typing
To run a standard analysis on an assembly and save the results to a tab-delimited file:
```bash
stxtyper -n assembly.fasta -o stx_results.tsv
```

### Batch Processing Identification
When processing multiple assemblies, use the `--name` flag to add an identifier to the first column of the output, making it easier to concatenate results:
```bash
stxtyper -n sample_01.fasta --name Sample_01 >> combined_results.tsv
```

### Extracting Operon Sequences
To extract the nucleotide sequences of the identified stx operons (including partial ones) for further analysis or verification:
```bash
stxtyper -n assembly.fasta --nucleotide_output stx_sequences.fasta
```

### AMRFinderPlus Integration
To produce output that matches the AMRFinderPlus field format:
```bash
stxtyper -n assembly.fasta --amrfinder --print_node
```

## Expert Tips and Best Practices

*   **Performance**: In versions 1.0.40 and later, use the `--threads` option to significantly speed up the underlying BLAST searches.
*   **Interpreting Operon Status**:
    *   `COMPLETE`: A full-length, known stx type.
    *   `COMPLETE_NOVEL`: A full-length operon that does not match the current typing scheme.
    *   `PARTIAL_CONTIG_END`: Likely truncated by the assembly process; consider re-assembling or using long-read data.
    *   `INTERNAL_STOP` / `FRAMESHIFT`: Indicates a potentially non-functional toxin gene.
*   **Quality Cutoffs**: The tool uses an 80% amino-acid identity cutoff for subunits and the operon as a whole to filter out low-quality hits.
*   **BLAST Path**: If BLAST binaries are not in your system PATH, specify their location using `--blast_bin <path>`.
*   **Troubleshooting**: Use `--log <file>` and `--debug` to investigate issues. Debug mode preserves temporary files in `$TMPDIR` that are normally deleted.

## Reference documentation
- [StxTyper README](./references/github_com_ncbi_stxtyper.md)
- [StxTyper Release Notes](./references/github_com_ncbi_stxtyper_tags.md)