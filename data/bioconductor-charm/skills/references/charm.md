Using the charm package to estimate DNA
methylation levels and ﬁnd diﬀerentially
methylated regions

Peter Murakami*, Martin Aryee, Rafael Irizarry

October 10, 2012

Johns Hopkins School of Medicine / Johns Hopkins School of Public Health
Baltimore, MD, USA

1

Introduction

The Bioconductor package charm can be used to analyze DNA methylation data
generated using McrBC fractionation and two-color Nimblegen microarrays. It
is customized for use with data the from the custom CHARM microarray [2],
but can also be applied to many other Nimblegen designs. The preprocessing
and normalization methods are described in detail in [1].

Functions include:

(cid:136) Quality control

(cid:136) Finding suitable control probes for normalization

(cid:136) Percentage methylation estimates

(cid:136) Identiﬁcation of diﬀerentially methylated regions

(cid:136) Plotting of diﬀerentially methylated regions

As input we will need raw Nimblegen data (.xys) ﬁles and a corresponding
annotation package built with pdInfoBuilder. This vignette uses the following
packages:

(cid:136) charm: contains the analysis functions

(cid:136) charmData: an example dataset

(cid:136) pd.charm.hg18.example: the annotation package for the example dataset

*pmurakam@jhsph.edu

1

(cid:136) BSgenome.Hsapiens.UCSC.hg18: A BSgenome object containing genomic

sequence used for ﬁnding non-CpG control probes

Each sample is represented by two xys ﬁles corresponding to the untreated
(green) and methyl-depleted (red) channels. The 532.xys and 635.xys suﬃxes
indicate the green and red channels respectively.

2 Analyzing data from the custom CHARM mi-

croarray

Load the charm package:

R> library(charm)
R> library(charmData)

3 Read in raw data

Get the name of your data directory (in this case, the example data):

R> dataDir <- system.file("data", package="charmData")
R> dataDir

[1] "/home/biocbuild/bbs-3.8-bioc/R/library/charmData/data"

First we read in the sample description ﬁle:

R> phenodataDir <- system.file("extdata", package="charmData")
R> pd <- read.delim(file.path(phenodataDir, "phenodata.txt"))
R> phenodataDir

[1] "/home/biocbuild/bbs-3.8-bioc/R/library/charmData/extdata"

R> pd

filename

sampleID tissue
136421_532.xys 441_liver liver
1
136421_635.xys 441_liver liver
2
136600_532.xys 449_spleen spleen
3
4
136600_635.xys 449_spleen spleen
5 3788602_532.xys 449_liver liver
6 3788602_635.xys 449_liver liver
7 3822402_532.xys 441_spleen spleen
8 3822402_635.xys 441_spleen spleen
9 5739902_532.xys 624_colon colon
10 5739902_635.xys 624_colon colon
11 5875602_532.xys 441_colon colon
12 5875602_635.xys 441_colon colon

2

A valid sample description ﬁle should contain at least the following (arbi-

trarily named) columns:

(cid:136) a ﬁlename column

(cid:136) a sample ID column

(cid:136) a group label column (optional)

The sample ID column is used to pair the methyl-depleted and untreated
data ﬁles for each sample. The group label column is used when identifying
diﬀerentially methylated regions between experimental groups.

The validatePd function can be used to validate the sample description ﬁle.
When called with only a sample description data frame and no further options
validatePd will try to guess the contents of the columns.

R> res <- validatePd(pd)

Now we read in the raw data. The readCharm command makes the assump-
tion (unless told otherwise) that the two xys ﬁles for a sample have the same ﬁle
name up to the suﬃxes 532.xys (untreated) and 635.xys (methyl-depleted). The
sampleNames argument is optional. Note that if the ﬀ package has been loaded
previously in your R session, the output of readCharm will contain ff rather
than matrix objects, and all subsequent charm functions acting on it (except
those in pipeline 2 described below) will recognize this and use ff objects also.
Using the ﬀ package is recommended when the data set is otherwise too large
for the amount of memory available.

R> rawData <- readCharm(files=pd$filename, path=dataDir, sampleKey=pd,

sampleNames=pd$sampleID)

