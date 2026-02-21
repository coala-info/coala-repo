seqPattern: an R package for visualisa-
tion of oligonucleotide sequence patterns
and motif occurrences

Vanja Haberle 1

May 8, 2015

Contents

1

Introduction . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2 Getting started . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3

Example data . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3.1

3.2

Zebrafish promoter sequences . . . . . . . . . . . . . . . . . . . . . .

Zebrafish promoter coordinates and associated features . . . . . . .

4

Visualising oligonucleotide and consensus sequence densi-
ties. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4.1

4.2

4.3

4.4

Preparing input sequences . . . . . . . . . . . . . . . . . . . . . . . .

Plotting dinucleotide density maps . . . . . . . . . . . . . . . . . . . .

Plotting average oligonucleotide profiles . . . . . . . . . . . . . . . . .

Plotting consensus sequence density map . . . . . . . . . . . . . . .

5

Visualising motif occurrences . . . . . . . . . . . . . . . . . . . . . . .

5.1

5.2

5.3

Plotting density of motif occurrences . . . . . . . . . . . . . . . . . . .

Plotting motif scanning scores . . . . . . . . . . . . . . . . . . . . . .

Plotting average motif occurrence profile . . . . . . . . . . . . . . . .

2

3

3

3

4

4

5

6

11

12

14

14

15

16

1vanja.haberle@gmail.com

6 Getting occurrence of sequence patterns and motifs without
visualisation . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

17

seqPattern

7

Session Info . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

18

1

Introduction

This document briefly describes how to use the package seqPattern. seqPattern is a Bioconductor-
compliant R package designed to visualise sequence patterns across a large set of sequences
(e.g. promoters, enhancers, ChIPseq peaks, etc.) centred at a common reference position
(e.g. TSS, peak position) and ordered by some feature. The visualisations includes plot-
ting the density of occurrences of di-, tri-, and in general any oligo-nucleotides, consensus
sequences specified using IUPAC nucleotide ambiguity codes and motifs specified by a posi-
tion weight matrix (PWM). Such visualisations are useful in discovering sequence patterns
positionally constrained with respect to the reference point and their correlation with the
specified feature [1].
Here is a list of functionalities provided in this package:

• Obtaining positions of occurrences of oligonucleotides or consensus sequences in an
ordered set of sequences centred at a common reference point in a matrix-like repre-
sentation.

• Visualising density of oligonucleotide or consensus sequence occurrences in an ordered
set of sequences centred at a common reference point. Multiple oligonucleotides can
be analysed simultaneously and their density plotted on the same colour scale allowing
visual comparison of enrichments/depletions of various oligonucleotides.

• Visualising average oligonucleotide profile for a set of sequences centred at a common

reference point.

• Obtaining positions of occurrences of motifs defined by a PWM in an ordered set
of sequences centred at a common reference point in a matrix-like representation.
A custom threshold can be applied to report only motif matches with score above
specified percentage of the maximal PWM score.

• Visualising density of motif occurrences in an ordered set of sequences centred at a
common reference point. Only motif matches with score above specified percentage
of the maximal PWM score are visualised.

• Visualising motif scanning scores for an ordered set of sequences centred at a common

reference point in the form of a heatmap.

• Visualising average motif occurrence profile (motif specified by a PWM) for a set of

sequences centred at a common reference point.

2

2 Getting started

To load the seqPattern package into your R envirnoment type:

seqPattern

> library(seqPattern)

3

Example data

The package contains two data sets provided for illustrating the functionality of the package.

3.1 Zebrafish promoter sequences

The first dataset is zebrafishPromoters and can be loaded by typing:

> data(zebrafishPromoters)

> zebrafishPromoters

DNAStringSet object of length 1000:

width seq

[1] 1000 ATCACTGGGTGACAAGCTGTTATAACACGCTG...ATGGGTAATGTAAAAAATAATATGAAAAATGC

[2] 1000 TGACAGAAATGTGGATGATGTGTGGATAATTG...TCCAGACAAGTAAGAGACCACCCCCTCAGAAA

[3] 1000 GTAAATCTAGTTTTGGCTGTTCTCAGGGGTGT...TGAACAATAGAGCATATGAACTGAAAGATTTT

[4] 1000 TTGTCACTATACACTGCCATTATATGAATCAC...TGTTACTTTTAGCCAGTGTCTGAGTAAGTTTA

