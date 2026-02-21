# Code example from 'GlobalAncovaDecomp' vignette. See references/ for full tutorial.

### R code from vignette source 'GlobalAncovaDecomp.rnw'

###################################################
### code chunk number 1: GlobalAncovaDecomp.rnw:25-32
###################################################
#library(Biobase)
library(GlobalAncova)
data(vantVeer)
data(phenodata)	
data(pathways)	
sI <- sessionInfo()
options(width=70)


###################################################
### code chunk number 2: data
###################################################
library(GlobalAncova)
data(vantVeer)
data(phenodata)	
data(pathways)	
formula <- ~ grade + metastases + ERstatus


###################################################
### code chunk number 3: sequential
###################################################
GlobalAncova.decomp(xx = vantVeer, formula = formula, model.dat = phenodata, method = "sequential")


###################################################
### code chunk number 4: GlobalAncovaDecomp.rnw:111-113
###################################################
formula2 <- ~ ERstatus + metastases + grade
GlobalAncova.decomp(xx = vantVeer, formula = formula2, model.dat = phenodata, method = "sequential")


###################################################
### code chunk number 5: type3
###################################################
GlobalAncova.decomp(xx = vantVeer, formula = formula, model.dat = phenodata, method = "type3")


###################################################
### code chunk number 6: pathw
###################################################
GlobalAncova.decomp(xx = vantVeer, formula = formula, model.dat = phenodata, method = "type3", test.genes = pathways[1:3])


###################################################
### code chunk number 7: genewise
###################################################
GlobalAncova.decomp(xx = vantVeer, formula = formula, model.dat = phenodata, test.genes = pathways[[1]][1:3], genewise = TRUE)


###################################################
### code chunk number 8: plotseq (eval = FALSE)
###################################################
## Plot.sequential(vantVeer, formula = ~ ERstatus + metastases + grade, model.dat = phenodata, test.genes = pathways[[3]], name.geneset = "cell cycle pathway")


###################################################
### code chunk number 9: GlobalAncovaDecomp.rnw:191-192
###################################################
Plot.sequential(vantVeer, formula = ~ ERstatus + metastases + grade, model.dat = phenodata, test.genes = pathways[[3]], name.geneset = "cell cycle pathway")


###################################################
### code chunk number 10: combplot (eval = FALSE)
###################################################
## Plot.all(vantVeer, formula = ~ ERstatus + metastases + grade, model.dat = phenodata, test.genes = pathways[[3]], name.geneset = "cell cycle pathway")


###################################################
### code chunk number 11: GlobalAncovaDecomp.rnw:213-214
###################################################
Plot.all(vantVeer, formula = ~ ERstatus + metastases + grade, model.dat = phenodata, test.genes = pathways[[3]], name.geneset = "cell cycle pathway")


###################################################
### code chunk number 12: pairwise
###################################################
pair.compare(xx = vantVeer, formula = ~ grade, model.dat = phenodata, group = "grade", perm = 100)


###################################################
### code chunk number 13: GlobalAncovaDecomp.rnw:271-272
###################################################
data(colon.tumour)


###################################################
### code chunk number 14: groene
###################################################
data(colon.tumour)
data(colon.normal)
data(colon.pheno)
formula <- ~ UICC.stage + sex + location
GlobalAncova.decomp(xx = colon.tumour, formula = formula, model.dat = colon.pheno, method = "type3")


###################################################
### code chunk number 15: diff
###################################################
GlobalAncova.decomp(xx = colon.tumour - colon.normal, formula = formula, model.dat = colon.pheno, method = "type3")


###################################################
### code chunk number 16: zz
###################################################
GlobalAncova.decomp(xx = colon.tumour, formula = formula, model.dat = colon.pheno, method = "all", zz = colon.normal)


###################################################
### code chunk number 17: zzgw
###################################################
GlobalAncova.decomp(xx = colon.tumour, formula = formula, model.dat = colon.pheno, method = "all", zz = colon.normal, zz.per.gene = TRUE)


