# Visualisation of proteomics data using R and Bioconductor

Laurent Gatto, Lisa Breckels and Sebastian Gibb

#### 4 November 2025

#### Abstract

This is the companion vignette to the ‘Using R and Bioconductor for proteomics data analysis’ manuscript that presents an overview of R and Bioconductor software for mass spectrometry and proteomics data. It provides the code to reproduce the figures in the paper.

#### Package

RforProteomics 1.48.0

# 1 Note

For a more **up-to-date overview** of what is available for mass
spectrometry-based proteomics in R, please see the [*R for Mass
Spectrometry* initiative](https://www.rformassspectrometry.org/) in
general, and the [book](https://rformassspectrometry.github.io/book/)
in particular.

# 2 Introduction

This vignette illustrates existing R and Bioconductor
infrastructure for the visualisation of mass spectrometry and
proteomics data. The code details the visualisations presented in

> Gatto L, Breckels LM, Naake T, Gibb S. Visualisation of proteomics
> data using R and Bioconductor. Proteomics. 2015 Feb 18. doi:
> 10.1002/pmic.201400392. PubMed PMID:
> [25690415](http://www.ncbi.nlm.nih.gov/pubmed/25690415).

> **NB**: I you are interested in R packages for mass
> spectrometry-based proteomics and metabolomics, see also the [R for
> Mass Spectrometry initiative](https://www.rformassspectrometry.org/)
> packages and the [tutorial
> book](https://rformassspectrometry.github.io/docs/)

## 2.1 References

* CRAN Task View: Graphic Displays & Dynamic Graphics & Graphic
  Devices & Visualization:
  <http://cran.r-project.org/web/views/Graphics.html>
* CRAN Task View: Web Technologies and Services:
  <http://cran.r-project.org/web/views/WebTechnologies.html>
* ggplot2
  [book](http://link.springer.com/book/10.1007/978-0-387-98141-3)
  (syntax is slightly outdated) ([code](http://ggplot2.org/book/)),
  [web page](http://ggplot2.org/) and
  [on-line docs](http://docs.ggplot2.org/current/)
* lattice
  [book](http://lmdvr.r-forge.r-project.org/figures/figures.html) and
  [web page](http://lattice.r-forge.r-project.org/)
* *R Graphics* [book](https://www.stat.auckland.ac.nz/~paul/RG2e/)
* [R Cookbook](http://www.cookbook-r.com/Graphs/) and
  [R Graphics Cookbook](http://shop.oreilly.com/product/0636920023135.do)

## 2.2 Relevant packages

There are currently 187
[Proteomics](http://bioconductor.org/packages/devel/BiocViews.html#___Proteomics) and
147
[MassSpectrometry](http://bioconductor.org/packages/devel/BiocViews.html#___MassSpectrometry) packages
in Bioconductor version 3.22. Other
non-Bioconductor packages are described in the `r Biocexptpkg("RforProteomics")` vignette (open it in R with
`RforProteomics()` or read
it
[online](file:///home/lg390/dev/00_github/RforProteomics/docs/articles/RforProteomics.html).)

# 3 Ascombe’s quartet

| x1 | x2 | x3 | x4 | y1 | y2 | y3 | y4 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 10 | 10 | 10 | 8 | 8.04 | 9.14 | 7.46 | 6.58 |
| 8 | 8 | 8 | 8 | 6.95 | 8.14 | 6.77 | 5.76 |
| 13 | 13 | 13 | 8 | 7.58 | 8.74 | 12.74 | 7.71 |
| 9 | 9 | 9 | 8 | 8.81 | 8.77 | 7.11 | 8.84 |
| 11 | 11 | 11 | 8 | 8.33 | 9.26 | 7.81 | 8.47 |
| 14 | 14 | 14 | 8 | 9.96 | 8.10 | 8.84 | 7.04 |
| 6 | 6 | 6 | 8 | 7.24 | 6.13 | 6.08 | 5.25 |
| 4 | 4 | 4 | 19 | 4.26 | 3.10 | 5.39 | 12.50 |
| 12 | 12 | 12 | 8 | 10.84 | 9.13 | 8.15 | 5.56 |
| 7 | 7 | 7 | 8 | 4.82 | 7.26 | 6.42 | 7.91 |
| 5 | 5 | 5 | 8 | 5.68 | 4.74 | 5.73 | 6.89 |

```
tab <- matrix(NA, 5, 4)
colnames(tab) <- 1:4
rownames(tab) <- c("var(x)", "mean(x)",
                   "var(y)", "mean(y)",
                   "cor(x,y)")

for (i in 1:4)
    tab[, i] <- c(var(anscombe[, i]),
                  mean(anscombe[, i]),
                  var(anscombe[, i+4]),
                  mean(anscombe[, i+4]),
                  cor(anscombe[, i], anscombe[, i+4]))
```

|  | 1 | 2 | 3 | 4 |
| --- | --- | --- | --- | --- |
| var(x) | 11.0000000 | 11.0000000 | 11.0000000 | 11.0000000 |
| mean(x) | 9.0000000 | 9.0000000 | 9.0000000 | 9.0000000 |
| var(y) | 4.1272691 | 4.1276291 | 4.1226200 | 4.1232491 |
| mean(y) | 7.5009091 | 7.5009091 | 7.5000000 | 7.5009091 |
| cor(x,y) | 0.8164205 | 0.8162365 | 0.8162867 | 0.8165214 |

While the residuals of the linear regression clearly indicate
fundamental differences in these data, the most simple and
straightforward approach is visualisation to highlight the fundamental
differences in the datasets.

```
ff <- y ~ x

mods <- setNames(as.list(1:4), paste0("lm", 1:4))

par(mfrow = c(2, 2), mar = c(4, 4, 1, 1))
for (i in 1:4) {
    ff[2:3] <- lapply(paste0(c("y","x"), i), as.name)
    plot(ff, data = anscombe, pch = 19, xlim = c(3, 19), ylim = c(3, 13))
    mods[[i]] <- lm(ff, data = anscombe)
    abline(mods[[i]])
}
```

![](data:image/png;base64...)

| lm1 | lm2 | lm3 | lm4 |
| --- | --- | --- | --- |
| 0.0390000 | 1.1390909 | -0.5397273 | -0.421 |
| -0.0508182 | 1.1390909 | -0.2302727 | -1.241 |
| -1.9212727 | -0.7609091 | 3.2410909 | 0.709 |
| 1.3090909 | 1.2690909 | -0.3900000 | 1.839 |
| -0.1710909 | 0.7590909 | -0.6894545 | 1.469 |
| -0.0413636 | -1.9009091 | -1.1586364 | 0.039 |
| 1.2393636 | 0.1290909 | 0.0791818 | -1.751 |
| -0.7404545 | -1.9009091 | 0.3886364 | 0.000 |
| 1.8388182 | 0.1290909 | -0.8491818 | -1.441 |
| -1.6807273 | 0.7590909 | -0.0805455 | 0.909 |
| 0.1794545 | -0.7609091 | 0.2289091 | -0.111 |

# 4 The MA plot example

The following code chunk connects to the `PXD000001` data set on the
ProteomeXchange repository and fetches the `mzTab` file. After missing
values filtering, we extract relevant data (log2 fold-changes and
log10 mean expression intensities) into `data.frames`.

```
library("rpx")
px1 <- PXDataset("PXD000001")
```

```
## Loading PXD000001 from cache.
```

```
mztab <- pxget(px1, "F063721.dat-mztab.txt")
```

```
## Loading F063721.dat-mztab.txt from cache.
```

```
library("MSnbase")
## here, we need to specify the (old) mzTab version 0.9
qnt <- readMzTabData(mztab, what = "PEP", version = "0.9")
sampleNames(qnt) <- reporterNames(TMT6)
qnt <- filterNA(qnt)
## may be combineFeatuers

spikes <- c("P02769", "P00924", "P62894", "P00489")
protclasses <- as.character(fData(qnt)$accession)
protclasses[!protclasses %in% spikes] <- "Background"

madata42 <- data.frame(A = rowMeans(log(exprs(qnt[, c(4, 2)]), 10)),
                       M = log(exprs(qnt)[, 4], 2) - log(exprs(qnt)[, 2], 2),
                       data = rep("4vs2", nrow(qnt)),
                       protein = fData(qnt)$accession,
                       class = factor(protclasses))

madata62 <- data.frame(A = rowMeans(log(exprs(qnt[, c(6, 2)]), 10)),
                       M = log(exprs(qnt)[, 6], 2) - log(exprs(qnt)[, 2], 2),
                       data = rep("6vs2", nrow(qnt)),
                       protein = fData(qnt)$accession,
                       class = factor(protclasses))

madata <- rbind(madata42, madata62)
```

## 4.1 The traditional plotting system

```
par(mfrow = c(1, 2))
plot(M ~ A, data = madata42, main = "4vs2",
     xlab = "A", ylab = "M", col = madata62$class)
plot(M ~ A, data = madata62, main = "6vs2",
     xlab = "A", ylab = "M", col = madata62$class)
```

![](data:image/png;base64...)

## 4.2 lattice

```
library("lattice")
latma <- xyplot(M ~ A | data, data = madata,
                groups = madata$class,
                auto.key = TRUE)
print(latma)
```

![](data:image/png;base64...)

## 4.3 ggplot2

```
library("ggplot2")
```

```
##
## Attaching package: 'ggplot2'
```

```
## The following object is masked from 'package:e1071':
##
##     element
```

```
ggma <- ggplot(aes(x = A, y = M, colour = class), data = madata,
               colour = class) +
    geom_point() +
    facet_grid(. ~ data)
```

```
## Warning in fortify(data, ...): Arguments in `...` must be used.
## ✖ Problematic argument:
## • colour = class
## ℹ Did you misspell an argument name?
```

```
print(ggma)
```

![](data:image/png;base64...)

## 4.4 Customization

```
library("RColorBrewer")
bcols <- brewer.pal(4, "Set1")
cls <- c("Background" = "#12121230",
         "P02769" = bcols[1],
         "P00924" = bcols[2],
         "P62894" = bcols[3],
         "P00489" = bcols[4])
```

```
ggma2 <- ggplot(aes(x = A, y = M, colour = class),
                data = madata) + geom_point(shape = 19) +
    facet_grid(. ~ data) + scale_colour_manual(values = cls) +
    guides(colour = guide_legend(override.aes = list(alpha = 1)))
print(ggma2)
```

![](data:image/png;base64...)

## 4.5 The `MAplot` method for `MSnSet` instances

```
MAplot(qnt, cex = .8)
```

![](data:image/png;base64...)

## 4.6 An interactive *[shiny](https://CRAN.R-project.org/package%3Dshiny)* app for MA plots

This (now outdated and deprecated) app is based on Mike Love’s
[shinyMA](https://github.com/mikelove/shinyMA) application, adapted
for a proteomics data. A screen shot is displayed below.

See the excellent *[shiny](https://CRAN.R-project.org/package%3Dshiny)* [web
page](http://shiny.rstudio.com/) for tutorials and the [Mastering
Shiny](https://mastering-shiny.org/) book for details on `shiny`.

## 4.7 Volcano plots

Below, using the *[msmsTest](https://bioconductor.org/packages/3.22/msmsTest)* package, we load a example
`MSnSet` data with spectral couting data (from the `r Biocpkg("msmsEDA")` package) and run a statistical test to obtain
(adjusted) p-values and fold-changes.

```
library("msmsEDA")
library("msmsTests")
data(msms.dataset)
## Pre-process expression matrix
e <- pp.msms.data(msms.dataset)
## Models and normalizing condition
null.f <- "y~batch"
alt.f <- "y~treat+batch"
div <- apply(exprs(e), 2, sum)
## Test
res <- msms.glm.qlll(e, alt.f, null.f, div = div)
lst <- test.results(res, e, pData(e)$treat, "U600", "U200 ", div,
                    alpha = 0.05, minSpC = 2, minLFC = log2(1.8),
                    method = "BH")
```

Here, we produce the volcano plot by hand, with the `plot`
function. In the second plot, we limit the x axis limits and add grid
lines.

```
plot(lst$tres$LogFC, -log10(lst$tres$p.value))
```

![](data:image/png;base64...)

```
plot(lst$tres$LogFC, -log10(lst$tres$p.value),
     xlim = c(-3, 3))
grid()
```

![](data:image/png;base64...)

Below, we use the `res.volcanoplot` function from the `r Biocpkg("msmsTests")` package. This functions uses the sample
annotation stored with the quantitative data in the `MSnSet` object to
colour the samples according to their phenotypes.

```
## Plot
res.volcanoplot(lst$tres,
                max.pval = 0.05,
                min.LFC = 1,
                maxx = 3,
                maxy = NULL,
                ylbls = 4)
```

![](data:image/png;base64...)

## 4.8 A PCA plot

Using the `counts.pca` function from the *[msmsEDA](https://bioconductor.org/packages/3.22/msmsEDA)*
package:

```
library("msmsEDA")
data(msms.dataset)
msnset <- pp.msms.data(msms.dataset)
lst <- counts.pca(msnset, wait = FALSE)
```

![](data:image/png;base64...)![](data:image/png;base64...)

It is also possible to generate the PCA data using the
`prcomp`. Below, we extract the coordinates of PC1 and PC2 from the
`counts.pca` result and plot them using the `plot` function.

```
pcadata <- lst$pca$x[, 1:2]
head(pcadata)
```

```
##                  PC1       PC2
## U2.2502.1 -120.26080 -53.55270
## U2.2502.2  -99.90618 -53.89979
## U2.2502.3 -127.35928 -49.29906
## U2.2502.4 -166.04611 -39.27557
## U6.2502.1 -127.18423  37.11614
## U6.2502.2 -117.97016  47.03702
```

```
plot(pcadata[, 1], pcadata[, 2],
     xlab = "PCA1", ylab = "PCA2")
grid()
```

![](data:image/png;base64...)

# 5 Plotting with R

```
kable(plotfuns)
```

| plot type | traditional | lattice | ggplot2 |
| --- | --- | --- | --- |
| scatterplots | plot | xyplot | geom\_point |
| histograms | hist | histgram | geom\_histogram |
| density plots | plot(density()) | densityplot | geom\_density |
| boxplots | boxplot | bwplot | geom\_boxplot |
| violin plots | vioplot::vioplot | bwplot(…, panel = panel.violin) | geom\_violin |
| line plots | plot, matplot | xyploy, parallelplot | geom\_line |
| bar plots | barplot | barchart | geom\_bar |
| pie charts | pie |  | geom\_bar with polar coordinates |
| dot plots | dotchart | dotplot | geom\_point |
| stip plots | stripchart | stripplot | goem\_point |
| dendrogramms | plot(hclust()) | latticeExtra package | ggdendro package |
| heatmaps | image, heatmap | levelplot | geom\_tile |

Below, we are going to use a data from the
*[pRolocdata](https://bioconductor.org/packages/3.22/pRolocdata)* to illustrate the plotting functions.

```
library("pRolocdata")
data(tan2009r1)
```

## 5.1 Scatter plots

See the MA and volcano plot examples.

The default plot `type` is `p`, for points. Other important types are
`l` for lines and `h` for *histogram* (see below).

## 5.2 Historams and density plots

We extract the (normalised) intensities of the first sample

```
x <- exprs(tan2009r1)[, 1]
```

and plot the distribution with a histogram and a density plot next to
each other on the same figure (using the `mfrow` `par` plotting
paramter)

```
par(mfrow = c(1, 2))
hist(x)
plot(density(x))
```

![](data:image/png;base64...)

## 5.3 Box plots and violin plots

we first extract the 888 proteins by `r ncol(tan2009r1)` samples data matrix and plot the sample distributions
next to each other using `boxplot` and `beanplot` (from the
*[beanplot](https://CRAN.R-project.org/package%3Dbeanplot)* package).

```
library("beanplot")
x <- exprs(tan2009r1)
par(mfrow = c(2, 1))
boxplot(x)
beanplot(x[, 1], x[, 2], x[, 3], x[, 4], log = "")
```

![](data:image/png;base64...)

## 5.4 Line plots

below, we produce line plots that describe the protein quantitative
profiles for two sets of proteins, namely er and mitochondrial
proteins using `matplot`.

we need to transpose the matrix (with `t`) and set the type to both
(`b`), to display points and lines, the colours to red and steel blue,
the point characters to 1 (an empty point) and the line type to 1 (a
solid line).

```
er <- fData(tan2009r1)$markers == "ER"
mt <- fData(tan2009r1)$markers == "mitochondrion"

par(mfrow = c(2, 1))
matplot(t(x[er, ]), type = "b", col = "red", pch = 1, lty = 1)
matplot(t(x[mt, ]), type = "b", col = "steelblue", pch = 1, lty = 1)
```

![](data:image/png;base64...)

In the last section, about spatial proteomics, we use the specialised
`plotDist` function from the *[pRoloc](https://bioconductor.org/packages/3.22/pRoloc)* package to generate
such figures.

## 5.5 Bar and dot charts

To illustrate bar and dot charts, we cound the number of proteins in
the respective class using table.

```
x <- table(fData(tan2009r1)$markers)
x
```

```
##
##  Cytoskeleton            ER         Golgi      Lysosome       Nucleus
##             7            28            13             8            21
##            PM    Peroxisome    Proteasome  Ribosome 40S  Ribosome 60S
##            34             4            15            20            32
## mitochondrion       unknown
##            29           677
```

```
par(mfrow = c(1, 2))
barplot(x)
dotchart(as.numeric(x))
```

![](data:image/png;base64...)

## 5.6 Heatmaps

The easiest to produce a complete heatmap is with the `heatmap`
function:

```
heatmap(exprs(tan2009r1))
```

![](data:image/png;base64...)

To produce the a heatmap without the dendrograms, one can use the
image function on a matrix or the specialised version for `MSnSet`
objects from the *[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* package.

```
par(mfrow = c(1, 2))
x <- matrix(1:9, ncol = 3)
image(x)
image(tan2009r1)
```

![](data:image/png;base64...)

See also *[gplots](https://CRAN.R-project.org/package%3Dgplots)*’s `heatmap.2` function and the
*[Heatplus](https://bioconductor.org/packages/3.22/Heatplus)* Bioconductor package for more advanced heatmaps
and the *[corrplot](https://CRAN.R-project.org/package%3Dcorrplot)* package for correlation matrices.

## 5.7 Dendrograms

The easiest way to produce and plot a dendrogram is:

```
d <- dist(t(exprs(tan2009r1))) ## distance between samples
hc <- hclust(d) ## hierarchical clustering
plot(hc) ## visualisation
```

![](data:image/png;base64...)

See also *[dendextend](https://CRAN.R-project.org/package%3Ddendextend)* and this
[post](http://stackoverflow.com/questions/6673162/reproducing-lattice-dendrogram-graph-with-ggplot2)
to illustrate *[latticeExtra](https://CRAN.R-project.org/package%3DlatticeExtra)* and *[ggdendro](https://CRAN.R-project.org/package%3Dggdendro)*.

## 5.8 Venn diagrams

* The *[limma](https://bioconductor.org/packages/3.22/limma)* package.
* The *[VennDiagram](https://CRAN.R-project.org/package%3DVennDiagram)* package.

# 6 Visualising mass spectrometry data

## 6.1 Direct access to the raw data

```
library("mzR")
mzf <- pxget(px1,
             "TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzML")
```

```
## Loading TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzML from cache.
```

```
ms <- openMSfile(mzf)

hd <- header(ms)
ms1 <- which(hd$msLevel == 1)

rtsel <- hd$retentionTime[ms1] / 60 > 30 & hd$retentionTime[ms1] / 60 < 35
```

```
lout <- matrix(NA, ncol = 10, nrow = 8)
lout[1:2, ] <- 1
for (ii in 3:4)
    lout[ii, ] <- c(2, 2, 2, 2, 2, 2, 3, 3, 3, 3)
lout[5, ] <- rep(4:8, each = 2)
lout[6, ] <- rep(4:8, each = 2)
lout[7, ] <- rep(9:13, each = 2)
lout[8, ] <- rep(9:13, each = 2)
```

```
i <- ms1[which(rtsel)][1]
j <- ms1[which(rtsel)][2]
ms2 <- (i+1):(j-1)
```

```
layout(lout)
par(mar=c(4,2,1,1))
plot(chromatogram(ms)[[1]], type = "l")
abline(v = hd[i, "retentionTime"], col = "red")
par(mar = c(3, 2, 1, 0))
plot(peaks(ms, i), type = "l", xlim = c(400, 1000))
legend("topright", bty = "n",
       legend = paste0(
           "Acquisition ", hd[i, "acquisitionNum"],  "\n",
           "Retention time ", formatRt(hd[i, "retentionTime"])))
abline(h = 0)
abline(v = hd[ms2, "precursorMZ"],
       col = c("#FF000080",
           rep("#12121280", 9)))
par(mar = c(3, 0.5, 1, 1))
plot(peaks(ms, i), type = "l", xlim = c(521, 522.5), yaxt = "n")
abline(h = 0)
abline(v = hd[ms2, "precursorMZ"], col = "#FF000080")
par(mar = c(2, 2, 0, 1))
for (ii in ms2) {
    p <- peaks(ms, ii)
    plot(p, xlab = "", ylab = "", type = "h", cex.axis = .6)
    legend("topright",
           legend = paste0("Prec M/Z\n", round(hd[ii, "precursorMZ"], 2)),
           bty = "n", cex = .8)
}
```

![Accesing and plotting MS data.](data:image/png;base64...)

Figure 1: Accesing and plotting MS data

```
M2 <- MSmap(ms, i:j, 100, 1000, 1, hd)
plot3D(M2)
```

![](data:image/png;base64...)

### 6.1.1 MS barcoding

```
par(mar=c(4,1,1,1))
image(t(matrix(hd$msLevel, 1, nrow(hd))),
      xlab="Retention time",
      xaxt="n", yaxt="n", col=c("black","steelblue"))
k <- round(range(hd$retentionTime) / 60)
nk <- 5
axis(side=1, at=seq(0,1,1/nk), labels=seq(k[1],k[2],k[2]/nk))
```

![](data:image/png;base64...)

### 6.1.2 Animation

The following animation scrolls over 5 minutes of retention time for a
MZ range between 521 and 523.

```
library("animation")
an1 <- function() {
    for (i in seq(0, 5, 0.2)) {
        rtsel <- hd$retentionTime[ms1] / 60 > (30 + i) &
            hd$retentionTime[ms1] / 60 < (35 + i)
        M <- MSmap(ms, ms1[rtsel], 521, 523, .005, hd)
        M@map[msMap(M) == 0] <- NA
        print(plot3D(M, rgl = FALSE))
    }
}

saveGIF(an1(), movie.name = "msanim1.gif")
```

```
knitr::include_graphics("./figures/msanim1.gif")
```

![](data:image/gif;base64...)

The code chunk below scrolls of a slice of retention times while
keeping the retention time constant between 30 and 35 minutes.

```
an2 <- function() {
    for (i in seq(0, 2.5, 0.1)) {
        rtsel <- hd$retentionTime[ms1] / 60 > 30 & hd$retentionTime[ms1] / 60 < 35
        mz1 <- 520 + i
        mz2 <- 522 + i
        M <- MSmap(ms, ms1[rtsel], mz1, mz2, .005, hd)
        M@map[msMap(M) == 0] <- NA
        print(plot3D(M, rgl = FALSE))
    }
}

saveGIF(an2(), movie.name = "msanim2.gif")
```

```
knitr::include_graphics("./figures/msanim2.gif")
```

![](data:image/gif;base64...)

## 6.2 The *[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* infrastructure

```
library("MSnbase")
data(itraqdata)
itraqdata2 <- pickPeaks(itraqdata, verbose = FALSE)
plot(itraqdata[[25]], full = TRUE, reporters = iTRAQ4)
```

![](data:image/png;base64...)

```
par(oma = c(0, 0, 0, 0))
par(mar = c(4, 4, 1, 1))
plot(itraqdata2[[25]], itraqdata2[[28]], sequences = rep("IMIDLDGTENK", 2))
```

```
## Warning in FUN(X[[i]], ...): 'modifications' is deprecated, please use
## 'fixed_modifications' instead.
## Warning in FUN(X[[i]], ...): 'modifications' is deprecated, please use
## 'fixed_modifications' instead.
```

![](data:image/png;base64...)

## 6.3 The *[protViz](https://CRAN.R-project.org/package%3DprotViz)* package

```
library("protViz")
data(msms)

fi <- fragmentIon("TAFDEAIAELDTLNEESYK")
fi.cyz <- as.data.frame(cbind(c=fi[[1]]$c, y=fi[[1]]$y, z=fi[[1]]$z))

p <- peakplot("TAFDEAIAELDTLNEESYK",
              spec = msms[[1]],
              fi = fi.cyz,
              itol = 0.6,
              ion.axes = FALSE)
```

![](data:image/png;base64...)

The `peakplot` function return the annotation of the MSMS spectrum
that is plotted:

```
str(p)
```

```
## List of 7
##  $ mZ.Da.error : num [1:57] 215.3 144.27 -2.8 -17.06 2.03 ...
##  $ mZ.ppm.error: num [1:57] 1808046 758830 -8306 -37724 3501 ...
##  $ idx         : int [1:57] 1 1 1 3 16 24 41 52 67 88 ...
##  $ label       : chr [1:57] "c1" "c2" "c3" "c4" ...
##  $ score       : num -1
##  $ sequence    : chr "TAFDEAIAELDTLNEESYK"
##  $ fragmentIon :'data.frame':    19 obs. of  3 variables:
##   ..$ c: num [1:19] 119 190 337 452 581 ...
##   ..$ y: num [1:19] 147 310 397 526 655 ...
##   ..$ z: num [1:19] 130 293 380 509 638 ...
```

## 6.4 Preprocessing of MALDI-MS spectra

The following code chunks demonstrate the usage of the mass
spectrometry preprocessing and plotting routines in the `r CRANpkg("MALDIquant")` package. *[MALDIquant](https://CRAN.R-project.org/package%3DMALDIquant)* uses the
traditional graphics system. Therefore *[MALDIquant](https://CRAN.R-project.org/package%3DMALDIquant)*
overloads the traditional functions `plot`, `lines` and `points` for
its own data types. These data types represents spectrum and peak
lists as S4 classes. Please see the *[MALDIquant](https://CRAN.R-project.org/package%3DMALDIquant)*
[vignette](http://cran.r-project.org/web/packages/MALDIquant/vignettes/MALDIquant-intro.pdf)
and the corresponding
[website](http://strimmerlab.org/software/maldiquant/) for more
details.

After loading some example data a simple `plot` draws the raw spectrum.

```
library("MALDIquant")

data("fiedler2009subset", package="MALDIquant")

plot(fiedler2009subset[[14]])
```

![](data:image/png;base64...)

After some preprocessing, namely variance stabilization and smoothing, we use
`lines` to draw our baseline estimate in our processed spectrum.

```
transformedSpectra <- transformIntensity(fiedler2009subset, method = "sqrt")
smoothedSpectra <- smoothIntensity(transformedSpectra, method = "SavitzkyGolay")

plot(smoothedSpectra[[14]])
lines(estimateBaseline(smoothedSpectra[[14]]), lwd = 2, col = "red")
```

![](data:image/png;base64...)

After removing the background removal we could use `plot` again to draw our
baseline corrected spectrum.

```
rbSpectra <- removeBaseline(smoothedSpectra)
plot(rbSpectra[[14]])
```

![](data:image/png;base64...)

`detectPeaks` returns a `MassPeaks` object that offers the same traditional
graphics functions. The next code chunk demonstrates how to mark the detected
peaks in a spectrum.

```
cbSpectra <- calibrateIntensity(rbSpectra, method = "TIC")
peaks <- detectPeaks(cbSpectra, SNR = 5)

plot(cbSpectra[[14]])
points(peaks[[14]], col = "red", pch = 4, lwd = 2)
```

![](data:image/png;base64...)

Additional there is a special function `labelPeaks` that allows to draw the *M/Z*
values above the corresponding peaks. Next we mark the 5 top peaks in the
spectrum.

```
top5 <- intensity(peaks[[14]]) %in% sort(intensity(peaks[[14]]),
                                         decreasing = TRUE)[1:5]
labelPeaks(peaks[[14]], index = top5, avoidOverlap = TRUE)
```

![](data:image/png;base64...)

Often multiple spectra have to be recalibrated to be
comparable. Therefore *[MALDIquant](https://CRAN.R-project.org/package%3DMALDIquant)* warps the spectra
according to so called reference or landmark peaks. For debugging the
`determineWarpingFunctions` function offers some warping plots. Here
we show only the last 4 plots:

```
par(mfrow = c(2, 2))
warpingFunctions <-
    determineWarpingFunctions(peaks,
                              tolerance = 0.001,
                              plot = TRUE,
                              plotInteractive = TRUE)
```

![](data:image/png;base64...)

```
par(mfrow = c(1, 1))
warpedSpectra <- warpMassSpectra(cbSpectra, warpingFunctions)
warpedPeaks <- warpMassPeaks(peaks, warpingFunctions)
```

In the next code chunk we visualise the need and the effect of the
recalibration.

```
sel <- c(2, 10, 14, 16)
xlim <- c(4180, 4240)
ylim <- c(0, 1.9e-3)
lty <- c(1, 4, 2, 6)

par(mfrow = c(1, 2))
plot(cbSpectra[[1]], xlim = xlim, ylim = ylim, type = "n")

for (i in seq(along = sel)) {
  lines(peaks[[sel[i]]], lty = lty[i], col = i)
  lines(cbSpectra[[sel[i]]], lty = lty[i], col = i)
}

plot(cbSpectra[[1]], xlim = xlim, ylim = ylim, type = "n")

for (i in seq(along = sel)) {
  lines(warpedPeaks[[sel[i]]], lty = lty[i], col = i)
  lines(warpedSpectra[[sel[i]]], lty = lty[i], col = i)
}
```

![](data:image/png;base64...)

```
par(mfrow = c(1, 1))
```

The code chunks above generate plots that are very similar to the figure 7 in
the corresponding paper *“Visualisation of proteomics data using R”*. Please
find the code to exactly reproduce the figure at:
<https://github.com/sgibb/MALDIquantExamples/blob/master/R/createFigure1_color.R>

# 7 Genomic and protein sequences

These visualisations originate from the `Pbase`
[`Pbase-data`](http://bioconductor.org/packages/devel/bioc/vignettes/Pbase/inst/doc/Pbase-data.html)
and
[`mapping`](http://bioconductor.org/packages/devel/bioc/vignettes/Pbase/inst/doc/mapping.html) vignettes.

# 8 Mass spectrometry imaging

The following code chunk downloads a MALDI imaging dataset from a
mouse kidney shared by
[Adrien Nyakas and Stefan Schurch](http://figshare.com/articles/MALDI_Imaging_Mass_Spectrometry_of_a_Mouse_Kidney/735961)
and generates a plot with the mean spectrum and three slices of
interesting *M/Z* regions.

```
library("MALDIquant")
library("MALDIquantForeign")

spectra <- importBrukerFlex("http://files.figshare.com/1106682/MouseKidney_IMS_testdata.zip", verbose = FALSE)

spectra <- smoothIntensity(spectra, "SavitzkyGolay",  halfWindowSize = 8)
spectra <- removeBaseline(spectra, method = "TopHat", halfWindowSize = 16)
spectra <- calibrateIntensity(spectra, method = "TIC")
avgSpectrum <- averageMassSpectra(spectra)
avgPeaks <- detectPeaks(avgSpectrum, SNR = 5)

avgPeaks <- avgPeaks[intensity(avgPeaks) > 0.0015]

oldPar <- par(no.readonly = TRUE)
layout(matrix(c(1,1,1,2,3,4), nrow = 2, byrow = TRUE))
plot(avgSpectrum, main = "mean spectrum",
     xlim = c(3000, 6000), ylim = c(0, 0.007))
lines(avgPeaks, col = "red")
labelPeaks(avgPeaks, cex = 1)

par(mar = c(0.5, 0.5, 1.5, 0.5))
plotMsiSlice(spectra,
             center = mass(avgPeaks),
             tolerance = 1,
             plotInteractive = TRUE)
par(oldPar)
```

```
knitr::include_graphics("./figures/mqmsi-1.png")
```

![](data:image/png;base64...)

## 8.1 An interactive *[shiny](https://CRAN.R-project.org/package%3Dshiny)* app for Imaging mass spectrometry

There is also an interactive
[MALDIquant IMS shiny app](https://github.com/sgibb/ims-shiny) for demonstration
purposes. A screen shot is displayed below. To start the application:

```
library("shiny")
runGitHub("sgibb/ims-shiny")
```

```
knitr::include_graphics("./figures/ims-shiny.png")
```

![](data:image/png;base64...)

# 9 Spatial proteomics

```
library("pRoloc")
library("pRolocdata")

data(tan2009r1)

## these params use class weights
fn <- dir(system.file("extdata", package = "pRoloc"),
          full.names = TRUE, pattern = "params2.rda")
load(fn)

setStockcol(NULL)
setStockcol(paste0(getStockcol(), 90))

w <- table(fData(tan2009r1)[, "pd.markers"])
(w <- 1/w[names(w) != "unknown"])
```

```
##
##  Cytoskeleton            ER         Golgi      Lysosome       Nucleus
##    0.14285714    0.05000000    0.16666667    0.12500000    0.05000000
##            PM    Peroxisome    Proteasome  Ribosome 40S  Ribosome 60S
##    0.06666667    0.25000000    0.09090909    0.07142857    0.04000000
## mitochondrion
##    0.07142857
```

```
tan2009r1 <- svmClassification(tan2009r1, params2,
                               class.weights = w,
                               fcol = "pd.markers")
```

```
## [1] "pd.markers"
```

```
## Registered S3 method overwritten by 'gdata':
##   method         from
##   reorder.factor gplots
```

```
ptsze <- exp(fData(tan2009r1)$svm.scores) - 1
```

```
lout <- matrix(c(1:4, rep(5, 4)), ncol = 4, nrow = 2)
layout(lout)
cls <- getStockcol()
par(mar = c(4, 4, 1, 1))
plotDist(tan2009r1[which(fData(tan2009r1)$PLSDA == "mitochondrion"), ],
         markers = featureNames(tan2009r1)[which(fData(tan2009r1)$markers.orig == "mitochondrion")],
         mcol = cls[5])
legend("topright", legend = "mitochondrion", bty = "n")
plotDist(tan2009r1[which(fData(tan2009r1)$PLSDA == "ER/Golgi"), ],
         markers = featureNames(tan2009r1)[which(fData(tan2009r1)$markers.orig == "ER")],
         mcol = cls[2])
legend("topright", legend = "ER", bty = "n")
plotDist(tan2009r1[which(fData(tan2009r1)$PLSDA == "ER/Golgi"), ],
         markers = featureNames(tan2009r1)[which(fData(tan2009r1)$markers.orig == "Golgi")],
         mcol = cls[3])
legend("topright", legend = "Golgi", bty = "n")
plotDist(tan2009r1[which(fData(tan2009r1)$PLSDA == "PM"), ],
         markers = featureNames(tan2009r1)[which(fData(tan2009r1)$markers.orig == "PM")],
         mcol = cls[8])
legend("topright", legend = "PM", bty = "n")
plot2D(tan2009r1, fcol = "svm", cex = ptsze, method = "kpca")
addLegend(tan2009r1, where = "bottomleft", fcol = "svm", bty = "n")
```

![](data:image/png;base64...)

See the
[`pRoloc-tutorial`](http://bioconductor.org/packages/release/bioc/vignettes/pRoloc/inst/doc/pRoloc-tutorial.pdf)
vignette (pdf) from the *[pRoloc](https://bioconductor.org/packages/3.22/pRoloc)* package for details
about spatial proteomics data analysis and visualisation.

# 10 Session information

```
print(sessionInfo(), locale = FALSE)
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] beanplot_1.3.1           ggplot2_4.0.0            lattice_0.22-7
##  [4] e1071_1.7-16             msmsTests_1.48.0         msmsEDA_1.48.0
##  [7] pRolocdata_1.48.0        pRoloc_1.50.0            BiocParallel_1.44.0
## [10] MLInterfaces_1.90.0      cluster_2.1.8.1          annotate_1.88.0
## [13] XML_3.99-0.19            AnnotationDbi_1.72.0     IRanges_2.44.0
## [16] MALDIquantForeign_0.14.1 MALDIquant_1.22.3        RColorBrewer_1.1-3
## [19] xtable_1.8-4             rpx_2.18.0               knitr_1.50
## [22] DT_0.34.0                protViz_0.7.9            BiocManager_1.30.26
## [25] RforProteomics_1.48.0    MSnbase_2.36.0           ProtGenerics_1.42.0
## [28] S4Vectors_0.48.0         mzR_2.44.0               Rcpp_1.1.0
## [31] Biobase_2.70.0           BiocGenerics_0.56.0      generics_0.1.4
## [34] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] segmented_2.1-4             fs_1.6.6
##   [3] matrixStats_1.5.0           bitops_1.0-9
##   [5] lubridate_1.9.4             httr_1.4.7
##   [7] doParallel_1.0.17           tools_4.5.1
##   [9] R6_2.6.1                    lazyeval_0.2.2
##  [11] withr_3.0.2                 prettyunits_1.2.0
##  [13] gridExtra_2.3               preprocessCore_1.72.0
##  [15] cli_3.6.5                   readBrukerFlexData_1.9.3
##  [17] labeling_0.4.3              sass_0.4.10
##  [19] mvtnorm_1.3-3               S7_0.2.0
##  [21] randomForest_4.7-1.2        proxy_0.4-27
##  [23] R.utils_2.13.0              dichromat_2.0-0.1
##  [25] MetaboCoreUtils_1.18.0      parallelly_1.45.1
##  [27] limma_3.66.0                impute_1.84.0
##  [29] RSQLite_2.4.3               FNN_1.1.4.1
##  [31] crosstalk_1.2.2             gtools_3.9.5
##  [33] dplyr_1.1.4                 dendextend_1.19.1
##  [35] Matrix_1.7-4                abind_1.4-8
##  [37] R.methodsS3_1.8.2           lifecycle_1.0.4
##  [39] yaml_2.3.10                 edgeR_4.8.0
##  [41] SummarizedExperiment_1.40.0 gplots_3.2.0
##  [43] biocViews_1.78.0            recipes_1.3.1
##  [45] qvalue_2.42.0               SparseArray_1.10.1
##  [47] BiocFileCache_3.0.0         grid_4.5.1
##  [49] blob_1.2.4                  gdata_3.0.1
##  [51] crayon_1.5.3                PSMatch_1.14.0
##  [53] KEGGREST_1.50.0             magick_2.9.0
##  [55] pillar_1.11.1               GenomicRanges_1.62.0
##  [57] future.apply_1.20.0         lpSolve_5.6.23
##  [59] codetools_0.2-20            glue_1.8.0
##  [61] pcaMethods_2.2.0            data.table_1.17.8
##  [63] MultiAssayExperiment_1.36.0 vctrs_0.6.5
##  [65] png_0.1-8                   gtable_0.3.6
##  [67] kernlab_0.9-33              cachem_1.1.0
##  [69] gower_1.0.2                 xfun_0.54
##  [71] S4Arrays_1.10.0             prodlim_2025.04.28
##  [73] Seqinfo_1.0.0               coda_0.19-4.1
##  [75] survival_3.8-3              ncdf4_1.24
##  [77] timeDate_4051.111           iterators_1.0.14
##  [79] tinytex_0.57                hardhat_1.4.2
##  [81] lava_1.8.2                  statmod_1.5.1
##  [83] ipred_0.9-15                nlme_3.1-168
##  [85] bit64_4.6.0-1               progress_1.2.3
##  [87] filelock_1.0.3              LaplacesDemon_16.1.6
##  [89] bslib_0.9.0                 affyio_1.80.0
##  [91] KernSmooth_2.23-26          rpart_4.1.24
##  [93] colorspace_2.1-2            DBI_1.2.3
##  [95] nnet_7.3-20                 tidyselect_1.2.1
##  [97] bit_4.6.0                   compiler_4.5.1
##  [99] curl_7.0.0                  httr2_1.2.1
## [101] graph_1.88.0                xml2_1.4.1
## [103] DelayedArray_0.36.0         plotly_4.11.0
## [105] bookdown_0.45               scales_1.4.0
## [107] caTools_1.18.3              hexbin_1.28.5
## [109] affy_1.88.0                 RBGL_1.86.0
## [111] rappdirs_0.3.3              stringr_1.5.2
## [113] digest_0.6.37               mixtools_2.0.0.1
## [115] rmarkdown_2.30              XVector_0.50.0
## [117] htmltools_0.5.8.1           pkgconfig_2.0.3
## [119] base64enc_0.1-3             MatrixGenerics_1.22.0
## [121] dbplyr_2.5.1                fastmap_1.2.0
## [123] rlang_1.1.6                 htmlwidgets_1.6.4
## [125] farver_2.1.2                jquerylib_0.1.4
## [127] jsonlite_2.0.0              mclust_6.1.2
## [129] mzID_1.48.0                 ModelMetrics_1.2.2.2
## [131] R.oo_1.27.1                 RCurl_1.98-1.17
## [133] magrittr_2.0.4              viridis_0.6.5
## [135] MsCoreUtils_1.22.0          vsn_3.78.0
## [137] stringi_1.8.7               pROC_1.19.0.1
## [139] MASS_7.3-65                 plyr_1.8.9
## [141] readMzXmlData_2.8.4         parallel_4.5.1
## [143] listenv_0.10.0              Biostrings_2.78.0
## [145] splines_4.5.1               hms_1.1.4
## [147] Spectra_1.20.0              locfit_1.5-9.12
## [149] igraph_2.2.1                RUnit_0.4.33.1
## [151] QFeatures_1.20.0            reshape2_1.4.4
## [153] biomaRt_2.66.0              evaluate_1.0.5
## [155] foreach_1.5.2               tidyr_1.3.1
## [157] purrr_1.1.0                 future_1.67.0
## [159] clue_0.3-66                 BiocBaseUtils_1.12.0
## [161] AnnotationFilter_1.34.0     viridisLite_0.4.2
## [163] class_7.3-23                tibble_3.3.0
## [165] memoise_2.0.1               timechange_0.3.0
## [167] globals_0.18.0              caret_7.0-1
## [169] sampling_2.11
```