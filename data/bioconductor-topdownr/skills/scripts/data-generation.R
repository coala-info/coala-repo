# Code example from 'data-generation' vignette. See references/ for full tutorial.

## ----environment, echo=FALSE, message=FALSE, warning=FALSE--------------------
library("topdownr")
library("BiocStyle")

## ----citation, echo=FALSE, results="asis"-------------------------------------
ct <- format(citation("topdownr"), "textVersion")
cat(gsub("DOI: *(.*)$", "DOI: [\\1](https://doi.org/\\1)", ct), "\n")

## ----writeMethodXml, eval=FALSE-----------------------------------------------
# library("topdownr")
# 
# ## Create MS1 settings
# ms1 <- expandMs1Conditions(
#     FirstMass=400,
#     LastMass=1200,
#     Microscans=as.integer(10)
# )
# 
# ## Set TargetMass
# targetMz <- cbind(mz=c(560.6, 700.5, 933.7), z=rep(1, 3))
# 
# ## Set common settings
# common <- list(
#     OrbitrapResolution="R120K",
#     IsolationWindow=1,
#     MaxITTimeInMS=200,
#     Microscans=as.integer(40),
#     AgcTarget=c(1e5, 5e5, 1e6)
# )
# 
# ## Create settings for different fragmentation conditions
# cid <- expandTms2Conditions(
#     MassList=targetMz,
#     common,
#     ActivationType="CID",
#     CIDCollisionEnergy=seq(7, 35, 7)
# )
# hcd <- expandTms2Conditions(
#     MassList=targetMz,
#     common,
#     ActivationType="HCD",
#     HCDCollisionEnergy=seq(7, 35, 7)
# )
# etd <- expandTms2Conditions(
#     MassList=targetMz,
#     common,
#     ActivationType="ETD",
#     ETDReactionTime=as.double(1:2)
# )
# etcid <- expandTms2Conditions(
#     MassList=targetMz,
#     common,
#     ActivationType="ETD",
#     ETDReactionTime=as.double(1:2),
#     ETDSupplementalActivation="ETciD",
#     ETDSupplementalActivationEnergy=as.double(1:2)
# )
# uvpd <- expandTms2Conditions(
#     MassList=targetMz,
#     common,
#     ActivationType="UVPD"
# )
# 
# ## Create experiments with all combinations of the above settings
# ## for fragment optimisation
# exps <- createExperimentsFragmentOptimisation(
#     ms1=ms1, cid, hcd, etd, etcid, uvpd,
#     groupBy=c("AgcTarget", "replication"), nMs2perMs1=10, scanDuration=0.5,
#     replications=2, randomise=TRUE
# )
# 
# ## Write experiments to xml files
# writeMethodXmls(exps=exps)
# 
# ## Run XMLMethodChanger
# runXmlMethodChanger(
#     modificationXml=list.files(pattern="^method.*\\.xml$"),
#     templateMeth="TMS2IndependentTemplateForTD.meth",
#     executable="path\\to\\XmlMethodChanger.exe"
# )

## ----ScanHeadsman, eval=FALSE-------------------------------------------------
# runScanHeadsman(
#     path="path\\to\\raw-files",
#     executable="path\\to\\ScanHeadsman.exe"
# )

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