[5] 1000 CACACTTTATATAATGAACAAATAAATATATT...CGTTAGCATTAATGCTAGCTTATTTTCGGGGC

...

... ...

[996] 1000 AACTGATTGTATTTTAATGACATTACAACATC...AAAGTTTAAAGCCTTGAGGCTCTAAGGCCTTT

[997] 1000 CGCAATGCTCAGTAAACTCTCTGAAACAGACA...TTAACTGTTTTAAACCTCAGAAGGAGTTTTCT

[998] 1000 TTGAAAATAATAGGGGTGAATGTATGACATTT...TCAGTCTGATAGATGACGTCAGTGCTCTTCTT

[999] 1000 GATGTTGTTTTTTGGCTCAAGAACTGAAGTAT...ACTGTATGCAATATTTAATGTGATGTATTTAC

[1000] 1000 TACACACTCTTGCACAAACTCGCATACACTAC...TGACCAGCCTGGTTTAAGCTGGGCTCCCAGCC

> head(zebrafishPromoters@elementMetadata)

DataFrame with 6 rows and 2 columns

tpm interquantileWidth

<numeric>

21.6422

166.7262

34.2380

33.9379

34.1767

76.3036

1

2

3

4

5

6

<numeric>

58

59

29

191

52

10

3

seqPattern

It is a DNAStringSet object that contains sequence of 1000 randomly selected promoters
active in zebrafish (Danio rerio) embryos at 24 hours past fertilisation (hpf). The data is
taken from Nepal et al.
[2], and represents regions flanking 400 bp upstream and 600 bp
downstream of the dominant TSS detected by Cap analysis of gene expression (CAGE). In
addition to genomic sequence, the object contains metadata providing CAGE tag per million
values and interquantile width for each promoter. This small example dataset is intended to
be used as input for running examples from seqPattern package help pages.

3.2 Zebrafish promoter coordinates and associated features
The second dataset is zebrafishPromoters24h, which can be loaded by typing:

> data(zebrafishPromoters24h)

> head(zebrafishPromoters24h)

chr start

end strand dominantTSS

tpm interquantileWidth

1 chr1 53498 53920

2 chr1 101877 102026

3 chr1 134648 134774

4 chr1 293528 293621

5 chr1 368940 369095

6 chr1 388651 388827

+

+

+

+

+

+

53734 58.10913

101934 43.38573

134725 80.04638

293616 54.59192

369041 55.50777

388696 10.14479

31

14

34

48

27

13

This is a data.frame object that contains genomic coordinates of all (10785 in total) pro-
moters active in zebrafish Danio rerio embryos at 24 hpf [2]. For each promoter additional
information is provided, including position of the dominant (most frequently used) TSS po-
sition, number of CAGE tags per million supporting that promoter and the interquantile
width of the promoter (width of the central region containing >= 80% of the CAGE tags).
All examples in this vignette use this dataset to demonstrate how to use various functions
provided in the package and illustrate the resulting visualisation.

4

Visualising oligonucleotide and consensus sequence
densities

In this part of the tutorial we will be using data from zebrafish (Danio rerio) that was mapped
to the danRer7 assembly of the genome. Therefore, the corresponding genome package
BSgenome.Drerio.UCSC.danRer7 has to be installed and available to load by typing:

> library(BSgenome.Drerio.UCSC.danRer7)

4

4.1 Preparing input sequences

As input we will use a full set of zebrafish promoters active in 24 hpf embryos that were
precisely mapped using CAGE [2]. To load the zebrafish promoters data type:

seqPattern

> data(zebrafishPromoters24h)

> nrow(zebrafishPromoters24h)

[1] 10785

> head(zebrafishPromoters24h)

chr start

end strand dominantTSS

tpm interquantileWidth

1 chr1 53498 53920

2 chr1 101877 102026

3 chr1 134648 134774

4 chr1 293528 293621

5 chr1 368940 369095

6 chr1 388651 388827

+

+

+

+

+

+

53734 58.10913

101934 43.38573

134725 80.04638

293616 54.59192

369041 55.50777

388696 10.14479

31

14

34

48

27

13

The loaded data.frame contains genomic coordinates, position of the dominant (most fre-
quently used) TSS position, number of CAGE tags per million and the interquantile width
(width of the central region containing >= 80% of the CAGE tags) for each promoter.

