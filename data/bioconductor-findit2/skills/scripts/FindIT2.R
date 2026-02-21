# Code example from 'FindIT2' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----"install", eval = FALSE--------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#       install.packages("BiocManager")
#   }
# 
# BiocManager::install("FindIT2")
# 
# # Check that you have a valid Bioconductor installation
# BiocManager::valid()

## -----------------------------------------------------------------------------
citation("FindIT2")

## ----"start", message=FALSE---------------------------------------------------
# load packages
# If you want to run this manual, please check you have install below packages.
library(FindIT2)
library(TxDb.Athaliana.BioMart.plantsmart28)
library(SummarizedExperiment)

library(dplyr)
library(ggplot2)

# because of the fa I use, I change the seqlevels of Txdb to make the chrosome levels consistent
Txdb <- TxDb.Athaliana.BioMart.plantsmart28
seqlevels(Txdb) <- c(paste0("Chr", 1:5), "M", "C")

all_geneSet <- genes(Txdb)


## ----eval=FALSE---------------------------------------------------------------
# # when you make sure your first metadata column is peak name
# colnames(mcols(yourGR))[1] <- "feature_id"
# 
# # or you just add a column
# yourGR$feature_id <- paste0("peak_", seq_len(length(yourGR)))
# 

## ----"prepare data"-----------------------------------------------------------
# load the test ChIP peak bed
ChIP_peak_path <- system.file("extdata", "ChIP.bed.gz", package = "FindIT2")
ChIP_peak_GR <- loadPeakFile(ChIP_peak_path)

# you can see feature_id is in your first column of metadata
ChIP_peak_GR

## ----"mm_nearestgene"---------------------------------------------------------
mmAnno_nearestgene <- mm_nearestGene(peak_GR = ChIP_peak_GR,
                                     Txdb = Txdb)

mmAnno_nearestgene


## -----------------------------------------------------------------------------
plot_annoDistance(mmAnno = mmAnno_nearestgene)

## -----------------------------------------------------------------------------
getAssocPairNumber(mmAnno = mmAnno_nearestgene)

getAssocPairNumber(mmAnno = mmAnno_nearestgene,
                   output_summary = TRUE)

# you can see all peak's related gene number is 1 because I use the nearest gene mode
getAssocPairNumber(mmAnno_nearestgene, output_type = "feature_id")

getAssocPairNumber(mmAnno = mmAnno_nearestgene,
                   output_type = "feature_id",
                   output_summary = TRUE)

## -----------------------------------------------------------------------------
plot_peakGeneAlias_summary(mmAnno_nearestgene)
plot_peakGeneAlias_summary(mmAnno_nearestgene, output_type = "feature_id")

## ----"mm_geneBound"-----------------------------------------------------------
# The genes_Chr5 is all gene set in Chr5
genes_Chr5 <- names(all_geneSet[seqnames(all_geneSet) == "Chr5"])

# The genes_Chr5_notAnno is gene set which is not linked by peak
genes_Chr5_notAnno <- genes_Chr5[!genes_Chr5 %in% unique(mmAnno_nearestgene$gene_id)]

# The genes_Chr5_tAnno is gene set which is linked by peak
genes_Chr5_Anno <- unique(mmAnno_nearestgene$gene_id)

# mm_geneBound will tell you there 5 genes in your input_genes not be annotated
# and it will use the distanceToNearest to find nearest peak of these genes
mmAnno_geneBound <- mm_geneBound(peak_GR = ChIP_peak_GR,
                                 Txdb = Txdb,
                                 input_genes = c(genes_Chr5_Anno[1:5], genes_Chr5_notAnno[1:5]))

# all of your input_genes have related peaks
mmAnno_geneBound


## ----"mm_geneScan"------------------------------------------------------------
mmAnno_geneScan <- mm_geneScan(peak_GR = ChIP_peak_GR,
                               Txdb = Txdb,
                               upstream = 2e4,
                               downstream = 2e4)

