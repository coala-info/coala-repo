# Code example from 'orthosIntro' vignette. See references/ for full tutorial.

## ----setup, include = FALSE, echo=FALSE, results="hide", message=FALSE--------
require(knitr)

knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    error = FALSE,
    warning = FALSE,
    message = FALSE,
    crop = NULL
)
stopifnot(requireNamespace("htmltools"))
htmltools::tagList(rmarkdown::html_dependency_font_awesome())


## ----library------------------------------------------------------------------
library(orthos)

## -----------------------------------------------------------------------------
MKL1_human <- readRDS(system.file("extdata", "GSE215150_MKL1_Human.rds",
                                  package = "orthos"))
head(MKL1_human)
dim(MKL1_human)

## -----------------------------------------------------------------------------
MKL1_mouse <- readRDS(system.file("extdata", "GSE215150_MKL1_Mouse.rds",
                                  package = "orthos"))
head(MKL1_mouse)
dim(MKL1_mouse)

## ----warning = FALSE, message = FALSE-----------------------------------------
#Decompose MKL1-vs-Cntrl and caMKL1-vs-Cntrl contrasts for human:
dec_MKL1_human <- decomposeVar(M = MKL1_human, treatm = c(2, 3), cntr = c(1, 1), 
                               organism = "Human", verbose = FALSE)
dec_MKL1_human

## ----warning = FALSE, message = FALSE-----------------------------------------
#Decompose MKL1-vs-Cntrl and caMKL1-vs-Cntrl contrasts for mouse:
dec_MKL1_mouse <- decomposeVar(M = MKL1_mouse, treatm = c(2, 3), cntr = c(1, 1),
                               organism = "Mouse", verbose = FALSE)
dec_MKL1_mouse

## -----------------------------------------------------------------------------
suppressPackageStartupMessages({
    library(ggplot2)
    library(SummarizedExperiment)
})
assays(dec_MKL1_mouse)

#MA plot of for the input contrasts:
DF <- data.frame(L2CPM= assay(dec_MKL1_mouse,"CONTEXT")[,2],
                 L2FC_INPUT=assay(dec_MKL1_mouse,"INPUT_CONTRASTS")[,2],
                 L2FC_DECODED=assay(dec_MKL1_mouse,"DECODED_CONTRASTS")[,2],
                 L2FC_RESIDUAL=assay(dec_MKL1_mouse,"RESIDUAL_CONTRASTS")[,2]
                 )

#MA plot of for the input contrast
P1 <- ggplot(data=DF, aes(x=L2CPM, y=L2FC_INPUT)) + 
  geom_point(alpha=0.4, size=1.8) + 
  geom_hline(aes(yintercept = 0), colour = "darkgray", linewidth = 0.5) +
  xlab("Expression (Log2 CPMs)") + 
  ylab("Log2 Fold Change")  

#Delta-delta plots for the input and decomposed contrast fractions
P2 <- ggplot(data=DF, aes(x=L2FC_INPUT, y=L2FC_DECODED)) + 
  geom_point(alpha=0.4, size=1.8) + 
  geom_hline(aes(yintercept = 0), colour = "darkgray", linewidth = 0.5) +
  xlab("Log2 Fold Change INPUT")  + 
  ylab("Log2 Fold Change DECODED")  

P3 <- ggplot(data=DF, aes(x=L2FC_INPUT, y=L2FC_RESIDUAL)) + 
  geom_point(alpha=0.4, size=1.8) + 
  geom_hline(aes(yintercept = 0), colour = "darkgray", linewidth = 0.5) +
  xlab("Log2 Fold Change INPUT")  + 
  ylab("Log2 Fold Change RESIDUAL")  

P4 <- ggplot(data=DF, aes(x=L2FC_DECODED, y=L2FC_RESIDUAL)) + 
  geom_point(alpha=0.4, size=1.8) + 
  geom_hline(aes(yintercept = 0), colour = "darkgray", linewidth = 0.5) +
  xlab("Log2 Fold Change DECODED")  + 
  ylab("Log2 Fold Change RESIDUAL")  

cowplot::plot_grid(P1,P2,P3,P4)

## -----------------------------------------------------------------------------
colData(dec_MKL1_human)

colData(dec_MKL1_mouse)

## ----fig.width = 12-----------------------------------------------------------
# parallelization parameters:
params <- BiocParallel::MulticoreParam(workers = 2)

