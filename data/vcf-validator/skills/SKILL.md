---
name: vcf-validator
description: The vcf-validator tool validates VCF file format compliance and verifies VCF records against a reference genome. Use when user asks to validate VCF files, check VCF syntax and semantics, verify VCF records against a reference genome, generate validation reports, filter VCF records, or ensure VCF files meet database submission standards.
homepage: https://github.com/EBIVariation/vcf-validator
---


# vcf-validator

## Overview
This skill provides procedural knowledge for validating VCF files using the EBI Variation team's C++ validation suite. It covers two primary utilities: `vcf_validator` for format compliance (lexical, syntactic, and semantic analysis) and `vcf_assembly_checker` for verifying that VCF records match a specific reference genome. Use this tool to ensure genomic data is submission-ready for databases like the European Variation Archive (EVA).

## Core Validation Patterns

### Basic Syntax and Semantic Check
The default behavior checks for both syntax (format) and semantic (logic) issues.
```bash
vcf_validator -i input.vcf
```

### Validation Levels
Control the strictness of the validation using the `-l` or `--level` flag:
- `error`: Only reports critical syntax violations.
- `warning`: Reports both errors and recommendations (Default).
- `stop`: Terminates execution immediately upon encountering the first syntax error.

### Generating Reports
Use the `-r` flag to specify output formats (comma-separated, no spaces):
- `summary`: A high-level count of error types and their first occurrence (Default).
- `text`: A verbose, line-by-line description of every error found.
- `stdout`: Redirects the report to the terminal instead of a file.

Example for a comprehensive summary and text log in a specific directory:
```bash
vcf_validator -i input.vcf.gz -r summary,text -o ./validation_results/
```

## Assembly Checking
The `vcf_assembly_checker` ensures the `REF` column in the VCF matches the sequence in a provided FASTA file.

### Requirements
- A FASTA file (`-f`).
- A FASTA index file (`.fai`) must exist in the same directory as the FASTA file.
- (Optional) An assembly report (`-a`) if contig naming conventions (e.g., GenBank vs. UCSC) differ between the VCF and FASTA.

### Common Assembly Commands
Verify VCF against a reference:
```bash
vcf_assembly_checker -i input.vcf -f reference.fa
```

Generate a "cleaned" VCF containing only the records that passed the assembly check:
```bash
vcf_assembly_checker -i input.vcf -f reference.fa -r valid,summary
```

## Expert Tips
- **Compressed Files**: The tools natively support `.gz` and `.bz2`. For `.zip` or other formats, use a pipe: `zcat file.vcf.zip | vcf_validator`.
- **Evidence Validation**: Use the `--require-evidence` flag to ensure the VCF contains either Genotypes (FORMAT/GT) or Allele Frequencies (INFO/AF), which is often required for database submissions.
- **GenBank Accessions**: When preparing data for EBI/EVA, use `--require-genbank` with the assembly checker to ensure contigs use official accessions.
- **Output Naming**: Reports are automatically named after the input file with an appended timestamp. Use `-o` to prevent cluttering your working directory.

## Reference documentation
- [vcf-validator GitHub Repository](./references/github_com_EBIVariation_vcf-validator.md)