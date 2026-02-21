Sushi: An R/Bioconductor package for
visualizing genomic data

Douglas H. Phanstiel*, Alan P. Boyle, Carlos L. Araya, and Mike Snyder

April 24, 2017

Contents

1 Introduction

2 Data

2.1 Data types
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 Example datasets . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Functions

3.1 Functions overview . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2 Non-Sushi Functions . . . . . . . . . . . . . . . . . . . . . . . . .
3.3 plotBedgraph . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.4 plotHic . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.5 plotBedpe . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.6 plotBed . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.7 plotManhattan . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.8 plotGenes . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.9 Zoom functions . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.10 Color functions . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.10.1 SushiColors . . . . . . . . . . . . . . . . . . . . . . . . . .
3.10.2 opaque . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.10.3 maptocolors . . . . . . . . . . . . . . . . . . . . . . . . . .
3.11 labeling functions . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.11.1 labelgenome . . . . . . . . . . . . . . . . . . . . . . . . . .
3.11.2 labelplot . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4 Tips

5 Appendix

6 Bibliography

*Corresponding contact: doug.phanstiel@gmail.com

1

2

2
2
2

3
3
4
4
10
12
14
18
19
22
25
25
26
27
28
28
30

31

32

43

1

Introduction

Sushi is an R package for plotting genomic data stored in multiple common
genomic formats including bed, bedpe, bedgraph format. The package was
designed to be very ﬂexible to allow for combinations of plots into multipanel
ﬁgures that can include plots made by Sushi, R basecode, or other R packages.
Sushi allows for simple ﬂexible plotting of gene structures, transcript structures,
sequencing tracks, ChIP-seq peaks, chromatin interactions, GWAS results and
other commen genomic data types. This vignette shows some examples of the
functions included in Sushi to get you started with plotting these diverse data
types.

2 Data

2.1 Data types

Sushi accepts 4 types of genomic data as input. These include:

(cid:136) bed format: 3-6 columns (chromosome, start, stop, name, score, strand)

(cid:136) bedpe format: 6-10 columns (chromosome1, start1, stop1, chromosome2,

start2, stop2,name, score, strand1, strand2)

(cid:136) bedgraph format: 4 columns (chromosome, start, stop, score)

(cid:136) interaction matrix: This is matrix in which row and column names are
genomic coordiates and matrix values are some tye of interaction score.

** strands can be represented as 1 or -1 or ”+” and ”-”.

** Some functions may require additional information depending on the plot

and features desired.

2.2 Example datasets

To illustrate how Sushi works, we have included several publicaly available data
sets in the package Sushi. The data types include RNA-seq, ChIP-seq, ChIA-
PET, and HiC data:

2

Sushi_5C.bedpe
Sushi_ChIAPET_pol2.bedpe
Sushi_ChIPExo_CTCF.bedgraph
Sushi_ChIPSeq_CTCF.bedgraph
Sushi_ChIPSeq_pol2.bed
Sushi_ChIPSeq_pol2.bedgraph
Sushi_ChIPSeq_severalfactors.bed
Sushi_DNaseI.bedgraph
Sushi_GWAS.bed
Sushi_HiC.matrix
Sushi_RNASeq_K562.bedgraph
Sushi_genes.bed
Sushi_hg18_genome
Sushi_transcripts.bed

Sanyal et al. [7]
Li et al. [4]
Rhee and Pugh [6]
The ENCODE Project Consortium [8]
The ENCODE Project Consortium [8]
The ENCODE Project Consortium [8]
The ENCODE Project Consortium [8]
Neph et al. [5]
International Consortium for Blood Pressure [3]
Dixon et al. [2]
The ENCODE Project Consortium [8]
Biomart [1]
Biomart [1]
The ENCODE Project Consortium [8]

These data sets can be loaded using the following commands:

’

’

Sushi

> library(
> Sushi_data = data(package =
> data(list = Sushi_data$results[,3])

Sushi

)

’

’

)

To see which data sets are loaded

> Sushi_data$results[,3]

[1] "Sushi_5C.bedpe"
[3] "Sushi_ChIPExo_CTCF.bedgraph"
[5] "Sushi_ChIPSeq_pol2.bed"
[7] "Sushi_ChIPSeq_severalfactors.bed" "Sushi_DNaseI.bedgraph"
[9] "Sushi_GWAS.bed"

"Sushi_ChIAPET_pol2.bedpe"
"Sushi_ChIPSeq_CTCF.bedgraph"
"Sushi_ChIPSeq_pol2.bedgraph"

"Sushi_HiC.matrix"
"Sushi_genes.bed"
"Sushi_transcripts.bed"

[11] "Sushi_RNASeq_K562.bedgraph"
[13] "Sushi_hg18_genome"

3 Functions

3.1 Functions overview

Sushi functions can be broken down into 3 categories: plotting, annotating,
zooming, and coloring. Plotting functions generate a basic plot object using
the data. Annotating functions add information to the plots such as an x-
axis labeling the genomic region or a legend describing the values represented
by diﬀerent colors. Zooming functions allow for highlighting and zooming of
genomic regions, which are of particular use for multipanel plots generated with
base R functions mfrow() or layout(). The coloring functions provide simple
tools for generating R colors and palettes.

3

(cid:136) Plotting functions: plotBed(), plotBedgraph(), plotBedpe(), plot-

Genes(), plotHiC(), and plotManhattan()

(cid:136) Annotating functions: labelgenome() and addlegend()

(cid:136) Zooming functions: zoomsregion() and zoombox()

(cid:136) Coloring functions: maptocolors(), SushiColors(), and opaque()

3.2 Non-Sushi Functions

An important characteristic of Sushi plots is their compatibility with all base
R functions and their ability to be combined into complex multipanel ﬁgures.
Two of the most usefule base R functions for creating multipanel ﬁgures are
layout() and mfrow(). Basic R plotting functions such as axis(), mtext(),
and legend() are also particularly well suited to combine with Sushi plots. A
familiarity with these functions will greatly improve your ability to create Sushi
plots.

3.3 plotBedgraph

Signal tracks can be plotted using plotBedgraph(). The input requires data in
bedgraph format. We will demonstrate this using bedgraph data representing a
DNaseI hypersensitivity experiment in K562 cells.

>

head(Sushi_DNaseI.bedgraph)

chrom

start

1 chr11 1640504 1640664
2 chr11 1640904 1641004
3 chr11 1641004 1641064
4 chr11 1641064 1641164
5 chr11 1645224 1645384
6 chr11 1645504 1645664

end value
1
1
2
1
1
1

The plotBedgraph() function is used to plot the data. As with most Sushi
functions the basic required arguments include the data to be plotted, the chro-
mosome, and a start and stop position.

> chrom
> chromstart
> chromend
> plotBedgraph(Sushi_DNaseI.bedgraph,chrom,chromstart,chromend,colorbycol= SushiColors(5))

= "chr11"
= 1650000
= 2350000

4

To annotate the genome postion we use the labelgenome() function. We us n
= 4 to specify the desired number of tickmarks. The scale is set to Mb (other
options are Kb or bp).

> labelgenome(chrom,chromstart,chromend,n=4,scale="Mb")

5

The y-axis can be added using basic R functions mtext() and axis().

> mtext("Read Depth",side=2,line=1.75,cex=1,font=2)
> axis(side=2,las=2,tcl=.2)

6

1.81.922.12.2chr11MbMultiple bedgraph tracks can be plotted on the same plot by setting over-
lay=TRUE. Transparencies can be added for easier viewing by adjusting the
transcparency value. The second plot can be rescaled to the maximum of the
ﬁrst plot by setting rescaleoverlay=TRUE.

> chrom
> chromstart
> chromend
> plotBedgraph(Sushi_ChIPSeq_CTCF.bedgraph,chrom,chromstart,chromend,

= "chr11"
= 1955000
= 1960000

> plotBedgraph(Sushi_DNaseI.bedgraph,chrom,chromstart,chromend,

transparency=.50,color=SushiColors(2)(2)[1])

transparency=.50,color=SushiColors(2)(2)[2],overlay=TRUE,
rescaleoverlay=TRUE)

> labelgenome(chrom,chromstart,chromend,n=3,scale="Kb")

7

1.81.922.12.2chr11MbRead Depth050100150200Then we can use the base R function legend() to add a legend to the plot.
First we need to use the rgb function to add transparency to the colors in order
to match out plot.

> legend("topright",inset=0.025,legend=c("DNaseI","ChIP-seq (CTCF)"),

fill=opaque(SushiColors(2)(2)),border=SushiColors(2)(2),text.font=2,
cex=1.0)

Setting flip=TRUE is another method that can be used to compare tracks. First,
we will use mfrow to divided the plotting divice into two vertically stacked
regions.

> par(mfrow=c(2,1),mar=c(1,4,1,1))

8

