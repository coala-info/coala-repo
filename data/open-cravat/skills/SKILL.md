---
name: open-cravat
description: OpenCRAVAT (Open Custom Ranked Analysis of Variant Tools) is a modular framework designed to transform raw genomic variant data into annotated, interpretable results.
homepage: http://www.opencravat.org
---

# open-cravat

## Overview
OpenCRAVAT (Open Custom Ranked Analysis of Variant Tools) is a modular framework designed to transform raw genomic variant data into annotated, interpretable results. This skill provides the procedural knowledge required to initialize the environment, manage annotation modules, and execute analysis jobs. It is particularly useful for bioinformaticians needing to integrate functional scores (like CHASMplus or VEST) and clinical databases (like ClinVar) into their variant discovery pipelines.

## Core Workflows

### 1. Initialization and Module Management
Before running annotations, the base system and specific annotators must be installed.
- **Initialize**: `oc admin init` (Run once after installation to set up the working directory).
- **List Modules**: `oc module ls -a` to see available annotators and filters.
- **Install Annotators**: `oc module install <module_name>` (e.g., `oc module install clinvar gnomad`).
- **Update**: `oc module update <module_name>` to keep data sources current.

### 2. Running Annotations
The primary command for processing variants is `oc run`.
- **Basic VCF Annotation**: `oc run input.vcf -l hg38`
- **Specific Annotators**: Use `-a` to limit which modules are run:
  `oc run input.vcf -a clinvar gnomad vesta`
- **Output Formats**: Use `-t` to specify output types (excel, text, vcf):
  `oc run input.vcf -t excel text`

### 3. Result Inspection and Export
- **GUI Mode**: Launch the interactive web interface to visualize results: `oc gui`
- **Report Generation**: If a job is already finished, generate new report formats without re-running the analysis:
  `oc report <job_id> -t vcf`

## Expert Tips
- **Genome Assembly**: Always verify the assembly version of your input file. Use `-l hg19` or `-l hg38` explicitly to avoid mismatch errors.
- **Resource Management**: For large VCFs, use the `--mp` flag to specify the number of parallel processes: `oc run input.vcf --mp 4`.
- **Module Store**: Use `oc module info <module_name>` to check the version and data source details before running a large-scale production pipeline.

## Reference documentation
- [OpenCRAVAT Overview](./references/www_opencravat_org_index.md)
- [Installation and BioConda Details](./references/anaconda_org_channels_bioconda_packages_open-cravat_overview.md)