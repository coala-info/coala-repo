# ADAM: Activity and Diversity Analysis Module

André L. Molan, Giordano B. S. Seco, Agnes A. S. Takeda, Jose L. Rybarczyk-Filho

#### 29 October 2025

#### Package

ADAM 1.26.0

# Contents

* [1 Overview](#overview)
* [2 GFAGAnalysis](#gfaganalysis)
* [3 ADAnalysis](#adanalysis)
* [4 Session information](#session-information)
* [References](#references)

# 1 Overview

*ADAM* is a GSEA R package created to group a set of genes from
comparative samples (control *versus* experiment) according to their
respective functions (Gene Ontology and KEGG pathways as default) and show
their significance by calculating p-values referring to gene diversity and
activity (Castro et al. ([2009](#ref-Castro2009))). Each group of genes is called GFAG
(Group of Functionally Associated Genes). The package has support for many
species in regards to the genes and their respective functions.

In the package’s analysis, all genes present in the expression data are
grouped by their respective functions according to the domains described by
AnalysisDomain argument. The relationship between genes and functions are made
based on the species annotation package. If there is no annotation package,
a three column file (gene, function and function description) must be
provided. For each GFAG, gene diversity and activity in each sample are
calculated. As the package always compare two samples (control *versus*
experiment), relative gene diversity and activity for each GFAG are
calculated. Using bootstrap method, for each GFAG, according to relative gene
diversity and activity, two p-values are calculated. The p-values are then
corrected, by using the
correction method defined by *PCorrectionMethod* argument, generating a q-value
(Molan ([2018](#ref-molan2018))). The significative GFAGs will be those whose q-value stay under
the cutoff set by *PCorrection* argument. Optionally, it’s possible to run
Wilcoxon ranck sum test and/or Fisher’s exact test (Fontoura and Mombach ([2016](#ref-fontoura2016))). These tests
also provide a corrected p-value, and siginificative groups can be seen through
them.

# 2 GFAGAnalysis

*GFAGAnalysis* function provides a complete analysis, using all available
arguments. As an example, lets consider a gene expression set of
*Aedes aegypti*:

```
suppressMessages(library(ADAM))
```

```
data("ExpressionAedes")
head(ExpressionAedes)
```

```
##         gene  control1 experiment1  control2 experiment2
## 1 AAEL000372 0.9750520   11.744300 15.432300     0.00000
## 2 AAEL000433 1.5934700   11.876400  0.133743     1.23991
## 3 AAEL000596 0.5680230    3.365710  7.411010    13.06860
## 4 AAEL000599 0.0370953    0.361577  0.154117     0.34019
## 5 AAEL000656 0.0648374    0.278074  1.340890     1.15750
## 6 AAEL000759 2.3512100   48.762500  6.276890    25.02600
```

The first column refers to the gene names, while the others are the expression
obtained by a specific experiment (in this case, RNA-seq). ADAM
always need two samples (control *versus* experiment). This way, we must
select two sample columns from the expression data for each comparison:

```
Comparison <- c("control1,experiment1","control2,experiment2")
```

Each GFAG has a number of genes associated to it. This way, the analysis can
consider all GFAGs or just those with a certain number of genes:

```
Minimum <- 3
Maximum <- 20
```

The p-values for each GFAG is calculated through the bootstrap method, which
demands a seed for generating random numbers and a number of bootstraps steps
(the number of bootstraps should be a value that ensures the p-value
precision):

```
SeedBootstrap <- 1049
StepsBootstrap <- 1000
```

The p-values will be corrected by a specific method with a certain cutoff
value:

```
CutoffValue <- 0.05
MethodCorrection <- "fdr"
```

In order to group the genes according to their biological functions, it’s
necessary an annotation package or a file relating genes and functions. In this
case, *Aedes aegypti* doesn’t have an annotation package. This way, we build our
own file:

```
data("KeggPathwaysAedes")
head(KeggPathwaysAedes)
```

```
##         gene pathwayID                 pathwayDescription
## 1 AAEL012172  aag00270 Cysteine and methionine metabolism
## 2 AAEL026440  aag00270 Cysteine and methionine metabolism
## 3 AAEL026231  aag00270 Cysteine and methionine metabolism
## 4 AAEL001176  aag00270 Cysteine and methionine metabolism
## 5 AAEL002399  aag00270 Cysteine and methionine metabolism
## 6 AAEL026357  aag00270 Cysteine and methionine metabolism
```

It’s necessary to inform which function domain and gene nomenclature are being
used. As *Aedes agypti* doesn’t have an annotation package, the domain will be
“own” and the nomenclature “gene”:

```
Domain <- "own"
Nomenclature <- "geneStableID"
```

Wilcoxon rank sum test and Fisher’s exact test will be run:

```
Wilcoxon <- TRUE
Fisher <- TRUE
```

As all arguments were defined, then we can run GFAGAnalysis function:

```
ResultAnalysis <- suppressMessages(GFAGAnalysis(ComparisonID = Comparison,
                            ExpressionData = ExpressionAedes,
                            MinGene = Minimum,
                            MaxGene = Maximum,
                            SeedNumber = SeedBootstrap,
                            BootstrapNumber = StepsBootstrap,
                            PCorrection = CutoffValue,
                            DBSpecies = KeggPathwaysAedes,
                            PCorrectionMethod = MethodCorrection,
                            WilcoxonTest = Wilcoxon,
                            FisherTest = Fisher,
                            AnalysisDomain = Domain,
                            GeneIdentifier = Nomenclature))
```

In the example above, we used the function *supressMessages* just to stop
showing messages during the *GFAGAnalysis* function execution. The output of
*GFAGAnalysis* will be a *list* with two elements. The first corresponds to a
*data frame* showing genes and their respective functions:

```
head(ResultAnalysis[[1]])
```

```
##         gene  GroupID
## 1 AAEL000759 aag00270
## 2 AAEL001176 aag00270
## 3 AAEL001378 aag00270
## 4 AAEL002399 aag00270
## 5 AAEL004059 aag00270
## 6 AAEL004728 aag00270
```

The second element of the output list result corresponds to data frames
according to the argument ComparisonID:

```
DT::datatable(as.data.frame(ResultAnalysis[[2]][1]), width = 800,
            options = list(scrollX = TRUE))
```

```
DT::datatable(as.data.frame(ResultAnalysis[[2]][2]), width = 800,
            options = list(scrollX = TRUE))
```

The data frames corresponding to the second element of the list have the
following columns:

* **ID** - A code identifying the GFAG (GO
  term, KEGG pathway or one according to users annotations).
* **Description** - Description of the
  GFAG.
* **Raw\_Number\_Genes** - Total number of
  genes related to the GFAG.
* **Sample\_Number\_Genes** - Number of genes,
  present in the sample, related to the GFAG.
* **H\_** - Two columns. GFAG gene diversity
  of each sample (control *versus* experiment).
* **N\_** - Two columns. GFAG gene activity
  of each sample (control *versus* experiment).
* **h** - Relative gene diversity.
* **n** - Relative gene activity.
* **pValue\_h** - GFAG p-value related to
  gene diversity.
* **pValue\_n** - GFAG p-value related to
  gene activity.
* **qValue\_h** - GFAG corrected p-value
  related to gene diversity.
* **qValue\_n** - GFAG corrected p-value
  related to gene activity.
* **Significance\_h** - GFAG significance
  related to gene diversity. “significative” means the q-value is lower than
  the cutoff set by PCorrection argument, while “not-significative” means the
  opposite.
* **Significance\_n** - GFAG significance
  related to gene activity. “significative” means the q-value is lower than
  the cutoff set by PCorrection argument, while “not-significative” means the
  opposite.
* **Wilcox\_pvalue** - GFAG p-value generated
  by Wilcoxon rank test.
* **Wilcox\_qvalue** - Wilcoxon GFAG
  corrected p-value.
* **Wilcox\_significance** - GFAG
  significance related Wilcoxon test. “significative” means the q-value is lower
  than the cutoff set by PCorrection argument, while “not-significative” means
  the opposite.
* **Fisher\_pvalue** - GFAG p-value generated
  by Fisher’s exact test.
* **Fisher\_qvalue** - Fisher GFAG corrected
  p-value.
* **Fisher\_significance** - GFAG
  significance related to Fisher’s exact test. “significative” means the q-value
  is lower than the cutoff set by PCorrection argument, while
  “not-significative” means the opposite.

# 3 ADAnalysis

*ADAnalysis* function provides a partial analysis, where is calculated just
gene diversity and activity of each GFAG with no signicance by bootstrap,
Wilcoxon or Fisher. As an example, lets consider the same gene expression set
of *Aedes aegypti* previously used in *GFAGAnalysis* funcion example:

```
suppressMessages(library(ADAM))
data("ExpressionAedes")
data("KeggPathwaysAedes")
```

As ADAM always need two samples (control *versus* experiment), let’s select
two sample columns from the expression data and define minimum and maximum
number of genes per GFAG:

```
Comparison <- c("control1,experiment1")
Minimum <- 3
Maximum <- 100
```

*Aedes aegypti* doesn’t have an annotation package. This way, we build our own
file:

```
SpeciesID <- "KeggPathwaysAedes"
```

It’s necessary to inform which function domain and gene nomenclature are being
used. *Aedes agypti* doesn’t have an annotation package. So the domain will be
“own” and the nomenclature “geneStableID”:

```
Domain <- "own"
Nomenclature <- "geneStableID"
```

As all arguments were defined, then we can run ADAnalysis function:

```
ResultAnalysis <- suppressMessages(ADAnalysis(ComparisonID = Comparison,
                            ExpressionData = ExpressionAedes,
                            MinGene = Minimum,
                            MaxGene = Maximum,
                            DBSpecies = KeggPathwaysAedes,
                            AnalysisDomain = Domain,
                            GeneIdentifier = Nomenclature))
```

In the example above, we used the function *supressMessages* just to stop
showing messages during the *ADAnalysis* function execution. The output of
*ADAnalysis* will be a *list* with two elements. The first corresponds to a
*data frame* showing genes and their respective functions:

```
head(ResultAnalysis[[1]])
```

```
##         gene  GroupID
## 1 AAEL000759 aag00270
## 2 AAEL001176 aag00270
## 3 AAEL001378 aag00270
## 4 AAEL002399 aag00270
## 5 AAEL004059 aag00270
## 6 AAEL004728 aag00270
```

The second element of the output list result corresponds to data frames
according to the argument ComparisonID:

```
DT::datatable(as.data.frame(ResultAnalysis[[2]][1]), width = 800,
            options = list(scrollX = TRUE))
```

The data frames corresponding to the second element of the list have the
following columns:

* **ID** - A code identifying the GFAG (GO
  term, KEGG pathway or one according to users annotations).
* **Description** - Description of the
  GFAG.
* **Raw\_Number\_Genes** - Total number of genes
  related to the GFAG.
* **Sample\_Number\_Genes** - Number of genes,
  present in the sample, related to the GFAG.
* **H\_** - Two columns. GFAG gene diversity
  of each sample (control *versus* experiment).
* **N\_** - Two columns. GFAG gene activity
  of each sample (control *versus* experiment).
* **h** - Relative gene diversity.
* **n** - Relative gene activity.

# 4 Session information

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] ADAM_1.26.0      BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0             SummarizedExperiment_1.40.0
##  [3] xfun_0.53                   bslib_0.9.0
##  [5] htmlwidgets_1.6.4           Biobase_2.70.0
##  [7] lattice_0.22-7              crosstalk_1.2.2
##  [9] vctrs_0.6.5                 tools_4.5.1
## [11] generics_0.1.4              stats4_4.5.1
## [13] parallel_4.5.1              tibble_3.3.0
## [15] AnnotationDbi_1.72.0        RSQLite_2.4.3
## [17] blob_1.2.4                  pkgconfig_2.0.3
## [19] Matrix_1.7-4                S4Vectors_0.48.0
## [21] lifecycle_1.0.4             stringr_1.5.2
## [23] compiler_4.5.1              Biostrings_2.78.0
## [25] Seqinfo_1.0.0               htmltools_0.5.8.1
## [27] sass_0.4.10                 yaml_2.3.10
## [29] pillar_1.11.1               crayon_1.5.3
## [31] jquerylib_0.1.4             GO.db_3.22.0
## [33] DT_0.34.0                   cachem_1.1.0
## [35] DelayedArray_0.36.0         abind_1.4-8
## [37] tidyselect_1.2.1            digest_0.6.37
## [39] stringi_1.8.7               dplyr_1.1.4
## [41] bookdown_0.45               fastmap_1.2.0
## [43] grid_4.5.1                  cli_3.6.5
## [45] SparseArray_1.10.0          magrittr_2.0.4
## [47] S4Arrays_1.10.0             bit64_4.6.0-1
## [49] rmarkdown_2.30              XVector_0.50.0
## [51] httr_1.4.7                  matrixStats_1.5.0
## [53] bit_4.6.0                   png_0.1-8
## [55] memoise_2.0.1               pbapply_1.7-4
## [57] evaluate_1.0.5              knitr_1.50
## [59] GenomicRanges_1.62.0        IRanges_2.44.0
## [61] rlang_1.1.6                 Rcpp_1.1.0
## [63] glue_1.8.0                  DBI_1.2.3
## [65] BiocManager_1.30.26         BiocGenerics_0.56.0
## [67] jsonlite_2.0.0              R6_2.6.1
## [69] MatrixGenerics_1.22.0
```

# References

Castro, Mauro AA, José L Rybarczyk Filho, Rodrigo JS Dalmolin, Marialva Sinigaglia, José CF Moreira, José CM Mombach, and Rita MC de Almeida. 2009. “ViaComplex: Software for Landscape Analysis of Gene Expression Networks in Genomic Context.” *Bioinformatics* 25 (11): 1468–9.

Fontoura, C. A. R. S., and J. C. M Mombach. 2016. “PATHChange: A Tool for Identification of Differentially Expressed Pathways Using Multi-Statistic Comparison.” <https://cran.r-project.org/web/packages/PATHChange/PATHChange.pdf>.

Molan, A. L. 2018. “Construction of a Tool for Multispecies Genic Functional Enrichment Analysis Among Comparative Samples.” Master’s thesis, Institute of Biosciences of Botucatu – Univ. Estadual Paulista. <http://hdl.handle.net/11449/157105>.