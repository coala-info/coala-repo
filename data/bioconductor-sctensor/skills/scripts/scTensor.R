# Code example from 'scTensor' vignette. See references/ for full tutorial.

## ----AHub1, echo=TRUE---------------------------------------------------------
library("AnnotationHub")
ah <- AnnotationHub()
mcols(ah)

## ----AHub2, echo=TRUE---------------------------------------------------------
dbfile <- query(ah, c("LRBaseDb", "Homo sapiens"))[[1]]

## ----AHub3, echo=TRUE---------------------------------------------------------
library("LRBaseDbi")
LRBase.Hsa.eg.db <- LRBaseDbi::LRBaseDb(dbfile)

## ----Access, echo=TRUE--------------------------------------------------------
columns(LRBase.Hsa.eg.db)
keytypes(LRBase.Hsa.eg.db)
key_HSA <- keys(LRBase.Hsa.eg.db, keytype="GENEID_L")
head(select(LRBase.Hsa.eg.db, keys=key_HSA[1:2],
            columns=c("GENEID_L", "GENEID_R"), keytype="GENEID_L"))

## ----Other1, echo=TRUE--------------------------------------------------------
lrNomenclature(LRBase.Hsa.eg.db)
species(LRBase.Hsa.eg.db)
lrListDatabases(LRBase.Hsa.eg.db)
lrVersion(LRBase.Hsa.eg.db)

dbInfo(LRBase.Hsa.eg.db)
dbfile(LRBase.Hsa.eg.db)
dbschema(LRBase.Hsa.eg.db)
dbconn(LRBase.Hsa.eg.db)

## ----Other2, echo=TRUE--------------------------------------------------------
suppressPackageStartupMessages(library("RSQLite"))
dbGetQuery(dbconn(LRBase.Hsa.eg.db),
  "SELECT * FROM DATA WHERE GENEID_L = '9068' AND GENEID_R = '14' LIMIT 10")

## ----SCE1, echo=TRUE----------------------------------------------------------
suppressPackageStartupMessages(library("scTensor"))
suppressPackageStartupMessages(library("SingleCellExperiment"))

## ----SCE2, fig.cap="Germline, Male, GSE86146", echo=TRUE, fig.width=10, fig.height=10----
data(GermMale)
data(labelGermMale)
data(tsneGermMale)

sce <- SingleCellExperiment(assays=list(counts = GermMale))
reducedDims(sce) <- SimpleList(TSNE=tsneGermMale$Y)
plot(reducedDims(sce)[[1]], col=labelGermMale, pch=16, cex=2,
  xlab="Dim1", ylab="Dim2", main="Germline, Male, GSE86146")
legend("topleft", legend=c(paste0("FGC_", 1:3), paste0("Soma_", 1:4)),
  col=c("#9E0142", "#D53E4F", "#F46D43", "#ABDDA4", "#66C2A5", "#3288BD", "#5E4FA2"),
  pch=16)

## ----cellCellSetting, echo=TRUE-----------------------------------------------
cellCellSetting(sce, LRBase.Hsa.eg.db, names(labelGermMale))

## ----cellCellDecomp, echo=TRUE------------------------------------------------
set.seed(1234)
cellCellDecomp(sce, ranks=c(2,3))

## ----cellCellRank, echo=TRUE--------------------------------------------------
(rks <- cellCellRanks(sce))
rks$selected

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

