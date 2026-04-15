---
name: bioconductor-meskit
description: MesKit analyzes and visualizes multi-region whole-exome sequencing data to characterize intra-tumor heterogeneity and infer tumor evolutionary history. Use when user asks to calculate ITH metrics, infer metastatic routes, construct phylogenetic trees, or classify mutations across multiple tumor regions.
homepage: https://bioconductor.org/packages/release/bioc/html/MesKit.html
---

# bioconductor-meskit

name: bioconductor-meskit
description: Analyze and visualize multi-region whole-exome sequencing (WES) data to characterize intra-tumor heterogeneity (ITH) and infer tumor evolutionary history. Use this skill when processing multi-region MAF files to calculate ITH metrics (MATH, AUC, Fst), infer metastatic routes (JSI, CCF comparison), and construct/visualize phylogenetic trees.

## Overview
MesKit is a Bioconductor package designed for the analysis of multi-region sequencing data. It facilitates the characterization of cancer genomic intra-tumor heterogeneity (ITH) and the reconstruction of evolutionary lineages. Key capabilities include calculating ITH scores, identifying subclonal clusters, estimating genetic distances between regions, and performing mutational signature analysis across phylogenetic branches.

## Data Preparation
MesKit requires specific input formats to link mutations across multiple regions of the same patient.

*   **MAF File**: Standard Mutation Annotation Format. Mandatory fields: `Hugo_Symbol`, `Chromosome`, `Start_Position`, `End_Position`, `Variant_Classification`, `Variant_Type`, `Reference_Allele`, `Tumor_Seq_Allele2`, `Ref_allele_depth`, `Alt_allele_depth`, `VAF`, and `Tumor_Sample_Barcode`.
*   **Clinical File**: Maps samples to patients. Mandatory fields: `Tumor_Sample_Barcode`, `Tumor_ID`, `Patient_ID`, and `Tumor_Sample_Label`.
*   **CCF Data (Optional)**: Cancer Cell Fraction data is highly recommended for clonal/subclonal classification.

## Core Workflow

### 1. Loading Data
Use `readMaf` to create a MesKit object.
```r
library(MesKit)
maf <- readMaf(
  mafFile = "path/to/data.maf",
  clinicalFile = "path/to/clinical.txt",
  ccfFile = "path/to/ccf.tsv", ## Optional
  refBuild = "hg19" ## "hg18", "hg19", or "hg38"
)
```

### 2. Characterizing Mutational Landscape
Categorize mutations based on shared patterns (Shared, Public, Private) or clonal status.
```r
## Classify mutations
mut_class <- classifyMut(maf, class = "SP", patient.id = 'V402')

## Plot mutational profile (e.g., for driver genes)
plotMutProfile(maf, class = "SP", geneList = driverGenes)
```

### 3. Measuring ITH
MesKit provides several metrics to quantify heterogeneity within and between regions.
*   **MATH Score**: `mathScore(maf, patient.id = 'ID')`
*   **CCF AUC**: `ccfAUC(maf, patient.id = 'ID')`
*   **Genetic Distance (Fst/Nei)**: `calFst(maf, patient.id = 'ID')` or `calNeiDist(maf, patient.id = 'ID')`

### 4. Evolutionary Inference
Infer metastatic routes and seeding patterns.
*   **Jaccard Similarity Index (JSI)**: `calJSI(maf, pairByTumor = TRUE)`
*   **CCF Comparison**: `compareCCF(maf, pairByTumor = TRUE)`
*   **Neutral Evolution Test**: `testNeutral(maf, patient.id = 'ID')`

### 5. Phylogenetic Analysis
Construct trees based on the presence/absence of mutations.
```r
## Construct tree (Methods: "NJ", "MP", "ML", "FASTME.ols", "FASTME.bal")
phyloTree <- getPhyloTree(maf, patient.id = "V402", method = "NJ")

## Visualize tree with annotations
plotPhyloTree(phyloTree)

## Analyze trunk vs branch mutations
mutTrunkBranch(phyloTree, CT = TRUE, plot = TRUE)
```

## Mutational Signatures
Analyze the 96 trinucleotide context across different branches of the evolutionary tree.
```r
## Generate mutation count matrix
tri_mtx <- triMatrix(phyloTree)

## Fit known signatures (e.g., "cosmic_v2")
fit_res <- fitSignatures(tri_mtx, signaturesRef = "cosmic_v2")

## Plot signature profile
plotMutSigProfile(fit_res)
```

## Tips for Success
*   **Barcode Consistency**: Ensure `Tumor_Sample_Barcode` is identical across MAF, Clinical, and CCF files.
*   **Reference Genome**: Match the `refBuild` in `readMaf` to the genome version used for variant calling and CNA segmentation.
*   **Indels**: If your CCF file includes Indels, set `use.indel.ccf = TRUE` in `readMaf`.
*   **Visualization**: Combine `plotPhyloTree` with `mutHeatmap` for a comprehensive view of how mutations are distributed across the phylogeny.

## Reference documentation
- [MesKit: Analyze and Visualize Multi-region Whole-exome Sequencing Data](./references/MesKit.md)