Next, we need to obtain the genomic sequence of the promoter region for which the oligonu-
cleotide density will be visualised, for instance the region flanking 400 bp upstream and 800
bp downstream of the dominant TSS. Thus, in this case the dominant TSS will be the
reference point to which all promoter sequences will be aligned. We also want to keep the
information about promoter interquantile width, since this feature will be used to order the
promoters in the density map.

> # create GRanges of dominant TSS position with associated metadata

> zebrafishPromotersTSS <- GRanges(seqnames = zebrafishPromoters24h$chr,

+

+

+

+

+

ranges = IRanges(start = zebrafishPromoters24h$dominantTSS,

end = zebrafishPromoters24h$dominantTSS),

strand = zebrafishPromoters24h$strand,

interquantileWidth = zebrafishPromoters24h$interquantileWidth,

seqlengths = seqlengths(Drerio))

> # get regions flanking TSS - 400 bp upstream and 800 bp downstream

> zebrafishPromotersTSSflank <- promoters(zebrafishPromotersTSS, upstream = 400,

+

downstream = 800)

> # obtain genomic sequence of flanking regions

> zebrafishPromotersTSSflankSeq <- getSeq(Drerio, zebrafishPromotersTSSflank)

5

Note that all regions need to have the same width for plotting, and in cases when flanking
regions fall outside of chromosome boundaries they need to be removed prior to plotting the
oligonucleotide density map. (For instance, use the trim function from the GenomicRanges
package to restrict regions within the boundaries of chromosomes and then remove ranges
shorter than expected width.)

seqPattern

4.2 Plotting dinucleotide density maps

Once a DNAStringSet object is obtained, it can be used to plot the density of oligonucleotides
of interest.
In the following example, we will plot the density of AA, TA, CG and GC
dinucleotides for the obtained set of sequences sorted by the promoter interquantile width
(Figure 1):

> plotPatternDensityMap(regionsSeq = zebrafishPromotersTSSflankSeq,

+

+

+

patterns = c("AA", "TA", "CG", "GC"),

seqOrder = order(zebrafishPromotersTSSflank$interquantileWidth),

flankUp = 400, flankDown = 800, color = "blue")

6

seqPattern

Figure 1: Density of AA, TA, CG and GC dinucleotides in regions flanking dominant TSS in zebrafish 24h
embryo promoters ordered by promoter width

The information about the number of base pairs upstream and downstream of the reference
point (flankUp and flankDown) needs to be specified in cases where these are asymmetric.
If not specified, it is assumed that the reference point is located in the middle of the provided
sequences (i.e. half of the total length in bp). There is also a number of graphical parameters
that can be adjusted, such as color palette, width and hight of the plot in pixels, axis labels,
scale bars, etc., and they are explained in detail in the help page of the plotPatternDen
sityMap function. Default colour palette is in shades of blue going from white through
lightblue to darkblue. Alternative colour palettes are available as shown in Figure 2, and can
be specified by setting the color parameter to the name of the corresponding palette.

7

seqPattern

Figure 2: Available colour palettes for plotting oligonucleotide density maps. Name of each palette is
indicated and can be used as color parameter within the plotPatternDensityMap function to specify the
corresponding colour palette for plotting.

The two main parameters that define how the density of the pattern will be calculated and
plotted are nBin and bandWidth. The nBin parameter specifies the number of bins in which
the plot will be divided across x (horizontal, corresponding to the sequence length) and y
axes (vertical, corresponding to the number of sequences). The default value is to calculate
the density at each position in every sequence, i.e.
the number of bins in the horizontal
direction is set to the sequence length and in the vertical direction to the total number
of sequences. The bandWidth parameter specifies the standard deviation of the bivariate
Gaussian kernel along the x (i.e. number of nucleotides) and y (i.e. number of sequences)
axis that is used to compute the density for each bin. The schematic in Figure 3 illustrates
how the density of three different dinucleotides is calculated for a set of 10 sequences each
10 bp long, using a 2D Gaussian kernel with standard deviation of 5 in both directions. The
calculations for larger sets of sequences and for any specified sequence pattern are done
analogously. Note that seqPattern package supports parallel processing using multiple cores
on Unix-like platforms, which significantly reduces the computational time when visualising
density of multiple patterns. For instance, the above example that calculates the density of
4 dinucleotides can be run on 4 cores by setting the useMulticore and nrCores parameters:

