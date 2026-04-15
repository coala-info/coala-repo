---
name: bedgovcf
description: bedgovcf converts BED-formatted genomic data into VCF files using a configuration-driven mapping approach. Use when user asks to transform BED files to VCF, map BED columns to specific VCF fields, or apply functional transformations like rounding and conditional logic to genomic data.
homepage: https://github.com/nvnieuwk/bedgovcf
metadata:
  docker_image: "quay.io/biocontainers/bedgovcf:0.1.1--h9ee0642_1"
---

# bedgovcf

## Overview
bedgovcf is a specialized utility for transforming BED-formatted genomic data into VCF files. It distinguishes itself from static converters by using a configuration-driven approach that allows you to dynamically map BED columns to VCF fields. This is particularly useful for complex BED files where specific columns represent attributes like variant type, quality scores, or sample-specific genotypes. The tool supports functional operations such as rounding, summation, and conditional logic to derive VCF field values directly from the input data.

## CLI Usage and Best Practices

### Core Command Structure
The tool requires three primary inputs to function: the BED file, a configuration file, and the reference genome index.
- **Standard Execution**: `bedgovcf --bed input.bed --config config.yaml --fai reference.fasta.fai`
- **Output Redirection**: By default, the tool outputs to stdout. Use the `--output <path>` flag to save directly to a file.

### Handling Input Variations
- **Header Management**: If your BED file contains a header row, you must use the `--header` flag. This allows you to reference columns by their names (e.g., `$start`) instead of their 0-based indices (e.g., `$1`).
- **Skipping Metadata**: Use `--skip <N>` to bypass a specific number of lines at the beginning of the BED file, which is useful for files with custom comment blocks or non-standard headers.
- **Sample Identification**: The tool defaults the VCF sample name to the prefix of the BED filename. Use `--sample <string>` to explicitly define the sample name in the VCF header.

### Field Mapping Logic
The tool maps BED data to VCF fields based on the configuration file. You can reference BED columns using the `$` prefix followed by the index or name.
- **Positional Fields**: `chrom` and `pos` default to the first and second columns of the BED file if not specified.
- **Reference/Alternate Bases**: If the BED file lacks base information, `ref` defaults to "N" and `alt` defaults to "<CNV>".
- **Case Sensitivity**: All field names defined in the configuration must be lowercase for the tool to recognize them.

### Functional Transformations
You can perform operations on BED values during conversion using specific function prefixes:
- **~round**: Rounds a float or integer to the nearest whole number.
- **~sum**: Adds multiple column values or constants together.
- **~min**: Subtracts subsequent values from the first value (useful for calculating lengths or offsets).
- **~if**: Implements conditional logic. It follows the pattern: `~if <val1> <operator> <val2> <true_result> <false_result>`. This is essential for setting VCF fields like `SVTYPE` (e.g., checking if a value is negative to assign "DEL" vs "DUP").

### Expert Tips
- **Coordinate Systems**: Ensure your BED file follows the standard 0-based, half-open coordinate system. bedgovcf will process these into the 1-based VCF system based on your mapping.
- **Prefixing**: Use the `prefix` attribute in your configuration for fields like `id` or `chrom` to prepends strings (e.g., adding "chr" to chromosome numbers or a tool name to variant IDs).
- **Nested Logic**: The `false_result` of an `~if` function can be another function, allowing for nested conditional statements to handle complex variant classification.

## Reference documentation
- [GitHub - nvnieuwk/bedgovcf](./references/github_com_nvnieuwk_bedgovcf.md)
- [bedgovcf - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_bedgovcf_overview.md)