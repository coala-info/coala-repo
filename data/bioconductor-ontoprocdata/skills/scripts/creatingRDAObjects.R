# Code example from 'creatingRDAObjects' vignette. See references/ for full tutorial.

## ---- eval=FALSE--------------------------------------------------------------
#  robot reason --input [filename].owl convert --check false --output [filename].obo

## ---- eval=FALSE--------------------------------------------------------------
#  directory = [directoryOfOboFiles]
#  rdaDirectory = [directoryForRDAFiles]
#  datafileName = [fileName].obo
#  rdaName = [rdaName].rda
#  datafile = paste0(directory,datafileName)
#  savefile = paste0(rdaDirectory, rdaName)
#  [rdaName] = get_OBO(datafile,  extract_tags = "everything")
#  
#  save([rdaName], file = savefile, compress = "xz")

## -----------------------------------------------------------------------------
sessionInfo()

