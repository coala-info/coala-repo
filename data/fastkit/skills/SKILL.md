---
name: fastkit
description: FastKit is a utility for formatting and validating biological sequence data in FASTA files. Use when user asks to format sequences, normalize character case, strip header spaces, or validate DNA and protein data integrity.
homepage: https://github.com/neoformit/fastkit
metadata:
  docker_image: "quay.io/biocontainers/fastkit:1.0.2--pyhdfd78af_0"
---

# fastkit

## Overview

FastKit is a specialized utility designed to handle the routine, repetitive tasks associated with biological sequence data preparation. It acts as a wrapper for established libraries like Biopython to provide a consistent interface for formatting and validating FASTA files. By writing results directly to standard output, it integrates seamlessly into command-line pipes, allowing users to clean and verify data without creating unnecessary intermediate files.

## Command Usage and Patterns

### Formatting Sequences
Use the `format` subcommand to normalize FASTA files. This is particularly useful for tools that are sensitive to header formatting or character case.

*   **Strip Header Spaces**: Replaces spaces in FASTA titles with underscores to prevent parsing errors in downstream tools.
    ```bash
    fastkit format input.fasta --strip-header-space > cleaned.fasta
    ```
*   **Normalize Case**: Converts all sequence characters to uppercase to ensure consistency.
    ```bash
    fastkit format input.fasta --uppercase > normalized.fasta
    ```
*   **Combined Formatting**:
    ```bash
    fastkit format input.fasta --strip-header-space --uppercase > final.fasta
    ```

### Validating Data Integrity
Use the `validate` subcommand to ensure files meet specific biological standards. These commands return boolean results or raise exceptions rather than modifying the file.

*   **DNA Validation**: Check if the file contains valid IUPAC DNA characters.
    ```bash
    fastkit validate input.fasta --dna
    ```
*   **Protein Validation**: Check for valid IUPAC protein sequences.
    ```bash
    fastkit validate input.fasta --protein
    ```
*   **Strict Validation**: Prohibit unknown characters (like N or X) by combining flags.
    ```bash
    fastkit validate input.fasta --dna --no-unknown
    ```
*   **Sequence Count Limits**: Verify that a file does not exceed a specific number of sequences.
    ```bash
    fastkit validate input.fasta --sequence-count 100
    ```

## Expert Tips and Best Practices

*   **Pipe Integration**: Since FastKit writes to `stdout`, always use redirection (`>`) to save your results or pipe (`|`) directly into the next tool in your pipeline.
*   **Filename Inference**: FastKit automatically infers datatypes from filenames. Ensure your files have standard extensions (e.g., `.fasta`, `.fas`, `.fastq`) for the best results.
*   **Pre-flight Checks**: Run `validate` as the first step in any automated pipeline. Catching a non-IUPAC character or an empty file early saves significant compute time on downstream alignment or assembly tasks.
*   **Header Sanitization**: Many legacy bioinformatics tools fail when encountering spaces or special characters in FASTA headers. Always use `--strip-header-space` when preparing data for older software.



## Subcommands

| Command | Description |
|---------|-------------|
| fastkit validate | Validate FASTA files in preparation for tool execution. |
| fastkit_format | Reformat FASTA files in preparation for tool execution. |

## Reference documentation
- [FastKit README](./references/github_com_neoformit_fastkit_blob_main_README.md)
- [FastKit Setup and CLI Entrypoints](./references/github_com_neoformit_fastkit_blob_main_setup.py.md)