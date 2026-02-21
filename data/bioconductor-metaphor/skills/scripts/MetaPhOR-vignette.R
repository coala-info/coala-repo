# Code example from 'MetaPhOR-vignette' vignette. See references/ for full tutorial.

## ----style, include = FALSE, results = 'asis'---------------------------------
BiocStyle::html_document()

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    dpi=200
)

library(kableExtra)

## ----message=FALSE------------------------------------------------------------
library(MetaPhOR)

## -----------------------------------------------------------------------------
exdegs <- read.csv(system.file("extdata/exampledegs.csv",
                                package = "MetaPhOR"),
                                header = TRUE)

## ----echo=FALSE---------------------------------------------------------------
kable(head(exdegs), format="html")    %>%
    kable_material()

## ----include=FALSE------------------------------------------------------------
# BRCA, OVCA, PRAD 
# sampsize <- c(1095, 378, 497)

## -----------------------------------------------------------------------------
set.seed(1234)

brca <- pathwayAnalysis(DEGpath = system.file("extdata/BRCA_DEGS.csv",
                        package = "MetaPhOR"),
                        genename = "X",
                        sampsize = 1095,
                        iters = 50000,
                        headers = c("logFC", "adj.P.Val"))

## ----echo = FALSE-------------------------------------------------------------
kable(head(brca), format="html", booktabs = TRUE)    %>%
    kable_material()

## -----------------------------------------------------------------------------
pval <- bubblePlot(scorelist = brca,
                    labeltext = "Pval",
                    labelsize = .85)
plot(pval)

## -----------------------------------------------------------------------------
logfc <- bubblePlot(scorelist = brca,
                    labeltext = "LogFC",
                    labelsize = .85)
plot(logfc)

## -----------------------------------------------------------------------------
##read in two additional sets of scores,
##run in the same manner as brca for comparison

ovca <- read.csv(system.file("extdata/OVCA_Scores.csv", package = "MetaPhOR"),
                header = TRUE,
                row.names = 1)
prad <- read.csv(system.file("extdata/PRAD_Scores.csv", package = "MetaPhOR"),
                header = TRUE,
                row.names = 1)

all.scores <- list(brca, ovca, prad)
names <- c("BRCA", "OVCA", "PRAD")

metaHeatmap(scorelist = all.scores,
            samplenames = names,
            pvalcut = 0.05)

## ----eval = FALSE-------------------------------------------------------------
# cytoPath(pathway = "Tryptophan Metabolism",
#             DEGpath = "BRCA_DEGS.csv",
#             figpath = paste(getwd(), "BRCA_Tryptophan_Pathway", sep = "/"),
#             genename = "X",
#             headers = c("logFC", "adj.P.Val"))

## ----echo = F, fig.wide = TRUE------------------------------------------------
knitr::include_graphics(c(system.file("extdata", "BRCA_Tryptophan_Pathway.png", 
                                        package = "MetaPhOR")))

## ----eval = FALSE-------------------------------------------------------------
# pathwayList()

## ----echo = F-----------------------------------------------------------------
kable(head(pathwayList()), format = "html", booktabs = TRUE)    %>%
    kable_material()

## -----------------------------------------------------------------------------
sessionInfo()

