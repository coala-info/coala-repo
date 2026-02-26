---
name: vcf2maf
description: vcf2maf converts Variant Call Format (VCF) files into standardized Mutation Annotation Format (MAF) files, selecting a single effect per variant. Use when user asks to convert VCF files to MAF, re-annotate existing MAF files, map sample IDs, or perform VCF to MAF conversion with or without VEP annotation.
homepage: https://github.com/mskcc/vcf2maf
---


# vcf2maf

## Overview
`vcf2maf` is a specialized utility designed to standardize the conversion of Variant Call Format (VCF) files into Mutation Annotation Format (MAF). In genomic analysis, a single variant can often be mapped to multiple gene transcripts or isoforms; `vcf2maf` addresses this by selecting a single effect per variant based on prioritized criteria (often leveraging Ensembl VEP). It is particularly effective at handling "non-standard" or poorly formatted VCF/MAF files encountered in bioinformatics workflows, ensuring that the resulting output is compatible with downstream tools like MuSiC or cBioPortal.

## Usage Instructions

### Basic VCF to MAF Conversion
The primary script is `vcf2maf.pl`. It requires an input VCF and produces a MAF.
```bash
perl vcf2maf.pl --input-vcf input.vcf --output-maf output.maf
```

### Handling Sample IDs and Genotypes
VCFs often use generic headers like `TUMOR` and `NORMAL`. Use these flags to map them to specific barcodes in the output MAF:
- `--tumor-id`: The barcode to write in the MAF `Tumor_Sample_Barcode` column.
- `--normal-id`: The barcode to write in the MAF `Matched_Norm_Sample_Barcode` column.
- `--vcf-tumor-id`: The actual column name in the input VCF representing the tumor sample.
- `--vcf-normal-id`: The actual column name in the input VCF representing the normal sample.

Example for VarScan VCFs:
```bash
perl vcf2maf.pl --input-vcf tests/test_varscan.vcf --output-maf output.maf --tumor-id Patient1-T --normal-id Patient1-N --vcf-tumor-id TUMOR --vcf-normal-id NORMAL
```

### Re-annotating Existing MAFs
Use `maf2maf.pl` to update or re-annotate an existing MAF file. This script internally converts the MAF to VCF, runs VEP, and converts it back to a standardized MAF.
```bash
perl maf2maf.pl --input-maf input.maf --output-maf reannotated.maf
```

### VEP Integration
`vcf2maf` is a wrapper for Ensembl VEP. If VEP is not in your PATH or uses a specific cache directory, specify them:
- `--vep-path`: Path to the directory containing the `vep` executable.
- `--vep-data`: Path to the VEP cache directory.
- `--ref-fasta`: Path to the reference genome FASTA file (must match the VCF build).

### Minimalist Conversion
If you do not have VEP installed or only need a quick conversion of the VCF coordinates and basic info without functional annotation:
```bash
perl vcf2maf.pl --input-vcf input.vcf --output-maf output.maf --inhibit-vep
```
*Note: This is discouraged for production pipelines as it skips standardized isoform selection.*

## Expert Tips and Best Practices
- **Isoform Selection**: By default, the tool uses VEP's "canonical" flag. You can override this by providing a custom list of isoforms to the script if your project requires specific transcript prioritization.
- **Reference Mismatches**: When using `maf2maf`, any variants where the reference allele does not match the provided `--ref-fasta` are moved to a separate `.errors.tsv` file for debugging. Always check this file to ensure data integrity.
- **Zygosity Detection**: If your input lacks explicit genotype columns, `maf2maf` can attempt to calculate zygosity from Allele Fractions. Ensure you set `--tum-vad-col` (variant depth) and `--tum-depth-col` (total depth) to the correct column names in your input file.
- **VEP Versioning**: Ensure your VEP version and cache version match. `vcf2maf` is sensitive to VEP's command-line argument changes across versions (e.g., version 105+ splice effects).

## Reference documentation
- [vcf2maf GitHub Repository](./references/github_com_mskcc_vcf2maf.md)
- [vcf2maf Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_vcf2maf_overview.md)