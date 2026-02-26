---
name: vembrane
description: vembrane manipulates VCF/BCF files using Python expressions for advanced filtering and data extraction. Use when user asks to filter or tag variants, extract variant data into tables, sort or prioritize variants, annotate variants, or convert VCF data to JSON, YAML, or FHIR.
homepage: https://github.com/vembrane/vembrane
---


# vembrane

## Overview

vembrane is a specialized tool for the manipulation of Variant Call Format (VCF) and Binary VCF (BCF) files. While tools like `bcftools` use a custom filtering language, vembrane allows users to write native Python expressions to evaluate variant records. This provides immense flexibility, enabling the use of Python's standard library (math, statistics, regex) and built-in functions to perform sophisticated variant prioritization, quality control, and data conversion.

## Core Subcommands

- **filter**: Removes records that do not satisfy a boolean Python expression.
- **tag**: Non-destructive filtering; adds a label to the `FILTER` column for records matching an expression.
- **table**: Extracts specific fields into a tabular format (TSV/CSV).
- **sort**: Reorders variants based on one or more Python expressions (useful for prioritization).
- **annotate**: Integrates data from external TSV/CSV files based on genomic coordinates.
- **structured/fhir**: Converts VCF data into JSON, YAML, or FHIR-compliant formats.

## Common CLI Patterns

### Filtering by Quality and Depth
Filter for variants with a quality score over 30 and a total read depth (DP) in the INFO field greater than 10:
```bash
vembrane filter 'QUAL > 30 and INFO["DP"] > 10' input.vcf
```

### Working with Annotations (ANN/CSQ)
vembrane automatically parses SnpEff (ANN) or VEP (CSQ) fields. To filter for specific consequences:
```bash
vembrane filter 'any(c == "missense_variant" for c in ANN["Consequence"])' input.vcf
```
*Note: Use `--annotation-key CSQ` if your file uses VEP annotations.*

### Genotype-Based Filtering
Filter for variants where at least two samples are heterozygous:
```bash
vembrane filter 'count_het() >= 2' input.vcf
```

### Creating a Custom TSV
Extract chromosome, position, and specific sample genotypes:
```bash
vembrane table 'CHROM, POS, REF, ALT, FORMAT["GT"]["Sample1"]' input.vcf > output.tsv
```

### Sorting for Prioritization
Sort variants by gnomAD frequency (ascending) and then by REVEL score (descending):
```bash
vembrane sort input.vcf 'ANN["gnomad_AF"], -ANN["REVEL"]' > prioritized.vcf
```

## Expert Tips

- **Handling Missing Data**: Use `without_na(values)` to skip missing entries or `replace_na(values, replacement)` to provide defaults within your expressions.
- **Truthiness**: If an expression returns multiple values (like a list of annotations), wrap it in `any()` or `all()` to ensure it evaluates to a single boolean for the filter.
- **Performance**: For large files, use BCF input/output (`-O bcf`) to speed up processing.
- **External Context**: Use `--context-file` to pass a Python script defining custom functions or variables that can be used inside your filter expressions.
- **Ontology Support**: Use the `SO` symbol in expressions to check for Sequence Ontology terms if an OBO file is provided via `--ontology`.

## Reference documentation

- [vembrane GitHub Repository](./references/github_com_vembrane_vembrane.md)
- [vembrane Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_vembrane_overview.md)