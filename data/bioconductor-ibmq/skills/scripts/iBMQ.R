# Code example from 'iBMQ' vignette. See references/ for full tutorial.

### R code from vignette source 'iBMQ.Rnw'

###################################################
### code chunk number 1: loading iBMQ package
###################################################
library(iBMQ)


###################################################
### code chunk number 2: loading SNP data (eval = FALSE)
###################################################
## data(snp)


###################################################
### code chunk number 3: loading gene data (eval = FALSE)
###################################################
## data(gene)


###################################################
### code chunk number 4: Calculate PPA (eval = FALSE)
###################################################
## #  PPA <-  eqtlMcmc(snp, gene, n.iter=100,burn.in=100,n.sweep=20,mc.cores=6, RIS=TRUE)


###################################################
### code chunk number 5: calculateThreshold (eval = FALSE)
###################################################
## cutoff <- calculateThreshold(PPA, 0.1)


###################################################
### code chunk number 6: count eQTL (eval = FALSE)
###################################################
## eqtl <- eqtlFinder(PPA, cutoff)


###################################################
### code chunk number 7: loading SNP data (eval = FALSE)
###################################################
## data(snppos)


###################################################
### code chunk number 8: loading gene (eval = FALSE)
###################################################
## data(genepos)


###################################################
### code chunk number 9: class SNP data (eval = FALSE)
###################################################
## eqtltype <- eqtlClassifier(eqtl, snppos, genepos,1000000)


###################################################
### code chunk number 10: ploteQTLs (eval = FALSE)
###################################################
## library(ggplot2)
## ggplot(eqtltype, aes(y=GeneStart, x=MarkerPosition)) +
## geom_point(aes(y=GeneStart, x=MarkerPosition,color = PPA), size = 1.5)+
## facet_grid(GeneChrm~MarkerChrm)+theme_bw(base_size = 12, base_family = "")+  
## theme(axis.ticks = element_blank(), axis.text.x = element_blank(), axis.text.y = element_blank())+scale_x_reverse()


###################################################
### code chunk number 11: hotpot (eval = FALSE)
###################################################
## hotspot <- hotspotFinder(eqtltype, 10)


###################################################
### code chunk number 12: hotpot (eval = FALSE)
###################################################
## data(genotype.liver)


###################################################
### code chunk number 13: hotpot (eval = FALSE)
###################################################
## data(phenotype.liver)


###################################################
### code chunk number 14: hotpot (eval = FALSE)
###################################################
## #PPA.liver <-  eqtlMcmc(genotype.liver, phenotype.liver, n.iter=100,burn.in=100,n.sweep=20,mc.cores=6, RIS=FALSE)


###################################################
### code chunk number 15: hotpot
###################################################
data(PPA.liver)


###################################################
### code chunk number 16: hotpot
###################################################
cutoff.liver <- calculateThreshold(PPA.liver, 0.2)


###################################################
### code chunk number 17: hotpot
###################################################
eqtl.liver <- eqtlFinder(PPA.liver, cutoff.liver)


###################################################
### code chunk number 18: hotpot
###################################################
data(probe.liver)


###################################################
### code chunk number 19: hotpot
###################################################
data(map.liver)


###################################################
### code chunk number 20: hotpot
###################################################
eqtl.type.liver <- eqtlClassifier(eqtl.liver, map.liver, probe.liver,5000000)


###################################################
### code chunk number 21: ploteQTLs
###################################################
library(ggplot2)
ggplot(eqtl.type.liver, aes(y=GeneStart, x=MarkerPosition)) +
geom_point(aes(y=GeneStart, x=MarkerPosition,color = PPA), size = 1.5)+
facet_grid(GeneChrm~MarkerChrm)+theme_bw(base_size = 12, base_family = "")+  
theme(axis.ticks = element_blank(), axis.text.x = element_blank(), axis.text.y = element_blank())+scale_x_reverse()


###################################################
### code chunk number 22: hotpot (eval = FALSE)
###################################################
## hotspot.liver <- hotspotFinder(eqtl.type.liver,20)


