# Code example from 'oncoscanR' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("oncoscanR")

## ----eval=FALSE---------------------------------------------------------------
# # install.packages('devtools')
# install_github('yannchristinat/oncoscanR')

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("GenomicRanges")
# 
# install.packages(c("magrittr", "jsonlite", "readr"))

## -----------------------------------------------------------------------------
library(oncoscanR)
segs.filename <- system.file("extdata", "chas_example.txt", 
                             package = "oncoscanR")
res <- workflow_oncoscan.chas(segs.filename)
print(res)

## -----------------------------------------------------------------------------
library(magrittr)

# Load the ChAS file
chas.fn <- system.file("extdata", "chas_example.txt", package = "oncoscanR")
segments <- load_chas(chas.fn, oncoscan_na33.cov)

# Clean the segments: restricted to Oncoscan coverage, LOH not overlapping
# with copy loss segments, smooth&merge segments within 300kb and prune
# segments smaller than 300kb.
segs.clean <- trim_to_coverage(segments, oncoscan_na33.cov) %>%
    adjust_loh() %>%
    merge_segments() %>%
    prune_by_size()

## -----------------------------------------------------------------------------
ascat.fn <- system.file("extdata", "ascat_example.txt", package = "oncoscanR")
ascat.segments <- load_ascat(ascat.fn, oncoscan_na33.cov)
head(ascat.segments)

## -----------------------------------------------------------------------------
chas.fn <- system.file("extdata", "triploide_gene_list_full_location.txt", 
                       package = "oncoscanR")
segments <- load_chas(chas.fn, oncoscan_na33.cov)
armlevel.loh <- get_loh_segments(segments) %>% 
    armlevel_alt(kit.coverage = oncoscan_na33.cov)

## -----------------------------------------------------------------------------
armlevel.loh <- get_loh_segments(segments) %>%
        armlevel_alt(kit.coverage = oncoscan_na33.cov, threshold = 0)

## -----------------------------------------------------------------------------
mbalt <- score_mbalt(segments, oncoscan_na33.cov)
percent.alt <- mbalt['sample']/mbalt['kit']
message(paste(mbalt['sample'], 'Mbp altered ->', round(percent.alt*100), 
              '% of genome'))

avgcn <- score_avgcn(segments, oncoscan_na33.cov)
wgd <- score_estwgd(segments, oncoscan_na33.cov)
message(paste('Average copy number:', round(avgcn, 2), '->', wgd['WGD'], 
'whole-genome doubling event'))

## -----------------------------------------------------------------------------
# Load data
chas.fn <- system.file("extdata", "LST_gene_list_full_location.txt", 
                       package = "oncoscanR")
segments <- load_chas(chas.fn, oncoscan_na33.cov)

# Clean the segments: restricted to Oncoscan coverage, LOH not overlapping
# with copy loss segments, smooth&merge segments within 300kb and prune
# segments smaller than 300kb.
segs.clean <- trim_to_coverage(segments, oncoscan_na33.cov) %>%
    adjust_loh() %>%
    merge_segments() %>%
    prune_by_size()

# Then we need to compute the arm-level alteration for loss and LOH since many 
# scores discard arms that are globally altered.
arms.loss <- names(get_loss_segments(segs.clean) %>%
        armlevel_alt(kit.coverage = oncoscan_na33.cov))
arms.loh <- names(get_loh_segments(segs.clean) %>%
        armlevel_alt(kit.coverage = oncoscan_na33.cov))

# Get the number of LST
lst <- score_lst(segs.clean, oncoscan_na33.cov)

# Get the number of HR-LOH
hrloh <- score_loh(segs.clean, arms.loh, arms.loss, oncoscan_na33.cov)

# Get the genomic LOH score
gloh <- score_gloh(segs.clean, arms.loh, arms.loss, oncoscan_na33.cov)

# Get the number of nLST
wgd <- score_estwgd(segs.clean, oncoscan_na33.cov)  # Get the avg CN, including 21p
nlst <- score_nlst(segs.clean, wgd["WGD"], oncoscan_na33.cov)

print(c(LST=lst, `HR-LOH`=hrloh, gLOH=gloh, nLST=nlst))

## -----------------------------------------------------------------------------
# Load data
chas.fn <- system.file("extdata", "TDplus_gene_list_full_location.txt", 
                       package = "oncoscanR")
segments <- load_chas(chas.fn, oncoscan_na33.cov)

# Clean the segments: restricted to Oncoscan coverage, LOH not overlapping
# with copy loss segments, smooth&merge segments within 300kb and prune
# segments smaller than 300kb.
segs.clean <- trim_to_coverage(segments, oncoscan_na33.cov) %>%
    adjust_loh() %>%
    merge_segments() %>%
    prune_by_size()

td <- score_td(segs.clean)
print(td$TDplus)

## -----------------------------------------------------------------------------
segs.filename <- system.file('extdata', 'LST_gene_list_full_location.txt', 
                             package = 'oncoscanR')
dat <- workflow_oncoscan.chas(segs.filename)

message(paste('Arms with copy loss:', 
              paste(dat$armlevel$LOSS, collapse = ', ')))
message(paste('Arms with copy gains:', 
              paste(dat$armlevel$GAIN, collapse = ', ')))
message(paste('HRD score:', dat$scores$HRD))

## -----------------------------------------------------------------------------
library(jsonlite)
segs.filename <- system.file('extdata', 'ascat_example.txt', 
                             package = 'oncoscanR')
dat <- workflow_oncoscan.ascat(segs.filename)
toJSON(dat, auto_unbox=TRUE, pretty=TRUE)

## -----------------------------------------------------------------------------
sessionInfo()

