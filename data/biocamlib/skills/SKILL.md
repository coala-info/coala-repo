---
name: biocamlib
description: BiOCamLib is a high-performance OCaml-based toolkit designed for sequence manipulation, string clustering, and parallelized bioinformatics data processing. Use when user asks to compute reverse complements, perform transitive closure for string clustering, manipulate FASTA or FASTQ files, and process large datasets in parallel.
homepage: https://github.com/PaoloRibeca/BiOCamLib
---


# biocamlib

## Overview

BiOCamLib is a high-performance OCaml-based toolkit designed for core bioinformatics tasks. It provides a set of specialized utilities—RC, Octopus, Parallel, and FASTools—that offer efficient alternatives for sequence reversal, string clustering, and robust FASTA/FASTQ handling. This skill provides guidance on using these tools for high-throughput data processing and format manipulation.

## Tool-Specific Instructions

### RC (Reverse Complement)
`RC` is a lightweight tool for computing the reverse complement of sequences. It processes input line-by-line from standard input.

*   **Basic Usage**: Pipe a sequence into the tool.
    ```bash
    echo "GAtTaCA" | RC
    ```
*   **Reverse Only**: Use the `-C` or `--no-complement` flag to reverse the sequence without base-complementing it.
*   **Expert Tip**: `RC` does not perform sequence validation; non-[ACGTacgt] characters are passed through unmodified. Ensure linting is performed upstream if strict validation is required.

### Octopus (Transitive Closure)
`Octopus` is used for clustering strings based on equivalence relations.

*   **Input Format**: Provide lines where whitespace-separated strings are considered part of the same class.
*   **Output**: Tab-separated lines, where each line represents a unique equivalence class with members sorted lexicographically.
*   **Example Pattern**:
    ```bash
    # Input:
    # A B
    # B C
    # D E
    # Output:
    # A B C
    # D E
    ```

### FASTools (FASTA/FASTQ Manipulation)
`FASTools` is a versatile utility for handling various sequence formats, including FASTA, single-end FASTQ, paired-end FASTQ, and interleaved FASTQ.

*   **Format Conversion**: Use it to interconvert between FASTA/FASTQ and a simple tabular format (where records are tab-separated lines).
*   **Renaming**: Supports a `rename` mode for modifying sequence headers.
*   **Paired-End Handling**: Specifically designed to manage the complexities of paired-end and interleaved data streams.

### Parallel
`Parallel` implements a reader/workers/writer model for chunk-wise file processing.

*   **Performance**: As a compiled binary, it offers a high-speed alternative to script-based parallelization tools like GNU Parallel for specific BiOCamLib-compatible workflows.
*   **Workflow Integration**: Best used when splitting large input files into chunks for simultaneous processing across multiple cores.

## Reference documentation
- [BiOCamLib Overview](./references/anaconda_org_channels_bioconda_packages_biocamlib_overview.md)
- [BiOCamLib GitHub Repository](./references/github_com_PaoloRibeca_BiOCamLib.md)