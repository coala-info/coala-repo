# Code example from 'Hiiragi2013' vignette. See references/ for full tutorial.

### R code from vignette source 'Hiiragi2013.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex(short.fignames=TRUE, use.unsrturl=FALSE)


###################################################
### code chunk number 2: packages
###################################################
library("Hiiragi2013")
set.seed(2013)


###################################################
### code chunk number 3: loadx
###################################################
data("x")
x


###################################################
### code chunk number 4: showWT
###################################################
with(subset(pData(x), genotype=="WT"),
     addmargins(table(Embryonic.day, Total.number.of.cells), 2))


###################################################
### code chunk number 5: showFGF4KO
###################################################
with(subset(pData(x), genotype=="FGF4-KO"), table(Embryonic.day))


###################################################
### code chunk number 6: sampleColours
###################################################
groups = split(seq_len(ncol(x)), pData(x)$sampleGroup)
sapply(groups, length)


###################################################
### code chunk number 7: sampleColours
###################################################
sampleColourMap = setNames(unique(pData(x)$sampleColour), unique(pData(x)$sampleGroup))
sampleColourMap


###################################################
### code chunk number 8: FGF4probes
###################################################
FGF4probes = (fData(x)$symbol == "Fgf4")
stopifnot(sum(FGF4probes)==4)


###################################################
### code chunk number 9: expressed1
###################################################
selectedSamples = with(pData(x), genotype=="WT") 
xe = x[, selectedSamples]
stopifnot(ncol(xe)==66)


###################################################
### code chunk number 10: figHistSds
###################################################
sdxe = rowSds(exprs(xe))
thresh = 0.5
hist(sdxe, 100, col = "skyblue")
abline(v = thresh)


###################################################
### code chunk number 11: anaHistSds
###################################################
table(sdxe>=thresh)
length(unique(fData(xe)$ensembl[ sdxe>=thresh ]))


###################################################
### code chunk number 12: mas5calls
###################################################
data("a")
stopifnot(nrow(pData(a))==ncol(x))
mas5c = mas5calls(a[, selectedSamples])


###################################################
### code chunk number 13: numCalls1
###################################################
myUnique = function(x) setdiff(unique(x), "")
allEnsemblIDs = myUnique(fData(xe)$ensembl)

callsPerGenePerArray = matrix(0, nrow = length(allEnsemblIDs), ncol = ncol(mas5c)+1,
                              dimnames = list(allEnsemblIDs, NULL))

for(j in seq_len(ncol(mas5c))) {
  for(k in 1:2) {
    ids = myUnique(fData(xe)$ensembl[ exprs(mas5c)[, j]==c("M","P")[k] ])
    callsPerGenePerArray[ids, j] = k
  }
}
 
fractionOfArrays = 0.1
for(k in 1:2) {
  ids = myUnique(fData(xe)$ensembl[ apply(exprs(mas5c)==c("M","P")[k], 1, 
                                          function(v) (mean(v)>fractionOfArrays)) ])
  callsPerGenePerArray[ids, ncol(mas5c)+1] = k
}

numCalls = apply(callsPerGenePerArray, 2, table)
numCalls = numCalls[rev(seq_len(nrow(numCalls))), ]


###################################################
### code chunk number 14: numCalls2
###################################################
numCalls[, 67]


###################################################
### code chunk number 15: figmas5calls
###################################################
gplots::barplot2(numCalls, names.arg = paste(seq_len(ncol(callsPerGenePerArray))),
         col = c(RColorBrewer::brewer.pal(8, "Paired")[2:1], "#e8e8e8"), ylab = "number of genes")


###################################################
### code chunk number 16: clusterResampling
###################################################
clusterResampling = function(x, ngenes, k = 2, B = 250, prob = 0.67) {
  mat = exprs(x)
  ce = cl_ensemble(list = lapply(seq_len(B), function(b) {
    selSamps = sample(ncol(mat), size = round(prob*ncol(mat)), replace = FALSE)
    submat = mat[, selSamps, drop = FALSE]
    selFeats = order(rowVars(submat), decreasing = TRUE)[seq_len(ngenes)]
    submat = submat[selFeats,, drop = FALSE]
    pamres = cluster::pam(t(submat), k = k, metric = "euclidean")
    pred = cl_predict(pamres, t(mat[selFeats, ]), "memberships")
    as.cl_partition(pred)
  }))
  cons = cl_consensus(ce)
  ag = sapply(ce, cl_agreement, y = cons)
  return(list(agreements = ag, consensus = cons))
}


###################################################
### code chunk number 17: ce1
###################################################
ce = list(
  "E3.25" = clusterResampling(x[, unlist(groups[c("E3.25")])], ngenes = 20),
  "E3.5"  = clusterResampling(x[, unlist(groups[c("E3.5 (EPI)", "E3.5 (PE)")])],
                              ngenes = 20))


###################################################
### code chunk number 18: figClue1
###################################################
par(mfrow = c(1,2))
colours  = c(sampleColourMap["E3.25"], RColorBrewer::brewer.pal(9,"Set1")[9])

boxplot(lapply(ce, `[[`, "agreements"), ylab = "agreement probabilities", col = colours)

mems = lapply(ce, function(x) sort(cl_membership(x$consensus)[, 1]))
mgrp = lapply(seq(along = mems), function(i) rep(i, times = length(mems[[i]])))
myjitter = function(x) x+seq(-.4, +.4, length.out = length(x))

plot(unlist(lapply(mgrp, myjitter)), unlist(mems),
     col = colours[unlist(mgrp)], ylab = "membership probabilities",
     xlab = "consensus clustering", xaxt = "n", pch = 16)
text(x = 1:2, y = par("usr")[3], labels = c("E3.25","E3.5"), adj = c(0.5, 1.4), xpd = NA)


###################################################
### code chunk number 19: test
###################################################
wilcox.test(ce$E3.25$agreements, ce$E3.5$agreements)


###################################################
### code chunk number 20: ce2
###################################################
sampleSets = list(
  `E3.5` = unlist(groups[c("E3.5 (EPI)", "E3.5 (PE)", "E4.5 (FGF4-KO)")]),
  `E4.5` = unlist(groups[c("E4.5 (EPI)", "E4.5 (PE)", "E4.5 (FGF4-KO)")]))
k = 3
csa = lapply(sampleSets, function(samps) list(
  colours = x$sampleColour[samps], 
  r = clusterResampling(x[!FGF4probes, samps], ngenes = 20, k = k)))


