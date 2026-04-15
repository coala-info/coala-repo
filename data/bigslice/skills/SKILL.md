---
name: bigslice
description: BiG-SLiCE is a scalable tool for analyzing Biosynthetic Gene Clusters (BGCs). Use when user asks to cluster BGCs, query BGCs against known families, or predict secondary metabolites.
homepage: https://github.com/satriaphd/bigslice
metadata:
  docker_image: "quay.io/biocontainers/bigslice:2.0.2--pyh8ed023e_0"
---

# bigslice

bigslice/
├── SKILL.md
└── references/
    ├── anaconda_org_channels_bioconda_packages_bigslice_overview.md
    ├── github_com_medema-group_bigslice.md
    └── github_com_medema-group_bigslice_wiki.md
```

bigslice/SKILL.md:
```yaml
name: bigslice
description: A highly scalable, user-interactive tool for the large-scale analysis of Biosynthetic Gene Clusters (BGCs) data. Use when Claude needs to analyze BGCs for identifying gene clusters, predicting secondary metabolites, and performing comparative analysis of homologous BGCs to chart biosynthetic diversity. This includes tasks like clustering BGCs, querying putative BGCs against known Gene Cluster Families (GCFs), and visualizing analysis results.
---
## Overview

BiG-SLiCE is a powerful command-line tool designed for the scalable and interactive analysis of Biosynthetic Gene Clusters (BGCs). It excels at clustering large numbers of BGCs, identifying Gene Cluster Families (GCFs), and facilitating comparative analysis to understand biosynthetic diversity across microbial genomes. BiG-SLiCE also offers features for querying novel BGCs against existing databases and provides interactive visualization tools to explore the analysis results.

## Usage Instructions

### Installation

Ensure you have HMMer (version 3.2b1 or later) installed. Install BiG-SLiCE using pip:

*   **From PyPI (stable):**
    ```bash
    pip install bigslice
    ```
*   **From source (bleeding edge):**
    ```bash
    pip install git+https://github.com/medema-group/bigslice.git
    ```

Fetch the latest HMM models (approximately 271MB gzipped):
```bash
download_bigslice_hmmdb
```

Check your installation:
```bash
bigslice --version
```

### Core Functionality

#### Clustering Analysis

Run BiG-SLiCE clustering analysis on your BGC data. Ensure your input data is prepared in an input folder (refer to the wiki for input folder preparation).

```bash
bigslice -i <input_folder> <output_folder>
```

For a minimal test run, you can use the provided example input folder.

#### Querying antiSMASH BGCs

Perform a fast query of a putative BGC against pre-processed Gene Cluster Family (GCF) models. This helps in determining the function and novelty of a BGC.

```bash
bigslice --query <antismash_output_folder> --n_ranks <int> <output_folder>
```
This command queries the latest clustering result within the specified `output_folder`. It returns a ranked list of GCFs and BGCs similar to the input BGC.

#### Custom GenBank Input

For BGCs not processed by antiSMASH/MIBiG (e.g., from ClusterFinder, DeepBGC, or manually refined borders), use the provided converter script. This script takes a GenBank file and a descriptor file for BGC generation. Refer to the script's folder for example input files.

#### User Interactive Output

BiG-SLiCE's output folder contains an SQLite3 database and scripts for a mini web-app to visualize the data.

1.  **Fulfill package requirements:**
    ```bash
    pip install -r <output_folder>/requirements.txt
    ```
2.  **Run the Flask server:**
    ```bash
    bash <output_folder>/start_server.sh <port(optional)>
    ```
3.  Open your browser and navigate to the URL provided by the server (e.g., `http://0.0.0.0:5000/`).

#### Programmatic Access and Postprocessing

For advanced users, BiG-SLiCE's preprocessed data can be accessed and manipulated using SQL(ite) queries on the output database. Jupyter notebook scripts are also available for performing analyses and generating figures.

### Expert Tips

*   **Scalability:** BiG-SLiCE is designed for large-scale analysis. For datasets exceeding 1.2 million BGCs, it can process them efficiently (e.g., in under a week on a 36-core machine with 128GB RAM).
*   **HMMer Version:** Ensure you are using HMMer version 3.2b1 or later for optimal compatibility and performance.
*   **Model Updates:** BiG-SLiCE v2.0 includes updated pHMM databases (PFAM 35.0) and BGC class definitions (antiSMASH v7.0.0).
*   **Exporting Results:** Use the `--export-csv` parameter to export pre-calculated BGCs and GCFs tables into TSVs for further analysis.

## Reference documentation
- [BiG-SLiCE README](./references/github_com_medema-group_bigslice.md)
- [BiG-SLiCE Wiki](./references/github_com_medema-group_bigslice_wiki.md)
- [BiG-SLiCE Overview on Anaconda.org](./references/anaconda_org_channels_bioconda_packages_bigslice_overview.md)