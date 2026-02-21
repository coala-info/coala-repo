# signeRFlow

#### Alexandre Defelicibus

#### 2025-10-30

# 1 Introduction

signeRFlow is a shiny app that allows users to explore mutational signatures and exposures to related mutational processes embedded into signeR package. With the available modules, users are able to perform analysis on their own data by applying different approaches, such as *de novo* and fitting. Also, there is a module to explore public datasets from TCGA.

## 1.1 Install signeR

In order to use signeRFlow app, you must have signeR package installed. To install **signeR**, open R and enter:

```
install.packages("BiocManager")
BiocManager::install("signeR")
```

## 1.2 Running shiny app

Start the app using either RStudio or a terminal:

```
library(signeR)
signeRFlow()
```

The app will open on a new window or on a tab in your browser.

![](data:image/png;base64...)

# 2 Modules

There are three available modules in the app:

* signeR *de novo*: This module provides access to signeR *de novo* analysis to find signatures in your data, estimating both signatures and related exposures.
* signeR fitting: This module provides access to signeR fitting analysis to find exposures to known signatures in your data, which can be uploaded or chosen from Cosmic database. Exposures are estimated and can be explored.
* TCGA explorer: This module provides access to the results of signeR applications to 33 datasets from TCGA.

You can go through the modules independently by using the app sidebar.

## 2.1 signeR de novo

In this module, you can upload an SNV matrix with counts of mutations and execute the signeR *de novo* algorithm, which computes a Bayesian approach to the non-negative factorization (NMF) of the mutation counts in a matrix product of mutational signatures and exposures to mutational processes.

You can also provide a file with opportunities that are used as weights for the factorization. Further analysis parameters can be set, results can be visualized on different plots and found signatures can be compared to the ones in Cosmic database interactively.

### 2.1.1 Load data

You can upload a VCF, MAF or an SNV matrix file (mandatory) with your own samples to use in signeR **de novo** module. You can upload an opportunity file as well or use an already built genome opportunity (hg19 or hg38 only). Also, you can upload a BED file to build an opportunity matrix.

#### 2.1.1.1 VCF, MAF or SNV Matrix

You can upload a VCF, MAF or an SNV matrix file from your computer by clicking on the *Browse button*.

![](data:image/png;base64...)

SNV matrix is a text file with a (tab-delimited) matrix of SNV counts found on analyzed genomes. It must contain one row for each sample and 97 columns, the first one with sample IDs and, after that, one column for each mutation type. Mutations should be specified in the column names (headers), by both the base change and the trinucleotide context where it occurs (for example: C>A:ACA). The table below shows an example of the SNV matrix structure.

|  | C>A:ACA | C>A:ACC | C>A:ACG | C>A:ACT | C>A:CCA | … | T>G:TTT |
| --- | --- | --- | --- | --- | --- | --- | --- |
| PD3851a | 31 | 34 | 9 | 21 | 24 | … | 21 |
| PD3904a | 110 | 91 | 9 | 87 | 108 | … | 77 |
| … | … | … | … | … | … | … | … |
| PD3890a | 122 | 112 | 13 | 107 | 99 | … | 50 |

If you want to upload a VCF or MAF file, you must select the genome build used on your variant calling analysis to allow signeR to generate an SNV matrix of counts. Also, you can generate an SNV matrix from a VCF or a MAF file using the methods:

```
genCountMatrixFromVcf
genCountMatrixFromMAF
```

