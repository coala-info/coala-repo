---
name: r-soupx
description: This tool removes ambient RNA contamination from droplet-based single-cell RNA sequencing data to improve expression accuracy. Use when user asks to estimate contamination fractions, remove background RNA from single-cell datasets, or generate decontaminated count matrices.
homepage: https://cran.r-project.org/web/packages/SoupX/index.html
metadata:
  docker_image: "quay.io/biocontainers/bioconductor-bsgenome.cneoformansvargrubiikn99.ncbi.asm221672v1:1.0.0--r45hdfd78af_4"
---


# r-soupx

## Overview

The `SoupX` R package addresses the ubiquitous problem of ambient RNA contamination in droplet-based single-cell experiments. This "soup" consists of cell-free mRNA from lysed cells that gets encapsulated into droplets, leading to false-positive expression (e.g., hemoglobin in T-cells). This skill provides the procedural workflow to estimate the contamination fraction (`rho`) and generate a decontaminated count matrix while preserving true endogenous signals.

## Core Workflow

The standard deconvolution pipeline follows three main steps: profiling the soup, estimating contamination, and adjusting counts.

### 1. Initialization and Loading
For 10X Genomics data processed via CellRanger, use the convenience loader. For other platforms, construct the `SoupChannel` manually.

```R
library(SoupX)

# For CellRanger: points to folder containing 'raw_gene_bc_matrices' and 'filtered_gene_bc_matrices'
sc = load10X('path/to/cellranger/outs/')

# Manual construction (requires raw/all droplets and filtered/cell-only droplets)
# sc = SoupChannel(tod, toc) 
```

### 2. Estimating Contamination (rho)
The contamination fraction `rho` represents the percentage of UMIs derived from the soup.

*   **Automated Estimation (Recommended):** Requires clustering information. If not using CellRanger defaults, provide clusters manually.
    ```R
    # Set clusters if not automatically loaded
    # sc = setClusters(sc, setNames(my_clusters, cell_ids))
    
    sc = autoEstCont(sc)
    ```
*   **Manual Estimation:** Use known non-expressed marker genes (e.g., Hemoglobin genes `HBB`, `HBA2` for non-erythrocytes).
    ```R
    genes = list(HB = c("HBB", "HBA2"))
    useToEst = estimateNonExpressingCells(sc, nonExpressedGeneList = genes)
    sc = calculateContaminationFraction(sc, genes, useToEst = useToEst)
    ```

### 3. Adjusting Counts
Generate the "strained" matrix. By default, this returns non-integer values which are often more accurate for downstream statistical models.

```R
# Generate corrected matrix
out = adjustCounts(sc, roundToInt = TRUE)

# Integrate with Seurat
# library(Seurat)
# srat = CreateSeuratObject(counts = out)
```

## Expert Tips and Best Practices

*   **Clustering is Essential:** While `SoupX` can run without clusters, the results are significantly more accurate when cells are grouped. Clusters allow the algorithm to aggregate signal and distinguish between low-level endogenous expression and background soup.
*   **Visual Sanity Checks:** Use `plotMarkerMap(sc, "GENE_NAME")` to visualize the ratio of observed counts to expected soup counts. If a gene's expression in a cluster is blue/cold, it is likely entirely soup-derived.
*   **Plausible Rho Values:** In fresh tissue 10X experiments, `rho` is typically between 0.02 (2%) and 0.10 (10%). Values above 0.20 indicate very high contamination, often seen in solid tumors or low-viability samples.
*   **Handling Homogeneous Data:** If your sample is a single cell line, `autoEstCont` may fail due to a lack of distinct marker genes. In these cases, manually set a fixed contamination fraction based on similar experiments using `setContaminationFraction(sc, 0.05)`.
*   **Soup Profile:** The soup profile is calculated from "empty" droplets (low UMI counts). If you only have the filtered count matrix, you can estimate the soup by the aggregate expression of all cells, though this is a fallback and less ideal than using the raw/all-droplets matrix.

## Reference documentation
- [SoupX PBMC Demonstration](./references/cran_r-project_org_web_packages_SoupX_vignettes_pbmcTutorial.html.md)
- [SoupX Reference Manual](./references/cran_r-project_org_web_packages_SoupX_refman_SoupX.html.md)
- [SoupX GitHub README](./references/github_com_cran_SoupX_blob_master_README.md)