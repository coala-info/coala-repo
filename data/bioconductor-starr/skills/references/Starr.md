Starr: Simple Tiling ARRay analysis
for Aﬀymetrix ChIP-chip data

Benedikt Zacher, Achim Tresch

April 24, 2017

1 Introduction

Starr is an extension of the Ringo [6] package for the analysis of ChIP-chip projects. Whereas
the latter is specialized to the processing of Nimblegen and Agilent arrays, the former provides
all corresponding features for Aﬀymetrix arrays. Data can be read in from Aﬀymetrix CEL-ﬁles,
or from text ﬁles in gﬀ format. Standard quality assessment and data normalization tools are
available. Starr uses the Bioconductor ExpressionSet class for data storage. The probeAnno class
from Ringo serves as a mapping of the ChIP signals onto the genomic position. Consequently,
all functions from Ringo that operate on either ExpressinoSet or probeAnno can be used without
modiﬁcation. These include smoothing operations, peak-ﬁnding, and quality control plots. Starr
adds new options for high-level analysis of ChIP-chip data. We demonstrate Starr’s facilities at
the example of an experiment that compares DNA binding under two diﬀerent conditions. Three
chips have been produced, two contain the actual immunoprecipitated DNA, and the other one is
a control experiment.

> library(Starr)

2 Reading the data

To read Aﬀymetrix tiling array data, two diﬀerent ﬁle types are required. The bpmap ﬁle contains
the mapping of the physical position on the array to the genomic position of the probe sequences.
The CEL ﬁle delivers the measured intensities from the scanner. The data included in this package
contains the ﬁrst 80000 bp from chromosome 1 of a real ChIP-chip experiment in yeast. Artiﬁcial
bpmap and CEL ﬁles were constructed for demonstration purposes. Two ChIP-chip experiments
were performed with TAP-tagged RNA Polymerase II subunit Rpb3. For the control experiment,
the ChIP-chip protocol has exactly been reproduced with wild type cells (i.e. with no TAP-tag to
Rpb3). The readBpmap() function from the aﬀxparser package reads the bpmap ﬁle.

> dataPath <- system.file("extdata", package="Starr")
> bpmapChr1 <- readBpmap(file.path(dataPath, "Scerevisiae_tlg_chr1.bpmap"))

The function readCelFile() reads one or more CEL ﬁles and stores them in an ExpressionSet.
Additionally to the path to the CEL ﬁles, experiment names and the type of experiment must be
speciﬁed. An optional experimentData object can be included. This is a ”MIAME” object, which
includes information about the experiment (e.g. the investigator or lab where the experiment was
done, an overall title, etc.).

> cels <- c(file.path(dataPath,"Rpb3_IP_chr1.cel"), file.path(dataPath,"wt_IP_chr1.cel"),
+

file.path(dataPath,"Rpb3_IP2_chr1.cel"))

1

> names <- c("rpb3_1", "wt_1","rpb3_2")
> type <- c("IP", "CONTROL", "IP")
> rpb3Chr1 <- readCelFile(bpmapChr1, cels, names, type, featureData=T, log.it=T)

Now we give a very short introduction to the ExpressionSet class. For a more detailed view,
please refer to ”An Introduction to Bioconductor’s ExpressionSet Class” [4]. A summary of the
ExpressionSet can be shown with:

> rpb3Chr1

ExpressionSet (storageMode: lockedEnvironment)
assayData: 20000 features, 3 samples

element names: exprs

protocolData: none
phenoData

sampleNames: rpb3_1 wt_1 rpb3_2
varLabels: type CEL
varMetadata: labelDescription

featureData

featureNames: 1 2 ... 20000 (20000 total)
fvarLabels: chr seq pos
fvarMetadata: labelDescription

’

experimentData(object)

’

experimentData: use
Annotation:

The ExpressionSet in this case consists of three diﬀerent objects. Optinally, a MIAME object
can be added as just described. In the following, a short description of the components of rpb3Chr1
is given:

1. The assayData is a matrix with the measured signals.

> head(exprs(rpb3Chr1))

wt_1

rpb3_1

rpb3_2
1 14.51089 14.42134 15.39158
2 12.67154 14.12533 12.88817
3 14.49791 14.09515 15.21496
4 11.89860 13.72238 12.61816
5 13.75071 13.73682 15.05078
6 11.35590 13.00545 12.09935

