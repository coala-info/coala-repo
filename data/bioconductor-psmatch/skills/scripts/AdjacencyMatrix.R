# Code example from 'AdjacencyMatrix' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message=FALSE---------------------
BiocStyle::markdown()

## ----setup, message = FALSE, echo = FALSE-------------------------------------
library("PSMatch")

## -----------------------------------------------------------------------------
library("PSMatch")
id <- msdata::ident(full.names = TRUE, pattern = "TMT") |>
PSM() |>
filterPsmDecoy() |>
filterPsmRank()
id

## -----------------------------------------------------------------------------
data.frame(id[1:10, c("sequence", "DatabaseAccess")])

## -----------------------------------------------------------------------------
adj <- makeAdjacencyMatrix(id)
dim(adj)
adj[1:5, 1:5]

## -----------------------------------------------------------------------------
length(unique(id$sequence))
length(unique(unlist(strsplit(id$DatabaseAccess, ";"))))

## -----------------------------------------------------------------------------
cc <- ConnectedComponents(adj)
length(cc)
cc

## -----------------------------------------------------------------------------
connectedComponents(cc, 1)

## -----------------------------------------------------------------------------
connectedComponents(cc, 527)

## -----------------------------------------------------------------------------
connectedComponents(cc, 38)

## -----------------------------------------------------------------------------
connectedComponents(cc, 920)

## -----------------------------------------------------------------------------
(i <- which(nrows(cc) > 2 & ncols(cc) > 2))
dims(cc)[i, ]

## -----------------------------------------------------------------------------
cx <- connectedComponents(cc, 1082)
cx

## -----------------------------------------------------------------------------
plotAdjacencyMatrix(cx)

## -----------------------------------------------------------------------------
plotAdjacencyMatrix(cx, 1)

## -----------------------------------------------------------------------------
plotAdjacencyMatrix(cx, 2)

## -----------------------------------------------------------------------------
score <- id$MS.GF.RawScore
names(score) <- id$sequence
head(score)

## -----------------------------------------------------------------------------
cls <- as.character(cut(score, 12,
                        labels = colorRampPalette(c("white", "red"))(12)))
names(cls) <- id$sequence
head(cls)

## -----------------------------------------------------------------------------
plotAdjacencyMatrix(cx, pepColors = cls)

## ----message = FALSE----------------------------------------------------------
basename(f <- msdata::quant(full.names = TRUE))
(i <- grep("Intensity\\.", names(read.delim(f))))
library(QFeatures)
se <- readSummarizedExperiment(f, quantCols = i, sep = "\t")

## -----------------------------------------------------------------------------
prots <- rowData(se)$Proteins
names(prots) <- rowData(se)$Sequence
head(prots)

## -----------------------------------------------------------------------------
adj <- makeAdjacencyMatrix(prots, split = ";")
dim(adj)
adj[1:3, 1:3]
cc <- ConnectedComponents(adj)
cc

## -----------------------------------------------------------------------------
head(cctab <- prioritiseConnectedComponents(cc))

## ----message = FALSE----------------------------------------------------------
library(factoextra)
fviz_pca(prcomp(cctab, scale = TRUE, center = TRUE))

## ----si-----------------------------------------------------------------------
sessionInfo()

