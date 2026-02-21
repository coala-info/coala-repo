How to use mQTL.NMR

1

How to use mQTL.NMR package

1.1 Introduction

mQTL.NMR provides a complete QTL analysis pipeline for 1H-NMR metabolomic
data. Distinctive features include normalisation using various approaches, peak
alignment using RSPA approach, dimensionality reduction and mQTL mapping
for animal crosses and humans cohorts. We provide below an application ex-
ample showing the use of mQTL.NMR package on real-world datasets.

1.2 Data format

Raw data ﬁles should be formatted according to the targeted type of analysis
(mQTL or mGWA analysis). However, this step can be skipped if the data
In order to format the dataﬁles into
ﬁles are already formatted by the user.
the supported format by the mQTL.NMR package (comma-delimited format
csvs), the format_mQTL() function should be used with the input ﬁles in the
following format:

Figure 1: Format dataﬁles by using format_mQTL()

It is preferable that the user create a new directory to load the demonstration
dataset. Data ﬁles can be formatted as follows:

> # Download raw data files

> library(mQTL.NMR)

1

How to use mQTL.NMR

> load_datafiles()
> format_mQTL(phenofile,genofile,physiodat,cleandat,cleangen)

[1] "Start formatting the datafile /tmp/RtmpbS6Q4x/Rinst5c1a43694efa/mQTL.NMR/extdata/phenofile.txt and the genotype file /tmp/RtmpbS6Q4x/Rinst5c1a43694efa/mQTL.NMR/extdata/genofile.txt into the csvs files: met.clean.txt gen.clean.txt"

An example of csvs resulted ﬁles are shown below:

Figure 2: Dataﬁles formatted in csvs

1.3 Normalization of metabolomic data

The mQTL.NMR package implements several approaches to perform the nor-
malization of metabolomic data. We show below an example of the use of
normalisation approache ’constant sum’ (CS)

> # Constant Sum normalization

> nmeth<-'CS'
> normalise_mQTL(cleandat,CSnorm,nmeth)

[1] "Start constant sum normalisation:"

1.4 Alignment of metabolomic data

The mQTL.NMR package uses the Recursive Segment-wise Peak Alignment
(RSPA) approach to align positions of NMR spectral peaks with respect to a
reference spectrum picked up either automatically or manually.

> align_mQTL(CSnorm,aligdat)

[1] "...Automatic selection of a reference spectrum..."

[1] ""

2

How to use mQTL.NMR

[1] "...Returning aligned spectra..."

1.5 Dimentionality reduction

The mQTL.NMR package oﬀers mainly two approaches in order to reduce the
number of traits considered for genetic mapping analysis: statitical recoupling
of variables ("SRV") and binning ("bin") approaches . An example of using
SRV approach is given below:

> met="rectangle" # choose the statistical summarizing measure ("max","sum","trapez",...)
> pre_mQTL(aligdat, reducedF, RedMet="SRV",met, corrT=0.9)

[1] "Processing a 168 x 1454 matrix with minsize of 10

and a correlation Threshold of 0.9 using the rectangle"

[1] "length of events: 66"

[1] "Xcluster" "168"

"66"

"66"

[1] "balise length:" "3"

[1] "Found 64 clusters"

[1] "dataset: data file /tmp/RtmpbS6Q4x/Rinst5c1a43694efa/mQTL.NMR/extdata/reducedF.txt generated"

1.6 Quantitative trait locus mapping

The mQTL.NMR package enables association studies for diﬀerent species, from
animal crosses to human cohorts. Below an example of mQTL mapping on
mouse crosse:

> results<- list() # a list to stock the mQTL mapping results

> nperm<- 0 # number of permutations if required
> results<-process_mQTL(reducedF, cleangen, nperm)

--Read the following data:

168 individuals

30 markers

67 phenotypes

--Cross type: f2

[1] "TotM is 44 and np is 64"

[1] 6.000000 1.265767

[1] 12.000000 3.069176

[1] 18.000000 3.069176

[1] 24.000000 3.069176

[1] 30.000000 3.069176

3

How to use mQTL.NMR

[1] 36.000000 3.069176

[1] 42.000000 3.069176

[1] 48.000000 3.069176

[1] 54.000000 3.069176

[1] 60.00000 19.76617

[1] "SRV ehk in this area was 19.77 for 3.73905 ppm at c9.loc65"

1.7 Visualization of results

mQTL mapping results can be shown in several plots as follows (Figure 1):

>

post_mQTL(results)

[1] "Post processing"

pdf

2

1.8 Summary of results

A summary of the results can be obtained in a table as follows:

> summary_mQTL(results,rectangle_SRV,T=8)

[1] "Summarize single runs /tmp/RtmpbS6Q4x/Rinst5c1a43694efa/mQTL.NMR/extdata/rectangle_SRV"

Min

Max

ppm chr

pos

lod

