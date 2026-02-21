# Code example from 'maigesPack_tutorial' vignette. See references/ for full tutorial.

### R code from vignette source 'maigesPack_tutorial.Rnw'

###################################################
### code chunk number 1: maigesPack_tutorial.Rnw:138-140
###################################################
library(maigesPack)
data(gastro)


###################################################
### code chunk number 2: maigesPack_tutorial.Rnw:148-149 (eval = FALSE)
###################################################
## gastro = loadData(fileConf="load_gastro.conf")


###################################################
### code chunk number 3: maigesPack_tutorial.Rnw:159-161 (eval = FALSE)
###################################################
## gastro = addGeneGrps(gastro, folder="geneGrps", ext="txt")
## gastro = addPaths(gastro, folder="geneNets", ext="tgf")


###################################################
### code chunk number 4: maigesPack_tutorial.Rnw:181-185
###################################################
gastro.raw = createMaigesRaw(gastro, greenDataField="Ch1.Mean",
  greenBackDataField="Ch1.B.Mean", redDataField="Ch2.Mean",
  redBackDataField="Ch2.B.Mean", flagDataField="Flags",
  gLabelGrp="GeneName", gLabelPath="GeneName")


###################################################
### code chunk number 5: WAplot1
###################################################
plot(gastro.raw[,1], bkgSub="none")


###################################################
### code chunk number 6: image1
###################################################
image(gastro.raw[,1])


###################################################
### code chunk number 7: maigesPack_tutorial.Rnw:233-235 (eval = FALSE)
###################################################
## boxplot(gastro.raw[,2])
## boxplot(gastro.raw)


###################################################
### code chunk number 8: hierRaw
###################################################
hierM(gastro.raw, rmGenes=c("BLANK","DAP","LYS","PHE", "Q_GENE","THR","TRP"),
              sLabelID="Sample", gLabelID="Name", doHeat=FALSE)


###################################################
### code chunk number 9: maigesPack_tutorial.Rnw:267-269
###################################################
gastro.raw2 = selSpots(gastro.raw, sigNoise=1, rmFlag=NULL, gLabelsID="Name",
  remove=list(c("BLANK","DAP","LYS","PHE","Q_GENE","THR","TRP")))


###################################################
### code chunk number 10: maigesPack_tutorial.Rnw:282-283
###################################################
gastro.norm = normLoc(gastro.raw2, span=0.4, method="loess")


###################################################
### code chunk number 11: maigesPack_tutorial.Rnw:293-295 (eval = FALSE)
###################################################
## gastro.norm = normOLIN(gastro.raw2)
## gastro.norm = normRepLoess(gastro.raw2)


###################################################
### code chunk number 12: maigesPack_tutorial.Rnw:303-304 (eval = FALSE)
###################################################
## gastro.norm = normScaleMarray(gastro.norm, norm="printTipMAD")


###################################################
### code chunk number 13: maigesPack_tutorial.Rnw:310-311 (eval = FALSE)
###################################################
## gastro.norm = normScaleMarray(gastro.norm, norm="globalMAD")


###################################################
### code chunk number 14: maigesPack_tutorial.Rnw:318-319 (eval = FALSE)
###################################################
## gastro.norm = normScaleLimma(gastro.norm, method="scale")


###################################################
### code chunk number 15: maigesPack_tutorial.Rnw:327-328 (eval = FALSE)
###################################################
## gastro.norm = normScaleLimma(gastro.raw2, method="vsn")


###################################################
### code chunk number 16: WAplot1N
###################################################
plot(gastro.norm[,1])


###################################################
### code chunk number 17: hierNorm
###################################################
hierM(gastro.norm, rmGenes=c("BLANK","DAP","LYS","PHE", "Q_GENE","THR","TRP"),
              sLabelID="Sample", gLabelID="Name", doHeat=FALSE)


###################################################
### code chunk number 18: maigesPack_tutorial.Rnw:370-373
###################################################
gastro.summ = summarizeReplicates(gastro.norm, gLabelID="GeneName",
  sLabelID="Sample", funcS="mean", funcG="median",
  keepEmpty=FALSE, rmBad=FALSE)


###################################################
### code chunk number 19: maigesPack_tutorial.Rnw:408-410
###################################################
gastro.ttest = deGenes2by2Ttest(gastro.summ, sLabelID="Type")
gastro.ttest