###################################################
### code chunk number 21: figClue2
###################################################
par(mfrow = c(2,3))
for(i in seq(along = csa))
  for(j in seq_len(k))
    plot(cl_membership(csa[[i]]$r$consensus)[, j], 
         ylab = paste0("P(cluster ", j, ")"), xlab = "samples",
         main = names(sampleSets)[i], col = csa[[i]]$colours, pch = 16, cex = 1.5)


###################################################
### code chunk number 22: ce3
###################################################
sampleSets = unlist(groups[c("E3.25", "E3.5 (FGF4-KO)")])
selSamples = x[!FGF4probes, sampleSets]
resampledSampleSet = clusterResampling(selSamples, ngenes = 20)


###################################################
### code chunk number 23: figClue3
###################################################
par(mfrow = c(1,2))
  for(j in seq_len(2))
    plot(cl_membership(resampledSampleSet$consensus)[, j], 
         ylab = paste0("P(cluster ", j, ")"), xlab = "Samples",
         col = x$sampleColour[sampleSets], pch = 16, cex = 1.5)


###################################################
### code chunk number 24: figHeatmapClue
###################################################
ngenes = 100
selFeats = order(rowVars(exprs(selSamples)), decreasing = TRUE)[seq_len(ngenes)]
myHeatmap(selSamples[selFeats, ], collapseDuplicateFeatures = TRUE, haveColDend = TRUE)


###################################################
### code chunk number 25: doCluster
###################################################
ngenes = c(10, 25, 50, 100, 250, 500, 1000, 2500, 5000, 10000)


###################################################
### code chunk number 26: cluster
###################################################
xForClustering = x[, x$Embryonic.day=="E3.5" & x$genotype=="WT"]
clusters = sapply(ngenes, pamCluster, x = xForClustering)


###################################################
### code chunk number 27: figClusters
###################################################
image(x = seq_len(nrow(clusters)), y = seq_len(ncol(clusters)), z = clusters,
      col = c("#f0f0f0", "#000000"), ylab = "ngenes", xlab = "samples", yaxt = "n")
text(x = 0, y = seq_len(ncol(clusters)), paste(ngenes), xpd = NA, adj = c(1, 0.5))


###################################################
### code chunk number 28: choosengenes
###################################################
i = which(ngenes==1000); stopifnot(length(i)==1)
ngenes = ngenes[i]
clusters = factor(clusters[, i])


###################################################
### code chunk number 29: compareClusteringAnnotation
###################################################
table(clusters, pData(x)[names(clusters), "lineage"])


###################################################
### code chunk number 30: compareClusteringAnnotationCheck
###################################################
stopifnot(all(
 table(clusters, pData(x)[names(clusters), "lineage"])==cbind(c(0,11),c(11,0))
))


###################################################
### code chunk number 31: print
###################################################
cbind(unlist(groups[c("E3.5 (EPI)", "E3.5 (PE)")]), ce[[2]]$consensus$.Data[, 1])


###################################################
### code chunk number 32: deBetweenClusters
###################################################
deCluster = rowttests(xForClustering, fac = clusters)


###################################################
### code chunk number 33: figIndepFiltSetup
###################################################
varianceRank = rank(-rowVars(exprs(xForClustering)))
plot(varianceRank, deCluster$p.value, pch = ".", log = "y",
     main = "Parameters for the independent filtering",
     xlab = "variance rank", ylab = "p-value")
nFilt = 20000
smallpValue = 1e-4
abline(v = nFilt, col = "blue")
abline(h = smallpValue, col = "orange")


###################################################
### code chunk number 34: checkFilterClaim
###################################################
stopifnot(!any((deCluster$p.value<smallpValue)&(varianceRank>nFilt)))


###################################################
### code chunk number 35: BH
###################################################
passfilter = which(varianceRank<=nFilt)
adjp = rep(NA_real_, nrow(x))
adjp[passfilter] = p.adjust(deCluster$p.value[passfilter], method = "BH")
ord = order(adjp)
numFeaturesReport = 200
differentially = ord[seq_len(numFeaturesReport)]
length(unique(fData(x)$symbol[differentially]))


###################################################
### code chunk number 36: write.csv
###################################################
deFeat35 = cbind(deCluster[differentially,], `FDR-adjusted p-value` = adjp[differentially], 
                 fData(x)[differentially,])
write.csv(deFeat35, file = "differentially-expressed-features-3.5.csv")


###################################################
### code chunk number 37: figHeatmapAll
###################################################
myHeatmap(x[differentially, x$genotype=="WT"])


###################################################
### code chunk number 38: figHeatmapAllColl
###################################################
myHeatmap(x[differentially, x$genotype=="WT"], collapseDuplicateFeatures = TRUE)


###################################################
### code chunk number 39: figHeatmap35
###################################################
myHeatmap(xForClustering[differentially, ])


###################################################
### code chunk number 40: figHeatmap35Coll
###################################################
myHeatmap(xForClustering[differentially, ], collapseDuplicateFeatures = TRUE)


###################################################
### code chunk number 41: de45
###################################################
x45 = x[, x$Embryonic.day=="E4.5" & x$genotype=="WT"]
de45 = rowttests(x45, fac = "lineage")


###################################################
### code chunk number 42: figIF45
###################################################
varianceRank = rank(-rowVars(exprs(x45)))
plot(varianceRank, de45$p.value, pch = ".", log = "y",
     main = "Parameters for the independent filtering",
     xlab = "variance rank", ylab = "p-value")
abline(v = nFilt, col = "blue")
abline(h = smallpValue, col = "orange")


###################################################
### code chunk number 43: BH45
###################################################
passfilter = which(varianceRank<=nFilt)
adjp = rep(NA_real_, nrow(x))
adjp[passfilter] = p.adjust(de45$p.value[passfilter], method = "BH")
ord = order(adjp)
differentially = ord[seq_len(numFeaturesReport)]
length(unique(fData(x)$symbol[differentially]))


###################################################
### code chunk number 44: write.csv
###################################################
deFeat45 = cbind(de45[differentially, ], `FDR-adjusted p-value` = adjp[differentially], 
                 fData(x)[differentially, ])
write.csv(deFeat45, file = "differentially-expressed-features-4.5.csv")


###################################################
### code chunk number 45: differentiallyE325toE35
###################################################
samples = unlist(groups[c("E3.25", "E3.5 (EPI)", "E3.5 (PE)")])
deE325toE35 = union(
  getDifferentialExpressedGenes(x, groups, "E3.25", "E3.5 (EPI)"),
  getDifferentialExpressedGenes(x, groups, "E3.25", "E3.5 (PE)"))


###################################################
### code chunk number 46: figdifferentiallyE325toE35
###################################################
myHeatmap(x[deE325toE35, samples], collapseDuplicateFeatures = TRUE)


