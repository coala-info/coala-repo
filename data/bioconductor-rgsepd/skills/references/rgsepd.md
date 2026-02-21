R/GSEPD Tutorial
Gene Set Enrichment and Projection Displays

Karl Stamm – karl.stamm@gmail.com –

October 30, 2025

1

Introduction

GSEPD is a package for streamlining RNA-Seq data analysis, targeting complex samples
with low replicate count such as human tissues, where all factors (metabolic, genetic, etc)
cannot be controlled statistically [Stamm et al., 2019]. As a prerequisite, you need only
your multiple samples’ count data as a matrix whose columns are samples and rows are
RefSeq NM and NR transcript identifiers. A second matrix associates sample identifiers with
treatment/condition. Given both datasets, GSEPD will automate differential expression via
DESeq2 [Love et al., 2014], functional analysis via GOSeq [Young et al., 2010], generate
heatmaps of gene expression for significantly differentially expressed genes, and subsets of
genes defined by the significantly enriched GO Terms.

After gene sets are detected from a differential expression analysis, the results are merged
into a novel ‘projection display’ wherein each sample is scored according to each condition’s
multidimensional average expression. When the treatment samples are found to have a
perturbed expression profile for a particular GO Term (geneset), all samples are scored on
an axis ranging from control to treatment condition, and outliers or anomalous samples are
readily apparent. Clustering quality of samples in a given geneset-space is quantified by the
cluster’s “Validity score” [Rosenberg and Hirschberg, 2007] and an empirical permutation
derived p-value. GO Terms with more genes than samples in your comparison will randomly
appear enriched, so the Segregation P-value is used to determine if a GO Term is significantly
segregating your samples.

2 Usage

You’ll need a prepared matrix of read-counts per transcript (Table 1.) You can use HTSeq
or RSEM or coverageBed, or any other generation method, so long as it ends with a table
of counts by transcript ID. This software comes pre-packaged with a dataset based on the
IlluminaBodyMap project, counted with coverageBed. The second prerequisite is a metadata
table associating sample identifiers with their test-condition and a nickname to annotate
figures with (see Table 2 for the included sample). Alternatively, the manual/Vignette for
DESeq2 describes how to generate a dataset object from HTSeq read counts, you can also

1

initialize GSEPD with the DESeqDataSet object instead of the counts matrix. By default
this table will be normalized by DESeq during processing, but if you have a pre-normalized
table, you can prevent the double normalization by setting renormalize=FALSE in the INIT()
routine.

2.1 Naming Conventions

In R, column names are not allowed to have spaces or certain special characters like + or . As
your sample names are the columns of the count table, this implies your sample names may
not have special characters or spaces. When you load a table with invalid column headers, R
may silently convert invalid characters into periods, thus “Sample 1” becomes “Sample.1”.
If your metadata table (where samples must be annotated) matches the original count table,
it won’t match this converted name, and you’ll either get an error about samples not being
found, or worse, an apparently successful run with invalid data.
In later stages of the
GSEPD process your test conditions also become column headers, and spaces will cause an
error before completion. It’s better to compare groups ‘test’ vs ‘control’ than ‘lung
tissue’ vs ‘healthy(-ish) person’.

library(rgsepd)

as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
setequal, union

DESeq2
S4Vectors
stats4
BiocGenerics
generics

## Loading required package:
## Loading required package:
## Loading required package:
## Loading required package:
## Loading required package:
##
## Attaching package:
’generics’
## The following objects are masked from ’package:base’:
##
##
##
##
## Attaching package:
## The following objects are masked from ’package:stats’:
##
##
## The following objects are masked from ’package:base’:
##
##
##
##
##
##
##

IQR, mad, sd, var, xtabs

’BiocGenerics’

Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
as.data.frame, basename, cbind, colnames, dirname, do.call,
duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
unsplit, which.max, which.min

2

’S4Vectors’

findMatches

I, expand.grid, unname

IRanges
GenomicRanges
Seqinfo
SummarizedExperiment
MatrixGenerics
matrixStats

##
## Attaching package:
## The following object is masked from ’package:utils’:
##
##
## The following objects are masked from ’package:base’:
##
##
## Loading required package:
## Loading required package:
## Loading required package:
## Loading required package:
## Loading required package:
## Loading required package:
##
## Attaching package:
’MatrixGenerics’
## The following objects are masked from ’package:matrixStats’:
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
## Loading required package:
## Welcome to Bioconductor
##
##
##
##
##
## Attaching package:
## The following object is masked from ’package:MatrixGenerics’:
##
##

colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
colWeightedMeans, colWeightedMedians, colWeightedSds,
colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
rowWeightedSds, rowWeightedVars

Vignettes contain introductory material; view with
’browseVignettes()’.
’citation("Biobase")’, and for packages ’citation("pkgname")’.

To cite Bioconductor, see

rowMedians

’Biobase’

Biobase

3

anyMissing, rowMedians

goseq
BiasedUrn
geneLenDataBase

## The following objects are masked from ’package:matrixStats’:
##
##
## Loading required package:
## Loading required package:
## Loading required package:
##
## Attaching package:
## The following object is masked from ’package:S4Vectors’:
##
##
##
##
## Loading R/GSEPD 1.42.0
## Building human gene name caches
## ’select()’ returned 1:1 mapping between keys and columns
## ’select()’ returned 1:1 mapping between keys and columns

’geneLenDataBase’

unfactor

