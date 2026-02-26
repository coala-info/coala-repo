---
name: upd
description: The `upd` tool detects Uniparental Disomy by analyzing trio genomic data to identify regions of single-parental inheritance. Use when user asks to call Uniparental Disomy regions, or extract informative sites.
homepage: https://github.com/bjhall/upd
---


# upd

## Overview
The `upd` tool is a specialized utility designed to detect Uniparental Disomy by analyzing genomic data from a trio (proband, mother, and father). It identifies regions where the proband has inherited both chromosomal copies from a single parent rather than one from each. The tool is particularly useful in clinical genetics for identifying causes of imprinting disorders or recessive conditions where only one parent is a carrier. It processes VCF files to output BED-formatted regions classified by parental origin and disomy type (heterodisomy vs. isodisomy).

## CLI Usage and Best Practices

### Input Requirements
To ensure successful execution, the input VCF must meet the following criteria:
- **Trio Format**: All three individuals (proband, mother, father) must be present in the same VCF file.
- **Genotype Quality**: The `GQ` field must be present in the genotype columns.
- **Frequency Annotation**: Variants must be annotated with a population frequency (e.g., `MAX_AF`). If using VEP, use the `--vep` flag to look within the `CSQ` field.

### Common Command Patterns

**Calling UPD Regions**
The most common use case is generating a BED file of candidate UPD regions:
```bash
upd --vcf input.vcf.gz \
    --proband PROBAND_ID \
    --mother MOTHER_ID \
    --father FATHER_ID \
    regions --out results.bed
```

**Extracting Informative Sites**
To see the specific markers (ANTI_UPD, UPD_MATERNAL_ORIGIN, etc.) that contribute to a call:
```bash
upd --vcf input.vcf.gz \
    --proband PROBAND_ID \
    --mother MOTHER_ID \
    --father FATHER_ID \
    sites --out informative_sites.txt
```

### Parameter Tuning
- **Filtering Low Quality**: Use `--min-gq` (default: 30) to ignore low-confidence calls. All three members of the trio must meet this threshold for a site to be included.
- **Frequency Thresholds**: Use `--min-af` (default: 0.05) to filter out rare variants that might not be informative for inheritance patterns.
- **Call Sensitivity**: 
    - Adjust `--min-sites` (default: 3) to change the number of consecutive informative markers required to define a region.
    - Adjust `--min-size` (default: 1000) to set the minimum base-pair length of a called region.

### Expert Tips and Caveats
- **Isodisomy vs. Deletions**: The tool cannot natively distinguish between isodisomy (two copies of the same parental allele) and hemizygous deletions. Always cross-reference `upd` results with SV/CNV calls. If a deletion overlaps a "UPD" call, the tool effectively identifies which parental allele was deleted.
- **Heterodisomy Estimation**: The distinction between heterodisomy and isodisomy is based on the ratio of heterozygous to homozygous sites (`--iso-het-pct`). For small regions, this is a rough estimate. For high-confidence runs of homozygosity (ROH), consider running `bcftools roh` in parallel.
- **VEP Integration**: If your frequency data is buried in VEP's CSQ string, the `--vep` flag is mandatory. Ensure the `--af-tag` matches the specific sub-field name inside the CSQ annotation (default is `MAX_AF`).

## Reference documentation
- [upd GitHub Repository](./references/github_com_bjhall_upd.md)
- [Bioconda upd Package Overview](./references/anaconda_org_channels_bioconda_packages_upd_overview.md)