2. Phenotypic data summarizes information about the samples (e.g., information about type of
experiment, such as tagged IP, raw IP, input DNA, ...). The rownames of the phenotypic data
are equal to the colnames of the assayData. The information about the type of experiment
is needed for the normalization.

> pData(rpb3Chr1)

rpb3_1
wt_1
rpb3_2

type
IP
CONTROL
IP

CEL
rpb3_1 /tmp/RtmpNExS17/Rinst3f222071ef9d/Starr/extdata/Rpb3_IP_chr1.cel
/tmp/RtmpNExS17/Rinst3f222071ef9d/Starr/extdata/wt_IP_chr1.cel
wt_1
rpb3_2 /tmp/RtmpNExS17/Rinst3f222071ef9d/Starr/extdata/Rpb3_IP2_chr1.cel

2

3. The featureData in this case contains information from the bpmap ﬁle. The featureNames
correspond to the rownames of the assayData of the ExpressionSet. With the featureData,
each ChIP-signal from the expression matrix can be mapped to the chromosome and its
position on it, as well as its genomic sequence. This information can be used for sequence
speciﬁc normalization methods.

> featureData(rpb3Chr1)

An object of class

’

AnnotatedDataFrame

’

featureNames: 1 2 ... 20000 (20000 total)
varLabels: chr seq pos
varMetadata: labelDescription

> head(featureData(rpb3Chr1)$chr)

[1] chr1 chr1 chr1 chr1 chr1 chr1
Levels: chr1

> head(featureData(rpb3Chr1)$seq)

[1] "GTGTGGGTGTGTGGGTGTGGTGTGG" "ACCACACCCACACACCCACACACCA"
[3] "GGTGTGGTGTGTGGGTGTGTGGGTG" "CACACACCCACACACCACACCACAC"
[5] "TGGTGTGTGGTGTGGTGTGTGGGTG" "CACACACCACACCACACACCACACC"

> head(featureData(rpb3Chr1)$pos)

[1] 1 5 9 13 17 21

3 Diagnostic plots

Since the probes are placed on the array in a randomized way, localized signal distortions are
most likely due to technical artefacts. A reconstruction of the array image helps to identify these
defects. The plotImage() function constructs a reconstruction of the artiﬁcial array, used in this
example (see ﬁgure 1).

> plotImage(file.path(dataPath,"Rpb3_IP_chr1.cel"))

Besides that, Starr provides diﬀerent diagnostic plots for the visual inspection of the data.
These plots should help to ﬁnd an appropriate normalization method. The densityplots and the
boxplots show the distribution of the measured intensities (see ﬁgure 2).

> par(mfcol=c(1,2))
> plotDensity(rpb3Chr1, oneDevice=T, main="")
> plotBoxes(rpb3Chr1)

To compare the diﬀerent experiments, the plotScatter() function can be applied. This produces
a matrix of pairwise scatterplots in the upper panel and pearson correlation in the lower panel.
The density of the data points can be visualized with a color gradient (see ﬁgure 3).

> plotScatter(rpb3Chr1, density=T, cex=0.5)

3

Figure 1: Spatial distribution of raw reporter intensities of the artiﬁcial array

Figure 2: Density- and boxplots of the logged intensities

4

Figure 3: A scatterplot matrix, showing the correlation in the lower panel. In the scatterplots,
the density of the points is illustrated with a color gradient.

MA-plots are a classic and important quality control plot to spot and correct saturation-
dependent eﬀects in the log enrichment. For each probe, the log enrichment M is plotted versus
Ideally, the measured enrichment
the average log intensities of signal and reference (A-value).
should be independent of the mean intensity A of signal and reference. But if e.g. the signal
and the reference measurements have diﬀerent saturation characteristics, then e.g. M will show a
dependence on A. plotMA() constructs MA plots of all pairs of Immunoprecipitation and control
experiments (see ﬁgure 4).

> ips <- rpb3Chr1$type == "IP"
> controls <- rpb3Chr1$type == "CONTROL"
> plotMA(rpb3Chr1, ip=ips, control=controls)