###################################################
### code chunk number 47: E325samples
###################################################
projection = deCluster$dm[differentially] %*% exprs(x)[differentially, ]


###################################################
### code chunk number 48: figProjection
###################################################
plotProjection(projection, label = sampleNames(x),
               col = x$sampleColour, colourMap = sampleColourMap)


###################################################
### code chunk number 49: safeSelect-1
###################################################
safeSelect = function(grpnames){
  stopifnot(all(grpnames %in% names(groups)))
  unlist(groups[grpnames])
}
g = safeSelect(c("E3.25",
                 "E3.5 (EPI)", "E3.5 (PE)",
                 "E4.5 (EPI)", "E4.5 (PE)"))


###################################################
### code chunk number 50: varianceOrder
###################################################
nfeatures = 100
varianceOrder = order(rowVars(exprs(x[, g])), decreasing = TRUE)
varianceOrder = setdiff(varianceOrder, which(FGF4probes))
selectedFeatures = varianceOrder[seq_len(nfeatures)]
xwt = x[selectedFeatures, g]


###################################################
### code chunk number 51: doPCA1
###################################################
tab = table(xwt$sampleGroup)
sp = split(seq_len(ncol(xwt)), xwt$sampleGroup)
siz = max(listLen(sp))
sp = lapply(sp, sample, size = siz, replace = (siz>length(x)))
xwte = xwt[, unlist(sp)]


###################################################
### code chunk number 52: doPCA2
###################################################
thepca = prcomp(t(exprs(xwte)), center = TRUE)
pcatrsf = function(x) scale(t(exprs(x)), center = TRUE, scale = FALSE) %*% thepca$rotation
stopifnot(all( abs(pcatrsf(xwte) - thepca$x) < 1e-6 ))


###################################################
### code chunk number 53: myPCA
###################################################
myPCAplot = function(x, labels, ...) {
  xy = pcatrsf(x)[, 1:2]
  plot(xy, pch = 16, col = x$sampleColour, cex = 1, xlab = "PC1", ylab = "PC2", ...)
  if(!missing(labels))
    text(xy, labels, cex = 0.35, adj = c(0.5, 0.5))
}


###################################################
### code chunk number 54: figmds-1
###################################################
myPCAplot(xwt)


###################################################
### code chunk number 55: figpcaloadings
###################################################
par(mfrow = c(1,2))
for(v in c("PC1", "PC2")) {
  loading = thepca$rotation[, v]
  plot(sort(loading), main = v, ylab = "")
  sel = order(loading)[c(1:10, (-9:0)+length(loading))]
  print(data.frame(
   symbol = fData(x)$symbol[selectedFeatures[sel]],
   probe = names(loading)[sel],
   loading = loading[sel], stringsAsFactors = FALSE
  ))
}


###################################################
### code chunk number 56: figmds-2
###################################################
myPCAplot(x[selectedFeatures, ])


###################################################
### code chunk number 57: figmds-3
###################################################
myPCAplot(x[selectedFeatures, ], labels = paste(seq_len(ncol(x))))


###################################################
### code chunk number 58: figmds-4
###################################################
myPCAplot(x[selectedFeatures, ], labels = paste(x$Total.number.of.cells))


###################################################
### code chunk number 59: hmprep
###################################################
mat = exprs(x[selectedFeatures, ])
rownames(mat) = fData(x)[selectedFeatures, "symbol"]


###################################################
### code chunk number 60: fighmko
###################################################
gplots::heatmap.2(mat, trace = "none", dendrogram = "none", scale = "row",
          col = gplots::bluered(100), keysize = 0.9,
          ColSideColors = x$sampleColour, margins = c(7,5))


###################################################
### code chunk number 61: figFGF4expression
###################################################
x325  = x[, with(pData(x), Embryonic.day=="E3.25")]
rv325 = rowVars(exprs(x325))
featureColours = RColorBrewer::brewer.pal(sum(FGF4probes), "Dark2")
py = t(exprs(x325)[FGF4probes, ])
matplot(py, type = "p", pch = 15, col = featureColours,
        xlab = "arrays", ylab = expression(log[2] ~ signal),
        ylim = range(py) + c(-0.7, 0))
legend("topright", legend = rownames(fData(x325))[FGF4probes], fill = featureColours)
points(seq_len(nrow(py)), rep(par("usr")[3]+0.2, nrow(py)),
       pch = 16, col = x325$sampleColour)


###################################################
### code chunk number 62: checkClaim1
###################################################
stopifnot(all(c("1420085_at", "1420086_x_at") %in% rownames(fData(x325))[FGF4probes]),
          all(x325$genotype[1:36]=="WT"),
          all(x325$genotype[37:44]=="FGF4-KO"))


###################################################
### code chunk number 63: FGF4expression2
###################################################
fgf4Expression = colMeans(exprs(x325)[c("1420085_at", "1420086_x_at"), ])
fgf4Genotype = factor(x325$genotype, 
                      levels = sort(unique(x325$genotype),decreasing = TRUE))


###################################################
### code chunk number 64: figFGF4jitter
###################################################
plot(x = jitter(as.integer(fgf4Genotype)),
     y = fgf4Expression,
     col = x325$sampleColour, xlim = c(0.5, 2.5), pch = 16,
     ylab = expression(FGF4~expression~(log[2]~units)),
     xlab = "genotype", xaxt = "n")
cm = sampleColourMap[sampleColourMap %in% x325$sampleColour]
legend("topright", legend = names(cm), fill = cm)


###################################################
### code chunk number 65: Fgf4MDS
###################################################
zero2one = function(x) (x-min(x))/diff(range(x))
rgb2col = function(x) {x = x/255; rgb(x[, 1], x[, 2], x[, 3])}

colours = x325$sampleColour
wt325 = x325$genotype=="WT"
colourBar = function(x) rgb2col(colorRamp(c("yellow", "blue"))(zero2one(x)))
colours[wt325] = colourBar(fgf4Expression)[wt325]

selMDS = order(rv325, decreasing = TRUE)[seq_len(100)]


###################################################
### code chunk number 66: figFgf4MDS
###################################################
MDSplot(x325[selMDS, ], col = colours)


###################################################
### code chunk number 67: figFgf4MDSColourBar
###################################################
atColour = seq(min(fgf4Expression), max(fgf4Expression), length = 20)
image(z = rbind(seq(along = atColour)), col = colourBar(atColour),
      xaxt = "n", y = atColour, ylab = "")


###################################################
### code chunk number 68: corFgf4Dist
###################################################
KOmean = rowMeans(exprs(x325)[selMDS, x325$genotype=="FGF4-KO"])
dists = colSums((exprs(x325)[selMDS, wt325] - KOmean)^2)^0.5
ct = cor.test(fgf4Expression[wt325], dists, method = "spearman")
ct


