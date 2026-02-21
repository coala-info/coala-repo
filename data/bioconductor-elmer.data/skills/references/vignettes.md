# ELMER.data: Supporting data for the ELMER package

Tiago Chedraoui Silva, Simon Coetzee, Nicole Gull, Lijing Yao, Peggy Farnham, Hui Shen, Peter Laird, Houtan Noushmehr, De-Chen Lin, Benjamin P. Berman

#### 2025-11-04

# 1 Introduction

This document provides an introduction of the *[ELMER.data](https://bioconductor.org/packages/3.22/ELMER.data)*, which contains
supporting data for *[ELMER](https://bioconductor.org/packages/3.22/ELMER)* (Yao, L., Shen, H., Laird, P. W., Farnham, P. J., & Berman, B. P. [2015](#ref-ELMER)). *[ELMER](https://bioconductor.org/packages/3.22/ELMER)* is package using DNA methylation to
identify enhancers, and correlates enhancer state with expression of nearby genes
to identify one or more transcriptional targets. Transcription factor (TF) binding
site analysis of enhancers is coupled with expression analysis of all TFs to
infer upstream regulators. *[ELMER.data](https://bioconductor.org/packages/3.22/ELMER.data)* provide 3 necessary data for
*[ELMER](https://bioconductor.org/packages/3.22/ELMER)* analysis:

1. Probes information: files with DNA methylation platforms metadata retrieved from <http://zwdzwd.github.io/InfiniumAnnotation> (Zhou, Wanding and Laird, Peter W and Shen, Hui [2016](#ref-zhou2016comprehensive)).
2. Probes.motif: motif occurences within \(\pm 250bp\) of probe sites on HM450K/EPIC array aligned against hg19/hg38.

## 1.1 Installing and loading ELMER.data

To install this package, start R and enter

```
devtools::install_github(repo = "tiagochst/ELMER.data")
library("ELMER.data")
library("GenomicRanges")
```

# 2 Contents

## 2.1 ENSEMBL gene and TSS information

Data from GRCh38.p12 and GRCh37.p13 accessed via biomart.

```
getTranscripts <- function(genome = "hg38"){

  tries <- 0L
  msg <- character()
  while (tries < 3L) {
    tss <- tryCatch({
      host <- ifelse(genome == "hg19",  "grch37.ensembl.org","www.ensembl.org")
      message("Accessing ", host, " to get TSS information")

      ensembl <- tryCatch({
        useEnsembl("ensembl", dataset = "hsapiens_gene_ensembl", host =  host)
      },  error = function(e) {
        message(e)
        for(mirror in c("asia","useast","uswest")){
          x <- useEnsembl("ensembl",
                          dataset = "hsapiens_gene_ensembl",
                          mirror = mirror,
                          host =  host)
          if(class(x) == "Mart") {
            return(x)
          }
        }
        return(NULL)
      })

      if(is.null(host)) {
        message("Problems accessing ensembl database")
        return(NULL)
      }
      attributes <- c("chromosome_name",
                      "start_position",
                      "end_position", "strand",
                      "ensembl_gene_id",
                      "transcription_start_site",
                      "transcript_start",
                      "ensembl_transcript_id",
                      "transcript_end",
                      "external_gene_name")
      chrom <- c(1:22, "X", "Y","M","*")
      db.datasets <- listDatasets(ensembl)
      description <- db.datasets[db.datasets$dataset=="hsapiens_gene_ensembl",]$description
      message(paste0("Downloading transcripts information from ", ensembl@host, ". Using: ", description))

      filename <-  paste0(gsub("[[:punct:]]| ", "_",description),"_tss.rda")
      tss <- getBM(attributes = attributes, filters = c("chromosome_name"), values = list(chrom), mart = ensembl)
      tss <- tss[!duplicated(tss$ensembl_transcript_id),]
      save(tss, file = filename, compress = "xz")
    })
  }
  return(tss)
}

getGenes <- function (genome = "hg19"){
  tries <- 0L
  msg <- character()
  while (tries < 3L) {
    gene.location <- tryCatch({
      host <- ifelse(genome == "hg19", "grch37.ensembl.org",
                     "www.ensembl.org")
      message("Accessing ", host, " to get gene information")
      ensembl <- tryCatch({
        useEnsembl("ensembl", dataset = "hsapiens_gene_ensembl",
                   host = host)
      }, error = function(e) {
        message(e)
        for (mirror in c("asia", "useast", "uswest")) {
          x <- useEnsembl("ensembl", dataset = "hsapiens_gene_ensembl",
                          mirror = mirror, host = host)
          if (class(x) == "Mart") {
            return(x)
          }
        }
        return(NULL)
      })
      if (is.null(host)) {
        message("Problems accessing ensembl database")
        return(NULL)
      }
      attributes <- c("chromosome_name", "start_position",
                      "end_position", "strand", "ensembl_gene_id",
                      "entrezgene", "external_gene_name")
      db.datasets <- listDatasets(ensembl)
      description <- db.datasets[db.datasets$dataset ==
                                   "hsapiens_gene_ensembl", ]$description
      message(paste0("Downloading genome information (try:",
                     tries, ") Using: ", description))
      filename <- paste0(gsub("[[:punct:]]| ", "_", description),
                         ".rda")
      if (!file.exists(filename)) {
        chrom <- c(1:22, "X", "Y")
        gene.location <- getBM(attributes = attributes,
                               filters = c("chromosome_name"), values = list(chrom),
                               mart = ensembl)
      }
      gene.location
    }, error = function(e) {
      msg <<- conditionMessage(e)
      tries <<- tries + 1L
    })
    if (!is.null(gene.location)) break
  }
  if (tries == 3L)
    stop("failed to get URL after 3 tries:", "\n  error: ", msg)

  return(gene.location)
}

Human_genes__GRCh37_p13__tss <- getTranscripts(genome = "hg19")
Human_genes__GRCh38_p12__tss <- getTranscripts(genome = "hg38")
Human_genes__GRCh37_p13 <- getGenes("hg19")
Human_genes__GRCh38_p12 <- getGenes("hg38")
save(Human_genes__GRCh37_p13__tss,
     file = "Human_genes__GRCh37_p13__tss.rda",
     compress = "xz")

save(Human_genes__GRCh38_p12,
     file = "Human_genes__GRCh38_p12.rda",
     compress = "xz")

save(Human_genes__GRCh38_p12__tss,
     file = "Human_genes__GRCh38_p12__tss.rda",
     compress = "xz")

save(Human_genes__GRCh37_p13,
     file = "Human_genes__GRCh37_p13.rda",
     compress = "xz")
```

## 2.2 Probes information

Probes information were retrieved from <http://zwdzwd.github.io/InfiniumAnnotation> (Zhou, Wanding and Laird, Peter W and Shen, Hui [2016](#ref-zhou2016comprehensive)).

```
for(plat in c("450K","EPIC")) {
  for(genome in c("hg38","hg19")) {
    base <- "http://zwdzwd.io/InfiniumAnnotation/current/"
    path <- file.path(base,plat,paste(plat,"hg19.manifest.rds", sep ="."))
    if (grepl("hg38", genome)) path <- gsub("hg19","hg38",path)
    if(plat == "EPIC") {
      annotation <- paste0(base,"EPIC/EPIC.hg19.manifest.rds")
    } else {
      annotation <- paste0(base,"hm450/hm450.hg19.manifest.rds")
    }
    if(grepl("hg38", genome)) annotation <- gsub("hg19","hg38",annotation)
    if(!file.exists(basename(annotation))) {
      if(Sys.info()["sysname"] == "Windows") mode <- "wb" else  mode <- "w"
      downloader::download(annotation, basename(annotation), mode = mode)
    }
  }
}

devtools::use_data(EPIC.hg19.manifest,overwrite = T,compress = "xz")
devtools::use_data(EPIC.hg38.manifest,overwrite = T,compress = "xz")
devtools::use_data(hm450.hg19.manifest,overwrite = T,compress = "xz")
devtools::use_data(hm450.hg38.manifest,overwrite = T,compress = "xz")
```

```
data("EPIC.hg19.manifest")
as.data.frame(EPIC.hg19.manifest)[1:5,] %>% datatable(options = list(scrollX = TRUE,pageLength = 5))
```

```
data("EPIC.hg38.manifest")
as.data.frame(EPIC.hg38.manifest)[1:5,] %>% datatable(options = list(scrollX = TRUE,pageLength = 5))
```

```
data("hm450.hg19.manifest")
as.data.frame(hm450.hg19.manifest)[1:5,] %>% datatable(options = list(scrollX = TRUE,pageLength = 5))
```

```
data("hm450.hg38.manifest")
as.data.frame(hm450.hg38.manifest)[1:5,] %>% datatable(options = list(scrollX = TRUE,pageLength = 5))
```

## 2.3 TF family and subfamily classifications

ELMER uses the TFClass (Wingender, E., Schoeps, T., Haubrock, M., & Dönitz, J [2014](#ref-wingender2014tfclass)), a classification of eukaryotic transcription factors based on the characteristics of their DNA-binding domains, to identify which are the TF that might be binding to the same region. For example, if a FOXA1 motif is found in a region, there is FOXA2 would also be able to bind to that region. For that ELMER uses two classifications, Family and sub-family. TFClass schema is shown below.

TFClass schema is below:

| Level | Rank denomination | Definition | Example |
| --- | --- | --- | --- |
| 1 | Superclass | General topology of the DNA-binding domain | Zinc-coordinating DNA-binding domains (Superclass 2) |
| 2 | Class | Structural blueprint of the DNA-binding domain | Nuclear receptors with C4 zinc fingers (Class 2.1) |
| 3 | Family | Sequence & functional similarity | Thyroid hormone receptor-related factors (NR1) (Family 2.1.2) |
| 4 | Subfamily | Sequence-based subgroupings | Retinoic acid receptors (NR1B) (Subfamily 2.1.2.1) |
| 5 | Genus | Transcription factor gene | RAR-α (Genus 2.1.2.1.1) |
| 4 | Species | TF polypeptide | RAR-α1 (Species 2.1.2.1.1.1) |

The following code was used to create the objects:

```
library(xml2)
library(httr)
library(dplyr)
library(rvest)
createMotifRelevantTfs <- function(classification = "family"){

  message("Accessing hocomoco to get last version of TFs ", classification)
  file <- paste0(classification,".motif.relevant.TFs.rda")

  # Download from http://hocomoco.autosome.ru/human/mono
  tf.family <- "http://hocomoco11.autosome.ru/human/mono?full=true" %>% read_html()  %>%  html_table()
  tf.family <- tf.family[[1]]
  # Split TF for each family, this will help us map for each motif which are the some ones in the family
  # basicaly: for a TF get its family then get all TF in that family
  col <- ifelse(classification == "family", "TF family","TF subfamily")
  family <- split(tf.family,f = tf.family[[col]])

  motif.relevant.TFs <- plyr::alply(tf.family,1, function(x){
    f <- x[[col]]
    if(f == "") return(x$`Transcription factor`) # Case without family, we will get only the same object
    return(unique(family[as.character(f)][[1]]$`Transcription factor`))
  },.progress = "text")
  #names(motif.relevant.TFs) <- tf.family$`Transcription factor`
  names(motif.relevant.TFs) <- tf.family$Model
  # Cleaning object
  attr(motif.relevant.TFs,which="split_type") <- NULL
  attr(motif.relevant.TFs,which="split_labels") <- NULL

  return(motif.relevant.TFs)
}

updateTFClassList <- function(tf.list, classification = "family"){
  col <- ifelse(classification == "family","family.name","subfamily.name")
  TFclass <- getTFClass()
  # Hocomoco
  tf.family <- "http://hocomoco11.autosome.ru/human/mono?full=true" %>% read_html()  %>%  html_table()
  tf.family <- tf.family[[1]]

  tf.members <- plyr::alply(unique(TFclass %>% pull(col)),1, function(x){
    TFclass$Gene[which(x == TFclass[,col])]
  },.progress = "text")
  names(tf.members) <- unique(TFclass %>% pull(col))
  attr(tf.members,which="split_type") <- NULL
  attr(tf.members,which="split_labels") <- NULL

  for(i in names(tf.list)){
    x <- tf.family[tf.family$Model == i,"Transcription factor"]
    idx <- which(sapply(lapply(tf.members, function(ch) grep(paste0("^",x,"$"), ch)), function(x) length(x) > 0))
    if(length(idx) == 0) next
    members <- tf.members[[idx]]
    tf.list[[i]] <- sort(unique(c(tf.list[[i]],members)))
  }
  return(tf.list)
}

getTFClass <- function(){
  # get TF classification
  file <- "TFClass.rda"
  if(file.exists(file)) {
    return(get(load(file)))
  }
  file <- "http://tfclass.bioinf.med.uni-goettingen.de/suppl/tfclass.ttl.gz"
  downloader::download(file,basename(file))
  char_vector <- readLines(basename(file))
  # Find TF idx
  idx <- grep("genus",char_vector,ignore.case = T)

  # get TF names
  TF <- char_vector[sort(c( idx +1, idx + 2, idx + 4))]
  TF <- TF[-grep("LOGO_|rdf:type",TF)]
  TF <- gsub("  rdfs:label | ;| rdfs:subClassOf <http://sybig.de/tfclass#|>","",TF)
  TF <- stringr::str_trim(gsub('"', '', TF))
  TF <- tibble::as.tibble(t(matrix(TF,nrow = 2)))
  colnames(TF) <- c("Gene", "class")

  # Get family and subfamily classification
  family.pattern <-  "^<http://sybig.de/tfclass#[0-9]+\\.[0-9]+\\.[0-9]+>"

  idx <- grep(family.pattern,char_vector)
  family.names <- char_vector[ sort(c(idx,idx+ 2))]
  family.names <- gsub("  rdfs:label | ;| rdfs:subClassOf <http://sybig.de/tfclass#|>|<http://sybig.de/tfclass#| rdf:type owl:Class","",family.names)
  family.names <- stringr::str_trim(gsub('"', '', family.names))
  family.names <- tibble::as.tibble(t(matrix(family.names,nrow = 2)))
  colnames(family.names) <- c("family", "family.name")

  subfamily.pattern <-  "^<http://sybig.de/tfclass#[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+>"

  idx <- grep(subfamily.pattern,char_vector)
  subfamily.names <- char_vector[ sort(c(idx,idx+ 2))]
  subfamily.names <- gsub("  rdfs:label | ;| rdfs:subClassOf <http://sybig.de/tfclass#|>|<http://sybig.de/tfclass#| rdf:type owl:Class","",subfamily.names)
  subfamily.names <- stringr::str_trim(gsub('"', '', subfamily.names))
  subfamily.names <- tibble::as.tibble(t(matrix(subfamily.names,nrow = 2)))
  colnames(subfamily.names) <- c("subfamily", "subfamily.name")
  subfamily.names$family <- stringr::str_sub(subfamily.names$subfamily,1,5)

  classification <- left_join(family.names,subfamily.names)
  classification$class <- ifelse(is.na(classification$subfamily),classification$family,classification$subfamily)

  # Add classification to TF list
  TFclass <- left_join(TF,classification)

  # Break ( into multiple cases)
  m <- grep("\\(|/",TFclass$Gene)
  df <- NULL
  for(i in m){
    gene <- sort(stringr::str_trim(unlist(stringr::str_split(TFclass$Gene[i],"\\(|,|\\)|/"))))
    gene <- gene[stringr::str_length(gene) > 0]
    aux <- TFclass[rep(i,length(gene)),]
    aux$Gene <- gene
    df <- rbind(df,aux)
  }
  TFclass <- rbind(TFclass,df)
  TFclass <- TFclass[!duplicated(TFclass),]

  # Break ( into multiple cases)
  m <- grep("-",TFclass$Gene)
  df <- NULL
  for(i in m){
    gene <- gsub("-","",sort(stringr::str_trim(unlist(stringr::str_split(TFclass$Gene[i],"\\(|,|\\)|/")))))
    gene <- gene[stringr::str_length(gene) > 0]
    aux <- TFclass[rep(i,length(gene)),]
    aux$Gene <- gene
    df <- rbind(df,aux)
  }
  TFclass <- rbind(TFclass,df)

  df <- NULL
  for(i in 1:length(TFclass$Gene)){
    m <- TFclass$Gene[i]
    gene <- unique(c(toupper(alias2Symbol(toupper(m))),toupper(m),toupper(alias2Symbol(m))))
    if(all(gene %in% TFclass$Gene)) next
    aux <- TFclass[rep(i,length(gene)),]
    aux$Gene <- gene
    df <- rbind(df,aux)
  }
  TFclass <- rbind(TFclass,df)
  TFclass <- TFclass[!duplicated(TFclass),]
  TFclass <- TFclass[TFclass$Gene %in% human.TF$external_gene_name,]
  save(TFclass,file = "TFClass.rda")
  return(TFclass)
}
TF.family <- createMotifRelevantTfs("family")
TF.family <- updateTFClassList(TF.family,"family")
TF.subfamily <- createMotifRelevantTfs("subfamily")
TF.subfamily <- updateTFClassList(TF.subfamily,classification = "subfamily")
save(TF.family,file = "~/ELMER.data/data/TF.family.rda", compress = "xz")
save(TF.subfamily,file = "~/ELMER.data/data/TF.subfamily.rda", compress = "xz")
```

```
hocomoco.table <- "http://hocomoco11.autosome.ru/human/mono?full=true" %>% read_html()  %>%  html_table()
hocomoco.table <- hocomoco.table[[1]]
save(hocomoco.table,file = "data/hocomoco.table.rda", compress = "xz")
```

## 2.4 Probes.motif

Probes.motif provides information for motif occurences within\(\pm 250bp\) of probe
sites on HM450K/EPIC array. HOMER (Heinz, Sven and Benner, Christopher and Spann, Nathanael and Bertolino, Eric and Lin, Yin C and Laslo, Peter and Cheng, Jason X and Murre, Cornelis and Singh, Harinder and Glass, Christopher K [2010](#ref-heinz2010simple)) was used with a p-value < 0.0001 to scan a \(\pm 250bp\)
region around each probe on HM450K/EPIC using HOCOMOCO V11 motif position weight
matrices (PWMs) which provides transcription factor (TF) binding models for more than 600 human TFs.
This data set is used in get.enriched.motif function in *[ELMER](https://bioconductor.org/packages/3.22/ELMER)* to calculate
Odds Ratio of motif enrichments for a given set of probes. This data is storaged
in a sparse matrix with wuth 640 columns, there is one matrix for HM450K aligned to hg19, one for HM450K aligned to hg38,
one for EPIC aligned to hg19, one for EPIC aligned to hg38. Each row is each probe regions (annotation of the regions used can be found in
[this repository](http://zwdzwd.github.io/InfiniumAnnotation)) and each
column is motif from [http://hocomoco.autosome.ru/](HOCOMOCO) (Kulakovskiy, Ivan V and Medvedeva, Yulia A and Schaefer, Ulf and Kasianov, Artem S and Vorontsov, Ilya E and Bajic, Vladimir B and Makeev, Vsevolod [2013](#ref-ref1)). The value 1 indicates the occurrence
of a motif in a particular probe and 0 means no occurrence.

```
data("Probes.motif.hg19.450K")
dim(Probes.motif.hg19.450K)
```

```
## Loading required namespace: Matrix
```

```
## [1] 419683    771
```

```
str(Probes.motif.hg19.450K)
```

```
## Formal class 'ngCMatrix' [package "Matrix"] with 5 slots
##   ..@ i       : int [1:50151601] 0 1 3 4 8 9 13 15 16 19 ...
##   ..@ p       : int [1:772] 0 156407 169989 184818 199332 214875 256287 297203 335695 418895 ...
##   ..@ Dim     : int [1:2] 419683 771
##   ..@ Dimnames:List of 2
##   .. ..$ : chr [1:419683] "cg08270205" "cg17420036" "cg18319381" "cg19584957" ...
##   .. ..$ : chr [1:771] "AHR_HUMAN.H11MO.0.B" "AIRE_HUMAN.H11MO.0.C" "ALX1_HUMAN.H11MO.0.B" "ALX3_HUMAN.H11MO.0.D" ...
##   ..@ factors : list()
```

```
data("Probes.motif.hg38.450K")
dim(Probes.motif.hg38.450K)
```

```
## [1] 419683    771
```

```
str(Probes.motif.hg38.450K)
```

```
## Formal class 'ngCMatrix' [package "Matrix"] with 5 slots
##   ..@ i       : int [1:50147936] 0 8 9 11 12 14 15 17 22 23 ...
##   ..@ p       : int [1:772] 0 156396 169987 184815 199328 214873 256295 297214 335707 418660 ...
##   ..@ Dim     : int [1:2] 419683 771
##   ..@ Dimnames:List of 2
##   .. ..$ : chr [1:419683] "cg02484391" "cg20288000" "cg15555335" "cg17709703" ...
##   .. ..$ : chr [1:771] "AHR_HUMAN.H11MO.0.B" "AIRE_HUMAN.H11MO.0.C" "ALX1_HUMAN.H11MO.0.B" "ALX3_HUMAN.H11MO.0.D" ...
##   ..@ factors : list()
```

```
data("Probes.motif.hg19.EPIC")
dim(Probes.motif.hg19.EPIC)
```

```
## [1] 757466    771
```

```
str(Probes.motif.hg19.EPIC)
```

```
## Formal class 'ngCMatrix' [package "Matrix"] with 5 slots
##   ..@ i       : int [1:86224575] 2 4 7 8 13 16 17 23 28 37 ...
##   ..@ p       : int [1:772] 0 226218 257880 295195 331261 369986 466572 547706 629647 766325 ...
##   ..@ Dim     : int [1:2] 757466 771
##   ..@ Dimnames:List of 2
##   .. ..$ : chr [1:757466] "cg22725197" "cg05925326" "cg18877506" "cg21149582" ...
##   .. ..$ : chr [1:771] "AHR_HUMAN.H11MO.0.B" "AIRE_HUMAN.H11MO.0.C" "ALX1_HUMAN.H11MO.0.B" "ALX3_HUMAN.H11MO.0.D" ...
##   ..@ factors : list()
```

```
data("Probes.motif.hg38.EPIC")
dim(Probes.motif.hg38.EPIC)
```

```
## [1] 757466    771
```

```
str(Probes.motif.hg38.EPIC)
```

```
## Formal class 'ngCMatrix' [package "Matrix"] with 5 slots
##   ..@ i       : int [1:86219996] 1 2 5 6 7 10 12 13 14 15 ...
##   ..@ p       : int [1:772] 0 226219 257883 295211 331278 370000 466586 547718 629656 766519 ...
##   ..@ Dim     : int [1:2] 757466 771
##   ..@ Dimnames:List of 2
##   .. ..$ : chr [1:757466] "cg24807889" "cg13463719" "cg04218845" "cg03043696" ...
##   .. ..$ : chr [1:771] "AHR_HUMAN.H11MO.0.B" "AIRE_HUMAN.H11MO.0.C" "ALX1_HUMAN.H11MO.0.B" "ALX3_HUMAN.H11MO.0.D" ...
##   ..@ factors : list()
```

The following code was used to create the objects:

```
getInfiniumAnnotation <- function(plat = "450K", genome = "hg38"){
  message("Loading object: ",file)
  newenv <- new.env()
  if(plat == "EPIC" & genome == "hg19") data("EPIC.hg19.manifest", package = "ELMER.data",envir=newenv)
  if(plat == "EPIC" & genome == "hg38") data("EPIC.hg38.manifest", package = "ELMER.data",envir=newenv)
  if(plat == "450K" & genome == "hg19") data("hm450.hg19.manifest", package = "ELMER.data",envir=newenv)
  if(plat == "450K" & genome == "hg38") data("hm450.hg38.manifest", package = "ELMER.data",envir=newenv)
  annotation <- get(ls(newenv)[1],envir=newenv)
  return(annotation)
}
# To find for each probe the know motif we will use HOMER software (http://homer.salk.edu/homer/)
# Step:
# 1 - get DNA methylation probes annotation with the regions
# 2 - Make a bed file from it
# 3 - Execute section: Finding Instance of Specific Motifs from http://homer.salk.edu/homer/ngs/peakMotifs.html to the HOCOMOCO TF motifs
# Also, As HOMER is using more RAM than the available we will split the files in to 100k probes.
# Obs: for each probe we create a winddow of 500 bp (-size 500) around it. This might lead to false positives, but will not have false negatives.
# The false posives will be removed latter with some statistical tests.
TFBS.motif <- "http://hocomoco11.autosome.ru/final_bundle/hocomoco11/full/HUMAN/mono/HOCOMOCOv11_full_HUMAN_mono_homer_format_0.0001.motif"
if(!file.exists(basename(TFBS.motif))) downloader::download(TFBS.motif,basename(TFBS.motif))
for(plat in c("EPIC","450K")){
  for(gen in c("hg38","hg19")){

    file <- paste0(plat,gen,".txt")
    print(file)
    if(!file.exists(file)){
      # STEP 1
      gr <- getInfiniumAnnotation(plat = plat,genome =  gen)

      # This will remove masked probes. They have poor quality and might be arbitrarily positioned (Wanding Zhou)
      gr <- gr[!gr$MASK_general]

      df <- data.frame(seqnames=seqnames(gr),
                       starts=as.integer(start(gr)),
                       ends=end(gr),
                       names=names(gr),
                       scores=c(rep(".", length(gr))),
                       strands=strand(gr))
      step <- 10000 # nb of lines in each file. 10K was selected to not explode RAM
      n <- nrow(df)
      pb <- txtProgressBar(max = floor(n/step), style = 3)

      for(j in 0:floor(n/step)){
        setTxtProgressBar(pb, j)
        # STEP 2
        file.aux <- paste0(plat,gen,"_",j,".bed")
        if(!file.exists(gsub(".bed",".txt",file.aux))){
          end <- ifelse(((j + 1) * step) > n, n,((j + 1) * step))
          write.table(df[((j * step) + 1):end,], file = file.aux, col.names = F, quote = F,row.names = F,sep = "\t")

          # STEP 3 use -mscore to get scores
          cmd <- paste("source ~/.bash_rc; annotatePeaks.pl" ,file.aux, gen, "-m", basename(TFBS.motif), "-size 500 -cpu 12 >", gsub(".bed",".txt",file.aux))
          system(cmd)
        }
      }
    }
    close(pb)
    # We will merge the results from each file into one
    peaks <- NULL
    pb <- txtProgressBar(max = floor(n/step), style = 3)
    for(j in 0:floor(n/step)){
      setTxtProgressBar(pb, j)
      aux <-  readr::read_tsv(paste0(plat,gen,"_",j,".txt"))
      colnames(aux)[1] <- "PeakID"
      if(is.null(peaks)) {
        peaks <- aux
      } else {
        peaks <- rbind(peaks, aux)
      }
    }
    close(pb)
    print("Writing file...")
    readr::write_tsv(peaks,path=file,col_names = TRUE)
    print("DONE!")
    gc()
  }
}

getMatrix <- function(filename) {
  motifs <- readr::read_tsv(file)
  # From 1 to 21 we have annotations
  matrix <- Matrix::Matrix(0, nrow = nrow(motifs), ncol = ncol(motifs) - 21 ,sparse = TRUE)
  colnames(matrix) <- gsub(" Distance From Peak\\(sequence,strand,conservation\\)","",colnames(motifs)[-c(1:21)])
  rownames(matrix) <- motifs$PeakID
  matrix[!is.na(motifs[,-c(1:21)])] <- 1
  matrix <- as(matrix, "nsparseMatrix")
  return(matrix)
}

for(plat in c("EPIC","450K")){
  for(gen in c("hg19","hg38")){
    file <- paste0(plat,gen,".txt")

    if(file == "450Khg19.txt"){
      if(file.exists("Probes.motif.hg19.450K.rda")) next
      Probes.motif.hg19.450K <- getMatrix(file)
      save(Probes.motif.hg19.450K, file = "Probes.motif.hg19.450K.rda", compress = "xz")
      rm(Probes.motif.hg19.450K)
    }
    if(file == "450Khg38.txt"){
      if(file.exists("Probes.motif.hg38.450K.rda")) next
      Probes.motif.hg38.450K <- getMatrix(file)
      save(Probes.motif.hg38.450K, file = "Probes.motif.hg38.450K.rda", compress = "xz")
      rm(Probes.motif.hg38.450K)
    }

    if(file == "EPIChg19.txt"){
      if(file.exists("Probes.motif.hg19.EPIC.rda")) next
      Probes.motif.hg19.EPIC <- getMatrix(file)
      save(Probes.motif.hg19.EPIC, file = "Probes.motif.hg19.EPIC.rda", compress = "xz")
      rm(Probes.motif.hg19.EPIC)
    }

    if(file == "EPIChg38.txt"){
      if(file.exists("Probes.motif.hg38.EPIC.rda")) next

      Probes.motif.hg38.EPIC <- getMatrix(file)
      save(Probes.motif.hg38.EPIC, file = "Probes.motif.hg38.EPIC.rda", compress = "xz")
      rm(Probes.motif.hg38.EPIC)
    }
  }
}
```

```
data("Probes.motif.hg19.450K")
as.data.frame(as.matrix(Probes.motif.hg19.450K[1:20,1:20])) %>%
  datatable(options = list(scrollX = TRUE,pageLength = 5))
```

## 2.5 TFclass classification

## 2.6 TF list

A curated list of TF was retrieved from Lambert, Samuel A., et al. “The human transcription factors.” Cell 172.4 (2018): 650-665 (Lambert, Samuel A and Jolma, Arttu and Campitelli, Laura F and Das, Pratyush K and Yin, Yimeng and Albu, Mihai and Chen, Xiaoting and Taipale, Jussi and Hughes, Timothy R and Weirauch, Matthew T [2018](#ref-Lambert2018)) with the following code.

```
human.TF <- readr::read_csv("http://humantfs.ccbr.utoronto.ca/download/v_1.01/DatabaseExtract_v_1.01.csv")
human.TF <- human.TF[human.TF$`Is TF?` == "Yes",]
colnames(human.TF)[1:2] <- c("ensembl_gene_id","external_gene_name")
save(human.TF,file = "~/ELMER.data/data/human.TF.rda",compress = "xz")
```

```
data("human.TF")
as.data.frame(human.TF) %>%
  datatable(options = list(scrollX = TRUE,pageLength = 5))
```

```
## Warning in instance$preRenderHook(instance): It seems your data is too big for
## client-side DataTables. You may consider server-side processing:
## https://rstudio.github.io/DT/server.html
```

Homer versions

* Software: v4.9.1
* Genome hg19: v5.10
* Genome hg38: v5.10

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
## [1] dplyr_1.1.4       DT_0.34.0         ELMER.data_2.34.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Matrix_1.7-4         jsonlite_2.0.0       compiler_4.5.1
##  [4] BiocManager_1.30.26  tidyselect_1.2.1     GenomicRanges_1.62.0
##  [7] jquerylib_0.1.4      IRanges_2.44.0       Seqinfo_1.0.0
## [10] yaml_2.3.10          fastmap_1.2.0        lattice_0.22-7
## [13] R6_2.6.1             generics_0.1.4       knitr_1.50
## [16] BiocGenerics_0.56.0  htmlwidgets_1.6.4    tibble_3.3.0
## [19] bookdown_0.45        bslib_0.9.0          pillar_1.11.1
## [22] rlang_1.1.6          cachem_1.1.0         xfun_0.54
## [25] sass_0.4.10          cli_3.6.5            magrittr_2.0.4
## [28] crosstalk_1.2.2      digest_0.6.37        grid_4.5.1
## [31] lifecycle_1.0.4      S4Vectors_0.48.0     vctrs_0.6.5
## [34] evaluate_1.0.5       glue_1.8.0           stats4_4.5.1
## [37] rmarkdown_2.30       tools_4.5.1          pkgconfig_2.0.3
## [40] htmltools_0.5.8.1
```

# References

Heinz, Sven and Benner, Christopher and Spann, Nathanael and Bertolino, Eric and Lin, Yin C and Laslo, Peter and Cheng, Jason X and Murre, Cornelis and Singh, Harinder and Glass, Christopher K. 2010. “Simple Combinations of Lineage-Determining Transcription Factors Prime Cis-Regulatory Elements Required for Macrophage and B Cell Identities.”

Kulakovskiy, Ivan V and Medvedeva, Yulia A and Schaefer, Ulf and Kasianov, Artem S and Vorontsov, Ilya E and Bajic, Vladimir B and Makeev, Vsevolod. 2013. “HOCOMOCO a Comprehensive Collection of Human Transcription Factor Binding Sites Models.”

Lambert, Samuel A and Jolma, Arttu and Campitelli, Laura F and Das, Pratyush K and Yin, Yimeng and Albu, Mihai and Chen, Xiaoting and Taipale, Jussi and Hughes, Timothy R and Weirauch, Matthew T. 2018. “The Human Transcription Factors.”

Wingender, E., Schoeps, T., Haubrock, M., & Dönitz, J. 2014. “TFClass a Classification of Human Transcription Factors and Their Rodent Orthologs.”

Yao, L., Shen, H., Laird, P. W., Farnham, P. J., & Berman, B. P. 2015. “Inferring Regulatory Element Landscapes and Transcription Factor Networks from Cancer Methylomes.”

Zhou, Wanding and Laird, Peter W and Shen, Hui. 2016. “Comprehensive Characterization, Annotation and Innovative Use of Infinium DNA Methylation BeadChip Probes.”