The last diagnostic plot shown here is about the sequence depedent bias of the probe intensities
(see ﬁgure 5). The raw logged intensity depends on the GC-content of the probe sequence. But
there is also a remarkable dependency on base position within the sequence.

> par(mfcol=c(1,2))
> plotGCbias(exprs(rpb3Chr1)[,1], featureData(rpb3Chr1)$seq, main="")
> plotPosBias(exprs(rpb3Chr1)[,1], featureData(rpb3Chr1)$seq)

4 Normalization of the data

After quality assessment, we perform normalization of the raw data. Here we use the cyclic loess
normalization.

> rpb3_loess <- normalize.Probes(rpb3Chr1, method="loess")

5

Figure 4: Pairwise MA-plots of all pairs of Immunoprecipitation and control experiments. Both
plots show a dependency between A and M value.

Figure 5: Sequence-speciﬁc hybridization bias (raw data). The raw logged intensity depends on
the GC-content of the probe sequence. But there is also a remarkable dependency on base position
within the sequence.

6

Besides this normalization method, there are e.g. median rank percentile [2], scale, quantile,
vsn, MAT and some others available. After normalization, we perform again diagnositc plots to
assert that the normalization was appropriate for the correction of the systematic measurement
errors. The MA-plot of the normalized data does not show any dependence of the M and A values
(see ﬁgure 6).

> plotMA(rpb3_loess, ip=ips, control=controls)

Figure 6: MA-plot of normalized data. There is no dependency between A- and M-value observed
any more.

Now we calculate the ratio of the probe intensities. Median values over replicates are taken.

> description <- c("Rpb3vsWT")
> rpb3_loess_ratio <- getRatio(rpb3_loess, ips, controls, description, fkt=median, featureData=F)

It is very important that the control or reference experiment is able to correct the sequence-
dependent bias on probe intensity, which is shown in ﬁgure 5. In this case the normalization and
reference experiment was adequate to correct all systematic biases in the data (see ﬁgure 7).

> par(mfcol=c(1,2))
> plotGCbias(exprs(rpb3_loess_ratio)[,1], featureData(rpb3_loess)$seq, main="")
> plotPosBias(exprs(rpb3_loess_ratio)[,1], featureData(rpb3_loess)$seq, ylim=c(-0.5,0.5))

5 Data analysis

Besides the typical ChIP-chip analysis of the data, like visualization (see Ringo) or peak ﬁnding,
Starr provides additional useful functions to analyze ChIP-signals along speciﬁc genomic regions.
For this purpose, we need a mapping of the probe intensities in our ExpressionSet to the genomic
positions. To achieve that, we construct a probeAnno object (as provided by Ringo). The object

7

Figure 7: Dependency of probe intensity on sequences (normalized ratio). The systematic bias
could be corrected.

consists of four vectors of equal length and ordering for each chromosome. The vectors specify
probe start and end, as well as the index of the probe intensity in the ExpressionSet. The unique
vector encodes how many matches the corresponding probe has on the given array. An entry of
’0’ indicates that the probe matching at this position has only this one match. See Ringo for a
detailed description of the probeAnno class.
If the array was designed on an outdated assembly of the genome, a re-mapping of reporters to
the genome can be necessary. Further on, the unique vector does possibly not identify all probes,
that match the genome uniquely at the sepciﬁed position. A re-mapping can be used to identify
all uniquely matching reporters.

> probeAnnoChr1 <- bpmapToProbeAnno(bpmapChr1)

5.1 Remapping probes to a current genome build

Starr provides an easy-to-use method for remapping probe sequences and building new bpmap
annotation. It implements the Aho-Corasick [1] string matching algorithm, which is designed for
searching a given set of sequences in a text. The genomic sequences must be provided as fasta ﬁles.
Each ﬁle is supposed to contain one chromosome. The sequences to be searched can be passed to
the function either as a character vector or as a bpmap list (returned by RmethodreadBpmap).
An example below, shows how to match the sequences of the given bpmap ﬁle from above to
chromosome 1 of S. cerevisiae. Sequences in this bpmap ﬁle are taken from both strands in 5(cid:48) → 3(cid:48)
direction, that means we have to search the +1 and -1 strand. The sequence of chromosome 1 is
stored in a fasta ﬁle chrI.fa in the dataPath folder.

