---
name: oncotator
description: Oncotator is a functional annotation tool that enriches genomic variant data with biological context from cancer-related data sources. Use when user asks to annotate point mutations or indels, convert VCF files to TCGA-compliant MAF format, or initialize data sources for hg19 genomic annotations.
homepage: https://github.com/broadinstitute/oncotator
metadata:
  docker_image: "quay.io/biocontainers/oncotator:1.9.9.0--py_0"
---

# oncotator

## Overview
Oncotator is a functional annotation tool designed to enrich genomic variant data with biological context from various cancer-related data sources. It identifies the effects of point mutations and small insertions/deletions (indels) on genes and transcripts. While it has been largely superseded by Funcotator (part of GATK), Oncotator remains a standard for legacy pipelines requiring specific MAF output formats or hg19 annotations. This skill provides guidance on installation, data source initialization, and core command-line execution patterns.

## Installation and Setup
Oncotator is best installed via Conda to manage its specific dependencies (like `pysam` and `numpy`):

```bash
conda install -c bioconda oncotator
```

### Data Sources
Oncotator requires a specific set of data sources (typically hg19) to function. These are not included in the tool installation and must be downloaded separately.
- Use the `initializeDatasource` command to prepare the database directory if you have a raw data source package.
- Ensure the environment variable or CLI flag points to the directory containing the `oncotator_v1_ds_...` folders.

## Common CLI Patterns

### Basic Annotation (VCF to MAF)
The most common use case is converting a VCF file into a TCGA-compliant MAF file:
```bash
oncotator -v --input-format=VCF --output-format=TCGA_MAF input.vcf output.maf hg19
```

### VCF to Annotated VCF
To keep the output in VCF format while adding annotations to the INFO field:
```bash
oncotator -v --input-format=VCF --output-format=VCF input.vcf output.annotated.vcf hg19
```

### Checking Version
To verify the installation and version:
```bash
Oncotator -V
```

## Expert Tips
- **Legacy Status**: Oncotator is archived and no longer maintained. For new projects, consider using Funcotator within GATK, which is faster and supports hg38.
- **Memory Requirements**: Running unit tests or large-scale annotations typically requires a minimum of 4GB to 6GB of RAM.
- **Input Formats**: While VCF is standard, Oncotator also supports other formats like `MAFLITE` or `SEG_FILE`. Always explicitly define `--input-format` if the file extension is non-standard.
- **Transcript Selection**: Oncotator uses a default set of rules to select the "best" transcript for annotation. If your pipeline requires specific transcript sets (e.g., Canonical only), verify the configuration files in the data source directory.

## Reference documentation
- [Oncotator Overview](./references/anaconda_org_channels_bioconda_packages_oncotator_overview.md)
- [Oncotator GitHub Repository](./references/github_com_broadinstitute_oncotator.md)