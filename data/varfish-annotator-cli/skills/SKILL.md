---
name: varfish-annotator-cli
description: The varfish-annotator-cli prepares genomic databases and annotates VCF files for the VarFish analysis platform. Use when user asks to initialize a local database, annotate small variants, annotate structural variants, or transform VCF files for VarFish.
homepage: https://github.com/bihealth/varfish-annotator
---


# varfish-annotator-cli

## Overview

The `varfish-annotator-cli` is a Java-based command-line tool designed to bridge the gap between standard variant callers and the VarFish analysis platform. It performs two primary functions:
1. **Database Preparation**: Consolidating external genomic databases (gnomAD, ClinVar, ExAC, etc.) into a local H2 database format.
2. **Variant Annotation**: Processing VCF files to add necessary metadata, frequency data, and quality metrics required for VarFish's web interface.

This tool is essential for bioinformaticians who need to transform raw VCF output from callers like GATK, Delly, or Dragen into the specific tab-separated values (TSV) format expected by the VarFish server.

## Common CLI Patterns

### Database Initialization (`init-db`)
Before annotating variants, you must initialize a local database containing reference information. This requires paths to various genomic resource files.

```bash
java -jar varfish-annotator-cli.jar init-db \
  --db-path ./varfish-annotator-db \
  --ref-path /path/to/reference.fa \
  --db-release-info "clinvar:2023-01-01" \
  --clinvar-path /path/to/clinvar.tsv \
  --gnomad-exomes-path /path/to/gnomad.exomes.vcf.gz
```

### Annotating Small Variants
To annotate a standard VCF (SNVs/Indels), use the `annotate` command. Ensure the genome build matches your database.

```bash
java -jar varfish-annotator-cli.jar annotate \
  --input-vcf input.vcf.gz \
  --input-db ./varfish-annotator-db \
  --output-prefix output_folder/ \
  --release GRCh37
```

### Annotating Structural Variants (SVs)
The tool supports specific SV callers. If using a non-explicitly supported caller, use the `--default-sv-method` flag to ensure proper labeling.

```bash
java -jar varfish-annotator-cli.jar annotate \
  --input-vcf sv_calls.vcf.gz \
  --input-db ./varfish-annotator-db \
  --output-prefix sv_output/ \
  --release GRCh38 \
  --default-sv-method DELLY
```

## Expert Tips & Best Practices

- **Genome Build Consistency**: The tool normalizes chromosome names based on the release. GRCh38 uses the `chr` prefix, while GRCh37 (hs37d5) typically does not. Ensure your `--release` flag matches your reference genome.
- **Memory Management**: For large VCFs or database initialization, increase the Java heap size using `-Xmx` (e.g., `java -Xmx8G -jar ...`).
- **Supported SV Callers**: Explicit support is provided for Delly 2, Dragen (CNV/SV), Manta, and GATK gCNV. For these callers, the tool extracts specific fields like `DR/DV` (Delly) or `PR/SR` (Dragen/Manta) to calculate allelic balance.
- **Handling Asterisk Alleles**: Note that asterisk alleles (representing overlapping deletions in GATK) are automatically ignored during processing.
- **Input Normalization**: While the tool uses HTSJDK to read VCFs, it is best practice to ensure your VCF is valid and sorted before processing to avoid parsing errors.

## Reference documentation

- [VarFish Annotator GitHub Repository](./references/github_com_varfish-org_varfish-annotator.md)