1956195719581959chr11Kb1956195719581959chr11KbDNaseIChIP−seq (CTCF)Next, we plot the ﬁrst plot. We set the transparency of the plot to 0.5. We will
also add the legend.

> plotBedgraph(Sushi_ChIPSeq_CTCF.bedgraph,chrom,chromstart,chromend,transparency=.50,

color=SushiColors(2)(2)[1])

> axis(side=2,las=2,tcl=.2)
> mtext("Read Depth",side=2,line=1.75,cex=1,font=2)
> legend("topright",inset=0.025,legend=c("DNaseI","ChIP-seq (CTCF)"),

fill=opaque(SushiColors(2)(2)),border=SushiColors(2)(2),text.font=2,
cex=1.0)

Finally, we add the second plot with flip=TRUE. We will also label the x-axis
using labelgenome() and label the y-axis using mtext() and axis().

> plotBedgraph(Sushi_DNaseI.bedgraph, chrom, chromstart, chromend,

transparency=.50, flip=TRUE, color=SushiColors(2)(2)[2])

> labelgenome(chrom,chromstart,chromend,side=3,n=3,scale="Kb")

9

01020304050Read DepthDNaseIChIP−seq (CTCF)> axis(side=2,las=2,tcl=.2,at=pretty(par("yaxp")[c(1,2)]),

> mtext("Read Depth",side=2,line=1.75,cex=1,font=2)

labels=-1*pretty(par("yaxp")[c(1,2)]))

3.4 plotHic

HiC interaction plots can be plotted given an interaction matrix in which row
and column names are genomic coordiates and matrix values are some tye of
interaction score.

>

Sushi_HiC.matrix[100:105,100:105]

4460000 4500000 4540000 4580000

4620000 4660000
4460000 60.758775 18.84723 33.31506 22.56641 7.926361 10.69235
4500000 18.847231 32.56282 36.31212 29.04343 13.375643 12.67360
4540000 33.315060 36.31212 17.97024 43.43753 20.411952 16.98875
4580000 22.566409 29.04343 43.43753 38.93754 25.206417 23.87764
4620000 7.926361 13.37564 20.41195 25.20642 9.201501 38.33665
4660000 10.692351 12.67360 16.98875 23.87764 38.336646 22.55054

The plotHic() function is used to plot the data while the labelgenome() func-
tion is used to add the genome labels to the x-axis. plotHic() returns an object
indicating the color palette and data range that can be fed into addlegend()
to create a legend.

> chrom
> chromstart
> chromend
> phic = plotHic(Sushi_HiC.matrix, chrom,chromstart, chromend, max_y = 20,

= "chr11"
= 500000
= 5050000

zrange=c(0,28), palette=SushiColors(7))

10

01020304050Read DepthDNaseIChIP−seq (CTCF)200150100500Read Depth1956195719581959chr11Kb> addlegend(phic[[1]], palette=phic[[2]], title="score", side="right",

bottominset=0.4, topinset=0, xoffset=-.035, labelside="left",
width=0.025, title.offset=0.035)

> labelgenome(chrom, chromstart, chromend, n=4, scale="Mb",

edgeblankfraction=0.20)

plotHic() has a number of customizable options. The plot can be ﬂipped over
the x-axis by setting flip = TRUE. The color palette can be changed by the
palette argument.
addlegend() also has customizable features. The legend can be moved to the
left side of the plot by setting side = "left" and the labeling can be moved
to the right side of the lenged buy setting labelside = "right". The vertical
position of the legend can be adjusted by changing the topinset and bottomin-
set.
Finally, the x-axis label can be moved to the top of the plot by setting side =
3 in the labelgenome() function.

> chrom
> chromstart
> chromend
> phic = plotHic(Sushi_HiC.matrix,chrom,chromstart,chromend,max_y = 20,

= "chr11"
= 500000
= 5050000

zrange=c(0,28),flip=TRUE,palette=topo.colors)

> addlegend(phic[[1]],palette=phic[[2]],title="score",side="left",bottominset=0.1,

topinset=0.5,xoffset=-.035,labelside="right",width=0.025,title.offset=0.035)

> labelgenome(chrom,chromstart,chromend,side=3,n=4,scale="Mb",edgeblankfraction=0.20)

11

score071421281.522.533.54chr11Mb3.5 plotBedpe

plotBedpe() allows for data in bedpe format to be plotted in multiple fashions.
To illustrate this we will use 5C data formatted in the following way.

>

head(Sushi_5C.bedpe)

chrom1

start1

end1 chrom2

start2

end2 name

chr2 234208447 234223064

1
chr2 234156762 234159135
2 chr15 41711734 41718116 chr15 41802421 41808201
3 chr11 64172456 64183193 chr11 64068878 64079209
4
chr2 234163674 234170252
chr6 41435903 41452283
5
6 chr11 64159283 64172456 chr11 64068878 64079209

chr2 234208447 234223064
chr6 41755186 41769245

score strand1
.
.
.
.
.
.

NA 44.39862
NA 20.62534
NA 16.91630
NA 12.34501
NA 11.63480
NA 11.13098

strand2 samplenumber
1
1
1
1
1
1

.
.
.
.
.
.

1
2
3
4
5
6

plotBedpe() can plot bedpe as arches. The height, linewidth, and color of each
arch can be scaled to represent diﬀerent aspects of the data. Here the height of
the arches represents the Z-score of the 5C interaction, the color represents the
cell line each interaction was detected in, and the line widths are kept constant
(default lwd = 1).

> chrom
> chromstart
> chromend
> pbpe = plotBedpe(Sushi_5C.bedpe,chrom,chromstart,chromend,

= "chr11"
= 1650000
= 2350000

heights = Sushi_5C.bedpe$score,plottype="loops",

12

score071421281.522.533.54chr11Mbcolorby=Sushi_5C.bedpe$samplenumber,
colorbycol=SushiColors(3))

> labelgenome(chrom, chromstart,chromend,n=3,scale="Mb")
> legend("topright",inset =0.01,legend=c("K562","HeLa","GM12878"),

col=SushiColors(3)(3),pch=19,bty=

n

,text.font=2)

’

’

> axis(side=2,las=2,tcl=.2)
> mtext("Z-score",side=2,line=1.75,cex=.75,font=2)

The plot can be ﬂipped over the x-axis by setting flip = TRUE, Bedpe ele-
ments can be represented by boxes and straight lines by setting plottype =
"lines". And colors can be used to represent Z-scores by setting colorby =
"Sushi_5C.bedpe$score".

> chrom
> chromstart
> chromend
> pbpe = plotBedpe(Sushi_5C.bedpe,chrom,chromstart,chromend,flip=TRUE,

= "chr11"
= 1650000
= 2350000

plottype="lines",colorby=Sushi_5C.bedpe$score,
colorbycol=SushiColors(5))
> labelgenome(chrom, chromstart,chromend,side=3,n=3,scale="Mb")
> addlegend(pbpe[[1]],palette=pbpe[[2]],title="Z-score",side="right",bottominset=0.05,

topinset=0.05,xoffset=-.035,labelside="right",width=0.025,title.offset=0.045)

13

1.822.2chr11MblllK562HeLaGM1287802468101214Z−score3.6 plotBed

plotBed provides multiple diﬀerent ways to represent genomic data stored in
bed format. Below are the ﬁrst six lines of a bed ﬁle detailing reads from Pol2
ChIP-Seq analysis of K562 cells.

>

head(Sushi_ChIPSeq_pol2.bed)

end

start

chrom

name score strand
-1
1 chr11 2280543 2280570 GGGCTCTCTCCGGCTTCCCTGTCCCGT
63
-1
2 chr11 2288946 2288973 CCTTCCCATCCGCAGGGGCACCACATG 1000
-1
3 chr11 2272471 2272498 TGGGCATCAGTCAGGCTCCTTCCCCAG 1000
-1
4 chr11 2288939 2288966 ATCCGCAGGGGCACCACATGAGTCACC 1000
-1
250
5 chr11 2281534 2281561 TGTCCTAGTGACAAGTGGCCGGACTTG
1
250
6 chr11 2286805 2286832 GGTGAGGGCCAGCAGCTCCCTGGGGGG

Leaving row set to auto provides a pile-sup style plot. Here the colorby argu-
ment is used to color the bed elements by the strand.

> chrom
> chromstart
> chromend
> plotBed(beddata

= "chr11"
= 2281200
= 2282200

= Sushi_ChIPSeq_pol2.bed,chrom = chrom,chromstart = chromstart,

chromend =chromend,colorby
colorbycol = SushiColors(2),row = "auto",wiggle=0.001)

= Sushi_ChIPSeq_pol2.bed$strand,

> labelgenome(chrom,chromstart,chromend,n=2,scale="Kb")
> legend("topright",inset=0,legend=c("reverse","forward"),fill=SushiColors(2)(2),

border=SushiColors(2)(2),text.font=2,cex=0.75)

14

