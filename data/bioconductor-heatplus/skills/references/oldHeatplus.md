Some superseded functions in package Heatplus

Alexander Ploner
Medical Epidemiology & Biostatistics
Karolinska Institutet, Stockholm
email: alexander.ploner@ki.se

October 30, 2025

The Heatplus offers an extended heatmap display, including covariates and
color-coding of clusters. This document demonstrates the use of the functions
heatplus_2 and heatmap_plus for generating regular and annotated heatmaps.

These functions have been superseded by regHeatmap and
annHeatmap and are included for historical reasons only!

We start with preparing a structured data matrix that looks somewhat like

a gene expression matrix with 45 samples and 130 genes:

> mm = matrix(rnorm(1000, m=1), 100,10)
> mm = cbind(mm, matrix(rnorm(2000), 100, 20))
> mm = cbind(mm, matrix(rnorm(1500, m=-1), 100, 15))
> mm2 = matrix(rnorm(450), 30, 15)
> mm2 = cbind(mm2, matrix(rnorm(900,m=1.5), 30,30))
> mm=rbind(mm, mm2)
> colnames(mm) = paste("Sample", 1:45)
> rownames(mm) = paste("Gene", 1:130)

Note that here the samples are the columns of the data matrix; this is common
for gene expression data, whereas it is traditional in statistics to have the samples
as rows of the data matrix.

For the annotated heatplots, we construct an artifical data frame of variables

describing further properties of the samples:

> addvar = data.frame(Var1=rep(c(0,1,0),c(10,20,15)),
+
Var2=rep(c(1,0,0),c(10,20,15)),
+
+
> addvar[3,3] = addvar[17,2] = addvar[34,1] =NA

Var3=rep(c(1,0), c(15,30)),
Var4=rep(seq(0,1,length=4), c(10,5,15,15))+rnorm(45,sd=0.5))

Note that this data frame is in the traditional form, i.e. samples as rows, as
common for phenotypic information accompanying an expression matrix; the

1

> library(Heatplus)
> heatmap_2(mm)

Figure 1: By default, the output of heatmap_2 is very similar to the graph
produced by heatmap(mm).

first three variables are binary, the fourth is quantitative, and we have thrown
in a few missing values to make it more interesting.

The rest of this vignette consists of graphs produced by the functions heatmap_2,

which produces a basic heat map similar to heatmap, and heatmap_plus, which
produces annotated heat maps.

2

Sample 42Sample 43Sample 41Sample 35Sample 33Sample 31Sample 34Sample 38Sample 32Sample 39Sample 37Sample 45Sample 40Sample 36Sample 44Sample 13Sample 14Sample 15Sample 11Sample 12Sample 16Sample 28Sample 25Sample 29Sample 21Sample 23Sample 30Sample 18Sample 20Sample 27Sample 17Sample 24Sample 22Sample 26Sample 19Sample 8Sample 4Sample 9Sample 2Sample 10Sample 6Sample 3Sample 5Sample 7Sample 1Gene 99Gene 27Gene 45Gene 1Gene 64Gene 9Gene 62Gene 33Gene 87Gene 7Gene 3Gene 66Gene 68Gene 8Gene 97Gene 70Gene 26Gene 12Gene 4Gene 23Gene 67Gene 80Gene 88Gene 77Gene 19Gene 22Gene 17Gene 50Gene 96Gene 74Gene 37Gene 42Gene 63Gene 86Gene 109Gene 107Gene 128Gene 124Gene 113Gene 129Gene 110Gene 108Gene 101Gene 123> heatmap_2(mm, do.dendro=c(FALSE, TRUE), legend=1, legfrac=12)

Figure 2: Here we suppress the plotting of the row dendrogram (though the
rows are still sorted!), and we add a legend at the bottom, slightly smaller than
the default.

3