set.seed(1000) #fixed randomness
data("IlluminaBodymap" , package="rgsepd")
data("IlluminaBodymapMeta" , package="rgsepd")

NM 000014
NM 000015
NM 000016
NM 000017
NM 000018
NM 000019
NM 000020
NM 000021
NM 000022
NM 000023

adipose.1
91717
7
1395
1400
9505
5609
5961
3935
335
103

adipose.2
91406
7
1410
1439
9432
5580
5625
4092
267
108

adipose.3
91667
7
1505
1393
9217
5707
5774
3931
292
97

adipose.4 blood.1 heart.1
67285
3
15851
1992
33252
16616
1658
1570
144
1463

290
0
2592
460
4432
1530
98
12021
723
16

91788
0
1368
1334
9780
5622
5862
3964
286
85

skeletal muscle.1
15609
0
2255
2759
15478
11988
497
2009
75
13083

Table 1: First few rows of the included IlluminaBodymap dataset. See ?IlluminaBodymap
for more details.

Next we’ll sub-select 5, 000 genes from this set for speed. Initialize the GSEPD object
with the GSEPD INIT function. Finally, to indicate which conditions will be tested as this
dataset includes samples from ‘condition’ A, B, and C, we use GSEPD ChangeConditions.

isoform_ids <- Name_to_RefSeq(c("GAPDH","HIF1A","EGFR","MYH7","CD33","BRCA2"))
rows_of_interest <- unique( c( isoform_ids ,

sample(rownames(IlluminaBodymap),
size=5000,replace=FALSE)))

G <- GSEPD_INIT(Output_Folder="OUT",

finalCounts=round(IlluminaBodymap[rows_of_interest , ]),

4

Sample
adipose.1 A
adipose.2 A
adipose.3 A
adipose.4 A
C
C

1
2
3
4
5 blood.1
6 blood.2

Condition SHORTNAME
AD1
AD2
AD3
AD4
BL1
BL2

First

Table 2:
See
?IlluminaBodymapMeta for more details. These are easy to build with a spreadsheet, saved
to csv and R’s builtin ?read.csv

the included IlluminaBodymapMeta dataset.

few rows of

sampleMeta=IlluminaBodymapMeta,

COLORS=c(blue="#4DA3FF",black="#000000",gold="#FFFF4D"))

## Keeping rows with counts (4595 of 5006)

G <- GSEPD_ChangeConditions( G, c("A","B"))

This should only take a moment, and create the folder OUT which will hold your generated
results. If you’re familiar with R objects, you can explore the G object here and change default
parameters, all set by GSEPD INIT. We’ll change some parameters now to demonstrate:

G$MAX_Genes_for_Heatmap <- 30
G$MAX_GOs_for_Heatmap <- 25
G$MaxGenesInSet <- 12
G$LIMIT$LFC <- log( 2.50 , 2 )
G$LIMIT$HARD <- FALSE

Here we changed five default settings on the G master object. The parameters MAX Genes for Heatmap

and MAX GOs for Heatmap cap how many rows you’ll see on your final differential expression
heatmap (Figure 6) and the projection HMA file (Figure 4), choosing the most significant
rows so your figures are shorter. If you’d like a figure containing everything, make these
values large.

The parameter MaxGenesInSet controls the size of evaluated GO-Terms. Default is 30,
here we reduce it to 12 for speed. Calculating projection significance for large sets can be
slow. Also see MinGenesInSet for culling niche gene sets. The goal here is to limit our
results to gene sets which are not too broad and not too narrow.

The parameter LIMIT$LFC is the log2 minimum foldchange required for significance, here
we’ve set it to require 250% expression up or down (default is 200%, at LFC=1). Finally
LIMIT$HARD if TRUE (the default), means figures and plots will respect the specified p-value
limits. Sometimes your comparison won’t have any significant genes or GO-terms and later
stages of the pipeline will error or quit. To force generation of all stages and plots of less-
than-strictly significant sets, we have set the LIMIT$HARD=FALSE. You’ll see messages during
processing if very few genes would be strictly significant, as the system adjusts the threshold
automatically. By default, limits are hard at p = 0.05.

5

Now we’re ready to run the pipeline:

G <- GSEPD_Process( G )

https://doi.org/10.1093/bioinformatics/bty895

## converting counts to integer mode
## Generating OUT/DESEQ.counts.Ax4.Bx8.csv
## converting counts to integer mode
## estimating size factors
## estimating dispersions
## gene-wise dispersion estimates
## mean-dispersion relationship
## final dispersion estimates
## fitting model and testing
## using ’normal’ for LFC shrinkage, the Normal prior from Love et al (2014).
##
## Note that type=’apeglm’ and type=’ashr’ have shown to have less bias than
type=’normal’.
## See ?lfcShrink for more details on shrinkage type, and the DESeq2 vignette.
## Reference:
## Generating OUT/DESEQ.Volcano.Ax4.Bx8.png
## Generating OUT/DESEQ.RES.Ax4.Bx8.csv
## dropping rows with raw PVAL>0.990 OR baseMean < 1 OR on excludes list
## deseq txid rows remaining:
## Converting identifiers with local DB
## Generating OUT/DESEQ.RES.Ax4.Bx8.Annote.csv
## Too many genes found differentially expressed, changing the
raw p=0.000000 so we can use 30 genes in the heatmap.
## Generating OUT/HM.Ax4.Bx8.30.pdf
## Loading hg19 length data...
## Fetching GO annotations...
## Loading required package:
## Calculating the p-values...
## ’select()’ returned 1:1 mapping between keys and columns
## Loading hg19 length data...
## Fetching GO annotations...
## Calculating the p-values...
## ’select()’ returned 1:1 mapping between keys and columns
## Loading hg19 length data...
## Fetching GO annotations...
## Calculating the p-values...
## ’select()’ returned 1:1 mapping between keys and columns
## ’select()’ returned 1:1 mapping between keys and columns
## ’select()’ returned 1:1 mapping between keys and columns
## ’select()’ returned 1:1 mapping between keys and columns
## Generating OUT/GOSEQ.RES.Ax4.Bx8.GO.csv

