# Simulating Single-Cell Multi-Omics Data with MOSim

#### Carolina Monzó, Ángeles Arzalluz-Luque, Sonia Tarazona

#### 2025-10-30

# Introduction

Welcome to the `MOSim` package, a versatile tool for simulating bulk and single-cell multi-omics data. In this vignette, we will explore how to create synthetic single-cell data, focusing on single-cell RNA-seq (scRNA-seq) and single-cell ATAC-seq (scATAC-seq) data. Using the `MOSim` package, you can generate custom multi-omics datasets for various experimental conditions, making it an essential resource for testing and validating analysis methods, or creating benchmark datasets.

# Installation

Before we dive into the exciting world of data simulation, you’ll need to install the `MOSim` package. You can easily obtain it from bioconductor using the following commands:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MOSim")

# For the latest development version
install.packages("devtools")
devtools::install_github("ConesaLab/MOSim")
```

# Simulating Single-Cell Multi-Omics Data

The core of data simulation lies in the sc\_mosim function, which allows you to create synthetic single-cell multi-omics data. Let’s explore a typical example of its usage, using the default dataset loaded in the package:

```
library(MOSim)

# Create a list of omics data types (e.g., scRNA-seq and scATAC-seq)
omicsList <- sc_omicData(list("scRNA-seq", "scATAC-seq"),
                         data = NULL)

# Define cell types for your experiment
cell_types <- list('Treg' = c(1:10),'cDC' = c(11:20),'CD4_TEM' = c(21:30),
      'Memory_B' = c(31:40))

# Load an association list containing peak IDs related to gene names
associationList <- data(associationList)

# Simulate multi-omics data with specific parameters
testing_groups <- sc_mosim(
  omicsList,
  cell_types,
  numberReps = 2,
  numberGroups = 3,
  diffGenes = list(c(0.2, 0.3), c(0.2, 0.3)),
  minFC = 0.25,
  maxFC = 4,
  numberCells = NULL,
  mean = NULL,
  sd = NULL,
  regulatorEffect = list(c(0.1, 0.2), c(0.1, 0.2), c(0.1, 0.2)),
  associationList = associationList,
  TF = FALSE
)
```

In the example above, we load omics data types, specify experimental conditions and cell types, and load an association list. The sc\_mosim function lets us simulate multi-omics data with various parameters, such as the number of replicates, differentially expressed genes, and regulatory effects.

# Data Preparation

Before diving into simulation, it’s essential to have your data ready. The `sc_omicData` function aids in preparing your data for simulation. It accepts the following inputs:

* omics\_types: A list of omics data types, which can be “scRNA-seq” or “scATAC-seq.”
* data (optional): A user-inputted list of matrices with features as rows and cells as columns. If data is NULL, the default data from 10 cells for 4 celltypes is loaded.

## Providing Custom Data

`sc_mosim` also allows you to simulate data resembling characteristics of a dataset of your choice. To do so, you need to format your data using the `sc_omicData` function. Supported input formats include:

* Count matrix
* Seurat array
  For example, to format your data extracted from the original Seurat object,
  you can follow these steps:

```
# This is done to get a dataset to extract a matrix (for example purposes)
scRNA <- MOSim::sc_omicData("scRNA-seq", data = NULL)
count <- scRNA[["scRNA-seq"]]
options(Seurat.object.assay.version = "v3")
Seurat_obj <- Seurat::CreateAssayObject(counts = count, assay = 'RNA')
# To format the data into sc_mosim-ready format, we pass the seurat
# object containing the count data we extracted into sc_omicData
omic_list_user <- sc_omicData(c("scRNA-seq"), data = c(Seurat_obj))
```

The resulting omic\_list\_user is a named list with “scRNA-seq” as the name and your count matrix as the value.

# Running the Simulation: sc\_mosim

## Default sc\_mosim Simulation

`sc_mosim` can simulate scRNA, scATAC and TF count matrices without providing any additional arguments. For a basic simulation, you only need to input the omics list and cell types. Here’s how it’s done:

```
omic_list <- sc_omicData(list("scRNA-seq"))
cell_types <- list('Treg' = c(1:10),'cDC' = c(11:20),'CD4_TEM' = c(21:30),
      'Memory_B' = c(31:40))

