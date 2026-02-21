# Code example from 'ontoProcData' vignette. See references/ for full tutorial.

## ----get-data-----------------------------------------------------------------
library(AnnotationHub)
ahub = AnnotationHub()
mymeta <- query(ahub , "ontoProcData")
mymeta
tag = names(mymeta)[1] 
tag

## -----------------------------------------------------------------------------
sessionInfo()