AnnotationDbi

threshold to

2844

6

## Written GO categories, now reverse mapping
## Generating OUT/GSEPD.RES.Ax4.Bx8.GO2.csv
## Generating OUT/GSEPD.RES.Ax4.Bx8.MERGE.csv
## Generating OUT/GSEPD.PCA AG.Ax4.Bx8.pdf
## Generating OUT/GSEPD.PCA DEG.Ax4.Bx8.pdf
## Generating OUT/SCA.GSEPD.Ax4.Bx8.pdf
## Calculating Projections and Segregation Significance
## Generating OUT/GSEPD.HMA.Ax4.Bx8.pdf
## Generating OUT/GSEPD.HMA.Ax4.Bx8.csv
## All Done!

This step can take a few minutes on a full genome-wide dataset. If you change something
and re-run GSEPD will reuse any files it finds with the same filename, so you don’t have
to wait for each step again, unless the filenames change. GSEPD’s automation steps will
convert gene identifiers, and GOSeq can take a few minutes as it runs on three differential
expression sets (the upregulated, the downregulated, and the combined). All of these results
are saved as CSV files under the OUT folder.

We save the G object from a GSEPD Process routine, to retain information such as the
normalized counts (wherein DESeq adjusted for library sequencing depths). This object will
be passed to further visualizations, such as heatmaps and PCA.

print(isoform_ids)

## [1] "NR_152150"
## [6] "NR_176251"

"NM_181054"

"NM_201284"

"NM_001407004" "NM_001772"

GSEPD_Heatmap(G,isoform_ids)

## Warning:

3 gene ids are not found in count data

7

GSEPD_PCA_Plot(G)

## Generating OUT/GSEPD.PCA AG.Ax4.Bx8.pdf, overwriting previous existing version.
## Generating OUT/GSEPD.PCA DEG.Ax4.Bx8.pdf, overwriting previous existing version.

## pdf
2
##

8

SK2 BSK3 BSK1 BSK4 BBL3 CBL2 CBL1 CBL4 CAD3 AHE4 BHE1 BHE2 BHE3 BAD2 AAD4 AAD1 AEGFRHIF1ACD338.58.58.28.32.22.22.22.29.68.38.78.28.49.59.59.4111111111313131313131313131313132.22.22.22.2111111117.57.17.17.27.17.47.58−3−1123Value02468Color Keyand HistogramCount3 Results

Several files are generated from each run. When GSEPD Processis invoked the pre-specified
conditions are compared, or when GSEPD ProcessAllis invoked, each condition is tested
against all others. For each comparison, files with the comparison listed in their filename
are generated. For a condition named “A” with N samples, versus “B” with M samples,
your normalized counts file will be written to OUT\DESEQ.counts.AxN.BxM.csvfor example.
If one of your conditions has the letter x in it, please change the delimiter with something
like G$C2T Delimiter <- ’z’ or other unused character.

3.1 Heatmap Organizational Clustering

Each generated heatmap figure organizes the rows and columns such that similar profiles are
adjacent. For this we use the default methods of gplots::heatmap.2 which calls hclust
on the supplied data. For gene heatmaps where you see numbers in each cell, representing
the gene’s expression value calculated by DESeq2::varianceStabilizingTransformation .
For users who have pre-normalized their datasets, systemic re-normalization can be disabled
at initialization with the renormalize parameter. The magnitude of a gene’s expression
might dominate the heirarchical clustering, so scaling is warranted. GSEPD will scale gene
expression values within each row(gene) as a normal Gaussian by subtracting the row’s mean
and dividing out the standard deviation. Therefore it is dependent on the samples used in
the figure, and heirarchical clustering with complete linkage is not guaranteed to be stable.
To ensure some values of each specified color, the normalized color data is capped to a
specifiable minimum and maximum (default 3) before heatmap.2’s clustering is performed.

Annotated_Filtered <- read.csv("OUT/DESEQ.RES.Ax4.Bx8.Annote_Filter.csv",

header=TRUE,as.is=TRUE)

REFSEQ
NM 000016
NM 000028
NM 000029
NM 000034
NM 000045
NM 000050
NM 000062
NM 000092
NM 000164
NM 000206

baseMean
6263.66
5294.45
2769.14
87627.22
327.85
2269.53
20542.97
332.62
41.22
4859.52

Ax4
10.40
10.44
10.22
14.42
10.26
12.66
15.71
5.25
7.15
9.22

Bx8 X.X.Y. LOG2.X.Y.
-2.98
-2.70
-2.06
-2.78
8.21
2.32
1.96
-4.30
3.01
1.93

0.13
0.15
0.24
0.15
295.78
4.99
3.89
0.05
8.06
3.82

12.87
13.13
12.22
16.91
3.08
10.34
13.75
8.97
4.41
7.33