c9.loc55
3.70110 3.71155 3.706325
UT_9_113.827703 3.71540 3.72420 3.719800
3.72475 3.73410 3.729425
c9.loc60

9 55.00000 13.08101

9 61.70003

9.21992

9 60.00000 19.38129

c9.loc65

3.73465 3.74345 3.739050

9 65.00000 19.76617

1.9 Circular genome-metabolome plot

mQTL.NMR package provides a functionality to visualize the obtained mQTL
mapping results. The user can start ﬁrst by visualizing the plot of the whole
results of mQTL mapping. For optimal visualization, the user can then plot the
results for one or several chromosomes.

> circle_mQTL(results, T=8,spacing=0)

4

How to use mQTL.NMR

(a) 3D Proﬁle

(b) Lod for top locus

(c) Lod for top shift

(d) Zoom on the lod for top shift

(e) 2D proﬁle

(f) Lod distribution

Figure 3: ﬁgures generated by post_mQTL()

5

llllllllllllllllllllllllllllll9lllllllllll010lc9.loc453.71lgnf09.088.4873.71lc9.loc503.71lD9Mit123.71lc9.loc553.71lc9.loc603.71lUT_9_113.8277033.71lc9.loc653.71lc9.loc703.71lrs36818993.71lrs62292983.71lc9.loc603.72lUT_9_113.8277033.72lc9.loc653.72lc9.loc703.72lc9.loc453.73lgnf09.088.4873.73lc9.loc503.73lD9Mit123.73lc9.loc553.73lc9.loc603.73lUT_9_113.8277033.73lc9.loc653.73lc9.loc703.73lrs36818993.73lrs62292983.73lrs37000853.73lc9.loc453.74lgnf09.088.4873.74lc9.loc503.74lD9Mit123.74lc9.loc553.74lc9.loc603.74lUT_9_113.8277033.74lc9.loc653.74lc9.loc703.74lrs36818993.74lrs62292983.74lrs37000853.74How to use mQTL.NMR

1.10 Structural assignment and metabolite identiﬁcation

mQTL.NMR package provides several visualization tools to help the user in
peak annotation and metabolite identiﬁcation. In particular, users can visualize
identiﬁed SRV clusters on the chemical shift axe and automatically generates
a plot showing the top ranked SRV cluster in the association study in order to
identify the corresponding metabolite.

1.10.1 Plot a region of NMR proﬁles

Displays a region of the NMR proﬁles by specifying a starting and ending point

> simple.plot(file=aligdat,lo=3.02,hi=3.08,k=1:60,title="NMR profile")

6

3.083.073.063.053.043.033.020123NMR profileresonance, ppmIntensityHow to use mQTL.NMR

1.10.2 Visualization of SRV clusters

Displays the NMR proﬁle with the clusters identiﬁed by SRV deﬁned by hori-
zontal lines on the proﬁle (green=min cluster border, red=max cluster border)

> SRV.plot(file1=aligdat,file2=rectangle_SRV,lo=3.02,hi=3.08,k=1:60,title="Clusters plot")

1.10.3 Top SRV clusters

Generates the plot of SRV cluster corresponding to the top association score
with the two right and left clusters to be used for metabolite identiﬁcation

> Top_SRV.plot(file1=aligdat,file2=rectangle_SRV,results=results,met=met,intMeth="mean")

7

3.083.073.063.053.043.033.020123Cluster plotresonance, ppmIntensityHow to use mQTL.NMR

> SRV_lod.plot(results,rectangle_SRV,T=1)

8

3.763.753.743.733.720.40.50.60.70.8Top cluster at ppm 3.73905 +/− 2 clustersresonance, ppmIntensityHow to use mQTL.NMR

The manual page on mQTL.NMR has a number of additional examples that show
how applicable functions can be used.

2

Session Information

The version number of R and packages loaded for generating the vignette were:

R version 3.4.2 (2017-09-28)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.3 LTS

Matrix products: default

BLAS: /home/biocbuild/bbs-3.6-bioc/R/lib/libRblas.so

LAPACK: /home/biocbuild/bbs-3.6-bioc/R/lib/libRlapack.so

9

3.73.63.53.43.33.23.15101520LOD for locus c9.loc65 on all SRV clustersResonance, ppmLODHow to use mQTL.NMR

locale:
[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

attached base packages:

[1] stats

graphics grDevices utils

datasets

methods

base

other attached packages:
[1] mQTL.NMR_1.12.0

loaded via a namespace (and not attached):
digest_0.6.12
[1] Rcpp_0.12.13
[5] backports_1.1.1 magrittr_1.5
[9] rmarkdown_1.6
[13] outliers_0.14
[17] parallel_3.4.2 compiler_3.4.2

qtl_1.41-6
BiocStyle_2.6.0 GenABEL_1.8-0
stringr_1.2.0
yaml_2.1.14
tools_3.4.2
htmltools_0.3.6 knitr_1.17

rprojroot_1.2
evaluate_0.10.1 stringi_1.1.5

MASS_7.3-47

10

