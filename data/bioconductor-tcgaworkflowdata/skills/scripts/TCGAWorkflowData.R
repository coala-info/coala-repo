# Code example from 'TCGAWorkflowData' vignette. See references/ for full tutorial.

## ----fig.show='hold'----------------------------------------------------------
library(TCGAWorkflowData)
data("elmerExample")
data("TCGA_LGG_Transcriptome_20_samples")
data("TCGA_GBM_Transcriptome_20_samples")
data("histoneMarks")
data("biogrid")
data("genes_GR")
data("maf_lgg_gbm")

## ----eval = FALSE, message=FALSE,warning=FALSE, include=TRUE------------------
# library(GenomicRanges)
# library(TCGAbiolinks)
# ##############################
# ## Recurrent CNV annotation ##
# ##############################
# # Get gene information from GENCODE using biomart
# genes <- TCGAbiolinks:::get.GRCh.bioMart(genome = "hg19")
# genes <- genes[genes$external_gene_id != "" & genes$chromosome_name %in% c(1:22,"X","Y"),]
# genes[genes$chromosome_name == "X", "chromosome_name"] <- 23
# genes[genes$chromosome_name == "Y", "chromosome_name"] <- 24
# genes$chromosome_name <- sapply(genes$chromosome_name,as.integer)
# genes <- genes[order(genes$start_position),]
# genes <- genes[order(genes$chromosome_name),]
# genes <- genes[,c("external_gene_id", "chromosome_name", "start_position","end_position")]
# colnames(genes) <- c("GeneSymbol","Chr","Start","End")
# genes_GR <- makeGRangesFromDataFrame(genes,keep.extra.columns = TRUE)
# save(genes_GR,genes,file = "genes_GR.rda", compress = "xz")

## ----eval=FALSE, message=FALSE, warning=FALSE, include=TRUE-------------------
# library(RTCGAToolbox)
# # Download GISTIC results
# lastAnalyseDate <- getFirehoseAnalyzeDates(1)
# gistic <- getFirehoseData(
#   dataset = "GBM",
#   gistic2_Date = lastAnalyseDate,
#   GISTIC = TRUE
# )
# 
# # get GISTIC results
# gistic_allbygene <- getData(
#   gistic,
#   type = "GISTIC",
#   platform = "AllByGene"
# )
# 
# gistic_thresholedbygene <- getData(
#   gistic,
#   type = "GISTIC",
#   platform = "ThresholdedByGene"
# )
# 
# save(
#   gistic_allbygene,
#   gistic_thresholedbygene,
#   file = "GBMGistic.rda", compress = "xz"
# )

## ----eval=FALSE, include=TRUE, results='asis'---------------------------------
# query_exp_lgg <- GDCquery(
#   project = "TCGA-LGG",
#   data.category = "Transcriptome Profiling",
#   data.type = "Gene Expression Quantification",
#   workflow.type = "STAR - Counts"
# )
# # Get only first 20 samples to make example faster
# query_exp_lgg$results[[1]] <- query_exp_lgg$results[[1]][1:20,]
# GDCdownload(query_exp_lgg)
# exp_lgg <- GDCprepare(
#   query = query_exp_lgg
# )
# 
# query_exp_gbm <- GDCquery(
#   project = "TCGA-GBM",
#   data.category = "Transcriptome Profiling",
#   data.type = "Gene Expression Quantification",
#   workflow.type = "STAR - Counts"
# )
# # Get only first 20 samples to make example faster
# query_exp_gbm$results[[1]] <- query_exp_gbm$results[[1]][1:20,]
# GDCdownload(query_exp_gbm)
# exp_gbm <- GDCprepare(
#   query = query_exp_gbm
# )

