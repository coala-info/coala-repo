---
name: bioconductor-citefuse
description: CiteFuse provides a comprehensive framework for integrating and analyzing multimodal CITE-seq data using Similarity Network Fusion. Use when user asks to integrate RNA and surface protein measurements, perform cell hashing for doublet detection, cluster cells using a fused similarity matrix, or identify important ADT markers.
homepage: https://bioconductor.org/packages/release/bioc/html/CiteFuse.html
---

# bioconductor-citefuse

## Overview

CiteFuse is a comprehensive framework for analyzing CITE-seq data (simultaneous RNA and surface protein/ADT measurement). It excels at integrating these two modalities using Similarity Network Fusion (SNF) to create a unified representation of cell states. The package also provides specialized tools for cell hashing (HTO) analysis to identify doublets and methods to assess which proteins (ADTs) contribute most to cluster identity.

## Core Workflow

### 1. Data Preprocessing and HTO Analysis
CiteFuse uses the `SingleCellExperiment` (SCE) class. RNA is stored in the main assay, while ADT and HTO data are stored in `altExp` slots.

```r
library(CiteFuse)
# Create SCE from a list of matrices (RNA, ADT, HTO)
sce <- preprocessing(CITEseq_example)

# Normalization (HTO for doublet detection)
sce <- normaliseExprs(sce, altExp_name = "HTO", transform = "log")

# Step-wise Doublet Detection
sce <- crossSampleDoublets(sce) # Between-sample
sce <- withinSampleDoublets(sce, minPts = 10) # Within-sample

# Filter for singlets
sce <- sce[, sce$doubletClassify_within_class == "Singlet" & 
             sce$doubletClassify_between_class == "Singlet"]
```

### 2. Modality Integration (SNF)
Integrate RNA and ADT data to create a fused similarity matrix.

```r
# Normalize RNA and ADT before fusion
sce <- scater::logNormCounts(sce)
sce <- normaliseExprs(sce, altExp_name = "ADT", transform = "log")

# Run Similarity Network Fusion
sce <- CiteFuse(sce)
# Fused matrix is stored in metadata(sce)[["SNF_W"]]
```

### 3. Clustering and Visualization
Perform clustering on the fused network and visualize results.

```r
# Spectral Clustering: Determine K using eigenvalues
SNF_W_clust <- spectralClustering(metadata(sce)[["SNF_W"]], K = 20)
plot(SNF_W_clust$eigen_values) # Look for "elbow"

# Final clustering
SNF_W_clust <- spectralClustering(metadata(sce)[["SNF_W"]], K = 5)
sce$SNF_W_clust <- as.factor(SNF_W_clust$labels)

# Louvain Clustering alternative
sce$SNF_W_louvain <- as.factor(igraphClustering(sce, method = "louvain"))

# Visualization
sce <- reducedDimSNF(sce, method = "tSNE", dimNames = "tSNE_joint")
visualiseDim(sce, dimNames = "tSNE_joint", colour_by = "SNF_W_clust")
```

### 4. Differential Expression (DE)
Identify markers for both RNA and ADT modalities.

```r
# RNA DE
sce <- DEgenes(sce, altExp_name = "none", group = sce$SNF_W_louvain)
sce <- selectDEgenes(sce, altExp_name = "none")

# ADT DE
sce <- DEgenes(sce, altExp_name = "ADT", group = sce$SNF_W_louvain)
sce <- selectDEgenes(sce, altExp_name = "ADT")

# Visualization
DEbubblePlot(list(RNA = metadata(sce)[["DE_res_RNA_filter"]], 
                  ADT = metadata(sce)[["DE_res_ADT_filter"]]))
```

### 5. ADT Importance and Networks
Evaluate which proteins drive the clustering and explore gene-protein correlations.

```r
# ADT Importance (Random Forest)
sce <- importanceADT(sce, group = sce$SNF_W_louvain, subsample = TRUE)
visImportance(sce, plot = "boxplot")

# Gene-ADT Network
geneADTnetwork(sce, 
               RNA_feature_subset = rna_features, 
               ADT_feature_subset = adt_features, 
               cor_method = "pearson")
```

### 6. Ligand-Receptor Analysis
Predict interactions using RNA for ligands and ADT for receptors.

```r
# Requires specific normalization
sce <- normaliseExprs(sce, altExp_name = "ADT", transform = "zi_minMax")
sce <- normaliseExprs(sce, altExp_name = "none", transform = "minMax")

sce <- ligandReceptorTest(sce, 
                          ligandReceptor_list = lr_pair_subset, 
                          cluster = sce$SNF_W_louvain, 
                          use_alt_exp = TRUE, 
                          altExp_name = "ADT")

visLigandReceptor(sce, type = "pval_dotplot", receptor_type = "ADT")
```

## Reference documentation
- [CiteFuse: getting started](./references/CiteFuse.Rmd)
- [CiteFuse: getting started (Markdown)](./references/CiteFuse.md)