lfcSE PVAL PADJ HGNC
0.56
0.05
0.22
0.43
0.29
0.08
0.03
0.47
0.54
0.12

0.01 ACADM
0.00 AGL
0.00 AGT
0.00 ALDOA
0.00 ARG1
0.00 ASS1
0.00 SERPING1
0.00 COL4A4
0.01 GIPR
IL2RG
0.00

0.00
0.00
0.00
0.00
0.00
0.00
0.00
0.00
0.00
0.00

ENTREZ
34
178
183
226
383
445
710
1286
2696
3561

Table 3: First few rows of OUT/DESEQ.RES.Ax4.Bx8.Annote Filter.csv which contains the
DESeq results, cropped for significant results, and annotated with gene names (the HGNC
Symbol).

9

Figure 1: OUT\GSEPD.PCA AG.Ax4.Bx8.pdf is the Principle Components Analysis of All
Genes, from the comparison Ax4 vs Bx8 under run OUT. This function annotates the top four
major genes underlying each principle component dimension along each axis (by maximum
absolute weight). Samples from the tested condition are marked in the comparison colors,
here blue and gold. All genes and all samples are included. A true outlier sample can direct
the principle components away from the differentiating genes, and all tested samples can
show as a single cluster.

10

−0.4−0.3−0.2−0.10.00.10.2−0.3−0.2−0.10.00.10.20.3AD1AD2AD3AD4BL1BL2BL3BL4HE1HE2HE3HE4SK1SK2SK3SK4HCP5LYNDOCK8SLC7A7TNFRSF14EIF2AK1ZNF641DGKDTMED5MBNL1ABOtherPCA over 4595 transcriptsFigure 2: OUT\GSEPD.PCA DEG.Ax4.Bx8.pdf is the Principle Components Analysis of
only Differentially Expressed Genes, from the comparison Ax4 vs Bx8 under run OUT. This
function annotates the top four major genes underlying each principle component dimen-
sion along each axis (by maximum absolute weight). Samples from the tested condition
are marked in the comparison colors, here blue and gold, with the non-comparison samples
marked as black ‘Other’. Because we’re only reviewing genes found to be differ-
entially expressed, this plot is guaranteed to show separation of your samples,
sometimes spuriously.

Figure 3: OUT\DESEQ.Volcano.Ax4.Bx8.png is the ‘volcano’ plot from the comparison Ax4
vs Bx8. Here, the horizontal axis is the relative fold-change between conditions, and the
vertical is significance. A left-right balanced figure indicates similar numbers of genes found
up and down-regulated. The bundled IlluminaBodymap dataset does not have biological
replicates, causing the Volcano plot to show too many significant genes.

11

−0.3−0.2−0.10.00.10.2−0.4−0.3−0.2−0.10.00.10.20.3AD1AD2AD3AD4BL1BL2BL3BL4HE1HE2HE3HE4SK1SK2SK3SK4CPDFRMD8SEC14L1TMOD3APOL3RPS28PLAGL2TMEM120BDYRK2ACSL6ABOtherPCA over 756 transcriptsFigure 4: OUT\GSEPD.HMA.Ax4.Bx8.pdf is the projection display summary heatmap from
the comparison Ax4 vs Bx8. Here, as in a normal heatmap, your samples are columns, and
rows are GO Terms with significant segregation ability. All rows and columns are arranged
to cluster. The color in each cell represents the sample’s Alpha score for that GO Term,
with blue indicating similarity to class ‘A’, and the gold indicating similarity to class ‘B’.
The unlabeled top row indicates the comparison categories, also seen on the sample labels
along the bottom (A, B, or C). Any white dots indicate the sample was distant from the axis
between conditions, so the color should be interpreted with caution or investigated further.
The most interesting results from GSEPD are here, when unclassified samples (Blood/C)
are scored as similar to either of the tested conditions on a geneset-by-geneset basis. Both
the Alpha table and Beta table are summarized in the HMA figure.

12

AD3 AAD2 AAD1 AAD4 ABL2 CBL1 CBL4 CBL3 CSK3 BSK2 BSK1 BSK4 BHE3 BHE1 BHE2 BHE4 Bapoptotic cell clearance GO:0043277polysaccharide biosynthetic process GO:0000271embryonic digestive tract development GO:0048566polysaccharide metabolic process GO:0005976response to fungus GO:0009620defense response to fungus GO:0050832ATP biosynthetic process GO:0006754proton motive force−driven ATP synthesis GO:0015986proton−transporting two−sector ATPase complex assembly GO:0070071mitochondrial proton−transporting ATP synthase complex assembly GO:0033615proton−transporting ATP synthase complex assembly GO:0043461granulocyte activation GO:0036230M band GO:0031430A band GO:0031672ficolin−1−rich granule membrane GO:0101003multicellular organismal movement GO:0050879skeletal muscle contraction GO:0003009musculoskeletal movement GO:0050881cardiac myofibril assembly GO:0055003cytochrome complex GO:0070069NADH dehydrogenase (ubiquinone) activity GO:0008137aerobic electron transport chain GO:0019646tricarboxylic acid cycle GO:0006099proton motive force−driven mitochondrial ATP synthesis GO:0042776oxidoreduction−driven active transmembrane transporter activity GO:0015453                                                                                                                                                                                                                                                                                                                                                                                                                00.20.40.60.81Value02060100Color Keyand HistogramCountFigure 5: OUT\GSEPD.HMG.Ax4.Bx8.pdf is a simplified projection display summary
heatmap from the comparison Ax4 vs Bx8. Here, as in a normal heatmap, your samples are
columns, and rows are GO Terms with significant segregation ability. All rows and columns
are arranged to cluster. The color in each cell represents the sample’s Gamma(1/2) score for
that GO Term, with blue indicating similarity to class ‘A’, and the gold indicating similarity
to class ‘B’. The unlabeled top row indicates the comparison categories, also seen on the
sample labels along the bottom (A, B, or C). Black areas indicate the sample was distant
from both conditions. The most interesting results from GSEPD are here, when unclassified
samples (Blood/C) are scored as similar to either of the tested conditions on a geneset-by-
geneset basis. Both the Gamma1 table and Gamma2 table are summarized in this HMG
figure.

