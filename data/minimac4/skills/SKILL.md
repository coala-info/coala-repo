---
name: minimac4
description: Minimac4 is a specialized tool designed for computationally efficient genotype imputation.
homepage: https://github.com/statgen/Minimac4
---

# minimac4

## Overview
Minimac4 is a specialized tool designed for computationally efficient genotype imputation. It serves as a lower-memory successor to Minimac3, utilizing the Michigan VCF (MVCF) encoding to handle massive reference panels. The tool is primarily used in genomic research to estimate missing genotypes in study samples by comparing them to a densely sequenced reference population. It supports standard genomic formats including VCF, BCF, and the high-performance SAV format.

## Common CLI Patterns

### Genotype Imputation
The primary function of Minimac4 is to impute missing variants into a phased target dataset.

```bash
# Basic imputation (outputting to SAV format)
minimac4 reference.msav target.vcf.gz > imputed.sav

# Imputation with explicit output format (BCF or VCF)
minimac4 reference.msav target.bcf -o imputed.bcf
minimac4 reference.msav target.vcf.gz -o imputed.vcf.gz
```

### Reference Panel Management
Minimac4 requires reference panels to be in the MVCF (.msav) format.

```bash
# Convert an existing Minimac3 M3VCF file to MVCF
minimac4 --update-m3vcf reference.m3vcf.gz > reference.msav

# Create a new MVCF reference from a phased VCF/BCF/SAV
minimac4 --compress-reference reference.vcf.gz > reference.msav
```

### Specialized Outputs
For specific downstream workflows, you may need sites-only files or empirical doses.

```bash
# Generate a sites-only file alongside the imputed data
minimac4 reference.msav target.bcf -o imputed.sav -s imputed.sites.vcf.gz

# Generate empirical doses for meta-imputation (MetaMinimac2)
minimac4 reference.msav target.bcf -o imputed.dose.sav -e imputed.empirical_dose.sav
```

## Expert Tips and Best Practices
- **Phasing Requirement**: Ensure your target genotype array data is phased before running Minimac4. The tool expects phased haplotypes for accurate imputation.
- **Format Selection**: Use the SAV format for both input and output when possible. It is more computationally efficient and provides better compression than standard VCF/BCF for large-scale genomic data.
- **Memory Efficiency**: Minimac4 is optimized for low memory footprints. If working on a cluster, you can typically request fewer resources than were required for Minimac3.
- **Reference Panel Updates**: Always use the `--update-m3vcf` command when migrating from older Minimac3 pipelines to take advantage of the performance improvements in the MVCF format.
- **Meta-Analysis**: If you plan to combine results from multiple cohorts using MetaMinimac2, you must include the `-e` (or `--empirical-output`) flag to generate the necessary dose information.

## Reference documentation
- [github_com_statgen_Minimac4.md](./references/github_com_statgen_Minimac4.md)
- [anaconda_org_channels_bioconda_packages_minimac4_overview.md](./references/anaconda_org_channels_bioconda_packages_minimac4_overview.md)