# Code example from 'gwascatData' vignette. See references/ for full tutorial.

## ----get-data-----------------------------------------------------------------
library(AnnotationHub)
ahub = AnnotationHub()
mymeta <- query(ahub , "gwascatData")
mymeta
tag = names(mymeta)[1] 
tag
head(ahub[[tag]][,1:6])

