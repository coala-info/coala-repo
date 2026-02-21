# Code example from 'ldblock' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----lkd, cache=TRUE----------------------------------------------------------
suppressPackageStartupMessages({
 library(ldblock)
 library(GenomeInfoDb)
})
path = dir(system.file("hapmap", package="ldblock"), full=TRUE)
ceu17 = hmld(path, poptag="CEU", chrom="chr17")
ceu17

## ----abc, fig=TRUE, fig.width=7, fig.height=7---------------------------------
library(Matrix)
image(ceu17@ldmat[1:400,1:400], 
   col.reg=heat.colors(120), colorkey=TRUE, useRaster=TRUE)

## ----getg---------------------------------------------------------------------
library(gwascat)
load(system.file("legacy/ebicat37.rda", package="gwascat"))
#seqlevelsStyle(ebicat37) = "NCBI"  # noop?
seqlevels(ebicat37) = gsub("chr", "", seqlevels(ebicat37))
e17 = ebicat37[ which(as.character(seqnames(ebicat37)) == "17") ]

## ----getrs--------------------------------------------------------------------
rsh17 = unique(e17$SNPS)
head(rsh17)

## ----doexpa-------------------------------------------------------------------
length(rsh17)
exset = ldblock::expandSnpSet( rsh17, ldstruct= ceu17, lb=.9 )
length(exset)
all(rsh17 %in% exset)

