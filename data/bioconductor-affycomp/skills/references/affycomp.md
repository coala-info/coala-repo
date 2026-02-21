Bioconductor Expression Assessment Tool for
Affymetrix Oligonucleotide Arrays (affycomp)

Rafael Irizarry and Leslie Cope

October 29, 2025

Contents

1 Introduction

1.1 Benchmark dataset . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
1.2 phenodata . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2 What’s new in version 1.2?

3 The Image Report

3.1 Basic plots . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2 Comparative plots
3.3 Tables . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.4 Standard deviation assessment . . . . . . . . . . . . . . . . . . . . . . . .

4 The end

1

Introduction

1
2
2

2

3
4
10
16
18

20

The defining feature of oligonucleotide expression arrays is the use of several probes to
assay each targeted transcript. This is a bonanza for the statistical geneticist, offering
a great opportunity to create probeset summaries with specific characteristics. There
are now several methods available for summarizing probe level data from the popular
Affymetrix GeneChips. It is harder to identify the method best suited to a given inquiry.
This package provides a graphical tool for summaries of Affymetrix probe level data. It
is the engine behind our webtool http://affycomp.jhsph.edu/. Plots and summary
statistics offer a picture of how an expression measure performs in several important
areas. This picture facilitates the comparison of competing expression measures and the
selection of methods suitable for a specific investigation.

1

The key is a benchmark dataset consisting of a dilution study and a spike-in study.
Because the truth is known for this data, it is possible to identify statistical features of the
data for which the expected outcome is known in advance. Those features highlighted
in our suite of graphs are justified by questions of biological interest, and motivated by
the presence of appropriate data.

1.1 Benchmark dataset

The spike-in benchmark data was originally free and easily available to the public, from
Affymetrix. Copies in compressed-tar format may now be obtained here: http://www.
biostat.jhsph.edu/~ririzarr/affycomp/spikein.tgz and http://www.biostat.jhsph.
edu/~ririzarr/affycomp/hgu133spikein.tgz. The dilution benchmark data was orig-
inally also free, although not as easily available, from Gene Logic.

