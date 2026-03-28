---
name: seqmagick
description: "seqmagick provides a streamlined interface for biological sequence processing tasks including format conversion, modification, and summary statistics. Use when user asks to convert sequence file formats, filter sequences by length or pattern, generate reverse complements, translate DNA to protein, or summarize sequence file information."
homepage: http://github.com/fhcrc/seqmagick
---


# seqmagick

## Overview

The `seqmagick` skill provides a streamlined interface for common sequence processing tasks that would otherwise require custom scripting. It operates similarly to ImageMagick but for biological sequences, offering subcommands like `convert` for creating new files and `mogrify` for in-place modifications. It is particularly useful for preparing datasets for phylogenetic analysis, cleaning up raw sequence data, and generating summary statistics of sequence files.

## Core Subcommands

### 1. Information and Extraction
*   **`info`**: Summarizes file contents (alignment status, min/max/avg length, sequence count).
    *   `seqmagick info *.fasta`
*   **`extract-ids`**: Quickly lists all sequence headers.
    *   `seqmagick extract-ids input.fasta -o ids.txt`

### 2. Conversion and Modification (`convert` & `mogrify`)
The `convert` command creates a new output file, while `mogrify` updates the input file in-place.

*   **Format Conversion**: Inferred by extension.
    *   `seqmagick convert input.fasta output.phy`
*   **Common Transformations**:
    *   `--ungap`: Remove all gap characters.
    *   `--reverse-complement`: Generate reverse complements.
    *   `--lower` / `--upper`: Change sequence case.
    *   `--translate`: Convert DNA/RNA to protein (`dna2protein`, `dna2proteinstop`).
    *   `--cut start:end`: Keep specific 1-indexed residues (e.g., `--cut 1:100`).
*   **Record Selection**:
    *   `--head N` / `--tail N`: Keep first or last N sequences.
    *   `--min-length N`: Filter out sequences shorter than N.
    *   `--deduplicate-sequences`: Remove identical sequence strings.
    *   `--pattern-include REGEX`: Keep records where ID/description matches a pattern.

### 3. Advanced Workflows
*   **`backtrans-align`**: Aligns nucleotide sequences to match an existing protein alignment.
    *   `seqmagick backtrans-align protein_align.fasta nucleotides.fasta -o aligned_nucl.fasta`
*   **`quality-filter`**: Filters FASTQ sequences based on quality scores or presence of barcodes/primers.

## Expert Tips & Best Practices

*   **Order Matters**: Transformations are applied in the order they appear on the command line. For example, `--cut 1:10 --min-length 50` will likely result in zero sequences because the cut happens before the length check.
*   **Standard Streams**: Use `-` to represent STDIN or STDOUT. When using streams, `seqmagick` defaults to FASTA format unless `--input-format` or `--output-format` is specified.
*   **Compressed Files**: Native support for `.gz` and `.bz2`. The tool automatically handles decompression and compression based on the file extension.
*   **NEXUS Requirements**: When writing to NEXUS format, you must explicitly provide the `--alphabet` flag (e.g., `--alphabet dna`).
*   **Regex Sensitivity**: Filters are case-sensitive. Use `(?i)` at the start of your regex pattern to enable case-insensitive matching.
*   **In-place Safety**: Use `mogrify` with caution. It is often safer to use `convert` first to verify the transformation logic before overwriting source data.



## Subcommands

| Command | Description |
|---------|-------------|
| convert | Convert between sequence formats |
| help | Show help for seqmagick actions. |
| mogrify | Modify sequence file(s) in place. |
| seqmagick backtrans-align | Given a protein alignment and unaligned nucleotides, align the nucleotides using the protein alignment. Protein and nucleotide sequence files must contain the same number of sequences, in the same order, with the same IDs. |
| seqmagick extract-ids | Extract the sequence IDs from a file |
| seqmagick quality-filter | Filter reads based on quality scores |
| seqmagick_info | Info action |

## Reference documentation

- [seqmagick documentation](./references/seqmagick_readthedocs_io_en_latest.md)
- [convert and mogrify](./references/seqmagick_readthedocs_io_en_latest_convert_mogrify.html.md)
- [backtrans-align](./references/seqmagick_readthedocs_io_en_latest_backtrans_align.html.md)
- [info](./references/seqmagick_readthedocs_io_en_latest_info.html.md)
- [extract-ids](./references/seqmagick_readthedocs_io_en_latest_extract_ids.html.md)