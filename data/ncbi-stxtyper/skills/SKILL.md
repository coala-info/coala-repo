---
name: ncbi-stxtyper
description: The ncbi-stxtyper tool detects and classifies Shiga toxin genes from assembled nucleotide sequences using a standardized nomenclature. Use when user asks to identify Stx subtypes, extract Stx operon sequences, or characterize the pathogenic potential of E. coli strains.
homepage: https://github.com/ncbi/stxtyper
---


# ncbi-stxtyper

## Overview

The `ncbi-stxtyper` tool is a specialized bioinformatic utility used to detect and classify Shiga toxin genes from assembled nucleotide sequences. It identifies both subunits of the Stx operon and applies a standardized nomenclature to determine the specific subtype. This tool is essential for public health surveillance and clinical microbiology when characterizing the pathogenic potential of *E. coli* strains. While it is integrated into NCBI's AMRFinderPlus (v4.0+), this skill focuses on the standalone command-line usage for targeted Stx analysis.

## Installation and Environment

The tool requires NCBI BLAST+ (specifically `tblastn`) to be available in your PATH.

- **Conda/Mamba**: `conda install -c bioconda ncbi-stxtyper`
- **Binary**: Download from GitHub releases, untar, and ensure the binary is executable.

## Common CLI Patterns

### Basic Subtyping
To run a standard analysis on an assembly and save the results to a tab-delimited file:
```bash
stxtyper -n assembly.fasta -o stx_results.tsv
```

### Extracting Operon Sequences
To identify the types and simultaneously extract the nucleotide sequences of the detected operons (useful for downstream phylogenetic analysis):
```bash
stxtyper -n assembly.fasta -o results.tsv --nucleotide_output stx_sequences.fasta
```

### High-Throughput Processing
When processing multiple assemblies, use the `--name` flag to include a sample identifier in the output, making it easier to concatenate results:
```bash
stxtyper -n sample01.fasta --name sample01 -o sample01.tsv
```

### AMRFinderPlus Compatibility
If you need the output to match the field structure of AMRFinderPlus for integration into existing pipelines:
```bash
stxtyper -n assembly.fasta --amrfinder --print_node
```

## Expert Tips and Best Practices

- **Performance**: Use the `--threads` option (available in version 1.0.40+) to speed up the underlying BLAST searches, especially when dealing with large assemblies or multiple contigs.
- **Interpreting Operon Status**:
    - `COMPLETE`: Full-length, known type.
    - `PARTIAL_CONTIG_END`: Likely split across contigs; may require manual inspection or better assembly.
    - `INTERNAL_STOP` / `FRAMESHIFT`: Indicates a potentially non-functional toxin gene.
    - `COMPLETE_NOVEL`: A full-length operon that does not match the current typing scheme.
- **BLAST Pathing**: If `tblastn` is not in your system PATH, specify its location using `--blast_bin /path/to/blast/bin/`.
- **Integration Note**: If you are already running `amrfinder` with the `--organism Escherichia` flag, `stxtyper` is executed automatically. Do not run it separately unless you need specific standalone features like `--nucleotide_output`.
- **Quality Cutoffs**: The tool uses an 80% amino-acid identity cutoff for subunit calls and operon classification to filter out low-quality hits.

## Reference documentation

- [StxTyper GitHub Repository](./references/github_com_ncbi_stxtyper.md)
- [StxTyper Release Notes and Tags](./references/github_com_ncbi_stxtyper_tags.md)