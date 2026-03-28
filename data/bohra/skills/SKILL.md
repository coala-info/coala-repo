---
name: bohra
description: Bohra is a command-line utility that orchestrates bacterial genomics workflows from raw sequencing data to annotated phylogenetic trees and AMR reports. Use when user asks to perform bacterial assembly, detect antimicrobial resistance, run Mycobacterium tuberculosis specific analysis, or conduct comparative genomics.
homepage: https://github.com/kristyhoran/bohra
---


# bohra

## Overview
Bohra is a comprehensive command-line utility designed to streamline bacterial genomics workflows. It acts as an orchestrator for various bioinformatics tools, allowing users to move from raw sequencing data to annotated phylogenetic trees and summary reports. It is particularly useful for public health microbiology, offering specialized pipelines for general bacterial assembly, antimicrobial resistance (AMR) detection, and Mycobacterium tuberculosis (TB) specific analysis.

## Input Preparation
Bohra requires a tab-delimited input file. You can generate this template automatically using the `generate-input` command:

```bash
bohra generate-input --isolate_ids <samples>.txt --reads /path/to/reads --contigs /path/to/contigs --outname input_table.txt
```

### Input Table Columns
- **Isolate**: Unique sample identifier (Required).
- **r1 / r2**: Paths to paired-end reads (Required if no assembly provided).
- **assembly**: Path to FASTA assembly (Required if no reads provided).
- **Species_expected**: Expected species name for targeted typing/AMR inference.
- **is_control**: Mark as 'control' to exclude from comparative analysis while still running single-sample metrics.

## Core Pipeline Commands
Bohra is modular. Choose the pipeline that matches your analytical goals:

- **Basic**: `bohra basic --input input_table.txt`
  Focuses on QC and initial characterization.
- **Assembly**: `bohra assemble --input input_table.txt`
  Performs *de novo* assembly from raw reads.
- **Comparative**: `bohra comparative --input input_table.txt`
  Runs reference-free (ska2, mash) or reference-based comparisons.
- **TB**: `bohra tb --input input_table.txt`
  Specialized workflow for *Mycobacterium tuberculosis* complex.
- **Full**: `bohra full --input input_table.txt`
  Executes the complete suite from reads to comparative genomics.

## Expert Tips & Best Practices
- **Speciation Control**: If you already know your species and want to skip the computational overhead of speciation while still getting accurate AMR results, use the `Species_expected` column in your input file combined with the `--speciation none` flag.
- **Database Management**: Ensure the `BOHRA_PUBMLST_DB` and `BOHRA_BLAST_DB` environment variables are set if you are using custom or updated MLST profiles.
- **Resource Efficiency**: If you have already generated assemblies, provide them in the `assembly` column. Bohra will detect these and skip the assembly step, significantly reducing runtime.
- **Metadata Integration**: Any additional columns added to the input file (e.g., 'Location', 'Date') will be automatically propagated to the final phylogenetic tree annotations and summary tables.



## Subcommands

| Command | Description |
|---------|-------------|
| bohra init-databases | Download and/or setup required databases. |
| bohra test | Check that bohra is installed correctly and runs as expected. |
| bohra_deps | Manage bohra dependencies. |
| bohra_generate-input | Generare input files for the Bohra pipeline. |

## Reference documentation
- [Usage Overview](./references/mdu-phl_github_io_bohra_usage_overview.md)