# Code example from 'UMI_VDJ_Barcode' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  message = FALSE,
  error = FALSE,
  warn = FALSE,
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(data.table)
library(ggplot2)
library(CellBarcode)

## ----eval=FALSE---------------------------------------------------------------
# system.file("extdata", "mef_test_data", package="CellBarcode")

## ----smaples------------------------------------------------------------------
example_data <- system.file("extdata", "mef_test_data", package = "CellBarcode")
fq_files <- dir(example_data, "fastq.gz", full=TRUE)

# prepare metadata for the samples
metadata <- stringr::str_split_fixed(basename(fq_files), "_", 10)[, c(4, 6)]
metadata <- as.data.frame(metadata)
sample_name <- apply(metadata, 1, paste, collapse = "_")
colnames(metadata) = c("cell_number", "replication")
# metadata should has the row names consistent to the sample names
rownames(metadata) = sample_name
metadata

## ----installation Bioconducotr, eval=FALSE------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("CellBarcode")

## ----installation devel, eval=FALSE-------------------------------------------
# # install.packages("remotes")
# remotes::install_github("wenjie1991/CellBarcode")

## ----basic_workflow-----------------------------------------------------------
# install.packages("stringr")
library(CellBarcode)
library(magrittr)

# The example data is the mix of MEF lines with known barcodes
# 2000 reads for each file have been sampled for this test dataset
# extract UMI barcode with regular expression
bc_obj <- bc_extract(
  fq_files,  # fastq file
  pattern = "([ACGT]{12})CTCGAGGTCATCGAAGTATC([ACGT]+)CCGTAGCAAGCTCGAGAGTAGACCTACT", 
  pattern_type = c("UMI" = 1, "barcode" = 2),
  sample_name = sample_name,
  metadata = metadata
)
bc_obj

# sample subset operation, select technical repeats 'mixa'
bc_sub = bc_subset(bc_obj, sample=replication == "mixa")
bc_sub 

# filter the barcode, UMI barcode amplicon >= 2 & UMI counts >= 2
bc_sub <- bc_cure_umi(bc_sub, depth = 2) %>% bc_cure_depth(depth = 2)

# select barcodes with a white list
bc_2df(bc_sub)
bc_sub[c("AAGTCCAGTACTATCGTACTA", "AAGTCCAGTACTGTAGCTACTA"), ]

# export the barcode counts to data.frame
head(bc_2df(bc_sub))

# export the barcode counts to matrix
head(bc_2matrix(bc_sub))

## ----quality_control_1--------------------------------------------------------
qc_noFilter <- bc_seq_qc(fq_files)
qc_noFilter
bc_names(qc_noFilter)
class(qc_noFilter)

## ----qc_figure_set1-----------------------------------------------------------
bc_plot_seqQc(qc_noFilter) 

## ----qc_figure_single1--------------------------------------------------------
qc_noFilter[1]
class(qc_noFilter[1])
bc_plot_seqQc(qc_noFilter[1]) 

## ----filter_low_quality_seq---------------------------------------------------
# TODO: output the filtering percentage
# TODO: Trimming
fq_filter <- bc_seq_filter(
  fq_files,
  min_average_quality = 30,
  min_read_length = 60,
  sample_name = sample_name)

fq_filter
bc_plot_seqQc(bc_seq_qc(fq_filter))

## -----------------------------------------------------------------------------
pattern <- "([ACGA]{12})CTCGAGGTCATCGAAGTATC([ACGT]+)CCGTAGCAAGCTCGAGAGTAGACCTACT"
pattern_type <- c("UMI" = 1, "barcode" = 2)

## ----extract_barcode_no_UMI---------------------------------------------------
pattern <- "CTCGAGGTCATCGAAGTATC([ACGT]+)CCGTAGCAAGCTCGAGAGTAGACCTACT"
bc_obj <- bc_extract(
  fq_filter,
  sample_name = sample_name,
  pattern = pattern,
  pattern_type = c(barcode = 1))

bc_obj
names(bc_messyBc(bc_obj)[[1]])

## ----extract_barcode_with_UMI-------------------------------------------------
pattern <- "([ACGA]{12})CTCGAGGTCATCGAAGTATC([ACGT]+)CCGTAGCAAGCTCGAGAGTAGACCTACT"
bc_obj_umi <- bc_extract(
  fq_filter,
  sample_name = sample_name,
  pattern = pattern,
  maxLDist = 0,
  pattern_type = c(UMI = 1, barcode = 2))

class(bc_obj_umi)
bc_obj_umi

## ----fig.width=5, fig.height=5------------------------------------------------
# select two samples from bc_obj_umi
bc_obj_umi_sub <- bc_obj_umi[, c("781_mixa", "781_mixb")]
# get the metadata matrix
(d <- bc_meta(bc_obj_umi_sub))
# use the row name of the metadata, which contains the sample names
d$sample_name <- rownames(d)

d$barcode_read_count / d$raw_read_count
# visualize
ggplot(d) + 
    aes(x=sample_name, y=barcode_read_count / raw_read_count) + 
    geom_bar(stat="identity")

## -----------------------------------------------------------------------------
# Access messyBc slot
head(bc_messyBc(bc_obj_umi)[[1]], n=2)
# return a data.frame
head(bc_messyBc(bc_obj_umi, isList=FALSE), n=2)

# Access cleanBc slot
# return a data.frame
head(bc_cleanBc(bc_obj_umi, isList=FALSE), n=2)

## -----------------------------------------------------------------------------
bc_obj_umi_sub <- bc_obj_umi[, c("781_mixa", "781_mixb")]
bc_names(bc_obj_umi_sub)

