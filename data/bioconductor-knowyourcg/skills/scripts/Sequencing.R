# Code example from 'Sequencing' vignette. See references/ for full tutorial.

## ----seq1, fig.width=5, fig.height=5, message=FALSE, eval=.Platform$OS.type!="windows"----
# Code that should run only on non-Windows systems
library(knowYourCG)

# Download query and knowledgebase datasets:
temp_dir <- tempdir()
knowledgebase <- file.path(temp_dir, "ChromHMM.20220414.cm")
query <- file.path(temp_dir, "mm10_f3_10cells.cg")
knowledgebase_url <- "https://zenodo.org/records/18175656/files/ChromHMM.20220414.cm"
query_url <- "https://zenodo.org/records/18176004/files/mm10_f3_10cells.cg"
download.file(knowledgebase_url, destfile = knowledgebase)
download.file(query_url, destfile = query)

# test enrichment (require YAME installed in shell)
res = testEnrichment(query, knowledgebase)
KYCG_plotDot(res, short_label=TRUE)

## -----------------------------------------------------------------------------
sessionInfo()