###################################################
### code chunk number 69: figCorFgf4Dist
###################################################
plot(fgf4Expression[wt325], dists, pch = 16, main = "E3.25 WT samples",
     xlab = "FGF4 expression", ylab = "Distance to FGF4-KO", col = colours)


###################################################
### code chunk number 70: Hiiragi2013.Rnw:910-911
###################################################
stopifnot(ct$p.value<0.01)


###################################################
### code chunk number 71: FGF4variab1
###################################################
varGroups = split(seq_len(ncol(x)), f = list(x$sampleGroup,x$Total.number.of.cells),
                  sep = ":", drop = TRUE)


###################################################
### code chunk number 72: ScanDate
###################################################
data.frame(
  `number arrays` = listLen(varGroups),
  `ScanDates` = sapply(varGroups, function(v) 
    paste(as.character(unique(x$ScanDate[v])), collapse = ", ")),
  stringsAsFactors = FALSE)


###################################################
### code chunk number 73: FGF4variab1
###################################################
sel   = varianceOrder[seq_len(nfeatures)]
myfun = function(x) median(apply(exprs(x), 1, mad))

sds = lapply(varGroups, function(j) myfun(x[sel, j]))
names(sds) = sprintf("%s (n=%d)", names(sds), listLen(varGroups))

varGroupX = factor(sapply(strsplit(names(varGroups), split = ":"),`[`, 1))


###################################################
### code chunk number 74: figFGF4variab
###################################################
op = par(mai = c(2,0.7,0.1,0.1))
plot(jitter(as.integer(varGroupX)), sds, xaxt = "n", xlab = "", ylab = "")
axis(1, las = 2, tick = FALSE, at = unique(varGroupX), labels = unique(varGroupX))
par(op)


###################################################
### code chunk number 75: sds
###################################################
gps = split(seq_len(ncol(x)), f = x$sampleGroup)[c("E3.25", "E3.25 (FGF4-KO)")]
sds = sapply(gps, function(j) apply(exprs(x)[sel, j], 1, mad))
summary(sds)
apply(sds, 2, function(x) c(`mean` = mean(x), `sd` = sd(x)))


###################################################
### code chunk number 76: numberOfCells
###################################################
for(n in c(100, 1000)) {
  sel = order(rv325, decreasing = TRUE)[seq_len(n)]
  KOmean = rowMeans(exprs(x325)[sel, x325$genotype=="FGF4-KO"])
  dists = colSums((exprs(x325)[sel, wt325] - KOmean)^2)^0.5

  pdf(file = sprintf("Hiiragi2013-figNumberOfCells-%d.pdf", n), width = 5, height = 10)
  par(mfrow = c(2,1))
  plot(x325$Total.number.of.cells[wt325], dists, pch = 16, main = "",
       xlab = "Total number of cells", ylab = "Distance to FGF4-KO")
  MDSplot(x325[sel, ], pointlabel = ifelse(x325$genotype=="WT",
                                           paste(x325$Total.number.of.cells), "KO"), cex = 1)
  dev.off()
}


###################################################
### code chunk number 77: selectedGroups
###################################################
selectedGroups = c("E3.25", "E3.25 (FGF4-KO)")
xKO = x[, safeSelect(selectedGroups)]
selectedFeatures = order(rowVars(exprs(xKO)), decreasing = TRUE)[seq_len(100)]


###################################################
### code chunk number 78: figHeatmapKO
###################################################
myHeatmap(xKO[selectedFeatures, ], collapseDuplicateFeatures = TRUE, haveColDend = TRUE)


###################################################
### code chunk number 79: checkClaim2
###################################################
stopifnot("Fgf4" %in% fData(xKO)$symbol[selectedFeatures])


###################################################
### code chunk number 80: dewtko
###################################################
x35 = x[, safeSelect(c("E3.5 (FGF4-KO)", "E3.5 (EPI)", "E3.5 (PE)"))]
f1 = f2 = x35$sampleGroup
f1[f1=="E3.5 (PE)" ] = NA
f2[f2=="E3.5 (EPI)"] = NA
x35$EPI = factor(f1, levels = c("E3.5 (FGF4-KO)", "E3.5 (EPI)"))
x35$PE  = factor(f2, levels = c("E3.5 (FGF4-KO)", "E3.5 (PE)"))
de = list(`EPI` = rowttests(x35, "EPI"),
          `PE`  = rowttests(x35, "PE"))
for(i in seq(along = de))
  de[[i]]$p.adj = p.adjust(de[[i]]$p.value, method = "BH")


###################################################
### code chunk number 81: figIndepFiltDeWtKo
###################################################
par(mfcol = c(3,2))
rkv = rank(-rowVars(exprs(x35)))
fdrthresh = 0.05
fcthresh =  1
for(i in seq(along = de)) {
  hist(de[[i]]$p.value, breaks = 100, col = "lightblue", main = names(de)[i], xlab = "p")
  plot(rkv, -log10(de[[i]]$p.value), pch = 16, cex = .25, main = "",
       xlab = "rank of overall variance", ylab = expression(-log[10]~p))
  plot(de[[i]]$dm, -log10(de[[i]]$p.value), pch = 16, cex = .25, main = "",
      xlab = "average log fold change", ylab = expression(-log[10]~p))
  abline(v = c(-1,1)*fcthresh[i], col = "red")
}


###################################################
### code chunk number 82: fig2DWTKO
###################################################
isSig = ((pmin(de$PE$p.adj, de$EPI$p.adj) < fdrthresh) &
         (pmax(abs(de$PE$dm), abs(de$EPI$dm)) > fcthresh))
table(isSig)
plot(de$PE$dm, de$EPI$dm, pch = 16, asp = 1,
     xlab = expression(log[2]~FGF4-KO / PE),
     ylab = expression(log[2]~FGF4-KO / EPI),
     cex  = ifelse(isSig, 0.6, 0.1), col = ifelse(isSig, "red", "grey"))


###################################################
### code chunk number 83: writetab35
###################################################
df = cbind(fData(x35)[isSig, ], `log2FC KO/PE` = de$PE$dm[isSig],
           `log2FC KO/EPI` = de$EPI$dm[isSig])
write.csv(df, file = "differentially_expressed_E3.5_vs_FGF4-KO.csv")
ctrls = grep("^AFFX", rownames(df), value = TRUE)


###################################################
### code chunk number 84: figFGF4ProbesInKO
###################################################
par(mfrow = c(2,2))
for(p in which(FGF4probes))
  plot(exprs(x35)[p, ], type = "p", pch = 16, col = x35$sampleColour, 
       main = rownames(fData(x325))[p], ylab = expression(log[2]~expression)) 