> newbpmap <- remap(bpmapChr1, path=dataPath, reverse_complementary=TRUE, return_bpmap=TRUE)

Number of nodes: 365098
Searching: chrI
89.5 % of the probes could be mapped uniquely.

In this case, 89.5 % of the probe sequences could be mapped to a unique position on chromosome

1. The method returns a list in the output format of the aﬀxparser function readBpmap.

8

array
S. cerevisiae Tiling 1.0R
Drosophila Tiling 2.0R
Human Promoter 1.0R

time
34 s
1 min 16s
14 min 22 s

#sequences
2 697 594
2 907 359
4 315 643

genome size (bp)
12 495 682
122 653 977
3.3 ∗ 109

Table 1: Time for remapping of reporter sequences from Aﬀymetrix tiling arrays to a current
genome build. Results were calculated on an Intel Core Duo E8600 3.33 GHz machine.

> str(newbpmap)

List of 1

$ chrI:List of 8

: chr "chrI"
: chr ""
: chr "chrI"
: chr ""
: chr "onlypm"
: int 1

..$ seqInfo :List of 7
.. ..$ name
.. ..$ groupname
.. ..$ fullname
.. ..$ version
.. ..$ mapping
.. ..$ number
.. ..$ numberOfHits: int 17900
..$ pmx
..$ pmy
..$ mmx
..$ mmy
..$ probeseq: chr [1:17900] "GTGTGGGTGTGTGGGTGTGGTGTGG" "ACCACACCCACACACCCACACACCA" "GGTGTGGTGTGTGGGTGTGTGGGTG" "CACACACCCACACACCACACCACAC" ...
..$ strand : int [1:17900] 0 1 0 1 0 1 0 1 0 1 ...
..$ startpos: int [1:17900] 1 5 9 13 17 21 25 29 33 37 ...

: int [1:17900] 129 129 27 27 170 170 131 131 130 130 ...
: int [1:17900] 0 100 86 186 42 142 66 166 75 175 ...
: NULL
: NULL

One can use this list either to write a new binary bpmap ﬁle, or to create a new probeAnno
object. Note, that this bpmap ﬁle diﬀers from the original ﬁle. Consequently, one has to read in the
data using this ﬁle, otherwise the probeAnno object will not be compatible with the ExpressionSet.

> writeTpmap("newbpmap.tpmap", newbpmap)
> tpmap2bpmap("newbpmap.tpmap", "newbpmap.bpmap")
> pA <- bpmapToProbeAnno(newbpmap)

The function works eﬃcinetly for all sizes of genomes. Table 1 shows a comparison of compu-
tation time for diﬀerent Aﬀymetrix tiling arrays. If the memory on your machine is not suﬃcient
for the amount of sequences that should be mapped, the parameter nseq can be set to search the
sequences in more than one iteration.

5.2 Analyse the correlation of ChIP signals to other data

In the following section we want to demonstrate, how the binding proﬁles of the protein of interest
can be analyzed over annotated genomic features. First we read in a gﬀ ﬁle, which contains anno-
tations for transcription start (TSS) and termination sites (TTS) of some genes on chromosome
1 [3]. The ﬁlterGenes() function ﬁlters the annotated features with respect to length, overlaps or
distance to other features. In this case the genes are supposed to have a minimal length of 1000
base pairs.

> transcriptAnno <- read.gffAnno(file.path(dataPath, "transcriptAnno.gff"), feature="transcript")
> filteredIDs <- filterGenes(transcriptAnno, distance_us = 0, distance_ds = 0, minLength = 1000)

The correlationPlot() can then be used to visualize e.g.

the correlation between the mean
binding intensity of speciﬁc regions around these transcripts and gene expression. First we need

9

to deﬁne the regions around the annotated features, that we want to analyze. This is realised with
a data frame.

> pos <- c("start", "start", "start", "region", "region","region","region", "stop","stop","stop")
> upstream <- c(500, 0, 250, 0, 0, 500, 500, 500, 0, 250)
> downstream <- c(0, 500, 250, 0, 500, 0, 500, 0, 500, 250)
> info <- data.frame(pos=pos, upstream=upstream, downstream=downstream, stringsAsFactors=F)

