# Getting started with PRONE

#### Lis Arend

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Workflow](#workflow)
* [4 Usage](#usage)
* [5 Load Data](#load-data)
  + [5.1 Example 1: TMT Data Set](#example-1-tmt-data-set)
  + [5.2 Example 2: Label-free (LFQ) Data Set](#example-2-label-free-lfq-data-set)
* [6 Data Structure](#data-structure)
* [7 Preprocessing, Imputation, Normalization, Evaluation, and Differential Expression](#preprocessing-imputation-normalization-evaluation-and-differential-expression)
* [8 Download Data](#download-data)
* [9 Session Info](#session-info)
* [References](#references)

# 1 Introduction

High-throughput omics data are often affected by systematic biases
introduced throughout all the steps of a clinical study, from sample
collection to quantification. Failure to account for these biases can
lead to erroneous results and misleading conclusions in downstream
analysis. Normalization methods aim to adjust for these biases to make
the actual biological signal more prominent. However, selecting an
appropriate normalization method is challenging due to the wide range of
available approaches. Therefore, a comparative evaluation of
unnormalized and normalized data is essential in identifying an
appropriate normalization strategy for a specific data set. This R
package provides different functions for preprocessing, normalizing, and
evaluating different normalization approaches. Furthermore,
normalization methods can be evaluated on downstream steps, such as
differential expression analysis and statistical enrichment analysis.
Spike-in data sets with known ground truth and real-world data sets of
biological experiments acquired by either tandem mass tag (TMT) or
label-free quantification (LFQ) can be analyzed.

# 2 Installation

```
# Official BioC installation instructions
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("PRONE")
```

```
# Load and attach PRONE
library(PRONE)
```

# 3 Workflow

A six-step workflow was developed in R version 4.2.2 to evaluate the
effectiveness of the previously defined normalization methods on
proteomics data. The workflow incorporates a set of novel functions and
also integrates various methods adopted by state-of-the-art tools.

![Six-step workflow of PRONE.](data:image/png;base64...)

Figure 3.1: Six-step workflow of PRONE.

Following the upload of the proteomics data into a SummarizedExperiment
object, proteins with too many missing values can be removed, outlier
samples identified, and normalization carried out. Furthermore, an
exploratory analysis of the performance of normalization methods can be
conducted. Finally, differential expression analysis can be executed to
further evaluate the effectiveness of normalization methods. For data
sets with known ground truth, such as spike-in and simulated data sets,
performance metrics, such as true positives (TPs), false positives
(FPs), and area under the curve (AUC) values, can be computed. The
evaluation of DE results of real-world experiments is based on visual
quality inspection, for instance, using volcano plots, and an
intersection analysis of the DE proteins of different normalization
methods is available.

# 4 Usage

This guide serves as an introduction to the PRONE R package, designed to facilitate the preparation of your data set for utilization of the PRONE package’s functionalities. It begins by delineating the underlying data structure essential for the application of the package, followed by a brief description of how to apply different normalization techniques to your data. Additionally, this tutorial shows how to export the normalized data at the end.

Beyond the scope of this introductory tutorial, PRONE encompassess a broad spectrum of functionalities, ranging from preprocessing steps, imputation, normalization and evaluation of the performance of different normalization techniques, to the identification of differentially expressed proteins. These functionalities are detailed in dedicated vignettes, offering detailed insights and instructions for leveraging full capabilities of the PRONE package:

* [Preprocessing Tutorial](Preprocessing.html)
* [Imputation Tutorial](Imputation.html)
* [Normalization Tutorial](Normalization.html)
* [Differential Expression Tutorial](Differential_Expression.html)

Furthermore, PRONE provides additional functionalities for the analysis of spike-in data sets, which are detailed in the following vignette:

* [Spike-In Tutorial](Spike_In_Data.html)

# 5 Load Data

PRONE uses the [SummarizedExperiment](https://bioconductor.org/packages/release/bioc/html/SummarizedExperiment.html) class as storage for protein intensities and meta data information on the proteomics data set. Hence, before being able to execute the functionalities of PRONE, the data needs to be saved accordingly. For this, the `load_data()` function was implemented and requires different parameters which are explained in the following:

* **data**: refers to the data.frame containing the protein intensities
* **md**: refers to the data.frame containing the meta-data information
* **protein\_column**: refers to the column in the data frame that contains the protein IDs
* **gene\_column** (optional): refers to the column in the data frame that contains the gene IDs
* **condition\_column** (optional): refers to the column in the meta-data table that contains the condition information - this can also be specified later
* **label\_column** (optional): refers to the column in the meta-data table that contains sample label information - sometimes the sample names are very long and this column gives the option to label the samples with shorter names for visualization purposes

If you have a tandem mass tag (TMT) data set with samples being measured in different batches than you have to specify the batch information. If reference samples were included in each batch, then additionally specify the samples names of the reference samples.

* **batch\_column** (optional): refers to the column in the meta-data table that contains the batch information
* **ref\_samples** (optional): refers to the samples that should be used as reference samples for normalization

**Attention:** You need to make sure that the sample names are saved in a column named “Column” in the meta-data table and are named accordingly in the protein intensity table.

## 5.1 Example 1: TMT Data Set

The example TMT data set originates from (Biadglegne et al. 2022).

```
data_path <- readPRONE_example("tuberculosis_protein_intensities.csv")
md_path <- readPRONE_example("tuberculosis_metadata.csv")

data <- read.csv(data_path)
md <- read.csv(md_path)

md$Column <- stringr::str_replace_all(md$Column, " ", ".")

ref_samples <- md[md$Group == "ref",]$Column

se <- load_data(data, md, protein_column = "Protein.IDs",
                gene_column = "Gene.names", ref_samples = ref_samples,
                batch_column = "Pool", condition_column = "Group",
                label_column = "Label")
```

## 5.2 Example 2: Label-free (LFQ) Data Set

The example data set originates from (Vehmas et al. 2016). This data set is used for the subsequent examples in this tutorial.

```
data_path <- readPRONE_example("mouse_liver_cytochrome_P450_protein_intensities.csv")
md_path <- readPRONE_example("mouse_liver_cytochrome_P450_metadata.csv")

data <- read.csv(data_path, check.names = FALSE)
md <- read.csv(md_path)

se <- load_data(data, md, protein_column = "Accession",
                gene_column = "Gene names", ref_samples = NULL,
                batch_column = NULL, condition_column = "Condition",
                label_column = NULL)
```

# 6 Data Structure

The SummarizedExperiment object contains the protein intensities as “assay”, the meta-data table as “colData”, and additional columns for instance resulting from MaxQuant as “rowData”. Furthermore, information on the different columns, for instance, which columns contains the batch information, can be found in the “metadata” slot.

```
se
#> class: SummarizedExperiment
#> dim: 1499 12
#> metadata(4): condition batch refs label
#> assays(2): raw log2
#> rownames(1499): 1 2 ... 1498 1499
#> rowData names(4): Gene.Names Protein.IDs Peptides used for quantitation
#>   IDs
#> colnames(12): 2206_WT 2208_WT ... 2285_Arom 2253_Arom
#> colData names(3): Column Animal Condition
```

The different data types can be accessed by using the `assays()` function. Currently, only the raw data and log2-transformed data are stored in the SummarizedExperiment object.

```
assays(se)
#> List of length 2
#> names(2): raw log2
```

# 7 Preprocessing, Imputation, Normalization, Evaluation, and Differential Expression

As already mentioned in the introduction section, many functionalities are available in PRONE. All these functionalities are mainly based on the SummarizedExperiment object.

In this tutorial, we will only perform simple normalization of the data using median and LoessF normalization.

```
se <- normalize_se(se, c("Median", "LoessF"))
#> Median completed.
#> LoessF completed.
```

The normalized intensities will be saved as additional assays in the SummarizedExperiment object.

```
assays(se)
#> List of length 4
#> names(4): raw log2 Median LoessF
```

Again, more information on the individual processes can be find in dedicated vignettes.

# 8 Download Data

Finally, you can easily download the normalized data by using the `export_data()` function. This function will save the specified assays as CSV files and the SummarizedExperiment object as an RDS file in a specified output directory. Make sure that the output directory exists.

```
if(!dir.exists("output/")) dir.create("output/")

export_data(se, out_dir = "output/", ain = c("log2", "Median", "LoessF"))
```

# 9 Session Info

```
utils::sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] PRONE_1.4.0                 SummarizedExperiment_1.40.0
#>  [3] Biobase_2.70.0              GenomicRanges_1.62.0
#>  [5] Seqinfo_1.0.0               IRanges_2.44.0
#>  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
#>  [9] generics_0.1.4              MatrixGenerics_1.22.0
#> [11] matrixStats_1.5.0
#>
#> loaded via a namespace (and not attached):
#>   [1] bitops_1.0-9                permute_0.9-8
#>   [3] rlang_1.1.6                 magrittr_2.0.4
#>   [5] GetoptLong_1.0.5            clue_0.3-66
#>   [7] compiler_4.5.1              mgcv_1.9-3
#>   [9] gprofiler2_0.2.3            png_0.1-8
#>  [11] vctrs_0.6.5                 reshape2_1.4.4
#>  [13] stringr_1.5.2               ProtGenerics_1.42.0
#>  [15] shape_1.4.6.1               crayon_1.5.3
#>  [17] pkgconfig_2.0.3             MetaboCoreUtils_1.18.0
#>  [19] fastmap_1.2.0               magick_2.9.0
#>  [21] XVector_0.50.0              labeling_0.4.3
#>  [23] rmarkdown_2.30              preprocessCore_1.72.0
#>  [25] purrr_1.1.0                 xfun_0.53
#>  [27] MultiAssayExperiment_1.36.0 cachem_1.1.0
#>  [29] jsonlite_2.0.0              DelayedArray_0.36.0
#>  [31] BiocParallel_1.44.0         parallel_4.5.1
#>  [33] cluster_2.1.8.1             R6_2.6.1
#>  [35] bslib_0.9.0                 stringi_1.8.7
#>  [37] RColorBrewer_1.1-3          limma_3.66.0
#>  [39] jquerylib_0.1.4             Rcpp_1.1.0
#>  [41] bookdown_0.45               iterators_1.0.14
#>  [43] knitr_1.50                  BiocBaseUtils_1.12.0
#>  [45] splines_4.5.1               Matrix_1.7-4
#>  [47] igraph_2.2.1                tidyselect_1.2.1
#>  [49] dichromat_2.0-0.1           abind_1.4-8
#>  [51] yaml_2.3.10                 vegan_2.7-2
#>  [53] doParallel_1.0.17           ggtext_0.1.2
#>  [55] codetools_0.2-20            affy_1.88.0
#>  [57] lattice_0.22-7              tibble_3.3.0
#>  [59] plyr_1.8.9                  withr_3.0.2
#>  [61] S7_0.2.0                    evaluate_1.0.5
#>  [63] Spectra_1.20.0              xml2_1.4.1
#>  [65] circlize_0.4.16             pillar_1.11.1
#>  [67] affyio_1.80.0               BiocManager_1.30.26
#>  [69] DT_0.34.0                   foreach_1.5.2
#>  [71] plotly_4.11.0               MSnbase_2.36.0
#>  [73] MALDIquant_1.22.3           ncdf4_1.24
#>  [75] RCurl_1.98-1.17             ggplot2_4.0.0
#>  [77] scales_1.4.0                glue_1.8.0
#>  [79] lazyeval_0.2.2              tools_4.5.1
#>  [81] mzID_1.48.0                 data.table_1.17.8
#>  [83] QFeatures_1.20.0            vsn_3.78.0
#>  [85] mzR_2.44.0                  fs_1.6.6
#>  [87] XML_3.99-0.19               Cairo_1.7-0
#>  [89] grid_4.5.1                  impute_1.84.0
#>  [91] tidyr_1.3.1                 crosstalk_1.2.2
#>  [93] colorspace_2.1-2            MsCoreUtils_1.22.0
#>  [95] nlme_3.1-168                PSMatch_1.14.0
#>  [97] cli_3.6.5                   viridisLite_0.4.2
#>  [99] S4Arrays_1.10.0             ComplexHeatmap_2.26.0
#> [101] dplyr_1.1.4                 AnnotationFilter_1.34.0
#> [103] pcaMethods_2.2.0            gtable_0.3.6
#> [105] sass_0.4.10                 digest_0.6.37
#> [107] SparseArray_1.10.0          htmlwidgets_1.6.4
#> [109] rjson_0.2.23                farver_2.1.2
#> [111] htmltools_0.5.8.1           lifecycle_1.0.4
#> [113] httr_1.4.7                  NormalyzerDE_1.28.0
#> [115] GlobalOptions_0.1.2         statmod_1.5.1
#> [117] gridtext_0.1.5              MASS_7.3-65
```

# References

Biadglegne, Fantahun, Johannes R. Schmidt, Kathrin M. Engel, Jörg Lehmann, Robert T. Lehmann, Anja Reinert, Brigitte König, Jürgen Schiller, Stefan Kalkhof, and Ulrich Sack. 2022. “Mycobacterium Tuberculosis Affects Protein and Lipid Content of Circulating Exosomes in Infected Patients Depending on Tuberculosis Disease State.” *Biomedicines* 10 (4): 783. <https://doi.org/10.3390/biomedicines10040783>.

Vehmas, Anni P., Marion Adam, Teemu D. Laajala, Gabi Kastenmüller, Cornelia Prehn, Jan Rozman, Claes Ohlsson, et al. 2016. “Liver Lipid Metabolism Is Altered by Increased Circulating Estrogen to Androgen Ratio in Male Mouse.” *Journal of Proteomics* 133 (February): 66–75. <https://doi.org/10.1016/j.jprot.2015.12.009>.