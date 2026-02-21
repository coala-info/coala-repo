# Code example from 'pfamAnalyzeR' vignette. See references/ for full tutorial.

## ----echo=FALSE, fig.align='left', out.width="85%"----------------------------
knitr::include_graphics("schemtic_overview.jpg")

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(pfamAnalyzeR)

## ----locate file--------------------------------------------------------------
### Create sting pointing to result file
# note that you do not need to use the "system.file".
# That is only needed when accessing files in an R package
pfamResultFile <- system.file(
    "extdata/pfam_results.txt",
    package = "pfamAnalyzeR"
)

file.exists(pfamResultFile)

## ----run analysis-------------------------------------------------------------
### Run entire pfam analysis
pfamRes <- pfamAnalyzeR(pfamResultFile)

## ----explore results----------------------------------------------------------

### Look at a few entries
pfamRes %>% 
    select(seq_id, hmm_name, type, domain_isotype, domain_isotype_simple) %>% 
    head()

### Summarize domain isotype
table(pfamRes$domain_isotype)

### Summarize domain isotype
table(pfamRes$domain_isotype_simple)

## ----type cautions------------------------------------------------------------
table(
    pfamRes$type,
    pfamRes$domain_isotype_simple
)

## ----session info-------------------------------------------------------------
sessionInfo()