mmAnno_geneScan


## -----------------------------------------------------------------------------
getAssocPairNumber(mmAnno_geneScan)

getAssocPairNumber(mmAnno_geneScan, output_type = "feature_id")

## -----------------------------------------------------------------------------
plot_peakGeneAlias_summary(mmAnno_geneScan)
plot_peakGeneAlias_summary(mmAnno_geneScan, output_type = "feature_id")

## -----------------------------------------------------------------------------
# Here you can see the score column in metadata
ChIP_peak_GR

# I can rename it into feature_score
colnames(mcols(ChIP_peak_GR))[2] <- "feature_score"

ChIP_peak_GR


## ----"calcRP_TFHit"-----------------------------------------------------------
# if you just want to get RP_df, you can set report_fullInfo FALSE
fullRP_hit <- calcRP_TFHit(mmAnno = mmAnno_geneScan,
                           Txdb = Txdb,
                           decay_dist = 1000,
                           report_fullInfo = TRUE)

# if you set report_fullInfo to TRUE, the result will be a GRange object
# it maintain the mmAnno_geneScan result and add other column, which represent  
# the contribution of each peak to the final RP of the gene

fullRP_hit

# or you can directly extract from metadata of your result
peakRP_gene <- metadata(fullRP_hit)$peakRP_gene

# The result is ordered by the sumRP and you can decide the target threshold by yourself
peakRP_gene


## ----"calcRP_bw"--------------------------------------------------------------

bwFile <- system.file("extdata", "E50h_sampleChr5.bw", package = "FindIT2")
RP_df <- calcRP_coverage(bwFile = bwFile,
                         Txdb = Txdb,
                         Chrs_included = "Chr5")

head(RP_df)


## ----"calcRP_region"----------------------------------------------------------
data("ATAC_normCount")

# This ATAC peak is the merge peak set from E50h-72h
ATAC_peak_path <- system.file("extdata", "ATAC.bed.gz", package = "FindIT2")
ATAC_peak_GR <- loadPeakFile(ATAC_peak_path)

mmAnno_regionRP <- mm_geneScan(ATAC_peak_GR,
                               Txdb,
                               upstream = 2e4,
                               downstream = 2e4)

# This ATAC_normCount is the peak count matrix normilzed by DESeq2
calcRP_region(mmAnno = mmAnno_regionRP,
              peakScoreMt = ATAC_normCount,
              Txdb = Txdb,
              Chrs_included = "Chr5") -> regionRP

# The sumRP is a matrix representing your geneRP in every samples
sumRP <- assays(regionRP)$sumRP
head(sumRP)

# The fullRP is a detailed peak-RP-gene relationship
fullRP <- assays(regionRP)$fullRP
head(fullRP)


## ----"findITarget"------------------------------------------------------------
data("RNADiff_LEC2_GR")
integrate_ChIP_RNA(result_geneRP = peakRP_gene,
                   result_geneDiff = RNADiff_LEC2_GR) -> merge_result

# you can see compared with down gene, there are more up gene on the top rank in ChIP-Seq data
# In the meanwhile, the number of down gene is less than up
merge_result

# if you want to extract merge target data
target_result <- merge_result$data
target_result


## ----"prepare_for_findIT"-----------------------------------------------------

# Here I take the top50 gene from integrate_ChIP_RNA as my interesting gene set.
input_genes <- target_result$gene_id[1:50]

# I use mm_geneBound to find related peak, which I will take as my interesting peak set.
related_peaks <- mm_geneBound(peak_GR = ATAC_peak_GR,
                              Txdb = Txdb,
                              input_genes = input_genes)
input_feature_id <- unique(related_peaks$feature_id)

# AT1G28300 is LEC2 tair ID
# I add a column named TF_id into my ChIP Seq GR
ChIP_peak_GR$TF_id <- "AT1G28300"

