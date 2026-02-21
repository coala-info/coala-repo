# Code example from 'MiRaGE' vignette. See references/ for full tutorial.

### R code from vignette source 'MiRaGE.Rnw'

###################################################
### code chunk number 1: MiRaGE.Rnw:124-128
###################################################
library(MiRaGE)
data(gene_exp)
library(Biobase)
result <- MiRaGE(gene_exp,species="HS")


###################################################
### code chunk number 2: UnevaluatedCode (eval = FALSE)
###################################################
## result <- MiRaGE(gene_exp,location="web",species="HS")


###################################################
### code chunk number 3: MiRaGE.Rnw:143-145
###################################################
data(gene_exp)
gene_exp


###################################################
### code chunk number 4: MiRaGE.Rnw:170-172
###################################################
x_gene <- read.csv(system.file("extdata/x_all_7a.csv",package="MiRaGE"),sep="\t")
x_gene[101:103,]


###################################################
### code chunk number 5: MiRaGE.Rnw:178-181
###################################################
gene_exp <- new("ExpressionSet",expr=data.matrix(x_gene[,-1]))
fData(gene_exp)[["gene_id"]] <- x_gene[,1]
pData(gene_exp)[["sample_name"]] <- colnames(x_gene)[-1]


###################################################
### code chunk number 6: MiRaGE.Rnw:194-195
###################################################
result$P1[1:3,]


###################################################
### code chunk number 7: MiRaGE.Rnw:208-210
###################################################
require(humanStemCell)
data(fhesc)


###################################################
### code chunk number 8: MiRaGE.Rnw:214-217
###################################################
pData(fhesc)[["sample_name"]] <- c("neg.1","neg.2","neg.3",
"pos.1","pos.2","pos.3")
fData(fhesc)[["gene_id"]] <-rownames(exprs(fhesc))


###################################################
### code chunk number 9: MiRaGE.Rnw:220-222
###################################################
require(MiRaGE)
result <- MiRaGE(fhesc,species="HS",ID="affy_hg_u133a_2")


###################################################
### code chunk number 10: MiRaGE.Rnw:225-226
###################################################
result$P0[order(result$P0[,2])[1:5],]


###################################################
### code chunk number 11: MiRaGE.Rnw:234-237
###################################################
require(beadarrayExampleData)
data(exampleBLData)
data(exampleSummaryData)


###################################################
### code chunk number 12: MiRaGE.Rnw:249-254
###################################################
vv <- exampleSummaryData[,1:12]
 fData(vv)[["gene_id"]] <- fData(exampleSummaryData)[["IlluminaID"]]
 pData(vv)[["sample_name"]] <- c("neg.1","neg.2","neg.3","neg.4",
"neg.5","neg.6","brain.1","brain.2","brain.3","brain.4","brain.5","brain.6")
result <- MiRaGE(vv,species="HS",ID="illumina_humanwg_6_v3")


###################################################
### code chunk number 13: MiRaGE.Rnw:257-258
###################################################
result$P1[order(result$P1[,2])[1:5],]


###################################################
### code chunk number 14: MiRaGE.Rnw:286-287
###################################################
save(file="TBL2",TBL2)


###################################################
### code chunk number 15: MiRaGE.Rnw:290-291
###################################################
load("TBL2")


###################################################
### code chunk number 16: MiRaGE.Rnw:294-295 (eval = FALSE)
###################################################
## result <- MiRaGE(...,species_force=F)


###################################################
### code chunk number 17: MiRaGE.Rnw:304-308
###################################################
library(MiRaGE)
data(gene_exp)
library(Biobase)
result <- MiRaGE(gene_exp,species="HS")


###################################################
### code chunk number 18: UnevaluatedCode (eval = FALSE)
###################################################
## TBL2_HS_gen() 


###################################################
### code chunk number 19: UnevaluatedCode (eval = FALSE)
###################################################
## TBL2_MM_gen()


###################################################
### code chunk number 20: UnevaluatedCode (eval = FALSE)
###################################################
## id_conv_gen(SP="MM")


###################################################
### code chunk number 21: UnevaluatedCode (eval = FALSE)
###################################################
## id_conv_gen(SP="HS")


###################################################
### code chunk number 22: UnevaluatedCode (eval = FALSE)
###################################################
## HS_conv_id()


###################################################
### code chunk number 23: UnevaluatedCode (eval = FALSE)
###################################################
## MM_conv_id()


###################################################
### code chunk number 24: MiRaGE.Rnw:348-349
###################################################
p.adjust(result$P1[,2],method="BH")


###################################################
### code chunk number 25: MiRaGE.Rnw:353-354
###################################################
result$P1[,1][p.adjust(result$P1[,2],method="BH")<0.05]