13

AD4 AAD3 AAD1 AAD2 ABL2 CBL4 CBL1 CBL3 CSK3 BSK2 BHE1 BSK4 BHE3 BSK1 BHE4 BHE2 Bproton−transporting two−sector ATPase complex assembly GO:0070071mitochondrial proton−transporting ATP synthase complex assembly GO:0033615proton−transporting ATP synthase complex assembly GO:0043461oxidoreduction−driven active transmembrane transporter activity GO:0015453cytochrome complex GO:0070069granulocyte activation GO:0036230cardiac myofibril assembly GO:0055003polysaccharide metabolic process GO:0005976polysaccharide biosynthetic process GO:0000271aerobic electron transport chain GO:0019646NADH dehydrogenase (ubiquinone) activity GO:0008137tricarboxylic acid cycle GO:0006099proton motive force−driven mitochondrial ATP synthesis GO:0042776musculoskeletal movement GO:0050881skeletal muscle contraction GO:0003009multicellular organismal movement GO:0050879ficolin−1−rich granule membrane GO:0101003embryonic digestive tract development GO:0048566apoptotic cell clearance GO:0043277defense response to fungus GO:0050832response to fungus GO:0009620M band GO:0031430proton motive force−driven ATP synthesis GO:0015986A band GO:0031672ATP biosynthetic process GO:000675400.20.40.60.81Value04080120Color Keyand HistogramCountFigure 6: OUT\HM.Ax4.Bx8.30.pdf is a heatmap of your comparisons with full expression
details for those genes found significantly expressed. The number of genes is given in the
filename. Each row is scaled such that the lowest values are blue and the highest are gold
(default colors are changable in GSEPD INIT). The numbers within each cell are the expres-
sion values as variance-stabilized normalized counts, similar to a log transform, provided by
DESeq2. Across the top, between the sample clustering dendrogram and the heatmap itself
is a colorbar annotating which samples belong to which comparison group, for this differen-
tial expression blue vs gold. Black corresponds to extraneous samples, contributing context.
Other variations of this plot with less information are generated as HMS files (compared
samples only) and HM- files (minimal figure without details).

14

BL3 CBL1 CBL4 CBL2 CAD3 AAD1 AAD4 AAD2 ASK1 BHE1 BSK3 BSK4 BSK2 BHE3 BHE4 BHE2 BPDE4DIPDMDPDLIM5AGLDGLUCYH1−2OGDHCYC1RAMP1CEP85SMYD1TCAPSYNPO2LS100A1UNC45BCAVIN4TTNTPSB2FMO3SCARB1PMLNDRG1PCSK7BCAP31OS9SLC1A5CEMIP2ARG1NCF2CXCR44.84.74.64.88.48.38.38.414151414141515154.54.64.54.81111111115141515151414148.68.78.58.69.39.59.49.3141514141415151511111111101010111313131313131313101010109.29.29.39.413131313131313139.39.49.29.38.98.88.98.61212121212121212111111111111101013131313131313131111111112111212141414141414141465.95.75.66.76.86.66.611111111111111119.59.49.59.57.27.57.47.312121212121212123.63.933.943.72.23.115151515151515154.24.43.34.24.14.84.74.415161515151616162.22.22.22.24.84.63.94.114151414141515154.23.93.53.58.38.38.58.414141414141414145.35.154.83.13.73.8414141414141414144.8554.74.73.63.94.61212121212121212101010109.89.79.99.820202020202020204.44.13.74.71111111177.67.37.27.57.47.57.42.22.22.22.2111111118.28.68.58.48.58.48.38.48.68.88.88.8131313139.39.19.59.49.39.299.110101010121212129.59.59.39.39.69.59.59.61212121214141414121212121212121211111111121212121010101010101010121313131413141311111111111111111313131314141414121212121212121211111111121212129.29.79.39.49.39.59.69.6131313131313131311111111111111116.66.76.56.5101010102.23.62.22.22.24.13.64.315151515111111118.18.18.18.28.18.38814141414121212128.68.78.58.78.88.98.88.8−3−113Value0204060Color Keyand HistogramCountFigure 7: OUT\SCGO\GSEPD.Ax4.Bx8.GO0000271.pdf First page of the projections file
for one GO Term. All significant sets have this figure generated displaying the central axis
between two groups as a black line (with ends annotated Ax4 and Bx8), and each sample’s
closest point along the line. These files have half as many pages as genes in the set, so we can
display pairs as two-dimensional scatterplots. It’s a workaround to the problem of displaying
an N-dimensional scatterplot. For sets with fewer than 11 genes, full pairings are viewable
with the Pairs file, Figure 8

15