# And I also add some other public ChIP-Seq data
TF_GR_database_path <- system.file("extdata", "TF_GR_database.bed.gz", package = "FindIT2")
TF_GR_database <- loadPeakFile(TF_GR_database_path)
TF_GR_database

# rename feature_id column into TF_id
# because the true thing I am interested in is TF set, not each TF binding site.
colnames(mcols(TF_GR_database))[1] <- "TF_id"

# merge LEC2 ChIP GR
TF_GR_database <- c(TF_GR_database, ChIP_peak_GR)

TF_GR_database


## ----"findIT_enrichWilcox"----------------------------------------------------
findIT_enrichWilcox(input_feature_id = input_feature_id, 
                    peak_GR = ATAC_peak_GR, 
                    TF_GR_database = TF_GR_database) -> result_enrichWilcox

# you can see AT1G28300 is top1
result_enrichWilcox


## ----"findIT_enrichFisher"----------------------------------------------------
findIT_enrichFisher(input_feature_id = input_feature_id, 
                   peak_GR = ATAC_peak_GR, 
                   TF_GR_database = TF_GR_database) -> result_enrichFisher

# you can see AT1G28300 is top1
result_enrichFisher


## -----------------------------------------------------------------------------
# Here I use the top 4 TF id to calculate jaccard similarity of TF
jaccard_findIT_enrichFisher(input_feature_id = input_feature_id,
                           peak_GR = ATAC_peak_GR,
                           TF_GR_database = TF_GR_database,
                           input_TF_id = result_enrichFisher$TF_id[1:4]) -> enrichAll_jaccard

# it report the jaccard similarity of TF you input

# but here I make the TF's own jaccard similarity 0, which is useful for heatmap
# If you want to convert it to 1, you can just use 
# diag(enrichAll_jaccard) <- 1

enrichAll_jaccard


## -----------------------------------------------------------------------------
data("TF_target_database")

# it should have two column named TF_id and target_gene.
head(TF_target_database)


## ----"findIT_TTPair"----------------------------------------------------------
# By default, TTpair will consider all target gene as background
# Because I just use part of true TF_target_database, the background calculation
# is not correct. 
# so I use all gene in Txdb as gene_background.

result_TTpair <- findIT_TTPair(input_genes = input_genes,
                               TF_target_database = TF_target_database,
                               gene_background = names(all_geneSet))

# you can see AT1G28300 is top1
result_TTpair


## -----------------------------------------------------------------------------

# Here I use the all TF_id because I just have three TF in result_TTpair
# For you, you can select top N TF_id as input_TF_id
jaccard_findIT_TTpair(input_genes = input_genes,
                      TF_target_database = TF_target_database,
                      input_TF_id = result_TTpair$TF_id) -> TTpair_jaccard

# Here I make the TF's own jaccard similarity 0, which is useful for heatmap
# If you want to convert it to 1, you can just use 
# diag(TTpair_jaccard) <- 1
TTpair_jaccard


## ----"findIT_TFHit"-----------------------------------------------------------
# For repeatability of results, you should set seed.
set.seed(20160806)

# the meaning of scan_dist and decay_dist is same as calcRP_TFHit
# the Chrs_included control the chromosome your background in 
# the background_number control the number of background gene

# If you want to compare the TF enrichment in your input_genes with other gene set
# you can input other gene set id into background_genes
result_TFHit <- findIT_TFHit(input_genes = input_genes,
                             Txdb = Txdb,
                             TF_GR_database = TF_GR_database,
                             scan_dist = 2e4,
                             decay_dist = 1e3,
                             Chrs_included = "Chr5",
                             background_number = 3000)

# you can see AT1G28300 is top1
result_TFHit


## -----------------------------------------------------------------------------
# For repeatability of results, you should set seed.
set.seed(20160806)
result_findIT_regionRP <- findIT_regionRP(regionRP = regionRP,
                                          Txdb = Txdb,
                                          TF_GR_database = TF_GR_database,
                                          input_genes = input_genes,
                                          background_number = 3000)

