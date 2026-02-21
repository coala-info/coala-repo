# Code example from 'scTGIF' vignette. See references/ for full tutorial.

## ----testdata, echo=TRUE, message=FALSE---------------------------------------
library("scTGIF")
library("SingleCellExperiment")
library("GSEABase")
library("msigdbr")

data("DistalLungEpithelium")
data("pca.DistalLungEpithelium")
data("label.DistalLungEpithelium")

## ----testdata2, echo=TRUE, fig.width=7, fig.height=7--------------------------
par(ask=FALSE)
plot(pca.DistalLungEpithelium, col=label.DistalLungEpithelium, pch=16,
    main="Distal lung epithelium dataset", xlab="PCA1", ylab="PCA2", bty="n")
text(0.1, 0.05, "AT1", col="#FF7F00", cex=2)
text(0.07, -0.15, "AT2", col="#E41A1C", cex=2)
text(0.13, -0.04, "BP", col="#A65628", cex=2)
text(0.125, -0.15, "Clara", col="#377EB8", cex=2)
text(0.09, -0.2, "Cilliated", col="#4DAF4A", cex=2)

## ----gmt, echo=TRUE-----------------------------------------------------------
m_df = msigdbr(species = "Mus musculus",
    category = "H")[, c("gs_name", "entrez_gene")]

hallmark = unique(m_df$gs_name)
gsc <- lapply(hallmark, function(h){
    target = which(m_df$gs_name == h)
    geneIds = unique(as.character(m_df$entrez_gene[target]))
    GeneSet(setName=h, geneIds)
})
gmt = GeneSetCollection(gsc)
gmt = gmt[1:10] # Reduced for this demo

## ----setting, echo=TRUE-------------------------------------------------------
sce <- SingleCellExperiment(assays = list(counts = DistalLungEpithelium))
reducedDims(sce) <- SimpleList(PCA=pca.DistalLungEpithelium)

## ----setting2, echo=TRUE------------------------------------------------------
CPMED <- function(input){
    libsize <- colSums(input)
    median(libsize) * t(t(input) / libsize)
}
normcounts(sce) <- log10(CPMED(counts(sce)) + 1)

## ----setting3, echo=TRUE------------------------------------------------------
settingTGIF(sce, gmt, reducedDimNames="PCA", assayNames="normcounts")

## ----calc, echo=TRUE----------------------------------------------------------
calcTGIF(sce, ndim=3)

## ----report, echo=TRUE--------------------------------------------------------
reportTGIF(sce,
    html.open=FALSE,
    title="scTGIF Report for DistalLungEpithelium dataset",
    author="Koki Tsuyuzaki")

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

