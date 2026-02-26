---
name: fastkit
description: FastKit formats and validates biological sequence files to prepare them for downstream analysis. Use when user asks to format FASTA headers, normalize sequence case, validate DNA or protein sequences, or check sequence counts.
homepage: https://github.com/neoformit/fastkit
---


# fastkit

## Overview

FastKit is a specialized utility designed to handle the routine, often repetitive tasks required to prepare biological sequence files for downstream analysis. Rather than reinventing core algorithms, it acts as a wrapper for established libraries like Biopython and SeqTK, providing a consistent interface for formatting and validation. Its primary design philosophy is to output to `stdout`, allowing users to chain operations via pipes and maintain transparent control over file naming.

## Core CLI Usage

### Formatting Sequences
The `format` subcommand prepares FASTA files for tool execution by cleaning headers and normalizing sequence characters.

*   **Strip Header Spaces**: Replaces spaces in FASTA titles with underscores. This is critical for tools that only read the first string of a header as the sequence ID.
    ```bash
    fastkit format input.fasta --strip-header-space > cleaned.fasta
    ```
*   **Case Normalization**: Converts all sequence characters to uppercase to ensure consistency across different datasets.
    ```bash
    fastkit format input.fasta --uppercase > normalized.fasta
    ```
*   **Combined Formatting**:
    ```bash
    fastkit format input.fasta --strip-header-space --uppercase > final.fasta
    ```

### Validating Data
The `validate` subcommand checks the integrity of FASTA files without altering their content. It raises errors or returns boolean values based on the specified constraints.

*   **DNA/Protein Validation**: Ensures sequences conform to IUPAC standards.
    ```bash
    # Validate as DNA
    fastkit validate input.fasta --dna

    # Validate as Protein
    fastkit validate input.fasta --protein
    ```
*   **Strict Character Checking**: Use `--no-unknown` to prohibit ambiguous characters (like `N` in DNA or `X` in Protein). This requires either the `--dna` or `--protein` flag.
    ```bash
    fastkit validate input.fasta --dna --no-unknown
    ```
*   **Sequence Count Constraints**: Verify that a file does not exceed a specific number of sequences.
    ```bash
    fastkit validate input.fasta --sequence-count 100
    ```

## Expert Tips and Best Practices

*   **Piping for Efficiency**: Since FastKit writes to `stdout`, you can pipe multiple subcommands together to perform complex pre-processing in a single line without creating intermediate files.
    ```bash
    fastkit format input.fasta --strip-header-space | fastkit format - --uppercase > processed.fasta
    ```
*   **Validation First**: Always run `validate` before `format` in a pipeline. This ensures you are not wasting compute resources formatting data that is fundamentally invalid or contains too many sequences for your target tool.
*   **IUPAC Compliance**: Use the `--no-unknown` flag when preparing data for sensitive alignment or phylogenetics tools that may misinterpret or crash on ambiguous characters.
*   **Filename Inference**: FastKit is designed to infer datatypes from filenames. Ensure your files have standard extensions (`.fasta`, `.fas`, `.fastq`) to allow the tool to process them correctly without manual type declarations.

## Reference documentation
- [FastKit GitHub Repository](./references/github_com_neoformit_fastkit.md)
- [FastKit Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fastkit_overview.md)