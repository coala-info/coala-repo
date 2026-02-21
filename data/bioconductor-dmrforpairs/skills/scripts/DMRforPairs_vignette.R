# Code example from 'DMRforPairs_vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'DMRforPairs_vignette.Rnw'

###################################################
### code chunk number 1: DMRforPairs_vignette.Rnw:27-29
###################################################
library(DMRforPairs)
data(DMRforPairs_data)


###################################################
### code chunk number 2: DMRforPairs_vignette.Rnw:33-34
###################################################
head(CL.methy,2)


###################################################
### code chunk number 3: DMRforPairs_vignette.Rnw:38-52
###################################################
parameters=expand.grid(min_distance = c(200,300), min_n = c(4,5))
recode=1
results.parameters =  tune_parameters(parameters,
 classes_gene=CL.methy$class.gene.related, 
 classes_island=CL.methy$class.island.related, 
 targetID=CL.methy$targetID, 
 chr=CL.methy$chromosome, 
 position=CL.methy$position, 
 m.v=CL.methy[,c(7:8)], 
 beta.v=CL.methy[,c(11:12)],
 recode=recode,
 gs=CL.methy$gene.symbol,
 do.parallel=0)
results.parameters


###################################################
### code chunk number 4: DMRforPairs_vignette.Rnw:55-62
###################################################
min_n=4
d=200
dM=1.4
pval_th=0.05
experiment="results_DMRforPairs_vignette"
method="fdr"
clr=c("red","blue","green")


###################################################
### code chunk number 5: DMRforPairs_vignette.Rnw:72-86
###################################################
output=DMRforPairs(
 classes_gene=CL.methy$class.gene.related,
 classes_island=CL.methy$class.island.related,
 targetID=CL.methy$targetID, 
 chr=CL.methy$chromosome, 
 position=CL.methy$position,
 m.v=CL.methy[,c(8:10)], 
 beta.v=CL.methy[,c(12:14)], 
 min_n=min_n,min_distance=d,min_dM=dM,
 recode=recode,
 sep=";",
 method=method,
 debug.v=FALSE,gs=CL.methy$gene.symbol,
 do.parallel=0)


###################################################
### code chunk number 6: DMRforPairs_vignette.Rnw:92-93
###################################################
head(output$classes$pclass,3) 


###################################################
### code chunk number 7: DMRforPairs_vignette.Rnw:96-97
###################################################
head(output$classes$pclass_recoded,3) 


###################################################
### code chunk number 8: DMRforPairs_vignette.Rnw:100-101
###################################################
head(output$classes$no.pclass,10) 


###################################################
### code chunk number 9: DMRforPairs_vignette.Rnw:104-105
###################################################
output$classes$u_pclass


###################################################
### code chunk number 10: DMRforPairs_vignette.Rnw:110-111
###################################################
head(output$regions$boundaries,4)


###################################################
### code chunk number 11: DMRforPairs_vignette.Rnw:114-115
###################################################
head(output$regions$valid.probes,2) 


###################################################
### code chunk number 12: DMRforPairs_vignette.Rnw:118-120
###################################################
head(output$regions$valid.m,2) 
head(output$regions$valid.beta,2) 


###################################################
### code chunk number 13: DMRforPairs_vignette.Rnw:123-124
###################################################
head(output$regions$perprobe,4) 


###################################################
### code chunk number 14: DMRforPairs_vignette.Rnw:129-130
###################################################
head(output$tested,1)


###################################################
### code chunk number 15: DMRforPairs_vignette.Rnw:146-153
###################################################
tested_inclannot=export_data(
 tested=output$tested,
 regions=output$regions,
 th=pval_th,min_n=min_n,min_dM=dM,min_distance=d,
 margin=10000,clr=clr,method=method,experiment.name=experiment,
 annotate.relevant=FALSE,annotate.significant=FALSE,
 FigsNotRelevant=FALSE,debug=FALSE)


###################################################
### code chunk number 16: DMRforPairs_vignette.Rnw:168-176
###################################################
plot_annotate_region(output$tested,
                     output$regions,
                     margin=10000,
                     regionID=16,
                     clr=clr,
                     annotate=FALSE,
                     scores=TRUE,
                     path=experiment)


###################################################
### code chunk number 17: DMRforPairs_vignette.Rnw:187-194
###################################################
plot_annotate_gene(gs="BMPER",
                   regions=output$regions,
                   margin=10000,
                   ID="BMPER",
                   clr=clr,
                   annotate=FALSE,
                   path=experiment)


###################################################
### code chunk number 18: DMRforPairs_vignette.Rnw:205-213
###################################################
plot_annotate_custom_region(chr=7,
                            st=33943000,
                            ed=33945000, 
                            output$regions,
                            margin=500,
                            ID="BMPER_TSS",
                            clr=clr,annotate=FALSE,
                            path=experiment)