−2−101−1.5−1.0−0.50.00.51.01.52.0polysaccharide biosynthetic processDYRK2 Z−Score Norm CountsGYS2 Z−Score Norm CountsAx4Bx8ABOtherAD1AD2AD3AD4BL1BL2BL3BL4HE1HE2HE3HE4SK1SK2SK3SK4Figure 8: OUT\SCGO\Pairs.Ax4.Bx8.GO0000271.pdf The Pairs file is generated for signif-
icant GO terms with between two and ten genes, making it easy to review correlations or
subgroups of gene expression among low-level gene sets.

16

10 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.000000DYRK210 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000034567810 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.0000003456710 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.0000006.57.07.58.08.59.010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.0000002468101210 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010.011.012.0246810121410 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000034567810 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.000000GYS210 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.000000IGF210 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000046810121410 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.0000003456710 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.000000HAS110 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.000000ACADM10 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.0000001112131410 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.0000006.57.07.58.08.59.010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.000000PPP1R3E10 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.000000AGL10 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010.511.512.510 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.0000002468101210 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.000000EGF10 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.000000GYS110 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010.511.512.513.510 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.000000246810121410.011.012.010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000046810121410 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.0000001112131410 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010.511.512.510 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.00000010.511.512.513.510 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.000000GYG2polysaccharide biosynthetic process GO:0000271Figure 9: OUT\SCGO\Scatter.Ax4.Bx8.GO0000271.pdf The Scatter file is similar to the
PCA files, but the gene set is restricted to those within a given, significant, GO Term. As in
the PCA file, genes driving the principle components are annotated along the axes. At the
bottom of the figure, statistics are given pertaining to this group. All such data is available
in tables, but this Scatter plot helps the user see which samples behave like which groups.
Depending on the number of genes relative to the number of samples, different PCA formulas
may be used. For a set with only two genes, this file can directly display the expression values
as normalized counts, the same as found on the expression heatmap (Fig. 6.)

17

−0.4−0.3−0.2−0.10.00.10.2−0.20.00.20.4PCA for polysaccharide biosynthetic process GO:0000271AD1AD2AD3AD4BL1BL2BL3BL4HE1HE2HE3HE4SK1SK2SK3SK4GYG2GYS2DYRK2EGFIGF2PPP1R3EDYRK2GYS2GYS1IGF2ABOther10 Genes / 16 Samples / GOSeq p=0.042225 / segregation p=0.000000X category
1 GO:0000271
2 GO:0000271
3 GO:0000271
4 GO:0000271
5 GO:0000271
6 GO:0000271
7 GO:0000271
8 GO:0000271
9 GO:0000271
10 GO:0000271
1688 GO:0003009
1689 GO:0003009
1690 GO:0003009
1691 GO:0003009
1692 GO:0003009

over represented padj.x Term.x

0.04 polysaccharide biosynthetic process Down
0.04 polysaccharide biosynthetic process Down
0.04 polysaccharide biosynthetic process Down
0.04 polysaccharide biosynthetic process Down
0.04 polysaccharide biosynthetic process Down
0.04 polysaccharide biosynthetic process Down
0.04 polysaccharide biosynthetic process Down
0.04 polysaccharide biosynthetic process Down
0.04 polysaccharide biosynthetic process Down
0.04 polysaccharide biosynthetic process Down
Down
0.00
Down
0.00
Down
0.00
Down
0.00
Down
0.00

skeletal muscle contraction
skeletal muscle contraction
skeletal muscle contraction
skeletal muscle contraction
skeletal muscle contraction

GOSEQ DEG Type HGNC
DYRK2
GYS2
IGF2
HAS1
ACADM
PPP1R3E
AGL
EGF
GYS1
GYG2
GSTM2
SYNM
DMD
STAC
KBTBD13

LOG2.X.Y. REFSEQ

-1.49 NM 003583
3.80 NM 021957
1.83 NM 001007139
-5.59 NM 001523
-2.98 NM 000016
-0.63 NR 026862
-2.70 NM 000028
-9.88 NM 001178130
-2.65 NM 002103
8.44 NM 001184702
-1.72 NM 000848
-3.17 NM 145728
-3.37 NM 004006
2.14 NM 003149
-5.33 NM 001101362

Ax4
10.10
7.79
14.50
2.51
10.40
7.75
10.40
3.00
10.70
14.30
8.33
12.80
11.30
7.99
4.32

Bx8 PVAL PADJ
0.00
0.00
0.06
0.01
0.00
0.00
0.00
0.00
0.01
0.00
1.00
0.98
0.00
0.00
0.00
0.00
0.00
0.00
0.00
0.00
0.00
0.00
0.00
0.00
0.00
0.00
0.33
0.08
0.00
0.00

11.50
3.63
12.70
5.15
12.90
8.21
13.10
10.60
13.30
5.58
10.00
15.90
14.60
5.54
8.90

Table 4: First few rows of OUT/GSEPD.RES.Ax4.Bx8.MERGE.csv showing enriched GO
Terms, and each terms’ underlying gene expression averages per group. This data is cen-
tral to the rgsepd package, defining the group centroids per GO-Term. It consists of the
cross-product of the GO enrichment statistics and the DESeq differential expression and
summarization.

GO:0000271
GO:0003009
GO:0005976
GO:0006099
GO:0006754
GO:0008137
GO:0009620
GO:0015453
GO:0015986
GO:0019646

adipose.1
0.01
0.01
0.01
-0.01
-0.01
-0.02
-0.00
-0.01
-0.01
-0.01

