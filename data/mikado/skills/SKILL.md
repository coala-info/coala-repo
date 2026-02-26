---
name: mikado
description: Mikado is a transcriptomic meta-assembler and filtering pipeline that integrates multiple RNA-Seq assemblies to select the most biologically plausible gene models. Use when user asks to consolidate multiple transcriptomes, score gene models based on external evidence, or pick the best representative transcripts for a locus.
homepage: https://github.com/lucventurini/mikado
---


# mikado

## Overview

Mikado is a transcriptomic meta-assembler and filtering pipeline designed to resolve the complexity of multiple RNA-Seq assemblies. Instead of relying on a single assembly method, Mikado leverages the strengths of various tools (e.g., StringTie, Trinity, Cufflinks) to define expressed loci and select the most biologically plausible gene models. It uses a multi-metric scoring system that evaluates ORF quality, cDNA size, protein homology, and splice junction reliability to distinguish between high-quality transcripts and artifacts like chimeric or fragmented models.

## Core Workflow and CLI Patterns

The Mikado pipeline typically follows a four-step process: configuration, preparation, serialisation, and picking.

### 1. Configuration
Generate the necessary configuration files and scoring schemas.
- **List available scoring files**: `mikado configure --list`
- **Generate a template configuration**: `mikado configure --scoring <species.yaml> --gtf <input_files> mikado.yaml`
- **Expert Tip**: Use the `--no-pad` option if you do not want Mikado to pad transcripts to the nearest junction.

### 2. Preparation
Consolidate transcripts from multiple GFF/GTF files into a single, unified set.
- **Basic usage**: `mikado prepare --gtf <assembly1.gtf> <assembly2.gtf> --output prepared.gtf`
- **Incorporate junctions**: Use the `--junctions` flag to provide high-quality splice junctions (e.g., from Portcullis) to improve the initial filtering of assemblies.

### 3. Serialisation
Load the prepared transcripts and external evidence (ORFs, BLAST results) into a database.
- **Command**: `mikado serialise --prodigal <orfs.gff> --xml <blast.xml> --json <junctions.json> --orfs <transdecoder.pep>`
- **Database Choice**: By default, Mikado uses SQLite. For very large datasets or high-concurrency environments, configure Mikado to use PostgreSQL or MySQL in the configuration file.

### 4. Picking
The final selection step where Mikado scores transcripts and selects the "best" model for each locus.
- **Command**: `mikado pick --sub-db <database_name> --scoring <scoring_file> --out <output.gtf>`
- **Recovering variants**: Use the `--sub-optimal` or `--all` flags if you need to retain valid alternative splice variants that are compatible with the primary isoform.

## Best Practices and Expert Tips

- **Homology Evidence**: While BLASTX is supported, **DIAMOND** is highly recommended for protein homology searches due to its significantly higher speed with comparable sensitivity.
- **ORF Prediction**: **Prodigal** is generally faster and lighter than Transdecoder for calculating ORFs within the Mikado pipeline, though Transdecoder is often used for more detailed proteogenomic studies.
- **Junction Validation**: Always try to provide junction confidence data from **Portcullis**. This significantly reduces the scoring of chimeric transcripts and improves the accuracy of the final gene models.
- **Reproducibility**: Ensure runs are reproducible by setting a random seed in the configuration or via the CLI if available in your version (v2.0+).
- **Performance**: If Mikado hangs during the `pick` step, check the database timeout limits. For SQLite, Mikado uses WAL (Write-Ahead Logging) to mitigate locking issues, but high I/O environments may still require increasing the timeout.

## Reference documentation
- [Mikado GitHub Repository](./references/github_com_lucventurini_mikado.md)
- [Bioconda Mikado Overview](./references/anaconda_org_channels_bioconda_packages_mikado_overview.md)