# The result object of findIT_regionRP is MultiAssayExperiment, same as calcRP_region
# TF_percentMean is the mean influence of TF on input genes minus background, 
# which represent the total influence of specific TF on your input genes
TF_percentMean <- assays(result_findIT_regionRP)$TF_percentMean
TF_pvalue <- assays(result_findIT_regionRP)$TF_pvalue


## -----------------------------------------------------------------------------
TF_percentMean

heatmap(TF_percentMean, Colv = NA, scale = "none")

## -----------------------------------------------------------------------------
metadata(result_findIT_regionRP)$percent_df %>% 
    filter(sample == "E5_0h_R1") %>% 
    select(gene_id, percent, TF_id) %>% 
    tidyr::pivot_wider(values_from = percent, names_from = gene_id) -> E50h_TF_percent

E50h_TF_mt <- as.matrix(E50h_TF_percent[, -1])
rownames(E50h_TF_mt) <- E50h_TF_percent$TF_id

E50h_TF_mt

heatmap(E50h_TF_mt, scale = "none")


## -----------------------------------------------------------------------------
metadata(result_findIT_regionRP)

metadata(result_findIT_regionRP)$percent_df %>% 
  filter(TF_id == "AT1G28300") %>% 
  select(-TF_id) %>% 
  tidyr::pivot_wider(names_from = sample, values_from = percent) -> LEC2_percent_df

LEC2_percent_mt <- as.matrix(LEC2_percent_df[, -1])
rownames(LEC2_percent_mt) <- LEC2_percent_df$gene_id

heatmap(LEC2_percent_mt, Colv = NA, scale = "none")
  

## ----eval = FALSE-------------------------------------------------------------
# # Before using shiny function, you should merge the regionRP and result_findIT_regionRP firstly.
# merge_result <- c(regionRP, result_findIT_regionRP)
# InteractiveFindIT2::shinyParse_findIT_regionRP(merge_result = merge_result, mode = "gene")
# 
# InteractiveFindIT2::shinyParse_findIT_regionRP(merge_result = merge_result,mode = "TF")

## -----------------------------------------------------------------------------

# For repeatability of results, you should set seed.
set.seed(20160806)
findIT_MARA(input_feature_id = input_feature_id,
            peak_GR = ATAC_peak_GR,
            peakScoreMt = ATAC_normCount,
            TF_GR_database = TF_GR_database,
            log = TRUE,
            meanScale = TRUE) -> result_findIT_MARA


# Please note that you should add the total motif scan data in TF_GR_database
# Here I just use the test public ChIP-Seq data, so the result is not valuable
result_findIT_MARA


## -----------------------------------------------------------------------------
# when you get the zscale value from findIT_MARA,
# you can use integrate_replicates to integrate replicate zscale by setting type as "rank_zscore"
# Here each replicate are combined using Stouffer’s method
MARA_mt <- as.matrix(result_findIT_MARA[, -1])

rownames(MARA_mt) <- result_findIT_MARA$TF_id

MARA_colData <- data.frame(row.names = colnames(MARA_mt),
                           type = gsub("_R[0-9]", "", colnames(MARA_mt))
                           )


integrate_replicates(mt = MARA_mt,
                     colData = MARA_colData,
                     type = "rank_zscore")


## -----------------------------------------------------------------------------
list(TF_Hit = result_TFHit,
     enrichFisher = result_enrichFisher,
     wilcox = result_enrichWilcox,
     TT_pair = result_TTpair
     ) -> rank_merge_list
purrr::map(names(rank_merge_list), .f = function(x){
    data <- rank_merge_list[[x]]
    data %>% 
        select(TF_id, rank) %>% 
        mutate(source = x) -> data
    return(data)
}) %>% 
    do.call(rbind, .) %>% 
    tidyr::pivot_wider(names_from = source, values_from = rank) -> rank_merge_df