Every row of this data frame represents one region, ﬂanking the annotated features. The ﬁrst
row e.g.
indicates, that we want to calculate the mean ChIP signal 500 bp upstream and 0 bp
downstream around the start of the feature. The term “region” means in this context the area
between start and stop of the feature. Once we have deﬁned these regions, we use the getMeans()
function to calculate the mean intensity over these regions for each transcript in our gﬀ annotation.
This function returns a list. Each entry of the list represents one of the regions deﬁned above and
contains a vector with all mean signals of the annotated featues.

> means_rpb3 <- getMeans(rpb3_loess_ratio, probeAnnoChr1, transcriptAnno[which(transcriptAnno$name %in% filteredIDs),], info)

Now, that we have the mean ChIP signals, we could deﬁne another vector, which contains e.g.
gene expression values and visualize the correlation of the speciﬁc regions to the expression value.
For this purpose the function correlate() from this package can be used to easily calculate the
correlation between the diﬀerent areas and the corresponding expression value. In this example,
we just plot the mean signal over the diﬀerent areas. The last thing we need to deﬁne for the
visualization is the order of the boxes in the lower panel of the plot (see ﬁgure 8). In this lower
panel, the diﬀerent regions along the transcript, deﬁned in the data frame info are shown. The
numbering of the levels starts at the bottom with level 1. Now we add this information to the
data frame and call correlationPlot().

> info$cor <- sapply(means_rpb3, mean, na.rm=T)
> level <- c(1, 1, 2, 3, 4, 5, 6, 1, 1, 2)
> info$level <- level
> correlationPlot(info, labels=c("TSS", "TTS"))

5.3 Visualization of a set of “proﬁles”

Starr provides functions for the visualization of a set of “proﬁles” (e.g. time series, signal levels
along genomic positions). Suppose that we are interested in the ChIP proﬁle of a protein along
the transcription start site. One way of looking over the inensity proﬁles is to take the mean
intensity at each available position along this region. This illustration gives a ﬁrst view of the
main tendency in the proﬁles. But some proﬁles with e.g. extremely high values can easily lead to
a distorted mean proﬁle. To get a more detailed view on a group of proﬁles and their divergence,
we developed the proﬁleplot.
In this function, the proﬁles are given as the rows of a samples times × positions matrix that
contains the respective signal of a sample at given position. Instead of plotting a line for each
proﬁle (e.g. column of the row), the q-quantiles for each position (e.g. column of the matrix) are
calculated, where q runs through a set of representative quantiles. Then for each q, the proﬁle
line of the q-quantiles is plotted. Color coding of the quantile proﬁles aids the interpretation
of the plot: There is a color gradient from the median proﬁle to the 0 (=min) resp. 1 (=max)
quantile. The following example shows how this function is used. First we construct an example
data matrix.

> sampls = 100
> probes = 63

10

Figure 8: correlationPlot of the mean intensities over areas around transcription start site (TSS)
and the transcription termination site (TTS) of annotated transcripts from chromosome 1 [3]. The
lower panel shows the the analyzed regions. The upper panel shows the mean intensity over the
individual regions.

> at = (-31:31)*14
> clus = matrix(rnorm(probes*sampls,sd=1),ncol=probes)
> clus= rbind( t(t(clus)+sin(1:probes/10))+1:nrow(clus)/sampls , t(t(clus)+sin(pi/2+1:probes/10))+1:nrow(clus)/sampls )

Next, we apply kmeans clustering to identify two diﬀerent clusters and construct a “character”

vector, that indicates to which cluster an individual proﬁle belongs.

> labs = paste("cluster",kmeans(clus,2)$cluster)

Then we apply the proﬁleplot function. In this case, the quantiles from the 5%- to the 95%-
quantile are shown with the color gradient (see ﬁgure 9). The median is shown as black line. The
25%- and the 75%-quantile are shown as grey lines. The grey lines in the background show the
original proﬁles of the diﬀerent clusters.

> par(mfrow=c(1,2))
> profileplot(clus,label=labs,main="Clustered data",colpal=c("heat","blue"),add.quartiles=T,fromto=c(0.05,0.95))

5.4 Visualize proﬁles of ChIP signals along genomic features