> plotPatternDensityMap(regionsSeq = zebrafishPromotersTSSflankSeq,

+

+

+

patterns = c("AA", "TA", "CG", "GC"),

seqOrder = order(zebrafishPromotersTSSflank$interquantileWidth),

flankUp = 400, flankDown = 800, useMulticore = TRUE, nrCores = 4)

Calling the plotPatternDensityMap function will create one .png file per specified pattern
in the working directory. The resulting dinucleotide density plots reveal complex pattern of
dinucleotide enrichments/depletions in zebrafish promoters (Figure 1). The density of all

8

greencyanbluepurplepinkredorangebrowngrayseqPattern

dinucleotides is plotted on the same colour scale, which allows direct comparison. For in-
stance, it is clear that CG dinucleotides are generally less abundant than other dinucleotides.
The region immediately upstream and downstream of TSS is enriched for CG and GC dinu-
cleotides and depleted for TA and AA dinucleotides. Within this region, there is narrow band
of TA and AA enrichment ∼30 bp upstream of the TSS visible only in sharp promoters (top).
Region downstream of TSS is characterised by alternating bands of enrichments and deple-
tions visible for all four dinucleotides and this pattern is more prominent in broad promoters
(bottom).Thus, visualising sequence in such way reveals differences in underlying sequence
composition and its relation to the reference point, as well as how this changes with some
associated feature.

9

seqPattern

Figure 3: Schematics illustrating steps in pattern density calculation and visualisation. Genomic se-
quences (of the same length) are sorted and aligned into a matrix-like representation. Marking the pres-
ence of selected dinucleotide by 1 and the absence by 0 creates an occurrence matrix. Next, a weighted
average is calculated at each position by placing a 2D Gaussian kernel at that position and assigning
weights to surrounding positions. An example of calculating the value at position S4,P7 is shown. Sur-
rounding positions are coloured on the basis of the weights assigned to them by the Gaussian kernel
(bandwidth=5 in both dimensions, and covariance=0 between the two dimensions). Averaged values are
mapped to different shades of blue to visualise the dinucleotide density.

10

CAATACAAAAATACCTAAGACAAAGCAGACGTAAATAAAAGAAAATAACAATAACCAGCGATAAAAAATAAAAACATTCCGACAAATTACCGCGGATCAAP1P2P3P4P5P6P7P8P9P10S1S2S3S4S5S6S7S8S9S100000000000000100000010000100000000000000000000000000000100100000000000000000000000000000001010000100P1P2P3P4P5P6P7P8P9P10S1S2S3S4S5S6S7S8S9S100001000000010001000000000000000100010000000001000001000000000100000010000000110000000011000000001000P1P2P3P4P5P6P7P8P9P10S1S2S3S4S5S6S7S8S9S100110100010000000000001110000000001100110011010010000000000001000111100001000000000010000000000000010P1P2P3P4P5P6P7P8P9P10S1S2S3S4S5S6S7S8S9S100.290.370.450.220.460.260.290.230.210.110.110.190.230.080.200.060.110.050.100.060.020.260.260.110.120.050.110.100.120.030.280.210.330.460.410.340.230.460.330.140.120.300.380.260.290.140.150.240.180.070.030.190.200.170.110.040.090.100.160.070.390.340.440.390.540.440.370.460.290.130.130.170.290.340.270.150.100.290.240.090.100.230.320.280.250.120.110.240.170.050.080.210.250.200.190.080.100.150.200.10P1P2P3P4P5P6P7P8P9P10S1S2S3S4S5S6S7S8S9S100.000.230.130.230.030.170.210.190.190.080.000.200.110.130.020.200.210.160.080.030.000.110.060.000.010.030.080.010.000.000.350.170.180.040.340.390.260.130.060.000.180.040.100.010.370.340.250.020.000.000.220.110.010.020.100.210.030.000.000.000.310.170.220.040.200.270.180.220.110.000.290.110.190.020.450.440.370.060.020.000.210.050.180.010.440.400.370.040.000.000.220.080.030.020.230.300.110.000.00P1P2P3P4P5P6P7P8P9P10S1S2S3S4S5S6S7S8S9S100.000.200.410.540.170.460.250.270.290.040.000.100.280.390.070.290.100.130.120.020.000.060.140.130.100.110.050.080.070.060.010.190.210.340.170.370.230.170.290.040.000.050.460.460.130.230.240.290.240.040.000.100.330.290.190.210.170.240.180.100.020.230.330.440.220.450.320.290.380.050.000.110.230.370.090.290.110.100.150.020.000.060.340.440.070.260.120.150.140.020.000.080.460.390.180.220.280.340.260.070.01P1P2P3P4P5P6P7P8P9P10S1S2S3S4S5S6S7S8S9S10Set of genomic sequences(aligned and sorted)Dinucleotide occurence matrix(one per dinucleotide)Weighted average dinucleotideoccurence matrix00.020.140.441DinucleotidedensitymapAATACGcountcalculate using2D Gaussian kernelmap valuesto colours0.1592 * 1 + 0.0965 * (1+1+0+0) + 0.0585 * (1+0+0+0) + 0.0215 * (0+1+0+0) + 0.0130 * (0+0+0+0+1+0+0+1) + ... = 0.4636In addition to plotting density map of individual dinucleotides, a "metadinucleotide" can
be specified using IUPAC nucleotide ambiguity codes. For instance, for the same set of
promoter regions we can plot the density of all WW and all SS dinucleotides in the same
plot (Figure 4):

