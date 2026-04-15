---
name: isoformcheck
description: IsoformCheck characterizes protein-coding variations and identifies distinct isoforms across haplotype-phased genome assemblies. Use when user asks to map transcript annotations to sample sequences, track copy count variations, or identify novel protein sequences within a pangenome.
homepage: https://github.com/maickrau/IsoformCheck
metadata:
  docker_image: "quay.io/biocontainers/isoformcheck:1.0.0--hdfd78af_0"
---

# isoformcheck

## Overview
IsoformCheck is a specialized bioinformatics tool for characterizing protein-coding variations across haplotype-phased genome assemblies. It maps reference transcript annotations onto sample sequences using `liftoff`, determines the resulting amino acid sequences, and identifies distinct isoforms. This allows researchers to track copy count variations and discover novel protein sequences within a population or pangenome.

## Installation and Setup
The tool is best managed via Bioconda. It is critical to pin the `liftoff` version to ensure compatibility.

```bash
conda create -n isoformcheck isoformcheck liftoff=1.6.3
conda activate isoformcheck
```

## Core Workflows

### 1. Database Initialization
Before analyzing samples, you must create a database using a high-quality reference genome and its corresponding GFF3 annotation.

```bash
IsoformCheck initialize -ref reference.fasta -gff reference.gff3 -db my_isoform_db
```

### 2. Preparing Sample Tables
Commands like `addsamples` and `comparesamples` require a tab-separated sample table. Each sample must have two rows (one per haplotype).

**Table Format (`samples.tsv`):**
| Sample | Haplotype | Assembly | Annotation |
| :--- | :--- | :--- | :--- |
| HG001 | 1 | path/to/h1.fa | [optional_path/to/h1.gff3] |
| HG001 | 2 | path/to/h2.fa | [optional_path/to/h2.gff3] |

### 3. Adding vs. Comparing Samples
*   **`addsamples`**: Use this to permanently store sample data in the database for long-term study and statistical testing.
*   **`comparesamples`**: Use this for rapid screening of novel samples against an existing database without modifying the database itself.

```bash
# To compare novel samples and find what is unique
IsoformCheck comparesamples -db my_isoform_db --table novel_samples.tsv -o screening_results
```

### 4. Statistical Analysis
To run chi-squared tests, you must define groups. This can be done via a group file (Sample, Group) or the `addgroup` command.

```bash
# Generate contingency tables for all transcripts
IsoformCheck contingencytable -db my_isoform_db --group_file groups.tsv -o tables/

# Run chi-squared tests for a specific transcript
IsoformCheck chisquare -db my_isoform_db --group_file groups.tsv --transcript ENST00000123456
```

## Expert Tips and Best Practices
*   **Parallelize Liftover**: For large cohorts, do not let `addsamples` run liftover sequentially. Run the `IsoformCheck liftover` command for each haplotype in parallel on a cluster, then provide the resulting GFF3 paths in the `Annotation` column of your sample table.
*   **Gene Information**: By default, exports only show transcript IDs. Always use the `--include-gene-info` flag with `exportisoforms` or `exportallelesets` to include gene names and chromosomal locations for easier biological interpretation.
*   **Database Maintenance**: Use `IsoformCheck stats -db db_folder` to quickly verify the number of samples, isoforms, and alleles currently indexed.
*   **Haplotype Naming**: Ensure the `Haplotype` column in your sample table uses only allowed values: `1`, `2`, `mat`, or `pat`.



## Subcommands

| Command | Description |
|---------|-------------|
| IsoformCheck | Protein isoform analysis from de novo genome assemblies. |
| liftoff | Lift features from one genome assembly to another |

## Reference documentation
- [IsoformCheck Main Documentation](./references/github_com_maickrau_IsoformCheck_blob_master_README.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_isoformcheck_overview.md)