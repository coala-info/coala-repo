# Code example from 'qubic_vignette' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
options(width=98)

## ----comment=NA, message=FALSE------------------------------------------------------------------
citation("QUBIC")

## ----message=FALSE------------------------------------------------------------------------------
library("QUBIC")

## ----random, cahce = TRUE, message = FALSE, fig.cap = 'Heatmap for two overlapped biclusters in the simulated matrix'----
library(QUBIC)
set.seed(1)
# Create a random matrix
test <- matrix(rnorm(10000), 100, 100)
colnames(test) <- paste("cond", 1:100, sep = "_")
rownames(test) <- paste("gene", 1:100, sep = "_")

# Discretization
matrix1 <- test[1:7, 1:4]
matrix1

matrix2 <- qudiscretize(matrix1)
matrix2

# Fill bicluster blocks
t1 <- runif(10, 0.8, 1)
t2 <- runif(10, 0.8, 1) * (-1)
t3 <- runif(10, 0.8, 1) * sample(c(-1, 1), 10, replace = TRUE)
test[11:20, 11:20] <- t(rep(t1, 10) * rnorm(100, 3, 0.3))
test[31:40, 31:40] <- t(rep(t2, 10) * rnorm(100, 3, 0.3))
test[51:60, 51:60] <- t(rep(t3, 10) * rnorm(100, 3, 0.3))

# QUBIC
res <- biclust::biclust(test, method = BCQU())
summary(res)

# Show heatmap
hmcols <- colorRampPalette(rev(c("#D73027", "#FC8D59", "#FEE090", "#FFFFBF", 
    "#E0F3F8", "#91BFDB", "#4575B4")))(100)
# Specify colors

par(mar = c(4, 5, 3, 5) + 0.1)
quheatmap(test, res, number = c(1, 3), col = hmcols, showlabel = TRUE)


## ----yeast, cache = TRUE------------------------------------------------------------------------
library(QUBIC)
data(BicatYeast)

# Discretization
matrix1 <- BicatYeast[1:7, 1:4]
matrix1

matrix2 <- qudiscretize(matrix1)
matrix2

# QUBIC
x <- BicatYeast
system.time(res <- biclust::biclust(x, method = BCQU()))

summary(res)

## ----yeast-heatmap, cache = TRUE, message = FALSE, fig.cap = 'Heatmap for the second bicluster identified in the *Saccharomyces cerevisiae* data. The bicluster consists of 53 genes and 5 conditions', fig.show = 'asis'----

# Draw heatmap for the second bicluster identified in Saccharomyces cerevisiae data

library(RColorBrewer)
paleta <- colorRampPalette(rev(brewer.pal(11, "RdYlBu")))(11)
par(mar = c(5, 4, 3, 5) + 0.1, mgp = c(0, 1, 0), cex.lab = 1.1, cex.axis = 0.5, 
    cex.main = 1.1)
quheatmap(x, res, number = 2, showlabel = TRUE, col = paleta)


## ----yeast-heatmap2, cache = TRUE, message = FALSE, fig.cap = 'Heatmap for the second and third biclusters identified in the *Saccharomyces cerevisiae* data. Bicluster #2 (topleft) consists of 53 genes and 5 conditions, and bicluster #3 (bottom right) consists of 37 genes and 7 conditions.', fig.show = 'asis'----

# Draw for the second and third biclusters identified in Saccharomyces cerevisiae data

par(mar = c(5, 5, 5, 5), cex.lab = 1.1, cex.axis = 0.5, cex.main = 1.1)
paleta <- colorRampPalette(rev(brewer.pal(11, "RdYlBu")))(11)
quheatmap(x, res, number = c(2, 3), showlabel = TRUE, col = paleta)


## ----yeast-network1, cache = TRUE, message = FALSE, fig.cap = 'Network for the second bicluster identified in the *Saccharomyces cerevisiae* data.', fig.show = 'asis'----

# Construct the network for the second identified bicluster in Saccharomyces cerevisiae
net <- qunetwork(x, res, number = 2, group = 2, method = "spearman")
if (requireNamespace("qgraph", quietly = TRUE))
    qgraph::qgraph(net[[1]], groups = net[[2]], layout = "spring", minimum = 0.6, 
        color = cbind(rainbow(length(net[[2]]) -  1), "gray"), edge.label = FALSE)


## ----yeast-network2, cache = TRUE, message = FALSE, fig.cap = 'Network for the second and third biclusters identified in the *Saccharomyces cerevisiae* data.', fig.show = 'asis'----

