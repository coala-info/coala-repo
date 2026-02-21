# Code example from 'GSEABenchmarkeR' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE--------------------------------------------------------
suppressPackageStartupMessages({ 
    library(GSEABenchmarkeR)
    library(EnrichmentBrowser)
})

## ----lib----------------------------------------------------------------------
library(GSEABenchmarkeR)

## ----maComp-------------------------------------------------------------------
geo2kegg <- loadEData("geo2kegg")
names(geo2kegg)

## ----getDatasetProbe----------------------------------------------------------
geo2kegg[[1]]

## ----maPreproc----------------------------------------------------------------
geo2kegg <- maPreproc(geo2kegg[1:5])

## ----getDatasetGene-----------------------------------------------------------
geo2kegg[[1]]

## ----maGroups-----------------------------------------------------------------
se <- geo2kegg[[1]]
table(se$GROUP)

## ----rseqComp-----------------------------------------------------------------
tcga <- loadEData("tcga", nr.datasets=2)
names(tcga)

## ----brca---------------------------------------------------------------------
brca <- tcga[[2]]
brca
table(brca$GROUP)

## ----userComp-----------------------------------------------------------------
data.dir <- system.file("extdata", package="GSEABenchmarkeR")
edat.dir <- file.path(data.dir, "myEData")
edat <- loadEData(edat.dir)
names(edat)
edat[[1]]

## ----deAna--------------------------------------------------------------------
geo2kegg <- runDE(geo2kegg, de.method="limma", padj.method="flexible")
rowData(geo2kegg[[1]], use.names=TRUE)

## ----getGS--------------------------------------------------------------------
library(EnrichmentBrowser)
kegg.gs <- getGenesets(org="hsa", db="kegg")

## ----runEA--------------------------------------------------------------------
kegg.ora.res <- runEA(geo2kegg[[1]], method="ora", gs=kegg.gs, perm=0)
kegg.ora.res

## ----eaAll--------------------------------------------------------------------
res.dir <- tempdir()
res <- runEA(geo2kegg, methods=c("ora", "camera"), 
                gs=kegg.gs, perm=0, save2file=TRUE, out.dir=res.dir)
res$ora[1:2]

## -----------------------------------------------------------------------------
method <- function(se, gs)
{
	ps <- runif(length(gs))
	names(ps) <- names(gs)
	return(ps)
}

## -----------------------------------------------------------------------------
res <- runEA(geo2kegg[1:2], method, kegg.gs)
res

## ----readRT-------------------------------------------------------------------
ea.rtimes <- readResults(res.dir, names(geo2kegg), 
                            methods=c("ora", "camera"), type="runtime")
ea.rtimes

## ----plotRuntime, fig.width=6, fig.height=6-----------------------------------
bpPlot(ea.rtimes, what="runtime")

## ----runtimeORAvsCAMERA, fig.width=6, fig.height=6----------------------------
mean(ea.rtimes$ora) / mean(ea.rtimes$camera)

## ----readRankings-------------------------------------------------------------
ea.ranks <- readResults(res.dir, names(geo2kegg), 
                            methods=c("ora", "camera"), type="ranking")
lengths(ea.ranks)
ea.ranks$ora[1:2]

## ----plotAdjSigSets, fig.width=6, fig.height=6--------------------------------
sig.sets <- evalNrSigSets(ea.ranks, alpha=0.05, padj="BH")
sig.sets
bpPlot(sig.sets, what="sig.sets")

## ----malaRankings-------------------------------------------------------------
mala.kegg.file <- file.path(data.dir, "malacards", "KEGG.rds")
mala.kegg <- readRDS(mala.kegg.file)
sapply(mala.kegg, nrow)
mala.kegg$ALZ
mala.kegg$BRCA

## ----data2dis-----------------------------------------------------------------
d2d.file <- file.path(data.dir, "malacards", "GseId2Disease.txt")
d2d.map <- readDataId2diseaseCodeMap(d2d.file)
head(d2d.map)

## ----evalRelevance------------------------------------------------------------
ea.ranks$ora$GSE1297
obs.score <- evalRelevance(ea.ranks$ora$GSE1297, mala.kegg$ALZ)
obs.score

## ----compRand-----------------------------------------------------------------
gs.names <- ea.ranks$ora$GSE1297$GENE.SET
gs.ids <- substring(gs.names, 1, 8)
rand.scores <- compRand(mala.kegg$ALZ, gs.ids, perm=50)
summary(rand.scores)
(sum(rand.scores >= obs.score) + 1) / 51

## ----compOpt------------------------------------------------------------------
opt.score <- compOpt(mala.kegg$ALZ, gs.ids)
opt.score
round(obs.score / opt.score * 100, digits=2)

## ----evalAll, fig.width=6, fig.height=6---------------------------------------
all.kegg.res <- evalRelevance(ea.ranks, mala.kegg, d2d.map[names(geo2kegg)])
bpPlot(all.kegg.res, what="rel.sets")

## -----------------------------------------------------------------------------
rel.ranks <- mala.kegg$ALZ[,1:2]
rel.ranks$REL.SCORE <- runif(nrow(rel.ranks), min=1, max=100)
rel.ranks$REL.SCORE <- round(rel.ranks$REL.SCORE, digits = 2)
ind <- order(rel.ranks$REL.SCORE, decreasing = TRUE)
rel.ranks <- rel.ranks[ind,]
rel.ranks

## -----------------------------------------------------------------------------
evalRelevance(ea.ranks$ora$GSE1297, rel.ranks)

## ----cacheRes-----------------------------------------------------------------
cacheResource(geo2kegg, rname="geo2kegg")

## ----getRes-------------------------------------------------------------------
geo2kegg <- loadEData("geo2kegg", cache=TRUE)
names(geo2kegg)

## ----clearCache, eval=FALSE---------------------------------------------------
# cache.dir <- rappdirs::user_cache_dir("GSEABenchmarkeR")
# bfc <- BiocFileCache::BiocFileCache(cache.dir)
# BiocFileCache::removebfc(bfc)

## ----bpRegister---------------------------------------------------------------
BiocParallel::registered()

## ----bpParam------------------------------------------------------------------
bp.par <- BiocParallel::registered()[[1]]
BiocParallel::bpprogressbar(bp.par) <- TRUE

## ----runDEBP------------------------------------------------------------------
geo2kegg <- runDE(geo2kegg, parallel=bp.par)

