# Code example from 'RMassBankNonstandard' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------
options(width=74)

## ----echo=FALSE---------------------------------------------------------
library("RMassBank")
library("RMassBankData")
library("gplots")

## ----eval=FALSE---------------------------------------------------------
# vignette("RMassBank")

## -----------------------------------------------------------------------
RmbDefaultSettings()
rmbo <- getOption("RMassBank")
rmbo$recalibrator <- list(
		"MS1" = "recalibrate.identity",
		"MS2" = "recalibrate.identity"
	)
options("RMassBank" = rmbo)

## -----------------------------------------------------------------------
w <- loadMsmsWorkspace(system.file("results/pH_narcotics_RF.RData", 
				package="RMassBankData"))

## ----fig=TRUE-----------------------------------------------------------
recal <- makeRecalibration(w@parent,
				recalibrateBy = rmbo$recalibrateBy,
				recalibrateMS1 = rmbo$recalibrateMS1,
				recalibrator = list(MS1="recalibrate.loess",MS2="recalibrate.loess"),
				recalibrateMS1Window = 15)
w@rc <- recal$rc
w@rc.ms1 <- recal$rc.ms1
w@parent <- w
plotRecalibration(w)

## -----------------------------------------------------------------------
w@spectra[[1]]@parent@mz[30:32]
w@spectra[[1]]@children[[1]]@mz[15:17]

## ----fig=TRUE-----------------------------------------------------------
w <- msmsWorkflow(w, steps=4)

## -----------------------------------------------------------------------
w@spectra[[1]]@parent@mz[30:32]
w@spectra[[1]]@children[[1]]@mz[15:17]

## -----------------------------------------------------------------------
RmbDefaultSettings()
getOption("RMassBank")$multiplicityFilter

# to make processing faster, we only use 3 spectra per compound
rmbo <- getOption("RMassBank")
rmbo$spectraList <- list(
    list(mode="CID", ces = "35%", ce = "35 % (nominal)", res = 7500),
    list(mode="HCD", ces = "15%", ce = "15 % (nominal)", res = 7500),
    list(mode="HCD", ces = "30%", ce = "30 % (nominal)", res = 7500)
)
options(RMassBank = rmbo)

loadList(system.file("list/NarcoticsDataset.csv", 
        package="RMassBankData"))


w <- newMsmsWorkspace()
files <- list.files(system.file("spectra", package="RMassBankData"),
        ".mzML", full.names = TRUE)
w@files <- files[1:2]

## -----------------------------------------------------------------------
w1 <- msmsWorkflow(w, mode="pH", steps=c(1))
# Here we artificially cut spectra out to make the workflow run faster for the vignette:
w1@spectra <- as(lapply(w1@spectra, function(s)
    {
		s@children <- s@children[1:3]
		s
    }),"SimpleList")
w1 <- msmsWorkflow(w1, mode="pH", steps=c(2:7))

## -----------------------------------------------------------------------
w2 <- msmsWorkflow(w, mode="pH", steps=c(1), confirmMode = 1)
# Here we artificially cut spectra out to make the workflow run faster for the vignette:

w2@spectra <- as(lapply(w2@spectra, function(s)
    {
		s@children <- s@children[1:3]
		s
    }),"SimpleList")
w2 <- msmsWorkflow(w2, mode="pH", steps=c(2:7))

## -----------------------------------------------------------------------
wTotal <- combineMultiplicities(c(w1, w2))
wTotal <- msmsWorkflow(wTotal, steps=8, mode="pH", archivename = "output")

## -----------------------------------------------------------------------
mb <- newMbWorkspace(wTotal)
# [...] load lists, execute workflow etc.

## -----------------------------------------------------------------------
sessionInfo()

