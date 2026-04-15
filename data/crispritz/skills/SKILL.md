---
name: crispritz
description: CRISPRitz is a software suite for the predictive analysis and assessment of CRISPR/Cas experiments, including variant-aware off-target searching. Use when user asks to integrate genomic variants, index genomes with specific PAM sequences, perform off-target searches with mismatches and bulges, or annotate and report on guide RNA behavior.
homepage: https://github.com/InfOmics/CRISPRitz
metadata:
  docker_image: "quay.io/biocontainers/crispritz:2.7.0--py38h9948957_2"
---

# crispritz

## Overview
CRISPRitz is a specialized suite designed for the predictive analysis and assessment of CRISPR/Cas experiments. It is particularly powerful for researchers who need to account for genomic variants (SNPs and indels) during off-target searches, as it can encode these variants using IUPAC notation. Use this skill to manage the full lifecycle of CRISPR computational analysis: from indexing a reference genome with specific PAM sequences to performing high-throughput off-target searches and generating annotated reports that provide biological context to the findings.

## Core Workflow and CLI Usage

The tool is invoked via the main wrapper script: `crispritz.py`.

### 1. Genomic Variant Integration
Use `add-variants` to create a variant-enriched genome. This is essential for population-aware guide design.
- **Action**: Converts standard genomic files and VCF-derived data into IUPAC-encoded sequences.
- **Output**: A set of files representing the genome enriched with variants.

### 2. Genome Indexing
Before searching, you must index the genome based on your target PAM.
- **Command**: `crispritz.py index-genome [genome_dir] [pam_file]`
- **Tip**: Ensure the PAM file matches the specific Cas enzyme being used (e.g., NGG for SpCas9).

### 3. Off-Target Search
Perform searches against reference or variant-enriched genomes.
- **Command**: `crispritz.py search [index_dir] [guide_file] [out_dir] -m [mismatches] -b [bulges]`
- **Key Parameters**:
    - `-m`: Maximum number of mismatches allowed.
    - `-b`: Maximum number of DNA/RNA bulges allowed.
- **Output**: A comprehensive list of all targets and off-targets, plus profile files containing mismatch distributions.

### 4. Functional Annotation
Add biological relevance to search results (e.g., identifying if an off-target falls in a promoter or coding region).
- **Command**: `crispritz.py annotate-results [search_results] [annotation_file]`
- **Utility**: Helps prioritize guides by filtering out off-targets in critical functional elements like exons or open chromatin regions.

### 5. Result Assessment and Reporting
- **`process-data`**: Compare off-target profiles between a standard reference genome and a variant-enriched genome to identify "variant-specific" off-targets.
- **`generate-report`**: Create a graphical summary of a guide's behavior, including mismatch and bulge profiles.

## Expert Tips
- **IUPAC Advantage**: When working with human data, always prefer the variant-enriched workflow (`add-variants` -> `search`) to avoid missing potential off-targets that only exist in specific individuals or populations.
- **Memory Management**: Indexing large genomes (like human) requires significant RAM. Ensure your environment has at least 16-32GB for smooth indexing.
- **Mismatch Thresholds**: While CRISPRitz supports high mismatch counts, searching with >4-5 mismatches significantly increases computation time and may yield many low-probability hits.

## Reference documentation
- [CRISPRitz Overview](./references/anaconda_org_channels_bioconda_packages_crispritz_overview.md)
- [CRISPRitz GitHub Repository and Tool Descriptions](./references/github_com_InfOmics_CRISPRitz.md)