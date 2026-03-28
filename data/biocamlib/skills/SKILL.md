---
name: biocamlib
description: biocamlib is a high-performance suite of OCaml-based utilities designed for efficient bioinformatics data processing and stream-oriented genomic workflows. Use when user asks to compute reverse complements, cluster string relations into equivalence classes, manipulate FASTA/FASTQ files, or perform parallel chunk-wise processing of multi-line files.
homepage: https://github.com/PaoloRibeca/BiOCamLib
---

# biocamlib

## Overview

BiOCamLib is a high-performance suite of OCaml-based utilities designed for efficient bioinformatics data processing. It excels at stream-oriented tasks where memory efficiency and speed are critical, such as processing very long genomic sequences or clustering large sets of string relations. The toolkit provides specialized binaries that follow the Unix philosophy, allowing them to be easily integrated into shell pipelines for complex genomic workflows.

## Tool-Specific Usage and Best Practices

### RC (Reverse Complement)
Use `RC` to compute the reverse complement of DNA/RNA sequences. It processes input line-by-line without buffering, making it suitable for extremely long sequences.

*   **Basic Usage**: `echo "GAtTaCA" | RC` outputs `TGtAaTC`.
*   **Preservation**: Non-base characters (anything not `[ACGTacgt]`) are passed through unmodified.
*   **Algorithm Control**: Use `-C` or `--no-complement` if you only need to reverse the string without complementing the bases.

### Octopus (String Clustering)
Use `Octopus` to find equivalence classes (transitive closures) among sets of strings. This is highly effective for clustering identifiers or sequences that share relations.

*   **Input Format**: Each line should contain whitespace-separated strings that belong together.
*   **Output Format**: Tab-separated lines where each line represents a complete equivalence class, with members sorted lexicographically.
*   **Example**:
    ```bash
    # Input:
    # A B
    # B C
    # D E
    Octopus < input.txt
    # Output:
    # A B C
    # D E
    ```

### FASTools (FASTA/FASTQ Manipulation)
`FASTools` is a versatile utility for handling common sequencing formats.

*   **Supported Formats**: FASTA, single-end FASTQ, paired-end FASTQ, and interleaved FASTQ.
*   **Tabular Conversion**: It can convert records into a simple tabular format (one record per line, fields tab-separated), which is often easier to process with standard Unix tools like `awk` or `cut`.
*   **Interconversion**: Use it to switch between interleaved and paired-end files or to extract specific components of a FASTQ record.

### Parallel (Chunk-wise Processing)
`Parallel` is a lightweight, compiled alternative to GNU Parallel. It uses a reader/workers/writer model to process multi-line files in chunks.

*   **Efficiency**: Because it is a compiled OCaml binary, it offers high performance with minimal overhead and no external dependencies like Perl.
*   **Workflow**: It splits input files into blocks of a specified size and feeds them to a pool of worker threads, ensuring that the output remains ordered if required.

## Installation and Environment

*   **Conda**: The easiest way to deploy is via the bioconda channel: `conda install -c bioconda biocamlib`.
*   **Manual Build**: If compiling from source, use the provided `./BUILD` script. This requires OCaml 4.12+ and the Dune package manager.
*   **Platform Support**: Officially supports Linux and MacOS.



## Subcommands

| Command | Description |
|---------|-------------|
| FASTools | A tool for processing FASTA/FASTQ records, including conversion to tabular format, sequence matching, reverse-complementing, and quality dropping. |
| Parallel | A tool to parallelize commands by processing blocks of lines from an input file. |
| RC | A tool to reverse-complement or complement biological sequences. |

## Reference documentation
- [BiOCamLib GitHub README](./references/github_com_PaoloRibeca_BiOCamLib_blob_main_README.md)
- [BiOCamLib Build Script](./references/github_com_PaoloRibeca_BiOCamLib_blob_main_BUILD.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_biocamlib_overview.md)