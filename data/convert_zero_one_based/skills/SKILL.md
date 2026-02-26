---
name: convert_zero_one_based
description: This tool shifts genomic coordinates between zero-based and one-based numbering systems. Use when user asks to convert BED files to VCF or GFF formats, change coordinate systems for tool compatibility, or ensure consistency across different genomic file formats.
homepage: https://github.com/griffithlab/convert_zero_one_based.git
---


# convert_zero_one_based

## Overview

The `convert_zero_one_based` tool is a Python-based command-line interface (CLI) developed by the Griffith Lab. It provides a straightforward method for shifting genomic coordinates between the two primary numbering systems used in bioinformatics. 

You should use this skill when:
- You have a BED file (0-based) that needs to be compared with VCF or GFF data (1-based).
- You are preparing data for tools that strictly require a specific coordinate basis.
- You need to ensure consistency across a pipeline involving multiple genomic file formats.

## CLI Usage and Patterns

The tool follows a positional argument structure. The basic syntax is:

```bash
convert_zero_one_based <input_file> <output_file> <input_basis> <output_basis>
```

### Coordinate Basis Definitions
- **0**: Represents a zero-based coordinate system (start is 0-indexed, end is exclusive). Common in BED and UCSC formats.
- **1**: Represents a one-based coordinate system (start is 1-indexed, end is inclusive). Common in VCF, GFF, SAM, and Ensembl formats.

### Common Conversion Scenarios

**1. Converting BED (0-based) to VCF-compatible (1-based):**
```bash
convert_zero_one_based input.bed output_1based.txt 0 1
```

**2. Converting VCF/GFF (1-based) to BED-compatible (0-based):**
```bash
convert_zero_one_based input_coords.txt output.bed 1 0
```

## Best Practices and Expert Tips

- **Verify Installation**: Always confirm the tool is in your path by running `convert_zero_one_based --help` before starting a batch process.
- **File Headers**: Ensure your input file is a tab-delimited or space-delimited file where the coordinates are in expected columns. The tool typically expects standard genomic columns (Chromosome, Start, Stop).
- **Validation**: After conversion, manually inspect the first few lines of the output to ensure the shift (usually +1 or -1) occurred as expected for your specific format.
- **Conda Environment**: It is recommended to run this tool within a dedicated Bioconda environment to avoid dependency conflicts with other Python-based genomic tools.

## Reference documentation
- [convert_zero_one_based - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_convert_zero_one_based_overview.md)
- [GitHub - griffithlab/convert_zero_one_based](./references/github_com_griffithlab_convert_zero_one_based.md)