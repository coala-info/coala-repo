# Code example from 'VignetteGeneGeneInteR_Introduction' vignette. See references/ for full tutorial.

### R code from vignette source 'VignetteGeneGeneInteR_Introduction.Rnw'

###################################################
### code chunk number 1: VignetteGeneGeneInteR_Introduction.Rnw:51-55 (eval = FALSE)
###################################################
## ped <- system.file("extdata/example.ped", package="GeneGeneInteR")
## info <- system.file("extdata/example.info", package="GeneGeneInteR")
## ## Information about position of the snps
## posi <- system.file("extdata/example.txt", package="GeneGeneInteR")


###################################################
### code chunk number 2: VignetteGeneGeneInteR_Introduction.Rnw:58-59 (eval = FALSE)
###################################################
## data <- importFile(file=ped, snps=info, pos=posi, pos.sep="\t")


###################################################
### code chunk number 3: VignetteGeneGeneInteR_Introduction.Rnw:66-67 (eval = FALSE)
###################################################
##  summary(data)


###################################################
### code chunk number 4: VignetteGeneGeneInteR_Introduction.Rnw:82-83 (eval = FALSE)
###################################################
## data$snpX


###################################################
### code chunk number 5: VignetteGeneGeneInteR_Introduction.Rnw:96-97 (eval = FALSE)
###################################################
## summary(data$genes.info)


###################################################
### code chunk number 6: VignetteGeneGeneInteR_Introduction.Rnw:116-117 (eval = FALSE)
###################################################
## Y <- read.table(system.file("/extdata/response.txt",package="GeneGeneInteR"),sep=";")


###################################################
### code chunk number 7: VignetteGeneGeneInteR_Introduction.Rnw:123-124 (eval = FALSE)
###################################################
## Y <- data$status


###################################################
### code chunk number 8: VignetteGeneGeneInteR_Introduction.Rnw:131-133 (eval = FALSE)
###################################################
## data <- snpMatrixScour(data$snpX,genes.info=data$genes.info,min.maf=0.05
## ,min.eq=1e-3,call.rate=0.9)


###################################################
### code chunk number 9: VignetteGeneGeneInteR_Introduction.Rnw:139-140 (eval = FALSE)
###################################################
## data$snpX


###################################################
### code chunk number 10: VignetteGeneGeneInteR_Introduction.Rnw:160-161 (eval = FALSE)
###################################################
## selec <- selectSnps(data$snpX, data$genes.info, select=1:10)


###################################################
### code chunk number 11: VignetteGeneGeneInteR_Introduction.Rnw:164-165 (eval = FALSE)
###################################################
## selec <- selectSnps(data$snpX, data$genes.info, c("DNAH9","TXNDC5"))


###################################################
### code chunk number 12: VignetteGeneGeneInteR_Introduction.Rnw:168-169 (eval = FALSE)
###################################################
## selec <- selectSnps(data$snpX, data$genes.info, c("15:101342000:101490000"))


###################################################
### code chunk number 13: VignetteGeneGeneInteR_Introduction.Rnw:181-182 (eval = FALSE)
###################################################
## sum(is.na(data$snpX))


###################################################
### code chunk number 14: VignetteGeneGeneInteR_Introduction.Rnw:190-191 (eval = FALSE)
###################################################
## data <- imputeSnpMatrix(data$snpX,data$genes.info)


###################################################
### code chunk number 15: VignetteGeneGeneInteR_Introduction.Rnw:199-200 (eval = FALSE)
###################################################
##  sum(is.na(data$snpX))


###################################################
### code chunk number 16: GGI (eval = FALSE)
###################################################
## GGI.res <- GGI(Y=Y, snpX=data$snpX, genes.info=data$genes.info,method="PCA")


###################################################
### code chunk number 17: VignetteGeneGeneInteR_Introduction.Rnw:237-238 (eval = FALSE)
###################################################
## class(GGI.res)


###################################################
### code chunk number 18: VignetteGeneGeneInteR_Introduction.Rnw:246-247 (eval = FALSE)
###################################################
## names(GGI.res)


###################################################
### code chunk number 19: VignetteGeneGeneInteR_Introduction.Rnw:260-261 (eval = FALSE)
###################################################
## round(GGI.res$p.value[1:4,1:4],digits=4)


###################################################
### code chunk number 20: VignetteGeneGeneInteR_Introduction.Rnw:279-280 (eval = FALSE)
###################################################
## summary(GGI.res)