from signeR package. See the [documentation](https://bioconductor.org/packages/release/bioc/vignettes/signeR/inst/doc/signeR-vignette.html#toc3) for more details.

> **`Warning`**:
>
> You must have installed the needed genomes from `BSgenome` package in order to use the VCF or MAF upload option.

**Columns:**

The first column needs to contain the sample ID and other columns contain the 96 trinucleotide contexts.

**Rows:**

Each row contains the sample ID and the counts for each trinucleotide contexts.

**Example file:**

[21 breast cancer](https://raw.githubusercontent.com/TojalLab/signeR/devel/inst/extdata/21_breast_cancers.mutations.txt) [VCF example](https://raw.githubusercontent.com/TojalLab/signeR/devel/inst/extdata/example.vcf) [MAF example](https://raw.githubusercontent.com/TojalLab/signeR/devel/inst/extdata/example.maf)

#### 2.1.1.2 Opportunity matrix

You can upload an Opportunity matrix file or a BED file from your computer by clicking at the **Browse button**. Also, you can use an already built genome opportunity for human reference genomes hg19 or hg38. This is an optional file.

![](data:image/png;base64...)

Opportunity matrix is a tab-delimited text file with a matrix of counts of trinucleotide contexts found in studied genomes. It must structured as the SNV matrix, with mutations specified on the head line (for each SNV count, the Opportunity matrix shows the total number of genomic loci where the refereed mutation could have occurred). The table below shows an example of the opportunity matrix structure.

| 366199887 | 211452373 | 45626142 | 292410567 | 335391892 | 239339768 | … | 50233875 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 202227618 | 116207171 | 25138239 | 161279580 | 184193767 | 131051208 | … | 177385805 |
| 225505378 | 130255706 | 28152934 | 179996700 | 206678032 | 147634427 | … | 199062504 |
| 425545790 | 245523433 | 53437284 | 339065644 | 389386002 | 278770926 | … | 375075216 |
| 452332390 | 259934779 | 55862550 | 361010972 | 412168035 | 292805460 | … | 396657807 |

If you want to upload a BED file, you must select the genome build used on your analysis to allow signeR to generate the opportunities for your regions file. Also, you can generate an opportunity matrix from the reference genome using the method:

```
genOpportunityFromGenome
```

from signeR package. See the [documentation](https://bioconductor.org/packages/release/bioc/vignettes/signeR/inst/doc/signeR-vignette.html#toc3) for more details.

> **`Warning`**:
>
> You must have installed the needed genomes from `BSgenome` package in order to use the BED upload.

**Columns:**

There is no header in this file and each column represents a trinucleotide context.

**Rows:**

Each row contains the count frequency of the trinucleotides in the whole analyzed region for each sample.

**Example file:**

[21 breast cancer](https://raw.githubusercontent.com/TojalLab/signeR/devel/inst/extdata/21_breast_cancers.opportunity.txt)

### 2.1.2 de novo analysis

There are some parameters that you can define before running the analysis by clicking at **Start de novo analysis** button:

![](data:image/png;base64...)

Parameters:

**Number of signatures**:

define the minimal and maximal numbers of signatures you want that signeR estimates.

**EM**:

number of iterations performed to estimate the hiper-hiper parameters of signeR model. Ignored if previously computed values are used for those parameters (fast option).

**Warm-up**:

number of Gibbs sampler iterations performed in warming phase, before signeR assumes that the model has converged.

**Final**:

number of final Gibbs sampler iterations used to estimate signatures and exposures.

During the execution, a message will appear on the screen showing the progress. After, you can download the results by clicking the button **Download Rdata** below the button **Start de novo analysis** and can iterate with all available plots in signeR package.

### 2.1.3 cosmic cosine

signeRFlow uses COSMIC v3.2 to calculate the cosine distance between found signatures and those present in COSMIC. A heatmap will be shown in the **COSMIC Comparison** section of *de novo* tab.

## 2.2 signeR fitting

In this module, you can upload a VCF, MAF or an SNV matrix file with counts of mutations, the same as used on *de novo* module, and a previous signatures file with known signatures to execute the signeR fitting algorithm, which computes a Bayesian approach to the fitting of mutation counts to known mutational signatures, thus estimating exposures to mutational processes.

You can also provide a file with opportunities or use an already built genome opportunity (hg19 or hg38 only) that is used as weights for the factorization. Further analysis parameters can be set and estimated exposures can be visualized on different plots interactively.

### 2.2.1 Load data

You can upload a VCF, MAF or an SNV matrix file with your own samples to use in signeR fitting module and previous known signatures (mandatories files). You can upload an opportunity file as well. SNV or VCF or MAF and opportunity matrix are the same as used on *de novo* module.

#### 2.2.1.1 SNV matrix

This is the same file used on **de novo** module.

#### 2.2.1.2 Opportunity matrix

This is the same file used on **de novo** module.

#### 2.2.1.3 Previous signatures

You can upload a Previous signatures matrix file from your computer by clicking at the *Browse button*. ![](data:image/png;base64...)

Previous signatures is a tab-delimited text file with a matrix of previously known signatures. It must contain one column for each signature and one row for each of the 96 SNV types (considering trinucleotide contexts). Mutation types should be contained in the first column, in the same form as the column names of the SNV matrix. The table below shows an example of the previous signatures matrix structure.

|  | Signature 2 | Signature 3 | Signature 5 | Signature 6 | … | Signature 8 |
| --- | --- | --- | --- | --- | --- | --- |
| C>A:ACA | 0.01110 | 0.00067 | 0.02218 | 0.01494 | … | 0.03672 |
| C>A:ACC | 0.00915 | 0.00062 | 0.01788 | 0.00896 | … | 0.03324 |
| C>A:ACG | 0.00150 | 0.00010 | 0.00213 | 0.00221 | … | 0.00252 |
| … | … | … | … | … | … | … |
| T>G:TTT | 0.00403 | 2.359E-05 | 0.0130 | 0.01337 | … | 0.00722 |

**Columns:**

The first column needs to contain the trinucleotide contexts and other columns contain the known signatures.

**Rows:**

Each row contains the expected frequency of the given mutation in the appointed trinucleotide context.

**Example file:**

[21 breast cancer](https://raw.githubusercontent.com/TojalLab/signeR/devel/inst/extdata/Cosmic_signatures_BRC.txt)

### 2.2.2 Fitting analysis

There are some parameters that you can define before running the analysis by clicking at **Start Fitting analysis** button:

![](data:image/png;base64...)

Parameters:

**EM**:

number of iterations performed to estimate the hiper-hiper parameters of signeR model. Ignored if previously computed values are used for those parameters (fast option).

**Warm-up**:

number of Gibbs sampler iterations performed in the warming phase, before signeR assumes that the model has converged.

**Final**:

number of final Gibbs sampler iterations used to estimate signatures and exposures.

During the execution, a message will appear on the screen showing the progress. After, you can download the results by clicking the button **Download Rdata** below the button **Start Fitting analysis** and can iterate with all available plots in signeR package.

## 2.3 Downstream analysis

Available in all modules, you can perform downstream analysis using *de novo* or fitting results with your own data, or in the TCGA Explorer module.

There are two main downstream analyses:

* **Clustering**
  + *Hierarchical Clustering*: signeRFlow generates a dendrogram for each generated sample of the exposure matrix. Consensus results, i.e. branches that are recurrently found, are reported. Different distance metrics and clustering algorithms are available to be selected.
  + *Fuzzy Clustering*: signeRFlow can apply the Fuzzy C-Means Clustering on each generated sample of the exposure matrix. Pertinence levels of samples to clusters are averaged over different runs of the algorithm. Means are considered as the final pertinence levels and are shown in a heatmap.
  + **Covariate**
    - *Categorical feature*: differences in exposures among groups can be analyzed and if some of the samples are unlabeled they can be labeled based on the similarity of their exposure profiles to those of labeled samples.
    - *Continuous feature*: its correlation to estimated exposures can be evaluated.
    - *Survival feature*: survival data can also be analyzed and the relation of signatures to survival can be accessed.

You can access these analyses in all modules using the tabs *Clustering* and *Covariate*.

### 2.3.1 Clustering

**Hierarchical Clustering**

By using the Hierarchical clustering section, you can select different dist and hclust methods: ![](data:image/png;base64...)

![](data:image/png;base64...)

When you select a new dist or hclust method, the dendrogram plot is updated.

**Fuzzy Clustering**

By using the Fuzzy clustering section, you can set the number of groups or let the algorithm estimate (Set groups to 1) and click on the **Run fuzzy** to start the analysis:

![](data:image/png;base64...)

During the execution, a message will be shown on the screen showing the progress.

> Warning: Fuzzy clustering can be a long process and demands high computer resources.

The output of Fuzzy clustering is shown as a heatmap plot.

### 2.3.2 Covariate

To perform a Covariate analysis on signeRFlow, you must upload a clinical data, a tab-delimited file with samples in rows and features in columns. You can upload a file by clicking on the **Browse…** button:

![](data:image/png;base64...)

Clinical data is a tab-delimited text file with a matrix of available metadata (clinical and/or survival) for each sample. It must have a first column of sample IDs, named **“SampleID”**, whose entries match the row names of the **SNV matrix**. The number and title of the remaining columns are optional, however if **survival** data is included it must be organized in a column named **time** (in months) and another named **status** (which contains 1 for death events and 0 for censored samples). The table below shows an example of the clinical data matrix structure.

| SampleID | gender | ajcc\_pathologic\_stage | ethnicity | race | status | time |
| --- | --- | --- | --- | --- | --- | --- |
| PD3851a | male | Stage I | not Hispanic or Latino | white | 0 | 236 |
| PD3890a | male | Stage II | not Hispanic or Latino | black or African-American | 1 | 199 |
| PD3904a | female | Stage II | NA | NA | 0 | 745 |
| PD3905a | female | Stage IV | NA | white | 1 | 299 |
| PD3945a | male | Stage IV | not Hispanic or Latino | Asian | 0 | 799 |

**Columns:**

The first column must contain the sample ID. Other columns may contain sample groupings or other features that you would like to co-analyze with exposure data.

**Rows:**

Each row contains clinical information for one sample: its ID and all other data of interest.

**Example file:**

[21 breast cancer](https://raw.githubusercontent.com/TojalLab/signeR/devel/inst/extdata/clinical-test-signerflow.tsv)

After the upload, a description table summarizes the data with all the features in rows, and the class, counts and missing data for each feature. By selecting a feature (row) at the table, a small panel is shown next to the table summarizing the values, categorical or continuous, for the selected feature:

![](data:image/png;base64...)

According to the class of the feature, a set of analysis are available in the **Plots** section:

* *Categorical feature*:

  ![](data:image/png;base64...) **Differential Exposure Analysis**: highlight signatures that are differentially active among groups of samples.

  ![](data:image/png;base64...) **Sample Classification**: classify samples based on their exposures to mutational processes.

  + *Numeric feature*:

    ![](data:image/png;base64...) **Correlation Analysis**: evaluate feature correlation to exposures to mutational signatures.

    ![](data:image/png;base64...) **Linear Regression**: relevance of exposures in final model of provided feature.
  + *Survival feature*:

    ![](data:image/png;base64...) **Survival analysis**: evaluate the effect of exposure on survival.

    ![](data:image/png;base64...) **Cox Regression**: evaluate the combined effect on survival of exposure levels to different signatures.

Some analyses also offer few parameters to perform the analysis.

# 3 TCGA Explorer

Instead of uploading a private dataset, signeRFlow allows you to explore exposure data previously estimated for samples on TCGA public datasets. We executed signeR algorithm previously applied to genome samples from 33 cancer types and estimated mutational signatures and exposures were obtained for each cancer type. Also, known signatures from Cosmic database were fitted to TCGA mutation data, thus estimating related exposures on each cancer type.

You can select the cancer type of interest and the analysis type on the sidebar. Also, samples can be filtered according to available features in the metadata.

![](data:image/png;base64...)

The first time you click on the button **TCGA Explorer** on the sidebar, signeRFlow will download all the necessary files (RData) according to cancer study and analysis type.

> Warning: The files are often small, but depending on the cancer study, this process can take a while. A message will show the download and rendering progress.

## 3.1 Filter dataset

Using the data summary table with all clinical data features downloaded from TCGA, you can select a feature to filter the dataset. According to the feature class, different options to filter will be shown.

It is not mandatory to filter the dataset, you can use all the cases. The aim of this resource is to allow you to explore the dataset and select the cases you work with.

> Note: If you filter a dataset using the data summary table, it will be used on the downstream analysis, such as clustering and covariate.

As an example, we selected the feature *ajcc\_pathologic\_stage* from ACC cancer type and *de novo* analysis:

![](data:image/png;base64...)

and applied the filter on the dataset, selecting only groups Stage I and Stage II:

![](data:image/png;base64...)

For each change in features and filters, the available plots are updated according to the filtered samples.

## 3.2 Covariate analysis

Similar to signeR analysis modules, the downstream analysis **Clustering** and **Covariate** are available on TCGA Explorer module and work the same, but you do not need to upload clinical data to this module.

As a reminder, at the top of **Covariate** tab you will see an information about the dataset and used filters.

![](data:image/png;base64...)

You can select a feature in the data summary table and perform a covariate analysis according to the feature class.

# 4 SessionInfo

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> loaded via a namespace (and not attached):
#>  [1] digest_0.6.37     R6_2.6.1          fastmap_1.2.0     xfun_0.53
#>  [5] cachem_1.1.0      knitr_1.50        htmltools_0.5.8.1 rmarkdown_2.30
#>  [9] lifecycle_1.0.4   cli_3.6.5         sass_0.4.10       jquerylib_0.1.4
#> [13] compiler_4.5.1    tools_4.5.1       evaluate_1.0.5    bslib_0.9.0
#> [17] yaml_2.3.10       rlang_1.1.6       jsonlite_2.0.0
```