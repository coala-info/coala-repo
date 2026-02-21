# Code example from 'plots_motif_enrichment' vignette. See references/ for full tutorial.

## ----echo = FALSE,hide=TRUE, message=FALSE, warning=FALSE---------------------
library(ELMER)
library(DT)
library(dplyr)
library(BiocStyle)

## ----results='hide', eval=TRUE, fig.height=6,fig.cap="The plot shows the Odds Ratio (x axis) for the selected motifs with OR above 1.3 and lower boundary of OR above 1.3. The range shows the 95% confidence interval for each Odds Ratio."----
motif.enrichment.plot(motif.enrichment = "result/getMotif.hypo.motif.enrichment.csv", 
                      significant = list(OR = 1.5,lowerOR = 1.3), 
                      label = "hypo", 
                      save = FALSE)  

## ----results='hide', eval=TRUE, fig.height=10,fig.cap="The plot shows the Odds Ratio (x axis) for the selected motifs with OR above 1.3 and lower boundary of OR above 1.3. The range shows the 95% confidence interval for each Odds Ratio."----
motif.enrichment.plot(motif.enrichment = "result/getMotif.hypo.motif.enrichment.csv", 
                      significant = list(OR = 1.5,lowerOR = 1.3), 
                      label = "hypo", 
                      summary = TRUE,
                      save = FALSE)  