###################################################
### code chunk number 85: checkClaim3
###################################################
stopifnot(sum(FGF4probes)==4)


###################################################
### code chunk number 86: figCtrls
###################################################
stopifnot(length(ctrls)>=8)


###################################################
### code chunk number 87: figCtrls
###################################################
par(mfcol = c(4, 2))
for(p in ctrls[1:8])
  plot(exprs(x35)[p, ], type = "p", pch = 16, col = x35$sampleColour, 
       main = p, ylab = expression(log[2]~expression)) 


###################################################
### code chunk number 88: kegg (eval = FALSE)
###################################################
## allGenes = unique(fData(x35)$symbol)
## sigGenes = unique(df$symbol)
## ntot = length(allGenes)
## n1   = length(sigGenes)
## keggpw = as.list(mouse4302PATH2PROBE)
## fts = lapply(keggpw, function(ps) {
##    pwGenes = unique(as.character(mouse4302SYMBOL[ps]))
##    ovlGenes = intersect(pwGenes, sigGenes)
##    n2  = length(pwGenes)
##    nov = length(ovlGenes)
##    mat = matrix(c(ntot-n1-n2+nov, n2-nov, n1-nov, nov), ncol = 2, nrow = 2,
##                 dimnames = list(`pathway` = c("no","yes"), `diff. expressed` = c("no","yes")))
##    ft = fisher.test(mat)
##    list(mat = mat, p.value = ft$p.value, estimate = ft$estimate, 
##         genes = paste(sort(ovlGenes), collapse = ", ")) 
##    })


###################################################
### code chunk number 89: kegg
###################################################
keggpw = as.list(mouse4302PATH2PROBE)
dat  = de$PE$dm+de$EPI$dm
fts = lapply(keggpw, function(ps) {
  inpw = rownames(fData(x35)) %in% ps
  ft   = ks.test( dat[inpw], dat[!inpw] )
  list(p.value = ft$p.value, statistic = ft$statistic, n = sum(inpw)) 
})


###################################################
### code chunk number 90: pws1
###################################################
pws = c("04010", "04070", "04150", "04310", "04330", "04340", "04350", "04370", "04630")


###################################################
### code chunk number 91: pws2 (eval = FALSE)
###################################################
## pws = c(pws, names(fts)[ sapply(fts, function(x) 
##     with(x, (sum(mat[2, ])<=40) && (p.value<0.01) && (estimate>=2))) ] )


###################################################
### code chunk number 92: pws2
###################################################
pws = unique( c(pws, names(fts)[ sapply(fts, function(x) 
    with(x, (n<=100) && (p.value<0.01))) ] ) )


###################################################
### code chunk number 93: pwInfo
###################################################
query  = paste0("mmu", pws)
query  = split(query, seq(along = query) %/% 10)
pwInfo = unlist(lapply(query, keggGet), recursive = FALSE)


###################################################
### code chunk number 94: assertion
###################################################
stopifnot(all(pws %in% names(fts)))
stopifnot(length(pwInfo)==length(pws))


###################################################
### code chunk number 95: pwImgs (eval = FALSE)
###################################################
## pwImgs = lapply(query, keggGet, option = "image")
## stopifnot(length(pwImgs)==length(pws))


###################################################
### code chunk number 96: xtable (eval = FALSE)
###################################################
## df = data.frame(
##   `id`   = pws,
##   `name` = sub(" - Mus musculus (mouse)", "", sapply(pwInfo, `[[`, "NAME"), fixed = TRUE),
##   `n`    = sapply(pws, function(x) sum(fts[[x]]$mat[2, ])),
##   `differentially expressed genes` = sapply(pws, function(x) fts[[x]]$genes),
##   `p`          = as.character(signif(sapply(pws, function(x) fts[[x]]$p.value),  2)),
##   `odds-ratio` = as.character(signif(sapply(pws, function(x) fts[[x]]$estimate), 2)),
##   stringsAsFactors = FALSE, check.names = FALSE)


###################################################
### code chunk number 97: xtable
###################################################
df = data.frame(
  `id`   = pws,
  `name` = sub(" - Mus musculus (mouse)", "", sapply(pwInfo, `[[`, "NAME"), fixed = TRUE),
  `n`         =                     sapply(pws, function(x) fts[[x]]$n),
  `p`         = as.character(signif(sapply(pws, function(x) fts[[x]]$p.value),  2)),
  `statistic` = as.character(signif(sapply(pws, function(x) fts[[x]]$statistic), 2)),
  stringsAsFactors = FALSE, check.names = FALSE)


###################################################
### code chunk number 98: printxtable
###################################################
print(xtable(df,
  caption = paste("Gene set enrichment analysis of selected KEGG pathways, for the",
                   "differentially expressed genes between E3.5 FGF-4 KO and WT samples.",
                   "n: number of microarray features annotated to genes in the pathway."),
  label = "tab_KEGG", align = c("l", "l","p{4cm}","r","r","r")),
  type = "latex", file = "tab_KEGG.tex")


###################################################
### code chunk number 99: figShowPws
###################################################
par(mfrow = c(7,4)); stopifnot(length(pws)<=42)
for(i in seq(along = pws)) {
  inpw = factor(ifelse(rownames(fData(x35)) %in% keggpw[[pws[i]]],"in pathway","outside"))
  ord  = order(inpw)
  enr  = paste0("p=", df$p[i], if(as.numeric(df$p[i])<0.05)
                                  paste(" D=", df$statistic[i]) else "")
  multiecdf( (de$PE$dm+de$EPI$dm) ~ inpw, xlim = c(-1,1)*3,
             main = paste(df$name[i], enr, sep = "\n"),
             xlab = "mean difference between FGF4-KO and wildtype samples" )
}


###################################################
### code chunk number 100: defJSD
###################################################
H = function(p) -sum(p*log2(p))
JSD = function(m, normalize = TRUE) {
  stopifnot(is.matrix(m), all(dim(m)>1))
  if(normalize)
    m = m/rowSums(m)
  H(colMeans(m)) - mean(apply(m, 2, H))
}


###################################################
### code chunk number 101: defSDV
###################################################
SDV = function(m) sqrt(mean(rowVars(m)))


###################################################
### code chunk number 102: numberFeatures
###################################################
numberFeatures = c(50, 200, 1000, 4000)


