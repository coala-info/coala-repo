# Suppl. Ch. 3 - Creating Data Objects

#### Gabriel Odom

#### 2025-10-30

* [1. Overview](#overview)
  + [1.1 Outline](#outline)
  + [1.2 Import Data](#import-data)
* [2. `Omics`-Class Objects Defined](#omics-class-objects-defined)
  + [2.1 Class Overview](#class-overview)
  + [2.2 Review of Data Types in `R`](#review-of-data-types-in-r)
* [3. Create New `Omics` Objects](#create-new-omics-objects)
  + [3.1 Overview of Subtypes](#overview-of-subtypes)
  + [3.2 Create a Survival `Omics` Data Object](#create-a-survival-omics-data-object)
  + [3.3 View the New Object](#view-the-new-object)
  + [3.4 Regression and Classification `Omics` Data Objects](#regression-and-classification-omics-data-objects)
* [4. Inspecting and Editing `Omics`-Class Objects](#inspecting-and-editing-omics-class-objects)
  + [4.1 Example “Get” Function](#example-get-function)
  + [4.2 Example “Set” Function](#example-set-function)
  + [4.3 Table of Accessors](#table-of-accessors)
  + [4.4 Inspect the Updated `pathwayCollection` List](#inspect-the-updated-pathwaycollection-list)
* [5. Review](#review)

# 1. Overview

This vignette is the third chapter in the “Pathway Significance Testing with `pathwayPCA`” workflow, providing a detailed perspective to the [Creating Data Objects](https://gabrielodom.github.io/pathwayPCA/articles/Supplement1-Quickstart_Guide.html#create-an-omics-data-object) section of the Quickstart Guide. This vignette builds on the material covered in the [“Import and Tidy Data”](https://gabrielodom.github.io/pathwayPCA/articles/Supplement2-Importing_Data.html) vignette. This guide will outline the major steps needed to create a data object for analysis with the `pathwayPCA` package. These objects are called `Omics`-class objects.

## 1.1 Outline

Before we move on, we will outline our steps. After reading this vignette, you should be able to

1. Describe the data components within the `Omics` object class.
2. Create a few `Omics` objects.
3. Inspect and edit individual elements contained in these objects.

First, load the `pathwayPCA` package and the [`tidyverse` package suite](https://www.tidyverse.org/).

```
library(tidyverse)
library(pathwayPCA)
```

## 1.2 Import Data

Because this is the third chapter in the workflow, we assume that

1. Your assay is “tidy”.
2. Your gene pathways list is stored in a `pathwayCollection` object.
3. Your phenotype and assay data have already been ID-matched.

If you are unsure about any of the three points above (or you don’t know what these mean), please review the [Import and Tidy Data](https://gabrielodom.github.io/pathwayPCA/articles/Importing_Data.html) vignette first. It isn’t very long, but it will help you set up your data in the right way. If your data is not in the proper form, the steps in this vignette may be very difficult.

For the purpose of example, we will load some “toy” data: a combined assay / phenotype data frame and a `pathwayCollection` list. These objects already fit the three criteria above. This tidy data set has 656 gene expression measurements (columns) on 250 colon cancer patients (rows).

```
data("colonSurv_df")
colonSurv_df
#> # A tibble: 250 × 659
#>    sampleID OS_time OS_event   JUN  SOS2  PAK3  RAF1 PRKCB   BTC  SHC1 PRKCA
#>    <chr>      <dbl>    <int> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1 subj1     64.9          0  9.29  5.48  8.21  8.03  5.49  6.65  8.26  8.94
#>  2 subj2     59.8          0  9.13  6.35  8.33  7.94  6.26  7.02  8.39  9.61
#>  3 subj3     62.4          0  9.37  5.67  7.82  7.74  6.05  7.52  8.69  8.40
#>  4 subj4     54.5          0 10.6   4.94  8.79  7.64  5.37  6.87  7.81  9.80
#>  5 subj5     46.3          1  8.70  5.60  8.75  8.05  6.07  6.49  8.45  8.21
#>  6 subj6     55.9          0  9.78  5.36  7.56  8.07  5.90  6.39  8.87  8.22
#>  7 subj7     58.0          0  9.22  5.05  8.20  7.80  5.55  6.86  8.28  8.97
#>  8 subj8     54.0          0 10.3   5.33  7.82  7.89  6.27  6.25  8.66  9.71
#>  9 subj9      0.427        1 10.8   5.07  7.63  7.69  5.48  7.57  8.36  9.69
#> 10 subj10    41.4          0  9.52  5.50  7.48  7.53  5.71  7.33  8.54  8.14
#> # ℹ 240 more rows
#> # ℹ 648 more variables: ELK1 <dbl>, NRG1 <dbl>, PAK2 <dbl>, MTOR <dbl>,
#> #   PAK4 <dbl>, MAP2K4 <dbl>, EIF4EBP1 <dbl>, BAD <dbl>, PRKCG <dbl>,
#> #   NRG3 <dbl>, …
```

Notice that the assay and survival response information have already been merged, so we have two additional columns (for Overall Survival Time and its corresponding death indicator). We also have a small collection of 15 pathways which correspond to our example colon cancer assay.

```
data("colon_pathwayCollection")
colon_pathwayCollection
#> Object with Class(es) 'pathwayCollection', 'list' [package 'pathwayPCA'] with 2 elements:
#>  $ pathways:List of 15
#>  $ TERMS   : chr [1:15] "KEGG_PENTOSE_PHOSPHATE_PATHWAY" ...
str(colon_pathwayCollection$pathways, list.len = 10)
#> List of 15
#>  $ pathway3   : chr [1:27] "RPE" "RPIA" "PGM2" "PGLS" ...
#>  $ pathway60  : chr [1:64] "RPE65" "CYP3A5" "UGT2B28" "CYP4A11" ...
#>  $ pathway87  : chr [1:87] "JUN" "SOS2" "PAK3" "RAF1" ...
#>  $ pathway120 : chr [1:89] "HLA-DOA" "HLA-DOB" "KLRC3" "KLRD1" ...
#>  $ pathway176 : chr [1:54] "CASP9" "SOS2" "E2F1" "PRKCB" ...
#>  $ pathway177 : chr [1:30] "HLA-DRB4" "HLA-DRB5" "HLA-DOA" "HLA-DOB" ...
#>  $ pathway187 : chr [1:16] "IKBKG" "CHUK" "EP300" "RELA" ...
#>  $ pathway266 : chr [1:11] "PRF1" "DFFA" "DFFB" "HMGB2" ...
#>  $ pathway390 : chr [1:29] "JUN" "BAG4" "CASP8" "MAPK8" ...
#>  $ pathway413 : chr [1:23] "PLD1" "RAF1" "EPHB2" "VAV1" ...
#>   [list output truncated]
```

The pathway collection and tidy assay (with matched phenotype information) are all the information we need to create an `Omics`-class data object.

---

# 2. `Omics`-Class Objects Defined

Now that we have our data loaded, we can create an analysis object for the `pathwayPCA` package.

## 2.1 Class Overview

In this package, all primary input data will be in an `Omics` data object. There are three classes of `Omics*` objects, but one function (`CreateOmics`) creates all of them. Each class contains a tidy assay and `pathwayCollection` list. The classes differ in the type of response information they can hold. The classes, and their responses, are

1. `OmicsSurv`—a data object for survival information, which includes event time (the time of last follow-up with a subject) and event indicator (did the subject die, or was the observation right-censored).
2. `OmicsReg`—a data object for continuous responses (usually a linear regression response).
3. `OmicsCateg`—a data object for categorical responses, the dependent variable of a generalized linear model. Currently, we only support binary classification (through logistic regression).
4. `OmicsPathway`—a data object with no response. This is the “parent” class for the other three `Omics` classes.

## 2.2 Review of Data Types in `R`

Take a quick look back at the structure of our `colonSurv_df` object. We have a table data frame with the first two columns as subject response information and the rest as an expression design matrix. Look at the types of the columns of this data frame (the `<dbl>` and `<int>` tags directly under the column names): these tags tell us that the columns contain “double / numeric” (`dbl`) and “integer” (`int`) information. The other tags we could potentially see here are `<chr>` (character), `<lgl>` (logical), or `<fct>` (factor). These tags are important because they identify which “class” of data is in each column.

Here are some examples of how to change data between types. We inspect the first 10 entries of each object.

```
# Original integer column
head(colonSurv_df$OS_event, 10)
#>  [1] 0 0 0 0 1 0 0 0 1 0

# Integer to Character
head(as.character(colonSurv_df$OS_event), 10)
#>  [1] "0" "0" "0" "0" "1" "0" "0" "0" "1" "0"

# Integer to Logical
head(as.logical(colonSurv_df$OS_event), 10)
#>  [1] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE

# Integer to Factor
head(as.factor(colonSurv_df$OS_event), 10)
#>  [1] 0 0 0 0 1 0 0 0 1 0
#> Levels: 0 1
```

The `CreateOmics` function puts the response information into specific classes:

* Survival data is stored as a pair of `numeric` (time) and `logical` (death indicator) vectors.
* Regression data is stored in a `numeric` or `integer` vector.
* Binary classification data is stored in a `factor` vector.

These restrictions are on purpose: the internal data creation functions in the `pathwayPCA` package have very specific requirements about the types of data they take as inputs. This ensures the integrity of your data analysis.

---

# 3. Create New `Omics` Objects

## 3.1 Overview of Subtypes

All new `Omics` objects are created with the `CreateOmics` function. You should use this function to create `Omics`-class objects for survival, regression, or categorical responses. This `CreateOmics` function *internally* calls on a specific creation function for each response type:

* Survival response: the `CreateOmicsSurv()` function creates an `Omics` object with class `OmicsSurv`. This object will contain:
  + `eventTime`: a `numeric` vector of event times.
  + `eventObserved`: a `logical` vector of death (or other event) indicators. This format precludes the option of recurrent-event survival analysis.
  + `assayData_df`: a tidy `data.frame` or `tibble` of assay data. Rows are observations or subjects; the columns are -Omics measures (e.g. transcriptome). The column names *must* match a subset of the genes provided in the pathways list (in the `pathwayCollection` object).
  + `pathwayCollection`: a `list` of pathway information, as returned by the `read_gmt` function (see the [Import and Tidy Data](https://gabrielodom.github.io/pathwayPCA/articles/Importing_Data.html#the-read_gmt-function) vignette for more details). The names of the genes in these pathways *must* match a subset of the genes recorded in the assay data frame (in the `assayData_df` object).
* Regression response: the `CreateOmicsReg()` function creates an `Omics` object with class `OmicsReg`. This object will contain:
  + `response`: a `numeric` vector of the response.
  + `assayData_df`: a tidy `data.frame` or `tibble` of assay data, as described above.
  + `pathwayCollection`: a `list` of pathway information, as described above.
* Binary Classification response: the `CreateOmicsCateg()` function creates an `Omics` object with class `OmicsCateg`. In future versions, this function will be able to take in \(n\)-ary responses and ordered categorical responses, but we only support binary responses for now. This object will contain:
  + `response`: a `factor` vector of the response.
  + `assayData_df`: a tidy `data.frame` or `tibble` of assay data, as described above.
  + `pathwayCollection`: a `list` of pathway information, as described above.

In order to create example `Omics`-class objects, we will consider the overall patient survival time (and corresponding censoring indicator) as our survival response, the event time as our regression response, and event indicator as our binary classification response.

## 3.2 Create a Survival `Omics` Data Object

Now we are prepared to create our first survival `Omics` object for later analysis with either AES-PCA or Supervised PCA. Recall that the `colonSurv_df` data frame has the survival time in the first column, the event indicator in the second column, and the assay expression data in the subsequent columns. Therefore, the four arguments to the `CreateOmics` function will be:

* `assayData_df`: this will be only the *expression columns* of the `colonSurv_df` data frame (i.e. all but the first two columns). In `R`, we can remove the first two columns of the `colonSurv_df` data frame by negative subsetting: `colonSurv_df[, -(1:2)]`.
* `pathwayCollection_ls`: this will be the `colon_pathwayCollection` list object. Recall that you can import a `.gmt` file into a `pathwayCollection` object via the `read_gmt` function, or create a `pathwayCollection` list object by hand with the `CreatePathwayCollection` function.
* `response`: this will be the first two columns of the `colonSurv_df` data frame. The survival time stored in the `OS_time` column and the event indicator stored in the `OS_event` column.
* `respType`: this will be the word `"survival"` or an abbreviation of it.

Also, when you create an `Omics*`-class object, the `CreateOmics()` function prints helpful diagnostic messages about the overlap between the features in the supplied assay data and those in the pathway collection.

```
colon_OmicsSurv <- CreateOmics(
  assayData_df = colonSurv_df[, -(2:3)],
  pathwayCollection_ls = colon_pathwayCollection,
  response = colonSurv_df[, 1:3],
  respType = "surv"
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

The last three sentences inform you of how strong the overlap is between the genes measured in your data and the genes selected in your pathway collection. This messages tells us that 9% of the 676 total genes included in all pathways were not measured in the assay; zero pathways were removed from the pathways list for having too few genes after gene trimming; and the genes in the pathways list call for 93.8% of the 656 genes measured in the assay. The last number is the most important: it measures how well your pathway collection overlaps with the genes measured in your assay. This number should be as close to 100% as possible. These diagnostic messages depend on the overlap between the pathway collection and the assay, so these messages are response agnostic.

## 3.3 View the New Object

In order to view a summary of the contents of the `colon_OmicsSurv` object, you need simply to print it to the `R` console.

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

Also notice that the `CreateOmics()` function stores a “cleaned” copy of the pathway collection. The object creation functions within the `pathwayPCA` package subset the feature data frame by the genes in each pathway. Therefore, if we have genes in the pathways that are not recorded in the data frame, then we will necessarily create missing (`NA`) predictors. To circumvent this issue, we check if each gene in each pathway is recorded in the data frame, and remove from each pathway the genes for which the assay does not have recorded expression levels. However, if we remove genes from pathways which do not have recorded levels in the predictor data frame, we could theoretically remove all the genes from a given pathway. Thus, we also check to make sure that each pathway in the given pathways list still has some minimum number of genes present (defaulting to three or more) after we have removed genes without corresponding expression levels.

The `IntersectOmicsPwyCollct()` function performs these two actions simultaneously, and this function is called and executed automatically within the object creation step. This function removes the unrecorded genes from each pathway, trims the pathways that have fewer than the minimum number of genes allowed, and returns a “trimmed” pathway collection. If there are any pathways removed by this execution, the `pathways` list within the `trimPathwayCollection` object within the `Omics` object will have a character vector of the pathways removed stored as the `"missingPaths"` attribute. Access this attribute with the `attr()` function.

## 3.4 Regression and Classification `Omics` Data Objects

We create regression- and categorical-type `Omics` data objects identically to survival-type `Omics` objects. We will use the survival time as our toy regression response and the death indicator as the toy classification response.

```
colon_OmicsReg <- CreateOmics(
  assayData_df = colonSurv_df[, -(2:3)],
  pathwayCollection_ls = colon_pathwayCollection,
  response = colonSurv_df[, 1:2],
  respType = "reg"
)
#>
#>   ======  Creating object of class OmicsReg  =======
#> The input pathway database included 676 unique features.
#> The input assay dataset included 656 features.
#> Only pathways with at least 3 or more features included in the assay dataset are
#>   tested (specified by minPathSize parameter). There are 15 pathways which meet
#>   this criterion.
#> Because pathwayPCA is a self-contained test (PMID: 17303618), only features in
#>   both assay data and pathway database are considered for analysis. There are 615
#>   such features shared by the input assay and pathway database.
colon_OmicsReg
#> Formal class 'OmicsReg' [package "pathwayPCA"] with 5 slots
#>   ..@ response             : num [1:250] 64.9 59.8 62.4 54.5 46.3 ...
#>   ..@ assayData_df         : tibble [250 × 656] (S3: tbl_df/tbl/data.frame)
#>   ..@ sampleIDs_char       : chr [1:250] "subj1" "subj2" "subj3" "subj4" ...
#>   ..@ pathwayCollection    :List of 3
#>   .. ..- attr(*, "class")= chr [1:2] "pathwayCollection" "list"
#>   ..@ trimPathwayCollection:List of 4
#>   .. ..- attr(*, "class")= chr [1:2] "pathwayCollection" "list"
```

```
colon_OmicsCateg <- CreateOmics(
  assayData_df = colonSurv_df[, -(2:3)],
  pathwayCollection_ls = colon_pathwayCollection,
  response = colonSurv_df[, c(1, 3)],
  respType = "categ"
)
#>
#>   ======  Creating object of class OmicsCateg  =======
#> The input pathway database included 676 unique features.
#> The input assay dataset included 656 features.
#> Only pathways with at least 3 or more features included in the assay dataset are
#>   tested (specified by minPathSize parameter). There are 15 pathways which meet
#>   this criterion.
#> Because pathwayPCA is a self-contained test (PMID: 17303618), only features in
#>   both assay data and pathway database are considered for analysis. There are 615
#>   such features shared by the input assay and pathway database.
colon_OmicsCateg
#> Formal class 'OmicsCateg' [package "pathwayPCA"] with 5 slots
#>   ..@ response             : Factor w/ 2 levels "0","1": 1 1 1 1 2 1 1 1 2 1 ...
#>   ..@ assayData_df         : tibble [250 × 656] (S3: tbl_df/tbl/data.frame)
#>   ..@ sampleIDs_char       : chr [1:250] "subj1" "subj2" "subj3" "subj4" ...
#>   ..@ pathwayCollection    :List of 3
#>   .. ..- attr(*, "class")= chr [1:2] "pathwayCollection" "list"
#>   ..@ trimPathwayCollection:List of 4
#>   .. ..- attr(*, "class")= chr [1:2] "pathwayCollection" "list"
```

---

# 4. Inspecting and Editing `Omics`-Class Objects

In order to access or edit a specific component of an `Omics` object, we need to use specific *accessor* functions. These functions are named with the component they access.

## 4.1 Example “Get” Function

The `get*` functions access the part of the data object you specify. You can save these objects to their own variables, or simply print them to the screen for inspection. Here we print the assay data frame contained in the `colon_OmicsSurv` object to the screen:

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
#> #   ERBB4 <dbl>, …
```

This function is rather simple: it shows us what object is stored in the `assayData_df` slot of the `colon_OmicsSurv` data object. As we should expect, we see all the columns of the `colonSurv_df` data frame except for the first two (the survival time and event indicator).

## 4.2 Example “Set” Function

If we needed to edit the assay data frame in the `colon_OmicsSurv` object, we can use the “replacement” syntax of the `getAssay` function. These are the “set” functions, and they use the `getSLOT(object) <- value` syntax. For example, if we wanted to remove all of the genes except for the first ten from the assay data, we can replace this assay data with a subset of the the original `colonSurv_df` data frame. The `SLOT` shorthand name is `Assay`, and the replacement value is the first ten gene expression columns (in columns 3 through 12) of the `colonSurv_df` data frame: `colonSurv_df[, (3:12)]`.

```
getAssay(colon_OmicsSurv) <- colonSurv_df[, (3:12)]
```

Now, when we inspect the `colon_OmicsSurv` data object, we see only ten variables measured in the `assayData_df` slot, instead of our original 656.

```
colon_OmicsSurv
#> Formal class 'OmicsSurv' [package "pathwayPCA"] with 6 slots
#>   ..@ eventTime            : num [1:250] 64.9 59.8 62.4 54.5 46.3 ...
#>   ..@ eventObserved        : logi [1:250] FALSE FALSE FALSE FALSE TRUE FALSE ...
#>   ..@ assayData_df         : tibble [250 × 10] (S3: tbl_df/tbl/data.frame)
#>   ..@ sampleIDs_char       : chr [1:250] "subj1" "subj2" "subj3" "subj4" ...
#>   ..@ pathwayCollection    :List of 3
#>   .. ..- attr(*, "class")= chr [1:2] "pathwayCollection" "list"
#>   ..@ trimPathwayCollection:List of 4
#>   .. ..- attr(*, "class")= chr [1:2] "pathwayCollection" "list"
```

Before we move on, we should resest the data in the `assayData_df` slot to the full data by

```
getAssay(colon_OmicsSurv) <- colonSurv_df[, -(1:2)]
```

## 4.3 Table of Accessors

Here is a table listing each of the “get” and “set” methods for the `Omics` class, and which sub-classes they can access or modify.

| Command | `Omics` Sub-class | Function |
| --- | --- | --- |
| `getAssay(object)` | All | Extract the `assayData_df` data frame stored in `object`. |
| `getAssay(object) <- value` | All | Set `assayData_df` stored in `object` to `value`. |
| `getSampleIDs(object)` | All | Extract the `sampleIDs_char` vector stored in `object`. |
| `getSampleIDs(object) <- value` | All | Set `sampleIDs_char` stored in `object` to `value`. |
| `getPathwayCollection(object)` | All | Extract the `pathwayCollection` list stored in `object`. |
| `getPathwayCollection(object) <- value` | All | Set `pathwayCollection` stored in `object` to `value`. |
| `getEventTime(object)` | `Surv` | Extract the `eventTime_num` vector stored in `object`. |
| `getEventTime(object) <- value` | `Surv` | Set `eventTime_num` stored in `object` to `value`. |
| `getEvent(object)` | `Surv` | Extract the `eventObserved_lgl` vector stored in `object`. |
| `getEvent(object) <- value` | `Surv` | Set `eventObserved_lgl` stored in `object` to `value`. |
| `getResponse(object)` | `Reg` or `Categ` | Extract the `response` vector stored in `object`. |
| `getResponse(object) <- value` | `Reg` or `Categ` | Set `response` stored in `object` to `value`. |

The `response` vector accessed or edited with the `getResponse` method depends on if the `object` supplied is a “regression” `Omics`-class object or a “categorical” one. For regression `Omics` objects, `getResponse(object)` and `getResponse(object) <- value` get and set, respectively, the `response_num` slot. However, for categorical `Omics` objects, `getResponse(object)` and `getResponse(object) <- value` get and set, respectively, the `response_fact` slot. This is because regression objects contain `numeric` response vectors while categorical objects contain `factor` response vectors.

## 4.4 Inspect the Updated `pathwayCollection` List

As we mentioned in the [Importing with the `read_gmt` Function](https://gabrielodom.github.io/pathwayPCA/articles/Supplement2-Importing_Data.html#import-gmt-files-with-read_gmt) subsection of the previous vignette, the `pathwayCollection` object will be modified upon `Omics`-object creation. Before, this list only had two elements, `pathways` and `TERMS` (we skipped importing the “description” field). Now, it has a third element: `setsize`—the number of genes contained in each pathway.

```
getPathwayCollection(colon_OmicsSurv)
#> Object with Class(es) 'pathwayCollection', 'list' [package 'pathwayPCA'] with 3 elements:
#>  $ pathways:List of 15
#>  $ TERMS   : Named chr [1:15] "KEGG_PENTOSE_PHOSPHATE_PATHWAY" ...
#>  $ setsize : Named int [1:15] 27 64 ...
```

---

# 5. Review

We now summarize our steps so far. We have

1. Defined the `Omics` class and three sub-classes: survival, regression, and categorical (and the “parent” class).
2. Created an `Omics` object for the three sub-classes.
3. Inspected and edited individual elements contained in these objects.

Now we are prepared to analyze our created data objects with either AES-PCA or Supervised PCA. Please read vignette chapter 4 next: [Test Pathway Significance](https://gabrielodom.github.io/pathwayPCA/articles/Supplement4-Methods_Walkthrough.html).

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
#> [1] stats4    parallel  stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#>  [1] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [3] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [5] IRanges_2.44.0              S4Vectors_0.48.0
#>  [7] BiocGenerics_0.56.0         generics_0.1.4
#>  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [11] survminer_0.5.1             ggpubr_0.6.2
#> [13] survival_3.8-3              pathwayPCA_1.26.0
#> [15] lubridate_1.9.4             forcats_1.0.1
#> [17] stringr_1.5.2               dplyr_1.1.4
#> [19] purrr_1.1.0                 readr_2.1.5
#> [21] tidyr_1.3.1                 tibble_3.3.0
#> [23] ggplot2_4.0.0               tidyverse_2.0.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1    farver_2.1.2        S7_0.2.0
#>  [4] fastmap_1.2.0       digest_0.6.37       timechange_0.3.0
#>  [7] lifecycle_1.0.4     magrittr_2.0.4      compiler_4.5.1
#> [10] rlang_1.1.6         sass_0.4.10         tools_4.5.1
#> [13] utf8_1.2.6          yaml_2.3.10         data.table_1.17.8
#> [16] knitr_1.50          ggsignif_0.6.4      S4Arrays_1.10.0
#> [19] labeling_0.4.3      bit_4.6.0           DelayedArray_0.36.0
#> [22] RColorBrewer_1.1-3  abind_1.4-8         withr_3.0.2
#> [25] grid_4.5.1          lars_1.3            xtable_1.8-4
#> [28] scales_1.4.0        dichromat_2.0-0.1   cli_3.6.5
#> [31] rmarkdown_2.30      crayon_1.5.3        km.ci_0.5-6
#> [34] tzdb_0.5.0          cachem_1.1.0        splines_4.5.1
#> [37] XVector_0.50.0      survMisc_0.5.6      vctrs_0.6.5
#> [40] Matrix_1.7-4        jsonlite_2.0.0      carData_3.0-5
#> [43] car_3.1-3           hms_1.1.4           bit64_4.6.0-1
#> [46] rstatix_0.7.3       archive_1.1.12      Formula_1.2-5
#> [49] jquerylib_0.1.4     glue_1.8.0          stringi_1.8.7
#> [52] gtable_0.3.6        pillar_1.11.1       htmltools_0.5.8.1
#> [55] R6_2.6.1            KMsurv_0.1-6        vroom_1.6.6
#> [58] evaluate_1.0.5      lattice_0.22-7      backports_1.5.0
#> [61] broom_1.0.10        bslib_0.9.0         SparseArray_1.10.0
#> [64] gridExtra_2.3       nlme_3.1-168        mgcv_1.9-3
#> [67] xfun_0.53           zoo_1.8-14          pkgconfig_2.0.3
```