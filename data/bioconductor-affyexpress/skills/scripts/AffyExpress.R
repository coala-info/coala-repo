# Code example from 'AffyExpress' vignette. See references/ for full tutorial.

### R code from vignette source 'AffyExpress.Rnw'

###################################################
### code chunk number 1: AffyExpress.Rnw:54-60
###################################################
library(AffyExpress)
library(estrogen)
datadir <- system.file("extdata", package = "estrogen")
phenoD<-read.AnnotatedDataFrame("phenoData.txt", path=datadir, sep="", header=TRUE, row.names="filename")
raw<-ReadAffy(filenames=rownames(pData(phenoD)), phenoData= phenoD, celfile.path=datadir)
pData(raw)


###################################################
### code chunk number 2: AffyExpress.Rnw:69-70
###################################################
AffyQA (parameters=c("estrogen", "time.h"), raw=raw) 


###################################################
### code chunk number 3: AffyExpress.Rnw:86-88
###################################################
normaldata<-pre.process(method="rma", raw=raw) 
dims(normaldata) 


###################################################
### code chunk number 4: AffyExpress.Rnw:93-94
###################################################
filtered<-Filter(object=normaldata, numChip=2, bg=6) 


###################################################
### code chunk number 5: AffyExpress.Rnw:124-126
###################################################
design<-make.design(target=pData(filtered), cov="estrogen") 
design


###################################################
### code chunk number 6: AffyExpress.Rnw:146-149
###################################################
contrast<-make.contrast(design.matrix=design, compare1="present",
compare2="absent") 
contrast 


###################################################
### code chunk number 7: AffyExpress.Rnw:165-166
###################################################
result<-regress(object=filtered, design=design, contrast=contrast, method="L", adj="fdr") 


###################################################
### code chunk number 8: AffyExpress.Rnw:169-170
###################################################
result[1:3,] 


###################################################
### code chunk number 9: AffyExpress.Rnw:176-177
###################################################
select<-select.sig.gene(top.table=result, p.value=0.05, m.value=log2(1.5)) 


###################################################
### code chunk number 10: AffyExpress.Rnw:188-189
###################################################
result2html(cdf.name=annotation(filtered), result=select, filename="singleFactor") 


###################################################
### code chunk number 11: AffyExpress.Rnw:202-204
###################################################
result.wrapper<-AffyRegress(normal.data=filtered, cov="estrogen", compare1="present",
compare2="absent", method="L", adj="fdr", p.value=0.05, m.value=log2(1.5))


###################################################
### code chunk number 12: AffyExpress.Rnw:219-221
###################################################
design.rb<-make.design(target=pData(filtered), cov=c("estrogen", "time.h")) 
design.rb


###################################################
### code chunk number 13: AffyExpress.Rnw:233-235
###################################################
contrast.rb<-make.contrast(design.matrix=design.rb, compare1="present", compare2="absent") 
contrast.rb 


###################################################
### code chunk number 14: AffyExpress.Rnw:260-262
###################################################
design.int<-make.design(pData(filtered), cov=c("estrogen", "time.h"), int=c(1,2)) 
design.int


###################################################
### code chunk number 15: AffyExpress.Rnw:266-268
###################################################
contrast.10<-make.contrast(design.matrix=design.int, compare1 ="present", compare2="absent", level="10") 
contrast.10


###################################################
### code chunk number 16: AffyExpress.Rnw:271-273
###################################################
contrast.48<-make.contrast(design.matrix=design.int, compare1 ="present", compare2="absent", level="48") 
contrast.48


###################################################
### code chunk number 17: AffyExpress.Rnw:294-296
###################################################
contrast.int<-make.contrast(design.int, interaction=TRUE)
contrast.int 


###################################################
### code chunk number 18: AffyExpress.Rnw:302-303
###################################################
result.int<-regress(object=filtered, design=design.int, contrast=contrast.int, method="L") 


###################################################
### code chunk number 19: AffyExpress.Rnw:310-311
###################################################
select.int<-select.sig.gene(result.int, m.value=log2(1.5), p.value=0.05)


###################################################
### code chunk number 20: AffyExpress.Rnw:316-318
###################################################
sig.ID<-select.int$ID[select.int$significant==TRUE]
sig.index<-match(sig.ID, rownames(exprs(filtered))) 


###################################################
### code chunk number 21: AffyExpress.Rnw:332-334
###################################################
result2<-post.interaction(strata.var="time.h",compare1="present", compare2="absent", design.int=design.int, 
    object=filtered[sig.index,], method="L",adj="fdr", p.value=0.05, m.value=log2(1.5))


###################################################
### code chunk number 22: AffyExpress.Rnw:345-346
###################################################
interaction.result2html(cdf.name=annotation(filtered), result=result2, inter.result=result.int)


###################################################
### code chunk number 23: AffyExpress.Rnw:354-356
###################################################
result1<-regress(object=filtered[-sig.index,], design=design, contrast=contrast, method="L", adj="fdr") 
select<-select.sig.gene(top.table=result1, p.value=0.05, m.value=log2(1.5)) 


###################################################
### code chunk number 24: AffyExpress.Rnw:366-369
###################################################
result3<-AffyInteraction(object=filtered, method="L", main.var="estrogen", 
strata.var = "time.h", compare1="present", compare2="absent", p.int=0.05, m.int=log2(1.5), 
adj.int="none", p.value=0.05, m.value=log2(1.5), adj="fdr")


