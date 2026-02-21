# Code example from 'SingleCellSignalR-Main' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::knit_hooks$set(optipng = knitr::hook_optipng)
options(rmarkdown.html_vignette.check_title = FALSE)

## ----load-libs, message = FALSE,  warning = FALSE, results = FALSE------------
library(BulkSignalR)
library(SingleCellSignalR)

## ----code1 , eval=TRUE,cache=FALSE--------------------------------------------

data(example_dataset,package='SingleCellSignalR')
mat <- log1p(data.matrix(example_dataset[,-1]))/log(2)
rownames(mat) <- example_dataset[[1]]
rme <- rowMeans(mat)
mmat <- mat[rme>0.05,]
d <- dist(t(mmat))
h <- hclust(d, method="ward.D")
clusters <- paste0("pop_", cutree(h, 5))

# SCSRNoNet -> LRscore based approach

scsrnn <- SCSRNoNet(mat,normalize=FALSE,method="log-only",
    min.count=1,prop=0.001,
    log.transformed=TRUE,populations=clusters)

scsrnn <- performInferences(scsrnn,verbose=TRUE,
    min.logFC=1e-10,max.pval=1,min.LR.score=0.5)

# SCSRNet -> DifferentialMode based approach

scsrcn <- SCSRNet(mat,normalize=FALSE,method="log-only",
    min.count=1,prop=0.001,
    log.transformed=TRUE,populations=clusters)

if(FALSE){
scsrcn <- performInferences(scsrcn,
    selected.populations = c("pop_1","pop_2","pop_3"),
    verbose=TRUE,rank.p=0.8,
    min.logFC=log2(1.01),max.pval=0.05)

print("getAutocrines")
inter1 <- getAutocrines(scsrcn, "pop_1")
head(inter1)

print("getParacrines")
inter2 <- getParacrines(scsrcn, "pop_1","pop_2")
head(inter2)

# Visualisation

cellNetBubblePlot(scsrcn)
}


## ----session-info-------------------------------------------------------------
sessionInfo()