With the just described methods, one can easily visualize ChIP proﬁles over annotated features
of groups of genes (e.g. diﬀerent groups of genes identiﬁed by a clustering method). To exemplify
the usage of this visualization method, we build a gﬀ annotation for the transcription start sites
from our transcript annotation. For that purpose, we use the transcript annotation and set the
end position of each transcript to its start site.

> tssAnno <- transcriptAnno
> watson <- which(tssAnno$strand == 1)

11

Figure 9: proﬁleplot of two clusters identiﬁed by kmeans clustering. The quantiles from the 5%-
to the 95%-quantile are shown with the color gradient. The median is shown as black line. The
25%- and the 75%-quantile are shown as grey lines. The grey lines in the background show the
original proﬁles of the diﬀerent clusters.

> tssAnno[watson,]$end <- tssAnno[watson,]$start
> crick <- which(tssAnno$strand == -1)
> tssAnno[crick,]$start <- tssAnno[crick,]$end

Then we use the getProﬁles() function to obtain the proﬁles over 500 bp upstream and down-
stream around the transcription start site. The function constructs a list with the proﬁles and
stores information about the border (like TSS, TTS, start, stop codon, etc.), as well as the length
of the ﬂanking upstream and downstream areas (500 bp here).

> profile <- getProfiles(rpb3_loess_ratio, probeAnnoChr1, tssAnno, 500, 500, feature="TSS", borderNames="TSS", method="basewise")

Further on, we use the plotProﬁles() function generate a plot of the mean ChIP proﬁles and a

proﬁleplot (as described in the previous section) of the annotated features (see ﬁgure 10).

> clust <- rep(1, dim(tssAnno)[1])
> names(clust) <- tssAnno$name
> plotProfiles(profile, cluster=clust)

5.5 Peak-ﬁnding with CMARRT

Starr implements the CMARRT [5] agorithm for identiﬁcation of bound regions. CMARRT ex-
tends the standard moving average approach commonly used in the analysis of ChIP-chip data
by incorporating the correlation structure in identifying bound regions for data from tiling ar-
rays. Probes are declared as bound using adjusted p-values for multiple comparisons under the
Gaussian approximation. The main function is cmarrt.ma which computes the p-values for each
probe by taking into account the correlation structure. CMARRT is developed using the Gaussian
approximation approach and thus it is important to check if this assumption is violated.

12

Figure 10: Visualization of the ChIP proﬁles along the transcription start site (TSS). On left left
side the mean proﬁle of the ChIP signals are shown. I.e., the mean signal at each available position
is plotted. The proﬁleplot on the rigtht side gives a more detailed view of the intensity proﬁles.

> peaks <- cmarrt.ma(rpb3_loess_ratio, probeAnnoChr1, chr=NULL, M=NULL, frag.length=300)

The function plotcmarrt produces the diagnostic plots (histogram of p-values and normal QQ
plots) for comparing the distribution of standardized MA statistics under correlation and indepen-
dence. If the distribution of the standardized moving average statistics S∗
is correctly speciﬁed,
i
the quantiles of S∗
i for unbound probes fall along a 45 degree reference line against the quantiles
from the standard Gaussian distribution. In addition, the p-values obtained should be a mixture of
uniform distribution between 0 and 1 and a non-uniform distribution concentrated near 0. Figure
shows the summary statistics.

> plotcmarrt(peaks)

The list of bound regions is obtained using the function cmarrt.peak for a given error rate

control which adjusts the p-values for multiple comparisons.

> peaklist <- cmarrt.peak(peaks, alpha = 0.05, method = "BH", minrun = 4)

> str(peaklist)

List of 2

$ cmarrt.bound:List of 6

: chr [1:36] "chr1" "chr1" "chr1" "chr1" ...

..$ Chr
..$ Start : num [1:36] 30185 32425 34061 34265 34725 ...
: num [1:36] 30645 32805 34233 34305 35105 ...
..$ Stop
..$ n.probe: int [1:36] 110 90 38 5 90 9 75 201 88 11 ...
..$ min.pv : num [1:36] 0.001515 0.0015 0.005989 0.010425 0.000189 ...
..$ ave.pv : num [1:36] 0.00683 0.00367 0.00864 0.01129 0.00263 ...

$ indep.bound :List of 6