## -----------------------------------------------------------------------------
bc_meta(bc_obj_umi_sub)$rep <- c("a", "b")
bc_meta(bc_obj_umi_sub)

## -----------------------------------------------------------------------------
bc_subset(bc_obj_umi_sub, sample = rep == "a")

## ----correct_barcodde_with_UMI------------------------------------------------
# Filter the barcodes with UMI-barcode tag >= 1, 
# and treat UMI as absolute unique and do "fish"
bc_obj_umi_sub <- bc_cure_umi(
    bc_obj_umi_sub, depth = 1, 
    isUniqueUMI = TRUE, 
    doFish = TRUE)
bc_obj_umi_sub

## ----correct_barcodde_with_count----------------------------------------------
# Apply the barcode sequence depth with depth >= 3
# With isUpdate = FLASE, the data in `messyBc` slot of bc_obj_umi_sub
#   will be used for depth filtering. The UMI information will be discarded, 
#   the identical barcodes in different UMI-barcode tags are merged before
#   performing the sequence depth filtering.
bc_obj_umi_sub <- bc_cure_depth(bc_obj_umi_sub, depth = 3, isUpdate = FALSE)
bc_obj_umi_sub

# Apply the UMI count filter, keep barcode >= 3 UMI
# The `bc_cure_umi` function applies the filtering on the UMI-barcode tags,
#   and create a `cleanBc` slot in the return BarcodeObj object. Then, 
#   the `bc_cure_depth` with `isUpdate` argument TRUE will apply the filtering
#   on the UMI counts in `cleanBc` and updated the `cleanBc`.
bc_obj_umi_sub <- bc_cure_umi(
    bc_obj_umi_sub, depth = 1, 
    isUniqueUMI = TRUE, 
    doFish = TRUE)
bc_obj_umi_sub
bc_obj_umi_sub <- bc_cure_depth(bc_obj_umi_sub, depth = 3, isUpdate = TRUE)
bc_obj_umi_sub

## ----correct_barcodde_clustering----------------------------------------------
# Do the clustering and merging the least abundant barcodes to the similar
# abundant ones
bc_cure_cluster(bc_obj_umi_sub)

## ----fig.width=5--------------------------------------------------------------
bc_plot_single(bc_obj_umi_sub)

## ----fig.width=5--------------------------------------------------------------
# re-do the filtering using depth threshold 0 to include all barcodes.
bc_obj_umi_sub_neo <- bc_cure_depth(bc_obj_umi_sub, depth=0, isUpdate=FALSE)

# you can use the count_marks argument to display the cutoff points in the figure
# and the highlight argument to highlight specific barcodes.
bc_plot_single(bc_obj_umi_sub_neo, count_marks=10, 
    highlight= c("AAGTCCAGTACTATCGTACTA", "AAGTCCAGTACTGTAGCTACTA"))

## ----fig.height=7-------------------------------------------------------------
# create a new BarcodeObj for following visualization
# use depth as 0 to include all the barcodes.
bc_obj_umi_neo <- bc_cure_depth(bc_obj_umi[, 1:4], depth=0)
# you can set the count_marks to display the cutoff point
# and highlight specific barcodes dots by highlight
bc_plot_mutual(bc_obj_umi_neo, count_marks=c(10, 20, 30, 40), 
    highlight= c("AAGTCCAGTACTATCGTACTA", "AAGTCCAGTACTGTAGCTACTA"))

## ----fig.width=5--------------------------------------------------------------
# create a new BarcodeObj for following visualization
# use depth as 0 to include all the barcodes.
bc_obj_umi_neo <- bc_cure_depth(bc_obj_umi[, 1:4], depth=0)

# 2d scatters plot with x axis of sample_x and y axis of sample_y
# sample_x, and sample_y can be the sample name or sample index
bc_plot_pair(
    bc_obj_umi_neo, 
    sample_x = c("50000_mixa"),
    sample_y = c("50000_mixb", "12500_mixa", "195_mixb"), 
    count_marks_x = 10,
    count_marks_y = c(10, 20, 30),
    highlight= c("AAGTCCAGTACTATCGTACTA", "AAGTCCAGTACTGTAGCTACTA")
)

## -----------------------------------------------------------------------------
bc_names(bc_obj_umi_sub)

## -----------------------------------------------------------------------------
bc_2df(bc_obj_umi_sub)

## -----------------------------------------------------------------------------
bc_2dt(bc_obj_umi_sub)

## ----misc---------------------------------------------------------------------
bc_2matrix(bc_obj_umi_sub)

## -----------------------------------------------------------------------------
data(bc_obj)

# Join two samples with different barcodes 
bc_obj["AGAG", "test1"] + bc_obj["AAAG", "test1"]

# Join two samples with shared barcodes
bc_obj_join <- bc_obj["AGAG", "test1"] + bc_obj["AGAG", "test1"]
bc_obj_join

# In this case, the shared barcodes are not merged.
# Applying bc_cure_depth() to merge them.
bc_cure_depth(bc_obj_join)

# Remove barcodes
bc_obj - "AAAG"

# Select barcodes in white list
bc_obj * "AAAG"

## -----------------------------------------------------------------------------
bc_2df(bc_obj_umi_sub[bc_barcodes(bc_obj_umi_sub)[1], "781_mixa"])
                  ## 1. Use `bc_barcodes` to pull out all the barcodes in two
                  ##    samples, and choose the fist barcode.
       ## 2. Select the barcode got in step 1, and the sample named "781_mixa".
## 3. Convert the BarcodeObj object to a data.frame. 

## -----------------------------------------------------------------------------
sessionInfo()

