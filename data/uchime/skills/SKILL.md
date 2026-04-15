---
name: uchime
description: UCHIME identifies chimeric sequences in amplicon sequencing data by comparing query sequences against a trusted reference database. Use when user asks to check sequences for chimeras, benchmark chimera detection, get chimera scores, or view chimera alignments.
homepage: https://drive5.com/uchime/uchime_download.html
metadata:
  docker_image: "quay.io/biocontainers/uchime:4.2--h9948957_0"
---

# uchime

## Overview
UCHIME is a specialized algorithm designed to identify chimeric sequences, which are common artifacts in amplicon sequencing (like 16S rRNA surveys) created when two or more biological sequences fuse during PCR. This skill focuses on the public-domain version (v4.2), which is primarily used for reference-based detection. It compares query sequences against a trusted database of chimera-free sequences (e.g., the "Gold" database) to determine if a query is likely a hybrid of two "parent" sequences present in the reference.

## Command Line Usage

### Basic Reference-Based Detection
The most common use case is checking a set of sequences against a reference database.
```bash
uchime --input query.fasta --db reference.fasta --uchimeout results.uchime
```

### Benchmarking and False Positive Testing
In the public-domain version, the `--self` option is not supported. To ignore reference sequences that are 100% identical to the query (useful for measuring false positives in a trusted dataset), use:
```bash
uchime --input query.fasta --db reference.fasta --uchimeout results.uchime --selfid
```

### Output Formats
*   `--uchimeout <filename>`: Produces a tab-separated file containing the chimera score and classification.
*   `--uchimealn <filename>`: Produces a human-readable alignment showing the query sequence aligned to its two predicted parents.

## Expert Tips and Best Practices

*   **Reference Selection**: For 16S rRNA data, use the "Gold" database (ChimeraSlayer reference). Ensure the reference database contains sequences in both forward and reverse-complemented orientations if your query data orientation is unknown.
*   **Version Awareness**: The public-domain version is frozen at v4.2. If you require high-speed optimizations or advanced *de novo* (denoising) chimera detection, these are typically found in the USEARCH implementation rather than the standalone public-domain UCHIME.
*   **Case Sensitivity**: While fixed in version 4.2, it is a best practice to ensure that both your query and reference sequences use consistent casing (all upper-case or all lower-case) to avoid potential matching failures.
*   **Input Preparation**: Ensure your input FASTA files are properly formatted and do not contain illegal characters, as the public-domain tool provides minimal error reporting for malformed files.

## Reference documentation
- [UCHIME Overview](./references/anaconda_org_channels_bioconda_packages_uchime_overview.md)
- [UCHIME Download and Version Notes](./references/drive_com_uchime_uchime_download.html.md)