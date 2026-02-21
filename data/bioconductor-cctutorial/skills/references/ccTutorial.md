Analyzing ChIP-chip Data Using Bioconductor

Joern Toedling (cid:63), Wolfgang Huber

EMBL European Bioinformatics Institute, Wellcome Trust Genome Campus,
Hinxton, United Kingdom

(cid:63)Email: joern.toedling@curie.fr

Introduction

ChIP-chip, chromatin immunoprecipitation combined with DNA microarrays, is a widely
used assay for DNA-protein binding and chromatin plasticity, which are of fundamental
interest for the understanding of gene regulation.

The interpretation of ChIP-chip data poses two computational challenges: ﬁrst, what
can be termed primary statistical analysis, which includes quality assessment, data nor-
malization and transformation, and the calling of regions of interest; second, integrative
bioinformatic analysis, which interprets the data in the context of existing genome anno-
tation and of related experimental results obtained, for example, from other ChIP-chip
or (m)RNA abundance microarray experiments.

Both tasks rely heavily on visualization, which helps to explore the data as well as to
present the analysis results. For the primary statistical analysis, some standardization is
possible and desirable: commonly used experimental designs and microarray platforms
allow the development of relatively standard workﬂows and statistical procedures. Most
software available for ChIP-chip data analysis can be employed in such standardized
approaches [1–6]. Yet even for primary analysis steps, it may be beneﬁcial to adapt
them to speciﬁc experiments, and hence it is desirable that software oﬀers ﬂexibility in
the choice of algorithms for normalization, visualization and identiﬁcation of enriched
regions.

For the second task, integrative bioinformatic analysis, the datasets, questions, and
applicable methods are diverse, and a degree of ﬂexibility is needed that often can only
be achieved in a programmable environment.
In such an environment, users are not
limited to predeﬁned functions, such as the ones made available as “buttons” in a GUI,
but can supply custom functions that are designed toward the analysis at hand.

Bioconductor [7] is an open source and open development software project for the anal-
ysis and comprehension of genomic data, and it oﬀers tools that cover a broad range
of computational methods, visualizations, and experimental data types, and is designed

1

to allow the construction of scalable, reproducible and interoperable workﬂows. A con-
sequence of the wide range of functionality of Bioconductor and its concurrency with
research progress in biology and computational statistics is that using its tools can
be daunting for a new user. Various books provide a good general introduction to R
and Bioconductor (e.g., [8–10]) and most Bioconductor packages are accompanied by
extensive documentation. This tutorial covers basic ChIP-chip data analysis with Bio-
conductor. Among the packages used are Ringo [5], biomaRt [11] and topGO [12].

We wrote this document in the Sweave [13] format, which combines explanatory text and
the actual R source code used in this analysis [14]. Thus the analysis can be reproduced
by the reader. An R package ccTutorial that contains the data, the text and code
presented here, and supplementary text and code is available from the Bioconductor
Web site.

> library("Ringo")
> library("biomaRt")
> library("topGO")
> library("xtable")
> library("ccTutorial")
> library("lattice")

Reporters are the DNA sequences ﬁxed to the microarray; they are de-
Terminology.
signed to speciﬁcally hybridize with corresponding genomic fragments from the immuno-
precipitate. A reporter has a unique identiﬁer and a unique sequence, and it can appear
in one or multiple features on the array surface [15]. The sample is the aliquot of
immuno-precipitated or input DNA that is hybridized to the microarray. We shall call
a genomic region apparently enriched by ChIP a ChIP-enriched region.

The Data. We consider a ChIP-chip dataset on a post-translational modiﬁcation of
histone protein H3, namely tri-methylation of its Lysine residue 4, in short H3K4me3.
H3K4me3 has been associated with active transcription (e. g. , [16, 17]). Here, en-
richment for H3K4me3 was investigated in Mus musculus brain and heart cells. The
microarray platform is a set of four arrays manufactured by NimbleGen containing 390k
reporters each. The reporters were designed to tile 32,482 selected regions of the Mus
musculus genome (assembly mm5) with one base every 100 bp, with a diﬀerent set
of promoters represented on each of the four arrays [18, Methods: Condensed array
ChIP-chip]. We obtained the data from the GEO repository [19] (accession GSE7688).

Importing the data into R

For each microarray, the scanner output consists of two ﬁles, one holding the Cy3 in-
tensities (the untreated input sample), the other one the Cy5 intensities, coming from
the immuno-precipitated sample. These ﬁles are tab-delimited text ﬁles in NimbleGen’s
pair format. Since the reporters are distributed over four arrays, we have 16 ﬁles (4
microarrays × 2 dyes × 2 tissues).

2

> pairDir <- system.file("PairData",package="ccTutorial")
> list.files(pairDir, pattern="pair$")

