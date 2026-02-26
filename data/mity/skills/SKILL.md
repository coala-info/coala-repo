---
name: mity
description: Mity is a bioinformatics pipeline designed to call, normalize, and report mitochondrial DNA variants with high sensitivity for low-level heteroplasmy. Use when user asks to call mitochondrial variants, normalize mitochondrial VCFs, generate annotated clinical reports, or merge mitochondrial calls into nuclear DNA VCFs.
homepage: https://github.com/KCCG/mity
---


# mity

## Overview
Mity is a specialized bioinformatics pipeline tailored for the unique challenges of mitochondrial DNA (mtDNA) analysis. Unlike standard nuclear variant callers, mity is optimized for the extremely high read depth and varying levels of heteroplasmy found in mitochondrial data. It provides a streamlined workflow to identify pathogenic variants, even at levels below 1% heteroplasmy, and produces annotated Excel reports designed for clinical and research interrogation.

## Core Commands and Workflows

### 1. The All-in-One Workflow
For most users, the `runall` command is the most efficient way to process data, as it executes calling, normalization, and reporting in a single step.

```bash
mity runall \
  --prefix [sample_name] \
  --output-dir [dir] \
  --min_vaf 0.01 \
  [input.bam/cram]
```

### 2. Step-by-Step Execution
If granular control is required, use the individual modules:

*   **Call**: Identifies variants from BAM or CRAM files.
    *   *Tip*: Always use the `--normalise` flag here to ensure compatibility with the reporting tool.
    ```bash
    mity call --prefix [name] --normalise [input.bam]
    ```
*   **Normalise**: Decomposes multi-allelic variants and splits multi-nucleotide polymorphisms (MNPs). This is critical because standard tools often lose metadata during this process; mity's implementation preserves quality scores.
*   **Report**: Generates an annotated `.xlsx` report.
    ```bash
    mity report --prefix [name] --min_vaf 0.01 [normalised.vcf.gz]
    ```
*   **Merge**: Integrates mitochondrial calls into an existing nuclear DNA VCF, replacing lower-quality MT calls from general-purpose callers like HaplotypeCaller.
    ```bash
    mity merge --mity_vcf [mity.vcf.gz] --nuclear_vcf [nuclear.vcf.gz]
    ```

## Expert Tips and Best Practices

*   **Reference Genome Awareness**: Mity natively supports the revised Cambridge Reference Sequence (rCRS). This is the standard for GRCh37, hs37d5, and GRCh38. 
    *   *Warning*: Avoid using hg19 if possible, as its mitochondrial sequence (NC_001807) differs in length and homology, which can lead to mapping and calling errors.
*   **Heteroplasmy Sensitivity**: To detect very low heteroplasmy (<1%), ensure your sequencing depth is >1000x.
*   **Interpreting Tiers**:
    *   **Tier 1 & 2**: High-confidence variants. Focus on those matching clinical presentations in 'disease_mitomap' or confirmed status.
    *   **Tier 3**: Low supporting reads. These should be treated with caution but not ignored, especially in blood samples where pathogenic variants might exist at higher levels in affected tissues.
*   **Filtering**: Use the report columns to exclude common variants found in 'phylotree_haplotype', 'MGRB_frequency', or 'GenBank_frequency_mitomap'.
*   **Debugging**: Use the `-k` or `--keep` flag to retain intermediate files (like the annotated VCF) for deeper troubleshooting beyond the Excel report.

## Reference documentation
- [mity GitHub Repository](./references/github_com_KCCG_mity.md)
- [mity Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mity_overview.md)