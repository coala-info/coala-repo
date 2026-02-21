# Code example from 'spkDoc' vignette. See references/ for full tutorial.

### R code from vignette source 'spkDoc.Rnw'

###################################################
### code chunk number 1: spkDoc.Rnw:229-230
###################################################
library(spkTools)


###################################################
### code chunk number 2: spkDoc.Rnw:233-235
###################################################
data(affy)
object <- affy


###################################################
### code chunk number 3: spkDoc.Rnw:239-242
###################################################
fc=2
label="Affymetrix"
par(mar=c(3,2.5,2,0.5), cex=1.8)


###################################################
### code chunk number 4: spkDoc.Rnw:249-250
###################################################
spkSlopeOut <- spkSlope(object, label, pch="+")


###################################################
### code chunk number 5: spkDoc.Rnw:264-265
###################################################
spkDensity(object, spkSlopeOut, cuts=TRUE, label)


###################################################
### code chunk number 6: spkDoc.Rnw:278-281
###################################################
spkBoxOut <- spkBox(object, spkSlopeOut, fc)
plotSpkBox(spkBoxOut, fc, ylim=c(-1.5,2.5))
sbox <- summarySpkBox(spkBoxOut)


###################################################
### code chunk number 7: spkDoc.Rnw:297-298
###################################################
spkMA(object, spkSlopeOut, fc, label=label, ylim=c(-2.5,2.5))


###################################################
### code chunk number 8: spkDoc.Rnw:316-330
###################################################
vtmp <- spkVar(object)
sv <- as.numeric(vtmp[,2][-nrow(vtmp)])
bin <- c("Low", "Med", "High")
bins <- bin[spkSlopeOut$breaks[2,]]
tab1 <- data.frame(NominalConc=2^spkSlopeOut$breaks[1,],
                   AvgExp=round(spkSlopeOut$avgExp,1),
                   PropGenesBelow=round(spkSlopeOut$prop,2),
                   ALEStrata=bins,
                   SD=round(sv,2))
colnames(tab1) <- c("Nominal Conc",
                    "Avg Expression",
                    "Prop of Genes Below",
                    "ALE Strata",
                    "Std Dev")


###################################################
### code chunk number 9: spkDoc.Rnw:333-336
###################################################
library(xtable)
tab1x <- xtable(tab1)
print(tab1x)


###################################################
### code chunk number 10: spkDoc.Rnw:352-366
###################################################
AccuracySlope <- round(spkSlopeOut$slopes[-1], digits=2)
AccuracySD <- round(spkAccSD(object, spkSlopeOut), digits=2)
pot <- spkPot(object, spkSlopeOut, AccuracySlope, AccuracySD, 
              precisionQuantile=.995)
PrecisionSD <- round(sbox$madFC[1:3], digits=2)
PrecisionQuantile <- round(pot$quantiles, digits=2)
SNR <- round(AccuracySlope/PrecisionSD, digits=2)
POT <- round(pot$POTs, digits=2)
tab2 <- data.frame(AccuracySlope=AccuracySlope,
                   AccuracySD=AccuracySD,
                   PrecisionSD=PrecisionSD,
                   PrecisionQuantile=PrecisionQuantile,
                   SNR=SNR,
                   POT=POT)


###################################################
### code chunk number 11: spkDoc.Rnw:368-370
###################################################
tab2x <- xtable(tab2)
print(tab2x)


###################################################
### code chunk number 12: spkDoc.Rnw:392-395
###################################################
bals <- round(spkBal(object))
anv <- round(spkAnova(object), digits=2)
tab3 <- t(c(anv,bals))


###################################################
### code chunk number 13: spkDoc.Rnw:397-399
###################################################
tab3x <- xtable(tab3)
print(tab3x)