1.822.2chr11MbZ−score25.28.411.614.7Setting splitstrand = TRUE plots reads from diﬀerent strands in two separate
vertical regions.

> chrom
> chromstart
> chromend
> plotBed(beddata

= "chr11"
= 2281200
= 2282200

= Sushi_ChIPSeq_pol2.bed,chrom = chrom,chromstart = chromstart,

chromend =chromend,colorby
colorbycol = SushiColors(2),row = "auto",wiggle=0.001,splitstrand=TRUE)

= Sushi_ChIPSeq_pol2.bed$strand,

> labelgenome(chrom,chromstart,chromend,n=2,scale="Kb")
> legend("topright",inset=0,legend=c("reverse","forward"),fill=SushiColors(2)(2),

border=SushiColors(2)(2),text.font=2,cex=0.75)

plotBed can also plot bed elements on diﬀerent rows as speciﬁed by the user.
First, we will use the Sushi function maptocolors() to assign a diﬀerent color
to each row.

> Sushi_ChIPSeq_severalfactors.bed$color =

maptocolors(Sushi_ChIPSeq_severalfactors.bed$row,
col=SushiColors(6))

15

2281.52282chr11Kbreverseforward2281.52282chr11KbreverseforwardBy providing row and color information plotBed() can be used to compare bed
elements from diﬀerent samples by plotting them on diﬀerent rows.

> chrom
> chromstart
> chromend
> plotBed(beddata

= "chr15"
= 72800000

= 73100000

= Sushi_ChIPSeq_severalfactors.bed,chrom = chrom,

chromstart = chromstart,chromend =chromend,
rownumber = Sushi_ChIPSeq_severalfactors.bed$row, type = "circles",
color=Sushi_ChIPSeq_severalfactors.bed$color,row="given",
plotbg="grey95",rowlabels=unique(Sushi_ChIPSeq_severalfactors.bed$name),
rowlabelcol=unique(Sushi_ChIPSeq_severalfactors.bed$color),rowlabelcex=0.75)

> labelgenome(chrom,chromstart,chromend,n=3,scale="Mb")
> mtext("ChIP-seq",side=3, adj=-0.065,line=0.5,font=2)

That same data can be represented by rectangles that depict the actual width
of each bed element.

> plotBed(beddata

= Sushi_ChIPSeq_severalfactors.bed,chrom = chrom,

chromstart = chromstart,chromend =chromend,
rownumber = Sushi_ChIPSeq_severalfactors.bed$row, type = "region",
color=Sushi_ChIPSeq_severalfactors.bed$color,row="given",
plotbg="grey95",rowlabels=unique(Sushi_ChIPSeq_severalfactors.bed$name),
rowlabelcol=unique(Sushi_ChIPSeq_severalfactors.bed$color),rowlabelcex=0.75)

> labelgenome(chrom,chromstart,chromend,n=3,scale="Mb")
> mtext("ChIP-seq",side=3, adj=-0.065,line=0.5,font=2)

16

lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllCTCFEP300JUNDMAZMYCPOLR2ARAD21RESTSP1ZNF143ZNF27472.973chr15MbChIP−seqplotBed() can also be used to plot heatmaps representing the density of bed
elements. First, we will use the biomaRt function getBM() to get the gene
information we require.

> chrom
> chromstart
> chromend
> chrom_biomart
> mart=useMart(host=

= "chr15"
= 60000000
= 80000000
= gsub("chr","",chrom)

’

’

dataset=

hsapiens_gene_ensembl

)

’

may2009.archive.ensembl.org

’

, biomart=

’

ENSEMBL_MART_ENSEMBL

’

,

> geneinfobed = getBM(attributes = c("chromosome_name","start_position","end_position"),

> geneinfobed[,1] = paste("chr",geneinfobed[,1],sep="")

filters= c("chromosome_name","start","end"),
values=list(chrom_biomart,chromstart,chromend),mart=mart)

The data is in simple bed format with just three columns representing chromo-
some, start, and stop.

> head (geneinfobed)

chromosome_name start_position end_position
73372334
64580710
63375557
72570422
60903293
70130724

73372069
64580642
63375442
72570353
60903209
70130646

chr15
chr15
chr15
chr15
chr15
chr15

1
2
3
4
5
6

Now we can make a gene density plot using the plotBed function.

17

CTCFEP300JUNDMAZMYCPOLR2ARAD21RESTSP1ZNF143ZNF27472.973chr15MbChIP−seq> plotBed(beddata = geneinfobed[!duplicated(geneinfobed),],chrom = chrom,

chromstart = chromstart,chromend =chromend,row=
palettes = list(SushiColors(7)), type = "density")

’

supplied

,

’

> labelgenome(chrom, chromstart, chromend, n=4,scale="Mb",edgeblankfraction=0.10)
> mtext("Gene Density",side=3, adj=0,line=0.20,font=2)

3.7 plotManhattan

plotManhattan() diﬀers from most other Sushi functions in that it can plot
multiple chromosomes in a single plot. Because of this plotManhattan requires
some additional inputs.
It requires an object in bed format describing the
location of data points as well as vector of p-values (typically one of the columns
of the bed ﬁle). But it also requires an genome object that describes which
chromosomes to plot and their sizes (in bp). The genome object is very similar
to the genome ﬁles used for bedtools.

The bed data should look something like this:

>

1
2
3
4
5
6

head(Sushi_GWAS.bed)

chr.hg18 pos.hg18 pos.hg18.1

chr1 1695996
chr1 1696020
chr1 1698661
chr1 1711339
chr1 1712792
chr1 1736016

1695996 rs6603811
1696020 rs7531583
1698661 rs12044597
1711339 rs2272908
1712792 rs3737628
1736016 rs12408690

rsid pval.GC.DBP V6
0.003110 .
0.000824 .
0.001280 .
0.001510 .
0.001490 .
0.004000 .

And the genome ﬁle should look like this:

>

head(Sushi_hg18_genome)

V1

V2
1 chr1 247249719
2 chr10 135374737

18

657075chr15MbGene Density3 chr11 134452384
4 chr12 132349534
5 chr13 114142980
6 chr14 106368585

The plotManhattan() function is used to plot the data while the labelgenome()
function is used to add the genome labels to the x-axis. The labelgenome()
function also requires a genome object.

> plotManhattan(bedfile=Sushi_GWAS.bed,pvalues=Sushi_GWAS.bed[,5],

col=SushiColors(6),genome=Sushi_hg18_genome,cex=0.75)

> labelgenome(genome=Sushi_hg18_genome,n=4,scale="Mb",

edgeblankfraction=0.20,cex.axis=.5)

> axis(side=2,las=2,tcl=.2)
> mtext("log10(P)",side=2,line=1.75,cex=1,font=2)
> mtext("chromosome",side=1,line=1.75,cex=1,font=2)

pdf
2

3.8 plotGenes

plotGenes() can be used to plot gene structures that are stored in bed format.
If no geneinfo object is provided genes are looked up in the region using biomart
with biomart=’ensembl’ and dataset=’hsapiens gene ensembl’.

19

> head(Sushi_genes.bed)

chrom

start

1 chr15 73017309 73017438 COX5A
2 chr15 72999672 72999836 COX5A
3 chr15 73003042 73003164 COX5A
4 chr15 73006160 73006281 COX5A
5 chr15 73008510 73008626 COX5A

stop gene score strand
-1
-1
-1
-1
-1

.
.
.
.
.

Using plotGenes() with arguments bentline=FALSE and plotgenetype="arrow"
produces arrow and line gene structures.

> chrom
> chromstart
> chromend
> pg = plotGenes(Sushi_genes.bed,chrom,chromstart,chromend ,

= "chr15"
= 72998000
= 73020000

types=Sushi_genes.bed$type,maxrows=1,bheight=0.2,
plotgenetype="arrow",bentline=FALSE,

labeloffset=.4,fontsize=1.2,arrowlength = 0.025,

labeltext=TRUE)

> labelgenome( chrom, chromstart,chromend,n=3,scale="Mb")

This function can also be used to plot transcript structures. The ﬁrst 20 lines
of a data frame describing RNA seq data are shown below.

> Sushi_transcripts.bed[1:20,]

chrom

start

stop

gene

1 chr15 73062668 73062770 ENST00000362710 0.000000
2 chr15 73097788 73097929 ENST00000361900 0.000000
3 chr15 73097264 73097365 ENST00000361900 0.000000
4 chr15 73095987 73096143 ENST00000361900 0.000000
5 chr15 73092071 73092199 ENST00000361900 0.000000
6 chr15 73091234 73091240 ENST00000361900 0.000000
7 chr15 73017309 73017408 ENST00000322347 31.488695
8 chr15 73006160 73006281 ENST00000322347 31.488695

score strand type
-1 exon
1 exon
1 exon
1 exon
1 exon
1 exon
-1 exon
-1 exon

20

