---
name: vcf2maf
description: vcf2maf converts Variant Call Format files into standardized Mutation Annotation Format files using Ensembl's Variant Effect Predictor. Use when user asks to convert VCF to MAF, reannotate existing MAF files, or standardize variant functional effects across multiple transcripts.
homepage: https://github.com/mskcc/vcf2maf
---


# vcf2maf

## Overview

vcf2maf is a specialized toolset designed to transform Variant Call Format (VCF) files into Mutation Annotation Format (MAF). Its primary purpose is to address the ambiguity in variant annotation—where a single mutation might affect multiple transcripts—by standardizing the selection of a single functional effect per variant. It relies heavily on Ensembl's Variant Effect Predictor (VEP) for high-quality, CLIA-compliant HGVS annotations. Beyond simple conversion, it provides robust support for parsing inconsistent or "crappy" bioinformatic formats often encountered in the field.

## Core Workflows

### Converting VCF to MAF
The primary script is `vcf2maf.pl`. It requires an input VCF and produces an annotated MAF.

**Basic conversion:**
```bash
perl vcf2maf.pl --input-vcf input.vcf --output-maf output.maf
```

**With Sample ID Mapping:**
Use these flags to ensure the MAF columns 16 and 17 (Tumor_Sample_Barcode and Matched_Norm_Sample_Barcode) are correctly populated, especially when the VCF uses generic headers like "TUMOR" or "NORMAL".
```bash
perl vcf2maf.pl \
  --input-vcf input.vcf \
  --output-maf output.maf \
  --tumor-id REAL_TUMOR_ID \
  --normal-id REAL_NORMAL_ID \
  --vcf-tumor-id TUMOR \
  --vcf-normal-id NORMAL
```

### Reannotating Existing MAFs
If you have a MAF file that needs updated annotations or a different reference isoform selection, use `maf2maf.pl`. This script internally converts the MAF to a temporary VCF and then runs the standard `vcf2maf` pipeline.

```bash
perl maf2maf.pl --input-maf old.maf --output-maf reannotated.maf
```

### Minimalist Conversion (No VEP)
If you do not have VEP installed or only need to reformat the VCF data into a MAF-like structure without functional annotation, use the `--inhibit-vep` flag.
*Note: This is generally discouraged for production pipelines as it bypasses the standardization benefits of the tool.*

```bash
perl vcf2maf.pl --input-vcf input.vcf --output-maf output.maf --inhibit-vep
```

## Expert Tips and Best Practices

### Handling VEP Dependencies
vcf2maf is a wrapper; it does not perform the biological annotation itself. You must provide paths to the VEP executable and its cache if they are not in your default environment:
- `--vep-path`: Path to the directory containing the `vep` executable.
- `--vep-data`: Path to the VEP cache directory (e.g., `~/.vep`).
- `--ref-fasta`: Path to the reference genome fasta file (required for VEP and `maf2vcf`).

### Performance Optimization
For large VCFs, use the `--vep-forks` parameter to enable multi-threading in VEP:
```bash
perl vcf2maf.pl --input-vcf large.vcf --output-maf output.maf --vep-forks 4
```

### Dealing with "MAF-like" Files
`maf2maf.pl` is highly tolerant of formatting errors. To successfully process a custom tab-delimited file as a MAF, ensure it contains these minimum columns:
- `Chromosome`
- `Start_Position`
- `Reference_Allele`
- `Tumor_Seq_Allele2`
- `Tumor_Sample_Barcode`

### Custom Isoform Selection
By default, vcf2maf uses VEP's "canonical" transcript. You can override this by providing a custom list of preferred Entrez Gene IDs and their corresponding Ensembl Transcript IDs (ENST) using the `--custom-enst` flag.



## Subcommands

| Command | Description |
|---------|-------------|
| perl maf2maf.pl | Converts MAF files to a VEP-annotated MAF. |
| perl vcf2maf_vcf2maf.pl | Converts VCF files to MAF format. |

## Reference documentation
- [vcf2maf Main Documentation](./references/github_com_mskcc_vcf2maf_blob_main_README.md)
- [vcf2maf.pl Script Details](./references/github_com_mskcc_vcf2maf_blob_main_vcf2maf.pl.md)
- [maf2maf.pl Script Details](./references/github_com_mskcc_vcf2maf_blob_main_maf2maf.pl.md)
- [maf2vcf.pl Script Details](./references/github_com_mskcc_vcf2maf_blob_main_maf2vcf.pl.md)