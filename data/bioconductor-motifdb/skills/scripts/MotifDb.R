# Code example from 'MotifDb' vignette. See references/ for full tutorial.

## ----load MotifDb, query CTCF, prompt=FALSE, message=FALSE, results="show"----
library(MotifDb)
query(MotifDb, "ctcf")

## ----query CTCF human, prompt=FALSE, message=FALSE, results="show"------------
library(MotifDb)
motifs <- query(MotifDb, andStrings=c("CTCF", "hsapiens"),
                orStrings=c("jaspar2018", "hocomocov11-core-A"),
                notStrings="ctcfl")
length(motifs)

## ----compare CTCF motifs, prompt=FALSE, message=FALSE, results="show"---------
sapply(motifs, consensusString)

## ----use seqLogo, prompt=FALSE, message=FALSE, results="hide", fig.width = 5, fig.height = 5, fig.show = "hold", out.width = "50%"----
library(seqLogo)
seqLogo(motifs[[1]])  # Hsapiens-jaspar2018-CTCF-MA0139.1
seqLogo(motifs[[2]])  # Hsapiens-HOCOMOCOv11-core-A-CTCF_HUMAN.H11MO.0.A


## ----ChIP-vs-FIMO, eval=TRUE, echo=FALSE--------------------------------------
knitr::include_graphics("GSM749704-CTCF-chipVsFimo.png")

