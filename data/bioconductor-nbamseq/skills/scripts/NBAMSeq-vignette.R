# Code example from 'NBAMSeq-vignette' vignette. See references/ for full tutorial.

## ----echo = FALSE-------------------------------------------------------------
knitr::opts_chunk$set(comment = "", message=FALSE, warning = FALSE)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("NBAMSeq")

## -----------------------------------------------------------------------------
library(NBAMSeq)

## -----------------------------------------------------------------------------
## An example of countData
n = 50  ## n stands for number of genes
m = 20   ## m stands for sample size
countData = matrix(rnbinom(n*m, mu=100, size=1/3), ncol = m) + 1
mode(countData) = "integer"
colnames(countData) = paste0("sample", 1:m)
rownames(countData) = paste0("gene", 1:n)
head(countData)

## -----------------------------------------------------------------------------
## An example of colData
pheno = runif(m, 20, 80)
var1 = rnorm(m)
var2 = rnorm(m)
var3 = rnorm(m)
var4 = as.factor(sample(c(0,1,2), m, replace = TRUE))
colData = data.frame(pheno = pheno, var1 = var1, var2 = var2,
    var3 = var3, var4 = var4)
rownames(colData) = paste0("sample", 1:m)
head(colData)

## -----------------------------------------------------------------------------
design = ~ s(pheno) + var1 + var2 + var3 + var4

## -----------------------------------------------------------------------------
gsd = NBAMSeqDataSet(countData = countData, colData = colData, design = design)
gsd

## -----------------------------------------------------------------------------
gsd = NBAMSeq(gsd)

## ----eval=TRUE----------------------------------------------------------------
library(BiocParallel)
gsd = NBAMSeq(gsd, parallel = TRUE)

## -----------------------------------------------------------------------------
res1 = results(gsd, name = "pheno")
head(res1)

## -----------------------------------------------------------------------------
res2 = results(gsd, name = "var1")
head(res2)

## -----------------------------------------------------------------------------
res3 = results(gsd, contrast = c("var4", "2", "0"))
head(res3)

## -----------------------------------------------------------------------------
## assuming we are interested in the nonlinear relationship between gene10's 
## expression and "pheno"
makeplot(gsd, phenoname = "pheno", genename = "gene10", main = "gene10")

## -----------------------------------------------------------------------------
## here we explore the most significant nonlinear association
res1 = res1[order(res1$pvalue),]
topgene = rownames(res1)[1]  
sf = getsf(gsd)  ## get the estimated size factors
## divide raw count by size factors to obtain normalized counts
countnorm = t(t(countData)/sf) 
head(res1)

## -----------------------------------------------------------------------------
library(ggplot2)
setTitle = topgene
df = data.frame(pheno = pheno, logcount = log2(countnorm[topgene,]+1))
ggplot(df, aes(x=pheno, y=logcount))+geom_point(shape=19,size=1)+
    geom_smooth(method='loess')+xlab("pheno")+ylab("log(normcount + 1)")+
    annotate("text", x = max(df$pheno)-5, y = max(df$logcount)-1, 
    label = paste0("edf: ", signif(res1[topgene,"edf"],digits = 4)))+
    ggtitle(setTitle)+
    theme(text = element_text(size=10), plot.title = element_text(hjust = 0.5))

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

