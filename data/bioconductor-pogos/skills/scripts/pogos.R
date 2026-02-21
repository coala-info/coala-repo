# Code example from 'pogos' vignette. See references/ for full tutorial.

## ----setup,echo=FALSE---------------------------------------------------------
suppressMessages({
suppressPackageStartupMessages({
library(pogos)
library(S4Vectors)
library(DT)
library(ggplot2)
})
})

## ----lkcc---------------------------------------------------------------------
iric = iriCCLE()
iric 

## ----lkdrp--------------------------------------------------------------------
drp = try(DRProfSet())
if (!inherits(drp, "try-error"))
 drp

## ----lkpl090, fig.height=2.5--------------------------------------------------
plot(iric)

## ----lklll,fig.height=3.5-----------------------------------------------------
if (!inherits(drp, "try-error"))
  plot(drp)

## ----lkk, echo=FALSE----------------------------------------------------------
data(cell_lines_v1)
datatable(as.data.frame(cell_lines_v1), options=list(lengthMenu=c(3,5,10,50,100)))

## ----lkccc, echo=FALSE--------------------------------------------------------
data(compounds_v1)
datatable(as.data.frame(compounds_v1), 
   options=list(lengthMenu=c(3,5,10,50,100)))

## ----lkccc2, echo=FALSE-------------------------------------------------------
data(datasets_v1)
datatable(as.data.frame(datasets_v1))

## ----doch,fig=TRUE------------------------------------------------------------
library(ontoProc)
cc = getOnto("chebi_full")
library(ontologyPlot)
onto_plot(cc, 
  c("CHEBI:134109", "CHEBI:61115", "CHEBI:75603", "CHEBI:37699", 
       "CHEBI:68481", "CHEBI:71178"), fontsize=24, shape="rect")

## ----lkmo, fig=TRUE-----------------------------------------------------------
onto_plot(cc, c("CHEBI:134109", "CHEBI:61115", "CHEBI:75603", "CHEBI:37699", 
   "CHEBI:68481", "CHEBI:71178", "CHEBI:52172", "CHEBI:64310", 
   "CHEBI:63632", "CHEBI:45863"), fontsize=28, shape="rect")

## ----ana,fig=TRUE-------------------------------------------------------------
clo = getOnto("cellLineOnto", year_added="2022")
smoc = c("CLO:0000517", "CLO:0000560", "CLO:0000563", "CLO:0001072", 
"CLO:0001088", "CLO:0001138", "CLO:0007606")
onto_plot(clo, smoc)

## ----lkoo---------------------------------------------------------------------
library(ontoProc)
clo = getOnto("cellLineOnto", year_added="2022")
minds = which(clo$name %in% c("143B cell", "1321N1 cell", "184B5 cell"))
tags = clo$id[minds]
clo$name[ unlist(clo$parent[tags]) ]

## ----lkefo, fig=TRUE----------------------------------------------------------
ee = getOnto("efoOnto")
onto_plot(ee, c("UBERON:0000474", "UBERON:0000079", 
  "UBERON:0000990", "UBERON:0000995", "UBERON:0003982", 
  "UBERON:0000310", "UBERON:0002107", "UBERON:0001264", 
  "UBERON:0002113", "UBERON:0001007", "UBERON:0002530", 
  "UBERON:6007435", "UBERON:0004122", "UBERON:0001008"))

## ----lkcom--------------------------------------------------------------------
chl = getOnto("chebi_full")
allch = chl$name
mm = allch[match(tolower(compounds_v1[,2]), tolower(allch), nomatch=0)]
round(length(mm)/nrow(compounds_v1),2) # not high
datatable(data.frame(id=names(mm), comp=as.character(mm)))

## ----srchsym, eval=FALSE------------------------------------------------------
# notin = setdiff(compounds_v1$name, mm)
# library(parallel)
# options(mc.cores=2)
# allch = tolower(allch)
# notin = tolower(notin)
# lk50 = mclapply(notin[1:50], function(x) { cat(x);
#        order(adist(x, allch))[1:5]})
# names(lk50) = notin[1:50]
# aa = do.call(cbind, lk50[1:50])
# ttt = t(apply(aa,2,function(x) allch[x])[1:3,])

## ----lkcomb,cache=TRUE--------------------------------------------------------
library(rjson)
library(httr)
xx = GET("https://pharmacodb.pmgenomics.ca/api/v1/intersections/2/895/1?indent=true")
if (as.numeric(xx$status_code) == 200) {
 ans = fromJSON(readBin(xx$content, what="character"))
 doses1 = sapply(ans[[1]]$dose_responses, function(x) x[[1]])
 resp1 =  sapply(ans[[1]]$dose_responses, function(x) x[[2]])
 }

## ----lkbar, fig=TRUE----------------------------------------------------------
library(ggplot2)
drt = try(DRTraceSet(dataset="CCLE"))
if (!inherits(drt, "try-error")) plot(drt)