Checking designs for each XYS file... Done.
Allocating memory... Done.
Reading /home/biocbuild/bbs-3.8-bioc/R/library/charmData/data/136421_532.xys.
Reading /home/biocbuild/bbs-3.8-bioc/R/library/charmData/data/136600_532.xys.
Reading /home/biocbuild/bbs-3.8-bioc/R/library/charmData/data/3788602_532.xys.
Reading /home/biocbuild/bbs-3.8-bioc/R/library/charmData/data/3822402_532.xys.
Reading /home/biocbuild/bbs-3.8-bioc/R/library/charmData/data/5739902_532.xys.
Reading /home/biocbuild/bbs-3.8-bioc/R/library/charmData/data/5875602_532.xys.
Checking designs for each XYS file... Done.
Allocating memory... Done.
Reading /home/biocbuild/bbs-3.8-bioc/R/library/charmData/data/136421_635.xys.
Reading /home/biocbuild/bbs-3.8-bioc/R/library/charmData/data/136600_635.xys.
Reading /home/biocbuild/bbs-3.8-bioc/R/library/charmData/data/3788602_635.xys.
Reading /home/biocbuild/bbs-3.8-bioc/R/library/charmData/data/3822402_635.xys.
Reading /home/biocbuild/bbs-3.8-bioc/R/library/charmData/data/5739902_635.xys.
Reading /home/biocbuild/bbs-3.8-bioc/R/library/charmData/data/5875602_635.xys.

R> rawData

3

TilingFeatureSet (storageMode: lockedEnvironment)
assayData: 243129 features, 6 samples
element names: channel1, channel2

protocolData

rowNames: 441_liver 449_spleen ... 441_colon (6

total)

varLabels: filenamesChannel1 filenamesChannel2

dates1 dates2

varMetadata: labelDescription channel

phenoData

rowNames: 441_liver 449_spleen ... 441_colon (6

total)

varLabels: sampleID tissue arrayUT arrayMD
varMetadata: labelDescription channel

featureData: none
experimentData: use
Annotation: pd.charm.hg18.example

’

experimentData(object)

’

4 Array quality assessment

We can calculate array quality scores and generate a pdf report with the qcRe-
port command.

A useful quick way of assessing data quality is to examine the untreated
channel where we expect every probe to have signal. Very low signal intensities
on all or part of an array can indicate problems with hybridization or scanning.
The CHARM array and many other designs include background probes that
do not match any genomic sequence. Any signal at these background probes
can be assumed to be the result of optical noise or cross-hybridization. Since
the untreated channel contains total DNA a successful hybridization would have
strong signal for all untreated channel genomic probes. The array signal quality
score (pmSignal) is calculated as the average percentile rank of the signal robes
among these background probes. A score of 100 means all signal probes rank
above all background probes (the ideal scenario).

R> qual <- qcReport(rawData, file="qcReport.pdf")
R> qual

sd1

pmSignal

sd2
441_liver 78.56437 0.1950274 0.1932112
449_spleen 81.46541 0.1755225 0.1227921
449_liver 83.95419 0.1249030 0.2409803
441_spleen 81.43751 0.1180708 0.1824810
624_colon 82.55727 0.1490854 0.2035761
441_colon 79.38069 0.3130266 0.3962373

The PDF quality report is shown in Appendix A. Three quality metrics are

calculated for each array:

4

1. Average signal strength: the average percentile rank of untreated channel

signal probes among the background (anti-genomic) probes.

2. Untreated channel signal standard deviation. The array is divided into
a series of rectangular blocks and the average signal level calculated for
each. Since probes are arranged randomly on the array there should be
no large diﬀerences between blocks. Arrays with spatial artifacts have a
larg standard deviation between blocks.

3. Methyl-depleted channel signal standard deviation.

To remove samples with a quality score less than 78, we could do this:

R> qc.min = 78
R> ##Remove arrays with quality scores below qc.min:
R> rawData=rawData[,qual$pmSignal>=qc.min]
R> qual=qual[qual$pmSignal>=qc.min,]
R> pd=pd[pd$sampleID%in%rownames(qual),]
R> pData(rawData)$qual=qual$pmSignal

and to identify which probes have a mean quality score above 75 we could

do this:

R> pmq = pmQuality(rawData)
R> rmpmq = rowMeans(pmq)
R> okqc = which(rmpmq>75)

We now want to calculate probe-level percentage methylation estimates for
each sample. As a ﬁrst step we need to identify a suitable set of unmethylated
control probes from CpG-free regions to be used in normalization.