For a full description of the benchmark data, see our RMA papers "Exploration, nor-
malization, and summaries of high density oligonucleotide array probe level data", Bio-
statistics, 2003 Apr;4(2):249-64 (http://www.ncbi.nlm.nih.gov/pubmed/12925520) and
"Summaries of Affymetrix GeneChip probe level data", Nucleic Acids Res, 2003 Febru-
ary 15; 31(4): e15 (http://www.ncbi.nlm.nih.gov/pmc/articles/PMC150247/).

In the Gene Logic dilution study, (http://www.genelogic.com/support/scientific-studies/),

two sources of cRNA, human liver tissue and central nervous system cell line (CNS),
were hybridized to human arrays (HG-U95Av2) in a range of dilutions and proportions.
You must contact Gene Logic (info@genelogic.com or +1-800-GENELOGIC) to obtain
the dilution data.

In the Affymetrix spike-in study, different cRNA fragments were added to the hy-
bridization mixture of the arrays at different picoMolar concentrations. The cRNAs were
spiked-in at a different concentration on each array (apart from replicates) arranged in
a cyclic Latin square design with each concentration appearing once in each row and
column. All arrays had a common background cRNA.

1.2 phenodata

The package includes phenoData objects that give more details, dilution.phenodata
and spikein.phenodata (also, hgu133a.spikein.phenodata).

2 What’s new in version 1.2?

A new set of assessments is provided by the function assessSpikeIn2, which is a wrap-
per for assessMA2, assessSpikeInSD, and assessLS. It will accept a full ExpressionSet
of the spikein data (59 columns), as with assessSpikeIn, but in this case only uses
columns 1:13, 17, 21:33, and 37. Otherwise, it assumes that it has expression measures
only for those particular 28 arrays.

2

All spike-in related assessments now support the HGU133A chip, in addition to the
HGU95A chip handled by version 1.1. The function read.newspikein, which is simply
a call to read.spikein with cdfName = "hgu133a", will read HGU133A expression
measures.

3 The Image Report

Given a file named dilfilename.csv containing your dilution expression measures and a
file named sifilename.csv containing your spikein expression measures, you can easily
obtain the graphs and summary statistics in an image report (illustrated using RMA):

R> library(affycomp) ##load the package
R> d <- read.dilution("dilfilename.csv")
R> s <- read.spikein("sifilename.csv")
R> rma.assessment <- affycomp(d, s, method.name="RMA")

affycomp is a wrapper for assessAll and affycompTable. The return value will
contain all the information, from assessAll, necessary to recreate the graphs (below)
without having to re-do the assessment. For example, the following two objects were
created by assessAll on ExpressionSets created by MAS 5.0 and RMA, respectively;
they are lists of lists.

> data(mas5.assessment)
> data(rma.assessment)

> names(mas5.assessment)

[1] "Dilution"
[6] "what"

"MA"
"method.name"

"Signal"

"FC"

"FC2"

Each component is the result of a specific assessment. The names tell us what they
are for. Dilution are the assessment based on the dilution data and can be used to
create Figures 2, 3, and 4b. MA has the necessary information for the MA plot or Figure
1. Signal has the necessary information to create Figure 4a. FC has assessments related
to fold change and can be used to create Figures 5a, 6a, and 6b. Finally, FC2 has the
necessary information to create Figure 5b. The captions for these Figures will give you
an idea of what they are for.

There are two kinds of plots, basic and comparative. The basic plots depict a given
expression measure. In the comparative plots, the given expression measure is compared
to other measures, MAS 5.0 by default. Tables are also automatically created with
assessment statistics. Finally, a simple assessment of standard error estimates can be
done. These are all described in the following subsections.

3

3.1 Basic plots

You can use affycompPlot which will automatically know what to do, or you can use
the auxiliary figure functions that will need to have a specific assessment list.

4

> affycompPlot(mas5.assessment$MA)

Figure 1: The MA plot shows log fold change as a function of mean log expression level.
A set of 14 arrays representing a single experiment from the Affymetrix spike-in data are
used for this plot. A total of 13 sets of fold changes are generated by comparing the first
array in the set to each of the others. Genes are symbolized by numbers representing the
nominal log2 fold change for the gene. Non-differentially expressed genes with observed
fold changes larger than 2 are plotted in red. All other probesets are represented with
black dots.

5

0510−10−50510Figure 1AM11111111111112222222222−12223333333333−11−113444444444−10−10−10455555555−9−9−9−956666666−8−8−8−8−8777777−7−7−7−7−7−7−788888−6−6−6−6−6−6−6−69999−5−5−5−5−5−5−5−5−5101010−4−4−4−4−4−4−4−4−4−41111−3−3−3−3−3−3−3−3−3−3−312−2−2−2−2−2−2−2−2−2−2−2−2−1−1−1−1−1−1−1−1−1−1−1−1−1¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥-¥-¥-¥-¥-¥-¥-¥-¥-¥-¥-¥-¥-¥-¥> affycomp.figure2(mas5.assessment$Dilution)

Figure 2: For each gene, and each experimental condition, we calculate the mean log
expression and the observed standard deviation across 5 replicates. The resulting scat-
terplot is smoothed to generate a single curve representing mean standard deviation as
a function of mean log expression.

6

05100.20.40.60.81.0Figure 2log expressionstandard error across replicates> affycomp.figure3(mas5.assessment$Dilution)

Figure 3: This plot, using the Gene Logic dilution data, shows the sensitivity of fold
change calculations to total RNA abundance. Average log fold-changes between liver and
CNS for the lowest concentration and the highest in the dilution data set are computed.
Orange and red color is used to denote genes with M6g − M1g bigger than log2(2) and
log2(3) respectively. The rest are denoted with black.

7

−10−505−10−505Figure 3Log fold change estimate for 1.25 ugLog fold change estimate for 20 ug> par(mfrow=c(2,1))
> affycomp.figure4a(mas5.assessment$Signal)
> affycomp.figure4b(mas5.assessment$Dilution)

Figure 4: a) Average observed log2 intensity plotted against nominal log2 concentration
for each spiked-in gene for all arrays in Affymetrix spike-In experiment. b) For the
Gene Logic dilution data, log expression values are regressed against their log nominal
concentration. The slope estimates are plotted against average log intensity across all
concentrations.

8

−2024681004812Figure 4aNominal concentration (in picoMolar)Observed expression05100.01.0Figure 4blog expressionslopes of log expression vs log concentration regresssion> par(mfrow=c(2,1))
> affycomp.figure5a(mas5.assessment$FC)
> affycomp.figure5b(mas5.assessment$FC)

Figure 5: A typical identification rule for differential expression filters genes with fold
change exceeding a given threshold. This figure shows average ROC curves which offer
a graphical representation of both specificity and sensitivity for such a detection rule.
a) Average ROC curves based on comparisons with nominal fold changes ranging from
2 to 4096. b) As a) but with nominal fold changes equal to 2.