COX5A73.00573.0173.015chr15Mb9 chr15 73008510 73008626 ENST00000322347 31.488695
10 chr15 72984058 72984106 ENST00000357635 7.473977
11 chr15 72984548 72984625 ENST00000357635 7.473977
12 chr15 72985672 72985759 ENST00000357635 7.473977
13 chr15 72985981 72986194 ENST00000357635 7.473977
14 chr15 72975546 72975719 ENST00000379693 2.422616
15 chr15 72972532 72972714 ENST00000379693 2.422616
16 chr15 72972055 72972196 ENST00000379693 2.422616
17 chr15 72970773 72970973 ENST00000379693 2.422616
18 chr15 72969965 72970048 ENST00000379693 2.422616
19 chr15 72972532 72972714 ENST00000352410 0.917141
20 chr15 72972055 72972196 ENST00000352410 0.917141

-1 exon
-1 exon
-1 exon
-1 exon
-1 exon
1 exon
1 exon
1 exon
1 exon
1 exon
1 exon
1 exon

A vector type can be used to specify if each region is an ’exon’ or ’utr’ while
plotgenetype="box" plots regions as a boxes rather than arrows. The data
can be plotted using plotGenes(). The colorby argument is used to color the
transcripts by log 10(FPKM). UTR regions are drawn as shorter boxes than
exons.

= "chr15"
= 72965000
= 72990000

> chrom
> chromstart
> chromend
> pg = plotGenes(Sushi_transcripts.bed,chrom,chromstart,chromend ,
types = Sushi_transcripts.bed$type,
colorby=log10(Sushi_transcripts.bed$score+0.001),
colorbycol= SushiColors(5),colorbyrange=c(0,1.0),
labeltext=TRUE,maxrows=50,height=0.4,plotgenetype="box")

> labelgenome( chrom, chromstart,chromend,n=3,scale="Mb")
> addlegend(pg[[1]],palette=pg[[2]],title="log10(FPKM)",side="right",
bottominset=0.4,topinset=0,xoffset=-.035,labelside="left",
width=0.025,title.offset=0.055)

21

3.9 Zoom functions

A critical characteristic of the Sushi package is its ability to create highly cus-
tomizable, publication-ready, multi-panel ﬁgures. Here, we will create a basic
three panel ﬁgure and demonstrate how the zoom functions work (zoomsregion
and zoombox). To illustrate these feature we will use the plotBedgraph() func-
tion to plot bedgrpah data representing a DNaseI hypersensitivity experiment
in K562 cells.

In order to make a multipanel ﬁgure we will use the R function layout. Layout
divides the device into rows and columns accoriding to a matrix you provide.
The matrix also tells it which plots will appear on which parts of the plotting
device. Below we make a 2 by 2 matrix. The entire top row will be used to plot
the ﬁrst plot while the bottom row with contain two plots. For more info on
layout try ?layout.

> layout(matrix(c(1,1,2,3),2, 2, byrow = TRUE))
> par(mar=c(3,4,1,1))

Next we will add the ﬁrst plot

> chrom
> chromstart
> chromend

= "chr11"
= 1900000
= 2350000

22

ENST00000323744ENST00000352410ENST00000379693ENST0000035763572.9772.97572.9872.985chr15Mblog10(FPKM)00.20.50.81> plotBedgraph(Sushi_DNaseI.bedgraph,chrom,chromstart=chromstart,

> labelgenome(chrom,chromstart=chromstart,chromend=chromend,n=4,

chromend=chromend,colorbycol= SushiColors(5))

scale="Mb")

> mtext("Read Depth",side=2,line=1.75,cex=1,font=2)
> axis(side=2,las=2,tcl=.2)

Next we will add the zoom regions using the function zoomsregion(). The
argument offsets is used to precisely position the left and right edges of the
widest part of the zoom.

> zoomregion1
> zoomregion2
> zoomsregion(zoomregion1,extend=c(0.01,0.13),wideextend=0.05,

= c(1955000,1960000)
= c(2279000,2284000)

offsets=c(0,0.580))

> zoomsregion(zoomregion2,extend=c(0.01,0.13),wideextend=0.05,

offsets=c(0.580,0))

23

22.12.22.3chr11MbRead Depth050100150200Then we can add each of the zoomed inset regions. For, each region we need
execute the zoombox function in order to draw the lines around the new plots.

> plotBedgraph(Sushi_DNaseI.bedgraph,chrom,chromstart=zoomregion1[1],

chromend=zoomregion1[2],colorbycol= SushiColors(5))

> labelgenome(chrom,chromstart=zoomregion1[1],chromend=zoomregion1[2],

n=4,scale="Kb",edgeblankfraction=0.2,cex.axis=.75)

> zoombox()
> mtext("Read Depth",side=2,line=1.75,cex=1,font=2)
> axis(side=2,las=2,tcl=.2)
> plotBedgraph(Sushi_DNaseI.bedgraph,chrom,chromstart=zoomregion2[1],

chromend=zoomregion2[2],colorbycol= SushiColors(5))

> labelgenome(chrom,chromstart=zoomregion2[1],chromend=zoomregion2[2],

n=4,scale="Kb",edgeblankfraction=0.2,cex.axis=.75)

> zoombox()
> mtext("Read Depth",side=2,line=1.75,cex=1,font=2)
> axis(side=2,las=2,tcl=.2)

24

22.12.22.3chr11MbRead Depth0501001502003.10 Color functions

Sushi includes three functions to assist in the generating of R colors and color
palettes: SushiColors(), maptocolors(), opaque().

3.10.1 SushiColors

SushiColors() provides default color palettes for the Sushi package.

To see a list of available color palettes:

> SushiColors(palette=

’

’

list

)

[1] 2 3 4 5 6 7

To view the color palettes:

25

22.12.22.3chr11MbRead Depth05010015020019571958chr11KbRead Depth05010015020022812282chr11KbRead Depth050100150200> plot(1,xlab=

’’

’

,xaxt=

n

’

’’

’

,yaxt=

’

n

,xlim=c(0.5,7.5),

ylim=c(2,7.5),type=

,ylab=
’
’
)

n

> for (i in (2:7))

{

for (j in (1:i))
{

rect(j-.5,i,j+.5,i+.5,col=SushiColors(i)(i)[j])

}

}

> axis(side=2,at=(2:7),labels=(2:7),las=2)
> axis(side=1,at=(1:7),labels=(1:7))
> mtext("SushiColors",side=3,font=2, line=1, cex=1.5)
> mtext("colors",side=1,font=2, line=2)
> mtext("palette",side=2,font=2, line=2)

3.10.2 opaque

opaque() takes any color or vector of colors and makes themp opaque. The
degree of transparency is determined by the argument transparency which is
a value between 0 and 1.

> plot(1,xlab=

’’

’

,xaxt=

’

n

’’

,ylab=

’

,yaxt=

’

n

’

,bty=

’

n

’

,type=

’

n

,

xlim=c(-.15,1.05),ylim=c(-1,2))

> for (i in seq(0,1,by=0.1))

{

}

rect(i-.05,-1,i+.05,1,col=opaque("red",transparency=i))
rect(i-.05,0,i+.05,2,col=opaque("blue",transparency=1-i))

> axis(side=1,at=seq(0,1,by=0.1),labels=seq(0,1,by=0.1))
> mtext("red transparency",side=1,font=2, line=2)
> axis(side=3,at=seq(0,1,by=0.1),labels=seq(1,0,by=-0.1))
> mtext("blue transparency",side=3,font=2, line=2)
> text(-0.075,1.5,labels="blue",font=2,adj=1)

26

2345671234567SushiColorscolorspalette> text(-0.075,0.5,labels="overlap",font=2,adj=1)
> text(-0.075,-.5,labels="red",font=2,adj=1)

3.10.3 maptocolors

maptocolors() takes a vector of values and maps them to a color palette which
can be used for plotting.

> set.seed(3)
> values = rnorm((1:10))
> colorpalette = SushiColors(5)
> plot(x=(1:10),y=values,col=maptocolors(values,colorpalette),

pch=19,cex=4,xlab="data points",yaxt=

n

,ylim=range(values)*1.2)

> addlegend(range(values),title="key",palette=colorpalette,

’

’

’

’

side=

left

,xoffset = -0.125,width=0.03,bottominset = 0.5, topinset = 0.025)

> axis(side=2,las=2)

27

00.10.20.30.40.50.60.70.80.91red transparency10.90.80.70.60.50.40.30.20.10blue transparencyblueoverlapred3.11 labeling functions

3.11.1 labelgenome

labelgenome() Add genome coordinates to the x-axis of a plot. The line
argument can be used to oﬀset the axis and n can be used to determine the
desired umber of tick marks.

> par(mar=c(8,3,3,1),mgp=c(3, .3, 0))
> plotBedgraph(Sushi_DNaseI.bedgraph,chrom="chr11",chromstart=1650000,
chromend=2350000,colorbycol=SushiColors(7))