R> library(BSgenome.Hsapiens.UCSC.hg18)
R> ctrlIdx <- getControlIndex(rawData, subject=Hsapiens, noCpGWindow=600)

We can check the success of the control probes by comparing their intensity
distribution with the non-control probes (before any normalization in which the
control probes are used).

R> cqc = controlQC(rawData=rawData, controlIndex=ctrlIdx, IDcol="sampleID",

expcol="tissue", ylimits=c(-6,8),
outfile="boxplots_check.pdf", height=7, width=9)

R> cqc

control

non_control

diff
624_colon
0.3566461933 -1.941694 2.298340
441_colon -0.0574214228 -1.731861 1.674439
441_liver -0.1457478398 -1.650048 1.504300
449_liver
0.3150572371 -1.784765 2.099822
449_spleen -0.0374729647 -2.396630 2.359157
441_spleen -0.0001859828 -1.505605 1.505419

5

We can also access the probe annotation using standard functions from the

oligo package.

R> chr = pmChr(rawData)
R> pns = probeNames(rawData)
R> pos = pmPosition(rawData)
R> seq = pmSequence(rawData)
R> pd = pData(rawData)

5 Percentage methylation estimates and diﬀer-

entially methylated regions (DMRs)

The minimal code required to estimate methylation would be p <- methp(rawData,
controlIndex=ctrlIdx). However, it is often useful to get methp to produce
a series of diagnostic density plots to help identify non-hybridization quality
issues. The plotDensity option speciﬁes the name of the output pdf ﬁle, and
the optional plotDensityGroups can be used to give groups diﬀerent colors.
Remember that if the ﬀ package was loaded before producing rawData with
readCharm, the output of methp will be an ff rather than a matrix object.
charm functions (except those in pipeline 2 described below) will handle ff p
objects automatically.

R> p <- methp(rawData, controlIndex=ctrlIdx,

plotDensity="density.pdf", plotDensityGroups=pd$tissue)

R> head(p)

441_liver 449_spleen 449_liver 441_spleen 624_colon
[1,] 0.2339500 0.3938997 0.3830594 0.5503894 0.3690156
[2,] 0.7981122 0.7028600 0.3553074 0.8672083 0.5467749
[3,] 0.1484353 0.1315433 0.2678832 0.2219977 0.3303371
[4,] 0.5636164 0.4794087 0.4745429 0.4852167 0.3907739
[5,] 0.5960515 0.5213320 0.4109157 0.4244830 0.4056629
[6,] 0.6382018 0.7462242 0.7421377 0.7026418 0.8668257

441_colon
[1,] 0.2936966
[2,] 0.8745990
[3,] 0.6575834
[4,] 0.4314869
[5,] 0.3523044
[6,] 0.8042553

For a simple unsupervised clustering of the samples, we can plot the results

of a classical multi-dimensional scaling analysis.

R> cmdsplot(labcols=c("red","black","blue"), expcol="tissue",

rawData=rawData, p=p, okqc=okqc, noXorY=TRUE,
outfile="cmds_topN.pdf", topN=c(100000,1000))

6

null device
1

The density plots are shown in Appendix B and the MDS plot is shown in
Appendix C.

5.1 Pipeline 1 (recommended): Regression-based DMR-

ﬁnding after correcting for batch eﬀects

Optionally, we may wish to restrict our search for DMRs to non-control probes
exceeding some quality threshold. We may do that simply by subsetting:

R> Index = setdiff(which(rmpmq>75),ctrlIdx)
R> Index = Index[order(chr[Index], pos[Index])]
R> p0 = p #save for pipeline 2 example
R> p = p[Index,]
R> seq = seq[Index]
R> chr = chr[Index]
R> pos = pos[Index]
R> pns = pns[Index]
R> pns = clusterMaker(chr,pos)

