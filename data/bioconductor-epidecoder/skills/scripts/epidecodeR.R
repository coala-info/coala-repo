# Code example from 'epidecodeR' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----echo=FALSE, out.width="90%"----------------------------------------------
knitr::include_graphics("steps.png")

## ----eval=FALSE---------------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("epidecodeR")

## ----setup--------------------------------------------------------------------
library(epidecodeR)

## -----------------------------------------------------------------------------
events<-system.file("extdata", "NOMO-1_ref_peaks.bed", package="epidecodeR")
deg<-system.file("extdata", "FTOi.txt", package="epidecodeR")
epiobj <- epidecodeR(events = events, deg = deg, pval=0.05, param = 3, ints=c(2,4))

## ----fig.width=6, fig.height=6------------------------------------------------
makeplot(epiobj, lim = c(-10,10), title = "m6A mediated dysregulation after FTO inhibitor treatment", xlab = "log2FC")

## ----fig.width=6, fig.height=6------------------------------------------------
plot_test(epiobj, title = "m6A mediated dysregulation after FTO inhibitor treatment", ylab = "log2FC")

## -----------------------------------------------------------------------------
events<-system.file("extdata", "eventcounts.txt", package="epidecodeR")
events_df<-read.table(events, header = TRUE, row.names = NULL, stringsAsFactors = FALSE, sep = "\t", fill = TRUE)

## -----------------------------------------------------------------------------
head (events_df)

## -----------------------------------------------------------------------------
events<-system.file("extdata", "NOMO-1_ref_peaks.bed", package="epidecodeR")
peaks_df<-read.table(events, header = FALSE, row.names = NULL, stringsAsFactors = FALSE, sep = "\t", fill = TRUE)

## -----------------------------------------------------------------------------
head (peaks_df)

## -----------------------------------------------------------------------------
head (get_theoretical_table(epiobj))

## -----------------------------------------------------------------------------
head (get_empirical_table(epiobj))

## -----------------------------------------------------------------------------
head (get_grpcounts(epiobj))

## -----------------------------------------------------------------------------
grptables_list<-get_grptables(epiobj)
head (grptables_list$'0')
head (grptables_list$'1')
head (grptables_list$'2to4')
head (grptables_list$'5+')

## ----fig.width=6, fig.height=6------------------------------------------------
makeplot(epiobj, lim = c(-10,10), title = "m6A mediated dysregulation after FTO inhibitor treatment", xlab = "log2FC")

## ----fig.width=6, fig.height=6------------------------------------------------
plot_test(epiobj, title = "m6A mediated dysregulation after FTO inhibitor treatment", ylab = "log2FC")

## -----------------------------------------------------------------------------
sessionInfo()

