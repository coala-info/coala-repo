# qPLEXanalyzer

#### Matthew Eldridge, Kamal Kishore and Ashley Sawle

#### 01/19/2026

* [Overview](#overview)
* [Import quantitative dataset](#import-quantitative-dataset)
* [Quality control](#quality-control)
  + [Peptide intensity plots](#peptide-intensity-plots)
  + [Relative log intensity boxplot](#relative-log-intensity-boxplot)
  + [Sample correlation plot](#sample-correlation-plot)
  + [Hierachical clustering dendrogram](#hierachical-clustering-dendrogram)
  + [Principle component analysis scatterplot](#principle-component-analysis-scatterplot)
  + [Bait protein coverage plot](#bait-protein-coverage-plot)
* [Data normalization](#data-normalization)
* [Aggregation of peptide intensities into protein intensities](#aggregation-of-peptide-intensities-into-protein-intensities)
* [Merging of similar peptides/sites into unified intensities](#merging-of-similar-peptidessites-into-unified-intensities)
* [Regression Analysis](#regression-analysis)
* [Differential statistical analysis](#differential-statistical-analysis)
* [Session Information](#session-information)

## Overview

This document provides brief tutorial of the *qPLEXanalyzer* package, a toolkit with multiple functionalities, for statistical analysis of qPLEX-RIME proteomics data (see `?qPLEXanalyzer` at the R prompt for a brief overview). The qPLEX-RIME approach combines the RIME method with multiplex TMT chemical isobaric labelling to study the dynamics of chromatin-associated protein complexes. The package can also be used for isobaric labelling (TMT or iTRAQ) based total proteome analysis.

* Import quantitative dataset: A pre-processed quantitative dataset generated from MaxQuant, Proteome Discoverer or any other proteomic software consisting of peptide intensities with associated features along with sample meta-data information can be imported by *qPLEXanalyzer*.
* Quality control: Computes and displays quality control statistics plots of the quantitative dataset.
* Data normalization: Quantile normalization, central tendencies scaling and linear regression based normalization.
* Aggregation of peptide intensities into protein intensities
* Merging of similar peptides/sites into unified intensities
* Differential statistical analysis: *limma* based analysis to identify differentially abundant proteins.

## Import quantitative dataset

[MSnbase](http://bioconductor.org/packages/MSnbase) (Gatto L 2012, n.d.) package by Laurent Gatto provides methods to facilitate reproducible analysis of MS-based proteomics data. The *MSnSet* class of [MSnbase](http://bioconductor.org/packages/MSnbase) provides architecture for storing quantitative MS proteomics data and the experimental meta-data. In *qPLEXanalyzer*, we store pre-processed quantitative proteomics data within this standardized object. The `convertToMSnset` function creates an *MSnSet* object from the quantitative dataset of peptides/protein intensities. This dataset must consist of peptides identified with high confidence in all the samples.

The default input dataset is the pre-processed peptide intensities from MaxQuant, Proteome Discoverer or any other proteomic software (see `?convertToMSnset` at the R prompt for more details). Only peptides uniquely matching to a protein should be used as an input. Alternatively, the protein level quantification by the aggregation of the peptide TMT intensities can also be used as input. Peptides/Protein intensities with missing values in one or more samples can either be excluded or included in the *MSnSet* object. If the missing values are kept in the *MSnSet* object, these must be imputed either by user defined methods or by those provided in [MSnbase](http://bioconductor.org/packages/MSnbase) package. The downstream functions of *qPLEXanalyzer* expect a matrix with no missing values in the *MSnSet* object.

The example dataset shown below is from an ER qPLEX-RIME experiment in MCF7 cells that was performed to compare two different ways of cell crosslinking: DSG/formaldehyde (double) or formaldehyde alone (single). It consists of four biological replicates for each condition along with two IgG samples pooled from replicates of each group.

```
library(qPLEXanalyzer)
library(patchwork)
data(human_anno)
data(exp2_Xlink)
```

```
MSnset_data <- convertToMSnset(exp2_Xlink$intensities,
                               metadata = exp2_Xlink$metadata,
                               indExpData = c(7:16),
                               Sequences = 2,
                               Accessions = 6)
exprs(MSnset_data) <- exprs(MSnset_data)+1.1
MSnset_data
```

```
## MSnSet (storageMode: lockedEnvironment)
## assayData: 12355 features, 10 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: FA.rep01 FA.rep02 ... DSG.FA.IgG (10 total)
##   varLabels: SampleName SampleGroup ... Grp (5 total)
##   varMetadata: labelDescription
## featureData
##   featureNames: peptide_1 peptide_2 ... peptide_12355 (12355 total)
##   fvarLabels: Confidence Sequences ... Accessions (6 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
## - - - Processing information - - -
##  MSnbase version: 2.36.0
```

## Quality control

Once an *MSnSet* object has been created, various descriptive statistics methods can be used to check the quality of the dataset.

### Peptide intensity plots

The `intensityPlot` function generates a peptide intensity distribution plot that helps in identifying samples with outlier distributions. [Figure 1](#Figure1) shows the distribution of the log-intensity of peptides/proteins for each sample. An outlier sample DSG.FA.rep01 can be identified from this plot. IgG control samples representing low background intensities will have shifted/distinct intensity distribution curve as compared to other samples and should not be considered as outliers.

```
intensityPlot(MSnset_data, title = "Peptide intensity distribution")
```

![](data:image/png;base64...)

Figure 1: Density plots of raw intensities for TMT-10plex experiment.

The intensities can also be viewed in the form of boxplots by `intensityPlot`. [Figure 2](#Figure2) shows the distribution of peptides intensities for each sample.

```
intensityBoxplot(MSnset_data, title = "Peptide intensity distribution")
```

![](data:image/png;base64...)

Figure 2: Boxplot of raw intensities for TMT-10plex experiment.

### Relative log intensity boxplot

`rliPlot` can be used to visualise unwanted variation in a data set. It is similar to the relative log expression plot developed for microarray analysis (Gandolfo 2018). Rather than examining gene expression, the RLI plot ([Figure 3](#Figure3)) uses the MS intensities for each peptide or the summarised protein intensities.

```
rliPlot(MSnset_data, title = "Relative Peptide intensity")
```

![](data:image/png;base64...)

Figure 3: RLI of raw intensities for TMT-10plex experiment.

### Sample correlation plot

A Correlation plot can be generated by `corrPlot` to visualize the level of linear association of samples within and between groups. The plot in [Figure 4](#Figure4) displays high correlation among samples within each group, however an outlier sample is also identified in one of the groups (DSG.FA).

```
corrPlot(MSnset_data)
```

![](data:image/png;base64...)

Figure 4: Correlation plot of peptide intensities

### Hierachical clustering dendrogram

Hierarchical clustering can be performed by `hierarchicalPlot` to produce a dendrogram displaying the hierarchical relationship among samples ([Figure 5](#Figure5)). The horizontal axis shows the dissimilarity (measured by means of the Euclidean distance) between samples: similar samples appear on the same branches. Colors correspond to groups. If the data set contains zeros, it will be necessary to add a small value (e.g. 0.01) to the intentsities in order to avoid errors while generating dendrogram.

```
exprs(MSnset_data) <- exprs(MSnset_data) + 0.01
hierarchicalPlot(MSnset_data)
```

![](data:image/png;base64...)

Figure 5: Clustering plot of peptide intensitites

### Principle component analysis scatterplot

A visual representation of the scaled loading of the first two dimensions of a PCA analysis can be obtained by `pcaPlot` ([Figure 6](#Figure6)). Co-variances between samples are approximated by the inner product between samples. Highly correlated samples will appear close to each other. The samples could be labeled by name, replicate, group or experiment run allowing for identification of potential batch effects.

```
pcaPlot(MSnset_data, labelColumn = "BioRep", pointsize = 3)
```

![](data:image/png;base64...)

Figure 6: PCA plot of peptide intensitites

### Bait protein coverage plot

A plot showing regions of the bait protein covered by captured peptides can be produced using `coveragePlot` ([Figure 7](#Figure7)). The plot shows the location of peptides that have been identified with high confidence across the protein sequence and the corresponding percentage of coverage. This provides a means of assessing the efficiency of the immunoprecipitation approach in the qPLEX-RIME method. For a better evaluation of the pull down assay we could compare the observed bait protein coverage with the theoretical coverage from peptides predicted by known cleavage sites.

```
mySequenceFile <- system.file("extdata", "P03372.fasta", package = "qPLEXanalyzer")
coveragePlot(MSnset_data,
             ProteinID = "P03372",
             ProteinName = "ESR1",
             fastaFile = mySequenceFile)
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the qPLEXanalyzer package.
##   Please report the issue at
##   <https://github.com/crukci-bioinformatics/qPLEXanalyzer/issues>.
## This warning is displayed once per session.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

Figure 7: Peptide sequence coverage plot

## Data normalization

The data can be normalized to remove experimental artifacts (e.g. differences in sample loading variability, systemic variation) in order to separate biological variations from those introduced during the experimental process. This would improve downstream statistical analysis to obtain more accurate comparisons. Different normalization methods can be used depending on the data:

* Quantiles `normalizeQuantiles`: The peptide intensities are roughly replaced by the order statistics on their abundance. The key assumption underneath is that there are only few changes between different groups. This normalization technique has the effect of making the distributions of intensities from the different samples identical in terms of their statistical properties. It is the strongest normalization method and should be used carefully as it erases most of the difference between the samples. We would recommend using it only for total proteome but not for qPLEX-RIME data.
* Mean/median scaling `normalizeScaling`: In this normalization method the central tendencies (mean or median) of the samples are aligned. The central tendency for each sample is computed and log transformed. A scaling factor is determined by subtracting from each central tendency the mean of all the central tendencies. The raw intensities are then divided by the scaling factor to get normalized ones.
* Row scaling `rowScaling`: In this normalization method each peptide/protein intensity is divided by the mean/median of its intensity across all samples and log2 transformed.

It is imperative to check the intensity distribution plot and PCA plot before and after normalization to verify its effect on the dataset.

In qPLEX-RIME data, the IgG (or control samples) should be normalized separately from the bait protein pull-down samples. As IgG samples represent the low background intensity, their intensity distribution profile is different from bait pull-downs. Hence, normalizing the two together would result in over-correction of the IgG intensity resulting in inaccurate computation of differences among groups. To this end we provide `groupScaling`, the additional parameter *groupingColumn* defines a category for grouping the samples, scaling is then carried out within each group independently.

If no normalization is necessary, skip this step and move to aggregation of peptides.

For this dataset, an outlier sample was identified by quality control plots and removed from further analysis. [Figure 8](#Figure8) displays the effect of various normalization methods on the peptide intensities distribution.

```
MSnset_data <- MSnset_data[, -5]
p1 <- intensityPlot(MSnset_data, title = "No normalization")

MSnset_norm_q <- normalizeQuantiles(MSnset_data)
p2 <- intensityPlot(MSnset_norm_q, title = "Quantile")

MSnset_norm_ns <- normalizeScaling(MSnset_data, scalingFunction = median)
p3 <- intensityPlot(MSnset_norm_ns, title = "Scaling")

MSnset_norm_gs <- groupScaling(MSnset_data,
                               scalingFunction = median,
                               groupingColumn = "SampleGroup")
p4 <- intensityPlot(MSnset_norm_gs, title = "Within Group Scaling")

(p1 | p2) / (p3 | p4)
```

![](data:image/png;base64...)

Figure 8: Peptide intensity distribution with various normalization methods

## Aggregation of peptide intensities into protein intensities

The quantitative dataset could consist of peptide or protein intensities. If the dataset consists of peptide information, they can be aggregated to protein intensities for further analysis.

An annotation file consisting of proteins with unique ID must be provided. An example file can be found with the package corresponding to uniprot annotation of human proteins. It consists of four columns: ‘Accessions’, ‘Gene’, ‘Description’ and ‘GeneSymbol’. The columns ‘Accessions’and ’GeneSymbol’ are mandatory for successful downstream analysis while the other two columns are optional. The [UniProt.ws](http://bioconductor.org/packages/niProt.ws) package provides a convenient means of obtaining these annotations using Uniprot protein accessions, as shown in the section below. The `summarizeIntensities` function expects an annotation file in this format.

```
library(UniProt.ws)
library(dplyr)
proteins <- unique(fData(MSnset_data)$Accessions)[1:10]
columns <- c("id", 'gene_primary',"gene_names", "protein_name")
hs <- UniProt.ws::UniProt.ws(taxId = 9606)
first_ten_anno <- UniProt.ws::select(hs, proteins, columns, "UniProtKB") %>%
  as_tibble() %>%
  select(Accessions = "Entry",
         Gene = "Entry.Name",
         Description = "Protein.names",
         GeneSymbol= "Gene.Names..primary.") %>%
  arrange(Accessions)
head(first_ten_anno)
```

```
## # A tibble: 6 × 4
##   Accessions Gene        Description                                  GeneSymbol
##   <chr>      <chr>       <chr>                                        <chr>
## 1 P04264     K2C1_HUMAN  Keratin, type II cytoskeletal 1 OS=Homo sap… KRT1
## 2 P05783     K1C18_HUMAN Keratin, type I cytoskeletal 18 OS=Homo sap… KRT18
## 3 P14866     HNRPL_HUMAN Heterogeneous nuclear ribonucleoprotein L O… HNRNPL
## 4 P35527     K1C9_HUMAN  Keratin, type I cytoskeletal 9 OS=Homo sapi… KRT9
## 5 P35908     K22E_HUMAN  Keratin, type II cytoskeletal 2 epidermal O… KRT2
## 6 P39748     FEN1_HUMAN  Flap endonuclease 1 OS=Homo sapiens OX=9606… FEN1
```

The aggregation can be performed by calculating the sum, mean or median of the raw or normalized peptide intensities. The summarized intensity for a selected protein could be visualized using `peptideIntensityPlot`. It plots all peptides intensities for a selected protein along with summarized intensity across all the samples ([Figure 9](#Figure9)).

```
MSnset_Pnorm <- summarizeIntensities(MSnset_norm_gs,
                                     summarizationFunction = sum,
                                     annotation = human_anno)
```

```
peptideIntensityPlot(MSnset_data,
                     combinedIntensities = MSnset_Pnorm,
                     ProteinID = "P03372",
                     ProteinName = "ESR1")
```

![](data:image/png;base64...)

Figure 9: Summarized protein intensity

## Merging of similar peptides/sites into unified intensities

Data that contain TMT-labelled peptides with post-translational modifications (Phospho/Acetyl) are mainly analysed at the peptide level instead of the protein level. The analysis can be performed either at the peptide sequence or modified protein site level. However, in these datasets there are peptide sequences or modified protein sites that are identified multiple times. Peptide sequences that are present multiple times may contain additional modifications such as oxidation of M or deamidation of N, Q that are introduced during sample preparation. Additionally, the same acetyl protein site may be present multiple times as peptide sequences may be overlapping due to a missed cleavage. To reduce the redundancy and facilitate the data interpretation, such sequences/sites coming from same protein are merged into a unified peptide/site TMT intensity.

The `mergePeptides` function performs the merging of identical peptides sequences (of enriched modification) belonging to same protein into single peptide intensity.

The `mergeSites` function performs the merging of identical modified sites (of enriched modification) belonging to same protein into single site intensity. It is imperative to pre-process your input quantitative proteomics data such that each row represents intensity of modified site (with protein accession). This function expects `Sites` column in your dataset.

## Regression Analysis

To correct for the potential dependency of immunoprecipitated proteins (in qPLEX-RIME) on the bait protein, a linear regression method is available in *qPLEXanalyzer*. The `regressIntensity` function performs a regression analysis in which bait protein levels is the independent variable (x) and the profile of each of the other protein is the dependent variable (y). The residuals of the y=ax+b linear model represent the protein quantification profiles that are not driven by the amount of the bait protein.

The advantage of this approach is that proteins with strong dependency on the target protein are subjected to significant correction, whereas proteins with small dependency on the target protein are slightly corrected. In contrast, if a standard correction factor were used, it would have the same magnitude of effect on all proteins. The control samples (such as IgG) should be excluded from the regression analysis. The `regressIntensity` function also generates the plot displaying the correlation between bait and other protein before and after applying this method ([Figure 10](#Figure10)).

The example dataset shown below is from an ER qPLEX-RIME experiment carried out in MCF7 cells to investigate the dynamics of the ER complex assembly upon 4-hydroxytamoxifen (OHT) treatment at 2h, 6h and 24h or at 24h post-treatment with the vehicle alone (ethanol). It consists of six biological replicates for each condition spanned across three TMT experiments along with two IgG mock pull down samples in each experiment.

```
data(exp3_OHT_ESR1)
MSnset_reg <- convertToMSnset(exp3_OHT_ESR1$intensities_qPLEX2,
                              metadata = exp3_OHT_ESR1$metadata_qPLEX2,
                              indExpData = c(7:16),
                              Sequences = 2,
                              Accessions = 6)
MSnset_P <- summarizeIntensities(MSnset_reg,
                                 summarizationFunction = sum,
                                 annotation = human_anno)
MSnset_P <- rowScaling(MSnset_P, scalingFunction = mean)
IgG_ind <- which(pData(MSnset_P)$SampleGroup == "IgG")
Reg_data <- regressIntensity(MSnset_P,
                             controlInd = IgG_ind,
                             ProteinId = "P03372")
```

![](data:image/png;base64...)

Figure 10: Correlation between bait protein and enriched proteins before and after regression

## Differential statistical analysis

A statistical analysis for the identification of differentially regulated or bound proteins is carried out using [limma](http://bioconductor.org/packages/limma) (Ritchie et al. 2015). It uses linear models to assess differential expression in the context of multifactor designed experiments. Firstly, a linear model is fitted for each protein where the model includes variables for each group and MS run. Then, log2 fold changes between comparisons are estimated using `computeDiffStats`. Multiple testing correction of p-values are applied using the Benjamini-Hochberg method to control the false discovery rate (FDR). Finally, `getContrastResults` is used to get contrast specific results.

The qPLEX-RIME experiment can consist of IgG mock samples to discriminate non-specific binding. The controlGroup argument within `getContrastResults` function allows you to specify this group (such as IgG). It then uses the mean intensities from the fitted linear model to compute log2 fold change between IgG and each of the groups. The maximum log2 fold change over IgG control from the two groups being compared is reported in the *controlLogFoldChange* column. This information can be used to filter non-specific binding. A *controlLogFoldChange* more than 1 can be used as a filter to discover specific interactors.

The results of the differential protein analysis can be visualized using `maVolPlot` function. It plots average log2 protein intensity to log2 fold change between groups compared. This enables quick visualization ([Figure 11](#Figure11)) of significantly abundant proteins between groups. `maVolPlot` could also be used to view differential protein results in a volcano plot ([Figure 12](#Figure12)) to compare the size of the fold change to the statistical significance level.

```
contrasts <- c(DSG.FA_vs_FA = "DSG.FA - FA")
diffstats <- computeDiffStats(MSnset_Pnorm, contrasts = contrasts)
diffexp <- getContrastResults(diffstats,
                              contrast = "DSG.FA_vs_FA",
                              controlGroup = "IgG")
```

```
maVolPlot(diffstats, contrast = "DSG.FA_vs_FA", plotType = "MA", title = contrasts)
```

![](data:image/png;base64...)

Figure 11: MA plot of the quantified proteins

```
maVolPlot(diffstats, contrast = "DSG.FA_vs_FA", plotType = "Volcano", title = contrasts)
```

![](data:image/png;base64...)

Figure 12: Volcano plot of the quantified proteins

## Session Information

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## Random number generation:
##  RNG:     Mersenne-Twister
##  Normal:  Inversion
##  Sample:  Rounding
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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] dplyr_1.1.4          patchwork_1.3.2      qPLEXanalyzer_1.28.2
##  [4] MSnbase_2.36.0       ProtGenerics_1.42.0  S4Vectors_0.48.0
##  [7] mzR_2.44.0           Rcpp_1.1.1           Biobase_2.70.0
## [10] BiocGenerics_0.56.0  generics_0.1.4
##
## loaded via a namespace (and not attached):
##  [1] rlang_1.1.7                 magrittr_2.0.4
##  [3] clue_0.3-66                 otel_0.2.0
##  [5] matrixStats_1.5.0           compiler_4.5.2
##  [7] vctrs_0.7.0                 reshape2_1.4.5
##  [9] stringr_1.6.0               pkgconfig_2.0.3
## [11] MetaboCoreUtils_1.18.1      crayon_1.5.3
## [13] fastmap_1.2.0               XVector_0.50.0
## [15] labeling_0.4.3              utf8_1.2.6
## [17] rmarkdown_2.30              tzdb_0.5.0
## [19] preprocessCore_1.72.0       purrr_1.2.1
## [21] xfun_0.56                   MultiAssayExperiment_1.36.1
## [23] cachem_1.1.0                jsonlite_2.0.0
## [25] DelayedArray_0.36.0         BiocParallel_1.44.0
## [27] parallel_4.5.2              cluster_2.1.8.1
## [29] R6_2.6.1                    bslib_0.9.0
## [31] stringi_1.8.7               RColorBrewer_1.1-3
## [33] limma_3.66.0                GenomicRanges_1.62.1
## [35] jquerylib_0.1.4             Seqinfo_1.0.0
## [37] assertthat_0.2.1            SummarizedExperiment_1.40.0
## [39] iterators_1.0.14            knitr_1.51
## [41] readr_2.1.6                 IRanges_2.44.0
## [43] BiocBaseUtils_1.12.0        splines_4.5.2
## [45] Matrix_1.7-4                igraph_2.2.1
## [47] tidyselect_1.2.1            dichromat_2.0-0.1
## [49] abind_1.4-8                 yaml_2.3.12
## [51] doParallel_1.0.17           codetools_0.2-20
## [53] affy_1.88.0                 lattice_0.22-7
## [55] tibble_3.3.1                plyr_1.8.9
## [57] withr_3.0.2                 S7_0.2.1
## [59] evaluate_1.0.5              Spectra_1.20.1
## [61] Biostrings_2.78.0           pillar_1.11.1
## [63] affyio_1.80.0               BiocManager_1.30.27
## [65] MatrixGenerics_1.22.0       foreach_1.5.2
## [67] MALDIquant_1.22.3           ncdf4_1.24
## [69] hms_1.1.4                   ggplot2_4.0.1
## [71] scales_1.4.0                glue_1.8.0
## [73] lazyeval_0.2.2              tools_4.5.2
## [75] mzID_1.48.0                 QFeatures_1.20.0
## [77] vsn_3.78.1                  fs_1.6.6
## [79] XML_3.99-0.20               grid_4.5.2
## [81] impute_1.84.0               tidyr_1.3.2
## [83] MsCoreUtils_1.22.1          PSMatch_1.14.0
## [85] cli_3.6.5                   S4Arrays_1.10.1
## [87] ggdendro_0.2.0              AnnotationFilter_1.34.0
## [89] pcaMethods_2.2.0            gtable_0.3.6
## [91] sass_0.4.10                 digest_0.6.39
## [93] SparseArray_1.10.8          farver_2.1.2
## [95] htmltools_0.5.9             lifecycle_1.0.5
## [97] statmod_1.5.1               MASS_7.3-65
```

Gandolfo, Terence P., Luke C. AND Speed. 2018. “RLE Plots: Visualizing Unwanted Variation in High Dimensional Data.” *PLOS ONE* 13 (2): 1–9. <https://doi.org/10.1371/journal.pone.0191629>.

Gatto L, Lilley K. 2012. ““MSnbase - an R/Bioconductor package for isobaric tagged mass spectrometry data visualization, processing and quantitation.” *Bioinformatics* 28 (288-289). <http://dx.doi.org/10.1093/bioinformatics/btr645>.

Gatto L, Rainer J, Gibb S. n.d. “MSnbase, efficient and elegant R-based processing and visualisation of raw mass spectrometry data.” *bioRxiv*. <https://doi.org/10.1101/2020.04.29.067868>.

Ritchie, Matthew E., Belinda Phipson, Di Wu, Yifang Hu, Charity W. Law, Wei Shi, and Gordon K. Smyth. 2015. “limma powers differential expression analyses for RNA-sequencing and microarray studies.” *Nucleic Acids Research* 43 (7): e47–e47. <https://doi.org/10.1093/nar/gkv007>.