You might also wish to consider excluding some probes from the between-array
normalization step in methp earlier using the excludeIndex argument, e.g., ex-
cludeIndex=which(rmpmq<=50), however, note that it is probably inadvisable
to remove probes from between-array normalization in methp that you will end
up using in the analysis (note that the probes with mean qc < x1 are a subset
of the probes with mean qc < x2 when x1=50 and x2=75 as in this example.
Setting x1>x2 is not recommended as it would result in un-normalized probes
being used in the analysis). Using the clusterMaker function was necessary in
order to redeﬁne the array regions since removing probes may result in too few
probes per region or unacceptably large gaps between probes within the same
region. At this point it may also be helpful to remove arrays whose average
correlation with all other arrays is below some threshold, since it is often rea-
sonable to assume that most probes are not diﬀerentially methylated between
arrays. Unsupervised clustering would also probably tend to show such arrays
as clustering separately. Another reason for removing arrays at this point is
if they have missing data on any of the covariates to be used in the following
analysis. Remember that any arrays excluded from this point forward should
be removed from both p and pd.

To identify DMR candidates, we use the dmrFind function. As it requires
the same mod and mod0 arguments as the sva() function from the sva package,
we must ﬁrst create these. Data with paired samples may be accommodated by
including the pair ID column as a factor in mod and mod0.

R> mod0 = matrix(1,nrow=nrow(pd),ncol=1)
R> mod = model.matrix(~1 +factor(pd$tissue,levels=c("liver","colon","spleen")))

7

We may now call dmrFind. Setting the coeff argument to 2 means that we
are interested in the colon-liver comparison, since it is the second column of mod
that deﬁnes that comparison in the linear model.

R> library(corpcor)
R> thedmrs = dmrFind(p=p, mod=mod, mod0=mod0, coeff=2, pns=pns, chr=chr, pos=pos)

Running SVA
Number of significant surrogate variables is: 1
Iteration (out of 5 ):1 2 3 4 5
Regression
Obtaining estimates for factor(pd$tissue, levels = c("liver", "colon", "spleen"))colon
Smoothing
============================================================
....

Found 180 potential DMRs

To compare liver and spleen, set coeff to 3. To compare colon and spleen,
you must redeﬁne mod such that the ﬁrst level is either colon or spleen, and then
set coeff appropriately, e.g., mod = model.matrix( 1 + factor(pd$tissue,
levels=c("colon","spleen","liver"))) and coeff=2. To avoid repeating
the SVA analysis within dmrFind, you may provide the surrogate variables al-
ready identiﬁed above as an argument to subsequent dmrFind calls through the
svs argument. The surrogate variables are located in thedmrs$args$svs, so
adding svs=thedmrs$args$svs to the call to dmrFind would prevent SVA from
being called again. As long as p (or logitp, if you provided logitp to dmrFind),
mod, and mod0 are the same, the surrogate variables will be the same regardless
of which comparison you explore.

Also note that if you adjust for covariates, their eﬀects will be controlled
for when ﬁnding DMRs, however their eﬀects are not removed from the matrix
of ”cleaned” percent methylation estimates (i.e., cleanp) returned by dmrFind,
which by default removes only batch eﬀects (i.e., the surrogate variables iden-
tiﬁed by SVA). Consequently the adjustment covariate eﬀects will still show up
in the clustering results (and will probably be enhanced) and in the DMR plots
(since they do not get removed from the cleanp matrix). Only the surrogate
variables identiﬁed by SVA will be removed from the clustering results and the
DMR plots, regardless of whether or not you adjust for covariates. Setting
rob=FALSE in dmrFinder will cause the covariates’ eﬀects to be removed from
cleanp as well (all except the covariate of interest). rob=TRUE by default because
covariates explicitly adjusted for should typically be real biological rather than
technical confounders, and removing the eﬀects of real biological confounders
from the percent methylation estimates would change them from being our best
estimate of what the true percent methylation is for each probe in our sample
to an adjusted version of this.

If you want to obtain FDR q-values for the DMR candidates returned by

dmrFind, you may use the qval function as follows:

8

R> withq = qval(p=p, dmr=thedmrs, numiter=3, verbose=FALSE, mc=1)

....

The numiter argument is set to 3 here only for convenience of demonstration. In
reality it should be much higher (hundreds, if not thousands). The p argument
provided must be the same as the one used in dmrFind. The qval function
utilizes the parallel package that comes with R as of version 2.14. By default,
mc=1 (no parallelization), however on multiple-core machines you can set qval
If you are working in a shared
to use more cores to parallelize the process.
computing environment, take care not to request more cores than are available
to you.

