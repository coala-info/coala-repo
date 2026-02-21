Overview: Visualization of Microarray Data

Robert Gentleman

October 30, 2025

1 Overview

In this document we present a brief overview of the visualization methods
that are available in Bioconductor project. To make use of these tools you
will need the packages: Biobase, annotate, and geneplotter . These must be
installed in your version of R and when you start R you must load them with
the library command.

A quick word of warning regarding the interpretation of these plots. We
can only plot where the gene is supposed to be. If there are translocations
or amplifications these will not be detected by microarray analyses.

> library(geneplotter)

2 Whole Genome Plots

The functions cPlot and cColor allow the user to associate microarray ex-
pression data with chromosomal location. The plots can include any subset
(by default all chromosomes are shown) of chromosomes for the organism
being considered.

To make these plots we use the complete reference set of genes for the
organism being studied. We must then obtain the chromosomal location
(in bases) and orientation (which strand) the gene is on. Chromosomes are
represented by straight lines parallel to the x–axis. Genes are represented by
short perpendicular lines. All genes for the experiment (i.e. for an Affymetrix
U95A analysis we show all genes on the chips).

The user can then change the color of different sets of the genes according

to their needs.

1

The original setup is done using cPlot. The subsequent coloring is done

using cColor.

We will use the example data in sample.ExpressionSet to show how

this function might be used.

ys <- split( y, cov2 )
t.test( ys[[1]], ys[[2]] )
}

> data(sample.ExpressionSet)
> eset = sample.ExpressionSet # legacy naming
> mytt <- function(y, cov2) {
+
+
+
> ttout <- esApply(eset, 1, mytt, eset$type)
> s1means <- sapply(ttout, function(x) x$estimate[1])
> s2means <- sapply(ttout, function(x) x$estimate[2])
> deciles <- quantile(c(s1means, s2means), probs=seq(0,1,.1))
> s1class <- cut(s1means, deciles)
> names(s1class) <- names(s1means)
> s2class <- cut(s2means, deciles)
> names(s2class) <- names(s2means)

Next we need to set up the graphics output. We do this in a rather
In the plot below we can compare the mean expression
complicated way.
levels for genes in Group 1 with those in Group 2. The Group 1 values are
in the left–hand plot and the Group 2 values are in the right–hand plot.

cols <- dChip.colors(10)
nf <- layout(matrix(1:3,nr=1), widths=c(5,5,2))
chrObj <- buildChromLocation("hgu95av2")
cPlot(chrObj)
cColor(featureNames(eset), cols[s1class], chrObj)
cPlot(chrObj)
cColor(featureNames(eset), cols[s2class], chrObj)
image(1,1:10,matrix(1:10,nc=10),col=cols, axes=FALSE,

xlab="", ylab="")

axis(2, at=(1:10), labels=levels(s1class), las=1)

2

3 Single Chromosome Plots

A different view of the variation in expression level can be obtained by plot-
ting characteristics of expression levels over contiguous regions of a chro-
mosome. For these plots cummulative expression or per–gene expressions
can be plotted. There are some issues of interpretation here (as in most
places) – expression is not likely to be controlled too much by chromosomal
locality. However these plots may be helpful in detecting deletions (of both
chromatids) or amplifications, or other interesting features of the genome.

In this section we will show how one can explore a particular chromosome
for an amplicon. The data arise from a study of breast cancer in the Iglehart
Laboratory.

<environment: 0x5d7951f6ad58>

3

Homo sapiensChromosome1166_GL000250v2_alt5_KI270897v1_alt1_MU273331v1_alt17_MU273380v1_fix1_KQ031383v1_fix22_ML143380v1_fix17_GL383563v3_alt21_MU273390v1_fix3_KN196476v1_fix8_KI270811v1_alt6_KI270798v1_alt19_KI270882v1_alt18_KZ559115v1_fix1_KQ458384v1_alt4_KI270789v1_alt18_GL383571v1_alt11_JH159137v1_alt17_GL000205v2_random3_GL383526v1_alt1_KI270712v1_random14_KZ208919v1_alt13_KI270841v1_alt8_KZ208914v1_fix3_KI270782v1_alt18_KI270911v1_alt12_GL383553v2_alt8_KI270814v1_alt2_KI270770v1_alt2_GL383522v1_alt17_KI270730v1_random12_MU273372v1_fixUn_KI270748v121_KI270872v1_altX_ML143383v1_fix19_KI270865v1_alt12_KI270837v1_altX_ML143382v1_fix13_ML143363v1_fixUn_KI270593v1Un_KI270518v1Un_KI270384v1Un_KI270393v1Un_KI270336v1Homo sapiensChromosome1166_GL000250v2_alt5_KI270897v1_alt1_MU273331v1_alt17_MU273380v1_fix1_KQ031383v1_fix22_ML143380v1_fix17_GL383563v3_alt21_MU273390v1_fix3_KN196476v1_fix8_KI270811v1_alt6_KI270798v1_alt19_KI270882v1_alt18_KZ559115v1_fix1_KQ458384v1_alt4_KI270789v1_alt18_GL383571v1_alt11_JH159137v1_alt17_GL000205v2_random3_GL383526v1_alt1_KI270712v1_random14_KZ208919v1_alt13_KI270841v1_alt8_KZ208914v1_fix3_KI270782v1_alt18_KI270911v1_alt12_GL383553v2_alt8_KI270814v1_alt2_KI270770v1_alt2_GL383522v1_alt17_KI270730v1_random12_MU273372v1_fixUn_KI270748v121_KI270872v1_altX_ML143383v1_fix19_KI270865v1_alt12_KI270837v1_altX_ML143382v1_fix13_ML143363v1_fixUn_KI270593v1Un_KI270518v1Un_KI270384v1Un_KI270393v1Un_KI270336v1(−488,10.1](10.1,19.5](19.5,30.9](30.9,49.8](49.8,71.5](71.5,109](109,167](167,264](264,615](615,9.33e+03]4

0200040006000800012000Cumulative expression levels by genes in chromosome 1  scaling method: none Representative GenesCumulative expression levels31617_at31617_at31598_s_at31598_s_at31583_at31457_at31625_at31625_at31625_at31569_at31714_at31624_at31533_s_at31508_at31662_at31579_at31326_at31603_at31499_s_at31495_at31642_at31502_at31470_at31737_at31342_at++−−++−−−−+−−−+++−−−+++−+