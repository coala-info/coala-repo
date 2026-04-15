---
name: jannovar-cli
description: Jannovar-cli is a Java-based tool used for the functional annotation of VCF files and the prediction of variant effects using HGVS nomenclature. Use when user asks to annotate genomic variants, predict transcript-level effects, or build serialized transcript databases for variant interpretation.
homepage: https://github.com/charite/jannovar
metadata:
  docker_image: "quay.io/biocontainers/jannovar-cli:0.36--hdfd78af_0"
---

# jannovar-cli

## Overview
Jannovar is a high-performance Java suite for the functional annotation of VCF files. It maps genomic coordinates to transcript-level effects, providing standardized HGVS nomenclature. This tool is essential for bioinformatics pipelines that require precise variant effect prediction based on specific transcript database releases, such as curated RefSeq sets.

## Installation
The most reliable way to install the CLI tool is via Bioconda:
```bash
conda install -c bioconda jannovar-cli
```

## Core CLI Usage

### 1. Database Preparation
Jannovar requires a serialized database file (`.ser`) to perform annotations.
- **Pre-built Databases**: It is recommended to use pre-built `.ser` files from Zenodo (e.g., `refseq_curated_109_hg38.ser`) to ensure consistency.
- **Building Databases**: If a custom database is needed, use the `download` and `build-db` commands (though note that the `download` command may require manual intervention if upstream URLs have changed).

### 2. VCF Annotation
The primary workflow involves taking a VCF and producing an annotated version.
```bash
jannovar annotate-vcf \
  --database path/to/your_database.ser \
  --input-vcf input.vcf \
  --output-vcf annotated.vcf
```

## Expert Tips and Best Practices

### Database Selection
- **RefSeq Curated vs. Standard**: Always prefer "curated" RefSeq databases (e.g., `refseq_curated_...`) for clinical or high-stringency research. These exclude `XM_` and `XP_` transcripts, which are based on automated gene predictions and can introduce noise into your results.
- **Genome Compatibility**: Jannovar hg19 databases are compatible with both UCSC hg19 and NCBI GRCh37 (including hs37d5).

### Versioning and Compatibility
- **Serialization Versions**: `.ser` files are version-dependent. Databases built with Jannovar 0.33 are generally compatible through version 0.38. If you upgrade the CLI tool significantly, you may need to rebuild or re-download your `.ser` files.
- **Java Requirements**: Ensure Java 8 or higher is available in your environment.

### Performance Optimization
- **Memory Allocation**: For large VCFs or complex databases (like ENSEMBL), increase the Java heap size to prevent `OutOfMemoryError`:
  ```bash
  # If calling the jar directly
  java -Xmx8G -jar jannovar-cli.jar annotate-vcf ...
  ```
- **Filtering**: Use `jannovar-filter` (if available in your distribution) to pre-filter variants before annotation to reduce processing time on large-scale WGS data.

### Troubleshooting
- **NullPointerException**: Often caused by a mismatch between the VCF chromosome naming (e.g., "chr1" vs "1") and the database naming. Ensure your VCF headers match the reference used to build the `.ser` file.
- **Synonymous Mutations**: Check that your output encoding supports UTF-8 if you encounter issues with special characters in synonymous mutation descriptions.

## Reference documentation
- [Jannovar GitHub README](./references/github_com_charite_jannovar.md)
- [Bioconda jannovar-cli Overview](./references/anaconda_org_channels_bioconda_packages_jannovar-cli_overview.md)