We may plot DMR candidates from dmrFind using the plotDMRs function.
In order to mark the location of CpG islands in the second panel of each plot,
we must ﬁrst obtain a table identifying CpG islands. CpG island deﬁnitions
according to the method of Wu et al (2010) [3] are available for a large number
of genomes and are one source for such a table. Alternatively, CpG island
deﬁnitions may be obtained from the UCSC Genome Browser, which is what
we will use here for this example.

R> con <- gzcon(url(paste("http://hgdownload.soe.ucsc.edu/goldenPath/hg18/database/","cpgIslandExt.txt.gz", sep="")))
R> txt <- readLines(con)
R> cpg.cur <- read.delim(textConnection(txt), header=FALSE, as.is=TRUE)
R> cpg.cur <- cpg.cur[,1:3]
R> colnames(cpg.cur) <- c("chr","start","end")
R> cpg.cur <- cpg.cur[order(cpg.cur[,"chr"],cpg.cur[,"start"]),]
R> plotDMRs(dmrs=thedmrs, Genome=Hsapiens, cpg.islands=cpg.cur, exposure=pd$tissue,

outfile="./colon-liver.pdf", which_plot=c(1),
which_points=c("colon","liver"), smoo="loess", ADD=3000,
cols=c("black","red","blue"))

Making 1 figures
Plotting DMR candidate 1

Instead of plotting the probe p-values in the 3rd panel, you may also wish to
inspect the behavior of the green channel (total) across the DMR regions. To
do this, you must ﬁrst have obtained the green channel intensity matrix, which
we do here after spatial adjustment and background correction. In addition to
specifying panel3="G", we must also provide G and the sequences corresponding
its rows (because the intensities are further corrected for gc-content).

R> dat0 = spatialAdjust(rawData, copy=FALSE)
R> dat0 = bgAdjust(dat0, copy=FALSE)
R> G = pm(dat0)[,,1] #from oligo
R> G = G[Index,]
R> plotDMRs(dmrs=thedmrs, Genome=Hsapiens, cpg.islands=cpg.cur, exposure=pd$tissue,

outfile="./colon-liver2.pdf", which_plot=c(1),
which_points=c("colon","liver"), smoo="loess", ADD=3000,
cols=c("black","red","blue"), panel3="G", G=G, seq=seq)

9

......Making 1 figures
Plotting DMR candidate 1

5.1.1 Continuous covariate of interest

The dmrFind function also handles a continuous covariate of interest. Here we
generate an artiﬁcial continuous covariate called x and perform the analysis
using that.

R> pd$x = c(1,2,3,4,5,6)
R> mod0 = matrix(1,nrow=nrow(pd),ncol=1)
R> mod = model.matrix(~1 +pd$x)
R> coeff = 2
R> thedmrs2 = dmrFind(p=p, mod=mod, mod0=mod0, coeff=coeff, pns=pns, chr=chr, pos=pos)

Running SVA
Number of significant surrogate variables is: 2
Iteration (out of 5 ):1 2 3 4 5
Regression
Obtaining estimates for pd$x
Smoothing
============================================================
....

Found 231 potential DMRs

To plot the DMR results, you may either categorize the continuous covariate

as for example as follows

R> groups = as.numeric(cut(mod[,coeff],c(-Inf,2,4,Inf))) #You can change these cutpoints.
R> pd$groups = c("low","medium","high")[groups]
R> plotDMRs(dmrs=thedmrs2, Genome=Hsapiens, cpg.islands=cpg.cur, exposure=pd$groups,

outfile="./test.pdf", which_plot=c(1), smoo="loess", ADD=3000,
cols=c("black","red","blue"))

Making 1 figures
Plotting DMR candidate 1

or you may plot the correlation of each probe with the covariate as follows:

R> plotDMRs(dmrs=thedmrs2, Genome=Hsapiens, cpg.islands=cpg.cur, exposure=pd$x,
outfile="./x.pdf", which_plot=c(1), smoo="loess", ADD=3000,
cols=c("black","red","blue"))

Making 1 figures
Plotting DMR candidate 1

10

An additional function that can be helpful for working with tables with
columns ”chr”, ”start”, and ”end” as many of the objects required or returned
by these functions are is the regionMatch function, which ﬁnds for each region
in one table the nearest region in another table (using the nearest() function
in the IRanges package) and provides information on how near they are to each
other.

R> ov = regionMatch(thedmrs$dmrs,thedmrs2$dmrs)

chr1 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19 chr2 chr20 chr21 chr22 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chrX