seqPattern

> plotPatternDensityMap(regionsSeq = zebrafishPromotersTSSflankSeq,

+

+

+

patterns = c("WW", "SS"),

seqOrder = order(zebrafishPromotersTSSflank$interquantileWidth),

flankUp = 400, flankDown = 800, color = "cyan", labelCol = "white")

Figure 4: Density of WW and SS dinucleotides in regions flanking dominant TSS in zebrafish 24h embryo
promoters ordered by promoter width

4.3 Plotting average oligonucleotide profiles

In addition to plotting oligonucleotide density maps, which show how a particular sequence
pattern around referent point changes with some associated feature, the package also provides
function for plotting average oligonucleotide profiles. For instance, we can visualise the
average profile of WW and SS metadinucleotides for two groups of promoters separated by
width (i.e. sharp and broad promoters; 5) as follows:

> # make index of sharp and broad promoters

> sIdx <- zebrafishPromotersTSSflank$interquantileWidth <= 9

> bIdx <- zebrafishPromotersTSSflank$interquantileWidth > 9

> # plot average dinucleotide profile for sharp promoters

> par(mfrow = c(1,2), mar = c(4.5,4,1,1))

> plotPatternOccurrenceAverage(regionsSeq = zebrafishPromotersTSSflankSeq[sIdx],

+

+

patterns = c("WW", "SS"), flankUp = 400, flankDown = 800,

smoothingWindow = 3, color = c("red3", "blue3"), cex.axis = 0.9)

11

> # plot average dinucleotide profile for broad promoters

> plotPatternOccurrenceAverage(regionsSeq = zebrafishPromotersTSSflankSeq[bIdx],

seqPattern

+

+

patterns = c("WW", "SS"), flankUp = 400, flankDown = 800,

smoothingWindow = 3, color = c("red3", "blue3"), cex.axis = 0.9)

Figure 5: Average profile of WW and SS dinucleotides in region flanking dominant TSS for sharp promot-
ers (width < 10 bp; left) and broad promoters (width >= 10 bp)

4.4 Plotting consensus sequence density map

Analogously to plotting dinucleotide density as described above, the plotPatternDensityMap
function can be used to visualise the density of longer consensus sequences specified using
IUPAC nucleotide ambiguity codes. For instance, one can use a consensus sequence of a tran-
scription factor binding site to visualise density of these sites with respect to some reference
point. Here we show an example of plotting density of the TATA-box consensus sequence
(TATAWAWR) and GC-box / Sp1 binding site consensus sequence (RGGMGGR) across ze-
brafish promoters for sense and antisense strand separately. (Note that the easiest way to
visualise occurrence of a consensus sequence in the antisense strand is to use the reverse
complement of the consensus sequence, which in our case corresponds to YWTWTATA and
YCCKCCY, for TATA-box and GC-box respectively.)

> # get regions flanking dominant TSS - 200bp upstream and downstream

> zebrafishPromotersTSSflank <- promoters(zebrafishPromotersTSS, upstream = 200,

+

downstream = 200)