[1] "47101_532.pair" "47101_635.pair" "48153_532.pair" "48153_635.pair"
[5] "48158_532.pair" "48158_635.pair" "48170_532.pair" "48170_635.pair"
[9] "48175_532.pair" "48175_635.pair" "48180_532.pair" "48180_635.pair"
[13] "48182_532.pair" "48182_635.pair" "49728_532.pair" "49728_635.pair"

One text ﬁle per array describes the samples, including which two pair ﬁles belong to
which sample. Another ﬁle, spottypes.text, describes the reporter categories on the
arrays.

We read in the raw reporter intensities and obtain four objects of class RGList, a class
deﬁned in package limma [20], one object per array type.

> RGs <- lapply(sprintf("files_array%d.txt",1:4),
readNimblegen, "spottypes.txt", path=pairDir)
+

See Text S1 for an extended description of the data import.

Quality assessment

In this step, we check the arrays for obvious artifacts and inconsistencies between array
subsets.

First, we look at the spatial distribution of the intensities on each array. See Text S1
for the ﬁgure and the source code. We do not see any artifacts such as scratches, bright
spots, or scanning-induced patterns that would render parts of the readouts useless.

On all arrays in our set, the Cy3 channel holds the intensities from the untreated in-
put sample, and the Cy5 channel holds the immunoprecipitate from brain and heart,
respectively. This experiment setup is reﬂected in the reporter intensity correlation per
channel (see Text S1). The correlation between the intensities of the input samples is
higher than between the ChIP samples (0.877 versus 0.734).

The Bioconductor package arrayQualityMetrics [21] oﬀers an extensive set of visual-
izations and metrics for assessing microarray data quality. Applied to this data set,
arrayQualityMetrics also indicates that the data are of good quality.

Mapping reporters to the genome

A mapping of reporters to genomic coordinates is usually provided by the array man-
ufacturer. Often, however, remapping the reporter sequences to the genome may be
required. Here, the microarray had been designed on an outdated assembly of the

3

mouse genome (mm5, May 2004). We remapped the reporter sequences to the current
assembly (mm9, July 2007).

We used Exonerate [22] for the remapping, requiring 97% sequence similarity for a
match. See Text S1 for details and the used scripts.

In Ringo, the mapping of reporters to the genome is stored in a probeAnno class object.
Text S1 contains details on its construction.

> data("probeAnno")
> allChrs <- chromosomeNames(probeAnno)

Genome Annotation

We want to relate ChIP-enriched regions to annotated genome elements, such as poten-
tial regulatory regions and transcripts. Using the Bioconductor package biomaRt [11], we
obtain an up-to-date annotation of the mouse genome from the Ensembl database [23].

The source code for creating the annotation table mm9genes is given in Text S1. The
table holds the coordinates, Ensembl gene identiﬁers, MGI symbols, and description of
all genes annotated for the mm9 mouse assembly.

> data("mm9genes")
> mm9genes[sample(nrow(mm9genes), 4),
+

c("name", "chr", "strand", "start", "end", "symbol")]

See the result in Table 1.

Moreover, we used biomaRt to retrieve the Gene Ontology (GO)[24] annotation for all
genes in the table. Find the source code and further details in Text S1.

> data("mm9.gene2GO")

For all genes, we stored which reporters, if any, are mapped inside the gene or in its 5kb
upstream region.

> data("mm9.g2p")

For later use, we determine which genes have a suﬃcient number – arbitrarily we say
ﬁve – of reporters mapped to their upstream region or inside and which genes also have
one or more GO terms annotated to them.

> arrayGenes <- names(mm9.g2p)[listLen(mm9.g2p)>=5]
> arrayGenesWithGO <- intersect(arrayGenes, names(mm9.gene2GO))

4

Preprocessing

For each sample, we compute the log ratios log2(Cy5/Cy3) for all reporters. To adjust
for systematic dye and labeling biases, we compute Tukey’s biweight mean across each
sample’s log2 ratios and subtract it from the individual log2 ratios. Each of the four
microarray types contains a unique set of reporters. Thus, we preprocess the arrays
separately by type and combine the results into one object holding the preprocessed
readouts for all reporters.

preprocess(thisRG[thisRG$genes$Status=="Probe",],

> MAs <- lapply(RGs, function(thisRG)
+
+
> MA <- do.call(rbind, MAs)
> X <- asExprSet(MA)
> sampleNames(X) <- paste(X$Cy5, X$Tissue, sep=".")

method="nimblegen", returnMAList=TRUE))

The result is an object of class ExpressionSet, the Bioconductor class for storing prepro-
cessed microarray data. Note that ﬁrst creating an MAList for each array type, com-
bining them with rbind, and then converting the result into an ExpressionSet is only
necessary if the reporters are distributed over more than one microarray type. For data
of one microarray type only, you can call preprocess with argument returnMAList=-
FALSE and directly obtain the result as an ExpressionSet.