..$ Chr
..$ Start : num [1:39] 11197 11289 14481 14541 14593 ...

: chr [1:39] "chr1" "chr1" "chr1" "chr1" ...

13

Figure 11: Normal quantile-quantile plots (qqplot) and histograms of p-values. The right panels
show the qqplot of Si and distribution of p-values under correlation structure. The bottom left
panel shows that if the correlation structure is ignored, the distribution of S∗
i for unbound probes
deviates from the standard Gaussian distribution. The top left panel shows that if the correlation
structure is ignored, the distribution of p-values for unbound probes deviates from the uniform
distribution for larger p-values.

14

: num [1:39] 11249 11581 14549 14609 14665 ...

..$ Stop
..$ n.probe: int [1:39] 8 68 12 12 13 15 6 11 4 8 ...
..$ min.pv : num [1:39] 1.16e-02 2.57e-08 8.63e-03 8.37e-03 5.86e-03 ...
..$ ave.pv : num [1:39] 0.01765 0.00225 0.01438 0.01367 0.0107 ...

The list of bound regions obtained under independence (ignoring the correlation structure) is

for comparison. It is not recommended to use this list for downstream analysis.

5.6 Peak-ﬁnding and visualization using Ringo

In this section we shortly present how functions from the package Ringo can be used for peak
ﬁnding and visualization. For a detailed description of the following work-ﬂow see the Ringo
vignette. Like it is recommended in the Ringo vignette, we ﬁrst need to smooth the ChIP-chip
intensities and deﬁne a threshold y0 for enriched regions.

> rpb3_ratio_smooth <- computeRunningMedians(rpb3_loess_ratio, probeAnno=probeAnnoChr1, allChr = "chr1", winHalfSize = 80, modColumn="type")
> sampleNames(rpb3_ratio_smooth) <- paste(sampleNames(rpb3_loess_ratio),"smoothed")
> y0 <- apply(exprs(rpb3_ratio_smooth), 2, upperBoundNull)

The cutoﬀ for maximum amount of base pairs at which enriched probes are condensed into
one ChIP enriched region is taken as the maximal transcript length. We use the Ringo function
ﬁndChersOnSmoothed() to identify ChIP enriched regions.

> distCutOff <- max(transcriptAnno$end - transcriptAnno$start)
> chers <- findChersOnSmoothed(rpb3_ratio_smooth, probeAnno=probeAnnoChr1, thresholds=y0, allChr="chr1", distCutOff=distCutOff, cellType="yeast", minProbesInRow = 10)

Then regions with a maximal distance of 500 bp upstream to a transcript are related to the
corresponding annotated features in the transcriptAnno. Below, ﬁve ChIP enriched regions that
could be associated to an annotated feature are shown. They are sorted by the highest smoothed
probe level in the enriched region.

> chers <- relateChers(chers, transcriptAnno, upstream=500)

> chersD <- as.data.frame.cherList(chers)
> chersD <- chersD[which(chersD$feature != ""),]
> chersD[order(chersD$maxLevel, decreasing=TRUE)[1:5],]

26 yeast.Rpb3vsWT smoothed.chrchr1.cher26 chr1 61959 63559
40 yeast.Rpb3vsWT smoothed.chrchr1.cher40 chr1 75155 75687
34 yeast.Rpb3vsWT smoothed.chrchr1.cher34 chr1 66251 67315
35 yeast.Rpb3vsWT smoothed.chrchr1.cher35 chr1 67411 67659
18 yeast.Rpb3vsWT smoothed.chrchr1.cher18 chr1 57999 58991

end cellType
yeast
yeast
yeast
yeast
yeast

name chr start

antibody features maxLevel

score
26 Rpb3vsWT smoothed YAL041W 1.426517 170.09384
40 Rpb3vsWT smoothed YAL036C 1.308477 46.86805
34 Rpb3vsWT smoothed YAL040C 1.177909 77.31863
35 Rpb3vsWT smoothed YAL040C 1.140377 20.82117
18 Rpb3vsWT smoothed YAL044C 1.123080 76.19462

Now we can plot the ChIP-enriched region, which was related to the feature with the maximal

signal within the enriched area. Figure 12 shows this region.

15

Figure 12: One of the identiﬁed Rpb3-antibody enriched regions on chromosome 1

