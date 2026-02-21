# Code example from 'ASCAT_to_RaggedExperiment' vignette. See references/ for full tutorial.

## ----installation, message = FALSE, warning = FALSE, eval = FALSE-------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# 
# BiocManager::install("RaggedExperiment")

## ----load-packages, message = FALSE-------------------------------------------
library(RaggedExperiment)
library(GenomicRanges)

## ----load-ascat-sample1-------------------------------------------------------
ASCAT_data_S1 <- read.delim(
    system.file(
        "extdata", "ASCAT_Sample1.txt",
        package = "RaggedExperiment", mustWork = TRUE
    ),
    header = TRUE
)

unique(ASCAT_data_S1$sample)

head(ASCAT_data_S1, n = 10)

## ----load-ascat-all-samples---------------------------------------------------
ASCAT_data_All <- read.delim(
    system.file(
        "extdata", "ASCAT_All_Samples.txt",
        package = "RaggedExperiment", mustWork = TRUE
    ),
    header = TRUE
)

unique(ASCAT_data_All$sample)

head(ASCAT_data_All, n = 10)

## ----ascat-to-granges-manual--------------------------------------------------
sample1_ex1 <- GRanges(
    seqnames = Rle(paste0("chr", ASCAT_data_S1$chr)),
    ranges = IRanges(
        start = ASCAT_data_S1$startpos, end = ASCAT_data_S1$endpos
    ),
    strand = Rle(strand("*")),
    nmajor = ASCAT_data_S1$nMajor,
    nminor = ASCAT_data_S1$nMinor
)

sample1_ex1

## ----ascat-to-granges-makegrangesfromdataframe--------------------------------
sample1_ex2 <- makeGRangesFromDataFrame(
    ASCAT_data_S1[,-c(1)],
    ignore.strand=TRUE,
    seqnames.field="chr",
    start.field="startpos",
    end.field="endpos",
    keep.extra.columns=TRUE
)

sample1_ex2

## ----split-dataframe----------------------------------------------------------
sample_list <- split(
    ASCAT_data_All,
    f = ASCAT_data_All$sample
)

## ----ascat-to-grangeslist-single----------------------------------------------
sample_list_GRanges_ex1 <- makeGRangesListFromDataFrame(
    ASCAT_data_S1,
    ignore.strand=TRUE,
    seqnames.field="chr",
    start.field="startpos",
    end.field="endpos",
    keep.extra.columns=TRUE,
    split.field = "sample"
)

sample_list_GRanges_ex1

## ----ascat-to-grangeslist-multiple--------------------------------------------
sample_list_GRanges_ex2 <- makeGRangesListFromDataFrame(
    ASCAT_data_All,
    ignore.strand=TRUE,
    seqnames.field="chr",
    start.field="startpos",
    end.field="endpos",
    keep.extra.columns=TRUE,
    split.field = "sample"
)

sample_list_GRanges_ex2

## ----access-grangeslist-------------------------------------------------------
sample1_ex3 <- sample_list_GRanges_ex2[[1]]

sample1_ex3

## ----grangeslist-function-----------------------------------------------------
sample_list_GRanges_ex3 <- GRangesList(
    sample1 = sample1_ex1
)

sample_list_GRanges_ex3

## ----ragexp-from-granges-single-----------------------------------------------
colDat_1 = DataFrame(id = 1)

ragexp_1 <- RaggedExperiment(
    sample1 = sample1_ex2,
    colData = colDat_1
)

ragexp_1

## ----ragexp-from-grangeslist-single-------------------------------------------
ragexp_2 <- RaggedExperiment(
    sample_list_GRanges_ex1,
    colData = colDat_1
)

ragexp_2

## ----ragexp-from-grangeslist-multiple-----------------------------------------
colDat_3 = DataFrame(id = 1:3)

ragexp_3 <- RaggedExperiment(
    sample_list_GRanges_ex2,
    colData = colDat_3
)

ragexp_3

## ----ragexp-from-grangeslist-function-----------------------------------------
ragexp_4  <- RaggedExperiment(
    sample_list_GRanges_ex3,
    colData = colDat_1
)

ragexp_4

## ----session-info-------------------------------------------------------------
sessionInfo()