Sample 42Sample 43Sample 41Sample 35Sample 33Sample 31Sample 34Sample 38Sample 32Sample 39Sample 37Sample 45Sample 40Sample 36Sample 44Sample 13Sample 14Sample 15Sample 11Sample 12Sample 16Sample 28Sample 25Sample 29Sample 21Sample 23Sample 30Sample 18Sample 20Sample 27Sample 17Sample 24Sample 22Sample 26Sample 19Sample 8Sample 4Sample 9Sample 2Sample 10Sample 6Sample 3Sample 5Sample 7Sample 1Gene 99Gene 25Gene 2Gene 45Gene 11Gene 14Gene 64Gene 82Gene 92Gene 62Gene 89Gene 24Gene 87Gene 29Gene 5Gene 3Gene 21Gene 75Gene 68Gene 34Gene 10Gene 97Gene 6Gene 54Gene 26Gene 36Gene 13Gene 4Gene 30Gene 59Gene 67Gene 20Gene 76Gene 88Gene 18Gene 28Gene 19Gene 40Gene 44Gene 17Gene 52Gene 94Gene 96Gene 51Gene 60Gene 37Gene 69Gene 91Gene 63Gene 90Gene 120Gene 109Gene 130Gene 106Gene 128Gene 127Gene 122Gene 113Gene 114Gene 104Gene 110Gene 116Gene 121Gene 101Gene 105−4−202dummy.x1> heatmap_plus(mm)

Figure 3: If we do not specify extra variables, heatmap_plus just produces a
heatmap without drawing the row dendrogram (though as in Figure 2, the rows
are sorted according to the dendrogram). Note however, how the sample labels
are now plotted under the column dendrogram; this does not look nice, but the
need for this will becom clear in Figure 4.

4

Sample 42Sample 43Sample 41Sample 35Sample 33Sample 31Sample 34Sample 38Sample 32Sample 39Sample 37Sample 45Sample 40Sample 36Sample 44Sample 13Sample 14Sample 15Sample 11Sample 12Sample 16Sample 28Sample 25Sample 29Sample 21Sample 23Sample 30Sample 18Sample 20Sample 27Sample 17Sample 24Sample 22Sample 26Sample 19Sample 8Sample 4Sample 9Sample 2Sample 10Sample 6Sample 3Sample 5Sample 7Sample 1Gene 99Gene 27Gene 45Gene 1Gene 64Gene 9Gene 62Gene 33Gene 87Gene 7Gene 3Gene 66Gene 68Gene 8Gene 97Gene 70Gene 26Gene 12Gene 4Gene 23Gene 67Gene 80Gene 88Gene 77Gene 19Gene 22Gene 17Gene 50Gene 96Gene 74Gene 37Gene 42Gene 63Gene 86Gene 109Gene 107Gene 128Gene 124Gene 113Gene 129Gene 110Gene 108Gene 101Gene 123> colnames(mm) = NULL
> heatmap_plus(mm, addvar=addvar, cov=4)

Figure 4: Here we set column names to NULL in order to get rid of the ugly
labels seen in Figure 3. Then we produce an annotated heat map, specifying
that we do have a covariate in column 4 of addvar.

5

Gene 99Gene 27Gene 45Gene 1Gene 64Gene 9Gene 62Gene 33Gene 87Gene 7Gene 3Gene 66Gene 68Gene 8Gene 97Gene 70Gene 26Gene 12Gene 4Gene 23Gene 67Gene 80Gene 88Gene 77Gene 19Gene 22Gene 17Gene 50Gene 96Gene 74Gene 37Gene 42Gene 63Gene 86Gene 109Gene 107Gene 128Gene 124Gene 113Gene 129Gene 110Gene 108Gene 101Gene 123Var1Var2Var3−1.00.01.0Var4> heatmap_plus(mm, addvar=addvar, cov=4, h=20, col=RGBColVec(64))

Figure 5: Here we produce an annotated heat map as in Figure 4, but we also
specify that the column dendrogram is to be cut at height h=20. Note the
different color scheme.

6

Gene 99Gene 27Gene 45Gene 1Gene 64Gene 9Gene 62Gene 33Gene 87Gene 7Gene 3Gene 66Gene 68Gene 8Gene 97Gene 70Gene 26Gene 12Gene 4Gene 23Gene 67Gene 80Gene 88Gene 77Gene 19Gene 22Gene 17Gene 50Gene 96Gene 74Gene 37Gene 42Gene 63Gene 86Gene 109Gene 107Gene 128Gene 124Gene 113Gene 129Gene 110Gene 108Gene 101Gene 123Var1Var2Var3−1.00.01.0Var4