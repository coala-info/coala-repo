# Code example from 'CancerMutationAnalysis' vignette. See references/ for full tutorial.

### R code from vignette source 'CancerMutationAnalysis.Rnw'

###################################################
### code chunk number 1: LoadData
###################################################
library(CancerMutationAnalysis)
data(WoodBreast07)
data(WoodColon07)
data(JonesPancreas08)
data(ParsonsGBM08)
data(ParsonsMB11)


###################################################
### code chunk number 2: GeneAlter
###################################################
head(GeneAlterGBM)


###################################################
### code chunk number 3: GeneCov
###################################################
head(GeneCovGBM)


###################################################
### code chunk number 4: GeneSamp
###################################################
head(GeneSampGBM)


###################################################
### code chunk number 5: CalcScores
###################################################
ScoresGBM <- cma.scores(cma.alter = GeneAlterGBM,
                        cma.cov = GeneCovGBM,
                        cma.samp = GeneSampGBM,
                        passenger.rates = BackRatesGBM["MedianRates",])

head(ScoresGBM)


###################################################
### code chunk number 6: FdrFig
###################################################
set.seed(188310)
FdrGBM <-  cma.fdr(cma.alter = GeneAlterGBM,
                   cma.cov = GeneCovGBM,
                   cma.samp = GeneSampGBM,
                   scores = "logLRT",
                   passenger.rates = BackRatesGBM["MedianRates",],
                   showFigure=TRUE,
                   cutoffFdr=0.1,
                   M = 5)

head(FdrGBM[["logLRT"]])


###################################################
### code chunk number 7: FdrFig-here
###################################################
set.seed(188310)
FdrGBM <-  cma.fdr(cma.alter = GeneAlterGBM,
                   cma.cov = GeneCovGBM,
                   cma.samp = GeneSampGBM,
                   scores = "logLRT",
                   passenger.rates = BackRatesGBM["MedianRates",],
                   showFigure=TRUE,
                   cutoffFdr=0.1,
                   M = 5)

head(FdrGBM[["logLRT"]])


###################################################
### code chunk number 8: loadKEGGsets
###################################################
library(KEGG.db)
KEGGPATHID2EXTID


###################################################
### code chunk number 9: loadEntrezID2Name
###################################################
data(EntrezID2Name)


###################################################
### code chunk number 10: GeneSet
###################################################
as.character(KEGGPATHNAME2ID[c("Endometrial cancer", 
                               "Non-small cell lung cancer",
                               "Alanine, aspartate and glutamate metabolism")])

SetResultsGBM <-
  cma.set.stat(cma.alter = GeneAlterGBM,
               cma.cov = GeneCovGBM,
               cma.samp = GeneSampGBM,
               GeneSets = KEGGPATHID2EXTID[c("hsa05213", 
                 "hsa05223",  "hsa00250")],
               ID2name = EntrezID2Name,
               gene.method = FALSE,
               perm.null.method = TRUE,
               perm.null.het.method = FALSE,
               pass.null.method = TRUE,
               pass.null.het.method = FALSE)


###################################################
### code chunk number 11: showGBMSetResults
###################################################
SetResultsGBM


###################################################
### code chunk number 12: simDataSets
###################################################
set.seed(831984)

resultsSim <- 
    cma.set.sim(cma.alter = GeneAlterGBM,
                cma.cov = GeneCovGBM,
                cma.samp = GeneSampGBM,
                GeneSets = KEGGPATHID2EXTID[c("hsa05213", 
                  "hsa05223", "hsa00250")],
                ID2name = EntrezID2Name,
                nr.iter = 2,
                pass.null = TRUE,
                perc.samples = c(75, 95),
                spiked.set.sizes = c(50),
                show.iter = TRUE,
                gene.method = FALSE,
                perm.null.method = TRUE,
                perm.null.het.method = FALSE,
                pass.null.method = TRUE,
                pass.null.het.method = FALSE)

resultsSim

slotNames(resultsSim)

resultsSim@null.dist


###################################################
### code chunk number 13: extractSimMethod
###################################################
extract.sims.method(resultsSim,
                    "p.values.perm.null")



###################################################
### code chunk number 14: combineSims
###################################################
combine.sims(resultsSim, resultsSim)


