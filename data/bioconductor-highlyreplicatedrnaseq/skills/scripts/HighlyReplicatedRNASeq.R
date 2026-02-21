# Code example from 'HighlyReplicatedRNASeq' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
schurch_se <- HighlyReplicatedRNASeq::Schurch16()

schurch_se

## -----------------------------------------------------------------------------
library(ExperimentHub)
eh <- ExperimentHub()
records <- query(eh, "HighlyReplicatedRNASeq")
records[1]           ## display the metadata for the first resource
count_matrix <- records[["EH3315"]]  ## load the count matrix by ID
count_matrix[1:10, 1:5]

## -----------------------------------------------------------------------------
summary(c(assay(schurch_se, "counts")))

## -----------------------------------------------------------------------------
norm_counts <- assay(schurch_se, "counts")
norm_counts <- log(norm_counts / colMeans(norm_counts) + 0.001)

## -----------------------------------------------------------------------------
hist(norm_counts, breaks = 100)

## -----------------------------------------------------------------------------
wt_mean <- rowMeans(norm_counts[, schurch_se$condition == "wildtype"])
ko_mean <- rowMeans(norm_counts[, schurch_se$condition == "knockout"])

plot((wt_mean+ ko_mean) / 2, wt_mean - ko_mean,
     pch = 16, cex = 0.4, col = "#00000050", frame.plot = FALSE)
abline(h = 0)

pvalues <- sapply(seq_len(nrow(norm_counts)), function(idx){
  tryCatch(
    t.test(norm_counts[idx, schurch_se$condition == "wildtype"], 
         norm_counts[idx, schurch_se$condition == "knockout"])$p.value,
  error = function(err) NA)
})

plot(wt_mean - ko_mean, - log10(pvalues),
     pch = 16, cex = 0.5, col = "#00000050", frame.plot = FALSE)

## -----------------------------------------------------------------------------
sessionInfo()