> # obtain genomic sequence of the flanking regions

> zebrafishPromotersTSSflankSeq <- getSeq(Drerio, zebrafishPromotersTSSflank)

12

−400−20002004006008000.00.10.20.30.40.50.6Distance to reference point (bp)Relative frequencyWWSS−400−20002004006008000.00.10.20.30.40.5Distance to reference point (bp)Relative frequencyWWSS> # plot density of TATA-box consensus sequence in pink

> plotPatternDensityMap(regionsSeq = zebrafishPromotersTSSflankSeq,

seqPattern

+

patterns = c("TATAWAWR", "YWTWTATA"),

+

+

+

>

seqOrder = order(zebrafishPromotersTSSflank$interquantileWidth),

flankUp = 200, flankDown = 200, nBin = c(400, 10000),

bandWidth = c(1,6), color = "pink", addPatternLabel = FALSE)

# plot density of GC-box consensus sequence in purple

> plotPatternDensityMap(regionsSeq = zebrafishPromotersTSSflankSeq,

+

+

+

+

patterns = c("RGGMGGR", "YCCKCCY"),

seqOrder = order(zebrafishPromotersTSSflank$interquantileWidth),

flankUp = 200, flankDown = 200, nBin = c(400, 10000),

bandWidth = c(1,6), color = "purple", addPatternLabel = FALSE)

Figure 6: Density of the TATA-box consensus sequence (TATAWAWR; top) and GC-box (Sp1 binding
site) consensus sequence (RGGMGGR; bottom) in regions flanking dominant TSS in zebrafish 24h embryo
promoters ordered by promoter width. Matches in the sense strand are shown on the left and in the anti-
sense strand on the right.

13

seqPattern

In the resulting density plot (Figure 6) promoters are aligned to dominant TSS and sorted
by promoter width. This reveals that the TATA-box consensus sequence is positioned very
precisely at ∼30 bp upstream of the TSS mainly in the sense strand and that it is present only
in very sharp promoters (top of the density plot), but not in the broad promoters (bottom of
the density plot). In contrast, the GC-box (Sp1 binding site) consensus sequence is present in
both strands and in both sharp and broad promoters roughly in the region 40-80 bp upstream
of the TSS, but it seems more focused in sharp promoters.

5

Visualising motif occurrences

5.1 Plotting density of motif occurrences

In addition to using consensus sequence, the binding motif of a certain transcription factor can
be described by a position-weight matrix (PWM), which gives the probability of occurrence
of each of the four nucleotides at a given position in the motif. More specifically, the values
in the PWM are derived from the position-specific frequency matrix and represent log-ratio
between nucleotide probabilities derived from observed frequency and expected background
probability for the corresponding nucleotide [3]. An example of a PWM describing the binding
motif for the TATA-box binding transcription factor (TBP) is provided in the package and
can be loaded:

> data(TBPpwm)

> TBPpwm

[,1]

[,2]

[,3]

[,4]

[,5]

[,6]

[,7]

A -2.588668 1.853661 -4.928518

1.861830

1.4605751

1.886064

1.1891247

C -1.076769 -8.928518 -3.256093 -8.928518 -8.9285184 -4.928518 -5.4690868

G -2.420724 -5.469087 -5.469087 -4.228079 -8.9285184 -2.270307 -1.1406158

T

1.665806 -1.469087 1.941075 -1.690114

0.3146556 -3.974322

0.3146556

[,8]

A

0.6713945

C -1.1406158

G

0.6898671

T -1.5534789

The plotMotifDensityMap function takes a PWM as an input, scans all sequences for the
occurrence of the motif above the specified match threshold (e.g. 90%) and visualises the
density of the motif with respect to the reference point (Figure 7, left):

> plotMotifDensityMap(regionsSeq = zebrafishPromotersTSSflankSeq,

+

+

motifPWM = TBPpwm, minScore = "90%",

seqOrder = order(zebrafishPromotersTSSflank$interquantileWidth),

14

+

flankUp = 200, flankDown = 200, color = "red")

seqPattern
5.2 Plotting motif scanning scores

On the other hand, using the plotMotifScanScores function it is possible to visualise the
PWM scanning scores along entire sequences in a form of a heatmap (Figure 7, right):

