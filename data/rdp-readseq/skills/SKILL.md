---
name: rdp-readseq
description: "This tool converts sequence data between various bioinformatics formats. Use when user asks to convert sequence files between formats like FASTA, PHYLIP, or NEXUS."
homepage: https://anaconda.org/channels/bioconda/packages/rdp-readseq/overview
---


# rdp-readseq

rdp-readseq/SKILL.md
```yaml
name: rdp-readseq
description: |
  A tool for reading and processing sequence data, particularly for phylogenetic analysis.
  Use when Claude needs to perform tasks related to sequence alignment, manipulation, or preparation for phylogenetic inference, especially when working with data formats commonly used in bioinformatics.
  This skill is specifically for the `rdp-readseq` command-line tool.
```
## Overview
The `rdp-readseq` tool is designed for reading and processing sequence data, commonly used in bioinformatics for tasks such as sequence alignment and preparation for phylogenetic analysis. It handles various sequence formats and can be used to manipulate sequence data for downstream analyses.

## Usage Instructions

`rdp-readseq` is a command-line utility. The primary function is to convert sequence data between different formats.

### Basic Usage: Format Conversion

The most common use case is converting a sequence file from one format to another.

**Syntax:**

```bash
rdp-readseq -fmt <output_format> -i <input_file> -o <output_file>
```

**Key Options:**

*   `-fmt <output_format>`: Specifies the desired output format. Common formats include:
    *   `fasta`
    *   `phylip`
    *   `nexus`
    *   `clustal`
    *   `msf` (Multiple Sequence Format)
*   `-i <input_file>`: The path to the input sequence file.
*   `-o <output_file>`: The path where the converted output file will be saved.

**Example:** Convert a FASTA file to PHYLIP format.

```bash
rdp-readseq -fmt phylip -i input.fasta -o output.phylip
```

### Handling Input Files

*   `rdp-readseq` can typically infer the input format from the file extension, but it's good practice to be explicit if there are ambiguities.
*   Ensure your input file is correctly formatted according to its declared type.

### Expert Tips

*   **Batch Processing:** For converting multiple files, consider using shell scripting (e.g., a `for` loop in Bash) to iterate through your input files and apply `rdp-readseq` to each.
*   **Format Compatibility:** Always verify the output format requirements of the downstream software you intend to use. `rdp-readseq` supports many common formats, but subtle differences can exist.
*   **Error Handling:** If `rdp-readseq` encounters an error, it will usually print a message to standard error. Check these messages carefully for clues about malformed input or incorrect options.

## Reference documentation
- [rdp-readseq Overview](./references/anaconda_org_channels_bioconda_packages_rdp-readseq_overview.md)