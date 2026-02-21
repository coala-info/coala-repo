# Code example from 'BioCor_2_advanced' vignette. See references/ for full tutorial.

## ----setup, message=FALSE, warning=FALSE, include=FALSE-----------------------
knitr::opts_chunk$set(collapse = TRUE, warning = TRUE, fig.wide = TRUE, 
                      cache = FALSE, crop = FALSE)
suppressPackageStartupMessages(library("org.Hs.eg.db"))
genesKegg <- base::as.list(org.Hs.eg.db::org.Hs.egPATH)
genesReact <- base::as.list(reactome.db::reactomeEXTID2PATHID)
# Remove genes and pathways which are not from human pathways
genesReact <- lapply(genesReact, function(x) {
    grep("R-HSA-", x, value = TRUE)
})
genesReact <- genesReact[lengths(genesReact) >= 1]
library("BioCor")

## ----merging------------------------------------------------------------------
kegg <- mgeneSim(c("672", "675", "10"), genesKegg)
react <- mgeneSim(c("672", "675", "10"), genesReact)
## We can sum it adding a weight to each origin
weighted.sum(c(kegg["672", "675"], react["672", "675"]), w = c(0.3, 0.7))

## Or if we want to perform for all the matrix
## A list of matrices to merge
sim <- list("kegg" = kegg, "react" = react)
similarities(sim, weighted.sum, w = c(0.3, 0.7))
similarities(sim, weighted.prod, w = c(0.3, 0.7))
similarities(sim, prod)
similarities(sim, mean)

## ----weighted-----------------------------------------------------------------
weighted.mean(c(1, NA), w = c(0.5, 0.5), na.rm = TRUE)
weighted.mean(c(1, 0.5, NA), w = c(0.5, 0.25, 0.25), na.rm = TRUE)
weighted.sum(c(1, NA), w = c(0.5, 0.5))
weighted.sum(c(1, 0.5, NA), w = c(0.5, 0.25, 0.25))
weighted.prod(c(1, NA), w = c(0.5, 0.5))
weighted.prod(c(1, 0.5, NA), w = c(0.5, 0.25, 0.25))

## ----simulate, fig.cap="Volcano plot. The airway data", fig.wide = TRUE, code_folding = "hide"----
suppressPackageStartupMessages(library("airway"))
data("airway")
library("DESeq2")

dds <- DESeqDataSet(airway, design = ~ cell + dex)
dds$dex <- relevel(dds$dex, "untrt")
dds <- DESeq(dds)
res <- results(dds, alpha = 0.05)
summary(res)
plot(res$log2FoldChange, -log10(res$padj),
    pch = 16, xlab = "log2FC",
    ylab = "-log10(p.ajd)", main = "Untreated vs treated"
)
logFC <- 2.5
abline(v = c(-logFC, logFC), h = -log10(0.05), col = "red")

## ----BioCor-------------------------------------------------------------------
fc <- res[abs(res$log2FoldChange) >= logFC & !is.na(res$padj), ]
fc <- fc[fc$padj < 0.05, ]
# Convert Ids (used later)
genes <- select(org.Hs.eg.db,
    keys = rownames(res), keytype = "ENSEMBL",
    column = c("ENTREZID", "SYMBOL")
)
genesFC <- genes[genes$ENSEMBL %in% rownames(fc), ]
genesFC <- genesFC[!is.na(genesFC$ENTREZID), ]
genesSim <- genesFC$ENTREZID
names(genesSim) <- genesFC$SYMBOL
genesSim <- genesSim[!duplicated(genesSim)]
# Calculate the functional similarity
sim <- mgeneSim(genes = genesSim, info = genesReact, method = "BMA")

## ----pval1, fig.cap="Functional similarity of genes with logFC above 2,5. Similar genes cluster together.", fig.width=15, fig.height=20----
nas <- apply(sim, 1, function(x) {
    all(is.na(x))
})
sim <- sim[!nas, !nas]

MDSs <- cmdscale(1 - sim)
plot(MDSs, type = "n", main = "BMA similarity", xlab = "MDS1", ylab = "MDS2")
up <- genes[genes$ENSEMBL %in% rownames(fc)[fc$log2FoldChange >= logFC], "SYMBOL"]
text(MDSs, labels = rownames(MDSs), col = ifelse(rownames(MDSs) %in% up, "black", "red"))
abline(h = 0, v = 0)
legend("top", legend = c("Up-regulated", "Down-regulated"), fill = c("black", "red"))

