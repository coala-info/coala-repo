# Code example from 'hpAnnot-vignette' vignette. See references/ for full tutorial.

## ----fig.show='hold', message=FALSE, warning=FALSE----------------------------
library(AnnotationHub)
ah <- AnnotationHub()
hp <- query(ah, "hpAnnot")
hp
mcols(hp)[,c("title", "description")]
xtabs(~dataprovider + species, mcols(hp))
head(hp[["AH60887"]])
hp$title

