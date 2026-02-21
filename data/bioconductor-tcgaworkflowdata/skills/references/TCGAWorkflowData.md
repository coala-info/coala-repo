# Example data for TCGA Workflow: Analyze cancer genomics and epigenomics data using Bioconductor packages

Tiago C. Silva, Antonio Colaprico, Catharina Olsen, Fulvio D’Angelo, Gianluca Bontempi Michele Ceccarelli , and Houtan Noushmehr

#### 2025-11-04

# Contents

* [1 Data Introduction](#data-introduction)
* [2 Loading the data](#loading-the-data)
* [3 Data creation](#data-creation)
  + [3.1 Genes information](#genes-information)
  + [3.2 GISTIC results](#gistic-results)
  + [3.3 Gene expression data](#gene-expression-data)
  + [3.4 DNA methylation and Gene expression data](#dna-methylation-and-gene-expression-data)
  + [3.5 Mutation data](#mutation-data)
  + [3.6 Biogrid data](#biogrid-data)
  + [3.7 Histone marks](#histone-marks)
* [4 Session info](#session-info)

# 1 Data Introduction

This package provides a dataset for those wishing to try out the
[TCGA Workflow: Analyze cancer genomics and epigenomics data using Bioconductor packages](https://f1000research.com/articles/5-1542/v2) [@10.12688/f1000research.8923.2].
The data in this package are a subset of the TCGA data
for LGG (Lower grade glioma) and GBM (Glioblastoma multiforme) samples.

# 2 Loading the data

```
library(TCGAWorkflowData)
data("elmerExample")
data("TCGA_LGG_Transcriptome_20_samples")
data("TCGA_GBM_Transcriptome_20_samples")
data("histoneMarks")
data("biogrid")
data("genes_GR")
data("maf_lgg_gbm")
```

# 3 Data creation

The following commands were used to create the data included with this package.

## 3.1 Genes information

Download gene information for hg19 using TCGAbiolinks, which uses biomart parckage.

```
library(GenomicRanges)
library(TCGAbiolinks)
##############################
## Recurrent CNV annotation ##
##############################
# Get gene information from GENCODE using biomart
genes <- TCGAbiolinks:::get.GRCh.bioMart(genome = "hg19")
genes <- genes[genes$external_gene_id != "" & genes$chromosome_name %in% c(1:22,"X","Y"),]
genes[genes$chromosome_name == "X", "chromosome_name"] <- 23
genes[genes$chromosome_name == "Y", "chromosome_name"] <- 24
genes$chromosome_name <- sapply(genes$chromosome_name,as.integer)
genes <- genes[order(genes$start_position),]
genes <- genes[order(genes$chromosome_name),]
genes <- genes[,c("external_gene_id", "chromosome_name", "start_position","end_position")]
colnames(genes) <- c("GeneSymbol","Chr","Start","End")
genes_GR <- makeGRangesFromDataFrame(genes,keep.extra.columns = TRUE)
save(genes_GR,genes,file = "genes_GR.rda", compress = "xz")
```

## 3.2 GISTIC results

Download and save a subset of GBM GISTIC results from GDAC firehose.

```
library(RTCGAToolbox)
# Download GISTIC results
lastAnalyseDate <- getFirehoseAnalyzeDates(1)
gistic <- getFirehoseData(
  dataset = "GBM",
  gistic2_Date = lastAnalyseDate,
  GISTIC = TRUE
)

# get GISTIC results
gistic_allbygene <- getData(
  gistic,
  type = "GISTIC",
  platform = "AllByGene"
)

gistic_thresholedbygene <- getData(
  gistic,
  type = "GISTIC",
  platform = "ThresholdedByGene"
)

save(
  gistic_allbygene,
  gistic_thresholedbygene,
  file = "GBMGistic.rda", compress = "xz"
)
```

## 3.3 Gene expression data

The following code will download 20 LGG (Lower grade glioma) and 20 GBM (Glioblastoma multiforme)
samples that have gene expression data. The Gene expression data is the raw expression signal for expression of a gene.

```
query_exp_lgg <- GDCquery(
  project = "TCGA-LGG",
  data.category = "Transcriptome Profiling",
  data.type = "Gene Expression Quantification",
  workflow.type = "STAR - Counts"
)
# Get only first 20 samples to make example faster
query_exp_lgg$results[[1]] <- query_exp_lgg$results[[1]][1:20,]
GDCdownload(query_exp_lgg)
exp_lgg <- GDCprepare(
  query = query_exp_lgg
)

query_exp_gbm <- GDCquery(
  project = "TCGA-GBM",
  data.category = "Transcriptome Profiling",
  data.type = "Gene Expression Quantification",
  workflow.type = "STAR - Counts"
)
# Get only first 20 samples to make example faster
query_exp_gbm$results[[1]] <- query_exp_gbm$results[[1]][1:20,]
GDCdownload(query_exp_gbm)
exp_gbm <- GDCprepare(
  query = query_exp_gbm
)
```

## 3.4 DNA methylation and Gene expression data

The following code will select 10 LGG (Lower grade glioma) and 10 GBM (Glioblastoma multiforme) samples that have both
DNA methylation and gene expression data. This objects will be then prepared
to the format accept by the Biocondcutor package
*[ELMER](https://bioconductor.org/packages/3.22/ELMER)*([link])(<http://bioconductor.org/packages/release/bioc/html/ELMER.html>).
The DNA methylation will have only probes in chromossome 9 in order to make the example
of the workflow faster. For a real analysis, all chromossomes should be used.
The Gene expression data is the normalized results for expression of a gene.

```
#----------- 8.3 Identification of Regulatory Enhancers   -------
library(TCGAbiolinks)
# Samples: primary solid tumor w/ DNA methylation and gene expression
matched_met_exp <- function(project, n = NULL){
  # get primary solid tumor samples: DNA methylation
  message("Download DNA methylation information")
  met450k <- GDCquery(
    project = project,
    data.category = "DNA Methylation",
    platform = "Illumina Human Methylation 450",
    data.type = "Methylation Beta Value",
    sample.type = c("Primary Tumor")
  )
  met450k.tp <-  met450k$results[[1]]$cases

  # get primary solid tumor samples: RNAseq
  message("Download gene expression information")
  exp <- GDCquery(
    project = project,
    data.category = "Transcriptome Profiling",
    data.type = "Gene Expression Quantification",
    workflow.type = "STAR - Counts"
    sample.type = c("Primary Tumor")
  )

  exp.tp <- exp$results[[1]]$cases
  # Get patients with samples in both platforms
  patients <- unique(substr(exp.tp,1,15)[substr(exp.tp,1,12) %in% substr(met450k.tp,1,12)] )
  if(!is.null(n)) patients <- patients[1:n] # get only n samples
  return(patients)
}
lgg.samples <- matched_met_exp("TCGA-LGG", n = 10)
gbm.samples <- matched_met_exp("TCGA-GBM", n = 10)
samples <- c(lgg.samples,gbm.samples)

#-----------------------------------
# 1 - Methylation
# ----------------------------------
query.met <- GDCquery(
  project = c("TCGA-LGG","TCGA-GBM"),
  data.category = "DNA Methylation",
  platform = "Illumina Human Methylation 450",
  data.type = "Methylation Beta Value",
  barcode = samples
)
GDCdownload(query.met)
met <- GDCprepare(query.met, save = FALSE)
met <- subset(met,subset = as.character(GenomicRanges::seqnames(met)) %in% c("chr9"))

#-----------------------------------
# 2 - Expression
# ----------------------------------
query.exp <- GDCquery(
  project = c("TCGA-LGG","TCGA-GBM"),
  data.category = "Transcriptome Profiling",
  data.type = "Gene Expression Quantification",
  workflow.type = "STAR - Counts"
  sample.type = c("Primary Tumor")
  barcode =  samples
)
GDCdownload(query.exp)
exp <- GDCprepare(query.exp, save = FALSE)
save(exp, met, gbm.samples, lgg.samples, file = "elmerExample.rda", compress = "xz")
```

## 3.5 Mutation data

The following code will download Mutation annotation files (aligned against the genoem of reference hg38)
for LGG and GBM samples and merge them into one single single file. The GDC Somatic Mutation Calling Workflow
used is the mutect2. For more information please check [GDC](https://docs.gdc.cancer.gov/Data/Bioinformatics_Pipelines/DNA_Seq_Variant_Calling_Pipeline/).

```
library(TCGAbiolinks)
query <- GDCquery(
  project = c("TCGA-LGG","TCGA-GBM"),
  data.category = "Simple Nucleotide Variation",
  access = "open",
  data.type = "Masked Somatic Mutation",
  workflow.type = "Aliquot Ensemble Somatic Variant Merging and Masking"
)
GDCdownload(query)
maf <- GDCprepare(query)
save(maf,file = "maf_lgg_gbm.rda",compress = "xz")
```

## 3.6 Biogrid data

Download biogrid information.

```
### read biogrid info
### Check last version in https://thebiogrid.org/download.php
file <- "https://downloads.thebiogrid.org/Download/BioGRID/Latest-Release/BIOGRID-ALL-LATEST.tab2.zip"
if(!file.exists(gsub("zip","txt",basename(file)))){
  downloader::download(file,basename(file))
  unzip(basename(file),junkpaths =TRUE)
}

tmp.biogrid <- vroom::vroom(
  dir(pattern = "BIOGRID-ALL.*\\.txt")
)
save(tmp.biogrid, file = "biogrid.rda", compress = "xz")
```

## 3.7 Histone marks

The code below was used to download histone marks specific for brain tissue using
the AnnotationHub package that can access the Roadmap database.

# 4 Session info

**R version 4.5.1 Patched (2025-08-23 r88802)**

**Platform:** x86\_64-pc-linux-gnu

**locale:**
*LC\_CTYPE=en\_US.UTF-8*, *LC\_NUMERIC=C*, *LC\_TIME=en\_GB*, *LC\_COLLATE=C*, *LC\_MONETARY=en\_US.UTF-8*, *LC\_MESSAGES=en\_US.UTF-8*, *LC\_PAPER=en\_US.UTF-8*, *LC\_NAME=C*, *LC\_ADDRESS=C*, *LC\_TELEPHONE=C*, *LC\_MEASUREMENT=en\_US.UTF-8* and *LC\_IDENTIFICATION=C*

**attached base packages:**

* stats
* graphics
* grDevices
* utils
* datasets
* methods
* base

**other attached packages:**

* TCGAWorkflowData(v.1.34.0)
* BiocStyle(v.2.38.0)

**loaded via a namespace (and not attached):**

* Matrix(v.1.7-4)
* jsonlite(v.2.0.0)
* compiler(v.4.5.1)
* BiocManager(v.1.30.26)
* Rcpp(v.1.1.0)
* SummarizedExperiment(v.1.40.0)
* Biobase(v.2.70.0)
* GenomicRanges(v.1.62.0)
* jquerylib(v.0.1.4)
* IRanges(v.2.44.0)
* Seqinfo(v.1.0.0)
* yaml(v.2.3.10)
* fastmap(v.1.2.0)
* lattice(v.0.22-7)
* R6(v.2.6.1)
* XVector(v.0.50.0)
* S4Arrays(v.1.10.0)
* generics(v.0.1.4)
* knitr(v.1.50)
* BiocGenerics(v.0.56.0)
* DelayedArray(v.0.36.0)
* bookdown(v.0.45)
* pander(v.0.6.6)
* MatrixGenerics(v.1.22.0)
* bslib(v.0.9.0)
* rlang(v.1.1.6)
* cachem(v.1.1.0)
* xfun(v.0.54)
* sass(v.0.4.10)
* SparseArray(v.1.10.1)
* cli(v.3.6.5)
* digest(v.0.6.37)
* grid(v.4.5.1)
* lifecycle(v.1.0.4)
* S4Vectors(v.0.48.0)
* evaluate(v.1.0.5)
* abind(v.1.4-8)
* stats4(v.4.5.1)
* rmarkdown(v.2.30)
* matrixStats(v.1.5.0)
* tools(v.4.5.1)
* htmltools(v.0.5.8.1)