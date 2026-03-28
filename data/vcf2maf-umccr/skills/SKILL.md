---
name: vcf2maf-umccr
description: This tool converts VCF files into standardized MAF format while selecting primary variant effects using Ensembl's Variant Effect Predictor. Use when user asks to convert VCF to MAF, handle tumor-normal pairs, map custom VCF column names, or reannotate existing MAF files.
homepage: https://github.com/umccr/vcf2maf/
---

# vcf2maf-umccr

## Overview
The `vcf2maf-umccr` tool is a specialized utility designed to transform Variant Call Format (VCF) files into Mutation Annotation Format (MAF). A primary challenge in genomic data standardization is that a single variant can affect multiple gene transcripts; this tool automates the selection of a single, primary effect per variant to ensure consistency across datasets. It leverages Ensembl's Variant Effect Predictor (VEP) for high-quality annotation while providing robust support for "crappy" or non-standard input formats often encountered in bioinformatics pipelines.

## Core Workflows

### Basic VCF to MAF Conversion
To convert a VCF to a MAF, you must provide the input VCF and the desired output path.
```bash
perl vcf2maf.pl --input-vcf input.vcf --output-maf output.maf
```

### Handling Tumor-Normal Pairs
For somatic mutation workflows, specify sample IDs to correctly populate the MAF columns and parse genotypes.
```bash
perl vcf2maf.pl \
  --input-vcf tests/test.vcf \
  --output-maf tests/test.vep.maf \
  --tumor-id WD1309 \
  --normal-id NB1308
```

### Mapping Custom VCF Column Names
If your variant caller (e.g., VarScan) uses generic headers like `TUMOR` and `NORMAL` in the VCF, but you want specific IDs in the MAF:
```bash
perl vcf2maf.pl \
  --input-vcf input.vcf \
  --output-maf output.maf \
  --tumor-id SAMPLE_01 \
  --normal-id NORMAL_01 \
  --vcf-tumor-id TUMOR \
  --vcf-normal-id NORMAL
```

### Reannotating Existing MAFs
Use `maf2maf.pl` to update annotations on an existing MAF file. This script internally converts the MAF to a temporary VCF, runs VEP, and converts it back to a standardized MAF.
```bash
perl maf2maf.pl --input-maf old.maf --output-maf reannotated.maf
```

## Expert Tips and Best Practices

- **VEP Integration**: Always ensure `--vep-path` and `--vep-data` are correctly set if VEP is not in your environment's default path.
- **Inhibiting VEP**: Use `--inhibit-vep` only if your VCF is already pre-annotated and you trust the upstream annotation. Standard operation (running VEP through `vcf2maf`) is recommended for comparability.
- **Zygosity Determination**: If `Tumor_Seq_Allele1` is missing in a MAF-to-MAF conversion, the tool will attempt to determine zygosity using variant allele fractions (VAF). Ensure you specify `--tum-vad-col` and `--tum-depth-col` to point to the correct read count columns.
- **Reference Mismatches**: During MAF reannotation, variants with reference allele mismatches are moved to a separate file for debugging rather than being silently corrected or dropped.
- **Retaining Columns**: When reannotating, use the `--retain-cols` flag to keep specific metadata columns (e.g., `Center`, `Validation_Status`, `BAM_file`) that would otherwise be overwritten by the standard MAF schema.



## Subcommands

| Command | Description |
|---------|-------------|
| perl maf2maf.pl | Converts MAF files to a VEP-compatible MAF format. |
| perl vcf2maf-umccr_vcf2maf.pl | Converts VCF files to MAF format. |

## Reference documentation
- [vcf2maf README](./references/github_com_umccr_vcf2maf_blob_main_README.md)
- [maf2maf Script Details](./references/github_com_umccr_vcf2maf_blob_main_maf2maf.pl.md)
- [vcf2maf Script Details](./references/github_com_umccr_vcf2maf_blob_main_vcf2maf.pl.md)