1 overlap
cover
6
cover
15
cover
138
2 inside
cover

type amountOverlap insideDist size1
NA 1238
NA 1053
NA 1117
877
NA
0 1001
873

1202
NA
NA
NA
NA
NA

32

NA

R> head(ov)

dist matchIndex

1
2
3
4
5
6

0
0
0
0
0
0

size2
1 1431
948
2
736
3
4
142
5 1106
561
6

One may also plot regions other than DMR candidates returned by dmrFind,

using the plotRegions function.

R> mytable = thedmrs$dmrs[,c("chr","start","end")]
R> mytable[2,] = c("chr1",1,1000) #not on array
R> mytable$start = as.numeric(mytable$start)
R> mytable$end = as.numeric(mytable$end)
R> plotRegions(thetable=mytable[c(1),], cleanp=thedmrs$cleanp, chr=chr,

pos=pos, Genome=Hsapiens, cpg.islands=cpg.cur, outfile="myregions.pdf",
exposure=pd$tissue, exposure.continuous=FALSE)

Making 1 figures
null device
1

5.2 Pipeline 2: DMR-ﬁnding without adjusting for batch

or other covariates

We can identify diﬀerentially methylated regions using the original dmrFinder:

11

R> dmr <- dmrFinder(rawData, p=p0, groups=pd$tissue,

compare=c("colon", "liver","colon", "spleen"),
removeIf=expression(nprobes<4 | abs(diff)<.05 | abs(maxdiff)<.05))

R> names(dmr)

[1] "tabs"
[6] "pns"
[11] "comps"

"p"
"index"
"package"

"l"
"gm"

"chr"
"groups" "args"

"pos"

R> names(dmr$tabs)

[1] "colon-liver" "colon-spleen"

R> head(dmr$tabs[[1]])

p1

chr

end

start

p2
319 chr12 88272817 88273811 0.8427334 0.1941297
1752 chr6 52637747 52638747 0.7125609 0.1907672
358 chr13 27090247 27091224 0.7934359 0.1870099
473 chr15 58673084 58673780 0.8209172 0.3017451
1116 chr20 60187462 60188197 0.8120143 0.2041655
131 chr11 14620645 14621065 0.8421385 0.3529311

319 chr12:88266873-88274292
1752 chr6:52635302-52638967
358 chr13:27090144-27095500
473 chr15:58669815-58674073
1116 chr20:60143957-60188418
131 chr11:14620645-14623686

regionName indexStart indexEnd nprobes
24
40465
25
160819
19
45272
20
57657
22
122601
13
28438

40488
160843
45290
57676
122622
28450

area

diff

ttarea

maxdiff
319 15.566489 760.5740 0.6486037 0.7546481
1752 13.044841 690.9003 0.5217936 0.6550192
358 11.522095 649.3496 0.6064260 0.7307582
473 10.383443 532.5779 0.5191722 0.6554295
1116 13.372674 501.8911 0.6078488 0.8301324
6.359697 432.0827 0.4892075 0.6369340
131

When called without the compare option, dmrFinder performs all pairwise com-
parisons between the groups.

We can also plot DMR candidates with the dmrPlot function. Here we plot

just the top DMR candidate from the ﬁrst DMR table.

R> dmrPlot(dmr=dmr, which.table=1, which.plot=c(1), legend.size=1,

all.lines=TRUE, all.points=FALSE, colors.l=c("blue","black","red"),
colors.p=c("blue","black"), outpath=".", cpg.islands=cpg.cur, Genome=Hsapiens)

12

Smoothing:
============================================================
Done.

Plotting finished.

We can also plot any given genomic regions using this data by using the
regionPlot function, supplying the regions in a data frame that must have
columns with names ”chr”, ”start”, and ”end”. Naturally, regions that are not
on the array will not appear in the resulting ﬁle.

R> mytab = data.frame(chr=as.character(dmr$tabs[[1]]$chr[1]),

start=as.numeric(c(dmr$tabs[[1]]$start[1])),
end=as.numeric(c(dmr$tabs[[1]]$end[1])), stringsAsFactors=FALSE)

R> regionPlot(tab=mytab, dmr=dmr, cpg.islands=cpg.cur, Genome=Hsapiens,

outfile="myregions.pdf", which.plot=1:5, plot.these=c("liver","colon"),
cl=c("blue","black"), legend.size=1, buffer=3000)

