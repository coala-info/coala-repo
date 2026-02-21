# Code example from 'BiocGRASP2' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'-------------------------------
BiocStyle::markdown()

## ----eval=FALSE----------------------------------------------------------
#  P = iconv(Phenotype, "CP1250", "UTF-8")
#  p = tolower(P)
#  Phenotype = P[match(p, p)]

## ----eval=FALSE----------------------------------------------------------
#  library(grasp2db)
#  GRASP2()           # dbplyr representation

## ----eval=FALSE----------------------------------------------------------
#  library(AnnotationHub)
#  db <- AnnotationHub()[["AH21414"]]

