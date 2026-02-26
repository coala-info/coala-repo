---
name: r-singlecellnet
description: This tool classifies single-cell RNA-Seq data across different platforms and species using the singleCellNet R package. Use when user asks to train classifiers on reference scRNA-Seq datasets, assess classifier performance, predict cell identities, or perform cross-species cell type mapping.
homepage: https://cran.r-project.org/web/packages/singlecellnet/index.html
---


# r-singlecellnet

name: r-singlecellnet
description: Classify single-cell RNA-Seq data across species and platforms using the singleCellNet R package. Use this skill when you need to train classifiers on reference scRNA-Seq datasets, assess classifier performance, or predict cell identities in query datasets (including cross-species mapping).

## Overview
singleCellNet (SCN) is an R package designed for the classification of single-cell RNA-Seq data. It uses a Top-Pair approach to identify gene pairs that are uniquely predictive of cell types, making it robust across different sequencing platforms and even across species (e.g., using mouse data to classify human cells).

## Installation
```R
if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")
devtools::install_github("pcahan1/singleCellNet")
library(singleCellNet)
```

## Core Workflow

### 1. Data Preparation
Ensure your expression data is a matrix (genes as rows, cells as columns) and your sample table (metadata) has a column for cell types.
```R
# Split data into training and testing sets
stList = splitCommon(sampTab = stTM, ncells = 100, dLevel = "cell_type_column")
stTrain = stList[[1]]
expTrain = expRaw[, rownames(stTrain)]
```

### 2. Training the Classifier
The `scn_train` function builds the Random Forest classifier based on top gene pairs.
```R
class_info <- scn_train(
  stTrain = stTrain, 
  expTrain = expTrain, 
  nTopGenes = 10, 
  nRand = 70, 
  nTrees = 1000, 
  nTopGenePairs = 25, 
  dLevel = "cell_type_column", 
  colName_samp = "cell_id_column"
)
```

### 3. Prediction and Assessment
Apply the trained model to held-out test data or new query data.
```R
# Predict on test data
classRes = scn_predict(cnProc = class_info[['cnProc']], expDat = expTest, nrand = 50)

# Assess performance
assessment = assess_comm(
  ct_scores = classRes, 
  stTrain = stTrain, 
  stQuery = stTest, 
  dLevelSID = "cell_id_column", 
  classTrain = "cell_type_column", 
  classQuery = "cell_type_column", 
  nRand = 50
)
plot_PRs(assessment)
```

### 4. Cross-Species Classification
To classify across species, use an ortholog table to rename genes before training/predicting.
```R
# Convert query (e.g., Human) to match training (e.g., Mouse)
oTab = utils_loadObject("human_mouse_genes.rda")
aa = csRenameOrth(expQuery, expTrain, oTab)
expQueryOrth = aa[['expQuery']]
```

## Visualization
* **Heatmap**: `sc_hmClass(classMat = classRes, grps = labels, isBig = TRUE)`
* **Violin Plot**: `sc_violinClass(sampTab = stQuery, classRes = classRes, sid = "cell_id", dLevel = "label")`
* **Attribution Plot**: `plot_attr(classRes = classRes, sampTab = stQuery, nrand = 50, dLevel = "label", sid = "cell_id")`

## Integration with Other Objects
* **Seurat**: Use `extractSeurat(seurat_obj, exp_slot_name = "counts")` to get the expression matrix and metadata.
* **SingleCellExperiment (SCE)**: Use `extractSCE(sce_obj, exp_slot_name = "counts")`.
* **Loom**: Use `loadLoomExpCluster("file.loom")`.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)