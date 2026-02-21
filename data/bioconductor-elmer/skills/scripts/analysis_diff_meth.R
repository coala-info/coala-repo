# Code example from 'analysis_diff_meth' vignette. See references/ for full tutorial.

## ----echo = FALSE,hide=TRUE, message=FALSE, warning=FALSE---------------------
library(ELMER.data)
library(ELMER)
library(DT)
library(dplyr)
library(BiocStyle)

## ----eval=TRUE, message=FALSE, warning = FALSE, results = "hide"--------------
mae <- get(load("mae.rda"))

sig.diff <- get.diff.meth(
  data = mae, 
  group.col = "definition",
  group1 =  "Primary solid Tumor",
  group2 = "Solid Tissue Normal",
  minSubgroupFrac = 0.2, # if supervised mode set to 1
  sig.dif = 0.3,
  diff.dir = "hypo", # Search for hypomethylated probes in group 1
  cores = 1, 
  dir.out ="result", 
  pvalue = 0.01
)

## ----eval=TRUE, message=FALSE, warning = FALSE--------------------------------
head(sig.diff)  %>% datatable(options = list(scrollX = TRUE))
# get.diff.meth automatically save output files. 
# - getMethdiff.hypo.probes.csv contains statistics for all the probes.
# - getMethdiff.hypo.probes.significant.csv contains only the significant probes which
# is the same with sig.diff
# - a volcano plot with the diff mean and significance levels
dir(path = "result", pattern = "getMethdiff")  

## ----eval=TRUE, message=FALSE, warning = FALSE,echo=FALSE---------------------
group1 <-  "Primary solid Tumor"
group2 <- "Solid Tissue Normal"
out <- readr::read_csv(dir(path = "result", pattern = "getMethdiff.hypo.probes.csv",full.names = TRUE))

TCGAbiolinks:::TCGAVisualize_volcano(
  x = as.data.frame(out)[,grep("Minus",colnames(out),value = T)],
  y = out$adjust.p, 
  title =  paste0("Volcano plot - Probes ",
                  "hypomethylated in ", group1, " vs ", group2,"\n"),
  filename = NULL,
  label =  c(
    "Not Significant",
    paste0("Hypermethylated in ",group1),
    paste0("Hypomethylated in ",group1)
  ),
  ylab =  expression(paste(-Log[10],
                           " (FDR corrected P-values) [one tailed test]")),
  xlab =  expression(paste(
    "DNA Methylation difference (",beta,"-values)")
  ),
  x.cut = 0.3, 
  y.cut = 0.01
)