9

0204060801001357Figure 5aFalse PositivesTrue Positives0204060801001357Figure 5bFalse PositivesTrue Positives> par(mfrow=c(2,1))
> affycomp.figure6a(mas5.assessment$FC)
> affycomp.figure6b(mas5.assessment$FC)

Figure 6: a) Observed log fold changes plotted against nominal log fold changes. The
dashed lines represent highest, 25th highest, 100th highest, 25th percentile, 75th per-
centile, smallest 100th, smallest 25th, and smallest log fold change for the genes that were
not differentially expressed. b) Like a) but the observed fold changes were calculated for
spiked in genes with nominal concentrations no higher than 2pM.

3.2 Comparative plots

You can use affycompPlot which will automatically know what to do, or you can use
the auxiliary figure functions that will need to have a specific assessment list.

10

111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111−10−50510−10010Figure 6aNominal log ratioobserved log ratio22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222223333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff−3−2−10123−2246Figure 6bNominal log ratioobserved log ratio> par(mfrow=c(2,1))
> affycompPlot(mas5.assessment$MA, rma.assessment$MA)

Figure 1: The MA plot shows log fold change as a function of mean log expression level.
A set of 14 arrays representing a single experiment from the Affymetrix spike-in data are
used for this plot. A total of 13 sets of fold changes are generated by comparing the first
array in the set to each of the others. Genes are symbolized by numbers representing the
nominal log2 fold change for the gene. Non-differentially expressed genes with observed
fold changes larger than 2 are plotted in red. All other probesets are represented with
black dots.

11

051015−10−50510MAS 5.0AM11111111111112222222222−12223333333333−11−113444444444−10−10−10455555555−9−9−9−956666666−8−8−8−8−8777777−7−7−7−7−7−7−788888−6−6−6−6−6−6−6−69999−5−5−5−5−5−5−5−5−5101010−4−4−4−4−4−4−4−4−4−41111−3−3−3−3−3−3−3−3−3−3−312−2−2−2−2−2−2−2−2−2−2−2−2−1−1−1−1−1−1−1−1−1−1−1−1−1¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥-¥-¥-¥-¥-¥-¥-¥-¥-¥-¥-¥-¥-¥-¥051015−10−50510RMAAM11111111111112222222222−12223333333333−11−113444444444−10−10−10455555555−9−9−9−956666666−8−8−8−8−8777777−7−7−7−7−7−7−788888−6−6−6−6−6−6−6−69999−5−5−5−5−5−5−5−5−5101010−4−4−4−4−4−4−4−4−4−41111−3−3−3−3−3−3−3−3−3−3−312−2−2−2−2−2−2−2−2−2−2−2−2−1−1−1−1−1−1−1−1−1−1−1−1−1¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥-¥-¥-¥-¥-¥-¥-¥-¥-¥-¥-¥-¥-¥-¥> affycomp.compfig2(list(mas5.assessment$Dilution, rma.assessment$Dilution),
+

method.names=c("MAS 5.0","RMA"))

Figure 2: For each gene, and each experimental condition, we calculate the mean log
expression and the observed standard deviation across 5 replicates. The resulting scat-
terplot is smoothed to generate a single curve representing mean standard deviation as
a function of mean log expression.

12

