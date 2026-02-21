# Code example from 'v2_running_SIMLR' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(igraph)
library(SIMLR)

## -----------------------------------------------------------------------------
set.seed(11111)
data(BuettnerFlorian)
example = SIMLR(X = BuettnerFlorian$in_X, c = BuettnerFlorian$n_clust, cores.ratio = 0)

## -----------------------------------------------------------------------------
nmi_1 = compare(BuettnerFlorian$true_labs[,1], example$y$cluster, method="nmi")
print(nmi_1)

## ----fig.width=12, fig.height=8, warning=FALSE, fig.cap="Visualization of the 3 cell populations retrieved by SIMLR on the dataset by Florian, et al."----
plot(example$ydata, 
    col = c(topo.colors(BuettnerFlorian$n_clust))[BuettnerFlorian$true_labs[,1]], 
    xlab = "SIMLR component 1",
    ylab = "SIMLR component 2",
    pch = 20,
    main="SIMILR 2D visualization for BuettnerFlorian")

## -----------------------------------------------------------------------------
set.seed(11111)
ranks = SIMLR_Feature_Ranking(A=BuettnerFlorian$results$S,X=BuettnerFlorian$in_X)
head(ranks$pval)
head(ranks$aggR)

## -----------------------------------------------------------------------------
set.seed(11111)
data(ZeiselAmit)
example_large_scale = SIMLR_Large_Scale(X = ZeiselAmit$in_X, c = ZeiselAmit$n_clust, kk = 10)

## -----------------------------------------------------------------------------
nmi_2 = compare(ZeiselAmit$true_labs[,1], example_large_scale$y$cluster, method="nmi")
print(nmi_2)

## ----fig.width=12, fig.height=8, warning=FALSE, fig.cap="Visualization of the 9 cell populations retrieved by SIMLR large scale on the dataset by Zeisel, Amit, et al."----
plot(example_large_scale$ydata, 
    col = c(topo.colors(ZeiselAmit$n_clust))[ZeiselAmit$true_labs[,1]], 
    xlab = "SIMLR component 1",
    ylab = "SIMLR component 2",
    pch = 20,
    main="SIMILR 2D visualization for ZeiselAmit")

## -----------------------------------------------------------------------------
set.seed(53900)
NUMC = 2:5
res_example = SIMLR_Estimate_Number_of_Clusters(BuettnerFlorian$in_X,
    NUMC = NUMC,
    cores.ratio = 0)

## -----------------------------------------------------------------------------
NUMC[which.min(res_example$K1)]

## -----------------------------------------------------------------------------
NUMC[which.min(res_example$K2)]

## -----------------------------------------------------------------------------
res_example

