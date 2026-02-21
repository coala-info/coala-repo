Phenotypic distance measures for image-based high-throughput
screening

Xian Zhang, Gr´egoire Pau, Wolfgang Huber, Michael Boutros
xianzhang@gmail.com

October 30, 2017

Contents

1 Introduction

2 Cell feature extraction with imageHTS

3 Phenotypic distance calculation

4 Phenotype identiﬁcation

5 Phenotypic clustering analysis

6 Session info

1 Introduction

1

1

2

3

3

4

High-throughput image-based screening (also termed high-content screening) has become a popular method in
systems biology, functional genomics and drug discovery. Data analysis of high-content screening can be divided
into two steps: image quantiﬁcation and phenotypic analysis. Previously we have developed two R packages,
EBImage and imageHTS for image quantiﬁcation. The current R package phenoDist is designed for measuring
the phenotypic distance between treatments (e.g., RNAi, small molecular), in order to identify phenotypes and
to group treatments into functional clusters. The package implements various methods to compute phenotypic
distance including scaling, principle component analysis, factor analysis [6], Kolmogorov-Smirnov statistics [5],
SVM (Support Vector Machine) supervised classiﬁcation [2], SVM weight vector [3], and SVM classiﬁcation
accuracy [8]. The package also provides functions for phenotype identiﬁcation, treatment clustering and gene
enrichment analysis. In this vignette, we will demonstrate how phenoDist can be used for phenotypic distance
calculation, phenotype identiﬁcation and phenotypic clustering in high-content screening data analysis.

2 Cell feature extraction with imageHTS

Before being analyzed with phenoDist, an image-based screen has to be setup as an imageHTS object and
analyzed with segmentation and cell feature extraction. A human kinome siRNA screen for HeLa cell morphology
is used as an example. Detailed description of the screen can be found in [4, 2]. The screen has been previously
analyzed; screen information and data can be accessed remotely through imageHTS at http://www.ebi.ac.
uk/huber-srv/cellmorph/kimorph/. We ﬁrst initialize an imageHTS object to store the screen information.

> library(

’

imageHTS

’

)

> localPath <- file.path(tempdir(),
> serverURL <-
> x <- parseImageConf(

kimorph
http://www.ebi.ac.uk/huber-srv/cellmorph/kimorph/

conf/imageconf.txt

)

’

’

’

’

, localPath=localPath, serverURL=serverURL)

’

’

File "conf/imageconf.txt" read.
Number of plates= 3

1

Number of replicates= 2
Number of wells= 384
Number of channels= 3
Number of spots= 1

> x <- configure(x,
> x <- annotate(x,

’

conf/description.txt
)

conf/annotation.txt

’

’

’

’

,

conf/plateconf.txt

’

’

,

conf/screenlog.txt

’

)

The cell images are then processed with segmentation and feature extraction. The following code is not run

in the vignette due to time constraints; we will later download the analysis results remotely.

> unames <- setdiff(getUnames(x), getUnames(x, content=
> segmentWells(x, uname=uname, segmentationPar=
> extractFeatures(x, uname,

conf/featurepar.txt

)

’

’

conf/segmentationpar.txt
’

’

)

’

’

empty

))

3 Phenotypic distance calculation

Based on the cell feature data, one can design a phenotypic distance measure, to quantitatively indicate how
similar two phenotypes (when treated by RNAi for example) are. The phenotypic distance measurement can
subsequently be used to identify phenotypes based on the phenotypic distance between samples and negative
controls, and perform clustering analysis based on the phenotypic distance between samples [8]. Multiple
methods to compute phenotypic distance are implemented in this package. Here we show two examples: one by
PCA transformation and euclidean distance; the other by SVM classiﬁcation accuracy.

> library(

’

phenoDist

’

)

’

’

kimorph

> profiles <- summarizeWells(x, unames,
’
> load(system.file(
> pcaPDM <- PDMByWellAvg(profiles, selectedWellFtrs=selectedWellFtrs, transformMethod=
+ distMethod=
> svmAccPDM <- PDMBySvmAccuracy(x, unames, selectedCellFtrs=selectedCellFtrs, cross=5, cost=1,
+ gamma=2^-5, kernel=

conf/featurepar.txt

selectedFtrs.rda

, package=

, nPCA=30)

euclidean

phenoDist

radial

PCA

))

)

,

,

)

’

’

’

’

’