05100.20.40.60.81.0Figure 2log expressionstandard error across replicatesMAS 5.0RMA> affycomp.compfig3(list(mas5.assessment$Dilution, rma.assessment$Dilution),
+

method.names=c("MAS 5.0","RMA"))

Figure 3: This plot, using the Gene Logic dilution data, shows the sensitivity of fold
change calculations to total RNA abundance. Average log fold-changes between liver and
CNS for the lowest concentration and the highest in the dilution data set are computed.
Orange and red color is used to denote genes with M6g − M1g bigger than log2(2) and
log2(3) respectively. The rest are denoted with black.

13

MAS 5.0RMA−4−2024Figure 3Difference between log fold changes> par(mfrow=c(2,1))
> affycomp.compfig4a(list(mas5.assessment$Signal, rma.assessment$Signal),
method.names=c("MAS 5.0","RMA"))
+
> affycomp.compfig4b(list(mas5.assessment$Dilution, rma.assessment$Dilution),
+

method.names=c("MAS 5.0","RMA"))

Figure 4: a) Average observed log2 intensity plotted against nominal log2 concentration
for each spiked-in gene for all arrays in Affymetrix spike-In experiment. b) For the
Gene Logic dilution data, log expression values are regressed against their log nominal
concentration. The slope estimates are plotted against average log intensity across all
concentrations.

14

−202468104812Figure 4aNominal concentration (in picoMolar)Observed expressionMAS 5.0RMA05100.50.70.9Figure 4blog expressionregression slopesMAS 5.0RMA> par(mfrow=c(2,1))
> affycomp.compfig5a(list(mas5.assessment$FC, rma.assessment$FC),
+
> affycomp.compfig5b(list(mas5.assessment$FC2, rma.assessment$FC2),
+

method.names=c("MAS 5.0","RMA"))

method.names=c("MAS 5.0","RMA"))

Figure 5: A typical identification rule for differential expression filters genes with fold
change exceeding a given threshold. This figure shows average ROC curves which offer
a graphical representation of both specificity and sensitivity for such a detection rule.
a) Average ROC curves based on comparisons with nominal fold changes ranging from
2 to 4096. b) As a) but with nominal fold changes equal to 2.

15

0204060801002610Figure 5aFalse PositivesTrue PositivesMAS 5.0RMA0204060801002610Figure 5bFalse PositivesTrue PositivesMAS 5.0RMA> par(mfrow=c(2,2))
> affycomp.figure6a(mas5.assessment$FC, main="a) MAS 5.0", ylim=c(-12,12))
> affycomp.figure6a(rma.assessment$FC, main="a) RMA", ylim=c(-12,12))
> affycomp.figure6b(mas5.assessment$FC, main="b) MAS 5.0", ylim=c(-6,6))
> affycomp.figure6b(rma.assessment$FC, main="b) RMA", ylim=c(-6,6))

Figure 6: a) Observed log fold changes plotted against nominal log fold changes. The
dashed lines represent highest, 25th highest, 100th highest, 25th percentile, 75th per-
centile, smallest 100th, smallest 25th, and smallest log fold change for the genes that were
not differentially expressed. b) Like a) but the observed fold changes were calculated for
spiked in genes with nominal concentrations no higher than 2pM.

3.3 Tables

The function tableAll returns a matrix with assessment statistics. Once the assessment
function is run, all one needs to type is

16

111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111−10−50510−100510a) MAS 5.0Nominal log ratioobserved log ratio22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222223333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111−10−50510−100510a) RMANominal log ratioobserved log ratio22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222223333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff−3−2−10123−6−2246b) MAS 5.0Nominal log ratioobserved log ratio−3−2−10123−6−2246b) RMANominal log ratioobserved log ratio> data(rma.assessment)
> data(mas5.assessment)
> tableAll(rma.assessment, mas5.assessment)

Median SD
R2
1.25v20 corr
2-fold discrepancy
3-fold discrepancy
Median slope
Signal detect slope
Signal detect R2
AUC (FP<10)
AUC (FP<15)
AUC (FP<25)
AUC (FP<100)
AFP, call if fc>2
ATP, call if fc>2
IQR
Obs-intended-fc slope
Obs-(low)int-fc slope
FC=2, AUC (FP<10)
FC=2, AUC (FP<15)
FC=2, AUC (FP<25)
FC=2, AUC (FP<100)
FC=2, AFP, call if fc>2
FC=2, ATP, call if fc>2