> labelgenome(chrom="chr11",chromstart=1650000,chromend=2350000,

side=1,n=4,scale="Mb",line=.25)

> labelgenome(chrom="chr11",chromstart=1650000,chromend=2350000,

side=1,n=3,scale="Kb",line=2)

> labelgenome(chrom="chr11",chromstart=1650000,chromend=2350000,

side=1,n=1,scale="bp",line=4)

28

246810data pointsvalueskey−1.2−0.600.61.3−1.5−1.0−0.50.00.51.01.5Manhattan plots include multiple genomes and labeling the axes of Manhattan
plots requires the same genome oject and value of space that were used to in
plotManhattan()

> plotManhattan(bedfile=Sushi_GWAS.bed,pvalues=Sushi_GWAS.bed[,5],

col=SushiColors(6),genome=Sushi_hg18_genome,
cex=0.75,space=0.05)

> labelgenome(genome=Sushi_hg18_genome,n=4,scale="Mb",

edgeblankfraction=0.20,cex.axis=.5,space=0.05)

> axis(side=2,las=2,tcl=.2)
> mtext("log10(P)",side=2,line=1.75,cex=1,font=2)
> mtext("chromosome",side=1,line=1.75,cex=1,font=2)

pdf
2

29

1.81.922.12.2chr11Mb180020002200chr11Kb2000000chr11bp3.11.2 labelplot

Plot labels and titles can be added with the labelplot() function.

> labelplot("A) ","Manhattan Plot")

> plotManhattan(bedfile=Sushi_GWAS.bed,pvalues=Sushi_GWAS.bed[,5],

col=SushiColors(6),genome=Sushi_hg18_genome,
cex=0.75,space=0.05)

> labelgenome(genome=Sushi_hg18_genome,n=4,scale="Mb"

,edgeblankfraction=0.20,cex.axis=.5,space=0.05)

> axis(side=2,las=2,tcl=.2)
> mtext("log10(P)",side=2,line=1.75,cex=1,font=2)
> mtext("chromosome",side=1,line=1.75,cex=1,font=2)
> labelplot("A) ","Manhattan Plot")

pdf
2

30

[1] TRUE

4 Tips

Other popular ﬁle formats such as BAM and GFF are not explicitly supported
by Sushi. However, data stored in these formats can be easily converted to BED
format using common command line tools such as the bedtools software suite
available at https://github.com/arq5x/bedtools2. Some examples taken from
the bedtools are shown below.

Convert BAM alignments to BED format.

bamToBed -i reads.bam > reads.bed

Convert BAM alignments to BED format using edit distance (NM) as the BED
score.

bamToBed -i reads.bam -ed > reads.bed

Convert BAM alignments to BEDPE format.

bamToBed -i reads.bam -bedpe > reads.bedpe

These BED ﬁles can easily be read into R for use with Sushi using the following
R command:

> read.table(file="reads.bed",sep="\t")

31

5 Appendix

For illustrative purposes we include a complex ﬁgure as published in the accom-
panying manuscript (Phanstiel, et al.).

l i b r a r y ( ’ S u s h i ’ )
pdfname = ” v i g n e t t e s / F i g u r e 1 . pdf ”
S u s h i data = data ( package = ’ S u s h i ’ )

1
2
3
4 data ( l i s t = S u s h i data$ r e s u l t s [ , 3 ] )
5 makepdf = TRUE
6
7 ###
8 ### CODE
9 ###

pdf ( pdfname , h e i g h t =10 , width =12)

}

i f
{

f o r a l l o f

( makepdf == TRUE)

layout ( matrix ( c ( 1 , 1 , 1 , 1 ,
1 , 1 , 1 , 1 ,
2 , 2 , 8 , 8 ,
2 , 2 , 9 , 9 ,
3 , 3 , 1 0 , 1 0 ,
3 , 3 , 1 0 , 1 0 ,
4 , 4 , 1 1 , 1 1 ,
4 , 4 , 1 1 , 1 1 ,
5 , 5 , 1 2 , 1 2 ,
5 , 5 , 1 2 , 1 2 ,
6 , 7 , 1 3 , 1 3 ,
6 , 7 , 1 4 , 1 4

10
11
12
13
14
15
16 # make a l a y o u t
17
18
19
20
21
22
23
24
25
26
27
28
29
30 par (mgp=c ( 3 , . 3 , 0 ) )
31
32
33 ###
34 ### (A) manhattan p l o t
35 ###
36
37 # s e t
38 par ( mar=c ( 3 , 4 , 3 , 2 ) )
39
40 # s e t
41
42
43
44
45

chrom1
c h r o m s t a r t 1
chromend1

) , 1 2 , 4 , byrow=TRUE) )

t h e genomic r e g i o n s

t h e margins

chrom2

= ”c h r 1 1 ”
= 500000
= 5050000

= ”c h r 1 5 ”

t h e p l o t s

32

c h r o m s t a r t 2
chromend2

46
47
48
49 # make t h e manhattan p l o t
50

= 73000000
= 89500000

plotManhattan ( b e d f i l e=S u s h i GWAS. bed , p v a l u e s=S u s h i GWAS. bed

[ , 5 ] , genome=S u s h i hg18 genome , cex =0.75)

51
52 # add zoom 1
53

z o o m s r e g i o n ( r e g i o n=c ( c h r o m s t a r t 1 , chromend1 ) , chrom=chrom1 ,

genome=S u s h i hg18 genome , extend=c ( 0 . 0 7 , 0 . 2 ) , w ide e x t e n d
=0.2 , o f f s e t s=c ( 0 , . 5 3 5 ) )

54
55 # add zoom 2
56

z o o m s r e g i o n ( r e g i o n=c ( c h r o m s t a r t 2 , chromend2 ) , chrom=chrom2 ,

genome=S u s h i hg18 genome , extend=c ( 0 . 0 7 , 0 . 2 ) , w ide e x t e n d
=0.2 , o f f s e t s=c ( . 5 3 5 , 0 ) )

57
58 # add l a b e l s
59

l a b e l g e n o m e ( genome=S u s h i hg18 genome , n=4 , s c a l e=”Mb” ,

e d g e b l a n k f r a c t i o n =0.20)

t c l =.2)

s i d e =2 ,

l i n e =1.75 , cex =.75 ,

f o n t =2)

l e t t e r a d j = −.025)

l a b e l p l o t ( ”A) ” , ” GWAS” ,

l a s =2,

l a b e l

60
61 # add y−a x i s
62
axis ( s i d e =2,
63 mtext ( ” l o g 1 0 (P) ” ,
64
65 # Add p l o t
66
67
68
69 ###
70 ### (B) Hi−C
71 ###
72
73 # s e t
74 par ( mar=c ( 3 , 4 , 2 , 2 ) )
75
76 # s e t
chrom
77
c h r o m s t a r t
78
chromend
79
80
zoomregion
81
82 # p l o t
83

t h e HiC d a t a

t h e margins

t h e genomic r e g i o n s

= ”c h r 1 1 ”
= 500000
= 5050000
= c ( 1 7 0 0 0 0 0 , 2 3 5 0 0 0 0 )

p h i c = p l o t H i c ( S u s h i HiC . matrix , chrom , c h r o m s t a r t , chromend ,

max y = 2 0 , z r a n g e=c ( 0 , 2 8 ) )

84
85 # add l a b e l s
86

l a b e l g e n o m e ( chrom , c h r o m s t a r t , chromend , n=4, s c a l e=”Mb” ,

e d g e b l a n k f r a c t i o n =0.20)

87

33

88 # add t h e l e g e n d
89

a d d l e g e n d ( p h i c [ [ 1 ] ] , palette=p h i c [ [ 2 ] ] ,

r i g h t ” , b o t t o m i n s e t =0.4 ,
l a b e l s i d e=” l e f t ” , width =0.025 , t i t l e . o f f s e t =0.035)

t i t l e=” s c o r e ” ,
t o p i n s e t =0, x o f f s e t = −.035 ,

s i d e=”

z o o m s r e g i o n ( r e g i o n=zoomregion , extend=c ( 0 . 0 5 , 0 . 2 5 ) )

zoombox ( zoomregion=zoomregion )

l a b e l p l o t ( ”B) ” , ” HiC ”)

l a b e l

90
91 # add zoom
92
93
94 # add zoombox
95
96
97 # Add p l o t
98
99
100
101 ###
102 ### (C) 5C
103 ###
104
105 # s e t
106 par ( mar=c ( 3 , 4 , 2 , 2 ) )
107
108 # s e t
chrom
109
c h r o m s t a r t
110
111
chromend
112
113 # p l o t
114

t h e margins

t h e l o o p s

t h e genomic r e g i o n s

= ”c h r 1 1 ”
= 1650000
= 2350000

pbpe = plotBedpe ( S u s h i 5C. bedpe , chrom , c h r o m s t a r t , chromend ,

h e i g h t s=S u s h i 5C. bedpe$ s c o r e , o f f s e t =0,
’ ,
samplenumber ,

lwd =1, p l o t t y p e=” l o o p s ” , c o l o r b y=S u s h i 5C. bedpe$
c o l o r b y c o l=S u s h i C o l o r s ( 3 ) )

f l i p =FALSE, bty= ’ n

zoombox ( p a s s t h r o u g h=TRUE)

115
116 # add zoombox
117
118
119 # add t h e genome l a b e l s
120
121
122 # add t h e l e g e n d
123

legend ( ” t o p r i g h t ” ,

l a b e l g e n o m e ( chrom , c h r o m s t a r t , chromend , n=3 , s c a l e=”Mb”)

”) , co l=S u s h i C o l o r s ( 3 ) ( 3 ) , pch =19 , bty= ’ n ’ , text . f o n t =2)