The above procedure is the standard method suggested by NimbleGen for ChIP-chip.
The appropriate choice of normalization method generally depends on the data at hand,
and the need for normalization is inversely related to the quality of the data. Ringo and
Bioconductor oﬀer many alternative and more sophisticated normalization methods,
e. g., using the genomic DNA hybridization as reference [25]. However, due to the
smaller dynamic range of the data in the input channel, such additional eﬀort seems less
worthwhile than, say, for transcription microarrays.

Visualizing Intensities along the Chromosome

We visualize the preprocessed H3K4me3 ChIP-chip reporter levels around the start of
the gene Actc1, which encodes the cardiac actin protein.

> plot(X, probeAnno, chrom="2", xlim=c(113.8725e6,113.8835e6),
+

’
ylim=c(-3,5), gff=mm9genes, paletteName=

’
Set2

)

The degree of H3K4me3 enrichment over the reporters mapped to this region seems
stronger in heart cells than in brain cells (see Figure 1). However, the signal is highly
variable and individual reporters give diﬀerent readouts from reporters matching ge-
nomic positions only 100 bp away, even though the DNA fragments after sonication are
hundreds of base pairs long.

5

See Figure S4 in Text S1 for the corresponding intensities around the start of the brain-
speciﬁc gene Crpm1 [26].

When multiple replicates are available, it is instructive to compare these visualizations
to assess the agreement between replicates.

Smoothing of Reporter Intensities

The signal variance arises from systematic and stochastic noise. Individual reporters
measure the same amount of DNA with diﬀerent eﬃciency due to reporter sequence
characteristics [27], such as GC content, secondary structure, and cross-hybridization.
To ameliorate these reporter eﬀects as well as the stochastic noise, we perform a smooth-
ing over individual reporter intensities before looking for ChIP-enriched regions. We slide
a window of 900 bp width along the chromosome and replace the intensity at genomic
position x0 by the median over the intensities of those reporters mapped inside the win-
dow centered at x0. Factors to take into account when choosing the width of the sliding
window are the size distribution of DNA fragments after sonication and the spacing
between reporter matches on the genome.

modColumn="Tissue", allChr=allChrs, winHalfSize=450, min.probes=5)

