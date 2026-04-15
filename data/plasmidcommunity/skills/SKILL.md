---
name: plasmidcommunity
description: PlasmidCommunity is a bioinformatics suite designed for the classification, community assignment, and transmission risk assessment of Klebsiella pneumoniae plasmids. Use when user asks to categorize plasmids into communities, assign new sequences to existing clusters, evaluate clustering quality, or predict plasmid transmission risk using pre-trained models.
homepage: https://github.com/wuxinmiao5/PlasmidCommunity
metadata:
  docker_image: "quay.io/biocontainers/plasmidcommunity:1.0.2--r44hdfd78af_1"
---

# plasmidcommunity

## Overview
PlasmidCommunity is a specialized bioinformatics suite designed for the classification and risk assessment of *Klebsiella pneumoniae* plasmids. It leverages genomic similarity networks and Average Nucleotide Identity (ANI) to categorize plasmids into communities, enabling researchers to track plasmid evolution, host interactions, and the dissemination of antimicrobial resistance (AMR). The toolkit is divided into three primary functional modules: classification/clustering, community assignment for new sequences, and transmission risk prediction using pre-trained models.

## Installation and Environment
The most efficient way to deploy the tool is via Conda:
```bash
conda create -n plasmidcommunity -c bioconda -c conda-forge plasmidcommunity
conda activate plasmidcommunity
```
Ensure that `fastANI`, `Prodigal`, and `BLAST` are available in your system's PATH, as the shell scripts rely on these external dependencies for sequence similarity and gene prediction.

## Core Workflows

### 1. Plasmid Classification (plasmidCommunity.sh)
This module handles the construction of similarity networks and clustering.

**Silhouette Coefficient Computation**
Use this to evaluate clustering quality and determine optimal thresholds.
```bash
plasmidCommunity.sh -a silhouetteCurve -s /path/to/plasmid_genomes/ -o output_prefix
```

**Community Generation**
Generate plasmid communities based on a specific distance cutoff (e.g., 0.13).
```bash
plasmidCommunity.sh -a getCommunity -c fastani_result.txt -d 0.13 -m 5 -o output_prefix
```
*   `-d`: Distance cutoff for community generation.
*   `-m`: Minimum community size (number of members).

**Pan-Genome Analysis**
Analyze the gene content across identified communities.
```bash
plasmidCommunity.sh -a pan -s /path/to/plasmid_genomes/ -f membership_info.txt -m 5 -o output_prefix
```

### 2. Community Assignment (assignCommunity)
Assign a query plasmid to an existing community based on ANI.
```bash
assignCommunity -q query_plasmid.fasta -d reference_plasmid_directory/ -o assignment_results.txt
```
The tool identifies the highest ANI match and retrieves the corresponding community membership and size.

### 3. Transmission Risk Prediction (PlasmidTransModel)
Predict the likelihood of plasmid transmission using R-based models. This requires pre-trained model files (`binaryModel.Rdata` or `threeClassModel.Rdata`).

*   **Binary Classification**: Predicts high vs. low transmission risk.
*   **Three-Class Classification**: Provides more granular risk categories.

## Expert Tips and Best Practices
*   **Data Preparation**: Ensure all input plasmid sequences are in FASTA format and stored in a single directory for batch processing modes.
*   **Threshold Selection**: While 0.13 is a common distance cutoff for *K. pneumoniae* plasmid communities, use the `silhouetteCurve` mode first to validate if this threshold provides high-quality clustering for your specific dataset.
*   **Resource Management**: Pan-genome analysis and ANI calculations are computationally intensive. Ensure your environment has sufficient memory when processing large databases (e.g., the 7,000+ plasmid reference set).
*   **Model Dependencies**: The transmission risk module requires specific R packages (`tidymodels`, `ranger`, `vegan`). If running from source, verify these are installed in your R environment.

## Reference documentation
- [PlasmidCommunity GitHub Repository](./references/github_com_wuxinmiao5_PlasmidCommunity.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_plasmidcommunity_overview.md)