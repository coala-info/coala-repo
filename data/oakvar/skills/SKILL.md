---
name: oakvar
description: OakVar is a modular genomic variant analysis platform used to annotate and interpret genetic variations through a customizable command-line interface. Use when user asks to search for or install modules, run variant annotation workflows, generate reports from analysis results, or launch the interactive GUI.
homepage: http://www.oakvar.com
---


# oakvar

## Overview
OakVar is a modular genomic variant analysis platform designed to streamline the annotation and interpretation of genetic variations. It serves as a successor to CRAVAT, offering a flexible architecture where users can install specific annotators and report generators to customize their bioinformatics pipelines. Use this skill to navigate the OakVar command-line interface, manage the local module ecosystem, and execute end-to-end variant analysis workflows from raw input to structured output.

## Core CLI Patterns

### Module Management
OakVar relies on a modular system. Before running analysis, ensure the necessary components are installed.
- **Search for modules**: `ov module search <keyword>`
- **Install annotators**: `ov module install <module_name>` (e.g., `ov module install gnomad`)
- **Update modules**: `ov module update <module_name>`

### Running Analysis
The primary command for processing variants is `ov run`.
- **Basic Annotation**: `ov run <input_file> -a <annotator1> <annotator2>`
- **Input Formats**: Supports VCF, TSV, and other genomic formats.
- **Genome Assembly**: Specify the assembly if not auto-detected using `-g` (e.g., `-g hg38`).

### Result Management and Reporting
After running an analysis, OakVar stores results in a local database (usually SQLite).
- **Generate Reports**: `ov report <db_path> -t <report_type>` (e.g., `excel`, `vcf`, `json`).
- **Interactive GUI**: Launch the web-based result viewer using `ov gui`.

## Expert Tips
- **Parallelization**: Use the `-n` flag with `ov run` to specify the number of parallel processes for faster annotation of large VCFs.
- **System Setup**: Run `ov system setup` upon first installation to initialize the working directories and base databases.
- **Module Info**: Use `ov module info <module_name>` to check versioning and data sources for specific annotators to ensure reproducibility in your research.

## Reference documentation
- [OakVar Overview](./references/anaconda_org_channels_bioconda_packages_oakvar_overview.md)