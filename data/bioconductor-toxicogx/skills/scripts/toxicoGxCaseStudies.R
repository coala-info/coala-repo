# Code example from 'toxicoGxCaseStudies' vignette. See references/ for full tutorial.

## ----setup, include = FALSE, cache = FALSE, message = FALSE-------------------

library("knitr")

### Chunk options: see http://yihui.name/knitr/options/ ###

## Text results
opts_chunk$set(echo = TRUE, warning = TRUE, message = FALSE, include = TRUE)

## Cache
opts_chunk$set(cache = 3, cache.path = "output/cache/")

## Plots
opts_chunk$set(fig.path = "output/figures/")


## ----eval = FALSE, message = FALSE, results = 'hide'--------------------------
# BiocManager::install("ToxicoGx")

## ----message = FALSE, fig.width = 8, fig.height = 3---------------------------
library(CoreGx)
library(ToxicoGx)
library(ggplot2)

# Load the tset
data(TGGATESsmall)
ToxicoGx::drugGeneResponseCurve(TGGATESsmall,
                      duration = c("2", "8", "24"),
                      cell_lines = "Hepatocyte", mDataTypes = "rna",
                      features = "ENSG00000140465_at",
                      dose = c("Control", "Low", "Middle", "High"),
                      drug = "Carbon tetrachloride",
                      ggplot_args = list(labs(title="Effect of Carbon tetra chloride on CYP1A1")),
                      summarize_replicates = FALSE
                      )


## ----echo = FALSE, out.width="500px"------------------------------------------
knitr::include_graphics('CS1_published.png')

## ----results = 'asis', warnings=FALSE-----------------------------------------
library(xtable)
data("TGGATESsmall")
# To compute the effect of drug concentration on the molecular profile of the cell
drug.perturbation <- ToxicoGx::drugPerturbationSig(tSet = TGGATESsmall,
                                         mDataType = "rna",
                                         cell_lines = "Hepatocyte",
                                         duration = "24",
                                         features = fNames(TGGATESsmall, "rna"),
                                         dose = c("Control", "Low"),
                                         drugs = c("Omeprazole", "Isoniazid"),
                                         returnValues=c("estimate","tstat", "pvalue", "fdr"),
                                         verbose = FALSE)
data(HCC_sig)
res <- apply(drug.perturbation[,,c("tstat", "fdr")],
             2, function(x, HCC){
               return(CoreGx::connectivityScore(x = x,
                                        y = HCC[, 2, drop = FALSE],
                                        method = "fgsea", nperm=100))
             },
             HCC = HCC_sig[seq_len(195),])
rownames(res) <- c("Connectivity", "P Value")
res <- t(res)
res <-  cbind(res,"FDR" = p.adjust(res[,2], method = "fdr"))
res <- res[order(res[,3]),]
knitr::kable(res,
       caption = 'Connectivity Score results for HCC and TG-GATEs PHH gene
       signature')

