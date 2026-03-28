---
name: meteor
description: Meteor performs high-resolution metagenomic analysis by mapping shotgun sequencing reads against microbial gene catalogues to generate taxonomic and functional profiles. Use when user asks to download gene catalogues, map reads to a reference, generate species-level abundance tables, perform functional annotation, or conduct strain-level population structure inference.
homepage: https://github.com/metagenopolis/meteor
---


# meteor

## Overview

Meteor is a specialized platform designed for high-resolution metagenomic analysis. It transforms raw shotgun sequencing data into actionable biological insights by mapping reads against pre-built microbial gene catalogues. The tool is capable of performing species-level taxonomic profiling (covering Bacteria, Archaea, and Eukaryotes), functional annotation (KEGG, DBcan, ARD), and advanced strain-level population structure inference. It is particularly useful for researchers working with established ecosystems like the human gut, oral cavity, or various animal models.

## Core CLI Workflow

### 1. Environment Setup and Testing
Verify the installation and dependencies (Python 3.11+, bowtie2, freebayes) before starting a production run.
```bash
meteor test
```

### 2. Catalogue Management
Meteor requires a reference catalogue specific to the ecosystem being studied.
- **Full version**: Includes all genes; required for functional profiling.
- **Light/Fast version**: Includes only marker genes; used for rapid taxonomic profiling.

**Common Pattern:**
```bash
# Download human gut catalogue in fast mode
meteor download -i hs_10_4_gut --fast -o catalogue_dir/
```
*Available catalogues include: `fc_1_3_gut` (cat), `gg_13_6_caecal` (chicken), `hs_10_4_gut` (human gut), `mm_5_0_gut` (mouse), etc.*

### 3. Data Indexing
Prepare your FASTQ files by creating the required directory structure and JSON metadata.
```bash
# Basic indexing
meteor fastq -i /path/to/fastq -o /path/to/output_dir

# Grouping multiple sequencing runs for the same library
meteor fastq -i ./ -m "SAMPLE_\\d+" -o output_dir
```

### 4. Mapping and Counting
Map reads against the catalogue to generate gene count tables.
- **Identity Threshold (`--id`)**: Default is 95% for full catalogues. Use 97% for "fast" catalogues to reduce false positives.
- **Strain Profiling Prep**: You must use `--kf` (keep filtered) to retain the CRAM files necessary for subsequent strain analysis.

**Expert Tip:** Filter out host reads and low-quality reads (length < 60nt) before running this step.
```bash
meteor mapping -i sample_dir/ -r catalogue_dir/ -o mapping_dir/ --kf -t 8
```

### 5. Taxonomic and Functional Profiling
Generate abundance tables for species and functions.
- Use `-n coverage` to normalize read counts by gene length.
- Functional outputs (ARD, DBCAN, GMM, GBM) are only generated when using a **full** catalogue.

```bash
meteor profile -i mapping_dir/sample_dir -o profile_dir -r catalogue_dir -n coverage
```

### 6. Merging and Comparative Analysis
Combine individual sample profiles into a single global table for statistical analysis.
```bash
meteor merge -i profile_dir -r catalogue_dir -o merging_dir
```

### 7. Strain-Level Inference
Identify specific mutations and build phylogenetic trees to analyze population structure.
```bash
# Identify mutations
meteor strain -i mapping_dir/sample_dir -o strain_dir -r catalogue_dir

# Build phylogenetic trees (GTR+GAMMA model)
meteor tree -i strain_dir -o tree_dir
```

## Best Practices and Tips

- **Memory Management**: The "fast" mode significantly reduces memory and time requirements and is recommended for large cohorts where only taxonomic composition is needed.
- **JSON Metadata**: Meteor generates `_census_stage_N.json` files at each step. These contain valuable audit trails (parameters, versions, and metrics) and should be preserved.
- **Automation**: For large-scale processing, use the Nextflow wrapper (`nf-meteor.nf`) provided in the repository to automate the transition between mapping, profiling, and merging.
- **Normalization**: Always use the `-n coverage` flag during the `profile` step if you intend to compare abundances across different genes or samples.



## Subcommands

| Command | Description |
|---------|-------------|
| download | Download a specific catalogue for Meteor analysis. |
| fastq | Create a fastq repository from a directory containing fastq files. |
| mapping | Map reads against a gene catalog and calculate raw gene counts. |
| merge | Merge abundance tables from multiple samples into a single directory. |
| profile | Generate species and functional abundance tables from raw gene counts. |
| strain | Perform variant calling and strain analysis on mapped samples. |
| tree | Infer phylogenetic trees from strain directories using various models and output formats. |

## Reference documentation
- [Meteor GitHub Repository](./references/github_com_metagenopolis_meteor.md)
- [Meteor Wiki and Documentation](./references/github_com_metagenopolis_meteor_wiki.md)