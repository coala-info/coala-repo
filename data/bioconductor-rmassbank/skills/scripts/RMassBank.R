# Code example from 'RMassBank' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------
options(width=74)

## -----------------------------------------------------------------------
library(RMassBank)

## -----------------------------------------------------------------------
library(RMassBankData)

## ----eval=TRUE----------------------------------------------------------
file.copy(system.file("list/NarcoticsDataset.csv", 
	package="RMassBankData"), "./Compoundlist.csv")

## ----eval=TRUE----------------------------------------------------------
RmbSettingsTemplate("mysettings.ini")

## ----echo=TRUE,eval=TRUE------------------------------------------------
loadRmbSettings("mysettings.ini")

## -----------------------------------------------------------------------
w <- newMsmsWorkspace()

## -----------------------------------------------------------------------
files <- list.files(system.file("spectra", package="RMassBankData"),
	 ".mzML", full.names = TRUE)
basename(files)
# To make the workflow faster here, we use only 2 compounds:
w@files <- files[1:2]

## -----------------------------------------------------------------------
loadList("./Compoundlist.csv")

## ----eval=TRUE,fig=TRUE-------------------------------------------------
w <- msmsWorkflow(w, mode="pH", steps=c(1:4), archivename = 
				"pH_narcotics")

## ----eval=FALSE---------------------------------------------------------
# plotRecalibration(w)

## ----eval=FALSE---------------------------------------------------------
# 	w <- msmsWorkflow(w, mode="pH", steps=1)
# 	w <- msmsWorkflow(w, mode="pH", steps=2)
# 	w <- msmsWorkflow(w, mode="pH", steps=3)
# 	# etc.

## ----eval=FALSE---------------------------------------------------------
# lapply(w@spectra,function(s) s@found)

## ----eval=FALSE---------------------------------------------------------
# findProgress(w)

## ----eval=TRUE----------------------------------------------------------
# In the really evaluated workflow, we do the following:
# we run steps 1 through 3, load the recalibration curve from a stored workflow
# and recalibrate the data using that curve.
storedW <- loadMsmsWorkspace(system.file("results/pH_narcotics_RF.RData", 
				package="RMassBankData"))

## ----fig=TRUE-----------------------------------------------------------
# Just to display the recalibration curve as calculated from
# the complete dataset:
storedW <- msmsWorkflow(storedW, mode="pH", steps=4)
# Copy the recalibration to workspace w and apply it
# (no graph displayed here)
w@rc <- storedW@parent@rc
w@rc.ms1 <- storedW@parent@rc.ms1
w <- msmsWorkflow(w, mode="pH", steps=4, archivename = 
	"pH_narcotics", newRecalibration = FALSE)

## -----------------------------------------------------------------------
w <- msmsWorkflow(w, mode="pH", steps=c(5:8), archivename = 
		"pH_narcotics")

## ----eval=FALSE---------------------------------------------------------
# archiveResults(w, filename)

## -----------------------------------------------------------------------
mb <- newMbWorkspace(w)
mb <- resetInfolists(mb)
mb <- loadInfolists(mb, system.file("infolists_incomplete",
		package="RMassBankData"))

## ----eval=FALSE---------------------------------------------------------
# mb <- resetInfolists(mb)
# mb <- loadInfolists(mb, my_folder_with_csv_infolists_inside)

## ----eval=FALSE---------------------------------------------------------
# mb <- addPeaks(mb, my_corrected_Failpeaks.csv)

## ----echo=TRUE,eval=TRUE------------------------------------------------
mb <- mbWorkflow(mb, infolist_path="./Narcotics_infolist.csv")

## ----eval=FALSE---------------------------------------------------------
# mb <- resetInfolists(mb)
# mb <- loadInfolists(mb, my_folder_with_csv_infolists_inside)

## -----------------------------------------------------------------------
mb <- resetInfolists(mb)
mb <- loadInfolists(mb, system.file("infolists", package="RMassBankData"))

## ----eval=TRUE,echo=TRUE------------------------------------------------
mb <- mbWorkflow(mb)

## -----------------------------------------------------------------------
sessionInfo()

