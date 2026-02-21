# Code example from 'LowMACAAnnotation' vignette. See references/ for full tutorial.

## ----firstchunk, echo=TRUE , eval=TRUE , message=FALSE , warning=FALSE----
library(LowMACAAnnotation)
myUni <- getMyUni()
str(myUni , nchar.max=10 , vec.len=2)

## ----secondchunk, echo=TRUE , eval=TRUE , message=FALSE , warning=FALSE----
myPfam <- getMyPfam()
str(myPfam , nchar.max=10 , vec.len=2)

## ----thirdchunk, echo=TRUE , eval=TRUE , message=FALSE , warning=FALSE----
myAlias <- getMyAlias()
str(myAlias , nchar.max=10 , vec.len=2)

## ----info,echo=TRUE------------------------------------------------------
sessionInfo()

