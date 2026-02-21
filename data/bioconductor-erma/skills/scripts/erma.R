# Code example from 'erma' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'---------------------------------
BiocStyle::markdown()

## ----dosetup,echo=FALSE,results="hide"-------------------------------------
suppressPackageStartupMessages({
library(rtracklayer)
library(BiocStyle)
library(erma)
library(GenomicFiles)
library(ggplot2)
library(grid)
library(png)
library(DT)
})

## ----lkm-------------------------------------------------------------------
library(DT)
library(erma)
meta = mapmeta()
kpc = c("Comments", "Epigenome.ID..EID.", "Epigenome.Mnemonic", "Quality.Rating", 
"Standardized.Epigenome.name", "ANATOMY", "TYPE")
datatable(as.data.frame(meta[,kpc]))

## ----lkst------------------------------------------------------------------
data(states_25)
datatable(states_25)

## ----dofig,fig=TRUE--------------------------------------------------------
library(png)
im = readPNG(system.file("pngs/emparms.png", package="erma"))
grid.raster(im)

## ----getgf-----------------------------------------------------------------
ermaset = makeErmaSet()
ermaset
cellTypes(ermaset)[1:5]
datatable(as.data.frame(colData(ermaset)[,kpc]))

## ----getgm, cache=FALSE----------------------------------------------------
uil33 = flank(resize(range(genemodel("IL33")), 1), width=50000)
uil33

## ----bind------------------------------------------------------------------
rowRanges(ermaset) = uil33  
ermaset

## ----getcss----------------------------------------------------------------
library(BiocParallel)
register(MulticoreParam(workers=2))
suppressWarnings({
csstates = lapply(reduceByFile(ermaset, MAP=function(range, file) {
  imp = import(file, which=range, genome=genome(range)[1])
  seqlevels(imp) = seqlevels(range)
  imp$rgb = erma:::rgbByState(imp$name)
  imp
}), "[[", 1) 
})
tys = cellTypes(ermaset)  # need to label with cell types
csstates = lapply(1:length(csstates), function(x) {
   csstates[[x]]$celltype = tys[x]
   csstates[[x]]
   })
csstates[1:2]

## ----doviz, fig=TRUE-------------------------------------------------------
csProfile(ermaset[,1:5], symbol="CD28", useShiny=FALSE)

