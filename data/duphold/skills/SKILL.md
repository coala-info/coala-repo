---
name: duphold
description: `duphold` is a high-performance tool designed to add depth-based evidence to structural variant calls.
homepage: https://github.com/brentp/duphold
---

# duphold

## Overview

`duphold` is a high-performance tool designed to add depth-based evidence to structural variant calls. While SV callers like Lumpy or Manta use split-reads and paired-end distances to identify variants, `duphold` provides a secondary layer of validation by examining the actual sequencing depth. It calculates fold-change metrics that allow researchers to confirm if a putative deletion actually shows a drop in coverage or if a duplication shows the expected increase, significantly improving the precision of SV discovery.

## Core Usage Patterns

### Basic SV Annotation
To annotate a single-sample VCF with depth information, provide the BAM/CRAM file and the reference FASTA.

```bash
duphold \
  --threads 4 \
  --vcf input_svs.vcf \
  --bam input_reads.cram \
  --fasta reference.fasta \
  --output annotated_svs.bcf
```

### Annotation with SNP/Indel Evidence
Providing a SNP VCF (ideally in BCF format for speed) allows `duphold` to report the number of homozygous and heterozygous SNPs within the SV region. This is useful for identifying "deletions" that incorrectly contain heterozygous SNP calls.

```bash
duphold \
  --snp high_qual_snps.bcf \
  --vcf input_svs.vcf \
  --bam input_reads.bam \
  --fasta reference.fasta \
  --output annotated_svs.bcf
```

## Key Metrics Generated

`duphold` updates the `FORMAT` field for the sample with the following tags:

*   **DHFFC**: Fold-change of the variant depth relative to its **Flanking** regions. (Best for Deletions).
*   **DHBFC**: Fold-change of the variant depth relative to genomic bins with similar **GC-content**. (Best for Duplications).
*   **DHFC**: Fold-change relative to the average depth of the entire chromosome.
*   **DHGT**: (When using `--snp`) Counts of [0] Hom-ref, [1] Het, [2] Hom-alt, [3] Unknown, and [4] Low-quality SNPs in the region.

## Expert Filtering Recommendations

After annotation, use `bcftools` to filter for high-confidence variants. The following thresholds are recommended by the author to retain ~98-99% of true positives while removing the majority of false positives:

### Filter for High-Quality Deletions and Duplications
```bash
bcftools view -i '(SVTYPE = "DEL" & FMT/DHFFC[0] < 0.7) | (SVTYPE = "DUP" & FMT/DHBFC[0] > 1.3)' input.duphold.bcf
```

## Performance and Optimization

*   **Input Formats**: `duphold` is significantly faster when processing **CRAM** files compared to BAM files.
*   **Output Formats**: Always prefer **BCF** output (`-o output.bcf`) for downstream processing speed.
*   **Threading**: Use up to 4 threads (`-t 4`). Beyond this, the bottleneck usually shifts from decompression to I/O.
*   **Flanking Regions**: The default flank size is 1000bp. For assemblies with poor contiguity or very small variants, you can adjust this using the environment variable:
    `export DUPHOLD_FLANK=500`
*   **Sample Name Mismatch**: If the sample name in the BAM header doesn't match the VCF, use:
    `export DUPHOLD_SAMPLE_NAME=CorrectName`

## Reference documentation
- [github_com_brentp_duphold.md](./references/github_com_brentp_duphold.md)
- [anaconda_org_channels_bioconda_packages_duphold_overview.md](./references/anaconda_org_channels_bioconda_packages_duphold_overview.md)