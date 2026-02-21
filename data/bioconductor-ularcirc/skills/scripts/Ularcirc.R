# Code example from 'Ularcirc' vignette. See references/ for full tutorial.

## ----setup,echo=FALSE---------------------------------------------------------
library(knitr)
library(BiocStyle)

## ----HG38AvailableDatabases, out.width='65%', fig.cap = 'Screenshot of Ularcirc available annotations',echo=FALSE----
knitr::include_graphics('HG38_Availale_Databases.PNG')

## ----AnnotatingTwoSzabo, out.width='100%', fig.cap = 'Screenshot of Ularcirc Gene view tab.',echo=FALSE----
knitr::include_graphics('AnnotatingTwoSzabo.PNG')

## ----SLC8a1TwoSzabo, out.width='100%', fig.cap = 'Screenshot of Slc8a1 back splice  and canonical splice junctions.',echo=FALSE----
knitr::include_graphics('SLC8a1_TwoSzabo.PNG')

## ----HG38Slc8a1_BSJ, out.width='65%', fig.cap = 'Ularcirc Junction view tab showing a backsplice junction for Slc8a1. Note that the . character defines splice junction',echo=FALSE----
knitr::include_graphics('BackspliceJunctionDetails.PNG')

## ----HG38Slc8a1_ORF, out.width='65%', fig.cap = 'Ularcirc Junction view tab showing the potential ORF within Slc8a1',echo=FALSE----
knitr::include_graphics('BackspliceJunctionORF.PNG')

## ----HG38Slc8a1_miRNA, out.width='65%', fig.cap = 'Ularcirc Junction view tab showing potential miRNA binding sites that reside within Slc8a1',echo=FALSE----
knitr::include_graphics('BackspliceJunction_miRNA.PNG')

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

