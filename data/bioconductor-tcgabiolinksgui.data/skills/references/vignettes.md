# Supporting data for the TCGAbiolinksGUI package

Tiago Chedraoui Silva, Tathiane Malta, Houtan Noushmehr

#### 2025-11-04

# 1 Introduction

This document provides an introduction of the *[TCGAbiolinksGUI.data](https://bioconductor.org/packages/3.22/TCGAbiolinksGUI.data)*, which contains
supporting data for *[TCGAbiolinksGUI](https://bioconductor.org/packages/3.22/TCGAbiolinksGUI)* (Silva et al. [2017](#ref-silva2017tcgabiolinksgui)).

This package contains the following objects:

* For gene annotation
* gene.location.hg38
* gene.location.hg19
* For Glioma Classifier function
  + glioma.gcimp.model
  + glioma.idh.model
  + glioma.idhmut.model
  + glioma.idhwt.model
* For linkedOmics database:
  + linkedOmicsData

## 1.1 Installing TCGAbiolinksGUI.data

You can install the package from Bioconductor:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install(("TCGAbiolinksGUI.data")
```

Or from GitHub:

```
BiocManager::install("BioinformaticsFMRP/TCGAbiolinksGUI.data")
```

Load the package:

```
library(TCGAbiolinksGUI.data)
```

# 2 Contents

## 2.1 Creating list of GDC projects

The code below access the NCI’s Genomic Data Commons (GDC) and get the list of available datasets for The Cancer Genome Atlas (TCGA) and Therapeutically Applicable Research to Generate Effective Treatments (TARGET) projects.

```
# Defining parameters
getGDCdisease <- function(){
  projects <- TCGAbiolinks:::getGDCprojects()
  projects <- projects[projects$id != "FM-AD",]
  disease <-  projects$project_id
  idx <- grep("disease_type",colnames(projects))
  names(disease) <-  paste0(projects[[idx]], " (",disease,")")
  disease <- disease[sort(names(disease))]
  return(disease)
}
```

This data is in saved in the GDCdisease object.

```
data(GDCdisease)
DT::datatable(as.data.frame(GDCdisease))
```

## 2.2 List of MAF files

The code below downloads a manifest of open TCGA MAF files available in the NCI’s Genomic Data Commons (GDC).

```
getMafTumors <- function(){
  root <- "https://gdc-api.nci.nih.gov/data/"
  maf <- fread("https://gdc-docs.nci.nih.gov/Data/Release_Notes/Manifests/GDC_open_MAFs_manifest.txt",
               data.table = FALSE, verbose = FALSE, showProgress = FALSE)
  tumor <- unlist(lapply(maf$filename, function(x){unlist(str_split(x,"\\."))[2]}))
  proj <- TCGAbiolinks:::getGDCprojects()

  disease <-  gsub("TCGA-","",proj$project_id)
  idx <- grep("disease_type",colnames(proj))
  names(disease) <-  paste0(proj[[idx]], " (",proj$project_id,")")
  disease <- sort(disease)
  ret <- disease[disease %in% tumor]
  return(ret)
}
```

This data is in saved in the maf.tumor object.

```
data(maf.tumor)
DT::datatable(as.data.frame(maf.tumor))
```

## 2.3 Creating Training models

Based on the article data from the article “Molecular Profiling Reveals Biologically Discrete Subsets and Pathways of Progression in Diffuse Glioma” (www.cell.com/cell/abstract/S0092-8674(15)01692-X) (Ceccarelli et al. [2016](#ref-Cell)) we created a training model to predict Glioma classes based on DNA methylation signatures.

First, we will load the required libraries, control random number generation by specifying a seed and register the number of cores for parallel evaluation.

```
library(readr)
library(readxl)
library(dplyr)
library(caret)
library(randomForest)
library(doMC)
library(e1071)

# Control random number generation
set.seed(210) # set a seed to RNG

# register number of cores to be used for parallel evaluation
registerDoMC(cores = parallel::detectCores())
```

The next steps will download the DNA methylation matrix from the article: the DNA methylation data for glioma samples, samples metadata, and
DNA methylation signatures.

```
file <- "https://tcga-data.nci.nih.gov/docs/publications/lgggbm_2016/LGG.GBM.meth.txt"
if(!file.exists(basename(file))) downloader::download(file,basename(file))
LGG.GBM <- as.data.frame(readr::read_tsv(basename(file)))
rownames(LGG.GBM) <- LGG.GBM$Composite.Element.REF
idx <- grep("TCGA",colnames(LGG.GBM))
colnames(LGG.GBM)[idx] <- substr(colnames(LGG.GBM)[idx], 1, 12) # reduce complete barcode to sample identifier (first 12 characters)
```

We will get metadata with samples molecular subtypes from the paper: (www.cell.com/cell/abstract/S0092-8674(15)01692-X) (Ceccarelli et al. [2016](#ref-Cell))

```
file <- "http://www.cell.com/cms/attachment/2045372863/2056783242/mmc2.xlsx"
if(!file.exists(basename(file))) downloader::download(file,basename(file))
metadata <-  readxl::read_excel(basename(file), sheet = "S1A. TCGA discovery dataset", skip = 1)
DT::datatable(
  metadata[,c("Case",
              "Pan-Glioma DNA Methylation Cluster",
              "Supervised DNA Methylation Cluster",
              "IDH-specific DNA Methylation Cluster")]
)
```

Probes metadata information are downloaded from <http://zwdzwd.io/InfiniumAnnotation>
This will be used to remove probes that should be masked from the training.

```
file <- "http://zwdzwd.io/InfiniumAnnotation/current/EPIC/EPIC.manifest.hg38.rda"
if(!file.exists(basename(file))) downloader::download(file,basename(file))
load(basename(file))
```

Retrieve probe signatures from the paper.

```
file <- "https://tcga-data.nci.nih.gov/docs/publications/lgggbm_2015/PanGlioma_MethylationSignatures.xlsx"
if(!file.exists(basename(file))) downloader::download(file,basename(file))
```

With the data and metadata available we will create one model for each signature.
The code below selects the DNA methylation values for a given set of signatures (probes)
and uses the classification of each sample to create a Random forest model.
Each model is described in the next subsections.

### 2.3.1 RF to classify between IDHmut and IDHwt

| Parameters | Values |
| --- | --- |
| trainingset | whole TCGA panglioma cohort |
| probes signature | 1,300 pan-glioma tumor specific |
| groups to be classified | LGm1, LGm2, LGm3, LGm4, LGm5, LGm6 |
| metadata column | Pan-Glioma DNA Methylation Cluster |

We will start by preparing the training data. We will select the probes signatures for the group classification from the excel file
(for this case the 1,300 probes) and the samples that belong to the groups we want to create our model (in this case “LGm2” “LGm5” “LGm3” “LGm4” “LGm1” “LGm6”).

```
sheet <- "1,300 pan-glioma tumor specific"
trainingset <- grep("mut|wt",unique(metadata$`Pan-Glioma DNA Methylation Cluster`),value = T)
trainingcol <- c("Pan-Glioma DNA Methylation Cluster")
```

The DNA methylation matrix will be subset to the DNA methylation
signatures and samples with classification.

```
plat <- "EPIC"
signature.probes <-  read_excel("PanGlioma_MethylationSignatures.xlsx",  sheet = sheet)  %>% pull(1)
samples <- dplyr::filter(metadata, `IDH-specific DNA Methylation Cluster` %in% trainingset)
RFtrain <- LGG.GBM[signature.probes, colnames(LGG.GBM) %in% as.character(samples$Case)] %>% na.omit
```

Probes that should be masked, will be removed.

```
RFtrain <- RFtrain[!EPIC.manifest.hg38[rownames(RFtrain)]$MASK.general,]
```

We will merge the samples with their classification. In the end, we will have samples in the row, and probes and classification as columns.

```
trainingdata <- t(RFtrain)
trainingdata <- merge(trainingdata, metadata[,c("Case", trainingcol[model])], by.x=0,by.y="Case", all.x=T)
rownames(trainingdata) <- as.character(trainingdata$Row.names)
trainingdata$Row.names <- NULL
```

After the data prepared we will start the RF training by selecting tuning the mtry argument, which defines
the number of variables randomly sampled as candidates at each split. We will use the function tuneRF to optimal mtry
from values going from sqrt(p) where p is number of probes in the data up to 2 \* sqrt(p)
(see tuneRF function for more information). RF will use all mtry values and use the one that produced the best model.

```
nfeat <- ncol(trainingdata)
trainingdata[,trainingcol] <-  factor(trainingdata[,trainingcol])
mtryVals <- floor(sqrt(nfeat))
for(i in floor(seq(sqrt(nfeat), nfeat/2, by = 2 * sqrt(nfeat)))) {
  print(i)
  x <- as.data.frame(
    tuneRF(
      trainingdata[,-grep(trainingcol[model],colnames(trainingdata))],
      trainingdata[,trainingcol[model]],
      stepFactor=2,
      plot= FALSE,
      mtryStart = i
    )
  )
  mtryVals <- unique(c(mtryVals, x$mtry[which (x$OOBError == min(x$OOBError))]))
}
mtryGrid <- data.frame(.mtry = mtryVals)
```

We will use the training data to create our Random forest model. First, we will set up a repeated k-fold cross-validation.
We set k=10, which will split the data into 10 equal size sets. Of the 10 set, one is retained as the validation data for testing the model, and the remaining 9 sets are used as training data. The cross-validation process is then repeated 10 times (the folds), each time using a different set as the validation data. The 10 results from the folds can then be averaged (or otherwise combined) to produce a single estimation.
This procedure will be repeated 10 times, with different 10 equal size sets. The final model accuracy is taken as the mean from the number of repeats.

```
fitControl <- trainControl(
  method = "repeatedcv",
  number = 10,
  verboseIter = TRUE,
  repeats = 10
)
```

Create our Random forest model using the train frunction from the caret package.

```
glioma.idh.model <- train(
  y = trainingdata[,trainingcol], # variable to be trained on
  x = trainingdata[,-grep(trainingcol,colnames(trainingdata))], # Daat labels
  data = trainingdata, # Data we are using
  method = "rf", # Method we are using
  trControl = fitControl, # How we validate
  ntree = 5000, # number of trees
  importance = TRUE,
  tuneGrid = mtryGrid, # set mtrys, the value that procuded a better model is used
)
```

The IDH model are saved in *glioma.idh.model* object.

```
data(glioma.idh.model)
glioma.idh.model
```

```
## Random Forest
##
##  880 samples
## 1205 predictors
##    6 classes: 'LGm1', 'LGm2', 'LGm3', 'LGm4', 'LGm5', 'LGm6'
##
## No pre-processing
## Resampling: Cross-Validated (10 fold, repeated 10 times)
## Summary of sample sizes: 792, 793, 792, 791, 792, 794, ...
## Resampling results across tuning parameters:
##
##   mtry  Accuracy   Kappa
##    34   0.9166862  0.8928240
##    68   0.9171602  0.8935333
##    87   0.9169331  0.8932650
##   104   0.9168127  0.8931906
##   122   0.9179471  0.8946451
##   156   0.9189363  0.8959692
##   260   0.9183925  0.8953602
##   295   0.9190913  0.8962952
##   382   0.9189609  0.8961085
##   451   0.9154555  0.8916298
##
## Accuracy was used to select the optimal model using the largest value.
## The final value used for the model was mtry = 295.
```

### 2.3.2 RF to classify IDHmut specific clusters

| Parameters | Values |
| --- | --- |
| trainingset | TCGA IDHmut only |
| probes signature | 1,308 IDHmutant tumor specific |
| groups to be classified | IDHmut-K1, IDHmut-K2, IDHmut-K3 |
| metadata column | IDH-specific DNA Methylation Cluster |

To produce the model we will use the same code above but we will change the training data (probes and labels are different)

```
sheet <- "1,308 IDHmutant tumor specific "
trainingset <- grep("mut",unique(metadata$`IDH-specific DNA Methylation Cluster`),value = T)
trainingcol <- "IDH-specific DNA Methylation Cluster"
```

The IDHmut model are saved in glioma.idhmut.model object.

```
data(glioma.idhmut.model)
glioma.idhmut.model
```

```
## Random Forest
##
##  450 samples
## 1216 predictors
##    3 classes: 'IDHmut-K1', 'IDHmut-K2', 'IDHmut-K3'
##
## No pre-processing
## Resampling: Cross-Validated (10 fold, repeated 10 times)
## Summary of sample sizes: 405, 406, 405, 405, 404, 404, ...
## Resampling results across tuning parameters:
##
##   mtry  Accuracy   Kappa
##    34   0.9611239  0.9328999
##    87   0.9689140  0.9465985
##   136   0.9689386  0.9466341
##   149   0.9689188  0.9465882
##   157   0.9686966  0.9462056
##   192   0.9695952  0.9477192
##   208   0.9700203  0.9484758
##   297   0.9704795  0.9492448
##   313   0.9702621  0.9489050
##   383   0.9695706  0.9477601
##   488   0.9666953  0.9429666
##   523   0.9669323  0.9433384
##   906   0.9580071  0.9283147
##
## Accuracy was used to select the optimal model using the largest value.
## The final value used for the model was mtry = 297.
```

### 2.3.3 RF to classify between G-CIMP-low and G-CIMP-high

| Parameters | Values |
| --- | --- |
| trainingset | TCGA IDHmut-K1 and IDHmut-K2 only |
| probes signature | 163 probes that define each TC |
| groups to be classified | G-CIMP-low, G-CIMP-high |
| metadata column | Supervised DNA Methylation Cluster |

To produce the model we will use the same code above but we will change the training data (probes and labels are different).

```
sheet <- "163  probes that define each TC"
trainingset <- c("IDHmut-K1","IDHmut-K2")
trainingcol <- "Supervised DNA Methylation Cluster"
```

The G-CIMP model was saved in glioma.gcimp.model object.

```
data("glioma.gcimp.model")
glioma.gcimp.model
```

```
## Random Forest
##
## 276 samples
## 145 predictors
##   3 classes: 'G-CIMP-high', 'G-CIMP-low', 'NA'
##
## No pre-processing
## Resampling: Cross-Validated (10 fold, repeated 10 times)
## Summary of sample sizes: 249, 248, 249, 249, 248, 249, ...
## Resampling results across tuning parameters:
##
##   mtry  Accuracy   Kappa
##     9   0.9785038  0.8640637
##    12   0.9781334  0.8605572
##    18   0.9770488  0.8521752
##    30   0.9763468  0.8482224
##    48   0.9756184  0.8416317
##   120   0.9715963  0.8219569
##
## Accuracy was used to select the optimal model using the largest value.
## The final value used for the model was mtry = 9.
```

### 2.3.4 RF to classify IDHwt specific clusters

| Parameters | Values |
| --- | --- |
| trainingset | TCGA IDHwt only |
| probes signature | 914 IDHwildtype tumor specific |
| groups to be classified | IDHwt-K1, IDHwt-K2, IDHwt-K3 |
| metadata column | IDH-specific DNA Methylation Cluster |

Note: In this case, samples classified into IDHwt-K3
should be further subdivided by grade.

To produce the model we will use the same code above but we will change the training data (probes and labels are different)

```
sheet <- "914 IDHwildtype tumor specific "
trainingset <- grep("wt",unique(metadata$`IDH-specific DNA Methylation Cluster`),value = T))
trainingcol <- "IDH-specific DNA Methylation Cluster"
```

The IDHwt specific model which classifies are saved in glioma.idh.model object.

```
data("glioma.idhwt.model")
glioma.idhwt.model
```

```
## Random Forest
##
## 430 samples
## 843 predictors
##   3 classes: 'IDHwt-K1', 'IDHwt-K2', 'IDHwt-K3'
##
## No pre-processing
## Resampling: Cross-Validated (10 fold, repeated 10 times)
## Summary of sample sizes: 387, 386, 387, 387, 386, 387, ...
## Resampling results across tuning parameters:
##
##   mtry  Accuracy   Kappa
##    29   0.9183143  0.8613377
##    58   0.9213541  0.8671481
##   145   0.9217971  0.8681346
##   160   0.9223453  0.8691234
##   261   0.9188388  0.8633256
##   348   0.9160532  0.8583906
##   754   0.9086191  0.8456904
##   812   0.9058276  0.8408604
##
## Accuracy was used to select the optimal model using the largest value.
## The final value used for the model was mtry = 160.
```

## 2.4 EPIC probes to remove

The list of probes to be removed from EPIC array due to differences in library versions were taken from
<https://support.illumina.com/downloads/infinium-methylationepic-v1-0-product-files.html> (Infinium MethylationEPIC v1.0 Missing Legacy CpG (B3 vs. B2) Annotation File)

```
data("probes2rm")
head(probes2rm)
```

```
## [1] "cg00007969" "cg00022997" "cg00050873" "cg00130644" "cg00166868"
## [6] "cg00215431"
```

## 2.5 Parsing linked omics database

The code below will parse all links from omicsLinks website.

```
scraplinks <- function(url){
    # Create an html document from the url
    webpage <- xml2::read_html(url)
    # Extract the URLs
    url_ <- webpage %>%
        rvest::html_nodes("a") %>%
        rvest::html_attr("href")
    # Extract the link text
    link_ <- webpage %>%
        rvest::html_nodes("a") %>%
        rvest::html_text()
    tb <- tibble::tibble(link = link_, url = url_)
    tb <- tb %>% dplyr::filter(tb$link == "Download")
    return(tb)
}

library(htmltab)
library(dplyr)
library(tidyr)
root <- "http://linkedomics.org"
root.download <- file.path(root,"data_download")
linkedOmics <- htmltab(paste0(root,"/login.php#dataSource"))
linkedOmics <- linkedOmics %>% unite(col = "download_page","Cohort Source","Cancer ID", remove = FALSE,sep = "-")
linkedOmics.data <- plyr::adply(linkedOmics$download_page,1,function(project){
    url <- file.path(root.download,project)
    tryCatch({
        tb <- cbind(tibble::tibble(project),htmltab(url),scraplinks(url))
        tb$Link <- tb$link <- NULL
        tb$dataset <- gsub(" \\(.*","",tb$`OMICS Dataset`)
        tb
    }, error = function(e) {
        message(e)
        return(NULL)
    }
    )
},.progress = "time",.id = NULL)
usethis::use_data(linkedOmics.data,internal = FALSE,compress = "xz")
```

## 2.6 Gene information

### 2.6.1 Gene

```
get_gene_information_biomart <- function(
    genome = c("hg38","hg19"),
    TSS = FALSE
){
    requireNamespace("biomaRt")
    genome <- match.arg(genome)
    tries <- 0L
    msg <- character()
    while (tries < 3L) {
        gene.location <- tryCatch({
            host <- ifelse(
                genome == "hg19",
                "grch37.ensembl.org",
                "www.ensembl.org"
            )
            mirror <- list(NULL, "useast", "uswest", "asia")[[tries + 1]]
            ensembl <- tryCatch({
                message(
                    ifelse(
                        is.null(mirror),
                        paste0("Accessing ", host, " to get gene information"),
                        paste0("Accessing ", host, " (mirror ", mirror, ")")
                    )
                )
                biomaRt::useEnsembl(
                    "ensembl",
                    dataset = "hsapiens_gene_ensembl",
                    host = host,
                    mirror = mirror
                )
            }, error = function(e) {
                message(e)
                return(NULL)
            })

            # Column values we will recover from the database
            attributes <- c(
                "ensembl_gene_id",
                "external_gene_name",
                "entrezgene",
                "chromosome_name",
                "strand",
                "end_position",
                "start_position",
                "gene_biotype"
            )

            if (TSS)  attributes <- c(attributes, "transcription_start_site")

            db.datasets <- biomaRt::listDatasets(ensembl)
            description <- db.datasets[db.datasets$dataset == "hsapiens_gene_ensembl", ]$description
            message(paste0("Downloading genome information (try:", tries, ") Using: ", description))
            gene.location <- biomaRt::getBM(
                attributes = attributes,
                filters = "chromosome_name",
                values = c(seq_len(22),"X","Y"),
                mart = ensembl
            )
            gene.location
        }, error = function(e) {
            msg <<- conditionMessage(e)
            tries <<- tries + 1L
            NULL
        })
        if (!is.null(gene.location)) break
        if (tries == 3L) stop("failed to get URL after 3 tries:", "\n  error: ", msg)
    }
}
gene.location.hg19 <- get_gene_information_biomart("hg19")
save(gene.location.hg19, file = "gene.location.hg19.rda")

gene.location.hg38 <- get_gene_information_biomart("hg38")
save(gene.location.hg38, file = "gene.location.hg38.rda")
```

### 2.6.2 TSS

```
library(biomaRt)
getTSS <- function(
    genome = "hg38",
    TSS = list(upstream = NULL, downstream = NULL)
) {
    host <- ifelse(genome == "hg19",  "grch37.ensembl.org", "www.ensembl.org")
    ensembl <- tryCatch({
        useEnsembl(biomart = "ensembl", dataset = "hsapiens_gene_ensembl", host =  host)
    },  error = function(e) {
        useEnsembl(
          biomart = "ensembl",
            dataset = "hsapiens_gene_ensembl",
            host =  host
        )
    })
    attributes <- c(
        "chromosome_name",
        "start_position",
        "end_position",
        "strand",
        "transcript_start",
        "transcription_start_site",
        "transcript_end",
        "ensembl_transcript_id",
        "ensembl_gene_id",
        "external_gene_name"
    )

    chrom <- c(1:22, "X", "Y")
    db.datasets <- listDatasets(ensembl)
    description <- db.datasets[db.datasets$dataset == "hsapiens_gene_ensembl", ]$description
    message(paste0("Downloading transcripts information. Using: ", description))

    tss <- getBM(
        attributes = attributes,
        filters = c("chromosome_name"),
        values = list(chrom),
        mart = ensembl
    )
    tss <- tss[!duplicated(tss$ensembl_transcript_id), ]
    if (genome == "hg19") tss$external_gene_name <- tss$external_gene_id
    tss$chromosome_name <-  paste0("chr", tss$chromosome_name)
    tss$strand[tss$strand == 1] <- "+"
    tss$strand[tss$strand == -1] <- "-"

    tss <- makeGRangesFromDataFrame(
        tss,
        start.field = "transcript_start",
        end.field = "transcript_end",
        keep.extra.columns = TRUE
    )

    if (!is.null(TSS$upstream) & !is.null(TSS$downstream)) {
        tss <- promoters(
            tss,
            upstream = TSS$upstream,
            downstream = TSS$downstream
        )
    }
    return(tss)
}

gene.location.hg19.tss <- getTSS("hg19")
save(gene.location.hg19.tss, file = "gene.location.hg19.tss.rda")

gene.location.hg38.tss <- getTSS("hg38")
save(gene.location.hg38.tss, file = "gene.location.hg38.tss.rda")
```

# 3 Session Information

---

```
sessionInfo()
```

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
## [1] TCGAbiolinksGUI.data_1.30.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6         xfun_0.54            bslib_0.9.0
##  [4] ggplot2_4.0.0        htmlwidgets_1.6.4    recipes_1.3.1
##  [7] lattice_0.22-7       vctrs_0.6.5          tools_4.5.1
## [10] crosstalk_1.2.2      generics_0.1.4       stats4_4.5.1
## [13] parallel_4.5.1       tibble_3.3.0         ModelMetrics_1.2.2.2
## [16] pkgconfig_2.0.3      Matrix_1.7-4         data.table_1.17.8
## [19] RColorBrewer_1.1-3   S7_0.2.0             lifecycle_1.0.4
## [22] stringr_1.5.2        compiler_4.5.1       farver_2.1.2
## [25] codetools_0.2-20     htmltools_0.5.8.1    class_7.3-23
## [28] sass_0.4.10          yaml_2.3.10          prodlim_2025.04.28
## [31] pillar_1.11.1        jquerylib_0.1.4      MASS_7.3-65
## [34] DT_0.34.0            cachem_1.1.0         gower_1.0.2
## [37] iterators_1.0.14     rpart_4.1.24         foreach_1.5.2
## [40] nlme_3.1-168         parallelly_1.45.1    lava_1.8.2
## [43] tidyselect_1.2.1     digest_0.6.37        stringi_1.8.7
## [46] future_1.67.0        reshape2_1.4.4       purrr_1.1.0
## [49] dplyr_1.1.4          bookdown_0.45        listenv_0.10.0
## [52] splines_4.5.1        fastmap_1.2.0        grid_4.5.1
## [55] cli_3.6.5            magrittr_2.0.4       dichromat_2.0-0.1
## [58] survival_3.8-3       future.apply_1.20.0  withr_3.0.2
## [61] scales_1.4.0         lubridate_1.9.4      timechange_0.3.0
## [64] rmarkdown_2.30       globals_0.18.0       nnet_7.3-20
## [67] timeDate_4051.111    evaluate_1.0.5       knitr_1.50
## [70] hardhat_1.4.2        caret_7.0-1          rlang_1.1.6
## [73] Rcpp_1.1.0           glue_1.8.0           BiocManager_1.30.26
## [76] pROC_1.19.0.1        ipred_0.9-15         jsonlite_2.0.0
## [79] R6_2.6.1             plyr_1.8.9
```

# References

Ceccarelli, Michele, FlorisP. Barthel, TathianeM. Malta, ThaisS. Sabedot, SofieR. Salama, BradleyA. Murray, Olena Morozova, et al. 2016. “Molecular Profiling Reveals Biologically Discrete Subsets and Pathways of Progression in Diffuse Glioma.” *Cell* 164 (3): 550–63. [https://doi.org/http://dx.doi.org/10.1016/j.cell.2015.12.028](https://doi.org/http%3A//dx.doi.org/10.1016/j.cell.2015.12.028).

Silva, Tiago C, Antonio Colaprico, Catharina Olsen, Gianluca Bontempi, Michele Ceccarelli, Benjamin P Berman, and Houtan Noushmehr. 2017. “TCGAbiolinksGUI: A Graphical User Interface to Analyze Gdc Cancer Molecular and Clinical Data.” *bioRxiv*, 147496.