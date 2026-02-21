---
name: isoformcheck
description: IsoformCheck is a comparative genomics tool that bridges the gap between genome assembly and functional protein analysis.
homepage: https://github.com/maickrau/IsoformCheck
---

# isoformcheck

## Overview
IsoformCheck is a comparative genomics tool that bridges the gap between genome assembly and functional protein analysis. It automates the process of lifting over reference annotations to new assemblies, translating coding sequences into amino acid isoforms, and quantifying these isoforms across individuals or populations. By treating protein sequences as discrete alleles, it enables researchers to detect novel protein variants and analyze copy count variation (CNV) in a phylogenomic context.

## Installation and Environment
The tool is available via Bioconda. To ensure compatibility with the liftover process, it is recommended to pin the `liftoff` version during installation.

```bash
conda create -n isoformcheck isoformcheck liftoff=1.6.3
```

## Core Workflow

### 1. Database Initialization
Before processing samples, you must create a database using a high-quality reference genome and its corresponding GFF3 annotation.

```bash
IsoformCheck initialize -ref reference.fasta -gff reference.gff3 -db project_db
```

### 2. Preparing the Sample Table
Most commands require a tab-separated sample table. Each row represents a single haplotype (two rows per diploid sample).

**Format:**
- **Sample**: Name of the individual.
- **Haplotype**: Must be `1`, `2`, `mat`, or `pat`.
- **Assembly**: Path to the fasta/fastq file for that haplotype.
- **Annotation** (Optional): Path to a pre-computed liftover GFF3. If blank, the tool runs `liftoff` automatically.

### 3. Detecting Novel Isoforms
To compare new assemblies against an existing database without modifying the database itself, use `comparesamples`.

```bash
IsoformCheck comparesamples -db project_db --table new_samples.tsv -o output_dir
```
This generates three primary files:
- `output_allelesets.tsv`: All detected allele sets.
- `output_novel_isoforms.tsv`: Protein sequences not found in the database.
- `output_novel_allelesets.tsv`: New combinations of isoforms.

### 4. Building and Expanding a Database
To permanently store samples for population-level analysis:
1. **Add Samples**: `IsoformCheck addsamples -db project_db --table samples.tsv`
2. **Finalize Names**: `IsoformCheck rename -db project_db` (Assigns stable names to all isoforms).

## Statistical Analysis
Once samples are in the database, you can perform group-based comparisons.

### Group Definition
Create a TSV file with two columns: `Sample` and `Group`.

### Running Tests
1. **Generate Contingency Tables**:
   ```bash
   IsoformCheck contingencytable -db project_db --group_file groups.tsv -o tables/
   ```
2. **Run Chi-Squared Tests**:
   ```bash
   IsoformCheck chisquare -db project_db --group_file groups.tsv -o stats.tsv
   ```

## Data Export
To retrieve sequences or counts for downstream analysis:
- **Export Isoforms**: `IsoformCheck exportisoforms -db project_db --include-gene-info`
- **Export Allele Sets**: `IsoformCheck exportallelesets -db project_db --include-gene-info`

## Expert Tips and Best Practices
- **Parallelization**: For large cohorts (e.g., >50 samples), do not let `comparesamples` or `addsamples` run the liftover step internally. Instead, run `liftoff` in parallel across your cluster for each haplotype first, then provide the resulting GFF3 paths in the `Annotation` column of your sample table.
- **Haplotype Consistency**: Ensure your haplotype labels (`1`/`2` or `mat`/`pat`) are consistent across the entire project to avoid errors in allele set construction.
- **Gene Info**: Always use the `--include-gene-info` flag during export if you need to map transcript IDs back to standard gene symbols or genomic coordinates.
- **Database Portability**: An IsoformCheck database is a directory. You can share the entire folder (containing `sample_info.db`, `sequences.agc`, etc.) with collaborators to ensure they are comparing against the same isoform definitions.

## Reference documentation
- [IsoformCheck GitHub README](./references/github_com_maickrau_IsoformCheck.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_isoformcheck_overview.md)