###################################################
### code chunk number 103: computeDivergences
###################################################
computeDivergences = function(y, indices, fun) {
  y = y[indices, ]
  exprVals = y[, -1]
  strata = y[, 1]
  numStrata = max(strata)
  stopifnot(setequal(strata, seq_len(numStrata)))

  orderedFeatures = order(rowVars(t(exprVals)), decreasing = TRUE)
  sapply(numberFeatures, function(n) {
    selFeat = orderedFeatures[seq_len(n)]
    sapply(seq_len(numStrata), function(s)
             fun(exprVals[strata==s, selFeat, drop = FALSE]))
  })
}


###################################################
### code chunk number 104: strata
###################################################
x$sampleGroup = factor(x$sampleGroup)
x$strata = as.numeric(x$sampleGroup)


###################################################
### code chunk number 105: check
###################################################
stopifnot(!any(is.na(x$strata)))


###################################################
### code chunk number 106: doJSD
###################################################
bootJSD = boot(data = cbind(x$strata, t(exprs(x))),
               statistic = function(...) computeDivergences(..., fun = JSD),
               R = 100, strata = x$strata)
dim(bootJSD$t) = c(dim(bootJSD$t)[1], dim(bootJSD$t0))


###################################################
### code chunk number 107: doSD
###################################################
bootSDV = boot(data = cbind(x$strata, t(exprs(x))),
               statistic = function(...) computeDivergences(..., fun = SDV),
               R = 100, strata = x$strata)
dim(bootSDV$t) = c(dim(bootSDV$t)[1], dim(bootSDV$t0))


###################################################
### code chunk number 108: fig-JSD
###################################################
par(mfrow = c(length(numberFeatures),2))
colores = sampleColourMap[levels(x$sampleGroup)]
for(i in seq(along = numberFeatures)) {
  for(what in c("JSD", "SDV")){
    obj = get(paste("boot", what, sep = ""))
    boxplot(obj$t[, , i], main = sprintf("numberFeatures=%d", numberFeatures[i]),
            col = colores, border = colores, ylab = what, xaxtb = "n")
    px = seq_len(ncol(obj$t))
    text(x = px, y = par("usr")[3], labels = levels(x$sampleGroup),
         xpd = NA, srt = 45, adj = c(1,0.5), col = colores)
    points(px, obj$t0[, i], pch = 16)
  }
} 


###################################################
### code chunk number 109: xs
###################################################
xs = x[, pData(x)$sampleGroup %in%
   c("E3.25", "E3.5 (PE)", "E4.5 (PE)", "E3.5 (EPI)", "E4.5 (EPI)")]
xs$sampleGroup = factor(xs$sampleGroup)


###################################################
### code chunk number 110: myBoxplot
###################################################
myBoxplot = function(ps) {
  fac = factor(pData(xs)$sampleGroup)
  boxplot(exprs(xs)[ps, ] ~ fac, col = sampleColourMap[levels(fac)], lim = c(2,14),
          main = sprintf("%s (%s)", fData(x)[ps, "symbol"], ps), show.names = FALSE)
  text(seq(along = levels(fac)), par("usr")[3] - diff(par("usr")[3:4])*0.02,
       levels(fac), xpd = NA, srt = 90, adj = c(1,0.5), cex = 0.8)
}