RMA

MAS 5.0
0.08811999 2.920239e-01
0.99420626 8.890008e-01
0.93645083 7.297434e-01
21.00000000 1.226000e+03
0.00000000 3.320000e+02
0.86631340 8.474941e-01
0.62537111 7.058227e-01
0.80414899 8.565416e-01
0.57774758 2.171241e-01
0.62731941 2.379589e-01
0.68984189 2.696288e-01
0.82066051 3.557402e-01
15.84156379 3.107387e+03
11.97942387 1.281893e+01
0.30801579 2.655135e+00
0.61209902 6.932507e-01
0.35950904 6.471881e-01
0.30344013 6.160714e-02
0.34324269 6.190476e-02
0.40009470 6.232830e-02
0.54261364 6.508575e-02
1.00000000 3.069786e+03
1.71428571 3.714286e+00

17

The function affycompTable makes a minimal table (that is also informative).

> affycompTable(rma.assessment, mas5.assessment)

Median SD
R2
1.25v20 corr
2-fold discrepancy
3-fold discrepancy
Signal detect slope
Signal detect R2
Median slope
AUC (FP<100)
AFP, call if fc>2
ATP, call if fc>2
FC=2, AUC (FP<100)
FC=2, AFP, call if fc>2
FC=2, ATP, call if fc>2
IQR
Obs-intended-fc slope
Obs-(low)int-fc slope

RMA

0.08811999 2.920239e-01
0.99420626 8.890008e-01
0.93645083 7.297434e-01
21.00000000 1.226000e+03
0.00000000 3.320000e+02
0.62537111 7.058227e-01
0.80414899 8.565416e-01
0.86631340 8.474941e-01
0.82066051 3.557402e-01
15.84156379 3.107387e+03
11.97942387 1.281893e+01
0.54261364 6.508575e-02
1.00000000 3.069786e+03
1.71428571 3.714286e+00
0.30801579 2.655135e+00
0.61209902 6.932507e-01
0.35950904 6.471881e-01

MAS.5.0 whatsgood Figure
2
2
3
3
3
4a
4a
4b
5a
5a
5a
5b
5b
5b
6
6a
6b

0
1
1
0
0
1
1
1
1
0
16
1
0
16
0
1
1

3.4 Standard deviation assessment

The package also contains a simple tool to assess standard error estimates. For this
to work the ExpressionSet object used for the assessment must have standard error
estimates for the dilution data. We include two examples.

> data(rma.sd.assessment)
> data(lw.sd.assessment)
> tableAll(rma.sd.assessment, lw.sd.assessment)

dChip
IQR of log ratio 0.910003 1.1918510
0.364145 0.7925533
Correlation

RMA

For the SD assessment, there is also a comparison plot in addition to the basic plot.

See affycompPlot (and affycomp.compfig7 or affycomp.figure7).

18

> affycompPlot(lw.sd.assessment, rma.sd.assessment)

Figure 7: Using the replicates from the dilution data, we calculate the mean predicted
variance for each gene, tissue, and dilution by squaring the estimated standard error.
tdg = (cid:80)
r(ytdrg − ytd·g)2/4 are calculated as well. These
The usual sample variances s2
boxplots are of the log ratios of the predicted and observed variance.

19

dChipRMA−6−4−20246Figure 7Log ratio of nominal SD and observed SD> affycompPlot(lw.sd.assessment)

Figure 7: Using the replicates from the dilution data, we calculate the mean predicted
variance for each gene, tissue, and dilution by squaring the estimated standard error. The
r(ytdrg − ytd·g)2/4 are calculated as well. A scatterplot
usual sample variances s2
of the log ratios of the predicted and observed variance, against mean log expression.

tdg = (cid:80)

4 The end

Enjoy!

20

2468101214−6−4−2024Figure 7Log expressionLog (Nominal SD/Observed SD)