i n s e t =0.01 ,

legend=c ( ”K562 ” , ”HeLa ” , ”GM12878

l a s =2,

t c l =.2)

124
125 # add y−a x i s
126
axis ( s i d e =2,
127 mtext ( ”Z−s c o r e ” ,
128
129 # Add p l o t
130
131

l a b e l

l a b e l p l o t ( ”C) ” , ” 5C”)

s i d e =2,

l i n e =1.75 , cex =.75 ,

f o n t =2)

34

t h e margins

132
133 ###
134 ### (D) ChIA PET ( P o l I I )
135 ###
136
137 # s e t
138 par ( mar=c ( 3 , 4 , 2 , 2 ) )
139
140 # s e t
chrom
141
c h r o m s t a r t
142
143
chromend
144
145 # p l o t
146

t h e l o o p s

t h e genomic r e g i o n s

= ”c h r 1 1 ”
= 1650000
= 2350000

pbpe = plotBedpe ( S u s h i ChIAPET p o l 2 . bedpe , chrom , c h r o m s t a r t ,

f l i p =TRUE, bty= ’ n ’ ,

chromend ,
c o l o r b y=abs ( S u s h i ChIAPET p o l 2 . bedpe$ s t a r t 1 −S u s h i ChIAPET
p o l 2 . bedpe$ s t a r t 2 ) , c o l o r b y c o l=S u s h i C o l o r s ( 5 ) )

lwd =1, p l o t t y p e=” l i n e s ” ,

147
148 # add t h e genome l a b e l s
149
150
151 # add t h e l e g e n d
152

l a b e l g e n o m e ( chrom , c h r o m s t a r t , chromend , n=4, s c a l e=”Mb”)

a d d l e g e n d ( pbpe [ [ 1 ] ] , palette=pbpe [ [ 2 ] ] ,
s i d e=” r i g h t ” , b o t t o m i n s e t =0.05 ,

t i t l e=” d i s t a n c e ( bp ) ” ,

t o p i n s e t =0.35 , x o f f s e t

= −.035 ,
l a b e l s . d i g i t s =0)

l a b e l s i d e=” l e f t ” , width =0.025 , t i t l e . o f f s e t =0.08 ,

zoombox ( p a s s t h r o u g h=TRUE)

l a b e l p l o t ( ”D) ” , ” ChIA−PET ( Pol2 ) ”)

l a b e l

153
154 # add zoombox
155
156
157 # Add p l o t
158
159
160
161 ###
162 ### (E) DNaseI
163 ###
164
165 # s e t
166 par ( mar=c ( 3 , 4 , 2 , 2 ) )
167
168 # s e t
chrom
169
c h r o m s t a r t
170
chromend
171
zoomregion1
172
173
zoomregion2
174
175 # o v e r l a p p i n g ,

t h e margins

t h e genomic r e g i o n s

= ”c h r 1 1 ”
= 1650000
= 2350000
= c ( 1 8 6 0 0 0 0 , 1 8 6 1 0 0 0 )
= c ( 2 2 8 1 0 0 0 , 2 2 8 2 4 0 0 )

t r a n s p a r e n t , and r e s c a l e d

35

176

pl otBe dg raph ( S u s h i DNaseI . bedgraph , chrom , c h r o m s t a r t ,
c o l o r b y c o l=S u s h i C o l o r s ( 5 ) )

chromend ,

177
178 # add zoom 1
179

z o o m s r e g i o n ( zoomregion1 , extend=c ( − 0 . 8 , 0 . 1 8 ) , w i d e e x t e nd =0.10 ,

o f f s e t s=c ( 0 , . 5 7 7 ) )

l a b e l g e n o m e ( chrom , c h r o m s t a r t , chromend , n=4, s c a l e=”Mb”)

z o o m s r e g i o n ( zoomregion2 , extend=c ( 0 . 0 1 , 0 . 1 8 ) , w i de e x te n d =0.10 ,

l i n e =1.75 , cex =.75 ,

f o n t =2)

180
181 # add t h e genome l a b e l s
182
183
184 # add zoombox
185
186
187 # add zoom 2
188

o f f s e t s=c ( . 5 7 7 , 0 ) )

zoombox ( zoomregion=zoomregion )

t c l =.2)
s i d e =2,

l a b e l
l a b e l p l o t ( ”E) ” , ” DnaseI ”)

189
190 # add y−a x i s
l a s =2,
axis ( s i d e =2,
191
192 mtext ( ”Read Depth ” ,
193
194 # Add p l o t
195
196
197
198 ###
199 ### (F) ChIP−Seq ChIP Exo
200 ###
201
202 # s e t
chrom
203
c h r o m s t a r t
204
chromend
205
zoomregion1
206
207
zoomregion2
208
209 # p l o t c h i p −s e q d a t a
210

t h e genomic r e g i o n s

= ”c h r 1 1 ”
= 1650000
= 2350000
= c ( 1 8 6 0 0 0 0 , 1 8 6 1 0 0 0 )
= c ( 2 2 8 1 0 0 0 , 2 2 8 2 4 0 0 )

plo tB edg r aph ( S u s h i ChIPSeq CTCF. bedgraph , chrom , zoomregion1
t r a n s p a r e n c y =.50 , c o l o r=S u s h i C o l o r s

[ 1 ] , zoomregion1 [ 2 ] ,
( 2 ) ( 2 ) [ 1 ] )

211
212 # p l o t c h i p −s e q d a t a
213

plo tB edg r aph ( S u s h i ChIPExo CTCF. bedgraph , chrom , zoomregion1
t r a n s p a r e n c y =.50 , c o l o r=S u s h i C o l o r s

[ 1 ] , zoomregion1 [ 2 ] ,
( 2 ) ( 2 ) [ 2 ] , o v e r l a y=TRUE,

r e s c a l e o v e r l a y=TRUE)

214
215 # Add p l o t
216
217
218 # add t h e genome l a b e l s

l a b e l

l a b e l p l o t ( ”F) ” , ” ChIP−Seq / ChIP−Exo ” ,

l e t t e r a d j = −.125)

36

219

l a b e l g e n o m e ( chrom , zoomregion1 [ 1 ] , zoomregion1 [ 2 ] , n=3,

l i n e

=.5 , s c a l e=”Mb” , e d g e b l a n k f r a c t i o n =0.2)

220
221 # add zoombox
222
zoombox ( )
223
224 # add l e g e n d
225

legend ( ” t o p r i g h t ” ,

i n s e t =0.025 ,

legend=c ( ”ChIP−s e q (CTCF) ” , ”

ChIP−exo (CTCF) ”) ,
b o r d e r=S u s h i C o l o r s ( 2 ) ( 2 ) , text . f o n t =2, cex =0.75)

f i l l =opaque ( S u s h i C o l o r s ( 2 ) ( 2 ) , 0 . 5 ) ,

226
227
228 ###
229 ### (G) Bed P i l e up
230 ###
231
232 # s e t
chrom
233
c h r o m s t a r t
234
chromend
235
zoomregion1
236
237
zoomregion2
238
239 # p l t
240

t h e genomic r e g i o n s

= ”c h r 1 1 ”
= 1650000
= 2350000
= c ( 1 9 5 5 0 0 0 , 1 9 6 5 0 0 0 )
= c ( 2 2 8 1 0 0 0 , 2 2 8 2 4 0 0 )

t h e c h i p −s e q d a t a as a p i l e −up

plotBed ( beddata=S u s h i ChIPSeq p o l 2 . bed , chrom=chrom ,

c h r o m s t a r t=zoomregion2 [ 1 ] , chromend=zoomregion2 [ 2 ] ,
c o l o r b y=S u s h i ChIPSeq p o l 2 . bed$ s t r a n d ,
c o l o r b y c o l=
S u s h i C o l o r s ( 2 ) , w i g g l e =0.001 , h e i g h t =0.25)

241
242 # add t h e genome l a b e l s
243

l a b e l g e n o m e ( chrom , zoomregion2 [ 1 ] , zoomregion2 [ 2 ] , n=2, s c a l e=

”Mb”)

244
245 # add zoombox
246
zoombox ( )
247
248 # add l e g e n d
249

legend ( ” t o p r i g h t ” ,

i n s e t =0.025 ,

legend=c ( ” r e v e r s e ” , ”f o r w a r d ”) ,

f i l l =S u s h i C o l o r s ( 2 ) ( 2 ) , b o r d e r=S u s h i C o l o r s ( 2 ) ( 2 ) , text .

f o n t =2, cex =0.75)

l a b e l
l a b e l p l o t ( ”G) ” , ” ChIP−Seq ” ,

250
251 # Add p l o t
252
253
254
255 ###
256 ### (H) manhattan p l o t zoomed
257 ###
258
259 # s e t

t h e margins

l e t t e r a d j = −.125)