6 Concluding Remarks

The package Starr facilitates the analysis of ChIP-chip data, in particular that of Aﬀymetrix. It
provides functions for data import, normalization and analysis. Besides that, high-level plots for
quality assessment and the analysis of ChIP-proﬁles and ChIP-signals are available. Functions for
smoothing operations, peak-ﬁnding, and quality control plots can be applied.

This vignette was generated using the following package versions:

(cid:136) R version 3.4.0 (2017-04-21), x86_64-pc-linux-gnu

(cid:136) Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_US.UTF-8, LC_COLLATE=C,

LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8,
LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8,
LC_IDENTIFICATION=C

(cid:136) Running under: Ubuntu 16.04.2 LTS

(cid:136) Matrix products: default

(cid:136) BLAS: /home/biocbuild/bbs-3.5-bioc/R/lib/libRblas.so

(cid:136) LAPACK: /home/biocbuild/bbs-3.5-bioc/R/lib/libRlapack.so

(cid:136) Base packages: base, datasets, grDevices, graphics, grid, methods, parallel, stats, utils

(cid:136) Other packages: Biobase 2.36.0, BiocGenerics 0.22.0, Matrix 1.2-9, RColorBrewer 1.1-2,
Ringo 1.40.0, Starr 1.32.0, aﬀxparser 1.48.0, aﬀy 1.54.0, lattice 0.20-35, limma 3.32.0

(cid:136) Loaded via a namespace (and not attached): AnnotationDbi 1.38.0, BiocInstaller 1.26.0,
DBI 0.6-1, IRanges 2.10.0, MASS 7.3-47, RCurl 1.95-4.8, RSQLite 1.1-2, Rcpp 0.12.10,
S4Vectors 0.14.0, XML 3.98-1.6, aﬀyio 1.46.0, annotate 1.54.0, bitops 1.0-6,
colorspace 1.3-2, compiler 3.4.0, digest 0.6.12, geneﬁlter 1.58.0, ggplot2 2.2.1, gtable 0.2.0,
lazyeval 0.2.0, memoise 1.1.0, munsell 0.4.3, plyr 1.8.4, preprocessCore 1.38.0,
pspline 1.0-17, scales 0.4.1, splines 3.4.0, stats4 3.4.0, survival 2.41-3, tibble 1.3.0,
tools 3.4.0, vsn 3.44.0, xtable 1.8-2, zlibbioc 1.22.0

16

00.20.40.60.81Fold change [log]llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllRpb3vsWT smoothedYAL060W3550036000365003700037500Chromosome chr1 coordinate [bp]Acknowledgments

I thank Michael Lidschreiber, Andreas Mayer and Kemal Akman for their help. Further on, I
want to thank the reviewer for useful comments on the package.

References

[1] A. V. Aho and M. J. Corasick. Eﬃcient string matching: an aid to bibliographic search.

Communications of the ACM, 18(36):333–340, 1975.

[2] M. J. Buck and J. D. Lieb. Chip-chip: considerations for the design, analysis, and application
of genome-wide chromatin immunoprecipitation experiments. Genomics, 83(3):349–360, 2004.

[3] L. David, W. Huber, M. Granovskaia, J. Toedling, C. J. Palm, L. Bofkin, T. Jones, R. W.
Davis, and L. M. Steinmetz. A high-resolution map of transcription in the yeast genome. Proc
Natl Acad Sci U S A, 103(14):5320–5325, 2006.

[4] S. Falcon, M. Morgan,

and R. Gentleman.

An Introduction to Bioconductor’s
http://wiki.biostat.berkeley.edu/˜bullard/courses/Tmexico-

ExpressionSet
08/resources/ExpressionSetIntroduction.pdf, February 2007.

Class.

[5] P. F. Kuan, H. Chun, and S. Keles. Cmarrt: a tool for the analysis of chip-chip data from
tiling arrays by incorporating the correlation structure. Pac Symp Biocomput, pages 515–526,
2008.

[6] J. Toedling, O. Sklyar, T. Krueger, J. J. Fischer, S. Sperling, and W. Huber. Ringo - an
R/Bioconductor package for analyzing ChIP-chip readouts. BMC Bioinformatics, 8:221, 2007.

17

