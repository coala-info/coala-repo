# Suppl. Ch. 1 - Quickstart Guide for New R Users

#### Gabriel Odom

#### 2025-10-30

* [1. Overview](#overview)
  + [Installing the Package](#installing-the-package)
  + [Loading Packages](#loading-packages)
* [2. Import Data](#import-data)
  + [2.1 Import `.gmt` Files](#import-.gmt-files)
  + [2.2 Import and Tidy Assay Data](#import-and-tidy-assay-data)
  + [2.3 Import Phenotype Info](#import-phenotype-info)
  + [2.4 Match the Phenotype and Assay Data](#match-the-phenotype-and-assay-data)
* [3. Create an `Omics` Data Object](#create-an-omics-data-object)
  + [3.1 Create an Object](#create-an-object)
  + [3.2 Inspect the Object](#inspect-the-object)
  + [3.3 Detailed Object Views](#detailed-object-views)
* [4. Test Pathways for Significance](#test-pathways-for-significance)
  + [4.1 AES-PCA](#aes-pca)
  + [4.2 Supervised PCA](#supervised-pca)
* [5. Inspect Results](#inspect-results)
  + [5.1 Analysis Output Table](#analysis-output-table)
  + [5.2 Graph of Top Pathways](#graph-of-top-pathways)
* [6. Links to Detailed Information](#links-to-detailed-information)

# 1. Overview

This guide will serve as a brief overview to the pathway significance testing workflow with the `pathwayPCA` package. We will discuss the four basic steps of pathway significance testing with the `pathwayPCA` package. These steps are: importing data, creating an `Omics` data object, testing pathways for significance, and inspecting the results. For detailed discussions of these steps, see the following appropriate vignettes:

1. Download Packages
2. Import and Tidy Data ([*vignette*](https://gabrielodom.github.io/pathwayPCA/articles/Supplement2-Importing_Data.html))
3. Create Data Objects ([*vignette*](https://gabrielodom.github.io/pathwayPCA/articles/Supplement3-Create_Omics_Objects.html))
4. Test Pathway Significance ([*vignette*](https://gabrielodom.github.io/pathwayPCA/articles/Supplement4-Methods_Walkthrough.html))
5. Visualize Results ([*vignette*](https://gabrielodom.github.io/pathwayPCA/articles/Supplement5-Analyse_Results.html))

## Installing the Package

`pathwayPCA` is a package for R, so you need [R](https://cloud.r-project.org/) first. We also strongly recommend the [RStudio](https://www.rstudio.com/products/rstudio/download/) integrated development environment as a user-friendly graphical wrapper for R.

### Stable Build

The stable build of our package will be available on Bioconductor in May of 2019. To access Bioconductor packages, first install BiocManager, then use BiocManager to install this package:

```
install.packages("BiocManager")
BiocManager::install("pathwayPCA")
```

### Development Build

Because we are currently in the development phase for version 2 of this package, you can install the package from GitHub. In order to install a package from GitHub, you will need the `devtools::` package (<https://github.com/r-lib/devtools>) and either [Rtools](https://cran.r-project.org/bin/windows/Rtools/) (for Windows) or [Xcode](https://developer.apple.com/xcode/) (for Mac). Then you can install the development version of the [`pathwayPCA` package](https://github.com/gabrielodom/pathwayPCA) from [GitHub](https://github.com/):

```
devtools::install_github("gabrielodom/pathwayPCA")
```

## Loading Packages

Also, if you want your analysis to be performed with parallel computing, you will need a package to help you. We recommend the `parallel` package (it comes with `R` automatically). We also recommend the `tidyverse` package to help you run some of the examples in these vignettes (while the `tidyverse` package suite is required for many of the examples in the vignettes, it is not required for any of the functions in this package).

```
install.packages("tidyverse")
```

```
library(parallel)
library(tidyverse)
library(pathwayPCA)
```

---

# 2. Import Data

This section is a quick overview of the material covered in the [Import and Tidy Data](https://gabrielodom.github.io/pathwayPCA/articles/Supplement2-Importing_Data.html) vignette. Here we show how to import pathway information, assay and phenotype data, and how to join the assay and phenotype data into one data frame.

## 2.1 Import `.gmt` Files

The `.gmt` format is a commonly used file format for storing [pathway information](https://software.broadinstitute.org/cancer/software/gsea/wiki/index.php/Data_formats#GMT:_Gene_Matrix_Transposed_file_format_.28.2A.gmt.29). Lists of pathways in the Molecular Signatures Database (MSigDB) can be downloaded from the [MSigDB Collections page](http://software.broadinstitute.org/gsea/msigdb/collections.jsp), and you can use the `read_gmt` function to import such a `.gmt` file into R. All `.gmt` files have a “description” field, which contains additional information on the pathway. However, this field can be left empty. In this example, we use `description = FALSE` to skip importing the “description” field.

```
gmt_path <- system.file("extdata", "c2.cp.v6.0.symbols.gmt",
                         package = "pathwayPCA", mustWork = TRUE)
cp_pathwayCollection <- read_gmt(gmt_path, description = FALSE)
cp_pathwayCollection
#> Object with Class(es) 'pathwayCollection', 'list' [package 'pathwayPCA'] with 2 elements:
#>  $ pathways:List of 1329
#>  $ TERMS   : chr [1:1329] "KEGG_GLYCOLYSIS_GLUCONEOGENESIS" ...
```

The imported `.gmt` file is stored as a `pathwayCollection` list object. This list contains:

* a list of the gene symbols or gene IDs contained in each pathway (`pathways`),
* the names of the pathways (`TERMS`), and
* (*OPTIONAL*) the description of each pathway (`description`). For Canonical Pathways files, if you specify `description = TRUE`, this is the hyperlink to the pathway description card on the GSEA website.

## 2.2 Import and Tidy Assay Data

We assume that the assay data (e.g. transcriptomic data) is either in an Excel file or flat text file. For example, your data may look like this:

![](data:image/png;base64...)

In this example data set, the columns are individual samples. The values in each row are the gene expression measurements for that gene. Use the `read_csv` function from the `readr` package to import `.csv` files into `R` as [tibble](https://cran.r-project.org/web/packages/tibble/vignettes/tibble.html) (table *and* data frame) objects. The `read_csv` function prints messages to the screen informing you of the assumptions it makes when importing your data. Specifically, this message tells us that all the imported data is numeric (`col_double()`) except for the gene name column (`X1 = col_character()`).

```
assay_path <- system.file("extdata", "ex_assay_subset.csv",
                          package = "pathwayPCA", mustWork = TRUE)
assay_df <- read_csv(assay_path)
#> New names:
#> Rows: 17 Columns: 37
#> ── Column specification
#> ──────────────────────────────────────────────────────── Delimiter: "," chr
#> (1): ...1 dbl (36): T21101311, T21101312, T21101313, T21101314, T21101315,
#> T21101316, ...
#> ℹ Use `spec()` to retrieve the full column specification for this data. ℹ
#> Specify the column types or set `show_col_types = FALSE` to quiet this message.
#> • `` -> `...1`
```

Incidentally, we consider gene symbols to adhere to the following conditions:

* gene symbols must start with an English letter (a-z or A-Z), and
* gene symbols can only contain English letters, Arabic numerals (0-9), and possibly a dash (-).

Furthermore, if your data has samples in the columns and -omic feature measurements in the rows (like the data set above), you’ll need to “tidy” the imported assay with the `TransposeAssay` function. The transposed data set will appear similar to the following:

```
assayT_df <- TransposeAssay(assay_df)
assayT_df
#> # A tibble: 36 × 18
#>    Sample    SOAT1   LSS  SQLE   EBP CYP51A1 DHCR7 CYP27B1 DHCR24 HSD17B7 MSMO1
#>    <chr>     <dbl> <dbl> <dbl> <dbl>   <dbl> <dbl>   <dbl>  <dbl>   <dbl> <dbl>
#>  1 T21101311  5.37  9.77  7.74  4.68    8.27  8.32    6.78   4.70    7.63  7.60
#>  2 T21101312  5.52  9.78  8.06  5.12    8.21  8.33    6.47   5.06    7.63  7.33
#>  3 T21101313  5.89  8.11  7.00  5.78    8.20  8.39    6.57   4.89    8.15  7.61
#>  4 T21101314  5.62  8.67  8.59  5.64    8.07  8.64    6.47   4.98    8.13  5.56
#>  5 T21101315  5.49  9.83  8.13  5.73    9.38  8.15    6.43   5.03    7.70  6.30
#>  6 T21101316  5.58  9.85  8.55  5.13    9.40  8.71    6.56   4.87    7.75  7.77
#>  7 T21101317  5.32 10.0   6.99  5.86    8.08  9.25    6.86   4.72    7.88  6.97
#>  8 T21101318  5.49  9.72  7.47  5.16    6.67  7.37    6.70   4.92    7.50  5.48
#>  9 T21101319  5.57  9.88  7.97  5.40    7.91  8.06    6.58   5.06    8.16  7.06
#> 10 T21101320  5.16  9.87  7.42  5.50    7.43  8.68    6.55   4.85    8.20  6.15
#> # ℹ 26 more rows
#> # ℹ 7 more variables: FDFT1 <dbl>, SC5DL <dbl>, LIPA <dbl>, CEL <dbl>,
#> #   TM7SF2 <dbl>, NSDHL <dbl>, SOAT2 <dbl>
```

## 2.3 Import Phenotype Info

Use the `read_csv` function to import the phenotype data. Once again, the `read_csv` function displays a message informing us of the types of data in each column. The following phenotype dataset for subject survival information contains the subject ID (`Sample`), survival time after disease onset in months (`eventTime`), and a logical (or binary) variable indicating if the subject died (`TRUE` or 1) or was lost to follow up (`eventObserved`; 0 or `FALSE`).

```
pInfo_path <- system.file("extdata", "ex_pInfo_subset.csv",
                          package = "pathwayPCA", mustWork = TRUE)
pInfo_df <- read_csv(pInfo_path)
#> Rows: 36 Columns: 3
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ","
#> chr (1): Sample
#> dbl (1): eventTime
#> lgl (1): eventObserved
#>
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
pInfo_df
#> # A tibble: 36 × 3
#>    Sample    eventTime eventObserved
#>    <chr>         <dbl> <lgl>
#>  1 T21101311     14.2  TRUE
#>  2 T21101312      1    TRUE
#>  3 T21101313      6.75 FALSE
#>  4 T21101314      8.5  TRUE
#>  5 T21101315      7.25 FALSE
#>  6 T21101316      5    TRUE
#>  7 T21101317     20    TRUE
#>  8 T21101318     13.2  FALSE
#>  9 T21101319      7.75 FALSE
#> 10 T21101320      9    FALSE
#> # ℹ 26 more rows
```

## 2.4 Match the Phenotype and Assay Data

Now that you have the assay data in tidy form (`assayT_df`) and the phenotype data (`pInfo_df`), you can use the `inner_join` function from the `dplyr` package to match the assay measurements to phenotype information by subject identifier.

```
exSurv_df <- inner_join(pInfo_df, assayT_df, by = "Sample")
exSurv_df
#> # A tibble: 36 × 20
#>    Sample  eventTime eventObserved SOAT1   LSS  SQLE   EBP CYP51A1 DHCR7 CYP27B1
#>    <chr>       <dbl> <lgl>         <dbl> <dbl> <dbl> <dbl>   <dbl> <dbl>   <dbl>
#>  1 T21101…     14.2  TRUE           5.37  9.77  7.74  4.68    8.27  8.32    6.78
#>  2 T21101…      1    TRUE           5.52  9.78  8.06  5.12    8.21  8.33    6.47
#>  3 T21101…      6.75 FALSE          5.89  8.11  7.00  5.78    8.20  8.39    6.57
#>  4 T21101…      8.5  TRUE           5.62  8.67  8.59  5.64    8.07  8.64    6.47
#>  5 T21101…      7.25 FALSE          5.49  9.83  8.13  5.73    9.38  8.15    6.43
#>  6 T21101…      5    TRUE           5.58  9.85  8.55  5.13    9.40  8.71    6.56
#>  7 T21101…     20    TRUE           5.32 10.0   6.99  5.86    8.08  9.25    6.86
#>  8 T21101…     13.2  FALSE          5.49  9.72  7.47  5.16    6.67  7.37    6.70
#>  9 T21101…      7.75 FALSE          5.57  9.88  7.97  5.40    7.91  8.06    6.58
#> 10 T21101…      9    FALSE          5.16  9.87  7.42  5.50    7.43  8.68    6.55
#> # ℹ 26 more rows
#> # ℹ 10 more variables: DHCR24 <dbl>, HSD17B7 <dbl>, MSMO1 <dbl>, FDFT1 <dbl>,
#> #   SC5DL <dbl>, LIPA <dbl>, CEL <dbl>, TM7SF2 <dbl>, NSDHL <dbl>, SOAT2 <dbl>
```

---

# 3. Create an `Omics` Data Object

This section is a quick overview of the material covered in the [Creating Data Objects](https://gabrielodom.github.io/pathwayPCA/articles/Supplement3-Create_Omics_Objects.html) vignette.

## 3.1 Create an Object

Using the data you just imported, create a data object specific to survival, regression, or categorical responses. For our example dataset, we will create a survival `Omics` object to hold our assay, pathways, and survival responses. If your indicator is a binary variable, the `CreateOmics` function will attempt to coerce it to a logical variable. Therefore, death indicators should be coded as 0-1, not 1-2.

This package includes a subject-matched colon cancer survival assay subset (`colonSurv_df`) and a toy pathway collection with 15 pathways (`colon_pathwayCollection`). When we create this `OmicsSurv` object, the `pathwayPCA` package checks the overlap between the -omes recorded in the assay data and the gene symbols in the supplied pathway collection. The `CreateOmics()` function also prints some diagnostic messages to inform you of how well your pathway collection overlaps your data.

```
data("colonSurv_df")
data("colon_pathwayCollection")

colon_OmicsSurv <- CreateOmics(
  assayData_df = colonSurv_df[, -(2:3)],
  pathwayCollection_ls = colon_pathwayCollection,
  response = colonSurv_df[, 1:3],
  respType = "survival"
)
#>
#>   ======  Creating object of class OmicsSurv  =======
#> The input pathway database included 676 unique features.
#> The input assay dataset included 656 features.
#> Only pathways with at least 3 or more features included in the assay dataset are
#>   tested (specified by minPathSize parameter). There are 15 pathways which meet
#>   this criterion.
#> Because pathwayPCA is a self-contained test (PMID: 17303618), only features in
#>   both assay data and pathway database are considered for analysis. There are 615
#>   such features shared by the input assay and pathway database.
```

## 3.2 Inspect the Object

After you create an `Omics` object, print the object to the screen to view a summary of the data contained therein.

```
colon_OmicsSurv
#> Formal class 'OmicsSurv' [package "pathwayPCA"] with 6 slots
#>   ..@ eventTime            : num [1:250] 64.9 59.8 62.4 54.5 46.3 ...
#>   ..@ eventObserved        : logi [1:250] FALSE FALSE FALSE FALSE TRUE FALSE ...
#>   ..@ assayData_df         : tibble [250 × 656] (S3: tbl_df/tbl/data.frame)
#>   ..@ sampleIDs_char       : chr [1:250] "subj1" "subj2" "subj3" "subj4" ...
#>   ..@ pathwayCollection    :List of 3
#>   .. ..- attr(*, "class")= chr [1:2] "pathwayCollection" "list"
#>   ..@ trimPathwayCollection:List of 4
#>   .. ..- attr(*, "class")= chr [1:2] "pathwayCollection" "list"
```

## 3.3 Detailed Object Views

Because the printing procedure for `Omics` objects is to show a summary of the contents, you need to use the `get*()` functions to view the individual components of the `colon_OmicsSurv` object we just created. Overall, you can use accessor functions to extract, edit, or replace data contained in the object. The accessor functions are listed in more detail in the [Table of Accessors](https://gabrielodom.github.io/pathwayPCA/articles/Supplement3-Create_Omics_Objects.html#table-of-accessors) subsection of Chapter 3. Use these functions to confirm that the data object you created accurately reflects the data you intend to analyze.

### 3.3.1 View the Assay

```
getAssay(colon_OmicsSurv)
#> # A tibble: 250 × 656
#>       JUN    SOS2   PAK3    RAF1  PRKCB    BTC      SHC1   PRKCA   ELK1    NRG1
#>     <dbl>   <dbl>  <dbl>   <dbl>  <dbl>  <dbl>     <dbl>   <dbl>  <dbl>   <dbl>
#>  1 -0.880  0.367   1.30   0.480  -0.867 -0.790 -0.284     0.0104  1.04   0.670
#>  2 -1.11   2.15    1.62   0.165   0.547 -0.261 -0.000491  1.18    1.49   1.30
#>  3 -0.752  0.764   0.330 -0.541   0.164  0.452  0.691    -0.950   0.667  0.128
#>  4  1.03  -0.751   2.75  -0.878  -1.09  -0.481 -1.34      1.52    2.23   3.65
#>  5 -1.73   0.613   2.66   0.550   0.197 -1.02   0.156    -1.29    1.68  -2.15
#>  6 -0.162  0.126  -0.324  0.627  -0.106 -1.17   1.11     -1.27    0.964  1.79
#>  7 -0.980 -0.520   1.28  -0.343  -0.762 -0.489 -0.257     0.0518  1.21  -0.312
#>  8  0.616  0.0633  0.343 -0.0195  0.578 -1.37   0.638     1.37    1.05  -0.703
#>  9  1.35  -0.467  -0.149 -0.718  -0.898  0.527 -0.0604    1.32   -1.000 -0.266
#> 10 -0.538  0.413  -0.503 -1.27   -0.466  0.178  0.345    -1.40   -0.378  0.0623
#> # ℹ 240 more rows
#> # ℹ 646 more variables: PAK2 <dbl>, MTOR <dbl>, PAK4 <dbl>, MAP2K4 <dbl>,
#> #   EIF4EBP1 <dbl>, BAD <dbl>, PRKCG <dbl>, NRG3 <dbl>, MAPK9 <dbl>,
#> #   ERBB4 <dbl>, MAPK10 <dbl>, PTK2 <dbl>, ERBB2 <dbl>, ERBB3 <dbl>,
#> #   MAP2K2 <dbl>, TGFA <dbl>, BRAF <dbl>, MAP2K1 <dbl>, MAP2K7 <dbl>,
#> #   ABL1 <dbl>, NRG2 <dbl>, AKT1 <dbl>, ABL2 <dbl>, AKT2 <dbl>, SHC4 <dbl>,
#> #   RPS6KB1 <dbl>, RPS6KB2 <dbl>, AKT3 <dbl>, NRAS <dbl>, GRB2 <dbl>, …
```

### 3.3.2 View the `pathwayCollection` List

```
getPathwayCollection(colon_OmicsSurv)
#> Object with Class(es) 'pathwayCollection', 'list' [package 'pathwayPCA'] with 3 elements:
#>  $ pathways:List of 15
#>  $ TERMS   : Named chr [1:15] "KEGG_PENTOSE_PHOSPHATE_PATHWAY" ...
#>  $ setsize : Named int [1:15] 27 64 ...
```

### 3.3.3 View the Event Time

We can use the vector subsetting mechanic in R (`vector[]`) to view only the first ten event times.

```
getEventTime(colon_OmicsSurv)[1:10]
#>  [1] 64.8657534 59.7698630 62.4000000 54.5095890 46.2904110 55.8575343
#>  [7] 57.9616438 54.0493151  0.4273973 41.4246575
```

### 3.3.4 View the Event Indicator

```
getEvent(colon_OmicsSurv)[1:10]
#>  [1] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE
```

---

# 4. Test Pathways for Significance

After you have confirmed that the `CreateOmics` function created the `Omics` object you wanted, you can analyze the object with adaptive, elastic-net, sparse (AES) PCA or supervised PCA. This section is a quick overview of the material covered in the [Test Pathway Significance](https://gabrielodom.github.io/pathwayPCA/articles/Supplement4-Methods_Walkthrough.html) vignette. For details of these methods functions, please see their respective sections in Chapter 4.

The function arguments are as follows. Both the `AESPCA_pVals` and `SuperPCA_pVals` functions take in an `Omics` object as the value to the `object` argument. AES-PCA can use permutation-based \(p\)-values, so the `numReps` argument controls how many permutations to take. If we set the number of permutations to 0, then the \(p\)-values will be calculated parametrically. The `numPCs` argument specifies how many principal components will be extracted from each pathway. The `parallel` and `numCores` arguments are used to control if and how the functions make use of parallel computing. Finally, the `adjustment` argument allows you to specify a family-wise error rate (FWER) or false discovery rate (FDR) adjustment for the pathway \(p\)-values. These options are documented in the `adjustRaw_pVals` function (see the [help documentation](https://gabrielodom.github.io/pathwayPCA/reference/adjustRaw_pVals.html) for details).

## 4.1 AES-PCA

Perform AES-PCA pathway significance testing on the `Omics` object with the `AESPCA_pVals` function. For more details on this function, see the [AES-PCA](https://gabrielodom.github.io/pathwayPCA/articles/Supplement4-Methods_Walkthrough.html#aes-pca) section of Chapter 4. We will adjust the pathway \(p\)-values by the estimated FDR calculated with the `"BH"` procedure (Benjamini and Hochberg, 1995).

```
colon_aespcOut <- AESPCA_pVals(
  object = colon_OmicsSurv,
  numReps = 0,
  numPCs = 2,
  parallel = TRUE,
  numCores = 2,
  adjustpValues = TRUE,
  adjustment = "BH"
)
#> Part 1: Calculate Pathway AES-PCs
#> Initializing Computing Cluster: DONE
#> Extracting Pathway PCs in Parallel: DONE
#>
#> Part 2: Calculate Pathway p-Values
#> Initializing Computing Cluster: DONE
#> Extracting Pathway p-Values in Parallel: DONE
#>
#> Part 3: Adjusting p-Values and Sorting Pathway p-Value Data Frame
#> DONE
```

## 4.2 Supervised PCA

Perform Supervised PCA pathway significance testing on the `Omics` object with the `SuperPCA_pVals` function. For more details on this function, see the [Supervised PCA](https://gabrielodom.github.io/pathwayPCA/articles/Supplement4-Methods_Walkthrough.html#supervised-pca) section of Chapter 4.

```
colon_superpcOut <- SuperPCA_pVals(
  object = colon_OmicsSurv,
  numPCs = 2,
  parallel = TRUE,
  numCores = 2,
  adjustpValues = TRUE,
  adjustment = "BH"
)
#> Initializing Computing Cluster: DONE
#> Calculating Pathway Test Statistics in Parallel: DONE
#> Calculating Pathway Critical Values in Parallel: DONE
#> Calculating Pathway p-Values: DONE
#> Adjusting p-Values and Sorting Pathway p-Value Data Frame: DONE
```

---

# 5. Inspect Results

This section is a quick overview of the material covered in the [Visualizing the Results](https://gabrielodom.github.io/pathwayPCA/articles/Supplement5-Analyse_Results.html) vignette. The output of `AESPCA_pVals()` is list object with class `aespcOut`. The output of `SuperPCA_pVals()` is a list object with class `superpcOut`. Both of these objects have the following three elements:

* `pVals_df`: a data frame with \(p\)-values and their details each pathway
* `PCs_ls`: a list of the data frames of the first selected principal component(s) extracted from the assay data subset corresponding to each pathway.
* `loadings_ls`: a list of the matrices of the loading vectors that correspond to the principal components in `PCs_ls`.

## 5.1 Analysis Output Table

For a quick and easy view of the pathway significance testing results, we can use the `getPathpVals()` function to access and subset the output data frame. If you are not using the `tidyverse` package suite, your results will print differently.

```
getPathpVals(colon_superpcOut)
#> # A tibble: 15 × 3
#>    terms                                                rawp      FDR_BH
#>    <chr>                                               <dbl>       <dbl>
#>  1 KEGG_ERBB_SIGNALING_PATHWAY                  0.0000000277 0.000000415
#>  2 PID_EPHB_FWD_PATHWAY                         0.000000259  0.00000141
#>  3 REACTOME_INSULIN_RECEPTOR_SIGNALLING_CASCADE 0.000000282  0.00000141
#>  4 KEGG_NON_SMALL_CELL_LUNG_CANCER              0.00000189   0.00000708
#>  5 BIOCARTA_TNFR1_PATHWAY                       0.0000694    0.000208
#>  6 KEGG_ASTHMA                                  0.000178     0.000445
#>  7 ST_GA12_PATHWAY                              0.000797     0.00171
#>  8 KEGG_RETINOL_METABOLISM                      0.00169      0.00314
#>  9 KEGG_PENTOSE_PHOSPHATE_PATHWAY               0.00188      0.00314
#> 10 REACTOME_SIGNALING_BY_INSULIN_RECEPTOR       0.0180       0.0270
#> 11 PID_TNF_PATHWAY                              0.0208       0.0283
#> 12 REACTOME_PHOSPHOLIPID_METABOLISM             0.0342       0.0427
#> 13 KEGG_ANTIGEN_PROCESSING_AND_PRESENTATION     0.0610       0.0703
#> 14 BIOCARTA_RELA_PATHWAY                        0.200        0.214
#> 15 BIOCARTA_SET_PATHWAY                         0.415        0.415
```

This function has the following modifying arguments:

* `score = FALSE`: . Return the raw \(p\)-values. Return the \(p\)-value score, \(-\log(p)\), instead of the unadjusted (raw) \(p\)-values with `score = FALSE`.
* `numPaths = 20`: Return the top 20 pathways by \(p\)-value score.
* `alpha = NULL`: Return all pathways with raw \(p\)-values less than `alpha`. If you specify `alpha`, then do not specify `numPaths`.

## 5.2 Graph of Top Pathways

To visualize the significance of the pathways based on FDR or uncorrected \(p\)-values, we can use the [`ggplot2` package](http://ggplot2.org/) to create summary graphics of the analysis results.

### 5.2.1 Tidy Up the Data

In order to take advantage of the publication-quality graphics created with the `ggplot2` package, we first need to tidy the data frames returned by the `AESPCA_pVals` and `SuperPCA_pVals` functions. The following code takes in the \(p\)-values data frame from the Supervised PCA method, modifies it to be compatible with the `ggplot` function, and saves the new data frame (`colonOutGather_df`).

```
colonOutGather_df <-
  getPathpVals(colon_superpcOut) %>%
  gather(variable, value, -terms) %>%
  mutate(score = -log(value)) %>%
  mutate(variable = factor(variable)) %>%
  mutate(variable = recode_factor(variable,
                                  rawp = "None",
                                  FDR_BH = "FDR"))

graphMax <- ceiling(max(colonOutGather_df$score))

colonOutGather_df
#> # A tibble: 30 × 4
#>    terms                                        variable        value score
#>    <chr>                                        <fct>           <dbl> <dbl>
#>  1 KEGG_ERBB_SIGNALING_PATHWAY                  None     0.0000000277 17.4
#>  2 PID_EPHB_FWD_PATHWAY                         None     0.000000259  15.2
#>  3 REACTOME_INSULIN_RECEPTOR_SIGNALLING_CASCADE None     0.000000282  15.1
#>  4 KEGG_NON_SMALL_CELL_LUNG_CANCER              None     0.00000189   13.2
#>  5 BIOCARTA_TNFR1_PATHWAY                       None     0.0000694     9.58
#>  6 KEGG_ASTHMA                                  None     0.000178      8.63
#>  7 ST_GA12_PATHWAY                              None     0.000797      7.14
#>  8 KEGG_RETINOL_METABOLISM                      None     0.00169       6.38
#>  9 KEGG_PENTOSE_PHOSPHATE_PATHWAY               None     0.00188       6.27
#> 10 REACTOME_SIGNALING_BY_INSULIN_RECEPTOR       None     0.0180        4.02
#> # ℹ 20 more rows
```

### 5.2.2 Graph Pathway Ranks

Now that our output is tidy, we can make a bar chart of the pathway significance based on the unadjusted \(p\)-values.

```
raw_df <- colonOutGather_df %>%
  filter(variable == "None") %>%
  select(-variable, -value)

ggplot(raw_df) +
  theme_bw() +
  aes(x = reorder(terms, score), y = score) +
  geom_bar(stat = "identity", position = "dodge", fill = "#005030") +
  scale_fill_discrete(guide = FALSE) +
  ggtitle("Supervised PCA Significant Colon Pathways") +
  xlab("Pathways") +
  scale_y_continuous("Negative Log p-Value", limits = c(0, graphMax)) +
  geom_hline(yintercept = -log(0.01), size = 2) +
  coord_flip()
#> Warning: The `guide` argument in `scale_*()` cannot be `FALSE`. This was deprecated in
#> ggplot2 3.3.4.
#> ℹ Please use "none" instead.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

---

# 6. Links to Detailed Information

Now that you have an idea of how to use this package, please see each of our vignettes for detailed and thorough commentary and guiding information on each of the three topics discussed herein. The vignettes are:

* [Chapter 2: Import Data](https://gabrielodom.github.io/pathwayPCA/articles/Supplement2-Importing_Data.html)
* [Chapter 3: Create `Omics` Data Objects](https://gabrielodom.github.io/pathwayPCA/articles/Supplement3-Create_Omics_Objects.html)
* [Chapter 4: Test Pathway Significance](https://gabrielodom.github.io/pathwayPCA/articles/Supplement4-Methods_Walkthrough.html)
* [Chapter 5: Visualizing the Results](https://gabrielodom.github.io/pathwayPCA/articles/Supplement5-Analyse_Results.html)

Here is the R session information for this vignette:

```
sessionInfo()
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
#> [1] parallel  stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] survminer_0.5.1   ggpubr_0.6.2      survival_3.8-3    pathwayPCA_1.26.0
#>  [5] lubridate_1.9.4   forcats_1.0.1     stringr_1.5.2     dplyr_1.1.4
#>  [9] purrr_1.1.0       readr_2.1.5       tidyr_1.3.1       tibble_3.3.0
#> [13] ggplot2_4.0.0     tidyverse_2.0.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6       xfun_0.53          bslib_0.9.0        rstatix_0.7.3
#>  [5] lattice_0.22-7     tzdb_0.5.0         vctrs_0.6.5        tools_4.5.1
#>  [9] generics_0.1.4     pkgconfig_2.0.3    Matrix_1.7-4       data.table_1.17.8
#> [13] RColorBrewer_1.1-3 S7_0.2.0           lifecycle_1.0.4    compiler_4.5.1
#> [17] farver_2.1.2       carData_3.0-5      htmltools_0.5.8.1  sass_0.4.10
#> [21] yaml_2.3.10        Formula_1.2-5      pillar_1.11.1      car_3.1-3
#> [25] crayon_1.5.3       jquerylib_0.1.4    cachem_1.1.0       abind_1.4-8
#> [29] nlme_3.1-168       km.ci_0.5-6        tidyselect_1.2.1   digest_0.6.37
#> [33] stringi_1.8.7      labeling_0.4.3     splines_4.5.1      fastmap_1.2.0
#> [37] grid_4.5.1         archive_1.1.12     cli_3.6.5          magrittr_2.0.4
#> [41] dichromat_2.0-0.1  utf8_1.2.6         broom_1.0.10       withr_3.0.2
#> [45] scales_1.4.0       backports_1.5.0    bit64_4.6.0-1      timechange_0.3.0
#> [49] rmarkdown_2.30     bit_4.6.0          gridExtra_2.3      ggsignif_0.6.4
#> [53] zoo_1.8-14         hms_1.1.4          evaluate_1.0.5     knitr_1.50
#> [57] KMsurv_0.1-6       mgcv_1.9-3         survMisc_0.5.6     lars_1.3
#> [61] rlang_1.1.6        xtable_1.8-4       glue_1.8.0         vroom_1.6.6
#> [65] jsonlite_2.0.0     R6_2.6.1
```