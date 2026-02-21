# Vignettte providing an overview of the data in MOFAdata

Britta Velten and Ricard Argelaguet

#### 2025-11-04

The MOFAdata package contains several data sets to be used
for illustration pruposes in the R package MOFA.
Please refer to the vignettes in the MOFA package,
where we explain in detail how MOFA can be trained on the data
and how the resulting model is to be analysed.

```
library(MOFAdata)
library(MultiAssayExperiment)
```

In MOFAdata we store the following data objects to be used with MOFA:

* Preprocessed data on 200 CLL patients with
  mRNA, methylation, drug response and mutation profiles (Dietrich et al. [2018](#ref-cllpaper)),
  used as input for MOFA in (Argelaguet et al. [2018](#ref-MOFApaper)).

```
# Load data
# import list with mRNA, Methylation, Drug Response and Mutation data.
data("CLL_data")
lapply(CLL_data, dim)
```

```
## $Drugs
## [1] 310 200
##
## $Methylation
## [1] 4248  200
##
## $mRNA
## [1] 5000  200
##
## $Mutations
## [1]  69 200
```

```
# Load sample metadata: Sex and Diagnosis
data("CLL_covariates")
head(CLL_covariates)
```

```
##      Gender Diagnosis
## H045      m       CLL
## H109      m       CLL
## H024      m       CLL
## H056      m       CLL
## H079      m       CLL
## H164      f       CLL
```

* scMT data: Preprocessed data on 87 single cells (Angermueller et al. [2016](#ref-angermueller2016parallel)),
  profiled using single-cell methylation and transcriptome sequencing,
  used as input to MOFA in (Argelaguet et al. [2018](#ref-MOFApaper)).

```
data("scMT_data")
scMT_data
```

```
## A MultiAssayExperiment object of 4 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 4:
##  [1] RNA expression: ExpressionSet with 5000 rows and 81 columns
##  [2] Met Enhancers: ExpressionSet with 5000 rows and 83 columns
##  [3] Met CpG Islands: ExpressionSet with 5000 rows and 83 columns
##  [4] Met Promoters: ExpressionSet with 5000 rows and 83 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

* other data include trained MOFA models for the above data sets
  as analysed in (Argelaguet et al. [2018](#ref-MOFApaper)) and REACTOME gene set information
  (Fabregat et al. [2015](#ref-fabregat2015reactome)) to be used in the MOFA package
  for gene set enrichment analysis of trained models.

# References

Angermueller, Christof, Stephen J Clark, Heather J Lee, Iain C Macaulay, Mabel J Teng, Tim Xiaoming Hu, Felix Krueger, et al. 2016. “Parallel Single-Cell Sequencing Links Transcriptional and Epigenetic Heterogeneity.” *Nature Methods* 13 (3): 229.

Argelaguet, Ricard, Britta Velten, Damien Arnol, Sascha Dietrich, Thorsten Zenz, John C. Marioni, Florian Buettner, Wolfgang Huber, and Oliver Stegle. 2018. “Multi-Omics Factor Analysis - a Framework for Unsupervised Integration of Multi-Omic Data Sets.” *Molecular Systems Biology*.

Dietrich, Sascha, Malgorzata Oleś, Junyan Lu, Leopold Sellner, Simon Anders, B Velten, Bian Wu, et al. 2018. “Drug-Perturbation-Based Stratification of Blood Cancer.” *The Journal of Clinical Investigation* 128 (1): 427–45.

Fabregat, Antonio, Konstantinos Sidiropoulos, Phani Garapati, Marc Gillespie, Kerstin Hausmann, Robin Haw, Bijay Jassal, et al. 2015. “The Reactome Pathway Knowledgebase.” *Nucleic Acids Research* 44 (D1): D481–D487.