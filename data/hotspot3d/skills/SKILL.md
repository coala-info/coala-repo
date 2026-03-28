---
name: hotspot3d
description: "HotSpot3D maps linear protein sequence mutations onto 3D structures to identify and analyze spatial mutation clusters. Use when user asks to identify spatial hotspots, map mutations to 3D protein structures, or determine the statistical significance of mutation clusters."
homepage: https://github.com/ding-lab/hotspot3d
---

# hotspot3d

## Overview
HotSpot3D is a specialized bioinformatics suite that maps linear protein sequence mutations onto 3D structures. This allows researchers to identify spatial clusters (hotspots) that may be functionally significant but are separated by large distances in a 1D sequence. The tool facilitates the correlation of these hotspots with known protein domains, drug-binding sites, and COSMIC annotations.

## Core Workflow

The standard HotSpot3D pipeline follows a two-phase approach: Preprocessing and Analysis.

### 1. Preprocessing
Preprocessing prepares the structural environment and annotations. While you can generate these from scratch, using pre-calculated data from Synapse is recommended for efficiency.

*   **Update Proximity:** Calculate distances between residues in PDB files.
    `hotspot3d uppro --output-dir=prep_dir --pdb-file-dir=pdb_dir`
*   **Run Full Prep:** Executes ROI generation, p-value calculation, and transcript/COSMIC annotation in one step.
    `hotspot3d prep --output-dir=prep_dir`

### 2. Analysis
Once the environment is prepped, use your mutation data (MAF file) to find clusters.

*   **Search:** Identify proximity information for your specific mutations.
    `hotspot3d search --maf-file=input.maf --prep-dir=prep_dir`
*   **Cluster:** Group pairwise data into clusters.
    `hotspot3d cluster --pairwise-file=3D_Proximity.pairwise --maf-file=input.maf`
*   **Significance:** Determine the statistical significance of identified clusters.
    `hotspot3d sigclus --prep-dir=prep_dir --pairwise-file=3D_Proximity.pairwise --clusters-file=output.clusters`
*   **Summary:** Generate a human-readable summary of the clustering results.
    `hotspot3d summary --clusters-file=output.clusters`

## Input Requirements (MAF Format)
HotSpot3D requires a standard .maf file but necessitates two non-standard columns for proper mapping:
1.  **Transcript ID:** Ensembl coding transcript IDs (e.g., ENST00000275493).
2.  **Protein Change:** HGVS p. single-letter abbreviations (e.g., p.L858R).

Essential standard columns include: `Hugo_Symbol`, `Chromosome`, `Start_Position`, `End_Position`, `Variant_Classification`, `Reference_Allele`, `Tumor_Seq_Allele1`, `Tumor_Seq_Allele2`, and `Tumor_Sample_Barcode`.

## Expert Tips & Best Practices
*   **Drug Interactions:** To include drug-mutation proximity, run the `drugport` module first to parse the DrugPort database before running `uppro`.
*   **Visualization:** Use the `visual` command to generate scripts for PyMol. This is the most effective way to validate if a cluster makes structural sense.
    `hotspot3d visual --pairwise-file=3D_Proximity.pairwise --clusters-file=output.clusters --pdb=PDB_ID`
*   **Distance Cutoffs:** By default, proximity data usually contains pairs within 20 Angstroms. If your analysis requires tighter clusters, you may need to filter the `.pairwise` file before clustering.
*   **Environment Setup:** Ensure `PERL5LIB` and `PATH` include the HotSpot3D installation directories, as the tool relies on several Perl modules (LWP::Simple, Parallel::ForkManager).



## Subcommands

| Command | Description |
|---------|-------------|
| hotspot3d | 3D mutation proximity analysis program. |
| hotspot3d | 3D mutation proximity analysis program. |
| hotspot3d | 3D mutation proximity analysis program. Preprocessing steps include parsing drugport database, updating proximity files, and running ROI generation, statistical calculation, annotation, and prioritization. |
| hotspot3d | 3D mutation proximity analysis program. |
| hotspot3d cluster | Cluster mutation-mutation, mutation-drug, or mutation-site pairs using network or density-based methods. |
| hotspot3d drugport | Drugport parsing tool for HotSpot3D |
| hotspot3d main | Hotspot3D main pipeline for proximity search, clustering, and analysis of mutations. |
| hotspot3d prep | Preparation step for Hotspot3D to generate proximity files and perform various analysis steps. |
| hotspot3d prior | Calculate prior probabilities for Hotspot3D analysis |
| hotspot3d search | Search for proximity results using HotSpot3D preprocessing results |
| hotspot3d sigclus | Calculate significance of clusters using simulations |
| hotspot3d summary | Summarize Hotspot3D clusters |
| hotspot3d trans | Generate proximity files for 3D hotspots |
| hotspot3d uppro | Generate proximity files for proteins using PDB data and distance measures. |
| hotspot3d visual | Visualize clusters and mutations using PyMol scripts |

## Reference documentation
- [HotSpot3D GitHub Repository](./references/github_com_ding-lab_hotspot3d.md)
- [HotSpot3D Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hotspot3d_overview.md)