> plotMotifScanScores(regionsSeq = zebrafishPromotersTSSflankSeq,

+

+

+

motifPWM = TBPpwm,

seqOrder = order(zebrafishPromotersTSSflank$interquantileWidth),

flankUp = 200, flankDown = 200)

Figure 7: Density of TATA-box motif occurrence above 90% of PWM score (left) and heatmap of PWM
scanning scores along all sequences (right) in regions flanking dominant TSS in zebrafish 24h embryo pro-
moters ordered by promoter width

In addition to showing positioning and enrichment of strong motif occurrences with high
match to the provided PWM, this form of visualisation can also reveal positional constraints
for occurrences of motifs with varying strength. For instance weaker motifs might have
different positional preference with respect to the reference point and might occur only in a
subset of sequences correlating with some feature, which will be visible when the sequences
are sorted according to that feature.

15

5.3 Plotting average motif occurrence profile

seqPattern

Analogously to plotting average oligonucleotide profiles described above, average occurrence
profile of a motif specified by a PWM can be visualised using plotMotifOccurrenceAverage
function. The following code exemplifies how to visualise average occurrence of a TATA-
box motif (above 90% match to PWM) in previously defined subsets of sharp and broad
promoters (Figure 8):

> # make index of sharp and broad promoters

> sIdx <- zebrafishPromotersTSSflank$interquantileWidth <= 9

> bIdx <- zebrafishPromotersTSSflank$interquantileWidth > 9

> # plot average motif occurrence profile for sharp promoters

> plotMotifOccurrenceAverage(regionsSeq = zebrafishPromotersTSSflankSeq[sIdx],

+

+

motifPWM = TBPpwm, minScore = "90%", flankUp = 200, flankDown = 200,

smoothingWindow = 3, color = c("red3"), cex.axis = 0.9)

> # add average motif occurrence profile for broad promoters to the existing plot

> plotMotifOccurrenceAverage(regionsSeq = zebrafishPromotersTSSflankSeq[bIdx],

+

+

motifPWM = TBPpwm, minScore = "90%", flankUp = 200, flankDown = 200,

smoothingWindow = 3, color = c("blue3"), add = TRUE)

> legend("topright", legend = c("sharp", "broad"), col = c("red3", "blue3"),

+ bty = "n", lwd = 1)

Figure 8: Average profile of TATA-box motif occurrence above 90% of PWM score in regions flanking
dominant TSS in sharp (red) and broad (blue) promoters

16

−200−10001002000.000.020.040.060.080.10Distance to reference point (bp)Relative frequencysharpbroad6 Getting occurrence of sequence patterns and mo-

tifs without visualisation

seqPattern

The above described functions find the occurrence of specified sequence patterns or motifs in
an ordered set of sequences, calculate their density and visualise the result as a density map.
The seqPattern package also provides functions for finding only the occurrence of patterns
or motifs without calculating the density and visualising it in a plot. These are getPatternOc
currenceList and motifScanHits for finding occurrence of patterns/consensus sequences
and motifs specified by a PWM, respectively.

> motifOccurrence <- motifScanHits(regionsSeq =

+

+

+

zebrafishPromotersTSSflankSeq[1:50],

motifPWM = TBPpwm, minScore = "90%", seqOrder =

order(zebrafishPromotersTSSflank$interquantileWidth[1:50]))

> head(motifOccurrence)

sequence position value

1

2

3

4

5

6

1

1

1

2

2

3

69

170

306

83

170

104

1

1

1

1

1

1

The occurrences are returned as coordinates in a matrix-like representation as follows: Input
sequences of the same length are sorted according to the index in seqOrder argument creating
an n x m matrix where n is the number of sequences and m is the length of the sequence.
For each pattern match the coordinates within such matrix are reported, i.e.
the ordinal
number of the sequence within the ordered set of sequences (sequence column) and the
start position of the pattern within that sequence (position column) are returned in the
resulting data.frame.

Similarly, the matrix of PWM scanning scores along all sequences can be obtained using
motifScanScores function:

> scanScores <- motifScanScores(regionsSeq = zebrafishPromotersTSSflankSeq[1:50],

+

+

motifPWM = TBPpwm, seqOrder =

order(zebrafishPromotersTSSflank$interquantileWidth[1:50]))

> dim(scanScores)

[1]

50 393

> scanScores[1:6,1:6]

17

[,1]

[,2]

[,3]

[,4]

[,5]

[,6]

