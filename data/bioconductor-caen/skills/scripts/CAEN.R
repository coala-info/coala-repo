# Code example from 'CAEN' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install("CAEN")

## ----message=FALSE,warning=FALSE----------------------------------------------
library(CAEN)
library(SummarizedExperiment)

## -----------------------------------------------------------------------------
data("realData")
realData

## ----message=FALSE, warning=FALSE---------------------------------------------
x <- realData                  
y <- c(rep(1,18),rep(2,18))      
xte <- realData                

prob <- estimatep(x = x, y = y, xte = x, beta = 1, type = "mle", prior = NULL)     
prob0 <- estimatep(x = x, y = y, xte = xte, beta = 1, type = "mle", 
                   prior = NULL)   
myscore <- CAEN(dataTable = x, y = y, K = 2, gene_no_list = 100)

## ----message=FALSE,warning=FALSE----------------------------------------------
ddd <- myscore$np
datx <- t(assay(x)[ddd,])
datxte <- t(assay(xte)[ddd,])
probb <- prob[ddd,]
probb0 <- prob0[ddd,]

zipldacv.out <- ZIPLDA.cv(x = datx, y = y, prob0 = t(probb))
ZIPLDA.out <- ZIPLDA(x = datx, y = y, xte = datxte, transform = FALSE, 
                     prob0 = t(probb0),rho = zipldacv.out$bestrho)
classResult <- ZIPLDA.out$ytehat

## -----------------------------------------------------------------------------
dat <- newCountDataSet(n = 100, p = 500, K = 4, param = 10, sdsignal = 2, 
                       drate = 0.2)

## ----message=FALSE, warning=FALSE---------------------------------------------
x <- t(assay(dat$sim_train_data))                  
y <- as.numeric(colnames(dat$sim_train_data))      
xte <- t(assay(dat$sim_test_data))                 

prob <- estimatep(x = x, y = y, xte = x, beta = 1, 
                  type = c("mle","deseq","quantile"),
                  prior = NULL)      
prob0 <- estimatep(x = x, y = y, xte = xte, beta = 1, 
                   type = c("mle","deseq","quantile"),
                   prior = NULL)   
myscore <- CAEN(dataTable = assay(dat$sim_train_data), 
                y = as.numeric(colnames(dat$sim_train_data)), K = 4,
                gene_no_list = 100)

## ----message=FALSE,warning=FALSE----------------------------------------------
ddd <- myscore$np
datx <- x[,ddd]
datxte <- xte[,ddd]
probb <- prob[ddd,]
probb0 <- prob0[ddd,]

zipldacv.out <- ZIPLDA.cv(x = datx, y = y, prob0 = t(probb))
ZIPLDA.out <- ZIPLDA(x = datx, y = y,
                     xte = datxte, transform = FALSE, prob0 = t(probb0),
                     rho = zipldacv.out$bestrho)
classResult <- ZIPLDA.out$ytehat

## -----------------------------------------------------------------------------
sessionInfo()