###################################################
### code chunk number 111: showGenes
###################################################
exemplaryGenes = read.table(header = TRUE, stringsAsFactors = FALSE, text = "
symbol   thclass  probeset
Gata6      C-1 1425464_at
Tom1l1     C-1 1439337_at
Sox2       C-1 1416967_at
Pdgfra    PE-2 1438946_at
Sox17     PE-2 1429177_x_at
P4ha2     PE-2 1417149_at
Gata4     PE-3 1418863_at
Aldh18a1  PE-3 1415836_at
Col4a1    PE-3 1452035_at
Col4a2    PE-3 1424051_at
Cubn      PE-3 1426990_at
Lamb1     PE-3 1424113_at
Dab2      PE-4 1423805_at
Lrp2      PE-4 1427133_s_at
Amn       PE-4 1417920_at
Fgf4     EPI-2 1420085_at
Nanog    EPI-2 1429388_at
Tdgf1    EPI-2 1450989_at
Cldn4    EPI-4 1418283_at
Enox1    EPI-4 1436799_at")

pdf(file = "exemplaryGenes.pdf", width = 8, height = 11)
par(mfrow = c(5,3))
for(i in seq_len(nrow(exemplaryGenes))) {
  wh = featureNames(x)[fData(x)[, "symbol"]==exemplaryGenes[i, "symbol"]]
  stopifnot(length(wh)>=1)
  sapply(wh, myBoxplot)
}
dev.off()


###################################################
### code chunk number 112: fig-ExemplaryGenes
###################################################
layout(rbind(c(1, 4,   7, 13),
             c(2, 5,   8, 14),
            c(21, 6,   9, 15),
             c(3, 16, 10, 19),
            c(22, 17, 11, 20),
            c(23, 18, 12, 24)))

xs = x
xs$sampleGroup = factor(xs$sampleGroup)
xs$sampleGroup = relevel(xs$sampleGroup, "E4.5 (PE)")
xs$sampleGroup = relevel(xs$sampleGroup, "E4.5 (EPI)")
xs$sampleGroup = relevel(xs$sampleGroup, "E3.5 (PE)")
xs$sampleGroup = relevel(xs$sampleGroup, "E3.5 (EPI)")
xs$sampleGroup = relevel(xs$sampleGroup, "E3.25")

for(i in seq_len(nrow(exemplaryGenes))) 
  myBoxplot(exemplaryGenes[i, "probeset"])


###################################################
### code chunk number 113: avglfc
###################################################
greater = function(cond1, cond2, thresh = 2) {
  stopifnot(all(cond1 %in% names(groups)), all(cond2 %in% names(groups)))
  rm1 = lapply(groups[cond1], function(j) rowMeans(exprs(x)[, j]))
  rm2 = lapply(groups[cond2], function(j) rowMeans(exprs(x)[, j]))
  res = rep(TRUE, nrow(x))
  for(v1 in rm1) for(v2 in rm2) 
      res = res & ((v1-v2) > thresh)
  return(res)
}


###################################################
### code chunk number 114: minLevel
###################################################
xquantiles = apply(exprs(x), 1, quantile, probs = c(0.025, 0.975))
minLevel = xquantiles[1, ]
maxLevel = xquantiles[2, ]
trsf2Zero2One = function(x) {
  x = (x-minLevel)/(maxLevel-minLevel)
  x[x<0] = 0
  x[x>1] = 1
  return(x)
}
xsc = x
exprs(xsc) = trsf2Zero2One(exprs(x))


###################################################
### code chunk number 115: isOff
###################################################
isOff = function(cond, thresh = 2) {
  stopifnot(all(cond %in% names(groups)))
  samps = unlist(groups[cond])
  rowSums(exprs(x)[, samps] > minLevel+thresh) <= ceiling(length(samps) * 0.1)
}


###################################################
### code chunk number 116: classification
###################################################
  `C-1` =  greater("E3.25", c("E3.5 (EPI)", "E4.5 (EPI)", "E3.5 (PE)", "E4.5 (PE)"))
`EPI-2` =  greater("E3.5 (EPI)", c("E3.25")) &
           greater("E3.5 (EPI)", "E4.5 (EPI)", thresh = 0.5) &
           isOff("E3.5 (PE)")  & isOff("E4.5 (PE)" )
 `PE-2` =  greater("E3.5 (PE)",  c("E3.25")) &
           greater("E3.5 (PE)",  "E4.5 (PE)", thresh = 0.5)  & 
           isOff("E3.5 (EPI)") & isOff("E4.5 (EPI)")
`EPI-4` = (greater("E4.5 (EPI)", c("E3.25", "E3.5 (EPI)")) &
           isOff(c("E3.25", "E3.5 (EPI)")) & 
           isOff("E4.5 (PE)" ))
 `PE-4` = (greater("E4.5 (PE)", c("E3.25", "E3.5 (PE)")) &
           isOff(c("E3.25", "E3.5 (PE)")) & 
           isOff("E4.5 (EPI)"))
`EPI-3` = (greater("E3.5 (EPI)", "E3.25", thresh = 0.5) &
           greater("E4.5 (EPI)", "E3.5 (EPI)", thresh = 0.5) &
           greater("E4.5 (EPI)", "E3.25", thresh = 3)   & 
           isOff("E4.5 (PE)") & !`EPI-4`)
 `PE-3` = (greater("E3.5 (PE)",  "E3.25", thresh = 0.5) &
           greater("E4.5 (PE)",  "E3.5 (PE)",  thresh = 0.5) &
           greater("E4.5 (PE)",  "E3.25", thresh = 3) & 
           isOff("E4.5 (EPI)") & !`PE-4`)
thclasses = cbind(`C-1`, `EPI-2`, `EPI-3`, `EPI-4`, `PE-2`,  `PE-3`,  `PE-4`)


###################################################
### code chunk number 117: onegroup
###################################################
multiclass = thclasses[rowSums(thclasses)>1,, drop = FALSE]
stopifnot(nrow(multiclass)==0)


###################################################
### code chunk number 118: cs
###################################################
colSums(thclasses)


###################################################
### code chunk number 119: figHeatmapthclasses
###################################################
agr = groups[c("E3.25", "E3.5 (EPI)", "E4.5 (EPI)", "E3.5 (PE)", "E4.5 (PE)")]
fgr = apply(thclasses, 2, which)
xsub = xsc[unlist(fgr), unlist(agr)]
mat = exprs(xsub)
rownames(mat) = fData(xsub)[, "symbol"]
myHeatmap2(mat, keeprownames = TRUE,
           rowGroups = factor(rep(seq(along = fgr), listLen(fgr))),
           colGroups = factor(rep(seq(along = agr), listLen(agr))))


###################################################
### code chunk number 120: writecsv
###################################################
out = do.call(rbind, lapply(seq(along = fgr), function(i) 
    cbind(`class` = names(fgr)[i], fData(xsc)[fgr[[i]], ])))
write.csv(out, file = "featureclassification.csv")


###################################################
### code chunk number 121: fig2bGenes
###################################################
fig2bGenes = c("Aldh18a1", "Col4a1", "Cubn", "Foxq1", "Gata4", "Lamb1", "Serpinh1")


###################################################
### code chunk number 122: rbGenes
###################################################
rbGenes = sort(unique(fData(x)$symbol[thclasses[, "PE-3"]]))
rbGenes


###################################################
### code chunk number 123: setdiff
###################################################
setdiff(fig2bGenes, rbGenes)


###################################################
### code chunk number 124: load
###################################################
data("xq")


###################################################
### code chunk number 125: hmprep
###################################################
xq$sampleColours = sampleColourMap[sub("[[:digit:]]+ ", "", sampleNames(xq))]
stopifnot(!any(is.na(xq$sampleColours)))


###################################################
### code chunk number 126: myHeatmap3
###################################################
myHeatmap3 = function(x, log = TRUE, 
  col = colorRampPalette(RColorBrewer::brewer.pal(9, "Blues"))(ncol), ncol = 100, ...) {
  mat = exprs(x)
  if(log){
    mat[mat<1] = 1
    mat = log10(mat)
  }
  rownames(mat) = fData(x)[, "symbol"]
  gplots::heatmap.2(mat, trace = "none", dendrogram = "none", scale = "none", col = col,
            keysize = 0.9, ColSideColors = x$sampleColour, margins = c(5,7), ...)
}


###################################################
### code chunk number 127: fighm1
###################################################
myHeatmap3(xq)


###################################################
### code chunk number 128: fighm2
###################################################
selectedGenes = c("Col4a1", "Lamab1", "Cubn", "Gata4", "Serpinh1", "Foxq1", "Aldh18a1")
myHeatmap3(xq[selectedGenes, ])


###################################################
### code chunk number 129: checkAssertion
###################################################
stopifnot(length(selectedGenes)==7)


###################################################
### code chunk number 130: selectedPE
###################################################
selectedSamples = (xq$Cell.type %in% c("ICM", "PE"))
table(xq$sampleGroup[selectedSamples])
sxq = xq[selectedGenes, selectedSamples]
groups = c("E3.25", "E3.5 (PE)", "E4.5 (PE)")
sxq$fsampleGroup = factor(sxq$sampleGroup, levels = groups)
stopifnot(!any(is.na(sxq$fsampleGroup)))


###################################################
### code chunk number 131: fighm3
###################################################
myHeatmap3(sxq)


###################################################
### code chunk number 132: discr
###################################################
groupmedians = t(apply(exprs(sxq), 1, function(v) tapply(v, sxq$sampleGroup, median)))
stopifnot(identical(colnames(groupmedians), groups), length(groups)==3)
discrthreshs = (groupmedians[, 2:3] + groupmedians[, 1:2]) / 2
stst = sapply(split(seq(along = sxq$sampleGroup), sxq$sampleGroup), 
    function(v) {i1 = head(v,1); i2 = tail(v,1); stopifnot(identical(v, i1:i2)); c(i1,i2)})


###################################################
### code chunk number 133: show
###################################################
groupmedians
discrthreshs


###################################################
### code chunk number 134: figthr
###################################################
op = par(mfrow = c(nrow(sxq), 1), mai = c(0.1, 0.7, 0.01, 0.01))
for(j in seq_len(nrow(sxq))) {
  plot(exprs(sxq)[j, ], type = "n", xaxt = "n", ylab = fData(sxq)$symbol[j])
  segments(x0 = stst[1, ], x1 = stst[2, ], y0 = groupmedians[j, ], col = "#808080", lty=3)
  segments(x0 = stst[1,1:2], x1 = stst[2,2:3], y0 = discrthreshs[j, ], col = "#404040")
  points(exprs(sxq)[j, ], pch = 16, col = sxq$sampleColour)
}
par(op)


###################################################
### code chunk number 135: discretisation1
###################################################
discretize = function(x) {
  exprs(x) = t(sapply(seq_len(nrow(exprs(x))), function(r) {
      as.integer(cut(exprs(x)[r, ], breaks = c(-Inf, discrthreshs[r, ],+Inf)))
  }))
  return(x)
}


###################################################
### code chunk number 136: discretisation2
###################################################
sxqd = discretize(sxq)


###################################################
### code chunk number 137: fighmd
###################################################
myHeatmap3(sxqd, log = FALSE, Colv = FALSE, Rowv = FALSE, key = FALSE, ncol = 3)


###################################################
### code chunk number 138: bruteForceOptimisation1
###################################################
stopifnot(all(exprs(sxqd)%in%(1:3)))

costfun1 = function(x, sg) {
  k = (sg=="E3.5 (PE)")
  mean( (x[-1,k]==1) & (x[-nrow(x),k]>1 ) )
}
costfun2 = function(x, sg) {
  k = (sg=="E4.5 (PE)")
  mean( (x[-1,k]<3 ) & (x[-nrow(x),k]==3) )
}

perms = permutations(nrow(sxq), nrow(sxq))
bruteForceOptimisation = function(fun, samps) {
  if (missing(samps)) samps = rep(TRUE, ncol(sxqd))
  apply(perms, 1, function(i) fun(exprs(sxqd)[i, samps], sxq$sampleGroup[samps]))
}

costs = list(
 `E3.25 -> E3.5` = bruteForceOptimisation(costfun1),
  `E3.5 -> E4.5` = bruteForceOptimisation(costfun2))
whopt  = lapply(costs, function(v) which(v==min(v)))


###################################################
### code chunk number 139: fighmd
###################################################
outf = file("fighmd.tex", open="w")
for(i in seq(along = costs)) {
  sxqdsub = switch(i,
     { 
       rv = sxqd[, sxqd$sampleGroup %in% groups[2] ]
       exprs(rv)[ exprs(rv)>2 ] = 2
       rv
     }, {
       rv = sxqd[, sxqd$sampleGroup %in% groups[3] ]
       exprs(rv)[ exprs(rv)<2 ] = 2
       exprs(rv) = exprs(rv)-1
       rv
     })
  columnOrder = order(sxqdsub$sampleGroup, colSums(exprs(sxqdsub)))
  for(w in whopt[[i]]) {
    fn = sprintf("fighmd-%d-%d.pdf", i, w)
    pdf(fn, width = 7, height = 3)
    myHeatmap3(sxqdsub[perms[w, ], columnOrder], log = FALSE, Colv = FALSE, Rowv = FALSE,
               key = FALSE, ncol = 2, breaks = seq(0.5, 2.5, by = 1))
    dev.off()
    cat("\\includegraphics[width=0.49\\textwidth]{", fn, "}\n", file = outf, sep = "")
  }
}
close(outf)


###################################################
### code chunk number 140: printcosts
###################################################
for(i in seq(along = costs)) {
  k = unique(costs[[i]][whopt[[i]]])
  stopifnot(length(k)==1)
  cat(sprintf("%14s: cost %g\n", names(costs)[[i]], k))
}


###################################################
### code chunk number 141: boot-takes-a-long-time
###################################################
bopt = lapply(list(costfun1, costfun2), function(fun) {
  boot(data = seq_len(ncol(sxqd)), 
       statistic = function(dummy, idx) min(bruteForceOptimisation(fun, idx)),
       R = 250) 
})


###################################################
### code chunk number 142: figboot
###################################################
names(bopt) = names(costs)
lapply(bopt, `[[`, "t0")
multiecdf(lapply(bopt, `[[`, "t"))
t.test(x = bopt[[1]]$t, y = bopt[[2]]$t)


###################################################
### code chunk number 143: mdsplot
###################################################
data("xql")

labeledSampleColourMap = c(RColorBrewer::brewer.pal(5, "RdGy")[c(1,2)], RColorBrewer::brewer.pal(5, "BrBG")[c(4,5)])
names(labeledSampleColourMap) = c("E4.5_high", "E3.5_high", "E3.5_low",  "E4.5_low")
labeledGroups = with(pData(xql), list(
  `E3.5_high` = which(Label=="High" & Embryonic.day=="E3.5"),
  `E3.5_low`  = which(Label=="Low"  & Embryonic.day=="E3.5"),
  `E4.5_high`	= which(Label=="High" & Embryonic.day=="E4.5"),
  `E4.5_low`  = which(Label=="Low"  & Embryonic.day=="E4.5")))

labeledSampleColours = rep(NA_character_, ncol(xql))
for(i in seq(along = labeledGroups))
 labeledSampleColours[labeledGroups[[i]]] = labeledSampleColourMap[names(labeledGroups)[i]]
xql$sampleColours = labeledSampleColours

md = MASS::isoMDS(dist(t(log(exprs(xql),2))))$points
plot(md, col = xql$sampleColours, pch = 16, asp = 1, xlab = "",ylab = "")


###################################################
### code chunk number 144: figure5b
###################################################
xs = x[, (x$genotype %in% "WT") & (x$Embryonic.day %in% c("E3.25","E3.5","E4.5"))]

Fgf3 = c("1441914_x_at")
Fgf4 = c("1420086_x_at")
Fgfr2 = c("1433489_s_at")
Fgfr3 = c("1421841_at")
Fgfr4 = c("1418596_at")

correlationPlot = function(ID){
  xsl = xs[ID, ]
  mat = exprs(xsl)
  rownames(mat) = fData(xsl)[, "symbol"]
  plot(t(mat), pch = 16, asp = 1, cex = 1.25, cex.lab = 1.2, col = xs$sampleColour,
       xlim = c(2,12), ylim = c(3,11))
}

par(mfrow = c(1,4))
correlationPlot(c(Fgf4,Fgfr2))
correlationPlot(c(Fgf4,Fgfr3))
correlationPlot(c(Fgf3,Fgfr3))
correlationPlot(c(Fgf3,Fgfr4))


###################################################
### code chunk number 145: sessionInfo
###################################################
toLatex(sessionInfo())


