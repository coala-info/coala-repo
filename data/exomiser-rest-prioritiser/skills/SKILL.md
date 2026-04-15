---
name: exomiser-rest-prioritiser
description: Exomiser filters and ranks potential disease-causing variants from sequencing data by integrating VCF files with clinical phenotypes. Use when user asks to prioritise variants, rank mutations using HPO terms, or identify causative genes in WES and WGS data.
homepage: https://github.com/exomiser/Exomiser
metadata:
  docker_image: "quay.io/biocontainers/exomiser-rest-prioritiser:14.1.0--hdfd78af_0"
---

# exomiser-rest-prioritiser

## Overview
Exomiser is a specialized Java application designed to filter and rank potential disease-causing variants from whole-exome or whole-genome sequencing (WES/WGS) data. By combining a patient's VCF file with clinical phenotypes encoded as Human Phenotype Ontology (HPO) terms, it automates the process of variant annotation and prioritisation. It leverages pathogenicity scores, population frequencies, and cross-species phenotype comparisons to identify the most likely causative mutations.

## Installation and Setup
The tool is available via Bioconda for streamlined environment management.

```bash
conda install bioconda::exomiser-rest-prioritiser
```

### Data Management
Exomiser requires substantial reference data (hg19, hg38, and phenotype databases).
- **Directory Configuration**: Define a dedicated data directory in the `application.properties` file using the `exomiser.data-directory` field.
- **Version Control**: Specify data versions (e.g., `2410`) for genomic and phenotype data to ensure reproducibility.
- **Shared Resources**: Multiple versions of the software can point to the same data directory to save disk space.

## Execution Best Practices
When running the prioritiser, especially for large datasets, follow these performance and configuration guidelines.

### Java Runtime Optimization
Whole-genome analysis is memory-intensive.
- **Memory Allocation**: Assign at least 16GB of RAM for WGS using the `-Xmx16g` flag.
- **Garbage Collection**: Use the G1 Garbage Collector to prevent performance degradation during large-scale variant processing.
- **Command Pattern**:
  `java -Xmx16g -XX:+UseG1GC -jar exomiser-cli.jar --analysis <path-to-analysis-config>`

### Analysis Configuration
The prioritisation engine relies on several key parameters:
- **Genome Assembly**: Explicitly set to `HG19` or `HG38`.
- **Inheritance Modes**: Define expected patterns such as `AUTOSOMAL_DOMINANT` or `AUTOSOMAL_RECESSIVE`.
- **Frequency Sources**: Utilize integrated datasets including 1000 Genomes, ESP, TOPMed, UK10K, ExAC, and gnomAD.
- **Pathogenicity Sources**: Enable specific predictors like PolyPhen, MutationTaster, or SIFT.

### Prioritisation Modules
- **PHIVE Prioritiser**: Uses mouse and other model organism phenotype data for ranking.
- **OMIM Prioritiser**: Ranks variants based on known human disease associations.
- **Priority Score Filters**: Apply thresholds (e.g., 0.501) to exclude low-confidence candidates early in the pipeline.

## Expert Tips
- **Phenotype-Only Mode**: Exomiser can be configured to run in phenotype-only mode, though it typically requires genomic data for full functional context.
- **VCF Compatibility**: Ensure VCF files are spec-compliant; use tools like `bcftools` to pre-process or normalize variants if the prioritiser encounters parsing errors.
- **Caching**: Enable Spring-based caching in the configuration to speed up repetitive queries across multiple samples.

## Reference documentation
- [Exomiser GitHub Repository](./references/github_com_exomiser_Exomiser.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_exomiser-rest-prioritiser_overview.md)