## ----setting, fig.cap="Volcano plot of the subset of 400 genes. This subset will be used in the following sections", code_folding = "hide"----
set.seed(250)
subRes <- res[!is.na(res$log2FoldChange), ]
subs <- sample.int(nrow(subRes), size = 400)
subRes <- subRes[subs, ]
g <- genes[genes$ENSEMBL %in% rownames(subRes), "ENTREZID"]
gS <- mgeneSim(g[g %in% names(genesReact)], genesReact, "BMA")
deg <- rownames(subRes[subRes$padj < 0.05 & !is.na(subRes$padj), ])
keep <- rownames(gS) %in% genes[genes$ENSEMBL %in% deg, "ENTREZID"]
plot(subRes$log2FoldChange, -log10(subRes$padj),
    pch = 16, xlab = "log2FC",
    ylab = "-log10(p.ajd)", main = "Untreated vs treated"
)
abline(v = c(-logFC, logFC), h = -log10(0.05), col = "red")

## ----cluster2, fig.cap="Distribution of scores between differentially expressed genes and those who aren't. The line indicates the mean score of the similarity between differentially expressed genes and those which aren't differentially expressed.", fig.wide = TRUE----
library("boot")
# The mean of genes differentially expressed
(scoreDEG <- mean(gS[!keep, keep], na.rm = TRUE))
b <- boot(data = gS, R = 1000, statistic = function(x, i) {
    g <- !rownames(x) %in% rownames(x)[i]
    mean(x[g, i], na.rm = TRUE)
})
(p.val <- (1 + sum(b$t > scoreDEG)) / 1001)
hist(b$t, main = "Distribution of scores", xlab = "Similarity score")
abline(v = scoreDEG, col = "red")

## ----pval2, fig.cap="Distribution of the similarity within differentially expressed genes. The line indicates the mean funtional similarity whitin them.", fig.wide = TRUE----
(scoreW <- combineScores(gS[keep, keep], "avg"))
b <- boot(data = gS, R = 1000, statistic = function(x, i) {
    mean(x[i, i], na.rm = TRUE)
})
(p.val <- (1 + sum(b$t > scoreW)) / 1001) # P-value
hist(b$t, main = "Distribution of scores", xlab = "Similarity score")
abline(v = scoreW, col = "red")

## ----logfc1, fig.cap="Similarity of genes along abs(logFC). Assessing the similarity of genes according to their absolute log2 fold change.", fig.wide = TRUE, code_folding = "hide"----
s <- seq(0, max(abs(subRes$log2FoldChange)) + 0.05, by = 0.05)
l <- sapply(s, function(x) {
    deg <- rownames(subRes[abs(subRes$log2FoldChange) >= x, ])
    keep <- rownames(gS) %in% genes[genes$ENSEMBL %in% deg, "ENTREZID"]
    BetweenAbove <- mean(gS[keep, keep], na.rm = TRUE)
    AboveBelow <- mean(gS[keep, !keep], na.rm = TRUE)
    BetweenBelow <- mean(gS[!keep, !keep], na.rm = TRUE)
    c(
        "BetweenAbove" = BetweenAbove, "AboveBelow" = AboveBelow,
        "BetweenBelow" = BetweenBelow
    )
})
L <- as.data.frame(cbind(logfc = s, t(l)))
plot(L$logfc, L$BetweenAbove,
    type = "l", xlab = "abs(log2) fold change",
    ylab = "Similarity score",
    main = "Similarity scores along logFC", col = "darkred"
)
lines(L$logfc, L$AboveBelow, col = "darkgreen")
lines(L$logfc, L$BetweenBelow, col = "black")
legend("topleft",
    legend = c(
        "Between genes above and below threshold",
        "Whitin genes above threshold",
        "Whitin genes below threshold"
    ),
    fill = c("darkgreen", "darkred", "black")
)

