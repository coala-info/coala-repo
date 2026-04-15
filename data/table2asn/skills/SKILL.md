---
name: table2asn
description: table2asn converts genomic sequences and feature tables into validated submission files for NCBI databases. Use when user asks to generate .sqn files, convert FASTA and feature tables into submission records, or prepare genomic data for GenBank.
homepage: https://www.ncbi.nlm.nih.gov/genbank/table2asn/
metadata:
  docker_image: "quay.io/biocontainers/table2asn:1.28.1179--he45da00_1"
---

# table2asn

## Overview
table2asn is the standard utility for converting raw genomic data into submission-ready records. It processes FASTA sequence files, "source" metadata (organism, strain, etc.), and feature tables (.tbl) to generate validated .sqn files. This tool is essential for researchers submitting genomes, transcriptomes, or targeted sequences to GenBank, as it performs initial validation and formatting that ensures compatibility with NCBI databases.

## Core Workflow
To generate a submission file, ensure your input files share the same base filename (e.g., `genome.fsa` and `genome.tbl`).

### Basic Command Pattern
```bash
table2asn -i [input_fasta] -t [template_file] -a [type] -outdir [output_path]
```

### Common Parameters
- `-i`: Input sequence file (FASTA format).
- `-t`: Submission template file (generated via NCBI's Template Maker).
- `-a`: File type (e.g., `s` for set, `g` for genome).
- `-f`: Feature table file (must have `.tbl` extension).
- `-src`: Source modifier file (metadata like strain, isolate, country).
- `-V`: Verification level (e.g., `v` for full validation).
- `-M`: Mitochondrial or Chloroplast genetic code selection (e.g., `-M n` for nuclear).

## Expert Tips & Best Practices
- **Filename Matching**: table2asn automatically pairs files based on the base name. If you have `seq1.fsa`, the tool will look for `seq1.tbl` and `seq1.src` in the same directory.
- **Validation Checks**: Always check the resulting `.val` files. These contain errors and warnings from the NCBI validator. A submission will likely be rejected if "Error" level messages are present.
- **Template Files**: Use a fresh `.sbt` template file for every new submission to ensure contact information and bio-project metadata are current.
- **Gapped Sequences**: If your FASTA contains gaps (Ns), use the `-l` parameter to specify how gaps should be interpreted (e.g., `-l bridged` for known gap sizes).
- **Batch Processing**: Use the `-p` flag to point to a directory containing multiple sets of files for bulk conversion.

## Reference documentation
- [table2asn Overview](./references/anaconda_org_channels_bioconda_packages_table2asn_overview.md)