rank_merge_df

# we only select TF which appears in all source
rank_merge_df <- rank_merge_df[rowSums(is.na(rank_merge_df)) == 0, ]

rank_merge_mt <- as.matrix(rank_merge_df[, -1])
rownames(rank_merge_mt) <- rank_merge_df$TF_id

colData <- data.frame(row.names = colnames(rank_merge_mt),
                      type = rep("source", ncol(rank_merge_mt)))

integrate_replicates(mt = rank_merge_mt, colData = colData, type = "rank")


## -----------------------------------------------------------------------------
data("RNA_normCount")

peak_GR <- loadPeakFile(ATAC_peak_path)[1:100]
mmAnno <- mm_geneScan(peak_GR,Txdb)

ATAC_colData <- data.frame(row.names = colnames(ATAC_normCount),
                           type = gsub("_R[0-9]", "", colnames(ATAC_normCount))
                           )

integrate_replicates(ATAC_normCount, ATAC_colData) -> ATAC_normCount_merge
RNA_colData <- data.frame(row.names = colnames(RNA_normCount),
                          type = gsub("_R[0-9]", "", colnames(RNA_normCount))
                          )
integrate_replicates(RNA_normCount, RNA_colData) -> RNA_normCount_merge

peakGeneCor(mmAnno = mmAnno,
            peakScoreMt = ATAC_normCount_merge,
            geneScoreMt = RNA_normCount_merge,
            parallel = FALSE) -> mmAnnoCor


## -----------------------------------------------------------------------------
subset(mmAnnoCor, cor > 0.8) %>% 
  getAssocPairNumber()

## -----------------------------------------------------------------------------
plot_peakGeneCor(mmAnnoCor = mmAnnoCor,
                 select_gene = "AT5G01075")

plot_peakGeneCor(mmAnnoCor = subset(mmAnnoCor, cor > 0.95),
                 select_gene = "AT5G01075")

plot_peakGeneCor(mmAnnoCor = subset(mmAnnoCor, cor > 0.95),
                 select_gene = "AT5G01075") +
  geom_point(aes(color = time_point))

plot_peakGeneAlias_summary(mmAnno = mmAnnoCor,
                           mmAnno_corFilter = subset(mmAnnoCor, cor > 0.8))


## ----eval=FALSE---------------------------------------------------------------
# InteractiveFindIT2::shinyParse_peakGeneCor(mmAnnoCor)

## -----------------------------------------------------------------------------
enhancerPromoterCor(peak_GR = peak_GR[1:100],
                    Txdb = Txdb,
                    peakScoreMt = ATAC_normCount,
                    up_scanPromoter = 500,
                    down_scanPromoter = 500,
                    up_scanEnhancer = 2000,
                    down_scanEnhacner = 2000,
                    parallel = FALSE) -> mmAnnoCor_linkEP

## -----------------------------------------------------------------------------
plot_peakGeneCor(mmAnnoCor = mmAnnoCor_linkEP,
                 select_gene = "AT5G01075") -> p

p

p$data$type <- gsub("_R[0-9]", "", p$data$time_point)
p$data$type <- factor(p$data$type, levels = unique(p$data$type))

p +
    ggplot2::geom_point(aes(color = type))


## -----------------------------------------------------------------------------
plot_peakGeneAlias_summary(mmAnno = mmAnnoCor_linkEP,
                           mmAnno_corFilter = subset(mmAnnoCor_linkEP, cor > 0.8))

## ----eval=FALSE---------------------------------------------------------------
# InteractiveFindIT2::shinyParse_peakGeneCor(mmAnnoCor_linkEP)

## ----reproduce3, echo=FALSE-------------------------------------------------------------------------------------------
## Session info
library("sessioninfo")
options(width = 120)
session_info()

