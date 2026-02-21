# The seventyGenesData package: annotated gene expression data from the van’t Veer and Van de Vijver breast cancer cohorts

Luigi Marchionni1,2

1Department of Pathology and Laboratory Medicine, Weill Cornell Medicine
2Formerly: The Sidney Kimmel Comprehensive Cancer Center, Johns Hopkins University School of Medicine

#### 11/04/2025

# 1 `seventyGeneData` Package

## 1.1 Overview

This vignette documents the `R` code used to retrieve from the original sources,
annotate, and then assemble into separate `ExpressionSet` instances
the gene expression data of the *van’t Veer* and *Van de Vijver* cohorts
(Veer et al. [2002](#ref-vant2002); Vijver et al. [2002](#ref-Vijver2002)).

## 1.2 Original data sources

The original data sets used to develop and validate the 70-genes
signature (Veer et al. [2002](#ref-vant2002); Vijver et al. [2002](#ref-Vijver2002)) were downloaded from the website
of the Bioinformatics and Statistics group of the Netherlands Cancer Institute (NKI)
(<http://bioinformatics.nki.nl/data.php>), and as supplementary material
associated with the original manuscripts, using the following hyperlinks:

* Van’t Veer cohort <http://bioinformatics.nki.nl/data/van-t-Veer_Nature_2002/>:
  + [Training set expression data: good prognosis](http://bioinformatics.nki.nl/data/van-t-Veer_Nature_2002/ArrayData_greater_than_5yr.zip)
  + [Training set expression data: bad prognosis](http://bioinformatics.nki.nl/data/van-t-Veer_Nature_2002/ArrayData_less_than_5yr.zip)
  + [Test set expression data](http://bioinformatics.nki.nl/data/van-t-Veer_Nature_2002/ArrayData_19samples.zip)
  + [Expression data for BRCA1 mutated cases](http://bioinformatics.nki.nl/data/van-t-Veer_Nature_2002/ArrayData_BRCA1.zip)
  + [Microarray feature annotation](http://bioinformatics.nki.nl/data/van-t-Veer_Nature_2002/ArrayNomenclature_contig_accession.xls)
  + [Annotation explanation](http://bioinformatics.nki.nl/data/van-t-Veer_Nature_2002/ArrayNomenclature_methods.doc)
  + [Microarray feature sequences](http://bioinformatics.nki.nl/data/van-t-Veer_Nature_2002/ProbeSeq.xls)
  + [Explanation of files content](http://bioinformatics.nki.nl/data/van-t-Veer_Nature_2002/README-Nature_I.doc)
  + [Explanation of acronyms used in the files](http://bioinformatics.nki.nl/data/van-t-Veer_Nature_2002/codeboek_Rosetta.doc)
  + [Clinical information (from Nature)](http://www.nature.com/nature/journal/v415/n6871/extref/415530a-s8.xls)
  + [70-gene signature data (from Nature)](http://www.nature.com/nature/journal/v415/n6871/extref/415530a-s9.xls)
* Van de Vijveer cohort:
  + [Clinical data](http://bioinformatics.nki.nl/data/nejm_table1.zip)
  + [The expression data for 70-Gene signature across the 295 samples](http://bioinformatics.nki.nl/data/nejm_table3.zip)
  + [70-Gene Template for Good Prognosis Signature](http://bioinformatics.nki.nl/data/nejm_table3.zip)
  + [Genome-Wide Gene Expression Data for 295 Samples](http://bioinformatics.nki.nl/data/ZipFiles295Samples.zip)

All the files, among those mentioned above, needed to compile this vignette
and create the *[seventyGeneData](https://bioconductor.org/packages/3.22/seventyGeneData)* `R` package are included
inside the `inst/extdata` directory.

The microarray feature annotation can be obtained from the *[breastCancerNKI](https://bioconductor.org/packages/3.22/breastCancerNKI)*
`R`/`Bioconductor` package, in which the two cohorts are merged in a unique `ExpressionSet`
instance. On the contrary in the present `R`/`Bioconductor` package the two data sets are maintained
separate, the training and test sets of sampes used in the original studies are identified,
along with the microarray features constituting the 70-gene signature.

Below is the code chunk used to download the van’t Veer’s cohort data from NKI and from
the Supplementary Information section associated with the original manuscript.
This code chunk was not run to compile this vignette, which was prepared
using the local copies of the data stored in the `inst/extdata` directory.

```
library(seventyGeneData)
```

```
### Create a working directory
dir.create("../extdata/vantVeer", showWarnings = FALSE, recursive = TRUE)
### Create the url list for all supplementary data on the Nature Website
nkiUrl <- "http://bioinformatics.nki.nl/data/van-t-Veer_Nature_2002/"
natureUrl <- "http://www.nature.com/nature/journal/v415/n6871/extref/"
urlList <- c(
  paste(nkiUrl,
    sep = "",
    c(
      "ArrayData_greater_than_5yr.zip",
      "ArrayData_less_than_5yr.zip", "ArrayData_19samples.zip",
      "ArrayData_BRCA1.zip", "ArrayNomenclature_contig_accession.xls",
      "ArrayNomenclature_methods.doc", "ProbeSeq.xls",
      "README-Nature_I.doc", "codeboek_Rosetta.doc"
    )
  ),
  paste(natureUrl,
    sep = "",
    c(
      "415530a-s7.doc", "415530a-s8.xls",
      "415530a-s9.xls", "415530a-s10.xls", "415530a-s11.xls"
    )
  )
)
### Dowload all files from Nature and NKI
lapply(urlList, function(x) {
  download.file(x,
    destfile = paste("../extdata/vantVeer/", gsub(".+/", "", x), sep = ""),
    quiet = FALSE, mode = "w", cacheOK = TRUE
  )
})
```

Below is the code to download the Van de Vijver’s cohort data from NKI.
This code chunk was not run to compile this vignette, which was prepared
using the local copies of the data stored in the `inst/extdata` directory.

```
### Create a working directory
dir.create("../extdata/vanDeVijver", showWarnings = FALSE, recursive = TRUE)
### Create the url list for all supplementary data on the NKI Website
nkiUrl <- "http://bioinformatics.nki.nl/data/"
urlList <- paste(nkiUrl, sep = "", c("nejm_table1.zip", "ZipFiles295Samples.zip"))
### Dowload all files from NKI
lapply(urlList, function(x) {
  download.file(x,
    destfile = paste("../extdata/vanDeVijver/", gsub(".+/", "", x), sep = ""),
    quiet = FALSE, mode = "w", cacheOK = TRUE
  )
})
```

Below is the code to download and install the *[breastCancerNKI](https://bioconductor.org/packages/3.22/breastCancerNKI)*
annotation metadata package from `Bioconductor`, along with other required libraries
if the are not available (e.g *[readxl](https://CRAN.R-project.org/package%3Dreadxl)*.
As shown below the *[breastCancerNKI](https://bioconductor.org/packages/3.22/breastCancerNKI)* contains a unique
instance of class `ExpressionSet` for both cohorts,
wich includes the expression data, the phenotypic information,
and the feature annotation.

```
### Get the list of available packages
installedPckgs <- installed.packages()[, "Package"]
### Define the list of desired libraries
pckgListBIOC <- c("Biobase", "limma", "breastCancerNKI", "readxl")
### Use the BiocManager package from Bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
### Load the packages, install them from Bioconductor if needed
for (pckg in pckgListBIOC) {
  if (!pckg %in% installedPckgs) BiocManager::install(pckg)
  require(pckg, character.only = TRUE)
}
```

## 1.3 `ExpressionSet` preparation

### 1.3.1 Feature data preparation

Below is the code used to assemble the microarray feature annotation
obtained from all the various sources described above, including
the information about gene membership to the original 70-gene
signature identified in the van’t Veer study (Veer et al. [2002](#ref-vant2002)),
as available from the supplementary data section of the original publication.
To this end the Excel spreadsheet named `415530a-s9.xls` corresponds to
Table S2 of the original manuscript, and contains the identifiers and annotation
for the 231 genes that proved to be associated with metastatic recurrence at 5 years.
According to the information contained in the legend for Table S2
(“Supplementary Methods” section, file `415530a-s7.doc`)
the optimal set of genes constituting the 70-gene signature can be obtained
from this table by selecting the top 70 features/reporters with highest
absolute correlation coefficients.

The code chunk below shows how to manipulate the annotation
contained in the *[breastCancerNKI](https://bioconductor.org/packages/3.22/breastCancerNKI)*:

```
### Load the library with annotation
library(Biobase)
library(breastCancerNKI)
### Load the dataset
data(nki)
### Check dataset classes and attributes
class(nki)
dim(nki)
### Check featureData
str(featureData(nki))
nkiAnn <- featureData(nki)
### Turn all annotation information into character
nkiAnn@data <- as.data.frame(apply(nkiAnn@data, 2, as.character),
  stringsAsFactors = FALSE
)
```

The code chunk below shows how to read and manipulate the annotation
contained in the files obtained from the Nature and the NKI websites:

```
### Load the library
library(readxl)
### Read GBACC information for van't Veer dataset
myFile <- system.file("extdata/vantVeer", "ArrayNomenclature_contig_accession.xls",
  package = "seventyGeneData"
)
featAcc <- read_xls(myFile)
### Read seq information for van't Veer dataset
myFile <- system.file("extdata/vantVeer", "ProbeSeq.xls",
  package = "seventyGeneData"
)
featSeq <- read_xls(myFile)
### Read 70-genes signature information for van't Veer dataset
myFile <- system.file("extdata/vantVeer", "415530a-s9.xls",
  package = "seventyGeneData"
)
gns231 <- read_xls(myFile)
### Remove special characters in the colums header,
### which are due to white spaces present in the Excel files
colnames(gns231) <- gsub("\\s|#", "", colnames(gns231))
### Remove GO annotation
gns231 <- gns231[, -grep("sp_xref_keyword_list", colnames(gns231))]
### Reorder the genes in decreasing order by absolute correlation
gns231 <- gns231[order(abs(gns231$correlation), decreasing = TRUE), ]
### Select the feature identifiers corresponding to the top 231 and 70 genes
gns231$genes231 <- TRUE
gns231$genes70 <- gns231$accession %in% gns231$accession[1:70]
### Merge all information (including 70-gene signature information)
### with the annotation obtained from the breastCancerNKI package
newAnn <- nkiAnn@data
newAnn <- merge(newAnn, featAcc, by.x = 1, by.y = 1, all = TRUE, sort = FALSE)
newAnn <- merge(newAnn, featSeq, by.x = 1, by.y = 1, all = TRUE, sort = FALSE)
newAnn <- merge(newAnn, gns231, by.x = 1, by.y = 1, all = TRUE, sort = FALSE)
```

All the available annotation information is shown below:

```
### Check the structure of the new annotation data.frame
newAnn <- newAnn[order(newAnn[, 1]), ]
str(newAnn)
```

### 1.3.2 Assemble the `vantVeer` `ExpressionSet` object

For the van’t Veer cohort the gene expression data for 117 samples
is contained in the following four different compressed files.

* `ArrayData_19samples.zip`, containing data for 19 samples (test set);
* `ArrayData_BRCA1.zip`, containing data for 20 samples (BRCA1 and 2 mutation).
* `ArrayData_greater_than_5yr.zip`, containing data for 51 samples;
* `ArrayData_less_than_5yr.zip`, containing data for 46 samples;

Once decompressed such archives correspond to 4 distinct Excel
spreadsheets containing three (3) columns for each sample,
organized as follows:
- Log ratio;
- P-value for log ratio significance;
- Log intensity;

However the annotation information contained in these spreadsheets has different format,
with unmatched quotes and a variable number of columns corresponding to
the systematic feature name, the gene name, and its annotation.
Hence such spreadsheets are somewhat difficult to read directly into `R`
with the `read_xls()` function contained in the *[readxl](https://CRAN.R-project.org/package%3Dreadxl)*.
For this reason, after extracting the corresponding compressed Excel files,
we have saved all the spreadsheets as TAB-delimited text files externally,
and we have provided them with the *[seventyGeneData](https://bioconductor.org/packages/3.22/seventyGeneData)* package
inside the `inst/extdata` directory.

Finally, the Sample IDs used in such gene expression tables correspond
to those used in the clinical data table (archived in the `415530a-s8.xls`).

The `R` code used to assemble the `ExpressionSet` instance for the van’t Veer
cohort contained in the *[seventyGenesData](https://bioconductor.org/packages/3.22/seventyGenesData)* `R`/`Bioconductor` package
is shown below.
Since gene expression from the original van’t Veer and Van de Vijver cohorts was
provided in the form of pre-processed, normalized, and summarized values,
pre-processing is not required.

The code chunk below shows how to list the available files containing
gene expression measurements:

```
### Load the library
library(Biobase)
library(readxl)
### Check presence of dowloaded file
filesVtVloc <- system.file("extdata/vantVeer", package = "seventyGeneData")
dir(filesVtVloc)
### Create list of files to be read in
filesVtV <- dir(filesVtVloc, full.names = TRUE, pattern = "^ArrayData")
filesVtV
```

The code chunk below shows how to read and the phenotypic information
associated with the samples analyzed in the van’t Veer cohort:

```
myFile <- system.file("extdata/vantVeer", "415530a-s8.xls",
  package = "seventyGeneData"
)
### Read phenotypic information
phenoVtV <- as.data.frame(read_xls(myFile))
### Show Phenotypic information
str(phenoVtV)
```

The code chunk below shows how to process the phenotypic information
associated with the samples analyzed in the van’t Veer cohort.
In particular it is important to check that samples order is the same
in the expression data and phenotypic information tables.

```
### Remove the special characters in the colums headers
### due to white spaces present in the Excel file
colnames(phenoVtV) <- gsub("\\s|#", "", colnames(phenoVtV))
#### Remove columns that do not contain useful information
phenoVtV <- phenoVtV[, apply(phenoVtV, 2, function(x) length(unique(x)) > 1)]
phenoVtV$SampleName <- paste("Sample", phenoVtV$Sample)
rownames(phenoVtV) <- phenoVtV$SampleName
### Read sample names from the 6 expression data tables
samplesVtV <- lapply(filesVtV, read.table,
  nrow = 1, header = FALSE, sep = "\t",
  stringsAsFactors = FALSE, fill = TRUE, strip.white = TRUE
)
### Format the samples strings
samplesVtV <- lapply(samplesVtV, function(x) x[grep("^Sample", x)])
headerDesc <- samplesVtV
samplesVtV <- lapply(samplesVtV, function(x) gsub(",.+", "", x))
```

The code chunk below shows how to compare the order of the samples
in the expression data spreadsheets and the phenotypic information table.

```
### Check sample lables obtained from expression data files
str(samplesVtV)
### Combine the lables in one unique vector
allSamplesVtV <- do.call("c", samplesVtV)
### Compare order the order the samples between the expression data
### and phenotypic information data.frames
if (all(rownames(phenoVtV) %in% allSamplesVtV)) {
  print("All sample names match phenoData")
  if (all(rownames(phenoVtV) == allSamplesVtV)) {
    print("All sample names match phenoData")
  } else {
    print("Sample names from tables and phenoData need reordering")
    phenoVtV <- phenoVtV[order(phenoVtV$SampleName), ]
  }
} else {
  print("Sample names DO NOT match phenoData")
}
```

The code chunk below shows how to read the expression data
from the spreadsheets:

```
### Read expression data from the 4 converted TAB-delimited text files
dataVtV <- lapply(filesVtV, read.table,
  skip = 1, sep = "\t", quote = "",
  header = TRUE, row.names = NULL,
  stringsAsFactors = FALSE, fill = FALSE, strip.white = FALSE
)
sapply(dataVtV, dim)
### Extract annotation: note that column headers are slightly different
sapply(dataVtV, function(x) head(colnames(x)))
sapply(dataVtV, function(x) tail(colnames(x)))
### Extract the associated annotation
annVtV <- lapply(dataVtV, function(x) x[, c("Systematic.name", "Gene.name")])
annVtV <- lapply(annVtV, function(x) {
  x[x == ""] <- NA
  x
})
annVtV <- do.call("cbind", annVtV)
```

The code chunk below shows how to check the annotation information
contained in the expression data spreadsheets:

```
### Check annotation order in all data files
if (all(apply(annVtV[, seq(1, 8, by = 2)], 1, function(x) length(unique(x)) == 1))) {
  print("OK")
  annVtV <- annVtV[, 1:2]
} else {
  print("Check annotation")
}
```

Create a function that extracts columns based on **UNIQUE** patterns
and sets rownames using annotation and reorder the rows:

```
### Define the function
extractColumns <- function(x, pattern, ann) {
  sel <- grep(pattern, colnames(x), value = TRUE)
  x <- x[, sel]
  rownames(x) <- ann
  x <- x[order(rownames(x)), ]
}
```

The code chunk below shows how to read the four files
and assemble the log-ratio expression data:

```
### Extract log ratio data from all the spreadsheets
logRat <- lapply(dataVtV, extractColumns, pattern = "Log10\\.ratio", ann = annVtV[, 1])
logRat <- do.call("cbind", logRat)
### Assign colnames and reorder the columns
colnames(logRat) <- allSamplesVtV
logRat <- logRat[, order(colnames(logRat)), ]
```

The code chunk below shows how to check that the samples are similarly
ordered in the assembled gene expression and phenotypes `data.frames`:

```
### Check order
all(phenoVtV$SampleName == colnames(logRat))
```

The code chunk below shows how to read the four files
and assemble the p-values associated with the expression data:

```
### Extract p-values from all the spreadsheets
pVal <- lapply(dataVtV, extractColumns, pattern = "value", ann = annVtV[, 1])
pVal <- do.call("cbind", pVal)
### Assign colnames and reorder the columns
colnames(pVal) <- allSamplesVtV
pVal <- pVal[, order(colnames(pVal)), ]
```

The code chunk below shows how to check that the samples are similarly
ordered in the assembled p-values and phenotypes data.frames:

```
### Check order
all(phenoVtV$SampleName == colnames(pVal))
```

The code chunk below shows how to read the four files
and assemble the expression intensities provided with the data:

```
### Extract expression intensity from all the spreadsheets
intensity <- lapply(dataVtV, extractColumns, pattern = "Intensity", ann = annVtV[, 1])
intensity <- do.call("cbind", intensity)
### Assign colnames and reorder the columns
colnames(intensity) <- allSamplesVtV
intensity <- intensity[, order(colnames(intensity)), ]
```

The code chunk below shows how to check that the samples are similarly
ordered in the assembled expression intensity and phenotypes `data.frames`:

```
### Check order
all(phenoVtV$SampleName == colnames(intensity))
```

The code chunk below shows how to create an instance of
class `ExpressionSet` for the van’t Veer cohort.

```
### Merge annotation objects and check order
annVtV <- merge(annVtV, newAnn, by = 1, all = TRUE, sort = TRUE)
rownames(annVtV) <- annVtV[, 1]
all(rownames(annVtV) == rownames(logRat))
all(rownames(annVtV) == rownames(pVal))
all(rownames(annVtV) == rownames(intensity))
### Create the new assayData
myAssayData <- assayDataNew(exprs = logRat, pValue = pVal, intensity = intensity)
### Create the new phenoData
myPhenoData <- new("AnnotatedDataFrame", phenoVtV)
### Create the new featureData
myFeatureData <- new("AnnotatedDataFrame", annVtV)
### Create the new experimentData
myExperimentData <- new("MIAME",
  name = "Marc J Van De Vijver, Hongyue Dai, and Laura J van't Veer",
  lab = "The Netherland Cancer Institute, Amsterdam, The Netherlands",
  contact = "Luigi Marchionni <marchion@gmail.com>",
  title = "Gene expression profiling predicts clinical outcome of breast cancer",
  abstract = "Breast cancer patients with the same stage of disease can have markedly different treatment responses and overall outcome.
The strongest predictors for metastases (for example, lymph node status and histological grade) fail to classify accurately breast tumours according to their clinical behaviour.
Chemotherapy or hormonal therapy reduces the risk of distant metastases by approximately one-third; however, 70-80% of patients receiving this treatment would have survived without it.
None of the signatures of breast cancer gene expression reported to date allow for patient-tailored therapy strategies.
Here we used DNA microarray analysis on primary breast tumours of 117 young patients, and applied supervised classification to identify a gene expression signature strongly predictive of a short interval to distant metastases (`poor prognosis' signature) in patients without tumour cells in local lymph nodes at diagnosis (lymph node negative).
In addition, we established a signature that identifies tumours of BRCA1 carriers. The poor prognosis signature consists of genes regulating cell cycle, invasion, metastasis and angiogenesis.
This gene expression profile will outperform all currently used clinical parameters in predicting disease outcome. Our findings provide a strategy to select patients who would benefit from adjuvant therapy.",
  url = "http://www.ncbi.nlm.nih.gov/pubmed/?term=11823860",
  pubMedIds = "11823860"
)
### Create the expression set
vantVeer <- new("ExpressionSet",
  assayData = myAssayData,
  phenoData = myPhenoData,
  featureData = myFeatureData,
  experimentData = myExperimentData
)
```

### 1.3.3 Assemble the `vanDeVijver` `ExpressionSet` object

For the Van de Vijver cohort the gene expression data for 295 samples
is contained in the `ZipFiles295Samples.zip` compressed archive.

Such data is organized in six separate text files:

* `Table_NKI_295_1.txt`, containing data for 50 samples;
* `Table_NKI_295_2.txt`, containing data for 50 samples;
* `Table_NKI_295_3.txt`, containing data for 50 samples;
* `Table_NKI_295_4.txt`, containing data for 50 samples;
* `Table_NKI_295_5.txt`, containing data for 50 samples;
* `Table_NKI_295_6.txt`, containing data for 45 samples;

All the files, amon those mentioned above, needed to compile this vignette
and create the *[seventyGeneData](https://bioconductor.org/packages/3.22/seventyGeneData)* `R` package are included
inside the `inst/extdata` directory.

Each row in each expression data spreadsheet corresponds
to a specific feature on the microrray.
The first two columns provide the systematic substance name and
the gene name when available.
Starting from the third column each sample accounts for five
distinct and consecutive columns:

* Log ratio;
* Log ratio error;
* P-value for log ratio significance;
* Log intensity;
* Flag for each feature(0 for control or bad spot, = 1 for valid measurement);

The Sample ID used in the gene expression tables correspond to those used
in the clinical data table (archived in the `nejm_table1.zip` compressed file).

The code used to assemble the `ExpressionSet` instance for the van’t Veer
cohort contained in the `BiocStyle::Biocpkg("seventyGenesData")`
`R`/`Bioconductor` package is shown below.

Since gene expression from the original van’t Veer and Van de Vijver cohorts was
provided in the form of pre-processed, normalized, and summarized values,
pre-processing is not required.

The code chunk below shows how to check the availability of all raw data
files obtained from the NKI website.

```
##################################################
### Load the library
library(Biobase)
library(readxl)
##################################################
### Check presence of dowloaded files
dir("../inst/extdata/vanDeVijver")
```

The code chunk below shows how to decompress and extract the
zipped archives containing the expression data for the Van de Vijver cohort.

```
### Check presence of dowloaded file
filesVdVloc <- system.file("extdata/vanDeVijver", package = "seventyGeneData")
dir(filesVdVloc)
### Create list of files to be unzipped and read in
filesVdVzip <- dir(filesVdVloc, full.names = TRUE)
filesVdVzip
### Create output directory
myTmpDir <- paste(filesVdVloc, "/tmp", sep = "")
### Decompress expression
unzip(filesVdVzip[1], exdir = myTmpDir)
### Decompress phenoData
unzip(filesVdVzip[2], exdir = myTmpDir)
### List of files in "ZipFiles295Samples.zip" containing expression
filesVdV <- dir(myTmpDir, full.names = TRUE, pattern = "NKI")
### Show file list content
filesVdV
```

The code chunk below shows how to process the phenotypic information
associated with the samples analyzed in the Van de Vijver cohort.
In particular it is important to check that samples order is the same
in the expression data and phenotypic information tables.

```
### Read phenotypic information
myFile <- dir(myTmpDir, full.names = TRUE, pattern = "Table1_ClinicalData_Table.xls")
phenoVdV <- as.data.frame(read_xls(myFile, skip = 3))
#### Remove columns that do not contain useful information
phenoVdV <- phenoVdV[, apply(phenoVdV, 2, function(x) length(unique(x)) > 1)]
phenoVdV$SampleName <- paste("Sample", phenoVdV$SampleID)
rownames(phenoVdV) <- phenoVdV$SampleName
### Read sample names from the expression data spreadsheets
samplesVdV <- lapply(filesVdV, scan, what = "character", nlines = 1, sep = "\t", strip.white = FALSE)
samplesVdV <- lapply(samplesVdV, function(x) x[x != ""])
allSamplesVdV <- do.call("c", samplesVdV)
### Read all data contained in the expression data spreadsheets
dataVdV <- lapply(filesVdV, read.table,
  header = TRUE, skip = 1, sep = "\t", quote = "",
  stringsAsFactors = FALSE, fill = TRUE, strip.white = TRUE
)
### Extract feature annotation
annVdV <- lapply(dataVdV, function(x) x[, c("Substance", "Gene")])
annVdV <- lapply(annVdV, function(x) {
  x[x == ""] <- NA
  x
})
annVdV <- do.call("cbind", annVdV)
```

The code chunk below shows how to check the annotation information
contained in the expression data spreadsheets:

```
### Check annotation order in all data files
if (all(apply(annVdV[, seq(1, 12, by = 2)], 1, function(x) length(unique(x)) == 1))) {
  print("OK")
  annVdV <- annVdV[, 1:2]
} else {
  print("Check annotation")
}
```

Create a function that extracts columns based on **UNIQUE** patterns
and sets rownames using annotation and reorder the rows.

```
### Define the function
extractColumns <- function(x, pattern, annVdV) {
  colnames(x) <- gsub("Log\\.Ratio\\.Error", "Error", colnames(x))
  sel <- grep(pattern, colnames(x), value = TRUE)
  x <- x[, sel]
  rownames(x) <- annVdV
  x <- x[order(rownames(x)), ]
}
```

The code chunk below shows how to read the four files
and assemble the log-ratio expression data:

```
### Extract and assemble the log ratio values
logRat <- lapply(dataVdV, extractColumns, pattern = "Log\\.Ratio", ann = annVdV[, 1])
logRat <- do.call("cbind", logRat)
### Set the column names
colnames(logRat) <- allSamplesVdV
```

The code chunk below shows how to check that the samples are similarly
ordered in the assembled gene expression and phenotypes `data.frames`:

```
### Check order
all(phenoVdV$SampleName == colnames(logRat))
```

The code chunk below shows how to read the four files
and assemble the log-ratio error associated with the expression data:

```
### Extract log ratio error
logRatError <- lapply(dataVdV, extractColumns, pattern = "Error", ann = annVdV[, 1])
logRatError <- do.call("cbind", logRatError)
### Set the column names
colnames(logRatError) <- allSamplesVdV
```

The code chunk below shows how to check that the samples are similarly
ordered in the assembled gene expression error and phenotypes `data.frames`:

```
### Check order
all(phenoVdV$SampleName == colnames(logRatError))
```

The code chunk below shows how to read the four files
and assemble the p-values associated with the expression data:

```
### Extract P-value
pVal <- lapply(dataVdV, extractColumns, pattern = "alue", ann = annVdV[, 1])
pVal <- do.call("cbind", pVal)
### Set the column names
colnames(pVal) <- allSamplesVdV
```

The code chunk below shows how to check that the samples are similarly
ordered in the assembled p-values and phenotypes data.frames:

```
### Check order
all(phenoVdV$SampleName == colnames(pVal))
```

The code chunk below shows how to read the four files
and assemble the expression intensities provided with the data:

```
### Extract Intensity
intensity <- lapply(dataVdV, extractColumns, pattern = "Intensity", ann = annVdV[, 1])
intensity <- do.call("cbind", intensity)
### Set the column names
colnames(intensity) <- allSamplesVdV
```

The code chunk below shows how to check that the samples are similarly
ordered in the assembled p-values and phenotypes data.frames:

```
### Check order
all(phenoVdV$SampleName == colnames(intensity))
```

The code chunk below shows how to create an instance of
class `ExpressionSet` for the *van’t Veer* cohort.

```
### Merge and check order
annVdV <- merge(annVdV, newAnn, by = 1, all = TRUE, sort = TRUE)
rownames(annVdV) <- annVdV[, 1]
all(rownames(annVdV) == rownames(logRat))
all(rownames(annVdV) == rownames(logRatError))
all(rownames(annVdV) == rownames(pVal))
all(rownames(annVdV) == rownames(intensity))
### Create the new assayData
myAssayData <- assayDataNew(
  exprs = logRat, exprsError = logRatError,
  pValue = pVal, intensity = intensity
)
### Create the new phenoData
myPhenoData <- new("AnnotatedDataFrame", phenoVdV)
### Create the new featureData
myFeatureData <- new("AnnotatedDataFrame", annVdV)
### Create the new experimentData
myExperimentData <- new("MIAME",
  name = "Marc J Van De Vijver, Yudong D He, and Laura J van't Veer",
  lab = "The Netherland Cancer Institute, Amsterdam, The Netherlands",
  contact = "Luigi Marchionni <marchion@gmail.com>",
  title = "A gene-expresion signature as a predictor  of survival in breast cancer",
  abstract = "Background: A more accurate means of prognostication in breast cancer will improve the selection of patients for adjuvant systemic therapy.
Methods: Using microarray analysis to evaluate our previously established 70-gene prognosis profile, we classified a series of 295 consecutive patients with primary breast carcinomas as having a gene expression signature associated with either a poor prognosis or a good prognosis.
All patients had stage I or II breast cancer and were younger than 53 years old; 151 had lymph-node-negative disease, and 144 had lymph-node-positive disease. We evaluated the predictive power of the prognosis profile using univariable and multivariable statistical analyses.
Results: Among the 295 patients, 180 had a poor-prognosis signature and 115 had a good-prognosis signature, and the mean (+/-SE) overall 10-year survival rates were 54.6+/-4.4 percent and 94.5+/-2.6 percent, respectively.
At 10 years, the probability of remaining free of distant metastases was 50.6+/-4.5 percent in the group with a poor-prognosis signature and 85.2+/-4.3 percent in the group with a good-prognosis signature.
The estimated hazard ratio for distant metastases in the group with a poor-prognosis signature, as compared with the group with the good-prognosis signature, was 5.1 (95 percent confidence interval, 2.9 to 9.0; P<0.001).
This ratio remained significant when the groups were analyzed according to lymph-node status. Multivariable Cox regression analysis showed that the prognosis profile was a strong independent factor in predicting disease outcome.
Conclusions: The gene-expression profile we studied is a more powerful predictor of the outcome of disease in young patients with breast cancer than standard systems based on clinical and histologic criteria. (N Engl J Med 2002;347:1999-2009.)",
  url = "http://www.ncbi.nlm.nih.gov/pubmed/?term=12490681",
  pubMedIds = "12490681"
)
### Create the expression set
vanDeVijver <- new("ExpressionSet",
  assayData = myAssayData,
  phenoData = myPhenoData,
  featureData = myFeatureData,
  experimentData = myExperimentData
)
### Remove temporary folder
file.remove(dir(myTmpDir, full.names = TRUE))
file.remove(myTmpDir)
```

## 1.4 Phenotypic information processing

### 1.4.1 Patients’ phenotypes in the `vantVeer` `ExpressionSet` object

The code below is to add data set information to the `vantVeer`
`ExpressionSet` object.

```
### Define the data set type from file of origin
type <- gsub("..txt", "", gsub(".+ArrayData_", "", filesVtV))
dataSetType <- mapply(x = samplesVtV, y = type, FUN = function(x, y) {
  rep(y, length(x))
})
### Combine with sample information
dataSetType <- do.call("c", dataSetType)
names(dataSetType) <- allSamplesVtV
### Reorder
dataSetType <- dataSetType[order(names(dataSetType))]
```

```
### Add the information to pData(vantVeer)
if (all(rownames(pData(vantVeer)) == names(dataSetType))) {
  pData(vantVeer)$DataSetType <- dataSetType
  print("Adding information about data set type to pData")
} else {
  print("Check order pData and data set type information")
}
```

The `R` code below is to create prognostic groups using recurrence information
defined as the occurrence of a metastasis as first event within five years from
surgery (“bad” prognosis), as opposed to patients who remained disease free for
at least five years (“good” prognosis).

```
### Process time metastases (TTM)
pData(vantVeer)$TTM <- pData(vantVeer)$followup.time.yr
#### Process TTM event
pData(vantVeer)$TTMevent <- pData(vantVeer)$metastases
#### Create binary TTM at 5 years groups
pData(vantVeer)$FiveYearMetastasis <- pData(vantVeer)$TTM < 5 & pData(vantVeer)$TTMevent == 1
### Show structure of updated phenotypes
str(pData(vantVeer))
### Save the final ExpressionSet object
dataDirLoc <- system.file("data", package = "seventyGeneData")
save(vantVeer, file = paste(dataDirLoc, "/vantVeer.rda", sep = ""))
```

### 1.4.2 Patients’ phenotypes in the `vanDeVijver` `ExpressionSet` object

The `R` code below is to create prognostic groups using recurrence information defined
as the occurrence of a metastasis as first event within five years from surgery (“bad” prognosis),
as opposed to patients who remained disease free for at least five years (“good” prognosis).x

```
### Select  new cases not included in the van't Veer study
pVDV <- pData(vanDeVijver)
### Rename columns
selNames <- c("TIMEmeta", "EVENTmeta", "TIMEsurvival", "EVENTdeath", "TIMErecurrence")
newNames <- c("TTM", "TTMevent", "OS", "OSevent", "RFS")
colnames(pVDV)[sapply(selNames, grep, colnames(pVDV))] <- newNames
### Process time metastases (TTM)
pVDV$TTM[is.nan(pVDV$TTM)] <- pVDV$OS[is.nan(pVDV$TTM)]
### Process recurrence free survival (RFS) adding RFSevent
pVDV$RFSevent <- pVDV$RFS < pVDV$OS
### Create binary TTM at 5 years groups selecting:
### 1) the cases with metastases as first event within 5 years
badCases <- which(
  pVDV$TTM <= pVDV$RFS ### Met is 1st recurrence
  & pVDV$TTMevent == 1 ### Metastases occurred
  & pVDV$TTM < 5 ### Recurrence within 5 years
)
### 2) the cases disease free for at least 5 years
goodCases <- which(
  pVDV$TTM > 5 ### No metastasis before 5 years
  & pVDV$RFS > 5 ### No recurrence before 5 years
  & pVDV$TTMevent == 0 ### Metastases did notoccurred
)
```

The code chunk below is to check that no patients are duplicated:

```
### Check if there are duplicated cased present in both prognostic groups
all(!goodCases %in% badCases)
```

The code chunk below is to add the prognostic group information to the
`pData` component of the `ExpressionSet`.

```
### Create groups by setting all cases to NA and then identifying bad cases
pVDV$FiveYearMetastasis <- NA
pVDV$FiveYearMetastasis[badCases] <- TRUE
### And then excluding patients with a relapse before a metastasis within 5 years
pVDV$FiveYearMetastasis[goodCases] <- FALSE
### Assign updated phenotypic data
pData(vanDeVijver) <- pVDV
### Show structure of updated phenotypes
str(pData(vanDeVijver))
### Save the final ExpressionSet object
dataDirLoc <- system.file("data", package = "seventyGeneData")
save(vanDeVijver, file = paste(dataDirLoc, "/vanDeVijver.rda", sep = ""))
```

## 1.5 Session information

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
#> other attached packages:
#> [1] seventyGeneData_1.46.0 BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
#>  [4] fastmap_1.2.0       xfun_0.54           cachem_1.1.0
#>  [7] knitr_1.50          htmltools_0.5.8.1   rmarkdown_2.30
#> [10] lifecycle_1.0.4     cli_3.6.5           sass_0.4.10
#> [13] jquerylib_0.1.4     compiler_4.5.1      tools_4.5.1
#> [16] evaluate_1.0.5      bslib_0.9.0         yaml_2.3.10
#> [19] BiocManager_1.30.26 jsonlite_2.0.0      rlang_1.1.6
```

## References

Veer, L. J. van’t, H. Dai, M. J. van de Vijver, Y. D. He, A. A. Hart, M. Mao, H. L. Peterse, et al. 2002. “Gene Expression Profiling Predicts Clinical Outcome of Breast Cancer.” *Nature* 415 (6871): 530–6.

Vijver, M. J. van de, Y. D. He, L. J. van’t Veer, H. Dai, A. A. Hart, D. W. Voskuil, G. J. Schreiber, et al. 2002. “A Gene-Expression Signature as a Predictor of Survival in Breast Cancer.” *N Engl J Med* 347 (25): 1999–2009.