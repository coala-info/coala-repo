---
name: wgs2ncbi
description: The `wgs2ncbi` toolkit is designed to streamline the transition from a scaffolded assembly (FASTA) and gene predictions (GFF3) to a valid NCBI submission.
homepage: https://github.com/naturalis/wgs2ncbi
---

# wgs2ncbi

## Overview

The `wgs2ncbi` toolkit is designed to streamline the transition from a scaffolded assembly (FASTA) and gene predictions (GFF3) to a valid NCBI submission. While NCBI's `tbl2asn` tool is the standard for creating submission files, it requires specific input formats that are often difficult to generate for "boutique" genome projects with thousands of scaffolds. This skill provides the procedural knowledge to configure and execute the `wgs2ncbi` pipeline, which manages sequence chunking, feature table generation, and metadata integration.

## Core Workflow

The submission process is divided into four primary functional steps, all of which rely on a central configuration file (`wgs2ncbi.ini`).

### 1. Preparation
Pre-process the annotation file to enable rapid access for subsequent steps.
```bash
wgs2ncbi prepare -conf wgs2ncbi.ini
```

### 2. Processing
Convert the genome FASTA and GFF3 annotations into FASTA chunks and NCBI-compliant feature tables (.tbl).
```bash
wgs2ncbi process -conf wgs2ncbi.ini
```

### 3. Conversion
Invoke NCBI's `tbl2asn` program to transform the generated chunks and tables into SeqIn (.sqn) files.
```bash
wgs2ncbi convert -conf wgs2ncbi.ini
```

### 4. Compression
Collate the resulting SeqIn files into a single archive ready for upload to the NCBI submission portal.
```bash
wgs2ncbi compress -conf wgs2ncbi.ini
```

## Configuration Management

The tool relies on four specific `.ini` files to handle metadata and cleaning. Success with `wgs2ncbi` depends on the accuracy of these files.

| File | Purpose | Key Details |
| :--- | :--- | :--- |
| `wgs2ncbi.ini` | Main Configuration | Define input/output paths, identifier prefixes, and filtering parameters. |
| `info.ini` | Metadata | Key/value pairs for FASTA headers (e.g., organism, strain, sex, tissue, dev_stage). |
| `adaptors.ini` | Sequence Masking | Coordinates of fragments to be blanked out (e.g., sequencing adaptors or contaminants identified by NCBI). |
| `products.ini` | Name Mapping | Maps internal gene/product names to NCBI-accepted nomenclature (e.g., removing database IDs or molecular weights). |

## Expert Tips and Best Practices

- **Iterative Refinement**: NCBI submission is rarely successful on the first pass. Use the `adaptors.ini` and `products.ini` files to address specific feedback from NCBI's validation reports without needing to modify your primary assembly or annotation files.
- **Locus Tag Consistency**: Ensure the `locus_tag` prefix defined in `wgs2ncbi.ini` matches the prefix registered with your NCBI BioProject.
- **Dependency Check**: `wgs2ncbi` acts as a wrapper for `tbl2asn`. Ensure `tbl2asn` is installed and available in your system's PATH before running the `convert` subcommand.
- **Template Creation**: You must provide a `template.sbt` file (created via the NCBI Submission Template Tool). This file contains author and institution metadata and is referenced in the `wgs2ncbi.ini`.

## Reference documentation
- [wgs2ncbi Overview](./references/anaconda_org_channels_bioconda_packages_wgs2ncbi_overview.md)
- [wgs2ncbi GitHub Repository](./references/github_com_naturalis_wgs2ncbi.md)