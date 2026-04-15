---
name: svtk
description: The Structural Variation Toolkit (svtk) provides a suite of utilities for processing, annotating, and evaluating structural variant calls. Use when user asks to convert VCF files to BED format, annotate functional context, count variant types, or perform statistical validation using split-read and read-depth evidence.
homepage: https://github.com/talkowski-lab/svtk
metadata:
  docker_image: "quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7"
---

# svtk

## Overview

The Structural Variation Toolkit (svtk) is a specialized suite of utilities designed to process, annotate, and evaluate structural variant calls. It serves as a bridge between standard genomic formats like VCF and BED, while providing domain-specific logic for SV-type counting and complex variant resolution. While the core package has been migrated to the official GATK-SV repository, this standalone version remains a reference for specific PESR (Paired-End/Split-Read) and RD (Read-Depth) testing procedures.

## Common CLI Patterns and Commands

### Format Conversion
Use `vcf2bed` to transform SV VCF files into BED format for downstream interval-based analysis.
* **Coordinate System**: Note that `svtk vcf2bed` automatically converts VCF coordinates to 0-based coordinates in the output BED file.
* **Filtering**: The tool preserves FILTER column information; ensure your input VCF is properly pre-filtered to avoid carrying low-quality sites into the BED output.

### SV Annotation
Use `svtk annotate` to add functional context to SV calls.
* **Chromosome Naming**: The annotator is flexible with naming conventions. It accepts both "chr#" (e.g., chr1, chrX) and bare integers/characters (e.g., 1, X, Y).
* **Impact Analysis**: Use this to identify Loss-of-Function (LoF) events, particularly for deletions and duplications (DUP_LOF).

### Dataset Summarization
Use `count-svtypes` to generate a breakdown of variant classes (DEL, DUP, INV, BND, etc.) within a file.
* **Piping**: This command supports standard input, allowing for efficient integration into shell pipelines:
  `cat variants.vcf | svtk count-svtypes`

### Statistical Testing
The toolkit includes specialized modules for validating SVs using orthogonal evidence:
* **SRTest**: Evaluates split-read support, including specific logic for interchromosomal breakends (BNDs).
* **RdTest**: Performs read-depth validation to confirm copy-number changes.
* **KS Stats**: Used for calculating Kolmogorov-Smirnov statistics to compare depth distributions, often used in filtering pipelines to eliminate stochastic noise.

## Expert Tips

* **Complex Variant Resolution**: When working with complex SVs (CPX), ensure you are using the resolution logic that matches your pipeline version, as resolution code for complex events often undergoes significant refinement during DSP (Data Sciences Platform) integration.
* **Dependency Management**: `svtk` relies heavily on `pysam`, `pybedtools`, and `cython`. If encountering performance issues with large VCFs, ensure the Cython extensions (`svtk/utils/helpers.pyx`) are properly compiled during installation.
* **Migration Note**: For the most actively maintained version of these tools, refer to the GATK-SV repository. This standalone `svtk` package is primarily for legacy support or specific research workflows.



## Subcommands

| Command | Description |
|---------|-------------|
| svtk | Annotate resolved SV with genic effects and noncoding hits. |
| svtk | Convert a VCF to a BED. |
| svtk bincov | Calculates non-duplicate primary-aligned binned coverage of a chromosome from an input BAM file |
| svtk collect-pesr | Collect split read and discordant pair data from a bam alignment. |
| svtk pe-test | Calculate enrichment of discordant pairs at SV breakpoints. |
| svtk resolve | Resolve complex SV from inversion/translocation breakpoints and CNV intervals. |
| svtk sr-test | Calculate enrichment of clipped reads at SV breakpoints. |
| svtk standardize | Standardize a VCF of SV calls. |
| svtk vcfcluster | Intersect SV called by PE/SR-based algorithms. |
| svtk_bedcluster | Cluster a bed of structural variants based on reciprocal overlap. |
| svtk_count-svtypes | Count the instances of each SVTYPE observed in each sample in a VCF. |
| svtk_rdtest2vcf | Convert an RdTest-formatted bed to the standard VCF format. |

## Reference documentation

- [SVTK README](./references/github_com_talkowski-lab_svtk_blob_master_README.md)
- [Setup and Dependencies](./references/github_com_talkowski-lab_svtk_blob_master_setup.py.md)
- [SVTK Commit History and Subcommands](./references/github_com_talkowski-lab_svtk_commits_master.md)