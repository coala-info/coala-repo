---
name: hotspot3d
description: hotspot3d is a specialized bioinformatics tool used to identify mutation "hotspots" by analyzing the 3D proximity of amino acids within protein structures.
homepage: https://github.com/ding-lab/hotspot3d
---

# hotspot3d

## Overview

hotspot3d is a specialized bioinformatics tool used to identify mutation "hotspots" by analyzing the 3D proximity of amino acids within protein structures. While mutations may appear distant in a linear protein sequence, they often cluster together in the folded 3D conformation. This tool allows researchers to correlate these spatial clusters with known domains, other mutations, or drug-binding sites. Use this skill when you need to process Mutation Annotation Format (MAF) files to find clusters that might have functional or therapeutic significance.

## Core Workflow and CLI Patterns

The hotspot3d workflow is divided into two main phases: Preprocessing (generating or downloading structural proximity data) and Analysis (searching and clustering specific mutation data).

### 1. Preprocessing
Before analyzing mutations, the tool requires proximity data for the proteins of interest.

*   **Automated Preprocessing**: Run the full suite of annotations (ROI, p-values, transcripts, COSMIC).
    ```bash
    hotspot3d prep --output-dir=preprocessing_dir
    ```
*   **Updating Proximity Files**: Calculate 3D distances from PDB files.
    ```bash
    hotspot3d uppro --output-dir=preprocessing_dir --pdb-file-dir=pdb_files_dir --drugport-file=drugport_results
    ```

### 2. Mutation Analysis
Once preprocessing is complete, use your specific mutation data (MAF file) to find hotspots.

*   **Proximity Searching**: Identify pairs of mutations in 3D proximity based on your MAF.
    ```bash
    hotspot3d search --maf-file=your_input.maf --prep-dir=preprocessing_dir
    ```
*   **Clustering**: Group the pairwise proximity data into clusters.
    ```bash
    hotspot3d cluster --pairwise-file=3D_Proximity.pairwise --maf-file=your_input.maf
    ```
*   **Significance Testing**: Determine the statistical significance of identified clusters.
    ```bash
    hotspot3d sigclus --prep-dir=preprocessing_dir --pairwise-file=3D_Proximity.pairwise --clusters-file=3D_Proximity.pairwise.singleprotein.collapsed.clusters
    ```

### 3. Summarization and Visualization
*   **Summary**: Generate a flat-file summary of the clustering results.
    ```bash
    hotspot3d summary --clusters-file=3D_Proximity.pairwise.singleprotein.collapsed.clusters
    ```
*   **Visualization**: Generate scripts for PyMol to visualize the 3D clusters.
    ```bash
    hotspot3d visual --pairwise-file=3D_Proximity.pairwise --clusters-file=3D_Proximity.pairwise.singleprotein.collapsed.clusters --pdb=3XSR
    ```

## Input Requirements and Best Practices

### MAF File Specifications
hotspot3d requires a standard .maf file but necessitates specific columns for successful mapping:
*   **Standard Columns**: `Hugo_Symbol`, `Chromosome`, `Start_Position`, `End_Position`, `Variant_Classification`, `Reference_Allele`, `Tumor_Seq_Allele1`, `Tumor_Seq_Allele2`, `Tumor_Sample_Barcode`.
*   **Required Custom Columns**:
    *   **Transcript ID**: Ensembl coding transcript IDs (e.g., ENST00000275493).
    *   **Protein Change**: HGVS p. single-letter abbreviations (e.g., p.L858R).

### Expert Tips
*   **Preprocessed Data**: Instead of generating proximity files for the entire proteome (which is computationally expensive), download pre-calculated human protein proximity data from Synapse (e.g., GRCh37/Ensembl 74 or GRCh38/Ensembl 87).
*   **Distance Cutoff**: By default, proximity data typically includes pairs within 20 Angstroms. This is generally sufficient for most biological hotspot applications.
*   **Drug Integration**: Use the `drugport` module to parse DrugPort data if you intend to identify mutation-drug clusters for precision medicine research.

## Reference documentation
- [hotspot3d GitHub Repository](./references/github_com_ding-lab_hotspot3d.md)
- [hotspot3d Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hotspot3d_overview.md)