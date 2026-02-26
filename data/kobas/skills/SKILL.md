---
name: kobas
description: KOBAS performs functional annotation and pathway enrichment analysis by mapping gene lists or sequences to known biological pathways. Use when user asks to assign KEGG Orthology terms to sequences, map gene IDs to orthologs, or identify significantly enriched metabolic pathways and functional categories.
homepage: http://kobas.cbi.pku.edu.cn
---


# kobas

## Overview
KOBAS is a specialized bioinformatics tool designed for automated annotation and pathway identification. It facilitates the translation of raw sequence data or gene lists into biological insights by mapping them against known metabolic pathways and functional categories. This skill provides the necessary command-line patterns to execute both the annotation (mapping IDs/sequences to orthologs) and enrichment (statistical overrepresentation) phases of the KOBAS workflow.

## Core Workflows

### 1. Functional Annotation (kobas-annotate)
Use this to assign KEGG Orthology (KO) terms to your input sequences or IDs.

- **Sequence-based (FASTA):**
  `kobas-annotate -i input.fasta -t fasta:nucl -s <species_code> -o output.annotate`
  *Note: Use `fasta:pro` for protein sequences.*
- **ID-based (Gene List):**
  `kobas-annotate -i gene_list.txt -t id:ensembl -s <species_code> -o output.annotate`

### 2. Pathway Enrichment (kobas-identify)
Use this to find significantly enriched pathways from the results of the annotation step.

- **Standard Enrichment:**
  `kobas-identify -i output.annotate -d K,G,R -m hyper -n <background_species> -o output.identify`
  *Parameters:*
  - `-d`: Databases (K: KEGG, G: GO, R: Reactome).
  - `-m`: Statistical method (hyper: Hypergeometric test, chi: Chi-square).
  - `-b`: Background/Reference species code (e.g., hsa for human, mmu for mouse).

## Expert Tips
- **Species Codes:** Always verify the 3 or 4-letter KEGG species code before running. Common examples include `hsa` (Human), `mmu` (Mouse), `dme` (Drosophila), and `ath` (Arabidopsis).
- **FDR Correction:** KOBAS typically provides multiple testing corrections (Benjamini-Hochberg). Focus on the `Corrected P-value` column in the `.identify` output to determine significance.
- **Database Updates:** Ensure the local KOBAS backend databases are correctly indexed and pointed to by your environment variables if using a local installation rather than the web server.

## Reference documentation
- [KOBAS Overview](./references/anaconda_org_channels_bioconda_packages_kobas_overview.md)