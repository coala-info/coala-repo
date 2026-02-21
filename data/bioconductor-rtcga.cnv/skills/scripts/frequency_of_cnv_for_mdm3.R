# Code example from 'frequency_of_cnv_for_mdm3' vignette. See references/ for full tutorial.

## ----echo=FALSE-------------------------------------------------------------------------------------------------------------------------------------
library(knitr)
opts_chunk$set(comment="", message=FALSE, warning = FALSE, tidy.opts=list(keep.blank.line=TRUE, width.cutoff=150),options(width=150), cache=TRUE, eval = FALSE)

## ---------------------------------------------------------------------------------------------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("RTCGA.cnv")

## ---------------------------------------------------------------------------------------------------------------------------------------------------
# get.region.cnv.score <- function(chr="12", start=69240000, stop=69200000) {
#   list_cnv <- data(package="RTCGA.cnv")
#   datasets <- list_cnv$results[,"Item"]
# 
#   filtered <- lapply(datasets, function(dataname) {
#     tmp <- get(dataname)
#     tmp <- tmp[tmp$Chromosome == chr,]
#     tmp <- tmp[pmin(tmp$Start, tmp$End) <= pmax(stop, start) & pmax(tmp$Start, tmp$End) >= pmin(stop, start),]
#     data.frame(tmp, cohort=dataname)
#   })
# 
#   do.call(rbind, filtered)
# }
# MDM2.scores <- get.region.cnv.score(chr="12", start=69240000, stop=69200000)
# 
# # only one per patient
# MDM2.scores$Sample <- substr(MDM2.scores$Sample, 1, 12)
# MDM2.scores <- MDM2.scores[!duplicated(MDM2.scores$Sample),]

## ---------------------------------------------------------------------------------------------------------------------------------------------------
# cutoff <- log(3)/log(2)-1
# MDM2cuted <- cut(MDM2.scores$Segment_Mean, c(0, cutoff, Inf), labels = c("<= 3", "> 3"))

## ---------------------------------------------------------------------------------------------------------------------------------------------------
# table(MDM2.scores$cohort, MDM2cuted)