> smoothX <- computeRunningMedians(X, probeAnno=probeAnno,
+
> sampleNames(smoothX) <- paste(sampleNames(X),"smoothed",sep=".")
> combX <- cbind2(X, smoothX)

Compare the smoothed reporter intensities with the original ones around the start of
the gene Actc1.

> plot(combX, probeAnno, chrom="2", xlim=c(113.8725e6,113.8835e6),
+
+

ylim=c(-3,5), gff=mm9genes,
colPal=c(brewer.pal(8,"Set2")[1:2],brewer.pal(8,"Dark2")[1:2]))

See the result in Figure 2. After smoothing, the reporters give a more concise picture
that there is H3K4me3 enrichment inside and upstream of Actc1 in heart but not in
brain cells.

Finding ChIP-enriched Regions

We would like to determine a discrete set of regions that appear antibody-enriched,
together with a quantitative score of our conﬁdence in that and a measure of their
enrichment strength. Which approach is best for this purpose depends on the microarray
design, on the biological question and on the subsequent use of the regions, e.g., in
a follow-up experiment or computational analysis. Below, we describe one possible
approach, but before that we discuss two more conceptual aspects.

6

In the literature, a computed conﬁdence score is often mixed up with the term “p-
value”. Speaking of a p-value is meaningful only if there is a deﬁned null hypothesis and
a probability interpretation; these complications are not necessary if the goal is simply
to ﬁnd and rank regions in some way that can be reasonably calibrated.

Furthermore, it is helpful to distinguish between our conﬁdence in an enrichment be-
ing present, and the strength of the enrichment. Although stronger enrichments tend
to result in stronger signals and hence less ambiguous calls, our certainty about an
enrichment should also be aﬀected by reporter coverage, sequence, cross-hybridization
etc.

Let us now consider the following simple approach: for an enriched region, require that
the smoothed reporter levels all exceed a certain threshold y0, that the region contains
at least nmin reporter match positions, and that each of these is less than dmax basepairs
apart from the nearest other aﬀected position in the region.

The minimum number of reporters rule (nmin) might seem redundant with the smoothing
median computation (since a smoothed reporter intensity is already the median of all
the reporter intensities in the window), but it plays its role in reporter sparse regions,
where a window may only contain one or a few reporters. One wants to avoid making
calls supported by only few reporters.
The dmax rule prevents us from calling disconnected regions.

The optimal approach for setting the enrichment
Setting the Enrichment Threshold.
threshold y0 would be to tune it by considering sets of positive and negative control
regions. As such control regions are often not available, as with the current data, we
choose a mixture modeling approach.

The distribution of the smoothed reporter levels y can be modeled as a mixture of
two underlying distributions. One is the null distribution L0 of reporter levels in non-
enriched regions; the other is the alternative distribution Lalt of the levels in enriched
regions.

The challenge is to estimate the null distribution L0. In Ringo, an estimate (cid:98)L0 is derived
based on the empirical distribution of smoothed reporter levels, as visualized in Figure 3.

panel.histogram(x, col=brewer.pal(8,"Dark2")[panel.number()], ...)
panel.abline(v=y0[panel.number()], col="red")

> myPanelHistogram <- function(x, ...){
+
+
+ }
> h = histogram( ~ y | z,
+
+
+
+
+
+
> print(h)

data = data.frame(

layout = c(1,2), nint = 50,
xlab = "smoothed reporter level [log2]",
panel = myPanelHistogram)

y = as.vector(exprs(smoothX)),
z = rep(X$Tissue, each = nrow(smoothX))),

7

The histograms motivate the following assumptions on the two mixture components L0
and Lalt: the null distribution L0 has most of its mass close to its mode m0, which is
close to y = 0, and it is symmetric about m0; the alternative distribution Lalt is more
spread out and has almost all of its mass to the right of m0.

Based on these assumptions, we can estimate L0 as follows. The mode m0 can be found
by the midpoint of the shorth of those y that fall into the interval [−1, 1] (on a log2 scale).
The distribution L0 is then estimated from the empirical distribution of m0−|y−m0|, i. e.
by reﬂecting y < m0 onto y > m0. From the estimated null distribution, an enrichment
threshold y0 can be determined, for example the 99.9% quantile.

> y0 <- apply(exprs(smoothX), 2, upperBoundNull, prob=0.99)

The values y0 estimated in this way are indicated by red vertical lines in the histograms
in Figure 3. Antibodies vary in their eﬃciency to bind to their target epitope, and
the noise level in the data depends on the sample DNA. Thus, y0 should be computed
separately for each antibody and cell type, as the null and alternative distributions, L0
and Lalt, may vary.

This algorithm has been used in previous studies [28]. A critical parameter in algorithms
for the detection of ChIP-enriched regions is the fraction of reporters on the array that
are expected to show enrichment. For the detection of in-vivo TF binding sites, it is
reasonable to assume that this fraction is small, and most published algorithms rely on
this assumption. However, the assumption does not necessarily hold for ChIP against
histone modiﬁcations. The algorithm presented works as long as there is a discernible
population of non-enriched reporter levels, even if the fraction of enriched levels is quite
large.

Another aspect of ChIP-chip data is the serial correlation between reporters, and there
are approaches that aim to model such correlations [29, 30].

ChIP-enriched Regions. We are now ready to identify H3K4me3 ChIP-enriched regions
in the data. We set nmin = 5 and dmax = 450.

> chersX <- findChersOnSmoothed(smoothX,
+
+
+
+
+
+

probeAnno = probeAnno,
thresholds = y0,
allChr = allChrs,
distCutOff = 450,
minProbesInRow = 5,
cellType = X$Tissue)

We relate found ChIP-enriched regions to gene coordinates retrieved from the Ensembl
database (see above). An enriched region is regarded as related to a gene if its center
position is located less than 5 kb upstream of a gene’s start coordinate or between a
gene’s start and end coordinates.

8

> chersX <- relateChers(chersX, mm9genes, upstream=5000)

One characteristic of enriched regions that can be used for ranking them is the area
under the curve score, that is the sum of the smoothed reporter levels each minus the
threshold. Alternatively, one can rank them by the highest smoothed reporter level in
the enriched region.

> chersXD <- as.data.frame(chersX)
> head(chersXD[
+
+

order(chersXD$maxLevel, decreasing=TRUE),
c("chr", "start", "end", "cellType", "features", "maxLevel", "score")])

See the result in Table 2. We visualize the intensities around the region with the highest
smoothed level.

> plot(chersX[[which.max(chersXD$maxLevel)]], smoothX, probeAnno=probeAnno,
+

gff=mm9genes, paletteName="Dark2", ylim=c(-1,6))

Figure 4 displays this region, which covers the gene Tcfe3.

Comparing ChIP-enrichment between the Tissues

There are several ways to compare the H3K4me3 enrichment between the two tissues.
How many ChIP-enriched regions do we ﬁnd in each tissue?

> table(chersXD$cellType)

brain heart
11852 10391

Brain cells show a higher number of H3K4me3-enriched regions than heart cells. Which
genes show tissue-speciﬁc association to H3K4me3 ChIP-enriched regions?

> brainGenes <- getFeats(chersX[sapply(chersX, cellType)=="brain"])
> heartGenes <- getFeats(chersX[sapply(chersX, cellType)=="heart"])
> brainOnlyGenes <- setdiff(brainGenes, heartGenes)
> heartOnlyGenes <- setdiff(heartGenes, brainGenes)

We use the Bioconductor package topGO [12] to investigate whether tissue-speciﬁc
H3K4me3-enriched genes can be summarized by certain biological themes. topGO em-
ploys the Fisher test to assess whether among a list of genes, the fraction annotated with
a certain GO term is signiﬁcantly higher than expected by chance, considering all genes
that are represented on the microarrays and have GO annotation. We set a p-value cut-
oﬀ of 0.001, and the evaluation starts from the most speciﬁc GO nodes in a bottom-up
approach. Genes that are used for evaluating a node are not used for evaluating any of
its ancestor nodes [12, elim algorithm].

9

> brainRes <- sigGOTable(brainOnlyGenes, gene2GO=mm9.gene2GO,
+
> print(brainRes)

universeGenes=arrayGenesWithGO)

See the result GO terms in Table 3. We perform the same analysis for genes showing
heart-speciﬁc relation to H3K4me3 enrichment.

> heartRes <- sigGOTable(heartOnlyGenes, gene2GO=mm9.gene2GO,
+
> print(heartRes)

universeGenes=arrayGenesWithGO)

See the result in Table 4. Genes that show H3K4me3 in brain but not in heart cells
are signiﬁcantly often involved in neuron-speciﬁc biological processes. Genes marked
by H3K4me3 speciﬁcally in heart cells show known cardiomyocyte functions, amongst
others.

This analysis could be repeated for the cellular component and molecular function on-
tologies of the GO. Besides GO, other databases that collect gene lists can be used for
this kind of gene set enrichment analysis. For, example the Kyoto Encyclopedia of Genes
and Genomes (KEGG) [31] is also available in Bioconductor.

In Text S1, we present an additional way for comparing H3K4me3 enrichment between
the two tissue, an enriched-region-wise comparison considering the actual overlap of the
enriched regions.

ChIP Results and Expression Microarray Data

We compare the H3K4me3 ChIP-chip results with the expression microarray data, which
Barrera et al.[18] provide for the same M. musculus tissues they analyzed with ChIP-
chip.

> data("barreraExpressionX")

The data were generated using the Mouse_430_2 oligonucleotide microarray platform
from Aﬀymetrix and preprocessed using Aﬀymetrix’s MAS5 method. Using biomaRt,
we created a mapping of Ensembl gene identiﬁers to the probe set identiﬁers on that
microarray platform (see Text S1 for the source code).

> data("arrayGenesToProbeSets")

We obtain the expression values for genes related to H3K4me3-enriched regions in heart
or brain cells.

10

> bX <- exprs(barreraExpressionX)
> allH3K4me3Genes <- union(brainGenes, heartGenes)
> allH3K4ProbeSets <- unlist(arrayGenesToProbeSets[allH3K4me3Genes])
> noH3K4ProbeSets <- setdiff(rownames(bX), allH3K4ProbeSets)
> brainH3K4ExclProbeSets <- unlist(arrayGenesToProbeSets[brainOnlyGenes])
> heartH3K4ExclProbeSets <- unlist(arrayGenesToProbeSets[heartOnlyGenes])
> brainIdx <- barreraExpressionX$Tissue=="Brain"
> brainExpression <- list(
+
+
+
+
+ )

H3K4me3BrainNoHeartNo = bX[noH3K4ProbeSets, brainIdx],
H3K4me3BrainYes
H3K4me3BrainYesHeartNo = bX[brainH3K4ExclProbeSets, brainIdx],
H3K4me3BrainNoHeartYes = bX[heartH3K4ExclProbeSets, brainIdx]

= bX[allH3K4ProbeSets, brainIdx],

We use boxplots to compare the brain expression levels of genes with and without
H3K4me3 enriched regions in brain/heart cells.

’
gene expression level in brain cells

names=NA, varwidth=TRUE, log="y",
’
ylab=

> boxplot(brainExpression, col=c("#666666","#999966","#669966","#996666"),
+
+
> mtext(side=1, at=1:length(brainExpression), padj=1, font=2,
+
> mtext(side=1, at=c(0.2, 1:length(brainExpression)), padj=1, font=2,
text=c("brain/heart","-/-","+/+","+/-","-/+"), line=2)
+

text=rep("H3K4me3",4), line=1)

)

See the boxplots in Figure 5. Genes related to H3K4me3 ChIP-enriched regions show
higher expression levels than those that are not, as we can assess using the Wilcoxon
rank sum test.

> with(brainExpression,
+
+

alternative="greater"))

