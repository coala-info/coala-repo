# cbaf: an automated, easy-to-use R package for comparing omic data across multiple cancers / a cancer’s subgroups

Arman Shahrisa

#### 2025-10-29

# Contents

* [1 Introduction](#introduction)
* [2 Package Installation](#package-installation)
* [3 How to Use the *cbaf*](#how-to-use-the-cbaf)
  + [3.1 main Functions](#main-functions)
    - [3.1.1 availableData()](#availabledata)
    - [3.1.2 cleanDatabase()](#cleandatabase)
    - [3.1.3 processOneStudy()](#processonestudy)
    - [3.1.4 processMultipleStudies()](#processmultiplestudies)
  + [3.2 Five dependant Functions](#five-dependant-functions)
    - [3.2.1 obtainOneStudy()](#obtainonestudy)
    - [3.2.2 obtainMultipleStudies()](#obtainmultiplestudies)
    - [3.2.3 automatedStatistics()](#automatedstatistics)
    - [3.2.4 heatmapOutput()](#heatmapoutput)
    - [3.2.5 xlsxOutput()](#xlsxoutput)

# 1 Introduction

`cbaf` is a *Bioconductor* package that facilitates working with the high-throughput data stored on <http://www.cbioportal.org/>. The official CRAN package that is designed for obtaining data from cBioPortal in R, is `cgdsr`. To obtain data with this package, users have to pass a multistep procedure. Besides, the index of cancers and their subgroups changes frequently, which in turn, requires changing the R code. cbaf makes this procedure automated for **RNA-Seq**, **microRNA-Seq**, **microarray** and **methylation** data. In addition, comparing the genetic data across multiple cancer studies/subgroups of a cancer study becomes much faster and easier. The results are stored as excel file(s) and multiple heatmaps.

# 2 Package Installation

The package can be installed via `BiocManager::install`:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("cbaf", dependencies = TRUE)
```

After that, the pachage can be loaded into *R* workspace by

```
library(cbaf)
```

# 3 How to Use the *cbaf*

The package contains seven low-level functions: `availableData()`, `obtainOneStudy()`, `obtainMultipleStudies()`, `automatedStatistics()`, `heatmapOutput()`, `xlsxOutput()` and `cleanDatabase()`.

In addition, there are also two high-level functions, `processOneStudy()` and `processMultipleStudies()`, that execute some of the mentioned functions in an ordered manner to speed up the overal process.

It is recommended that users only work with two low-level functions - `availableData()` and `cleanDatabase()` - directly, since they are independant of other low-level functions. For the rest, please use high-level functions instead. This allows all functions to work with a higher efficiency.

## 3.1 main Functions

### 3.1.1 availableData()

This function scans all the cancer studies to examine presence of *RNA-Seq*, *RNA-SeqRelativeToNormalSapmles*, *microRNA-Seq*, *microarray* and *methylation* data. It requires a name to label the output excel file. In the following example, the entered name is `"list.2020-05-05"`.

It contains one optional argument:

* **oneOfEach**, a character vector that contains name of a supported technique that includes `RNA-Seq`, `RNA-SeqRTN`, `microRNA-Seq`, `Microarray.mRNA` `Microarray.microRNA` or `methylation`. The default value in FALSE. Note that, if this option is selected, the function will select one cancer of each type that contains the requested data. Output will also be printed on console instead of generating an excel file. Therefore, it is mandatory that user assigns the output to a variable of interest: `cancer_names <- availableData("list.2020-05-05", oneOfEach = "RNA-Seq")`

```
availableData("list.2020-05-05")
```

Upon finishing, the output excel file is accessible at the present (working) directory. It contains different columns: cancer\_study\_id, cancer\_study\_name, RNA.Seq, microRNA.Seq, microarray of mRNA, microarray of miRNA, methylation and description.

if there is already an excel file with the given name in the working directory, the function prints a message, asking the user whether or not it should proceeds. If the answer is no, the function prints a message to inform the user that it has stopped further processing. If the user types yes, `availableData()` will overwrite the excel file after it has obtained the requested data.

### 3.1.2 cleanDatabase()

This function removes the created databases in the cbaf package directory. This helps users to obtain the fresh data from cbioportal.org.

It contains one optional argument:

* **databaseNames**, a character vector that contains name of databases that will be removed. The default value in null.

In the following example, *databaseNames* is `Whole2`.

```
cleanDatabase("Whole2")
```

If the *databaseNames* left unentered, the function will print the available databases and allow the user to choose the desired ones.

### 3.1.3 processOneStudy()

This function combines four other functions for the ease of use. It is recommended that users only use this parent function to obtain and process gene data across multiple subsections of a cancer study so that child functions work with maximum efficiency. `processOneStudy()` uses the following functions:

* **obtainOneStudy()**
* **automatedStatistics()**
* **heatmapOutput()**
* **xlsxOutput()**

It requires at least four arguments. All function arguments are the same as low-level functions:

* **genesList**, a list that contains at least one gene group. There is no limit on the number of gene groups, users can set as many as gene groups they desire.
* **submissionName**, a character string containing name of interest. It is used for naming the process and should be the same as submissionName for either of `obtainOneStudy()` or `obtainMultipleStudies()` functions.
* **studyName**, a character string showing the desired cancer name. It is an standard cancer study name that exists on cbioportal.org, such as `Acute Myeloid Leukemia (TCGA, NEJM 2013)`.
* **desiredTechnique**, one of the five supported high-throughput studies. RNA-Seq data can be accessed either as relative to all samples or relative to normal samples: `RNA-Seq`, `RNA-SeqRTN`, `microRNA-Seq`, `microarray.mRNA`, `microarray.microRNA` or `methylation`.

Function also contains nineteen other options:

* **desiredCaseList** a numeric vector that contains the index of desired cancer subgroups, assuming the user knows index of desired subgroups. If not, desiredCaseList must be set as ‘none’, function will show the available subgroups asking the user to enter the desired ones during the process. The default value is ‘none’.
* **validateGenes** a logical value that, if set to be `TRUE`, function will check each cancer subgroup to find whether or not every gene has a record. If the subgroup doesn’t have a record for the specific gene, function checks for alternative gene names that cbioportal might use instead of the given gene name.
* **calculate**, a character vector that contains the desired statistical procedures. Default input is `c("frequencyPercentage", "frequencyRatio", "meanValue")`. To get all the statistics, use the following instead: `c("frequencyPercentage", "frequencyRatio", "meanValue", "medianValue")`.
* **cutoff**, a number used to limit samples to those that are greater than this number (cutoff). The default value for methylation data is 0.8 while gene expression studies use default value of 2.0. For methylation studies, it is *observed/expected ratio*, for the rest, it is *log z-score*. To change the cutoff to any desired number, change the option to `cutoff = desiredNumber` in which desiredNumber is the number of interest.
* **round**, a logical value that forces the function to round all the calculated values to two decimal places. The default value is `TRUE`.
* **topGenes**, a logical value that, if set as TRUE, causes the function to create three data.frame that contain the five top genes for each cancer. To get all the three data.frames, *frequencyPercentage*, *meanValue* and *median* must have been included for **calculate**.
* **shortenStudyNames** a logical value that causes the function to remove the last part of cancer names aiming to shorten them. The removed segment usually contains the name of scientific group that has conducted the experiment.
* **geneLimit** if large number of genes exist in at least one gene group, this option can be used to limit the number of genes that are shown on heatmap. For instance, `geneLimit=50` will limit the heatmap to 50 genes that show the most variation across multiple study / study subgroups. The default value is `50`.
* **rankingMethod** determines the method by which genes will be ranked prior to drawing heatmap. `variation` orders the genes based on
  unique values in one or few cancer studies while `highValue` ranks the genes when they cotain high values in multiple / many cancer studies. This option is useful when number of genes are too much so that user has to limit the number of genes on heatmap by `geneLimit`.
* **heatmapFileFormat** This option enables the user to select the desired image file format of the heatmaps. The default value is `"TIFF"`. Other suppoeted formats include `"BMP"`, `"JPG"`, `"PNG"`, and `"PDF"`.
* **resolution** This option can be used to adjust the resolution of the output heatmaps as ‘dot per inch’. The defalut resolution is 600.
* **RowCex** a number that specifies letter size in heatmap row names, which ranges from 0 to 2. If `RowCex = "auto"`, the function will automatically determine the best RowCex.
* **ColCex** a number that specifies letter size in heatmap column names, which ranges from 0 to 2. If `ColCex = "auto"`, the function will automatically determine the best ColCex.
* **heatmapMargines** a numeric vector that is used to set heatmap margins. If `heatmapMargines = "auto"`, the function will automatically determine the best possible margines. Otherwise, enter the desired margine as e.g. `c(10,10)`.
* **rowLabelsAngle** a number that determines the angle with which the gene names are shown in heatmaps. The default value is 0 degree.
* **columnLabelsAngle** a number that determines the angle with which the studies/study subgroups names are shown on heatmaps. The default value is 45 degree.
* **heatmapColor** a character string that defines heatmap color. The default value is “RdBu”. “RdGr” is also a popular color in genomic studies. To see the rest of colors, please type `library(RColorBrewer)` and then `display.brewer.all()`.
* **reverseColor** a logical value that reverses the color gradient for heatmap(s).
* **transposedHeatmap** a logical value that transposes heatmap rows to columns and vice versa.
* **simplifyBy** a number that tells the function to change the values smaller than that to zero. The purpose behind this option is to facilitate recognizing candidate genes. Therefore, it is not suited for publications. It has the same unit as *cutoff*.
* **genesToDrop** a character vector. Gene names within this vector will be omitted from heatmap. The default value is `FALSE`.
* **transposeResults**, a logical value to replace the columns and rows of the output.

To get more information about the function options, please refer to the child function to whom they correspond, for example `genesList` lies within `obtainMultipleStudies()` function. The following is an example showing how this function can be used:

```
genes <- list(K.demethylases = c("KDM1A", "KDM1B", "KDM2A", "KDM2B", "KDM3A", "KDM3B", "JMJD1C", "KDM4A"), K.methyltransferases = c("SUV39H1", "SUV39H2", "EHMT1", "EHMT2", "SETDB1", "SETDB2", "KMT2A", "KMT2A"))

processOneStudy(genes, "test", "Breast Invasive Carcinoma (TCGA, Cell 2015)", "RNA-Seq", desiredCaseList = c(2,3,4,5), calculate = c("frequencyPercentage",  "frequencyRatio"), heatmapFileFormat = "TIFF")
```

```
## [obtainOneStudy] Please choose a name other than 'test' and 'test2'.
```

```
## [obtainOneStudy] The requested data already exist locally.
```

```
## [obtainOneStudy] The function was haulted!
```

```
##
```

```
## [automatedStatistics] Please choose a name other than 'test' and 'test2'.
```

```
## [automatedStatistics] The requested data already exist locally.
```

```
## [automatedStatistics] The function was haulted!
```

```
##
```

```
## [heatmapOutput] Automatically determining 'RowCex'.
```

```
## [heatmapOutput] Automatically determining 'ColCex'.
```

```
## [heatmapOutput] Automatically determining 'heatmapMargines'.
```

```
## [heatmapOutput] Preparing heatmap(s).
```

```
##
  |
  |                                                                      |   0%
```

```
##
  |
  |===================================                                   |  50%
```

```
##
  |
  |======================================================================| 100%
```

```
##
```

```
## [xlsxOutput] Preparing excel file(s).
```

```
##
  |
  |                                                                      |   0%
  |
  |===================================                                   |  50%
  |
  |======================================================================| 100%
```

The output excel file and heatmaps are stored in separate folders for every gene group. Ultimately, all the folders are located inside another folder, which its name is the combination of *submissionName* and “output for multiple studies”, for example “test output for multiple studies”.

### 3.1.4 processMultipleStudies()

This function combines four other functions for the ease of use. It is recommended that users only use this parent function to obtain and process gene data across multiple cancer studies for maximum efficiency. `processMultipleStudies()` uses the following functions:

* **obtainMultipleStudies()**
* **automatedStatistics()**
* **heatmapOutput()**
* **xlsxOutput()**

It requires at least four arguments. All function arguments are the same as low-level functions:

* **genesList**, a list that contains at least one gene group. There is no limit on the number of gene groups, users can set as many as gene groups they desire.
* **submissionName**, a character string containing name of interest. It is used for naming the process and should be the same as submissionName for either of `obtainOneStudy()` or `obtainMultipleStudies()` functions.
* **studyName**, a character string showing the desired cancer name. It is an standard cancer study name that exists on cbioportal.org, such as `Acute Myeloid Leukemia (TCGA, NEJM 2013)`.
* **desiredTechnique**, one of the five supported high-throughput studies. RNA-Seq data can be accessed either as relative to all samples or relative to normal samples: `RNA-Seq`, `RNA-SeqRTN`, `microRNA-Seq`, `microarray.mRNA`, `microarray.microRNA` or `methylation`.

Function also contains nineteen other options:

* **cancerCode**, if `TRUE`, will force the function to use the standard abbreviated cancer names instead of complete cancer names. For example, `laml_tcga_pub` is the shortened name for `Acute Myeloid Leukemia (TCGA, NEJM 2013)`.
* **validateGenes** a logical value that, if set to be `TRUE`, function will check each cancer subgroup to find whether or not every gene has a record. If the subgroup doesn’t have a record for the specific gene, function checks for alternative gene names that cbioportal might use instead of the given gene name.
* **calculate**, a character vector that contains the desired statistical procedures. Default input is `c("frequencyPercentage", "frequencyRatio", "meanValue")`. To get all the statistics, use the following instead: `c("frequencyPercentage", "frequencyRatio", "meanValue", "medianValue")`.
* **cutoff**, a number used to limit samples to those that are greater than this number (cutoff). The default value for methylation data is 0.8 while gene expression studies use default value of 2.0. For methylation studies, it is *observed/expected ratio*, for the rest, it is *log z-score*. To change the cutoff to any desired number, change the option to `cutoff = desiredNumber` in which desiredNumber is the number of interest.
* **round**, a logical value that forces the function to round all the calculated values to two decimal places. The default value is `TRUE`.
* **topGenes**, a logical value that, if set as TRUE, causes the function to create three data.frame that contain the five top genes for each cancer. To get all the three data.frames, *frequencyPercentage*, *meanValue* and *median* must have been included for **calculate**.
* **shortenStudyNames** a logical value that causes the function to remove the last part of cancer names aiming to shorten them. The removed segment usually contains the name of scientific group that has conducted the experiment.
* **geneLimit** if large number of genes exist in at least one gene group, this option can be used to limit the number of genes that are shown on heatmap. For instance, `geneLimit=50` will limit the heatmap to 50 genes that show the most variation across multiple study / study subgroups. The default value is `50`.
* **rankingMethod** determines the method by which genes will be ranked prior to drawing heatmap. `variation` orders the genes based on
  unique values in one or few cancer studies while `highValue` ranks the genes when they cotain high values in multiple / many cancer studies. This option is useful when number of genes are too much so that user has to limit the number of genes on heatmap by `geneLimit`.
* **heatmapFileFormat** This option enables the user to select the desired image file format of the heatmaps. The default value is `"TIFF"`. Other suppoeted formats include `"BMP"`, `"JPG"`, `"PNG"`, and `"PDF"`.
* **resolution** This option can be used to adjust the resolution of the output heatmaps as ‘dot per inch’. The defalut resolution is 600.
* **RowCex** a number that specifies letter size in heatmap row names, which ranges from 0 to 2. If `RowCex = "auto"`, the function will automatically determine the best RowCex.
* **ColCex** a number that specifies letter size in heatmap column names, which ranges from 0 to 2. If `ColCex = "auto"`, the function will automatically determine the best ColCex.
* **heatmapMargines** a numeric vector that is used to set heatmap margins. If `heatmapMargines = "auto"`, the function will automatically determine the best possible margines. Otherwise, enter the desired margine as e.g. `c(10,10)`.
* **rowLabelsAngle** a number that determines the angle with which the gene names are shown in heatmaps. The default value is 0 degree.
* **columnLabelsAngle** a number that determines the angle with which the studies/study subgroups names are shown on heatmaps. The default value is 45 degree.
* **heatmapColor** a character string that defines heatmap color. The default value is “RdBu”. “RdGr” is also a popular color in genomic studies. To see the rest of colors, please type `library(RColorBrewer)` and then `display.brewer.all()`.
* **reverseColor** a logical value that reverses the color gradient for heatmap(s).
* **transposedHeatmap** a logical value that transposes heatmap rows to columns and vice versa.
* **simplifyBy** a number that tells the function to change the values smaller than that to zero. The purpose behind this option is to facilitate recognizing candidate genes. Therefore, it is not suited for publications. It has the same unit as *cutoff*.
* **genesToDrop** a character vector. Gene names within this vector will be omitted from heatmap. The default value is `FALSE`.
* **transposeResults**, a logical value to replace the columns and rows of the output.
* **downloadOnServer**, a logical value that activates a two step procedure, in which, Data are downloaded on a server and then the generated zip file can be transferred to a local computer to continue the procedure. The default value is `FALSE`.

To get more information about the function options, please refer to the child function to whom they correspond, for example `genesList` lies within `obtainMultipleStudies()` function. The following is an example showing how this function can be used:

```
genes <- list(K.demethylases = c("KDM1A", "KDM1B", "KDM2A", "KDM2B", "KDM3A", "KDM3B", "JMJD1C", "KDM4A"), K.methyltransferases = c("SUV39H1", "SUV39H2", "EHMT1", "EHMT2", "SETDB1", "SETDB2", "KMT2A", "KMT2A"))

studies <- c("Acute Myeloid Leukemia (TCGA, Provisional)", "Adrenocortical Carcinoma (TCGA, Provisional)", "Bladder Urothelial Carcinoma (TCGA, Provisional)", "Brain Lower Grade Glioma (TCGA, Provisional)", "Breast Invasive Carcinoma (TCGA, Provisional)")

processMultipleStudies(genes, "test2", studies, "RNA-Seq", calculate = c("frequencyPercentage", "frequencyRatio"), heatmapFileFormat = "TIFF")
```

```
## [obtainMultipleStudies] Please choose a name other than 'test' and 'test2'.
```

```
## [obtainMultipleStudies] The requested data already exist locally.
```

```
## [obtainMultipleStudies] The function was haulted!
```

```
##
```

```
## [automatedStatistics] Please choose a name other than 'test' and 'test2'.
```

```
## [automatedStatistics] The requested data already exist locally.
```

```
## [automatedStatistics] The function was haulted!
```

```
##
```

```
## [heatmapOutput] Automatically determining 'RowCex'.
```

```
## [heatmapOutput] Automatically determining 'ColCex'.
```

```
## [heatmapOutput] Automatically determining 'heatmapMargines'.
```

```
## [heatmapOutput] Preparing heatmap(s).
```

```
##
  |
  |                                                                      |   0%
```

```
##
  |
  |===================================                                   |  50%
```

```
##
  |
  |======================================================================| 100%
```

```
##
```

```
## [xlsxOutput] Preparing excel file(s).
```

```
##
  |
  |                                                                      |   0%
  |
  |===================================                                   |  50%
  |
  |======================================================================| 100%
```

The output excel file and heatmaps are stored in separate folders for every gene group. Ultimately, all the folders are located inside another folder, which its name is the combination of *submissionName* and “output for multiple studies”, for example “test output for multiple studies”.

## 3.2 Five dependant Functions

The following functions are used by `processOneStudy()` and `processMultipleStudies()` functions. It is highly recomended to use thses two functions instead of running the following five functions independantly.

### 3.2.1 obtainOneStudy()

This function obtains and stores the supported data for at least one group of genes across multiple subgroups of a cancer study. In addion, it can check whether or not all genes are included in different subgroups of a cancer study and, if not, looks for the alternative gene names.

It requires at least four arguments:

* **genesList**, a list that contains at least one gene group. There is no limit on the number of gene groups, users can set as many as gene groups they desire.
* **submissionName**, a character string containing name of interest. It is used for naming the process.
* **studyName**, a character string showing the desired cancer name. It is an standard cancer study name that exists on cbioportal.org, such as `Acute Myeloid Leukemia (TCGA, NEJM 2013)`.
* **desiredTechnique**, one of the five supported high-throughput studies. RNA-Seq data can be accessed either as relative to all samples or relative to normal samples: `RNA-Seq`, `RNA-SeqRTN`, `microRNA-Seq`, `microarray.mRNA`, `microarray.microRNA` or `methylation`.

Function also contains two other options:

* **desiredCaseList** a numeric vector that contains the index of desired cancer subgroups, assuming the user knows index of desired subgroups. If not, desiredCaseList must be set as ‘none’, function will show the available subgroups asking the user to enter the desired ones during the process. The default value is ‘none’.
* **validateGenes** a logical value that, if set to be `TRUE`, function will check each cancer subgroup to find whether or not every gene has a record. If the subgroup doesn’t have a record for the specific gene, function checks for alternative gene names that cbioportal might use instead of the given gene name.

Consider the following example, where *genes* consists of two gene groups K.demethylases and K.acetyltransferases, *submissionName* is `test`, *cancername* is `Breast Invasive Carcinoma (TCGA, Cell 2015)` and the *desiredTechnique* is `RNA-Seq`. If `desired.case.list = "none"`, all subgroups of the requested cancer study appear on console, function asks the user to choose the index of desired subgroups. Alterntively, user can enter the index of desired cases by changing the argument `desired.case.list = "none"` to, e.g. `desiredCaseList = c(2,3,4,5)`. After the user has entered the desired subgroups, function continues by getting the data and informs the user with a progress bar.

```
genes <- list(K.demethylases = c("KDM1A", "KDM1B", "KDM2A"), K.acetyltransferases = c("CLOCK", "CREBBP", "ELP3", "EP300"))

obtainOneStudy(genes, "test", "Breast Invasive Carcinoma (TCGA, Cell 2015)", "RNA-Seq", desiredCaseList = c(2,3,4,5))
```

```
## [obtainOneStudy] Please choose a name other than 'test' and 'test2'.
```

```
## [obtainOneStudy] The requested data already exist locally.
```

```
## [obtainOneStudy] The function was haulted!
```

### 3.2.2 obtainMultipleStudies()

This function obtains and stores the supported data for at least one group of genes across multiple cancer studies. It can check whether or not all genes are included in each cancer study and, if not, it looks for the alternative gene names.

It requires at least four arguments:

* **genes**, a list that contains at least one group of genes. There is no limit for the number of gene groups, users can set as many as gene groups they desire.
* **submissionName**, a character string containing name of interest. It is used for naming the process.
* **cancernames**, a character vector or a matrix possessing names of desired cancer studies. The character vector contains standard cancer names that can be found on cbioportal.org, such as `Acute Myeloid Leukemia (TCGA, NEJM 2013)`. Alternatively, a matrix can be used if user prefers user-defined cancer names. In this case, the first column of matrix comprises the standard cancer names while the second column must contain the desired cancer names.
* **desiredTechnique**, one of the five supported high-throughput studies. RNA-Seq data can be accessed either as relative to all samples or relative to normal samples: `RNA-Seq`, `RNA-SeqRTN`, `microRNA-Seq`, `microarray.mRNA`, `microarray.microRNA` or `methylation`.

Function also contains two other options:

* **cancerCode**, if `TRUE`, will force the function to use the standard abbreviated cancer names instead of complete cancer names. For example, `laml_tcga_pub` is the shortened name for `Acute Myeloid Leukemia (TCGA, NEJM 2013)`.
* **validateGenes** , if `TRUE`, causes the function to check all cancer studies to find which genes from the input data are available. In addition, function checks for alternative gene names that cbioportal might use instead of the given gene name.

In the following example, *genes* consists of two gene groups K.demethylases and K.acetyltransferases, *submissionName* is `test2`, *cancername* has complete name of five cancer studies and the desired high-throughput study is `RNA-Seq`.

```
genes <- list(K.demethylases = c("KDM1A", "KDM1B", "KDM2A"), K.acetyltransferases = c("CLOCK", "CREBBP", "ELP3", "EP300"))

# Specifying names of cancer studies by standard study names
cancernames <- c("Acute Myeloid Leukemia (TCGA, Provisional)", "Adrenocortical Carcinoma (TCGA, Provisional)", "Bladder Urothelial Carcinoma (TCGA, Provisional)", "Brain Lower Grade Glioma (TCGA, Provisional)", "Breast Invasive Carcinoma (TCGA, Provisional)")

# Specifying names of cancer studies by creating a matrix that includes standard and desired study names
cancernames <- matrix(c("Acute Myeloid Leukemia (TCGA, Provisional)", "acute myeloid leukemia", "Adrenocortical Carcinoma (TCGA, Provisional)", "adrenocortical carcinoma", "Bladder Urothelial Carcinoma (TCGA, Provisional)", "bladder urothelial carcinoma", "Brain Lower Grade Glioma (TCGA, Provisional)", "brain lower grade glioma", "Breast Invasive Carcinoma (TCGA, Provisional)",  "breast invasive carcinoma"), nrow = 5, ncol=2 , byrow = TRUE)

obtainMultipleStudies(genes, "test2", cancernames, "RNA-Seq")
```

```
## [obtainMultipleStudies] Please choose a name other than 'test' and 'test2'.
```

```
## [obtainMultipleStudies] The requested data already exist locally.
```

```
## [obtainMultipleStudies] The function was haulted!
```

### 3.2.3 automatedStatistics()

The function calculates the statistics of the data obtained by `obtainOneStudy()` or `obtainMultipleStudies()` functions. Based on user’s preference, these statistics can include *frequency percentage*, *frequency ratio*, *mean value* and *median value* of samples greater than specific value. Furthermore, it can look for the genes that comprise the highest values in each cancer and list the top 5 genes for *frequency percentage*, *mean value* and *median value*.

It requires at least two arguments:

* **submissionName**, a character string containing name of interest. It is used for naming the process and should be the same as submissionName for either of `obtainOneStudy()` or `obtainMultipleStudies()` functions.
* **obtainedDataType**, a character string that identifies the type of input data produced by the previous function. Two options are available: `single study` for `obtainOneStudy()` and `multiple studies` for `obtainMultipleStudies()`. The function uses `obtainedDataType` and `submissionName` to construct the name of the BiocFileCach object and then finds the appropriate data inside it. Default value is `multiple studies`.

Function also contains four other options:

* **calculate**, a character vector that contains the desired statistical procedures. The default input is `c("frequencyPercentage", "frequencyRatio", "meanValue")` while the complete input is `c("frequencyPercentage", "frequencyRatio", "meanValue", "medianValue")`. This will tell the function to compute the following:

  + *frequencyPercentage*, which is the percentage of samples having the value greather than specific cutoff divided by the total sample size for every study / study subgroup
  + *frequency ratio*, which shows the number of selected samples divided by the total number of samples that give the frequency percentage. It shows the selected and total sample sizes.
  + *Mean Value*, which contains mean value of selected samples for each study.
  + *Median Value*, which shows the median value of selected samples for every study.
* **topGenes**, a logical value that, if set as TRUE, causes the function to create three data.frame that contain the five top genes for each cancer. To get all the three data.frames, *frequencyPercentage*, *meanValue* and *median* must have been included for **calculate**.
* **cutoff**, a number used to limit samples to those that are greater than this number (cutoff). The default value for methylation data is 0.8 while gene expression studies use default value of 2.0. For methylation studies, it is *observed/expected ratio*, for the rest, it is *log z-score*. To change the cutoff to any desired number, change the option to `cutoff = desiredNumber` in which desiredNumber is the number of interest.
* **round**, a logical value that forces the function to round all the calculated values to two decimal places. The default value is `TRUE`.

In the following example, *submissionName* is `test`, and the *obtainedDataType* is `multiple studies`. We exclude *mean value* and *median value* from `calculate`. Note that top genes for these two statistics will also be skipped.

```
automatedStatistics("test", obtainedDataType = "single study", calculate = c("frequencyPercentage", "frequencyRatio"))
```

```
## [automatedStatistics] Please choose a name other than 'test' and 'test2'.
```

```
## [automatedStatistics] The requested data already exist locally.
```

```
## [automatedStatistics] The function was haulted!
```

### 3.2.4 heatmapOutput()

This function prepares heatmap for *frequency percentage*, *mean value* and *median value* data provided by `automatedStatistics()` function. Heatmaps for every gene group are stored in separate folder.

It requires at least one argument:

* **submissionName**, a character string containing name of interest. It is used for naming the process and should be the same as submissionName for either of `obtainOneStudy()` or `obtainMultipleStudies()` functions.

Function also contains thirteen other options:

* **shortenStudyNames** a logical value that causes the function to remove the last part of cancer names aiming to shorten them. The removed segment usually contains the name of scientific group that has conducted the experiment.
* **geneLimit** if large number of genes exist in at least one gene group, this option can be used to limit the number of genes that are shown on heatmap. For instance, `geneLimit=50` will limit the heatmap to 50 genes that show the most variation across multiple study / study subgroups. The default value is `50`.
* **rankingMethod** determines the method by which genes will be ranked prior to drawing heatmap. `variation` orders the genes based on
  unique values in one or few cancer studies while `highValue` ranks the genes when they cotain high values in multiple / many cancer studies. This option is useful when number of genes are too much so that user has to limit the number of genes on heatmap by `geneLimit`.
* **heatmapFileFormat** This option enables the user to select the desired image file format of the heatmaps. The default value is `"TIFF"`. Other suppoeted formats include `"BMP"`, `"JPG"`, `"PNG"`, and `"PDF"`.
* **resolution** This option can be used to adjust the resolution of the output heatmaps as ‘dot per inch’. The defalut resolution is 600.
* **RowCex** a number that specifies letter size in heatmap row names, which ranges from 0 to 2. If `RowCex = "auto"`, the function will automatically determine the best RowCex.
* **ColCex** a number that specifies letter size in heatmap column names, which ranges from 0 to 2. If `ColCex = "auto"`, the function will automatically determine the best ColCex.
* **heatmapMargines** a numeric vector that is used to set heatmap margins. If `heatmapMargines = "auto"`, the function will automatically determine the best possible margines. Otherwise, enter the desired margine as e.g. `c(10,10)`.
* **rowLabelsAngle** a number that determines the angle with which the gene names are shown in heatmaps. The default value is 0 degree.
* **columnLabelsAngle** a number that determines the angle with which the studies/study subgroups names are shown on heatmaps. The default value is 45 degree.
* **heatmapColor** a character string that defines heatmap color. The default value is “RdBu”. “RdGr” is also a popular color in genomic studies. To see the rest of colors, please type `library(RColorBrewer)` and then `display.brewer.all()`.
* **reverseColor** a logical value that reverses the color gradient for heatmap(s).
* **transposedHeatmap** a logical value that transposes heatmap rows to columns and vice versa.
* **simplifyBy** a number that tells the function to change the values smaller than that to zero. The purpose behind this option is to facilitate recognizing candidate genes. Therefore, it is not suited for publications. It has the same unit as *cutoff*.
* **genesToDrop** a character vector. Gene names within this vector will be omitted from heatmap. The default value is `FALSE`.

In the following example, *submissionName* is `test`.

```
heatmapOutput("test", shortenStudyNames = TRUE, heatmapMargines = c(13,5), heatmapColor = "RdGr", genesToDrop = c("PVT1", "SNHG6"), reverseColor = FALSE, heatmapFileFormat = "JPG")
```

If the requested heatmaps already exist, it doesn’t rewrite the heatmaps. The number of skipped heatmaps is then printed.

### 3.2.5 xlsxOutput()

This function exports the output of `automatedStatistics()` and the *gene validation* result of one of the `obtainOneStudy()` or `obtainMultipleStudies()` functions as an excel file. For every gene group, an excel file will be generated and stored in the same folder as heatmaps.

It requires one argument:

* **submissionName**, a character string containing name of interest. It is used for naming the process and should be the same as submissionName for either of `obtainOneStudy()` or `obtainMultipleStudies()` functions.

There is another optional argument:

* **transposeResults**, a logical value to replace the columns and rows of the output.

In the following example, *submissionName* is `test`.

```
xlsxOutput("test")
```

If the requested excel files already exist, the function avoids rewriting them. The number of skipped excel files is then printed.