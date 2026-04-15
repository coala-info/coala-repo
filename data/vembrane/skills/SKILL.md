---
name: vembrane
description: vembrane manipulates VCF and BCF files using Python expressions for advanced filtering, sorting, and data extraction. Use when user asks to filter variants with complex logic, extract VCF fields into tabular formats, sort records by custom expressions, or tag variants based on specific criteria.
homepage: https://github.com/vembrane/vembrane
metadata:
  docker_image: "quay.io/biocontainers/vembrane:2.4.0--pyhdfd78af_0"
---

# vembrane

## Overview
`vembrane` is a command-line utility that brings the power of Python expressions to VCF/BCF file manipulation. It allows for sophisticated filtering and transformation by treating variant fields—such as `INFO`, `FORMAT`, `CHROM`, and functional annotations—as Python objects. This enables the use of complex logic, mathematical operations, and string manipulations that are often difficult or impossible in standard VCF tools. It is particularly effective for variant prioritization and data extraction into tabular or structured formats.

## Core Command Patterns

### Filtering Variants
The `filter` subcommand is the primary way to subset VCF files.
```bash
# Filter by quality and specific consequence
vembrane filter 'QUAL >= 30 and ANN["Consequence"].any_is_a("missense_variant")' input.bcf

# Filter using INFO and FORMAT fields
vembrane filter 'INFO["DP"] > 10 and all(FORMAT["GQ"][s] > 20 for s in SAMPLES)' input.vcf
```

### Creating Tables
The `table` subcommand extracts VCF data into tabular formats (TSV/CSV/Parquet).
```bash
# Extract specific fields to a TSV
vembrane table 'CHROM, POS, REF, ALT, ANN["Gene_Name"], QUAL' input.vcf > output.tsv

# Use Python math in table columns
vembrane table 'CHROM, POS, 10**(-QUAL/10)' input.vcf
```

### Sorting and Prioritization
The `sort` subcommand allows for multi-level sorting based on expressions.
```bash
# Sort by allele frequency (ascending) then by quality (descending)
vembrane sort 'ANN["gnomAD_AF"], -QUAL' input.vcf > sorted.vcf
```

### Tagging (Non-destructive Filtering)
The `tag` subcommand adds values to the `FILTER` column instead of removing records.
```bash
# Tag variants with low depth
vembrane tag --tag low_depth="INFO['DP'] < 5" input.vcf
```

## Python Expression Syntax

### Field Access
- **Standard Fields**: `CHROM`, `POS`, `ID`, `REF`, `ALT`, `QUAL`, `FILTER`.
- **INFO Fields**: `INFO["FIELD_NAME"]`.
- **FORMAT Fields**: `FORMAT["FIELD_NAME"]["SAMPLE_NAME"]`.
- **Samples**: `SAMPLES` (a list of sample names).

### Annotation (ANN/CSQ) Handling
`vembrane` provides special handling for the `ANN` (or `CSQ`) field, which often contains multiple entries per variant.
- **Access**: `ANN["Field"]` returns a list of values for that field across all transcripts.
- **Sequence Ontology**: Use `.any_is_a("term")` to check if any annotation matches a Sequence Ontology term or its children.
  ```python
  ANN["Consequence"].any_is_a("stop_gained")
  ```

### Handling Missing Values
VCF files often have missing data. Use Python's `get` or check for `None`.
```python
# Provide a default value for missing INFO fields
INFO.get("DP", 0) > 10
```

## Expert Tips
- **Performance**: When working with large files, use BCF format and pipe `bcftools view` into `vembrane` for faster processing.
- **Custom Context**: Use `--custom-context` to pass a Python script defining helper functions that can be used within your expressions.
- **Annotation Keys**: If your VCF uses a key other than `ANN` for annotations (e.g., `CSQ`), use the `-k` or `--annotation-key` flag.
- **Tabular Defaults**: By default, `vembrane table` produces a "long" format (one row per sample). Use `--wide` to get one row per variant if sample-specific data is not needed.



## Subcommands

| Command | Description |
|---------|-------------|
| vembrane annotate | Add new INFO field annotations to a VCF/BCF from other data sources, using a configuration file. |
| vembrane fhir | Generate FHIR records from VCF/BCF files. |
| vembrane filter | Filter VCF/BCF records and annotations based on a user-defined Python expression.Only records for which the expression evaluates to True are kept. |
| vembrane sort | Sort VCF/BCF records by one or multiple Python expressions that encode keys for the desired order. This feature is primarily meant to prioritizing records for the human eye. For large unfiltered VCF/BCF files, the only relevant sorting is usually by position, which is better done with e.g. bcftools (and usually the standard sorting that variant callers output). Expects the VCF/BCF file to be single-allelic, i.e., one ALT allele per record. |
| vembrane structured | Create structured output from a VCF/BCF and a YTE template. |
| vembrane tag | Flag records by adding a tag to their FILTER field based on one or more expressions. This is a non-destructive alternative to `filter`, as it keeps all records. |
| vembrane_table | Convert VCF/BCF records to tabular format. |

## Reference documentation
- [vembrane README](./references/github_com_vembrane_vembrane_blob_main_README.md)
- [Table Subcommand Documentation](./references/github_com_vembrane_vembrane_blob_main_docs_table.md)
- [Sort Subcommand Documentation](./references/github_com_vembrane_vembrane_blob_main_docs_sort.md)
- [Tag Subcommand Documentation](./references/github_com_vembrane_vembrane_blob_main_docs_tag.md)
- [vembrane Homepage](./references/vembrane_github_io_index.md)