’

’

’

’

’

’

The above calculations are not run in the vignette due to time constraints, instead, we load a subset of the

pre-calculated svmAccPDM for demonstration purposes.

> load(system.file(
> dim(svmAccPDM_Pl1)

’

kimorph

’

’

,

svmAccPDM_Pl1.rda

’

, package=

’

phenoDist

’

))

[1] 704 704

> svmAccPDM_Pl1[1:5,1:5]

001-01-A03
001-01-A04
001-01-A05
001-01-A06
001-01-A07

001-01-A03 001-01-A04 001-01-A05 001-01-A06 001-01-A07
0.94
0.78
0.70
0.70
NA

0.94
0.77
NA
0.64
0.70

NA
0.94
0.93
0.91
0.93

0.94
NA
0.78
0.78
0.78

0.92
0.77
0.63
NA
0.67

Rows and columns of the distance matrix are non-empty wells from the ﬁrst plate of the three-plate library
with two technical replicates. Each value is the phenotypic distance measurement between cell populations
from the two corresponding wells, calculated by the SVM classiﬁcation accuracy method. The distance matrix
is not completely symmetric due to random sampling in the SVM cross validation process, but the ﬂuctuation
is negligible [8].

With the phenotypic distance matrix, we can assess the reproducibility of the two technical replicates of the

screen by comparing the distance between replicates and distance between non-replicates.

> ranking <- repDistRank(x, distMatrix=svmAccPDM_Pl1)
> summary(ranking)

2

Min. 1st Qu. Median
5.00
1.00
1.00

Mean 3rd Qu.

Max.
30.62 621.00

34.54

Lower ranking suggests better reproducibility. When ranking equals 1, the treatment is most similar to its

technical replicates.

4 Phenotype identiﬁcation

Phenotypic distance between a treatment and the negative control indicates how strong the phenotype is. With
the phenotype information, we can assess screen quality by calculating replicate correlation and separation
between positive and negative controls.

> pheno <- distToNeg(x, distMatrix=svmAccPDM_Pl1, neg=
> df <- data.frame(pheno=pheno,gene=getWellFeatures(x, uname=rownames(svmAccPDM_Pl1),
+ feature=
))
> df <- df[order(pheno, decreasing=T),]
> head(df)

GeneID

rluc

)

’

’

’

’

pheno gene
001-02-B10 0.94875 ERBB4
001-02-O17 0.94250 AURKB
UBC
001-02-O04 0.93500
001-02-D04 0.93250 KIF23
001-02-P04 0.93000
UBC
001-02-B11 0.92500 COPB2

Shown are the ﬁve siRNA treatments with the most signiﬁcant phenotypes (i.e., highest phenotypic distance

to the negative control). With imageHTS, one can view the cell images for certain siRNA treatments.

Replicate reproducibility can also be assessed by calculating correlation coeﬃcient between replicates, and

by calculating Z’-factor, which indicates the separation between positive and negative controls [7].

> repCorr(x, pheno)

[1] 0.7709275

> ctlSeparatn(x, pheno, neg=

’

’

rluc

’

, pos=

’

ubc

, method=

’

’

robust

)

[1] 0.4221891

These two quality control metrics can be used to assess screen quality, or to evaluate diﬀerent data analysis

methods.

5 Phenotypic clustering analysis

Treatments can be clustered based on the phenotypic distance matrix, which will help us understand their
functional relationship. Here we clusters the genes with hierarchical clustering.

> phenoCluster <- clusterDist(x, distMatrix=svmAccPDM_Pl1, clusterFun=

’

’

hclust

, method=

’

’

ward

)

The clustering can be analyzed for GO term enrichment to identify signiﬁcant gene clusters with the R

package GOstats [1]. The following code is not run in the vignette due to time constraints.

’

’

GOstats

> library(
> GOEnrich <- enrichAnalysis(x, cl=cutree(phenoCluster, k=5), terms=
+ pvalueCutoff=0.01, testDirection=

, ontology=

over

BP

)

’

’

’

’

, conditional=TRUE)

’

’

GO

, annotation=

’

org.Hs.eg.db

’

,

3

6 Session info

This document was produced using:

> toLatex(sessionInfo())

(cid:136) R version 3.4.2 (2017-09-28), x86_64-pc-linux-gnu

(cid:136) Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_US.UTF-8, LC_COLLATE=C,

LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8, LC_NAME=C,
LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

(cid:136) Running under: Ubuntu 16.04.3 LTS

(cid:136) Matrix products: default

(cid:136) BLAS: /home/biocbuild/bbs-3.6-bioc/R/lib/libRblas.so

(cid:136) LAPACK: /home/biocbuild/bbs-3.6-bioc/R/lib/libRlapack.so

(cid:136) Base packages: base, datasets, grDevices, graphics, grid, methods, parallel, stats, utils

(cid:136) Other packages: Biobase 2.38.0, BiocGenerics 0.24.0, EBImage 4.20.0, RColorBrewer 1.1-2,
cellHTS2 2.42.0, e1071 1.6-8, geneﬁlter 1.60.0, hwriter 1.3.2, imageHTS 1.28.0, locﬁt 1.5-9.1,
phenoDist 1.26.0, splots 1.44.0, vsn 3.46.0

(cid:136) Loaded via a namespace (and not attached): AnnotationDbi 1.40.0, BiocInstaller 1.28.0,

Category 2.44.0, DBI 0.7, DEoptimR 1.0-8, GSEABase 1.40.0, IRanges 2.12.0, MASS 7.3-47,
Matrix 1.2-11, RBGL 1.54.0, RCurl 1.95-4.8, RSQLite 2.0, Rcpp 0.12.13, S4Vectors 0.16.0,
XML 3.98-1.9, abind 1.4-5, aﬀy 1.56.0, aﬀyio 1.48.0, annotate 1.56.0, bit 1.1-12, bit64 0.9-7, bitops 1.0-6,
blob 1.1.0, class 7.3-14, cluster 2.0.6, colorspace 1.3-2, compiler 3.4.2, digest 0.6.12, ﬀtwtools 0.9-8,
ggplot2 2.2.1, graph 1.56.0, gtable 0.2.0, htmltools 0.3.6, htmlwidgets 0.9, jpeg 0.1-8, lattice 0.20-35,
lazyeval 0.2.1, limma 3.34.0, memoise 1.1.0, munsell 0.4.3, mvtnorm 1.0-6, pcaPP 1.9-72, plyr 1.8.4,
png 0.1-7, prada 1.54.0, preprocessCore 1.40.0, rlang 0.1.2, robustbase 0.92-7, rrcov 1.4-3, scales 0.5.0,
splines 3.4.2, stats4 3.4.2, survival 2.41-3, tibble 1.3.4, tiﬀ 0.1-5, tools 3.4.2, xtable 1.8-2, zlibbioc 1.24.0

References

[1] S. Falcon and R. Gentleman. Using GOstats to test gene lists for GO term association. Bioinformatics,

23(2):257–8, 2007.

[2] F. Fuchs, G. Pau, D. Kranz, O. Sklyar, C. Budjan, S. Steinbrink, T. Horn, A. Pedal, W. Huber, and
M. Boutros. Clustering phenotype populations by genome-wide RNAi and multiparametric imaging. Mol
Syst Biol, 6:370, 2010.

[3] L. H. Loo, L. F. Wu, and S. J. Altschuler. Image-based multivariate proﬁling of drug responses from single

cells. Nat Methods, 4(5):445–453, 2007.

[4] G. Pau, X. Zhang, M. Boutros, and W. Huber. Automated analysis of high-throughput imaging screens

with imageHTS. In preparation.

[5] Z. E. Perlman, M. D. Slack, Y. Feng, T. J. Mitchison, L. F. Wu, and S. J. Altschuler. Multidimensional

drug proﬁling by automated microscopy. Science, 306(5699):1194–1198, 2004.

[6] D. W. Young, A. Bender, J. Hoyt, E. McWhinnie, G. W. Chirn, C. Y. Tao, J. A. Tallarico, M. Labow, J. L.
Jenkins, T. J. Mitchison, and Y. Feng. Integrating high-content screening and ligand-target prediction to
identify mechanism of action. Nat Chem Biol, 4(1):59–68, 2008.

[7] J. H. Zhang, T. D. Chung, and K. R. Oldenburg. A simple statistical parameter for use in evaluation and

validation of high throughput screening assays. J Biomol Screen, 4(2):67–73, 1999.

[8] X. Zhang, G. Pau, W. Huber, and M. Boutros. Phenotype identiﬁcation and clustering in image-based

screening with a novel phenotypic distance measure. In preparation.

4

