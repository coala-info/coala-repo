# Code example from 'MethylSeqData' vignette. See references/ for full tutorial.

## ----style, echo=FALSE--------------------------------------------------------
knitr::opts_chunk$set(error = FALSE, warning = FALSE, message = FALSE)

## -----------------------------------------------------------------------------
library(MethylSeqData)
brain <- RizzardiHickeyBrain()
brain

## -----------------------------------------------------------------------------
out <- listDatasets()

## ----echo = FALSE-------------------------------------------------------------
out <- as.data.frame(out)
out$Taxonomy <- c(`10090` = "Mouse", `9606` = "Human")[as.character(out$Taxonomy)]
out$Call <- sprintf("`%s`", out$Call)
knitr::kable(out)

