---
name: mehari
description: Mehari is a high-performance tool for the functional annotation of sequence variants, projecting them onto transcripts and proteins to predict biological consequences. Use when user asks to annotate VCF files with Sequence Ontology terms and HGVS descriptions, include population frequencies and clinical significance, or manage annotation databases.
homepage: https://github.com/bihealth/mehari
metadata:
  docker_image: "quay.io/biocontainers/mehari:0.39.0--h13c227e_0"
---

# mehari

## Overview

Mehari is a high-performance tool written in Rust designed for the functional annotation of sequence variants. It specializes in projecting genomic variants onto transcripts and proteins to predict biological consequences. Use this skill to generate Sequence Ontology (SO) terms and HGVS descriptions that mirror gold-standard tools like VariantValidator and VEP. It is particularly useful for processing VCF files to include population frequencies (gnomAD) and clinical significance (ClinVar) in a single pass.

## Core CLI Usage

The primary command for variant annotation is `annotate seqvars`.

### Basic Annotation Pattern
To annotate a VCF with transcript effects, frequencies, and ClinVar data:

```bash
mehari annotate seqvars \
  --transcripts path/to/transcript_db \
  --frequencies path/to/gnomad_db \
  --clinvar path/to/clinvar_db \
  --path-input-vcf input.vcf \
  --path-output-vcf output.vcf
```

### Database Management
Before annotation, ensure your databases are valid or create them from source files:

- **Check Database Integrity**: Use `mehari db check` to verify the status and record counts of your local annotation databases.
- **Create Database**: When building databases from scratch, use `mehari db create`. 
  - **Tip**: Use the `--compression-level` option to balance disk space and performance.

## Expert Tips and Best Practices

### HGVS Normalization
By default, Mehari performs HGVS normalization. If your workflow requires the raw, non-normalized descriptions (e.g., to match specific legacy pipelines), use the CLI flag to disable it:
- `--disable-variant-hgvs-normalization`

### VEP Compatibility
If you are transitioning from a VEP-based pipeline, Mehari offers a compatibility mode to ensure the consequence terms and output formats align with VEP expectations.

### Output Optimization
- **TSV Output**: For large-scale data science workflows where VCF overhead is unnecessary, Mehari can produce harmonized TSV outputs containing both Ensembl and RefSeq information.
- **Intergenic Variants**: By default, some tools filter out non-coding hits. Use `--keep-intergenic` if you need to preserve variants that do not overlap with known transcripts.

### Performance Tuning
- **Memory Management**: Mehari uses `jemalloc` by default for efficient memory allocation during heavy annotation tasks.
- **Contig Consistency**: Use the `ContigManager` features (implicit in recent versions) to ensure that 'chr1' vs '1' naming mismatches between your VCF and databases are handled automatically.

### Server Mode
For high-throughput environments or web integrations, Mehari can run as a REST API server:
```bash
mehari server run --db-path path/to/combined_dbs
```



## Subcommands

| Command | Description |
|---------|-------------|
| mehari annotate | Annotation related commands |
| mehari db | Database-related commands |
| mehari server | Server related commands |
| mehari verify | Verification related commands |

## Reference documentation
- [Mehari README](./references/github_com_varfish-org_mehari_blob_main_README.md)
- [Mehari Changelog](./references/github_com_varfish-org_mehari_blob_main_CHANGELOG.md)