# Code example from 'UCSCRepeatMasker' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE--------------------------------------------------------
options(width=80)

## ----message=FALSE, cache=FALSE-----------------------------------------------
library(AnnotationHub)

## ----message=FALSE, cache=FALSE-----------------------------------------------
ah <- AnnotationHub()
query(ah, c("UCSC", "RepeatMasker", "Homo sapiens"))

## ----message=FALSE, cache=FALSE-----------------------------------------------
rmskhg38 <- ah[["AH99003"]]
rmskhg38

## ----message=FALSE, cache=FALSE-----------------------------------------------
metadata(rmskhg38)

## ----session_info, cache=FALSE------------------------------------------------
sessionInfo()

