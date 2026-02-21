# Code example from 'tutorial' vignette. See references/ for full tutorial.

## ----echo=FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = FALSE,comment = "#>",fig.pos='H')

## ----eval=TRUE, message=FALSE, warning=FALSE, results='hide'-------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
    # install.packages("BiocManager")
# BiocManager::install("PathwaySplice")
library(PathwaySplice)

## ----eval = FALSE--------------------------------------------------------
#  library(devtools)
#  install_github("SCCC-BBC/PathwaySplice")

## ----eval=TRUE, warning=FALSE, message=FALSE, results='markup'-----------
data(featureBasedData)
head(featureBasedData)

## ----eval=TRUE, message=FALSE, warning=FALSE, results='markup'-----------
gene.based.table <- makeGeneTable(featureBasedData, stat = "pvalue")
head(gene.based.table)

## ----eval=TRUE, warning=FALSE, message=FALSE, results='markup'-----------
lrTestBias(gene.based.table, boxplot.width = 0.3)

## ----eval=TRUE, message=FALSE, warning=FALSE, results='markup'-----------
gene.based.table.fdr <- makeGeneTable(featureBasedData, stat = "fdr")
lrTestBias(gene.based.table.fdr, boxplot.width = 0.3)

## ----eval=TRUE,warning=FALSE,message=FALSE,results='markup'--------------
result.adjusted <- runPathwaySplice(genewise.table = gene.based.table.fdr,
                                    genome = "hg19",
                                    id = "ensGene",
                                    test.cats = c("GO:BP"),
                                    go.size.limit = c(5, 30),
                                    method = "Wallenius",
                                    use.genes.without.cat = TRUE)

head(result.adjusted)

## ----eval=TRUE, warning=FALSE,message=FALSE,results ='markup', fig.align='right', fig.height=13, fig.width=15----
enmap <- enrichmentMap(pathway.res = result.adjusted,
                       n = 7,
                       output.file.dir = tempdir(),
                       similarity.threshold = 0.5, 
                       scaling.factor = 2)

## ----eval=FALSE, message = FALSE, warning=FALSE, fig.show='hide'---------
#  dir.name <- system.file("extdata", package = "PathwaySplice")
#  hallmark.local.pathways <- file.path(dir.name, "h.all.v6.0.symbols.gmt.txt")
#  hlp <- gmtGene2Cat(hallmark.local.pathways, genomeID = "hg19")
#  
#  result.hallmark <- runPathwaySplice(genewise.table = gene.based.table.fdr,
#                                      genome = "hg19",
#                                      id = "ensGene",
#                                      gene2cat = hlp,
#                                      go.size.limit = c(5, 100),
#                                      method = "Wallenius",
#                                      binsize = 20,
#                                      use.genes.without.cat = TRUE)

## ----eval=FALSE, message=FALSE, warning=FALSE,results='markup',fig.show='hide'----
#  
#  outKegg2Gmt("hsa", file.path(dir.name, "kegg.gmt.txt"))
#  
#  kegg.pathways <- gmtGene2Cat(file.path(dir.name, "kegg.gmt.txt"),
#                               genomeID = "hg19")
#  
#  result.kegg <- runPathwaySplice(genewise.table = gene.based.table.fdr,
#                                  genome = "hg19",
#                                  id = "ensGene",
#                                  gene2cat = kegg.pathways,
#                                  go.size.limit = c(5, 100),
#                                  method = "Wallenius",
#                                  use.genes.without.cat = TRUE)
#  

## ----eval=FALSE----------------------------------------------------------
#  dir <- system.file("extdata", package="PathwaySplice")
#  all.gene.table <- readRDS(file.path(dir, "AllGeneTable.rds"))

## ----eval=FALSE, warning=FALSE, message=FALSE, results='markup', fig.show='hide'----
#  res.adj <- runPathwaySplice(genewise.table = all.gene.table,
#                              genome = "hg19",
#                              id = "ensGene",
#                              test.cats = "GO:BP",
#                              go.size.limit = c(5, 30),
#                              method = "Wallenius")
#  
#  res.unadj <- runPathwaySplice(genewise.table = all.gene.table,
#                                genome = "hg19",
#                                id = "ensGene",
#                                test.cats = "GO:BP",
#                                go.size.limit = c(5, 30),
#                                method = "Hypergeometric")
#  compareResults(n.go = 20,
#                 adjusted = res.adj,
#                 unadjusted = res.unadj,
#                 gene.based.table = all.gene.table,
#                 output.dir = tempdir(),
#                 type.boxplot = "Only3")

## ----eval=FALSE,warning=FALSE,message=FALSE,results='markup'-------------
#  PathwaySplice:::compareResults2(result.hyper,
#                  result.Wall,
#                  result.Sampling,
#                  result.Sampling.200k)
#  