net <- qunetwork(x, res, number = c(2, 3), group = c(2, 3), method = "spearman")
if (requireNamespace("qgraph", quietly = TRUE))
    qgraph::qgraph(net[[1]], groups = net[[2]], layout = "spring", minimum = 0.6, 
        legend.cex = 0.5, color = c("red", "blue", "gold", "gray"), edge.label = FALSE)


## ----ecoli, cache = TRUE------------------------------------------------------------------------
library(QUBIC)
library(QUBICdata)
data("ecoli", package = "QUBICdata")

# Discretization
matrix1 <- ecoli[1:7, 1:4]
matrix1

matrix2 <- qudiscretize(matrix1)
matrix2

# QUBIC
res <- biclust::biclust(ecoli, method = BCQU(), r = 1, q = 0.06, c = 0.95, o = 100, 
    f = 0.25, k = max(ncol(ecoli)%/%20, 2))
system.time(res <- biclust::biclust(ecoli, method = BCQU(), r = 1, q = 0.06, c = 0.95, 
    o = 100, f = 0.25, k = max(ncol(ecoli)%/%20, 2)))
summary(res)


## ----ecoli-heatmap, cache = TRUE, message = FALSE, fig.cap = 'Heatmap for the fifth bicluster identified in the *Escherichia coli* data. The bicluster consists of 103 genes and 38 conditions', fig.show = 'asis'----

# Draw heatmap for the 5th bicluster identified in Escherichia coli data

library(RColorBrewer)
paleta <- colorRampPalette(rev(brewer.pal(11, "RdYlBu")))(11)
par(mar = c(5, 4, 3, 5) + 0.1, mgp = c(0, 1, 0), cex.lab = 1.1, cex.axis = 0.5, 
    cex.main = 1.1)
quheatmap(ecoli, res, number = 5, showlabel = TRUE, col = paleta)


## ----ecoli-heatmap2, cache = TRUE, message = FALSE, fig.cap = 'Heatmap for the fourth and eighth biclusters identified in the *Escherichia coli* data. Bicluster #4 (topleft) consists of 108 genes and 44 conditions, and bicluster #8 (bottom right) consists of 26 genes and 33 conditions', fig.show = 'asis'----

library(RColorBrewer)
paleta <- colorRampPalette(rev(brewer.pal(11, "RdYlBu")))(11)
par(mar = c(5, 4, 3, 5), cex.lab = 1.1, cex.axis = 0.5, cex.main = 1.1)
quheatmap(ecoli, res, number = c(4, 8), showlabel = TRUE, col = paleta)


## ----ecoli-network, cache = TRUE, message = FALSE, fig.cap = 'Network for the fifth bicluster identified in the *Escherichia coli* data.', fig.show = 'asis'----

# construct the network for the 5th identified bicluster in Escherichia coli data
net <- qunetwork(ecoli, res, number = 5, group = 5, method = "spearman")
if (requireNamespace("qgraph", quietly = TRUE))
    qgraph::qgraph(net[[1]], groups = net[[2]], layout = "spring", minimum = 0.6, 
        color = cbind(rainbow(length(net[[2]]) - 1), "gray"), edge.label = FALSE)



## ----ecoli-network2, cache = TRUE, message = FALSE, fig.cap = 'Network for the fourth and eighth biclusters identified in the *Escherichia coli* data.', fig.show = 'asis'----

# construct the network for the 4th and 8th identified bicluster in Escherichia coli data
net <- qunetwork(ecoli, res, number = c(4, 8), group = c(4, 8), method = "spearman")
if (requireNamespace("qgraph", quietly = TRUE))
    qgraph::qgraph(net[[1]], groups = net[[2]], legend.cex = 0.5, layout = "spring", 
        minimum = 0.6, color = c("red", "blue", "gold", "gray"), edge.label = FALSE)


## ----query-based-biclustering, cache = TRUE, message = FALSE------------------------------------
library(QUBIC)
library(QUBICdata)
data("ecoli", package = "QUBICdata")
data("ecoli.weight", package = "QUBICdata")
res0 <- biclust(ecoli, method = BCQU(), verbose = FALSE)
res0
res4 <- biclust(ecoli, method = BCQU(), weight = ecoli.weight, verbose = FALSE)
res4

## ----bicluster-expanding, cache = TRUE----------------------------------------------------------
res5 <- biclust(x = ecoli, method = BCQU(), seedbicluster = res, f = 0.25, verbose = FALSE)
summary(res5)

## ----biclusters-comparison, cache = TRUE--------------------------------------------------------
test <- ecoli[1:50,]
res6 <- biclust(test, method = BCQU(), verbose = FALSE)
res7 <- biclust (test, method = BCCC())
res8 <- biclust(test, method = BCBimax())
showinfo (test, c(res6, res7, res8))