wilcox.test(H3K4me3BrainYesHeartNo, H3K4me3BrainNoHeartNo,

Wilcoxon rank sum test with continuity correction

data: H3K4me3BrainYesHeartNo and H3K4me3BrainNoHeartNo
W = 88159233, p-value < 2.2e-16
alternative hypothesis: true location shift is greater than 0

Discussion

The analysis of the ChIP-chip and transcription data of Barrera et al.[18] showed that
genes that are expressed in speciﬁc tissues are marked by tissue-speciﬁc H3K4me3 mod-
iﬁcation. This ﬁnding agrees with previous reports that H3K4me3 is a marker of active
gene transcription [16].

11

We have shown how to use the freely available tools R and Bioconductor for the analysis
of ChIP-chip data. We demonstrated ways to assess data quality, to visualize the data
and to ﬁnd ChIP-enriched regions.

As with any high-throughput technology, there are aspects of ChIP-chip experiments
that need close attention, such as speciﬁcity and sensitivity of the antibodies, and po-
tential cross-hybridization of the microarray reporters. Good experiments will contain
appropriate controls, in the presence of which the software can be used to monitor and
assess these issues.

In addition to the ones introduced here, there are other Bioconductor packages that
provide further functionality, e. g. ACME [32], oligo and tilingArray [25]. For analyses
that go beyond pairwise comparisons of samples and use more complex (multi-)factorial
experimental designs or retrospective studies of collections of tissues from patients, the
package limma [20] oﬀers a powerful statistical modeling interface and facilitates com-
putation of appropriate reporter-wise statistics.

We also demonstrated a few conceivable follow-up investigations. Bioconductor allows
for easy integration of ChIP-chip results with other resources, such as annotated genome
elements, gene expression data, or DNA-protein interaction networks.

Software Versions

This tutorial was generated using the following package versions:

(cid:136) R version 2.10.0 Under development (unstable) (2009-08-16 r49268),

x86_64-unknown-linux-gnu

(cid:136) Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_US.UTF-8,
LC_COLLATE=en_US.UTF-8, LC_MONETARY=C, LC_MESSAGES=en_US.UTF-8,
LC_PAPER=en_US.UTF-8, LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C,
LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

(cid:136) Base packages: base, datasets, graphics, grDevices, grid, methods, stats, tools, utils
(cid:136) Other packages: aﬀy 1.23.5, AnnotationDbi 1.7.11, Biobase 2.5.6, biomaRt 2.1.0,

ccTutorial 1.0.13, codetools 0.2-2, DBI 0.2-4, digest 0.3.1, GO.db 2.3.0, graph 1.23.3,
lattice 0.17-25, limma 2.19.4, Matrix 0.999375-30, RColorBrewer 1.0-2, Ringo 1.9.10,
RSQLite 0.7-2, SparseM 0.80, topGO 1.13.1, weaver 1.11.0, xtable 1.5-5
(cid:136) Loaded via a namespace (and not attached): aﬀyio 1.13.3, annotate 1.23.1,

geneﬁlter 1.25.7, preprocessCore 1.7.5, RCurl 1.2-0, splines 2.10.0, survival 2.35-4,
XML 2.6-0

Acknowledgments

We thank Richard Bourgon and two reviewers for valuable comments on the manuscript, and
Leah O. Barrera, Bing Ren and co-workers for making their ChIP-chip data publicly available.

12

References

[1] Buck MJ, Nobel AB, Lieb JD (2005) ChIPOTle: a user-friendly tool for the analysis of

ChIP-chip data. Genome Biology 6:R97.

[2] Ji H, Wong WH (2005) TileMap: create chromosomal map of tiling array hybridizations.

Bioinformatics 21:3629–3636.

[3] Johnson WE, Li W, Meyer CA, Gottardo R, Carroll JS, et al. (2006) Model-based analysis

of tiling-arrays for ChIP-chip. Proc Natl Acad Sci USA 103:12457–12462.

[4] Kele¸s S (2007) Mixture modeling for genome-wide localization of transcription factors. Bio-

metrics 63:10–21.

[5] Toedling J, Sklyar O, Krueger T, Sperling S, Fischer JJ, et al. (2007) Ringo - an
R/Bioconductor package for analyzing ChIP-chip readouts. BMC Bioinformatics 8:221.

[6] Zheng M, Barrera LO, Ren B, Wu YN (2007) ChIP-chip: data, model, and analysis. Bio-

metrics 63:787–796.

[7] Gentleman RC, Carey VJ, Bates DJ, Bolstad BM, Dettling M, et al. (2004) Bioconductor:
Open software development for computational biology and bioinformatics. Genome Biology
5:R80.

[8] Gentleman R (2008) R Programming for Bioinformatics. Computer Science and Data Anal-

ysis. Chapman & Hall/CRC.

[9] Gentleman R, Carey V, Huber W, Irizarry R, Dudoit S, editors (2005) Bioinformatics and

Computational Biology Solutions Using R and Bioconductor. Springer.

[10] Hahne F, Huber W, Gentleman R, Falcon S (2008) Bioconductor Case Studies. Use R.

Springer.

[11] Durinck S, Moreau Y, Kasprzyk A, Davis S, Moor BD, et al. (2005) BioMart and Biocon-
ductor: a powerful link between biological databases and microarray data analysis. Bioin-
formatics 21:3439–3440.

[12] Alexa A, Rahnenf¨uhrer J, Lengauer T (2006) Improved scoring of functional groups from

gene expression data by decorrelating GO graph structure. Bioinformatics 22:1600–1607.

[13] Gentleman R (2005) Reproducible research: A bioinformatics case study. Statistical Appli-

cations in Genetics and Molecular Biology 4:2.

[14] Knuth D (1992) Literate programming. Technical report, Center for the Study of Language

and Information, Stanford, California.

[15] The Microarray and Gene Expression Data (MGED) Society (2005) MIAME Glossary.

URL http://www.mged.org/Workgroups/MIAME/miame_glossary.html.

[16] Santos-Rosa H, Schneider R, Bannister AJ, Sherriﬀ J, Bernstein BE, et al. (2002) Active

genes are tri-methylated at K4 of histone H3. Nature 419:407–11.

[17] Fischer JJ, Toedling J, Krueger T, Schueler M, Huber W, et al. (2008) Combinatorial eﬀects
of four histone modiﬁcations in transcription and diﬀerentiation. Genomics 91:41–51.

[18] Barrera LO, Li Z, Smith AD, Arden KC, Cavenee WK, et al. (2008) Genome-wide mapping
and analysis of active promoters in mouse embryonic stem cells and adult organs. Genome
Res 18:46–59.

13

[19] Edgar R, Domrachev M, Lash AE (2002) Gene Expression Omnibus: NCBI gene expression

and hybridization array data repository. Nucleic Acids Res 30:207–210.

[20] Smyth GK (2005) Limma:

In: Gentleman R, Carey
linear models for microarray data.
V, Huber W, Irizarry R, Dudoit S, editors, Bioinformatics and Computational Biology
Solutions Using R and Bioconductor. Springer, pp. 397–420.

[21] Kauﬀmann A, Gentleman R, Huber W (2008) arrayQualityMetrics – a Bioconductor pack-

age for quality assessment of microarray data. submitted .

[22] Slater GSC, Birney E (2005) Automated generation of heuristics for biological sequence

comparison. BMC Bioinformatics 6:31.

[23] Birney E, Andrews TD, Bevan P, Caccamo M, Chen Y, et al. (2004) An overview of Ensembl.

Genome Res 14:925–928.

[24] Ashburner M, Ball CA, Blake JA, Botstein D, Butler H, et al. (2000) Gene ontology: tool
for the uniﬁcation of biology. The Gene Ontology Consortium. Nat Genet 25:25–29.

[25] Huber W, Toedling J, Steinmetz LM (2006) Transcript mapping with high-density oligonu-

cleotide tiling arrays. Bioinformatics 22:1963–1970.

[26] Hamajima N, Matsuda K, Sakata S, Tamaki N, Sasaki M, et al. (1996) A novel gene family
deﬁned by human dihydropyrimidinase and three related proteins with diﬀerential tissue
distribution. Gene 180:157–163.

[27] Royce TE, Rozowsky JS, Gerstein MB (2007) Assessing the need for sequence-based nor-

malization in tiling microarray experiments. Bioinformatics 23:988–997.

[28] Schwartz YB, Kahn TG, Nix DA, Li XY, Bourgon R, et al. (2006) Genome-wide analysis

of Polycomb targets in Drosophila melanogaster. Nat Genet 38:700–705.

[29] Bourgon RW (2006) Chromatin-immunoprecipitation and high-density tiling microarrays:
a generative model, methods for analysis, and methodology assessment in the absence of a
”gold standard”. Ph.D. thesis, University of California, Berkeley, Berkley, California, USA.
URL http://www.ebi.ac.uk/~bourgon/papers/bourgon_dissertation_public.pdf.

[30] Kuan PF, Chun H, Kele¸s S (2008) CMARRT: a tool for the analysis of ChIP-chip data from

tiling arrays by incorporating the correlation structure. Pac Symp Biocomput :515–526.

[31] Kanehisa M (1997) A database for post-genome analysis. Trends Genet 13:375–376.

[32] Scacheri PC, Crawford GE, Davis S (2006) Statistics for ChIP-chip and DNase hypersensi-

tivity experiments on NimbleGen arrays. Methods Enzymol 411:270–282.

14

Tables

name
ENSMUSG00000076459
ENSMUSG00000075814
ENSMUSG00000066371
ENSMUSG00000029098

chr
12
8
9
5

strand
1
-1
1
1

start
110951020
126138999
107774792
35925700

end
110951100
126139117
107775570

symbol

4930506F14Rik

35956448 Acox3

Table 1: An excerpt of the object ’mm9genes’.

chr
X
X
17
X
15
17

start
7338726
98834348
10508374
148236854
10414592
35972156

end
7343630
98838572
10511376
148239554
10416734
35975830

cellType
heart
heart
heart
heart
heart
heart

features
ENSMUSG00000000134
ENSMUSG00000034160
ENSMUSG00000062078
ENSMUSG00000025261
ENSMUSG00000022248 ENSMUSG00000022247
ENSMUSG00000061607 ENSMUSG00000001525

maxLevel
5.56
5.45
5.44
5.40
5.39
5.37

score
83.64
93.09
76.27
80.29
53.19
62.10

Table 2: The ﬁrst six lines of object ’chersXD’.

GO.ID
GO:0007268
GO:0007610
GO:0007409
GO:0006887
GO:0031344
GO:0045664
GO:0007420

Term
synaptic transmission
behavior
axonogenesis
exocytosis
regulation of cell projection organizati...
regulation of neuron diﬀerentiation
brain development

Annotated
121
180
119
40
32
54
136

Signiﬁcant
40
54
38
17
14
20
40

Expected
21.88
32.55
21.52
7.23
5.79
9.76
24.59

p.value
4.5e-05
5.0e-05
0.00016
0.00028
0.00067
0.00073
0.00073

Table 3: GO terms that are signiﬁcantly over-represented among genes showing
H3K4me3 enrichment speciﬁcally in brain cells

Term
GO.ID
GO:0006936 muscle contraction
GO:0002526
GO:0008016
GO:0030878
GO:0007512
GO:0032879
GO:0003007
GO:0055003
GO:0048646

acute inﬂammatory response
regulation of heart contraction
thyroid gland development
adult heart development
regulation of localization
heart morphogenesis
cardiac myoﬁbril assembly
anatomical structure formation involved ...

Annotated
56
17
32
7
8
155
28
4
155

Signiﬁcant
13
6
8
4
4
19
7
3
21

Expected
2.96
0.90
1.69
0.37
0.42
8.19
1.48
0.21
8.19

p.value
4.6e-06
0.00016
0.00019
0.00024
0.00045
0.00046
0.00048
0.00056
0.00081

Table 4: GO terms that are signiﬁcantly over-represented among genes showing
H3K4me3 enrichment speciﬁcally in heart cells

15

Figure Legends

Figure 1: Normalized reporter intensities for H3K4me3 ChIP around the TSS of the
gene Actc1 in M. musculus brain and heart cells. The ticks on the genomic coordinate
axis below indicate genomic positions matched by reporters on the microarray. The blue
box below the genomic coordinate axis marks the gene Actc1 with the position below the
axis indicating that the gene is located on the Crick strand.

Figure 2: Normalized and smoothed reporter intensities for H3K4me3 ChIP around the
TSS of the gene Actc1 in M. musculus brain and heart cells.

16

−2024Fold change [log]llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllH3K4me3.brainH3K4me3.heartActc1113873000113874000113875000113876000113877000113878000113879000113880000113881000113882000113883000Chromosome 2 coordinate [bp]−2024Fold change [log]llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllH3K4me3.brainH3K4me3.heartH3K4me3.brain.smoothedH3K4me3.heart.smoothedActc1113873000113874000113875000113876000113877000113878000113879000113880000113881000113882000113883000Chromosome 2 coordinate [bp]Figure 3: Histograms of reporter intensities after smoothing of reporter levels, measured
in M. musculus heart and brain cells. The red vertical lines are the cutoﬀ values suggested
by the algorithm described in the text.

Figure 4: This genomic region is the H3K4me3 ChIP-enriched region with the highest
smoothed reporter level.

17

smoothed reporter level [log2]Percent of Total051015−4−20246brain051015heart−10123456Fold change [log]llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllH3K4me3.brain.smoothedH3K4me3.heart.smoothedTcfe37338000733900073400007341000734200073430007344000Chromosome X coordinate [bp]Figure 5: Boxplots for comparing gene expression levels in brain cells. Genes are
stratiﬁed by whether or not they are related to H3K4me3 ChIP-enriched regions in brain
and/or heart cells according to ChIP-chip. The width of the boxes is proportional to the
number of genes in each stratiﬁcation group.

18

lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll110100100010000gene expression level in brain cellsH3K4me3H3K4me3H3K4me3H3K4me3brain/heart−/−+/++/−−/+