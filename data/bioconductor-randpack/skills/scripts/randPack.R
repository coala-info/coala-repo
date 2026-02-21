# Code example from 'randPack' vignette. See references/ for full tutorial.

### R code from vignette source 'randPack.Rnw'

###################################################
### code chunk number 1: docl
###################################################
library(randPack)
getClass("ClinicalTrial")
getClass("ClinicalExperiment")
getClass("PatientID")


###################################################
### code chunk number 2: doadmin
###################################################
 pIDs = new("PatientID",
            strata = c("Center1", "Center2"),
            start = c(1000L, 2000L),
            stop = c(1150L, 2150L)
 )
 validPID(pIDs)


###################################################
### code chunk number 3: doce
###################################################
 trts = c( A = 3L, B = 4L, C = 1L)
 CEvac = new("ClinicalExperiment",
    name="My first experiment",
    treatments = trts,
    factors = list( F1 = c("A", "B", "C"), F2 = c("t1", "t2")),
    strataFun = function(pDesc) pDesc@strata,
    #randomization = list(Center1= list(pbdesc), Center2=list(rd)),
    #randomization = list(Center1= list(pbdesc), Center2=list(pbdesc)),
    randomization = list(Center1= list(a=1), Center2=list(a=1)),
    patientIDs = pIDs
 )
  
 CEvac

 treatmentFactors(CEvac)
 factorNames(CEvac)
 randPack:::numberOfFactorLevels(CEvac)


###################################################
### code chunk number 4: doct (eval = FALSE)
###################################################
##  CTvac = createTrial(CEvac, seed=c(301, 401))


###################################################
### code chunk number 5: dora
###################################################
getClass("RandomizerDesc")
getClass("Randomizer")
getClass("PermutedBlockDesc")
getClass("PermutedBlock")


###################################################
### code chunk number 6: dode
###################################################
pbdesc = new("PermutedBlockDesc", treatments = trts, type="PermutedBlock",
     numBlocks=4L)


###################################################
### code chunk number 7: dohi
###################################################
  ##should be 24 (no, 32) long and have one C ever 8 allocs
table(dempb <- randPack:::.newPBlock(pbdesc))
bls = rep(1:4, each=8)
sapply(split(dempb,bls), function(x) sum(x=="C"))


###################################################
### code chunk number 8: dopure
###################################################
rd = new("RandomDesc", treatments = trts, type = "Random", numPatients = 32L)
mmpb = makeRandomizer("Expt1", pbdesc, seed = 101)
mmr = makeRandomizer("Expr1r", rd, seed=201)
demrd = randPack:::.newRandom(rd)
table(demrd)


###################################################
### code chunk number 9: dosi
###################################################
trts = c( A = 3L, B = 4L, C = 1L)


###################################################
### code chunk number 10: doce2
###################################################
 CE1 = new("ClinicalExperiment",
    name="My first experiment",
    treatments = trts,
    factors = list( F1 = c("A", "B", "C"), F2 = c("t1", "t2")),
    strataFun = function(pDesc) pDesc@strata,
    #randomization = list(Center1= list(pbdesc), Center2=list(rd)),
    randomization = list(Center1= list(pbdesc), Center2=list(pbdesc)),
    patientIDs = pIDs
 )
CE1


###################################################
### code chunk number 11: lkv
###################################################
 CT1 = createTrial(CE1, seed=c(301, 401))


###################################################
### code chunk number 12: mk4
###################################################
 pD1 = new("PatientData", name="Sally H", date=Sys.Date(),
 covariates=list(sex="F", age=33), strata="Center1")
 pD2 = new("PatientData", name="Sally Z", date=Sys.Date(),
 covariates=list(sex="F", age=34), strata="Center1")
 pD3 = new("PatientData", name="Tom Z", date=Sys.Date(),
 covariates=list(sex="M", age=44), strata="Center2")
 pD4 = new("PatientData", name="Jack Z", date=Sys.Date(),
 covariates=list(sex="M", age=54), strata="Center2")


###################################################
### code chunk number 13: gett
###################################################

 trt1 = getTreatment(CT1, pD1)
 trt2 = getTreatment(CT1, pD2)
 trt3 = getTreatment(CT1, pD3)
 trt4 = getTreatment(CT1, pD4)


###################################################
### code chunk number 14: gete
###################################################
getEnrolleeInfo(CT1)


###################################################
### code chunk number 15: keepo
###################################################
  ##since the strata are Center1 or Center2, we can just pull those
  ##out directly. If the strata were by, say sex and center then we
  ##would need to have some name mangling scheme.

  sFun = function(pDesc) pDesc@strata

## patientID class


##define an experiment with two strata

 ##now how to randomize patients



 CE1@strataFun(pD1)



###################################################
### code chunk number 16: useco
###################################################
trts = c( A = 1L, B= 1L)
bcdesc = new("EfronBiasedCoinDesc", treatments = trts, type="EfronBiasedCoin",
     numPatients=1000L, p=2/3)
CE1@randomization = list(Center1= list(bcdesc), Center2=list(bcdesc))
CT2 = createTrial(CE1, seed=c(301, 401))
btrt1 = getTreatment(CT2, pD1)
btrt2 = getTreatment(CT2, pD2)
btrt3 = getTreatment(CT2, pD3)
btrt4 = getTreatment(CT2, pD4)
c(btrt1, btrt2, btrt3, btrt4)


###################################################
### code chunk number 17: useur
###################################################
urndesc = new("UrnDesc", treatments = trts, type="Urn",
     numPatients=1000L, alpha=1, beta=3)
CE1@randomization = list(Center1= list(urndesc), Center2=list(urndesc))
CT3 = createTrial(CE1, seed=c(301, 401))
utrt1 = getTreatment(CT3, pD1)
utrt2 = getTreatment(CT3, pD2)
utrt3 = getTreatment(CT3, pD3)
utrt4 = getTreatment(CT3, pD4)
c(utrt1, utrt2, utrt3, utrt4)


###################################################
### code chunk number 18: zz
###################################################
md = new("MinimizationDesc", treatments=c(A=1L, B=1L), method=minimizePocSim,
   type="Minimization", featuresInUse="sex")


###################################################
### code chunk number 19: zzz
###################################################
randomization(CE1) = list(Center1=list(md), Center2 = list(md))


###################################################
### code chunk number 20: domm
###################################################
CT4 = createTrial(CE1, seed=c(301,401))
getTreatment(CT4, pD1)
getTreatment(CT4, pD2)
getTreatment(CT4, pD3)
getTreatment(CT4, pD4)


###################################################
### code chunk number 21: lkass
###################################################
sessionInfo()


