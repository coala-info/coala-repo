# Code example from 'Step3.PostProcessing' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, 
                      results = "markup", 
                      message = FALSE, 
                      warning = FALSE)
knitr::opts_chunk$set(fig.width=6, fig.height=4) 

## -----------------------------------------------------------------------------
library(Sconify)
wand.final <- PostProcessing(scone.output = wand.scone,
                         cell.data = wand.combined,
                         input = input.markers)


wand.combined # input data
wand.scone # scone-generated data
wand.final # the data after post-processing

# tSNE map shows highly responsive population of interest
TsneVis(wand.final, 
        "pSTAT5(Nd150)Di.IL7.change", 
        "IL7 -> pSTAT5 change")

# tSNE map now colored by q value
TsneVis(wand.final, 
        "pSTAT5(Nd150)Di.IL7.qvalue", 
        "IL7 -> pSTAT5 -log10(qvalue)")

# tSNE map colored by KNN density estimation
TsneVis(wand.final, "density")


## -----------------------------------------------------------------------------
wand.final.sub <- SubsampleAndTsne(dat = wand.final, 
                                   input = input.markers, 
                                   numcells = 500)
wand.final.sub