37

t h e genomic r e g i o n s

260 par ( mar=c ( 0 . 1 , 4 , 2 , 2 ) )
261
262 # s e t
chrom
263
c h r o m s t a r t
264
chromend
265
c h r o m s t a r t 2
266
267
chromend2
268
269 # make t h e manhattan p l o t
270

= ”c h r 1 5 ”
= 60000000
= 80000000
= 72000000
= 74000000

plotManhattan ( b e d f i l e=S u s h i GWAS. bed , chrom=chrom2 , c h r o m s t a r t
=c h r o m s t a r t , chromend=chromend , p v a l u e s=S u s h i GWAS. bed$
p v a l .GC.DBP, co l=S u s h i C o l o r s ( 6 ) (nrow( S u s h i hg18 genome ) )
[ 1 5 ] , cex =0.75)

271
272 # add zoom i n
273

z o o m s r e g i o n ( r e g i o n=c ( c h r o m s t a r t 2 , chromend2 ) , chrom=chrom2 ,

genome=NULL, ex t end=c ( 0 . 0 7 5 , 1 ) , o f f s e t s=c ( 0 . 0 , 0 ) )

l a b e l

l a s =2,

t c l =.2)

s i d e =2,

f o n t =2)

t o p e x t e n d =5)

l i n e =1.75 , cex =.75 ,

l a b e l p l o t ( ”H) ” , ” GWAS”)

zoombox ( p a s s t h r o u g h=TRUE,

274
275 # add zoom box
276
277
278 # add y−a x i s
axis ( s i d e =2,
279
280 mtext ( ”Z−s c o r e ” ,
281
282 # Add p l o t
283
284
285
286 ###
287 ### ( I ) Gene d e n s i t y
288 ###
289
290 # s e t
291 par ( mar=c ( 3 , 4 , 1 . 8 , 2 ) )
292
293 # s e t
chrom
294
c h r o m s t a r t
295
chromend
296
chrom biomart
297
298
299 # s e t
t h e mart ( s i n c e we want hg18 c o o r d i n a t e s )
300 mart=useMart ( h o s t= ’ may2009 . a r c h i v e . ensembl . o r g ’ , biomart= ’
ENSEMBL MART ENSEMBL ’ , d a t a s e t= ’ h s a p i e n s gene ensembl ’ )

= ”c h r 1 5 ”
= 60000000
= 80000000
= gsub ( ”c h r ” , ” ” , chrom )

t h e genomic r e g i o n s

t h e margins

301
302 # g e t
303

j u s t gene i n f o

g e n e i n f o b e d = getBM ( attributes=c ( ”chromosome name ” , ” s t a r t

p o s i t i o n ” , ”end p o s i t i o n ”) ,

f i l t e r s =c ( ”chromosome name ” , ”

38

s t a r t ” , ”end ”) , v a l u e s=l i s t ( chrom biomart , c h r o m s t a r t ,
chromend ) , mart=mart )

g e n e i n f o b e d [ , 1 ] = paste ( ”c h r ” , g e n e i n f o b e d [ , 1 ] , s e p=” ”)

304
305 # add ”c h r ” t o t h e chrom column
306
307
308 # p l o t gene d e n s i t y
309

plotBed ( beddata=g e n e i n f o b e d [ ! duplicated ( g e n e i n f o b e d ) , ] , chrom=
chrom , c h r o m s t a r t=c h r o m s t a r t , row= ’ s u p p l i e d ’ , chromend=
type=” d e n s i t y ”)
chromend , p a l e t t e s=l i s t ( S u s h i C o l o r s ( 7 ) ) ,

310
311 #l a b e l genome
312

l a b e l g e n o m e ( chrom=chrom , c h r o m s t a r t , chromend , n=4, s c a l e=”Mb”

, e d g e b l a n k f r a c t i o n =0.10)

313
314 # add zoom i n
315

z o o m s r e g i o n ( r e g i o n=c ( c h r o m s t a r t 2 , chromend2 ) , chrom=chrom2 ,
genome=NULL, e x te nd=c ( 2 , 1 . 0 ) , w i d e e x te n d =.75 , o f f s e t s=c
( 0 . 0 , 0 ) )

zoombox ( zoomregion=c ( c h r o m s t a r t 2 , chromend2 ) ,

t o p e x t e n d =5)

l a b e l p l o t ( ” I ) ” , ” Gene D e n s i t y ”)

l a b e l

316
317 # add zoombox
318
319
320 # Add p l o t
321
322
323
324 ###
325 ### ( J ) RNA s e q
326 ###
327
328 # s e t
329 par ( mar=c ( 3 , 4 , 2 , 2 ) )
330
331 # s e t
332
333
334
335
336
337
338 # p l o t
339

chrom2
c h r o m s t a r t 2
chromend2
zoomregion
chrom2 biomart

t h e margins

t r a n s c r i p t s

t h e genomic r e g i o n s

= ”c h r 1 5 ”
= 72800000
= 73100000
= c ( 7 2 9 9 8 0 0 0 , 7 3 0 2 0 0 0 0 )
= 15

pg = p l o t G e n e s ( S u s h i

t r a n s c r i p t s . bed , chrom2 , c h r o m s t a r t 2 ,

chromend2 ,
( S u s h i
S u s h i C o l o r s ( 5 ) ,
p l o t g e n e t y p e=”box ”)

t y p e s=S u s h i

t r a n s c r i p t s . bed$type , c o l o r b y=log10

t r a n s c r i p t s . bed$ s c o r e +0.001) , c o l o r b y c o l=

l a b e l t e x t=FALSE, maxrows =50 , h e i g h t =0.4 ,

340
341 # l a b e l genome
342

l a b e l g e n o m e ( chrom2 , c h r o m s t a r t 2 , chromend2 , n=3, s c a l e=”Mb”)

39

343
344 # add t h e l e g e n d
345

a d d l e g e n d ( pg [ [ 1 ] ] , palette=pg [ [ 2 ] ] ,

” r i g h t ” , b o t t o m i n s e t =0.4 ,
l a b e l s i d e=” l e f t ” , width =0.025 , t i t l e . o f f s e t =0.055)

t i t l e=” l o g 1 0 (FPKM) ” ,
t o p i n s e t =0, x o f f s e t = −.035 ,

s i d e=

z o o m s r e g i o n ( r e g i o n=zoomregion , extend=c ( − . 0 2 5 , 1 ) )

l a b e l
l a b e l p l o t ( ”J ) ” , ” RNA−s e q ”)

zoombox ( p a s s t h r o u g h=TRUE)

346
347 # add zoombox
348
349
350 # add zoom
351
352
353 # Add p l o t
354
355
356
357 ###
358 ### (K) ChIP Seq p e a k s
359 ###
360
361 # s e t
362 par ( mar=c ( 3 , 4 , 2 , 2 ) )
363
364 # s e t
chrom
365
c h r o m s t a r t
366
chromend
367
zoomregion
368
369
370

t h e margins

t h e genomic r e g i o n s

= ”c h r 1 5 ”
= 72800000
= 73100000
= c ( 7 2 9 9 8 0 0 0 , 7 3 0 2 0 0 0 0 )

S u s h i ChIPSeq s e v e r a l f a c t o r s . bed$ c o l o r = m a p t o c o l o r s ( S u s h i
ChIPSeq s e v e r a l f a c t o r s . bed$row , co l=S u s h i C o l o r s ( 6 ) )

371
372 # p l o t
373

i t

plotBed ( beddata=S u s h i ChIPSeq s e v e r a l f a c t o r s . bed , chrom=chrom ,
rownumber=S u s h i

c h r o m s t a r t=c h r o m s t a r t , chromend=chromend ,
ChIPSeq s e v e r a l f a c t o r s . bed$row ,

type=” c i r c l e s ” , c o l o r=

S u s h i ChIPSeq s e v e r a l f a c t o r s . bed$ c o l o r , row=” g i v e n ” ,
p l o t b g=”g r e y 9 5 ” ,
s e v e r a l f a c t o r s . bed$name ) ,

r o w l a b e l s=unique ( S u s h i ChIPSeq

r o w l a b e l c o l=unique ( S u s h i ChIPSeq

s e v e r a l f a c t o r s . bed$ c o l o r ) ,

r o w l a b e l c e x =0.75)

l a b e l g e n o m e ( chrom , c h r o m s t a r t , chromend , n=3, s c a l e=”Mb”)

374
375 # l a b e l genome
376
377
378 # add zoom
379
380
381 # add zoom i n
382

zoombox ( zoomregion = zoomregion )

z o o m s r e g i o n ( r e g i o n=zoomregion , chrom=chrom , extend=c ( 0 . 5 , . 2 2 ) ,

w i de e x t e nd =0.15 , o f f s e t s=c ( 0 . 0 , 0 ) )

40

l a b e l
l a b e l p l o t ( ”K) ” , ” ChIP−s e q ”)