sim <- sc_mosim(omic_list, cell_types, TF = TRUE)
```

This will result in simulated raw count matrices for scRNA and TF.

## Customizing the sc\_mosim Simulation

The `sc_mosim` function offers a range of parameters to fine-tune your simulation:

* omics: A named list specifying the omics data types.
* cellTypes: A list specifying the cell types.
* numberReps (optional): The number of biological replicates.
* numberGroups (optional): The number of different biological groups (experimental conditions).
* diffGenes (optional): To simulate differentially expressed genes between groups.
* minFC (optional): Threshold for downregulated genes.
* maxFC (optional): Threshold for upregulated genes.
* numberCells (optional): A vector specifying the number of cells per cell type.
* mean and sd (optional): Vectors for mean and standard deviation of expression per cell type.
* noiseRep (optional): Standard deviation between biological replicates.
* noiseGroup (optional): Standard deviation between groups.
* feature\_no (optional): Total number of features to distribute between co-expression clusters.
* clusters (optional): Number of co-expression patterns to simulate.
* cluster\_size (optional): Number of features in each co-simulation cluster.
* TF (optional): wether to extract TF dataframe as sim\_TF in simulation object.
* TFdf (optional): If an association matrix of TF and Target\_gene is given the TF expression values are extracted. If no data.frame is given, using the association of human TF from {<https://tflink.net/>} For example, to simulate data with specific settings, you can use the following
  code:

```
omic_list <- sc_omicData(c("scRNA-seq", "scATAC-seq"))
cell_types <- list('Treg' = c(1:10),'cDC' = c(11:20),'CD4_TEM' = c(21:30),
      'Memory_B' = c(31:40))
sim <- sc_mosim(omic_list, cell_types, numberReps = 2,
               numberGroups = 2, diffGenes = list(c(0.2, 0.3)), feature_no = 8000,
               clusters = 3, mean = c(2*10^6, 1*10^6,2*10^6, 1*10^6),
               sd = c(5*10^5, 2*10^5, 5*10^5, 2*10^5),
               regulatorEffect = list(c(0.1, 0.2), c(0.1, 0.2)), TF = FALSE)
```

# Working with Simulation Results

## The sc\_mosim Simulation Object

The result of your simulation is stored in a named list with ‘sim\_sc + omic name’ as names and Seurat objects as values. Each Seurat object contains the synthetic count matrices for your experiment. Other relevant information included in the object are:

* cellTypes: A list specifying the columns in each simulated matrix that correspond to each cell type.
* patterns: Matrix of co-expression patterns affecting the genes throughout cell-types.
* FC: list of Fold Changes applied to each gene to simulate differential expression between experimental groups.
* AssociationMatrices: gene/peak association matrices including differential expression and regulatory relationships.
* Variability: added variability matrices to add dispersion to experimental groups and biological replicates.

## Retrieving Simulation Settings

To access simulation settings and other constraints for simulation, you can use the `sc_omicSettings` function. This provides information about the relationship between genes and peaks, differentially expressed genes, regulator types, expression patterns, and fold changes for each gene and peak compared to group 1.

```
settings <- sc_omicSettings(sim)
```

If you run the sc\_mosim simulation including TF, you can also extract the
association matrix of TF - target genes regulatory relationships.

```
settings <- sc_omicSettings(sim, TF = TRUE)
```

## Accessing the Count Data Matrices

You can extract the simulated matrices for all experimental conditions and biological replicates using the `sc_omicResults` function. This provides you with the synthetic data for further analysis and visualization.

```
res <- sc_omicResults(sim)
```

## How to cite `MOSim`

The `MOSim` package is published in Briefings in Bioinformatics:

Monzó C., Aguerralde-Martin M., Martínez-Mira C., Arzalluz-Luque A., Conesa A., Tarazona S. (2025) MOSim: bulk and single-cell multi-layer regulatory network simulator. Briefings in Bioinformatics, Volume 26, Issue 2. DOI: 10.1093/bib/bbaf110

(<https://academic.oup.com/bib/article/26/2/bbaf110/8089935?utm_source=advanceaccess&utm_campaign=bib&utm_medium=email>)