# for demonstration purposes (for actual analyses, use 'mode = "ANALYSIS"'):
query.res.human <- queryWithContrasts(dec_MKL1_human, organism = "Human", 
                                      BPPARAM = params, verbose = FALSE, 
                                      mode = "DEMO")
names(query.res.human)

names(query.res.human$zscores)

# query contrasts in rows, `orthosData` entries in columns:
dim(query.res.human$zscores$RESIDUAL_CONTRASTS) 
summary(t(query.res.human$zscores$RESIDUAL_CONTRASTS))

#Information on the top hits of the query using the residual human MKL1/caMKL1 contrasts:
query.res.human$TopHits$RESIDUAL_CONTRASTS

## ----fig.width = 12-----------------------------------------------------------
# query the database using only the "caMKL1" mouse contrast, suppress plotting:
# for demonstration purposes (for actual analyses, use 'mode = "ANALYSIS"'):
query.res.mouse <- queryWithContrasts(dec_MKL1_mouse[, "caMKL1"], organism = "Mouse", 
                                      BPPARAM = params, verbose = FALSE, 
                                      plotType = "none", mode = "DEMO")

# plot results for individual contrasts using violin plots:
ViolinPlots_mouse <- plotQueryResultsViolin(query.res.mouse, doPlot = FALSE)
ViolinPlots_mouse[["caMKL1"]]

# plot results for individual contrasts using composite Manhattan/Density plots:
ManhDensPlots_mouse <- plotQueryResultsManh(query.res.mouse, doPlot = FALSE)
ManhDensPlots_mouse[["caMKL1"]]


#Information on the top hits of the query using the residual mouse caMKL1 contrasts:
query.res.mouse$TopHits$RESIDUAL_CONTRASTS

## -----------------------------------------------------------------------------
organism <- "Mouse"
orthosDB <- loadContrastDatabase(organism = "Mouse", mode = "DEMO")

orthosDB 

#Available contrast annotations:
colnames(colData(orthosDB))

#Available gene annotations:
colnames(rowData(orthosDB))

#Retrieve partial annotation for a specific contrast
#returned as a top-hit in the mouse caMKL1 query above:
colData(orthosDB)["GSM5021181", c("title", "series_id", "CNTname")]

# Compare context and individual contrast fractions between
# the mouse caMKL1 contrast under consideration and the "GSM5021181"
# query hit:
par(mfrow = c(2, 2))
queryID <- "GSM5021181"
for (contrast in names(assays(dec_MKL1_mouse))[c(4, 1, 2, 3)]) {
    unit <- "L2FC"
    if (contrast == "CONTEXT") {unit <- "L2CPM"}
    plot(assays(dec_MKL1_mouse)[[contrast]][, "caMKL1"],
         assays(orthosDB)[[contrast]][, queryID],
         pch = 16, cex = 0.5, col = "darkslategrey", main = contrast,
         xlab = paste0(unit, " caMKL1"), ylab = paste0(unit, " ", queryID))
    abline(0, 1, col = "darkred", lwd = 0.8, lty = 2)
}     

## -----------------------------------------------------------------------------
# mouse MKL1 context and contrast with the appropriate shape and representation.
#
# Shape of models input is M x N,  
# where M is the number of conditions,
# N the number of features -i.e orthos Genes
#
# Representation is L2CPMs for contexts and L2FCs for contrasts.
#
CONTEXT  <- t(assay(dec_MKL1_mouse,"CONTEXT")[,1])
CONTRAST <- t(assay(dec_MKL1_mouse,"INPUT_CONTRASTS")[,1])

# Activate the `basilisk` environment:
library(basilisk)
cl <- basiliskStart(orthos:::orthosenv,
                    testload = "tensorflow")

# Produce a latent embedding for the context with .predictEncoder:
LATC <- basilisk::basiliskRun(proc = cl,
                              fun = orthos:::.predictEncoder,
                              organism = "Mouse",
                              gene_input = CONTEXT)

# Produce a latent embedding and decoding for the contrast with .predictEncoderD:
res <- basilisk::basiliskRun(proc = cl,
                             fun = orthos:::.predictEncoderD,
                             organism = "Mouse",
                             delta_input = CONTRAST, context = LATC)

# Deactivate the `basilisk` environment:
basilisk::basiliskStop(cl)

# Access the contrast latent embedding and decoding from the .predictEncoderD returned result:
LATD <- res$LATD
DEC <- res$DEC

## -----------------------------------------------------------------------------
sessionInfo()