[1,] 63.43760 31.36077 57.53743 28.46517 35.59483 27.94817

seqPattern

[2,] 47.31515 57.84285 62.43671 67.52613 83.10196 54.81150

[3,] 71.92744 69.65404 82.63422 75.39365 71.82337 82.76337

[4,] 46.13987 62.04548 36.02750 46.60518 63.79247 49.47394

[5,] 90.57873 67.58995 90.99609 59.95292 79.81380 40.64799

[6,] 77.32850 66.54411 55.26975 39.65247 61.11497 44.48001

By default, the values corresponding to the percentage of the maximal possible PWM score
are returned.

7

Session Info

> sessionInfo()

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default

BLAS:
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LAPACK version 3.12.0

locale:
[1] LC_CTYPE=C
[3] LC_TIME=C
[5] LC_MONETARY=C
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:

[1] stats4

stats

graphics

grDevices utils

datasets

methods

[8] base

other attached packages:
[1] BSgenome.Drerio.UCSC.danRer7_1.4.0 BSgenome_1.78.0

18

seqPattern

[3] rtracklayer_1.70.0
[5] Biostrings_2.78.0
[7] GenomicRanges_1.62.0
[9] IRanges_2.44.0
[11] BiocGenerics_0.56.0
[13] seqPattern_1.42.0

BiocIO_1.20.0
XVector_0.50.0
Seqinfo_1.0.0
S4Vectors_0.48.0
generics_0.1.4

loaded via a namespace (and not attached):
[1] Matrix_1.7-4
BiocStyle_2.38.0
[3] compiler_4.5.1
BiocManager_1.30.26
crayon_1.5.3
[5] rjson_0.2.23
[7] SummarizedExperiment_1.40.0 plotrix_3.8-4
[9] Biobase_2.70.0
[11] Rsamtools_2.26.0
[13] parallel_4.5.1
[15] yaml_2.3.10
[17] lattice_0.22-7
[19] S4Arrays_1.10.0
[21] knitr_1.50
[23] DelayedArray_0.36.0
[25] rlang_1.1.6
[27] SparseArray_1.10.0
[29] grid_4.5.1
[31] KernSmooth_2.23-26
[33] cigarillo_1.0.0
[35] abind_1.4-8
[37] restfulr_0.0.16
[39] httr_1.4.7
[41] tools_4.5.1

GenomicAlignments_1.46.0
bitops_1.0-9
BiocParallel_1.44.0
fastmap_1.2.0
R6_2.6.1
curl_7.0.0
XML_3.99-0.19
MatrixGenerics_1.22.0
xfun_0.53
cli_3.6.5
digest_0.6.37
evaluate_1.0.5
codetools_0.2-20
RCurl_1.98-1.17
rmarkdown_2.30
matrixStats_1.5.0
htmltools_0.5.8.1

References

[1] Vanja Haberle, Nan Li, Yavor Hadzhiev, Charles Plessy, Christopher Previti, Chirag

Nepal, Jochen Gehrig, Xianjun Dong, Altuna Akalin, Ana Maria Suzuki, Wilfred F J van
IJcken, Olivier Armant, Marco Ferg, Uwe Strähle, Piero Carninci, Ferenc Müller, and
Boris Lenhard. Two independent transcription initiation codes overlap on vertebrate
core promoters. Nature, 507(7492):381–385, 2014.

19

[2] Chirag Nepal, Yavor Hadzhiev, Christopher Previti, Vanja Haberle, Nan Li, Hazuki

seqPattern

Takahashi, Ana Maria S. Suzuki, Ying Sheng, Rehab F. Abdelhamid, Santosh Anand,
Jochen Gehrig, Altuna Akalin, Christel E.M. Kockx, Antoine A.J. van der Sloot,
Wilfred F.J. van IJcken, Olivier Armant, Sepand Rastegar, Craig Watson, Uwe Strähle,
Elia Stupka, Piero Carninci, Boris Lenhard, and Ferenc Müller. Dynamic regulation of
coding and non-coding transcription initiation landscape at single nucleotide resolution
during vertebrate embryogenesis. Genome Research, 23(11):1938–1950, 2013.

[3] Wyeth W Wasserman and Albin Sandelin. Applied bioinformatics for the identification

of regulatory elements. Nature Reviews Genetics, 5(4):276–287, 2004.

20

