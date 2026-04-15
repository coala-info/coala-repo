---
name: indelible
description: InDelible identifies intermediate-sized genomic insertions and deletions by leveraging split-read analysis and active learning quality control. Use when user asks to detect intermediate-sized variants, identify de novo mutations in clinical diagnostics, or perform structural variant calling on whole exome sequencing data.
homepage: https://github.com/HurlesGroupSanger/indelible
metadata:
  docker_image: "biocontainers/indelible:v1.03-4-deb_cv1"
---

# indelible

## Overview
InDelible is a specialized genomic tool designed to bridge the gap between standard small InDel callers and large-scale CNV discovery tools. It focuses on intermediate-sized variants that are often missed by chromosomal microarrays or standard WES pipelines. By leveraging split-read analysis and an active learning methodology for quality control, it provides a high-sensitivity framework for clinical diagnostics, particularly for identifying de novo mutations in gene sets of interest.

## Primary SV Calling Pipeline
The InDelible workflow is executed through the `indelible.py` script and follows a sequential six-step process. Ensure all dependencies (bedtools, tabix, bgzip, bwa, blast) are in your `$PATH`.

1.  **Fetch**: This initial step queries the raw sequencing data (BAM/CRAM) to extract split reads and discordant pairs that indicate potential breakpoints.
2.  **Aggregate**: Clusters the fetched reads to identify candidate structural variant locations.
3.  **Score**: Applies the adaptive learning model to the clusters. This step performs the primary quality control, distinguishing true variants from sequencing artifacts.
4.  **Database**: Compares identified variants against internal or external databases to filter out common population variants and focus on rare or unique events.
5.  **Annotate**: Adds functional information to the variants, such as gene impact and predicted effect on protein-coding sequences.
6.  **Denovo**: A specialized module for trio analysis to identify variants present in the proband but absent in the parents.

## Expert Tips and Best Practices
- **Targeted Analysis**: Always use a "target gene list" to significantly reduce the search space. This not only speeds up processing but also reduces the false discovery rate by focusing on clinically relevant regions.
- **CRAM Compatibility**: If you are working with CRAM files, you must use `bedtools` version 2.28 or later to ensure proper read extraction.
- **Size Optimization**: While InDelible can detect various sizes, it is most effective for variants between 20bp and 500bp. For variants significantly larger than 1kb, consider supplementing with standard CNV callers.
- **Environment Setup**: InDelible supports both Python 2.7 and 3.7. If using the Docker/Singularity containers, ensure your volume mounts correctly point to your reference genomes and input data.
- **Filtering Strategy**: Focus on the "Primary TSV File" output for downstream analysis. For clinical diagnostics, prioritize variants in genes previously associated with the phenotype, especially those identified via the `denovo` command.

## Potential Limitations
- **WGS Usage**: While theoretically compatible with Whole Genome Sequencing, the high volume of reads will lead to significantly increased run-times. It is optimized for the higher coverage found in WES.
- **Zygosity**: The tool was designed primarily for dominant de novo variation. While it can identify homozygous or compound heterozygous variants, the filtering defaults are tuned for rarity and de novo occurrence.

## Reference documentation
- [InDelible: Genomic Structural Variant Caller by Adaptive Training](./references/github_com_HurlesGroupSanger_indelible.md)