Smoothing:
============================================================
Done.
1
Plotting finished.

R>

The DMR plot is shown in Appendix D, and the plot of the user-provided

region is shown in Appendix E.

5.2.1 Analysis of paired samples

If the samples are paired, we can also analyze them as such. To show this,
let’s pretend that the samples in our test data set are paired, and then use the
dmrFinder function with the "paired" argument set to TRUE and the "pairs"
argument specifying which samples are pairs. (In this example we also have to
lower the cutoﬀ since there are not enough samples to ﬁnd any regions with the
default cutoﬀ of 0.995.)

R> pData(rawData)$pair = c(1,1,2,2,1,2)
R> dmr2 <- dmrFinder(rawData, p=p0, groups=pd$tissue,

compare=c("colon", "liver","colon", "spleen"),
removeIf=expression(nprobes<4 | abs(diff)<.05 | abs(maxdiff)<.05),
paired=TRUE, pairs=pData(rawData)$pair, cutoff=0.95)

============================================================

We plot the, say, third DMR with the dmrPlot function (shown in Appendix

F)

13

R> dmrPlot(dmr=dmr2, which.table=1, which.plot=c(3), legend.size=1, all.lines=TRUE,

all.points=FALSE, colors.l=c("blue","black"), colors.p=c("blue","black"),
outpath=".", cpg.islands=cpg.cur, Genome=Hsapiens)

============================================================

Plotting finished.

Plotting user-provided regions using the results of paired analysis is done

using the regionPlot function as before (shown in Appendix G).

R> regionPlot(tab=mytab, dmr=dmr2, cpg.islands=cpg.cur, Genome=Hsapiens,
outfile="myregions_paired.pdf", which.plot=1:5,
plot.these=c("colon-liver"), cl=c("black"), legend.size=1, buffer=3000)

============================================================
1

Plotting finished.

References

[1] Martin J. Aryee, Zhijin Wu, Christine Ladd-Acosta, Brian Herb, Andrew P.
Feinberg, Srinivasan Yegnasubramanian, and Rafael A. Irizarry. Accurate
genome-scale percentage dna methylation estimates from microarray data.
Biostatistics, 12(2):197–210, 2011.

[2] Irizarry et al. Comprehensive high-throughput arrays for relative methyla-

tion (charm). Genome Research, 18(5):780–790, 2008.

[3] Wu et al. Redeﬁning cpg islands using a hierarchical hidden markov model.

Biostatistics, 11(3):499–514, 2010.

6 Appendix A: Quality report

14

441_colon441_liver441_spleen449_liver449_spleen624_colonllllll7075808590Signal strengthllllll0.00.10.20.30.4Channel 1standard deviationllllll0.00.10.20.30.4Channel 2standard deviationSignal strength histogramSignal strengthFrequency787980818283840.00.51.01.52.0Untreated Channel: PM probe quality441_colon30507090441_liver30507090441_spleen30507090449_liver30507090449_spleen30507090624_colon30507090Enriched Channel: PM signal intensity441_colon89101112441_liver89101112441_spleen89101112449_liver89101112449_spleen89101112624_colon891011127 Appendix B: Density plots

Each row corresponds to one stage of the normalization process (Raw data,
After spatial and background correction, after within-sample normalization, af-
ter between-sample normalization, percentage methylation estimates). The left
column shows all probes, while the right column shows control probes.

18

−4−202460.00.20.40.60.81. Raw All probesMcolonliverspleen−4−202460.00.20.40.61. Raw Control probesMDensitycolonliverspleen−4−202460.00.20.42. After spatial & bg All probesMcolonliverspleen−4−202460.00.20.42. After spatial & bg Control probesMDensitycolonliverspleen−4−202460.00.10.20.33. After within−sample norm All probesMcolonliverspleen−4−202460.00.20.40.60.83. After within−sample norm Control probesMDensitycolonliverspleen−4−202460.000.100.200.304. After between−sample norm All probesMcolonliverspleen−4−202460.00.20.40.64. After between−sample norm Control probesMDensitycolonliverspleen0.00.20.40.60.81.00.00.51.01.55. Percentage methylation All probescolonliverspleen0.00.20.40.60.81.0012345675. Percentage methylation Control probesDensitycolonliverspleen8 Appendix C: MDS plot

20

