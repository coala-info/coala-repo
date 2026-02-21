# Code example from 'BioPlex' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ---- eval = FALSE------------------------------------------------------------
#  if(!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("BioPlex")

## ---- message = FALSE---------------------------------------------------------
library(BioPlex)
library(AnnotationHub)
library(ExperimentHub)
library(graph)

## ----ahub, message = FALSE----------------------------------------------------
ah <- AnnotationHub::AnnotationHub()

## ----ehub, message = FALSE----------------------------------------------------
eh <- ExperimentHub::ExperimentHub()

## ----orgdb, message = FALSE---------------------------------------------------
orgdb <- AnnotationHub::query(ah, c("orgDb", "Homo sapiens"))
orgdb <- orgdb[[1]]
orgdb
keytypes(orgdb)

## ----bioplex293T--------------------------------------------------------------
bp.293t <- getBioPlex(cell.line = "293T", version = "3.0")
head(bp.293t)
nrow(bp.293t)

## ----bioplexHCT116------------------------------------------------------------
bp.hct116 <- getBioPlex(cell.line = "HCT116", version = "1.0")
head(bp.hct116)
nrow(bp.hct116)

## ----bioplex-remap------------------------------------------------------------
bp.293t.remapped <- getBioPlex(cell.line = "293T",
                               version = "3.0",
                               remap.uniprot.ids = TRUE)

## ----bpgraph------------------------------------------------------------------
bp.gr <- bioplex2graph(bp.293t)
bp.gr
head(graph::nodeData(bp.gr))
head(graph::edgeData(bp.gr))

## ----pfam---------------------------------------------------------------------
bp.gr <- annotatePFAM(bp.gr, orgdb)
head(graph::nodeData(bp.gr, graph::nodes(bp.gr), "PFAM"))

## ----corumALL-----------------------------------------------------------------
all <- getCorum(set = "all", organism = "Human")
dim(all)
colnames(all)
all[1:5, 1:5]

## ----corumCore----------------------------------------------------------------
core <- getCorum(set = "core", organism = "Human")
dim(core)

## ----corumSplice--------------------------------------------------------------
splice <- getCorum(set = "splice", organism = "Human")
dim(splice)

## ----corum-remap--------------------------------------------------------------
core.remapped <- getCorum(set = "core", 
                          organism = "Human",
                          remap.uniprot.ids = TRUE)

## ----corum2list---------------------------------------------------------------
core.list <- corum2list(core, subunit.id.type = "UNIPROT")
head(core.list)
length(core.list)

## ----corum2glist--------------------------------------------------------------
core.glist <- corum2graphlist(core, subunit.id.type = "UNIPROT")
head(core.glist)
length(core.glist)
core.glist[[1]]@graphData
graph::nodeData(core.glist[[1]])

## ----gse122425----------------------------------------------------------------
se <- getGSE122425()
se
head(assay(se, "raw"))
head(assay(se, "rpkm"))
colData(se)
rowData(se)

## ---- eval = FALSE------------------------------------------------------------
#  ccle.trans <- ExpressionAtlas::getAtlasExperiment("E-MTAB-2770")

## ---- eval = FALSE------------------------------------------------------------
#  klijn <- ExpressionAtlas::getAtlasExperiment("E-MTAB-2706")

## ----ccle-proteom-------------------------------------------------------------
AnnotationHub::query(eh, c("gygi", "depmap"))
ccle.prot <- eh[["EH3459"]]
ccle.prot <- as.data.frame(ccle.prot)

## ----ccle-proteom2------------------------------------------------------------
dim(ccle.prot)
colnames(ccle.prot)
head(ccle.prot)

## ----ccle-prot-hct116---------------------------------------------------------
ccle.prot.hct116 <- subset(ccle.prot, cell_line == "HCT116_LARGE_INTESTINE")
dim(ccle.prot.hct116)
head(ccle.prot.hct116)

## ----ccle-prot-se-------------------------------------------------------------
se <- ccleProteome2SummarizedExperiment(ccle.prot, cell.line = NULL)
assay(se)[1:5, 1:5]
assay(se)[1:5, "HCT116"]
rowData(se)

## ----bp.prot------------------------------------------------------------------
bp.prot <- getBioplexProteome()
assay(bp.prot)[1:5,1:5]
colData(bp.prot)
rowData(bp.prot)

## ----cache--------------------------------------------------------------------
cache.dir <- tools::R_user_dir("BioPlex", which = "cache") 
bfc <- BiocFileCache::BiocFileCache(cache.dir)

## ----rmCache, eval = FALSE----------------------------------------------------
#  BiocFileCache::removebfc(bfc)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

