# Code example from 'chipseqDBData' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", message=FALSE--------------------------------
require(knitr)
opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)

## -----------------------------------------------------------------------------
library(chipseqDBData)
h3k9ac.paths <- H3K9acData()
h3k9ac.paths

## -----------------------------------------------------------------------------
library(Rsamtools)
diagnostics <- list()
for (i in seq_len(nrow(h3k9ac.paths))) {
    stats <- scanBam(h3k9ac.paths$Path[[i]], 
        param=ScanBamParam(what=c("mapq", "flag")))
    flag <- stats[[1]]$flag
    mapq <- stats[[1]]$mapq

    mapped <- bitwAnd(flag, 0x4)==0
    diagnostics[[h3k9ac.paths$Name[i]]] <- c(
        Total=length(flag), 
        Mapped=sum(mapped),
        HighQual=sum(mapq >= 10 & mapped),
        DupMarked=sum(bitwAnd(flag, 0x400)!=0)
    )
}
diag.stats <- data.frame(do.call(rbind, diagnostics))
diag.stats$Prop.mapped <- diag.stats$Mapped/diag.stats$Total*100
diag.stats$Prop.marked <- diag.stats$DupMarked/diag.stats$Mapped*100
diag.stats

## -----------------------------------------------------------------------------
sessionInfo()

