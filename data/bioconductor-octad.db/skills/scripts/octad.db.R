# Code example from 'octad.db' vignette. See references/ for full tutorial.

## ----eval=TRUE----------------------------------------------------------------
library(octad.db)
#select data
suppressMessages(library(octad.db))
phenoDF=get_ExperimentHub_data("EH7274") #load data.frame with samples included in the OCTAD database. 
head(phenoDF) #list all data included within the package

## ----eval=TRUE----------------------------------------------------------------
data("res_example",package='octad.db') #load example res from octad.db
data("sRGES_example",package='octad.db') #load example sRGES from octad.db

## ----eval=TRUE----------------------------------------------------------------
sessionInfo()