## ----eval=FALSE, include=TRUE, results='asis'---------------------------------
# #----------- 8.3 Identification of Regulatory Enhancers   -------
# library(TCGAbiolinks)
# # Samples: primary solid tumor w/ DNA methylation and gene expression
# matched_met_exp <- function(project, n = NULL){
#   # get primary solid tumor samples: DNA methylation
#   message("Download DNA methylation information")
#   met450k <- GDCquery(
#     project = project,
#     data.category = "DNA Methylation",
#     platform = "Illumina Human Methylation 450",
#     data.type = "Methylation Beta Value",
#     sample.type = c("Primary Tumor")
#   )
#   met450k.tp <-  met450k$results[[1]]$cases
# 
#   # get primary solid tumor samples: RNAseq
#   message("Download gene expression information")
#   exp <- GDCquery(
#     project = project,
#     data.category = "Transcriptome Profiling",
#     data.type = "Gene Expression Quantification",
#     workflow.type = "STAR - Counts"
#     sample.type = c("Primary Tumor")
#   )
# 
#   exp.tp <- exp$results[[1]]$cases
#   # Get patients with samples in both platforms
#   patients <- unique(substr(exp.tp,1,15)[substr(exp.tp,1,12) %in% substr(met450k.tp,1,12)] )
#   if(!is.null(n)) patients <- patients[1:n] # get only n samples
#   return(patients)
# }
# lgg.samples <- matched_met_exp("TCGA-LGG", n = 10)
# gbm.samples <- matched_met_exp("TCGA-GBM", n = 10)
# samples <- c(lgg.samples,gbm.samples)
# 
# #-----------------------------------
# # 1 - Methylation
# # ----------------------------------
# query.met <- GDCquery(
#   project = c("TCGA-LGG","TCGA-GBM"),
#   data.category = "DNA Methylation",
#   platform = "Illumina Human Methylation 450",
#   data.type = "Methylation Beta Value",
#   barcode = samples
# )
# GDCdownload(query.met)
# met <- GDCprepare(query.met, save = FALSE)
# met <- subset(met,subset = as.character(GenomicRanges::seqnames(met)) %in% c("chr9"))
# 
# #-----------------------------------
# # 2 - Expression
# # ----------------------------------
# query.exp <- GDCquery(
#   project = c("TCGA-LGG","TCGA-GBM"),
#   data.category = "Transcriptome Profiling",
#   data.type = "Gene Expression Quantification",
#   workflow.type = "STAR - Counts"
#   sample.type = c("Primary Tumor")
#   barcode =  samples
# )
# GDCdownload(query.exp)
# exp <- GDCprepare(query.exp, save = FALSE)
# save(exp, met, gbm.samples, lgg.samples, file = "elmerExample.rda", compress = "xz")

## ----eval=FALSE, include=TRUE, results='asis'---------------------------------
# library(TCGAbiolinks)
# query <- GDCquery(
#   project = c("TCGA-LGG","TCGA-GBM"),
#   data.category = "Simple Nucleotide Variation",
#   access = "open",
#   data.type = "Masked Somatic Mutation",
#   workflow.type = "Aliquot Ensemble Somatic Variant Merging and Masking"
# )
# GDCdownload(query)
# maf <- GDCprepare(query)
# save(maf,file = "maf_lgg_gbm.rda",compress = "xz")

## ----eval=FALSE, include=TRUE, results='asis'---------------------------------
# ### read biogrid info
# ### Check last version in https://thebiogrid.org/download.php
# file <- "https://downloads.thebiogrid.org/Download/BioGRID/Latest-Release/BIOGRID-ALL-LATEST.tab2.zip"
# if(!file.exists(gsub("zip","txt",basename(file)))){
#   downloader::download(file,basename(file))
#   unzip(basename(file),junkpaths =TRUE)
# }
# 
# tmp.biogrid <- vroom::vroom(
#   dir(pattern = "BIOGRID-ALL.*\\.txt")
# )
# save(tmp.biogrid, file = "biogrid.rda", compress = "xz")

## ----results='hide', eval=FALSE, echo=FALSE, message=FALSE,warning=FALSE------
# library(ChIPseeker)
# library(AnnotationHub)
# library(pbapply)
# library(ggplot2)
# #------------------ Working with ChipSeq data ---------------
# # Step 1: download histone marks for a brain and non-brain samples.
# #------------------------------------------------------------
# # loading annotation hub database
# ah = AnnotationHub()
# 
# # Searching for brain consolidated epigenomes in the roadmap database
# bpChipEpi_brain <- query(ah , c("EpigenomeRoadMap", "narrowPeak", "chip", "consolidated","brain","E068"))
# 
# # Get chip-seq data
# histone.marks <- pblapply(names(bpChipEpi_brain), function(x) {ah[[x]]})
# names(histone.marks) <- names(bpChipEpi_brain)
# save(histone.marks, file = "histoneMarks.rda", compress = "xz")

## ----sessionInfo, results='asis', echo=FALSE----------------------------------
pander::pander(sessionInfo(), compact = FALSE)