383
384 # Add p l o t
385
386
387
388 ###
389 ### (L) Pol2 b e d g r p a h
390 ###
391
392 # s e t
393 par ( mar=c ( 3 , 4 , 2 , 2 ) )
394
395 # s e t
chrom
396
c h r o m s t a r t
397
398
chromend
399
400 # p l o t
401

t h e margins

t h e genomic r e g i o n s

= ”c h r 1 5 ”
= 72998000
= 73020000

t h e Pol2 b e d g r a p h d a t a

plo tBedgr a ph ( S u s h i ChIPSeq p o l 2 . bedgraph , chrom , c h r o m s t a r t ,

chromend ,

c o l o r b y c o l=S u s h i C o l o r s ( 5 ) )

l a b e l g e n o m e ( chrom , c h r o m s t a r t , chromend , n=3, s c a l e=”Mb”)

t c l =.2)
s i d e =2,

l i n e =1.75 , cex =.75 ,

f o n t =2)

l a b e l p l o t ( ”L) ” , ” Chip−Seq ( Pol2 ) ”)

zoombox ( p a s s t h r o u g h=TRUE)

l a b e l

402
403 # l a b e l genome
404
405
406 # add zoombox
407
408
409 # add y−a x i s
410
l a s =2,
axis ( s i d e =2,
411 mtext ( ”Read Depth ” ,
412
413 # Add p l o t
414
415
416
417 ###
418 ### (M) RNA−s e q b e d g r a p h
419 ###
420
421 # s e t
422 par ( mar=c ( 2 , 4 , . 5 , 2 ) )
423
424 # s e t
chrom
425
c h r o m s t a r t
426
427
chromend
428
429 # p l o t
430

t h e margins

t h e genomic r e g i o n s

= ”c h r 1 5 ”
= 72998000
= 73020000

t h e K562 RNAseq b e d g r a p h d a t a

plo tBedgr a ph ( S u s h i RNASeq K562 . bedgraph , chrom , c h r o m s t a r t ,

chromend ,

c o l o r b y c o l=S u s h i C o l o r s ( 5 ) )

41

l a b e l g e n o m e ( chrom , c h r o m s t a r t , chromend , n=3, s c a l e=”Mb”)

l a b e l
l a b e l p l o t ( ”M) ” , ” RNA−s e q ”)

zoombox ( p a s s t h r o u g h=TRUE)

431
432 # l a b e l genome
433
434
435 # add zoombox
436
437
438 # Add p l o t
439
440
441
442 ###
443 ### (N) Gene S t r u c t u r e s
444 ###
445
446 # s e t
447 par ( mar=c ( 3 , 4 , . 5 , 2 ) )
448
449 # s e t
chrom
450
c h r o m s t a r t
451
452
chromend
453
454 # p l o t gene s t r u c t u r e s
455

t h e margins

t h e genomic r e g i o n

= ”c h r 1 5 ”
= 72998000
= 73020000

456
457 # l a b e l genome
458
459
460 # add zoombox
zoombox ( )
461
462
463 # Add p l o t
464

l a b e l

=−0.4)

( makepdf == TRUE)

dev . o f f ( )

465
466
467
468
469

i f
{

}

42

p l o t G e n e s ( S u s h i g e n e s . bed , chrom , c h r o m s t a r t , chromend ,

maxrows=1, b h e i g h t =0.15 , p l o t g e n e t y p e=”arrow ” , b e n t l i n e=
FALSE,

f o n t s i z e =1.2 , a r r o w l e n g t h = 0 . 0 1 )

l a b e l o f f s e t =1,

l a b e l g e n o m e ( chrom , c h r o m s t a r t , chromend , n=3, s c a l e=”Mb”)

l a b e l p l o t ( ”N) ” , ” Gene S t r u c t u r e s ” ,

l e t t e r l i n e = −0.4 ,

t i t l e l i n e

6 Bibliography

[1] Biomart. URL http://www.biomart.org/.

[2] JR Dixon, S Selvaraj, F Yue, A Kim, Y Li, Y Shen, M Hu, JS Liu, and
B Ren. Topological domains in mammalian genomes identiﬁed by analysis
of chromatin interactions. Nature, 485, September 2012. doi: 10.1038/
nature11082. PMID: 22495300.

[3] International Consortium for Blood Pressure. Genetic variants in novel path-
ways inﬂuence blood pressure and cardiovascular disease risk. Nature, 478,
September 2011. doi: 10.1038/nature10405. PMID: 21909115.

[4] G Li, X Ruan, RK Auerbach, KS Sandhu, M Zheng, P Wang, HM Poh,
Y Goh, J Lim, J Zhang, HS Sim, SQ Peh, FH Mulawadi, CT Ong, YL Orlov,
S Hong, Z Zhang, S Landt, D Raha, G Euskirchen, CL Wei, W Ge, H Wang,
C Davis, KI Fisher-Aylor, A Mortazavi, M Gerstein, T Gingeras, B Wold,
Y Sun, MJ Fullwood, E Cheung, E Liu, WK Sung, M Snyder, and Y Ruan.
Extensive promoter-centered chromatin interactions provide a topological
basis for transcription regulation. Cell, 148:84–98, January 2012. doi: 10.
1016/j.cell.2011.12.014. PMID: 22265404.

43

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll12345678910111213141516171819202122468101214log10(P)A) GWAS1.522.533.54chr11Mbscore07142128B) HiC1.822.2chr11MblllK562HeLaGM1287802468101214Z−scoreC) 5C1.81.922.12.2chr11Mbdistance (bp)46264491685206125497165787D) ChIA−PET (Pol2)1.81.922.12.2chr11Mb050100150200Read DepthE) DnaseIF) ChIP−Seq / ChIP−Exo1.86041.8606chr11MbChIP−seq (CTCF)ChIP−exo (CTCF)2.28152.282chr11MbreverseforwardG) ChIP−Seqllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll46810Z−scoreH) GWAS657075chr15MbI) Gene Density72.973chr15Mblog10(FPKM)−3−1.9−0.80.41.5J) RNA−seqlllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllCTCFEP300JUNDMAZMYCPOLR2ARAD21RESTSP1ZNF143ZNF27472.973chr15MbK) ChIP−seq73.00573.0173.015chr15Mb0100200300400Read DepthL) Chip−Seq (Pol2)73.00573.0173.015chr15MbM) RNA−seqCOX5A73.00573.0173.015chr15MbN) Gene Structures[5] S Neph, J Vierstra, AB Stergachis, AP Reynolds, E Haugen, B Vernot,
RE Thurman, S John, R Sandstrom, AK Johnson, MT Maurano, R Hum-
bert, E Rynes, H Wang, S Vong, K Lee, D Bates, M Diegel, V Roach,
D Dunn, J Neri, A Schafer, RS Hansen, T Kutyavin, E Giste, M Weaver,
T Canﬁeld, P Sabo, M Zhang, G Balasundaram, R Byron, MJ MacCoss,
JM Akey, MA Bender, M Groudine, R Kaul, and JA Stamatoyannopou-
los. An expansive human regulatory lexicon encoded in transcription factor
footprints. Nature, 489:83–90, September 2012. doi: 10.1038/nature11212.
PMID: 22955618.

[6] HS Rhee and BF Pugh. Comprehensive genome-wide protein-dna interac-
tions detected at single-nucleotide resolution. Cell, 147, December 2011. doi:
10.1016/j.cell.2011.11.013. PMID: 22153082.

[7] A Sanyal, BR Lajoie, G Jain, and J Dekker. The long-range interaction
landscape of gene promoters. Nature, 489(7414):109–113, September 2012.
doi: 10.1038/nature11279. PMID: 22955621.

[8] The ENCODE Project Consortium. An integrated encyclopedia of DNA
elements in the human genome. Nature, 489(7414):57–74, September 2012.
ISSN 1476-4687. doi: 10.1038/nature11247. URL http://www.ncbi.nlm.
nih.gov/pubmed/22955616. PMID: 22955616.

44

