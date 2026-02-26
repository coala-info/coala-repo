---
name: sansa
description: "Sansa is a toolkit designed for the post-processing, annotation, and benchmarking of structural variants. Use when user asks to annotate structural variants with population databases or genomic features, identify and remove redundant variant calls, or compare VCF files for benchmarking."
homepage: https://github.com/dellytools/sansa
---


# sansa

## Overview
Sansa is a specialized toolkit designed for the post-processing of structural variants (SVs). It streamlines the annotation of SVs using population databases (like gnomAD) or genomic features (GTF/GFF), identifies redundant variant calls in multi-sample datasets caused by breakpoint imprecision, and provides utilities for benchmarking SV call sets. It is highly optimized for variants produced by the Delly caller but supports standard VCF/BCF formats.

## Installation
The most efficient way to deploy sansa is via bioconda:
```bash
conda install -c bioconda sansa
```

## SV Annotation Patterns

### Database-driven Annotation
To annotate a query VCF with a database like gnomAD-SV or 1000 Genomes:
```bash
sansa annotate -d database.vcf.gz input.vcf.gz
```
*   **Output**: Generates `anno.bcf` (containing a unique `INFO/ANNOID`) and `query.tsv.gz` (mapping query SVs to database IDs).
*   **Refining Results**: Use `bcftools` to join the results and extract specific fields (e.g., Allele Frequency):
    ```bash
    bcftools query -H -f "%INFO/ANNOID\t%ID\t%INFO/EUR_AF\n" anno.bcf > anno.tsv
    ```

### Gene and Feature Annotation
Annotate SVs with nearby genes or exons using GTF or GFF3 files:
```bash
# Gene-level annotation
sansa annotate -g Homo_sapiens.GRCh38.gtf.gz input.vcf.gz

# Exon-level annotation with specific ID attributes
sansa annotate -f exon -i exon_id -g annotation.gff3.gz input.vcf.gz
```
*   **Distance Cutoff**: Use `-t` to set the distance threshold for matching (default is 0, meaning the SV must overlap or be immediately adjacent).

### Matching Logic Control
Fine-tune how sansa determines if two SVs are "the same":
*   `-b [int]`: Max allowed breakpoint distance (default: 50bp).
*   `-r [float]`: Minimum size ratio of the smaller SV to the larger SV (default: 0.8).
*   `-n`: Deactivate SV type check (allows matching DELs to BNDs, etc.).
*   `-s all`: Report all matching database entries instead of just the best match.

## Duplicate Removal (markdup)
In multi-sample VCFs where single-sample calls have been merged, use `markdup` to identify sites that are likely duplicates due to imprecise breakpoint calling:
```bash
sansa markdup -o cleaned.bcf input.vcf.gz
```
*   **Criteria**: Matches based on genomic proximity, genotype concordance, and allele similarity.
*   **Haplotype matching**: Requires the `INFO/CONSENSUS` field (standard in Delly output) for SV allele comparison.

## VCF Comparison (compvcf)
Compare a query VCF against a gold-standard "base" VCF:
```bash
sansa compvcf -a base.bcf input.bcf
```
*   **Site-only comparison**: If genotypes are missing, set the minimum allele count to zero using `-e 0`.

## Expert Tips
*   **Gene Fusions**: When using Delly, sansa utilizes `INFO/CT` (Connection Type) values to identify gene fusion candidates. Pay attention to the strand orientation (+/-) and distance reported in the output to prioritize high-confidence fusions.
*   **Memory Efficiency**: For large-scale population VCFs, prefer BCF format over VCF for faster processing and reduced I/O overhead.
*   **Unmatched Variants**: Use the `-m` flag during annotation to include query SVs that did not match any database entry in the output TSV, which is critical for filtering for rare/de novo variants.

## Reference documentation
- [Sansa GitHub Repository](./references/github_com_dellytools_sansa.md)
- [Bioconda Sansa Overview](./references/anaconda_org_channels_bioconda_packages_sansa_overview.md)