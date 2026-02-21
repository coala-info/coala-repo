# Code example from 'BasicChecks' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

cache.dir <- tools::R_user_dir("BioPlex", which = "cache")
bfc <- BiocFileCache::BiocFileCache(cache.dir)
for(b in BiocFileCache::bfcinfo(bfc)$rid) BiocFileCache::bfcremove(bfc, b)

## ---- message = FALSE---------------------------------------------------------
library(BioPlex)
library(AnnotationDbi)
library(AnnotationHub)
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

## ----corumCore----------------------------------------------------------------
core <- getCorum(set = "core", organism = "Human")

## ----corum2glist--------------------------------------------------------------
core.glist <- corum2graphlist(core, subunit.id.type = "UNIPROT")

## ----corum-subunit------------------------------------------------------------
has.cdk2 <- hasSubunit(core.glist, 
                       subunit = "CDK2",
                       id.type = "SYMBOL")

## ----corum-subunit2-----------------------------------------------------------
table(has.cdk2)
cdk2.glist <- core.glist[has.cdk2]
lapply(cdk2.glist, function(g) unlist(graph::nodeData(g, attr = "SYMBOL")))

## ----corum-subunit3, message = FALSE, eval = FALSE----------------------------
#  plot(cdk2.glist[[1]], main = names(cdk2.glist)[1])

## ----bioplex293T--------------------------------------------------------------
bp.293t <- getBioPlex(cell.line = "293T", version = "3.0")

## ----bpgraph------------------------------------------------------------------
bp.gr <- bioplex2graph(bp.293t)

## -----------------------------------------------------------------------------
n <- graph::nodes(cdk2.glist[[1]])
bp.sgr <- graph::subGraph(n, bp.gr)
bp.sgr

## -----------------------------------------------------------------------------
bp.gr <- BioPlex::annotatePFAM(bp.gr, orgdb)

## -----------------------------------------------------------------------------
unip2pfam <- graph::nodeData(bp.gr, graph::nodes(bp.gr), "PFAM")
pfam2unip <- stack(unip2pfam)
pfam2unip <- split(as.character(pfam2unip$ind), pfam2unip$values)
head(pfam2unip, 2)

## -----------------------------------------------------------------------------
scan.unip <- pfam2unip[["PF02023"]]
getIAPfams <- function(n) graph::nodeData(bp.gr, graph::edges(bp.gr)[[n]], "PFAM")
unip2iapfams <- lapply(scan.unip, getIAPfams)
unip2iapfams <- lapply(unip2iapfams, unlist)
names(unip2iapfams) <- scan.unip

## -----------------------------------------------------------------------------
pfam2iapfams <- unlist(unip2iapfams)
sort(table(pfam2iapfams), decreasing = TRUE)[1:5]

## ----gse122425----------------------------------------------------------------
se <- getGSE122425()
se

## ----prey-expression----------------------------------------------------------
bait <- unique(bp.293t$SymbolA)
length(bait)
prey <- unique(bp.293t$SymbolB)
length(prey)

## -----------------------------------------------------------------------------
ind <- match(prey, rowData(se)$SYMBOL)
par(las = 2)
boxplot(log2(assay(se, "rpkm") + 0.5)[ind,], 
        names = se$title, 
        ylab = "log2 RPKM")

## ----prey-expression2---------------------------------------------------------
# background: how many genes in total are expressed in all three WT reps
gr0 <- rowSums(assay(se)[,1:3] > 0)
table(gr0 == 3)
# prey: expressed in all three WT reps
table(gr0[ind] == 3)
# prey: expressed in at least one WT rep
table(gr0[ind] > 0)

## ----prey-expression-ora------------------------------------------------------
exprTable <-
     matrix(c(9346, 1076, 14717, 32766),
            nrow = 2,
            dimnames = list(c("Expressed", "Not.expressed"),
                            c("In.prey.set", "Not.in.prey.set")))
exprTable

## ----prey-expression-ora2-----------------------------------------------------
fisher.test(exprTable, alternative = "greater")

## ----prey-expression-293T-perm------------------------------------------------
permgr0 <- function(gr0, nr.genes = length(prey)) 
{
    ind <- sample(seq_along(gr0), nr.genes)
    sum(gr0[ind] == 3)
}

## ----prey-expression-perm2----------------------------------------------------
perms <- replicate(permgr0(gr0), 1000)
summary(perms)
(sum(perms >= 9346) + 1) / 1001

## ----prey-freq----------------------------------------------------------------
prey.freq <- sort(table(bp.293t$SymbolB), decreasing = TRUE)
preys <- names(prey.freq)
prey.freq <- as.vector(prey.freq)
names(prey.freq) <- preys
head(prey.freq)
summary(prey.freq)
hist(prey.freq, breaks = 50, main = "", xlab = "Number of PPIs", ylab = "Number of genes")

## -----------------------------------------------------------------------------
ind <- match(names(prey.freq), rowData(se)$SYMBOL)
rmeans <- rowMeans(assay(se, "rpkm")[ind, 1:3])
log.rmeans <- log2(rmeans + 0.5)
par(pch = 20)
plot( x = prey.freq,
      y = log.rmeans,
      xlab = "prey frequency",
      ylab = "log2 RPKM")
cor(prey.freq, 
    log.rmeans,
    use = "pairwise.complete.obs")

## ----bp.prot------------------------------------------------------------------
bp.prot <- getBioplexProteome()
bp.prot
rowData(bp.prot)

## -----------------------------------------------------------------------------
rowSums(assay(bp.prot)[1:5,]) 

## -----------------------------------------------------------------------------
ratio <- rowMeans(assay(bp.prot)[1:5, 1:5]) / rowMeans(assay(bp.prot)[1:5, 6:10])
log2(ratio)

## -----------------------------------------------------------------------------
t.test(assay(bp.prot)[1, 1:5], assay(bp.prot)[1, 6:10])

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