adipose.2
-0.01
0.00
0.00
0.00
-0.01
-0.02
0.00
-0.02
-0.01
-0.02

adipose.3
-0.00
-0.03
-0.01
0.01
-0.00
0.00
0.00
0.01
-0.00
-0.00

adipose.4 blood.1 heart.1
0.96
1.14
0.91
1.27
1.17
1.37
0.79
1.23
1.19
1.28

0.62
-0.13
0.50
0.19
0.29
0.15
0.30
0.25
0.35
0.14

0.00
0.02
-0.01
-0.00
0.02
0.03
-0.00
0.02
0.02
0.03

skeletal muscle.1
1.02
0.91
1.06
0.74
0.83
0.64
1.10
0.78
0.82
0.73

Table 5: First ten rows of OUT/GSEPD.Alpha.Ax4.Bx8.csv showing the group projection
scores for each sample, these directly correspond to the colors in the HMA file. Where the
HMA displays only significant sets, the Alpha table continues for all tested GO Terms. Both
the Alpha table and Beta table are summarized in Figure 4.

References

Michael I Love, Wolfgang Huber, and Simon Anders. Moderated estimation of fold change
and dispersion for rna-seq data with deseq2. bioRxiv, 2014. doi: 10.1101/002832. URL
http://dx.doi.org/10.1101/002832.

Rosenberg
entropy-based

Andrew
tional
2007.
cluster
http://www1.cs.columbia.edu/~amaxwell/pubs/v measure-emnlp07.pdf.
ment of Computer Science Columbia University New York, NY 10027.

evaluation measure,

V-Measure:

Hirschberg.

external

Julia

and

A

condi-
URL
Depart-

Karl Stamm, Aoy Tomita-Mitchell, and Serdar Bozdag.

Gsepd:
package for rna-seq gene set enrichment and projection display.
matics, 20(1):115, 2019.
https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-019-2697-5.

a bioconductor
BMC Bioinfor-
doi: 10.1186/s12859-019-2697-5. URL

ISSN 1471-2105.

Matthew Young, Matthew Wakefield, Gordon Smyth, and Alicia Oshlack.

Gene

18

GO:0000271
GO:0003009
GO:0005976
GO:0006099
GO:0006754
GO:0008137
GO:0009620
GO:0015453
GO:0015986
GO:0019646

adipose.1
0.05
0.03
0.04
0.09
0.02
0.01
0.01
0.01
0.03
0.02

adipose.2
0.03
0.03
0.03
0.09
0.02
0.05
0.01
0.03
0.03
0.02

adipose.3
0.02
0.08
0.02
0.08
0.01
0.01
0.01
0.00
0.01
0.01

adipose.4 blood.1 heart.1
0.15
0.28
0.13
0.18
0.17
0.12
0.17
0.12
0.17
0.10

0.02
0.03
0.02
0.09
0.02
0.05
0.00
0.03
0.03
0.02

0.42
0.43
0.38
0.21
0.21
0.13
0.40
0.33
0.23
0.11

skeletal muscle.1
0.17
0.18
0.15
0.17
0.16
0.10
0.15
0.11
0.17
0.09

Table 6: First ten rows of OUT/GSEPD.Beta.Ax4.Bx8.csv showing the linear divergence
(distance to axis) for each sample, high values here would be annotated with white dots
on the HMA file to indicate that a sample is not falling on the axis. Non-tested samples
are expected to frequently have high values here, the C group was not part of the A vs B
comparison. Where the HMA displays only significant sets, the Beta table continues for all
tested GO Terms. Both the Alpha table and Beta table are summarized in Figure 4.

ontology analysis
for
ogy, 11(2):R14, 2010.
http://genomebiology.com/2010/11/2/R14.

ISSN 1465-6906.

accounting for
doi:

rna-seq:

selection bias.
10.1186/gb-2010-11-2-r14.

Genome Biol-
URL

Session Info

sessionInfo()

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0 LAPACK version 3.12.0
##
## locale:
## [1] LC_CTYPE=en_US.UTF-8
## [3] LC_TIME=en_GB
## [5] LC_MONETARY=en_US.UTF-8
## [7] LC_PAPER=en_US.UTF-8
## [9] LC_ADDRESS=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

19

GO:0000271
GO:0003009
GO:0005976
GO:0006099
GO:0006754
GO:0008137
GO:0009620
GO:0015453
GO:0015986
GO:0019646

adipose.1
0.09
0.07
0.08
0.14
0.04
0.02
0.01
0.02
0.04
0.03

adipose.2
0.06
0.07
0.06
0.14
0.04
0.06
0.03
0.05
0.04
0.05

adipose.3
0.05
0.19
0.04
0.14
0.02
0.01
0.02
0.01
0.01
0.02

adipose.4 blood.1 heart.1
1.00
1.31
0.95
1.30
1.21
1.38
0.87
1.25
1.22
1.29

0.04
0.07
0.04
0.14
0.05
0.07
0.01
0.05
0.05
0.06

1.01
0.99
0.93
0.40
0.47
0.21
0.88
0.57
0.49
0.25

skeletal muscle.1
1.07
1.00
1.10
0.79
0.89
0.65
1.14
0.80
0.85
0.75

