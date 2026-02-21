---
name: meteor
description: Meteor is a specialized platform designed for the quantitative analysis of metagenomic shotgun sequencing data.
homepage: https://github.com/metagenopolis/meteor
---

# meteor

## Overview

Meteor is a specialized platform designed for the quantitative analysis of metagenomic shotgun sequencing data. It operates by mapping reads against comprehensive gene catalogues to provide species-level taxonomic profiling, functional analysis (including KEGG and DBcan annotations), and strain-level population structure inference. It is particularly effective for studying complex ecosystems like the human gut, oral, or skin microbiomes using pre-built, curated reference catalogues.

## Core Workflow and CLI Patterns

### 1. Reference Catalogue Management
Meteor requires a local microbial gene catalogue. Catalogues come in "full" (all genes + functional data) or "fast" (marker genes only, no functional profiling) versions.

*   **List and Download:**
    ```bash
    # Download a specific catalogue (e.g., human gut)
    meteor download -i hs_10_4_gut -o catalogue_dir/

    # Download the 'light' version for faster species-only profiling
    meteor download -i hs_10_4_gut --fast -o catalogue_dir/
    ```
*   **Available Catalogues:** `fc_1_3_gut` (Cat), `clf_1_0_gut` (Dog), `gg_13_6_caecal` (Chicken), `hs_10_4_gut` (Human Gut), `hs_8_4_oral` (Human Oral), `hs_2_9_skin` (Human Skin), `mm_5_0_gut` (Mouse), `oc_5_7_gut` (Rabbit), `rn_5_9_gut` (Rat), `ssc_9_3_gut` (Pig).

### 2. Data Preparation (Indexing)
Meteor expects a specific directory structure where each sample has its own subdirectory.

*   **Organize FASTQ files:**
    ```bash
    meteor fastq -i /path/to/raw_fastq -o /path/to/formatted_samples
    ```
*   **Handling Multiple Files per Sample:** Use the `-m` regex option to group multiple sequencing runs (e.g., different lanes) into a single sample directory.
    ```bash
    # Groups files containing 'SAMPLE_01', 'SAMPLE_02', etc.
    meteor fastq -i ./raw_data -m "SAMPLE_\\d+" -o ./processed_samples
    ```

### 3. Mapping and Counting
This step aligns reads to the catalogue and generates gene count tables.

*   **Standard Mapping:**
    ```bash
    meteor mapping -i sample_dir/ -r catalogue_dir/ -o mapping_dir/ -t 8
    ```
*   **Preserving Alignments:** By default, Meteor deletes CRAM files to save space. Use `--kf` (keep files) if you intend to perform strain-level profiling later.
*   **Identity Thresholds:** Meteor defaults to 95% identity for full catalogues. For "fast" catalogues, 97% is recommended to reduce false positives.

### 4. Taxonomic and Functional Profiling
Generates abundance tables for species and functions.

*   **Generate Profiles:**
    ```bash
    # Use -n coverage to normalize for gene length
    meteor profile -i mapping_dir/sample/ -r catalogue_dir/ -o profile_dir/ -n coverage
    ```
*   **Outputs:** This generates tables for Species, ARD (Antibiotic Resistance), DBCAN (Carbohydrate enzymes), GMM (Metabolic modules), and GBM (Gut-Brain modules). Note: Functional tables require the "full" catalogue.

### 5. Strain Profiling and Phylogeny
For high-resolution population analysis.

*   **Identify Mutations:**
    ```bash
    meteor strain -i mapping_dir/sample/ -r catalogue_dir/ -o strain_dir/
    ```
*   **Build Trees:**
    ```bash
    meteor tree -i strain_dir/ -o tree_dir/
    ```

## Expert Tips and Best Practices

*   **Pre-processing:** Meteor does not perform quality trimming or host depletion. Always filter out low-quality reads, reads shorter than 60nt, and host-contaminating reads (e.g., human DNA) *before* running `meteor mapping`.
*   **Normalization:** Always use the `-n coverage` flag during the `profile` step to ensure gene counts are normalized by gene length, which is essential for accurate relative abundance comparisons.
*   **Batch Processing:** `meteor mapping` and `meteor profile` typically process one sample at a time. Use a shell loop or the provided Nextflow wrapper (`nf-meteor.nf`) for large cohorts.
*   **Memory Management:** Mapping against large catalogues (like `gg_13_6_caecal`) is memory-intensive. Ensure your environment has sufficient RAM or use the `--fast` catalogue version if functional data is not required.

## Reference documentation
- [Meteor GitHub Repository](./references/github_com_metagenopolis_meteor.md)
- [Meteor Wiki and Detailed Documentation](./references/github_com_metagenopolis_meteor_wiki.md)