# Code example from 'gDNAinRNAseqData' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE--------------------------------------------------------
options(width=80)

## ----message=FALSE------------------------------------------------------------
library(gDNAinRNAseqData)

bamfiles <- LiYu22subsetBAMfiles()
bamfiles

## -----------------------------------------------------------------------------
pdat <- LiYu22phenoData(bamfiles)
pdat

## ----session_info, cache=FALSE------------------------------------------------
sessionInfo()