Table 7: First ten rows of OUT/GSEPD.HMG1.Ax4.Bx8.csv showing the z-scaled distance
to the Group1 centroid for each sample, these directly correspond to the colors in the HMG
file. Where the HMG displays only significant sets, the Gamma table continues for all tested
GO Terms. Both the Gamma1 and Gamma2 tables are summarized in Figure 5. Distance
is normalized to dimensionality by scaling between the centroids. Thus a score of 0 means
the sample resides on the centroid, and a score of 1 means it resides on the opposite class
centroid, or equidistant.

graphics grDevices utils

datasets methods

AnnotationDbi_1.72.0
goseq_1.62.0
BiasedUrn_2.0.12
SummarizedExperiment_1.40.0
MatrixGenerics_1.22.0
GenomicRanges_1.62.0
IRanges_2.44.0
BiocGenerics_0.56.0
xtable_1.8-4

stats

##
## attached base packages:
## [1] stats4
## [8] base
##
## other attached packages:
## [1] org.Hs.eg.db_3.22.0
## [3] rgsepd_1.42.0
## [5] geneLenDataBase_1.45.0
## [7] DESeq2_1.50.0
## [9] Biobase_2.70.0
## [11] matrixStats_1.5.0
## [13] Seqinfo_1.0.0
## [15] S4Vectors_0.48.0
## [17] generics_0.1.4
##
## loaded via a namespace (and not attached):
bitops_1.0-9
## [1] DBI_1.2.3
rlang_1.1.6
## [4] biomaRt_2.66.0
RSQLite_2.4.3
## [7] compiler_4.5.1
png_0.1-8
## [10] GenomicFeatures_1.62.0
stringr_1.5.2
## [13] txdbmaker_1.6.0
fastmap_1.2.0
## [16] crayon_1.5.3
caTools_1.18.3
## [19] XVector_0.50.0
bit_4.6.0
## [22] UCSC.utils_1.6.0
cigarillo_1.0.0
## [25] cachem_1.1.0

20

httr2_1.2.1
magrittr_2.0.4
mgcv_1.9-3
vctrs_0.6.5
pkgconfig_2.0.3
dbplyr_2.5.1
Rsamtools_2.26.0
xfun_0.53
GenomeInfoDb_1.46.0

GO:0000271
GO:0003009
GO:0005976
GO:0006099
GO:0006754
GO:0008137
GO:0009620
GO:0015453
GO:0015986
GO:0019646

adipose.1
0.99
0.99
0.99
1.02
1.01
1.02
1.00
1.01
1.01
1.01

adipose.2
1.01
1.00
1.00
1.01
1.01
1.02
1.00
1.02
1.01
1.02

adipose.3
1.00
1.05
1.01
1.00
1.00
1.00
1.00
0.99
1.00
1.00

adipose.4 blood.1 heart.1
0.28
0.66
0.29
0.39
0.35
0.40
0.42
0.30
0.32
0.33

1.00
0.98
1.01
1.01
0.98
0.97
1.00
0.98
0.98
0.97

0.88
1.50
0.93
0.88
0.80
0.86
1.09
0.92
0.73
0.88

skeletal muscle.1
0.32
0.41
0.31
0.37
0.34
0.38
0.33
0.29
0.31
0.31

Table 8: First ten rows of OUT/GSEPD.HMG2.Ax4.Bx8.csv showing the z-scaled distance
to the Group2 centroid for each sample, these directly correspond to the colors in the HMG
file. Where the HMG displays only significant sets, the Gamma table continues for all tested
GO Terms. Both the Gamma1 and Gamma2 tables are summarized in Figure 5. Distance
is normalized to dimensionality by scaling between the centroids. Thus a score of 0 means
the sample resides on the centroid, and a score of 1 means it resides on the opposite class
centroid, or equidistant.

## [28] jsonlite_2.0.0
progress_1.2.3
## [31] highr_0.11
DelayedArray_0.36.0
## [34] parallel_4.5.1
prettyunits_1.2.0
## [37] stringi_1.8.7
RColorBrewer_1.1-3
## [40] Rcpp_1.1.0
knitr_1.50
## [43] splines_4.5.1
tidyselect_1.2.1
## [46] abind_1.4-8
yaml_2.3.10
## [49] codetools_0.2-20
curl_7.0.0
## [52] tibble_3.3.0
KEGGREST_1.50.0
## [55] evaluate_1.0.5
BiocFileCache_3.0.0
## [58] pillar_1.11.1
filelock_1.0.3
## [61] RCurl_1.98-1.17
hms_1.1.4
## [64] scales_1.4.0
gtools_3.9.5
BiocIO_1.20.0
## [67] tools_4.5.1
## [70] GenomicAlignments_1.46.0 XML_3.99-0.19
## [73] nlme_3.1-168
## [76] rappdirs_0.3.3
## [79] gtable_0.3.6
## [82] farver_2.1.2
## [85] httr_1.4.7

restfulr_0.0.16
S4Arrays_1.10.0
SparseArray_1.10.0
memoise_2.0.1
GO.db_3.22.0

blob_1.2.4
BiocParallel_1.44.0
R6_2.6.1
rtracklayer_1.70.0
Matrix_1.7-4
dichromat_2.0-0.1
gplots_3.2.0
lattice_0.22-7
S7_0.2.0
Biostrings_2.78.0
KernSmooth_2.23-26
ggplot2_4.0.0
glue_1.8.0
locfit_1.5-9.12
grid_4.5.1
cli_3.6.5
dplyr_1.1.4
rjson_0.2.23
lifecycle_1.0.4
bit64_4.6.0-1

21