## ----logfc2, fig.cap = "Functional similarity between the up-regulated and down-regulated genes.", code_folding = "hide"----
l <- sapply(s, function(x) {
    # Names of genes up and down regulated
    degUp <- rownames(subRes[subRes$log2FoldChange >= x, ])
    degDown <- rownames(subRes[subRes$log2FoldChange <= -x, ])

    # Translate to ids in gS
    keepUp <- rownames(gS) %in% genes[genes$ENSEMBL %in% degUp, "ENTREZID"]
    keepDown <- rownames(gS) %in% genes[genes$ENSEMBL %in% degDown, "ENTREZID"]

    # Calculate the mean similarity between each subgrup
    between <- mean(gS[keepUp, keepDown], na.rm = TRUE)

    c("UpVsDown" = between)
})
L <- as.data.frame(cbind("logfc" = s, "UpVsDown" = l))
plot(L$logfc, L$UpVsDown,
    type = "l",
    xlab = "abs(log2) fold change threshold",
    ylab = "Similarity score",
    main = "Similarity scores along logFC"
)
legend("topright",
    legend = "Up vs down regulated genes",
    fill = "black"
)

## ----newPathway, fig.wide=TRUE, eval=FALSE------------------------------------
# # Adding a new pathway "deg" to those genes
# genesReact2 <- genesReact
# diffGenes <- genes[genes$ENSEMBL %in% deg, "ENTREZID"]
# genesReact2[diffGenes] <- sapply(genesReact[diffGenes], function(x) {
#     c(x, "deg")
# })
# plot(ecdf(mgeneSim(names(genesReact), genesReact)))
# curve(ecdf(mgeneSim(names(genesReact2), genesReact2)), color = "red")

## ----newPathway2, fig.wide=TRUE, fig.cap="The effect of adding a new pathway to a functional similarity. In red the same network as in black but with the added pathway.", warning=FALSE, message=FALSE----
library("Hmisc")
genesReact2 <- genesReact
diffGenes <- genes[genes$ENSEMBL %in% deg, "ENTREZID"]
# Create the new pathway called deg
genesReact2[diffGenes] <- sapply(genesReact[diffGenes], function(x) {
    c(x, "deg")
})
ids <- unique(genes[genes$ENSEMBL %in% rownames(subRes), "ENTREZID"])
Ecdf(c(mgeneSim(ids, genesReact, method = "BMA"),
       mgeneSim(ids, genesReact2, method = "BMA")
),
group = c(rep("Reactome", length(ids)^2), rep("Modified", length(ids)^2)),
col = c("black", "red"), xlab = "Functional similarities", 
main = "Empirical cumulative distribution")

## ----combineSource, fig.cap = "Comparison of functional similarity in different databases."----
genesKegg <- as.list(org.Hs.egPATH)
gSK <- mgeneSim(rownames(gS), genesKegg)
mix <- combineSources(genesKegg, genesReact)
gSMix <- mgeneSim(rownames(gS), mix)
Ecdf(c(gS, gSK, gSMix),
    group = c(
        rep("Reactome", length(gS)), rep("Kegg", length(gSK)),
        rep("Mix", length(gSMix))
    ),
    col = c("black", "red", "blue"), xlab = "Functional similarities", 
    main = "Empirical cumulative distribution."
)

## ----combineSource2, fig.cap = "Comparison of functional similarity in different gene sets."----
gSK2 <- mgeneSim(rownames(gS), genesKegg, method = "BMA")
gS2 <- mgeneSim(rownames(gS), genesReact, method = "BMA")
gSMix2 <- mgeneSim(rownames(gS), mix, method = "BMA")
Ecdf(c(gS2, gSK2, gSMix2),
    group = c(
        rep("Reactome", length(gS)), rep("Kegg", length(gSK)),
        rep("Mix", length(gSMix))
    ),
    col = c("black", "red", "blue"), xlab = "Functional similarities (BMA)", main = "Empirical cumulative distribution."
)

## ----GOSemSim, fig.cap="Comparison of similarities. Functional similarities compared to biological process semantic similarity.",fig.wide=TRUE,include=TRUE----
library("GOSemSim")
BP <- godata("org.Hs.eg.db", ont = "BP", computeIC = TRUE)
gsGO <- GOSemSim::mgeneSim(rownames(gS), semData = BP, measure = "Resnik", verbose = FALSE)
keep <- rownames(gS) %in% rownames(gsGO)
hist(as.dist(gS[keep, keep] - gsGO),
    main = "Difference between functional similarity and biological process",
    xlab = "Functional similarity - biological process similarity"
)

## ----session, code_folding = "hide"-------------------------------------------
sessionInfo()

