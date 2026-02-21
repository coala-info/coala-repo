---
name: vcf2maf-umccr
description: The `vcf2maf-umccr` tool is a specialized utility designed to transform Variant Call Format (VCF) files into Mutation Annotation Format (MAF).
homepage: https://github.com/umccr/vcf2maf/
---

# vcf2maf-umccr

## Overview

The `vcf2maf-umccr` tool is a specialized utility designed to transform Variant Call Format (VCF) files into Mutation Annotation Format (MAF). Its primary value lies in its ability to resolve the ambiguity of variant effects by mapping each variant to a single, prioritized gene transcript or isoform. This standardization is critical for downstream genomic analysis where consistent labeling of mutations (e.g., Missense vs. Splice Site) is required. The tool relies heavily on Ensembl's Variant Effect Predictor (VEP) for functional annotation but provides the flexibility to override canonical isoforms or use custom datasets like ExAC.

## CLI Usage Patterns

### Basic VCF to MAF Conversion
The most common use case involves converting a VCF into an annotated MAF.
```bash
perl vcf2maf.pl --input-vcf input.vcf --output-maf output.maf
```

### Handling Tumor and Normal Samples
To ensure the MAF columns 16 and 17 (Tumor_Sample_Barcode and Matched_Norm_Sample_Barcode) are correctly populated, specify the sample IDs.
```bash
perl vcf2maf.pl \
  --input-vcf input.vcf \
  --output-maf output.maf \
  --tumor-id SAMPLE_T \
  --normal-id SAMPLE_N
```

### Mapping VarScan or Custom VCF Columns
If the input VCF uses generic headers (like `TUMOR` and `NORMAL`) but you want specific IDs in the output MAF, use the VCF-specific ID flags to help the script locate the correct genotype columns.
```bash
perl vcf2maf.pl \
  --input-vcf varscan.vcf \
  --output-maf output.maf \
  --tumor-id WD1309 \
  --normal-id NB1308 \
  --vcf-tumor-id TUMOR \
  --vcf-normal-id NORMAL
```

### Re-annotating Existing MAF Files
Use `maf2maf.pl` to update or re-annotate an existing MAF file. This script internally converts the MAF to VCF and then runs the standard `vcf2maf` pipeline.
```bash
perl maf2maf.pl --input-maf old.maf --output-maf reannotated.maf
```

## Expert Tips and Best Practices

- **VEP Dependency**: Always ensure VEP is installed and accessible. If VEP or its cache are in non-standard locations, use `--vep-path` and `--vep-data` to point to the correct directories.
- **Avoid `--inhibit-vep`**: While this flag allows for a minimalist MAF without running VEP, it is generally discouraged. The accuracy of the MAF depends on the specific parameters VEP uses during the `vcf2maf` run to ensure comparability across datasets.
- **Zygosity Determination**: When using `maf2maf.pl`, if `Tumor_Seq_Allele1` is missing, the tool will attempt to calculate zygosity using Variant Allele Fractions (VAF). Ensure you provide `--tum-vad-col` and `--tum-depth-col` to point to the correct read count columns in your input file.
- **Reference Mismatches**: Variants with reference allele mismatches are automatically moved to a separate file during processing. Always check these files to debug potential reference genome versioning issues (e.g., GRCh37 vs. GRCh38).
- **Minimalist Input**: For `maf2maf.pl`, the bare minimum required columns are `Chromosome`, `Start_Position`, `Reference_Allele`, `Tumor_Seq_Allele2`, and `Tumor_Sample_Barcode`.

## Reference documentation
- [vcf2maf GitHub Repository](./references/github_com_umccr_vcf2maf.md)
- [vcf2maf-umccr Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_vcf2maf-umccr_overview.md)