###################################################
### code chunk number 20: maigesPack_tutorial.Rnw:418-420 (eval = FALSE)
###################################################
## gastro.wilcox = deGenes2by2Wilcox(gastro.summ, sLabelID="Type")
## gastro.boot = deGenes2by2BootT(gastro.summ, sLabelID="Type")


###################################################
### code chunk number 21: maigesPack_tutorial.Rnw:426-428 (eval = FALSE)
###################################################
## plot(gastro.ttest)
## tablesDE(gastro.ttest)


###################################################
### code chunk number 22: som20
###################################################
somMde(gastro.ttest, sLabelID="Type", adjP="BH", nDEgenes=20,
       xdim=2, ydim=1, topol="rect")


###################################################
### code chunk number 23: maigesPack_tutorial.Rnw:463-464
###################################################
gastro.ANOVA = designANOVA(gastro.summ, factors="Tissue")


###################################################
### code chunk number 24: maigesPack_tutorial.Rnw:469-471
###################################################
gastro.ANOVAfit = deGenesANOVA(gastro.ANOVA, retF=TRUE)
gastro.ANOVAfit


###################################################
### code chunk number 25: maigesPack_tutorial.Rnw:476-477 (eval = FALSE)
###################################################
## gastro.ANOVAfit = deGenesANOVA(gastro.ANOVA, retF=FALSE)


###################################################
### code chunk number 26: maigesPack_tutorial.Rnw:489-491 (eval = FALSE)
###################################################
## boxplot(gastro.ANOVAfit, name="FUBP1", gLabelID="GeneName", 
## sLabelID="Tissue")


###################################################
### code chunk number 27: maigesPack_tutorial.Rnw:529-532
###################################################
gastro.class = classifyLDA(gastro.summ, sLabelID="Type",
  gNameID="GeneName", nGenes=3, geneGrp=6)
gastro.class


###################################################
### code chunk number 28: maigesPack_tutorial.Rnw:541-544 (eval = FALSE)
###################################################
## gastro.class = classifyLDA(gastro.summ, sLabelID="Tissue",
##   gNameID="GeneName", nGenes=3, geneGrp=6,
##   facToClass=list(Norm=c("Neso","Nest"), Ade=c("Aeso","Aest")))


###################################################
### code chunk number 29: maigesPack_tutorial.Rnw:551-553 (eval = FALSE)
###################################################
## plot(gastro.class, idx=1)
## tableClass(gastro.class)


###################################################
### code chunk number 30: maigesPack_tutorial.Rnw:578-580
###################################################
gastro.mod = activeMod(gastro.summ, sLabelID="Tissue", cutExp=1,
  cutPhiper=0.05)


###################################################
### code chunk number 31: maigesPack_tutorial.Rnw:586-587 (eval = FALSE)
###################################################
## plot(gastro.mod, "S", margins=c(15,3))


###################################################
### code chunk number 32: Mod
###################################################
plot(gastro.mod, "C", margins=c(23,5))


###################################################
### code chunk number 33: maigesPack_tutorial.Rnw:626-628 (eval = FALSE)
###################################################
## gastro.net = relNetworkB(gastro.summ, sLabelID="Tissue", 
##   samples="Neso", geneGrp=1)


###################################################
### code chunk number 34: maigesPack_tutorial.Rnw:637-639 (eval = FALSE)
###################################################
## image(gastro.net)
## plot(gastro.net, cutPval=0.05)


###################################################
### code chunk number 35: maigesPack_tutorial.Rnw:652-654 (eval = FALSE)
###################################################
## gastro.net2 = relNetworkM(gastro.summ, sLabelID="Tissue", 
##   samples = list(Neso="Neso", Aeso="Aeso"), geneGrp=7)


###################################################
### code chunk number 36: maigesPack_tutorial.Rnw:661-663 (eval = FALSE)
###################################################
## image(gastro.net2)
## plot(gastro.net2, cutPval=0.05)


###################################################
### code chunk number 37: maigesPack_tutorial.Rnw:670-671 (eval = FALSE)
###################################################
## plotGenePair(gastro.net2, "KLK13", "EVPL")


###################################################
### code chunk number 38: maigesPack_tutorial.Rnw:689-690
###################################################
gastro.net = activeNet(gastro.summ, sLabelID="Tissue")


###################################################
### code chunk number 39: Score
###################################################
plot(gastro.net, type="score", margins=c(21,5))


###################################################
### code chunk number 40: Pvalues
###################################################
plot(gastro.net, type="p-value", margins=c(21,5))


