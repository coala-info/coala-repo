---
name: wgs2ncbi
description: The wgs2ncbi toolkit prepares genomic assemblies and GFF3 annotations for submission to the NCBI by generating compliant .sqn files. Use when user asks to configure submission metadata, clean annotation data, or generate Whole Genome Shotgun submission files.
homepage: https://github.com/naturalis/wgs2ncbi
---


# wgs2ncbi

## Overview

The `wgs2ncbi` toolkit is designed to bridge the gap between raw genomic outputs (scaffolded FASTA assemblies and GFF3 annotations) and the strict submission requirements of the NCBI. While NCBI's `tbl2asn` is the standard for creating submission files, it requires specific input formats and adheres to rigorous naming conventions that most assembly pipelines do not produce natively. This skill provides the procedural knowledge to configure the toolkit, clean annotation data, and execute the multi-step workflow required to generate a valid `.sqn` file for Whole Genome Shotgun (WGS) submissions.

## Configuration Essentials

The tool relies on four primary `.ini` files and a submission template. Proper setup of these files is critical for a successful run.

### 1. wgs2ncbi.ini (Main Configuration)
This file defines the environment. Key parameters include:
- **Input/Output**: Paths to your assembly FASTA and GFF3 files.
- **Identifiers**: Prefixes for locus tags and general feature IDs.
- **Filtering**: Parameters to exclude short scaffolds or low-quality annotations.

### 2. info.ini (Metadata)
Contains key/value pairs for FASTA headers. Ensure these match your NCBI BioSample/BioProject records:
- `organism`, `strain`, `isolate`
- `sex`, `tissue-type`, `dev-stage`

### 3. adaptors.ini (Sequence Masking)
Used to blank out sequence fragments flagged by NCBI as contaminants or adaptors. 
- **Tip**: Start with an empty file. Populate it only after NCBI's initial screening provides specific coordinates for removal.

### 4. products.ini (Product Name Mapping)
Maps internal gene/product names to NCBI-compliant nomenclature.
- **Tip**: Use this to resolve "illegal" characters or prohibited terms (e.g., "hypothetical protein" is allowed, but names containing molecular weights or database IDs are often rejected).

## Command Line Workflow

Execute the submission preparation in the following sequence:

### Step 1: Prepare
Pre-processes the GFF3 annotation file to create an index for rapid access.
```bash
wgs2ncbi prepare -conf wgs2ncbi.ini
```

### Step 2: Process
Converts the genome FASTA and the prepared annotations into FASTA chunks and NCBI feature tables (.tbl).
```bash
wgs2ncbi process -conf wgs2ncbi.ini
```

### Step 3: Convert
Invokes the NCBI `tbl2asn` utility to generate the `.sqn` files from the chunks created in the previous step.
```bash
wgs2ncbi convert -conf wgs2ncbi.ini
```

### Step 4: Compress
Collates all generated SeqIn files into a single archive ready for upload to the NCBI submission portal.
```bash
wgs2ncbi compress -conf wgs2ncbi.ini
```

## Expert Tips for Submission

- **Iterative Refinement**: NCBI submission is rarely a single-pass process. Expect to run the `process` and `convert` steps multiple times as you update `products.ini` and `adaptors.ini` based on validation reports.
- **Validation Errors**: If `tbl2asn` (Step 3) produces `.val` files with "Error" or "Fatal" messages, you must correct the source GFF3 or update your `.ini` mappings before re-running.
- **Locus Tags**: Ensure the locus tag prefix used in `wgs2ncbi.ini` has been registered and approved by NCBI for your specific BioProject.



## Subcommands

| Command | Description |
|---------|-------------|
| prune | Based on a validation file from NCBI, makes pruned versions of feature tables that omit features within regions identified by NCBI. |
| wgs2ncbi | prepares whole genome sequencing projects for submission to NCBI |
| wgs2ncbi | prepares whole genome sequencing projects for submission to NCBI |
| wgs2ncbi | prepares whole genome sequencing projects for submission to NCBI |
| wgs2ncbi | prepares whole genome sequencing projects for submission to NCBI |
| wgs2ncbi | prepares whole genome sequencing projects for submission to NCBI |

## Reference documentation
- [WGS2NCBI Main Documentation](./references/github_com_naturalis_wgs2ncbi.md)