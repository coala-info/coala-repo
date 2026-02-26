---
name: dram
description: DRAM provides high-resolution functional profiling and metabolic annotation of microbial and viral genomes by distilling database hits into refined summaries. Use when user asks to annotate microbial genomes, distill functional profiles, identify auxiliary metabolic genes in viral contigs, or perform metabolic reconstruction across multiple genomes.
homepage: https://github.com/shafferm/DRAM/
---


# dram

## Overview

DRAM (Distilled and Refined Annotation of Metabolism) is a bioinformatic tool designed to provide high-resolution functional profiling of microbial and viral genomes. Unlike standard annotators that provide raw database hits, DRAM "distills" these results into three levels of information: Raw, Distillate, and Liquor. It is the preferred tool for researchers needing to infer organismal metabolism across hundreds of genomes or identify auxiliary metabolic genes (AMGs) in viral contigs.

## Core Workflows

### 1. Database Setup and Configuration
Before running annotations, DRAM must have its databases prepared. This is a resource-intensive one-time step.

*   **Standard Setup (with KEGG):**
    `DRAM-setup.py prepare_databases --output_dir DRAM_data --kegg_loc kegg.pep`
*   **Memory-Constrained Setup:**
    Use `--skip_uniref` to reduce RAM requirements from ~512 GB to ~64-128 GB.
*   **Verify Configuration:**
    `DRAM-setup.py print_config`

### 2. Annotating and Distilling MAGs
The standard pipeline for microbial genomes involves two distinct steps.

*   **Annotation:**
    `DRAM.py annotate -i 'path/to/bins/*.fa' -o annotation_output`
    *Note: Always wrap the input path in single quotes when using wildcards to ensure the internal globbing works correctly.*
*   **Distillation:**
    `DRAM.py distill -i annotation_output/annotations.tsv -o distill_output --trna_path annotation_output/trnas.tsv --rrna_path annotation_output/rrnas.tsv`

### 3. Viral Annotation (DRAM-v)
DRAM-v is specialized for viral contigs and requires output from VirSorter.

*   **Viral Annotation:**
    `DRAM-v.py annotate -i viral_contigs.fa -v VIRSorter_affi-contigs.tab -o viral_anno_output`
*   **Viral Distillation:**
    `DRAM-v.py distill -i viral_anno_output/annotations.tsv -o viral_distill_output`

## Expert Tips and Best Practices

*   **Resource Management:** DRAM annotation is memory-heavy. If using UniRef90, ensure the system has at least 220 GB of RAM. If RAM is limited, use KOfam for KEGG and skip UniRef90 to keep usage under 50 GB.
*   **Input Formats:** Ensure genome bins use standard extensions (.fa, .fasta, .fna). If your files have different extensions, specify them in the input glob.
*   **AMG Identification:** In DRAM-v, potential Auxiliary Metabolic Genes (AMGs) are identified using auxiliary scores and metabolic flags. By default, a gene is a potential AMG if it has an 'M' flag, no 'V', 'A', or 'I' flags, and an auxiliary score of 3 or lower.
*   **Updating Installations:** When moving to a new environment, use `DRAM-setup.py export_config` and `DRAM-setup.py import_config` to migrate database paths without re-downloading hundreds of gigabytes of data.

## Reference documentation
- [DRAM GitHub Repository](./references/github_com_WrightonLabCSU_DRAM.md)
- [DRAM Wiki](./references/github_com_WrightonLabCSU_DRAM_wiki.md)
- [DRAM Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_dram_overview.md)