llllll−40−20020−30−20−1001020cMDSDoes not use probes in sex chromosomes.Using the 1e+05 most variable probes, out of 145217 total.lllcolonliverspleen9 Appendix D: DMR plot

DMR plot for the ﬁrst DMR in the list.

22

1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110.00.20.40.60.81.0p222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444colon *liver *spleen882710008827200088273000882740000.000.050.100.15LocationCpG densityID:1−−chr12:88270323−8827421110 Appendix E: Plot of an arbitrary genomic

region

For the arbtirary region we just chose the ﬁrst DMR.

24

111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110.00.20.40.60.81.0positionp222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222223333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333344444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444colonliver88270000882710008827200088273000882740000.000.050.100.15LocationCpG densityID:1−−chr12:88272817−8827381111 Appendix F: DMR plot from analysis of paired

samples

DMR plot for the third DMR in the list

26

−1.0−0.50.00.51.0difference in p111111111111111111111111111111111111111111111111111111111111111111111111222222222222222222222222222222222222222222222222222222222222222222222222colon−liver *1     Pair 12     Pair 21985001990001995002000002005002010002015002020000.000.050.100.15LocationCpG densityID:3−−chr17:198374−20192012 Appendix G: Plot of an arbitrary genomic

region, shown using paired results

For the arbtirary region we simply chose the same ﬁrst DMR as in appendix
E.

28

−1.0−0.50.00.51.0difference in p1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111122222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222colon−liver88270000882710008827200088273000882740000.000.050.100.15LocationCpG densityID:1−−chr12:88269837−8827421113 Details

This document was written using:

R> sessionInfo()

R version 3.5.1 Patched (2018-07-12 r74967)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.5 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:

[1] stats4
[6] grDevices utils

grid

parallel stats
datasets methods

graphics
base

other attached packages:

[1] corpcor_1.6.9
[2] BSgenome.Hsapiens.UCSC.hg18_1.3.1000
[3] BSgenome_1.50.0
[4] rtracklayer_1.42.0
[5] GenomicRanges_1.34.0
[6] GenomeInfoDb_1.18.0
[7] charmData_1.18.0
[8] pd.charm.hg18.example_0.99.4
[9] DBI_1.0.0

[10] oligo_1.46.0
[11] Biostrings_2.50.0
[12] XVector_0.22.0
[13] IRanges_2.16.0
[14] S4Vectors_0.20.0
[15] oligoClasses_1.44.0
[16] RSQLite_2.1.1
[17] charm_2.28.0
[18] genefilter_1.64.0
[19] RColorBrewer_1.1-2
[20] fields_9.6

30

[21] maps_3.3.0
[22] spam_2.2-0
[23] dotCall64_1.0-0
[24] SQN_1.0.5
[25] nor1mix_1.2-3
[26] mclust_5.4.1
[27] Biobase_2.42.0
[28] BiocGenerics_0.28.0

loaded via a namespace (and not attached):

[1] locfit_1.5-9.1
[3] lattice_0.20-35
[5] gtools_3.8.1
[7] foreach_1.4.4
[9] zlibbioc_1.28.0

Rcpp_0.12.19
Rsamtools_1.34.0
digest_0.6.18
sva_3.30.0
annotate_1.60.0
Matrix_1.2-15
splines_3.5.1
RCurl_1.95-4.11
DelayedArray_0.8.0
pkgconfig_2.0.2
mgcv_1.8-25

[11] blob_1.1.1
[13] preprocessCore_1.44.0
[15] BiocParallel_1.16.0
[17] bit_1.1-14
[19] compiler_3.5.1
[21] multtest_2.38.0
[23] SummarizedExperiment_1.12.0 GenomeInfoDbData_1.2.0
[25] ff_2.2-14
[27] matrixStats_0.54.0
[29] GenomicAlignments_1.18.0
[31] bitops_1.0-6
[33] xtable_1.8-3
[35] limma_3.38.2
[37] siggenes_1.56.0
[39] bit64_0.9-7
[41] AnnotationDbi_1.44.0
[43] memoise_1.1.0

codetools_0.2-15
XML_3.98-1.16
MASS_7.3-51.1
nlme_3.1-137
affyio_1.52.0
iterators_1.0.10
tools_3.5.1
survival_2.43-1
BiocManager_1.30.3
affxparser_1.54.0

31

