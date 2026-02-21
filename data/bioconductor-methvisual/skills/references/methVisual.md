MethVisual - R package for visualization and exploratory
statistical analysis of DNA methylation proﬁles

Arie Zackay and Christine Steinhoﬀ

October 30, 2018

1 Background

DNA Methylation is a biochemical modiﬁcation of DNA which in vertebrates almost ex-
clusively occurs at CpG sites, e.g. a methyl group is added at the 5 prime C position of
cytosines. Exploration of DNA methylation and its impact on various regulatory cellular
processes has become a very active ﬁeld of research and comprises cancer, silencing of repet-
itive elements, development, chromatin remodeling, RNA interference, imprinting, tissue
speciﬁcity, and evolutionary mutation processes To date the most accurate experimental
procedures are based on bisulﬁte treatment followed by conversion of non methylated cy-
tosines to uracil and sequencing. Analyzing this kind of data is complicated. Several steps,
like alignment of bisulﬁte treated sequence to reference sequence, detection of low conver-
sion rates of C to T in the bisulﬁte treatment and conversion process and quality control,
are necessary before actually extracting methylation proﬁles for further statistical analy-
sis. However, this procedure is a prerequisite for the investigation of functionality of DNA
methylation. MethVisual allows for processing this kind of data as well as several basic
exploratory analysis and visualization steps.

MethVisual enables intuitive visualization and exploratory analysis of binary DNA methy-
lation data. The package allows the user to import binary methylation sequences (clone
sequences) as generated from bisulﬁte sequencing, aligns them, perform quality control pro-
cess and execute statistical analysis (Table 1). The package was developed for methylation
data but can also be applied on other binary coded data types in a straightforward manner.

This document provides an example for the analysis workﬂow. It includes the required steps
for the analysis of methylation data, using the example data saved in this package. This
example data is taken from the program BiQ-Analyzer 1.

The analysis steps are:

1. Reading sequences sample sequences and reference sequence

2. Alignment control and quality control

3. Computation of methylation status

1http://biq-analyzer.bioinf.mpi-sb.mpg.de/

1

4. Exploratory statistics and visualization including lollipop plot, neighboring cooccurrence-

and distant cooccurrence analysis

5. Further statistical investigations including hierarchical clustering and correspon-

dence analysis

Description
Cooccurrence of methylation data
Summary of methylation states
Sequence match control
Lollipop plot
Alignment and quality control
Amount of CpG sites
Methylation state
Sequence conversion
Aligned CpG positions
HeatMap over methylation data
Processing GFF methylation ﬁles
Saving example data
Tab delimited text ﬁle
Correlation between methylation states
Correspondence analysis (CA) methylation states
BiQ-Analyzer dataset
Fisher’s exact Test on methylation Data

methVisual
Functions
Cooccurrence
MethAlignNW
MethDataInput
MethLollipops
MethylQC
cgInAlign
cgMethFinder
coversionGenom
findNonAligned
heatMapMeth
makeDataMethGFF
makeLocalExpDir
makeTabFilePath
matrixSNP
methCA
methData
methFisherTest
methWhitneyUTest Mann Whitney U-Test on methylation data
Plot of the absolute number of methylation
plotAbsMethyl
Distant cooccurrence of methylation data
plotMatrixSNP
Read multiple FASTA ﬁle
readBisulfFASTA
Upload genomic sequence
selectRefSeq

Table 1: The functions are available in methVisual

In order to start please download the newest version of methVisual and load it into R.

> library(methVisual)

2 Reading Sequences

This section demonstrate the analysis of FASTA ﬁles, that includes the clone sequences and
the reference sequence.

First, the example data has to be saved in a directory. Please make sure that you have
reading and writing permission under R.home() directory. If you do not have permission
choose your own path.

Creating BiQ-Analyzer directory in your R.home():

2

> dir.create(file.path(R.home(component="home"),"/BiqAnalyzer/"))

Saving methVisual example data in /BiqAnalyzer directory:

> makeLocalExpDir(dataPath="/examples/BiqAnalyzer",localDir=file.path(R.home(component="home"),"/BiqAnalyzer/"))

Upload the list of clone sequences as tab delimited text ﬁle:

> methData <-MethDataInput(file.path(R.home(component="home"),"/BiqAnalyzer","/PathFileTab.txt"))

Hereby the sample sequence list is saved in a data frame object methData with PATH and
FILE column

> methData

FILE

PATH
1 seq_A.fasta /home/biocbuild/bbs-3.8-bioc/R//BiqAnalyzer/
2 seq_B.fasta /home/biocbuild/bbs-3.8-bioc/R//BiqAnalyzer/
3 seq_C.fasta /home/biocbuild/bbs-3.8-bioc/R//BiqAnalyzer/
4 seq_D.fasta /home/biocbuild/bbs-3.8-bioc/R//BiqAnalyzer/
5 seq_E.fasta /home/biocbuild/bbs-3.8-bioc/R//BiqAnalyzer/
6 seq_F.fasta /home/biocbuild/bbs-3.8-bioc/R//BiqAnalyzer/
7 seq_G.fasta /home/biocbuild/bbs-3.8-bioc/R//BiqAnalyzer/
8 seq_H.fasta /home/biocbuild/bbs-3.8-bioc/R//BiqAnalyzer/
9 seq_I.fasta /home/biocbuild/bbs-3.8-bioc/R//BiqAnalyzer/
10 seq_J.fasta /home/biocbuild/bbs-3.8-bioc/R//BiqAnalyzer/

Read reference sequence into R

> refseq <- selectRefSeq(file.path(R.home(component="home"),"/BiqAnalyzer","/Master_Sequence.txt"))

3 Alignment Control and Quality Control

The alignment control (AC) procedure comprises a comparison of the sample sequences to
the reference sequence and is performed to prevent false alignment in the further analysis.
False alignment can occur because of three reasons, sequences that are reversed, complement
or reversed-complement to the genomic sequence. The AC procedure compare the score re-
sult computed by pairwise Needleman Wunsch Algorithm for global alignment implemented
in the Biostrings 2 R package and select the alignment variant with the highest score among
these three possibilities for each clone sequence involved. If changes are necessary, they will
be either performed automatically or left to the user to include them. The alignment con-
trolled sequences will be saved. Potential errors during the experimental process of bisulﬁte
sequencing concern mainly bisulﬁte conversion and sequence identity. However, bisulﬁte
conversion might be incomplete, that means even though non methylated cytosines (Cs)

2http://www.bioconductor.org/packages/2.2/bioc/html/Biostrings.html

3

should be converted to uracils (Us) upon bisulﬁte treatment and subsequent ampliﬁcation
there might be non methylated Cs that have not been converted.
In vertebrates we can
assume that methylation is restricted to CpG sites. Thus, non converted Cs outside of CpG
sites can be regarded as non conversion failure. MethVisual further measures the bisulﬁte
treatment quality by calculating this conversion ratio among Cs in non CpG sites, which is
deﬁned as the ratio between the number of unconverted Cs and the sum of all Cs outside
CpG sites. MethVisual also determines the sequence identity between each sample sequence
and genomic sequence by calculating the sequencing error rate and restricting the compari-
son of sequenced sample versus reference sequence to As, Gs and Ts. The user can deﬁne a
threshold percentage for rejecting sequences.

All control procedures are implemented under the function MethylQC().

> QCdata <- MethylQC(refseq, methData,makeChange=TRUE,identity=80,conversion=90)

The sample sequence list after AC and QC procedure is saved as a data frame object with
PATH and FILE column.

> QCdata

FILE
1 QC_seq_B.fasta
2 QC_seq_C.fasta
3 QC_seq_E.fasta
4 QC_seq_G.fasta
5 QC_seq_H.fasta
6 QC_seq_I.fasta

PATH
1 /home/biocbuild/bbs-3.8-bioc/R//BiqAnalyzer/
2 /home/biocbuild/bbs-3.8-bioc/R//BiqAnalyzer/
3 /home/biocbuild/bbs-3.8-bioc/R//BiqAnalyzer/
4 /home/biocbuild/bbs-3.8-bioc/R//BiqAnalyzer/
5 /home/biocbuild/bbs-3.8-bioc/R//BiqAnalyzer/
6 /home/biocbuild/bbs-3.8-bioc/R//BiqAnalyzer/

4 Calculation of methylation status

Now the user needs to extract the information on methylation states from the quality checked
sample sequences. Given the aligned sequences, the function MethAlignNW() returns a list
object with the following data: Sequence name, methylation state of CpG sites over all clone
sequences, start and end position of alignments and the length of reference sequence.

> methData <- MethAlignNW( refseq , QCdata)

Alignment with QC_seq_B.fasta done
Alignment with QC_seq_C.fasta done

4

Alignment with QC_seq_E.fasta done
Alignment with QC_seq_G.fasta done
Alignment with QC_seq_H.fasta done
Alignment with QC_seq_I.fasta done

> methData

$seqName
[1] "QC_seq_B.fasta" "QC_seq_C.fasta" "QC_seq_E.fasta"
[4] "QC_seq_G.fasta" "QC_seq_H.fasta" "QC_seq_I.fasta"

$alignment
[1] "TTTGGGATTGTTTTTTTAGTAGGTGAAGTTTTGTTATGGATTTTTTTTGTTGGGGTTTTGTGTTGTTTTGTTTGTTTTTAGTTGTTGGTTAAGGTTGTGGTTGTGTAGCTGTAGTGTTGTGTTTTGTCGTTGTTTTGTTTTGTTTGTTGTTGTGGATGGTGTTGTGTGTAGCAGTGTGTATTTTTTTTTCAGGAATTTGTGGAGGGAGTGTAGGTTTGAAGAGCTTTTGGATG"
[2] "TTCGGGATCGTTTTTTTAGTAGGTGAAGTTTTGTTATGGATTTTTTTCGTTGGGGTTTCGTGTTGTTTTGTTCGTTTTTAGTCGTTGGTTAAGGTTGCGGTCGCGTAGGCGTAGTGTCGCGTTCCGTCGTCGTTTCGTTTTGTTCGTTGTTGTGGAAGGTGTTGCGCGTAGTAATGCGTATTTTTTTTTTAGGAATTCGTGGAGGGAGTGTAGGTTCGAAGAGTTTTTGGATG"
[3] "TTTGGGATTGTTTTTTTTAGCAGGTGAAGTTTTGTTATGGATTTTTTTTGTTGGGGTTTTGATGTTGTTTCGTTTGTTTCTAGTTGTTGGTTTAAGGTCGTGGTTGTGTAGGCGTAGTGTCGCGTTTCGTCGTTGTTTTGTTTTGTTCGTCGTTGCGGAAGGTGTTGTGCGTAGCAATGCGTATTTTTTTTTTAGGAATTTGTGGAGGGAGTGTAGGTTTGAAGAGTTTTTGGATG"
[4] "TTTGGGATTGTTTTTTTAGTAGGTGAAGTTTTGTTATGGATTTTTTTTGTTGGGGTTTTGTGTTGTTTTGTTTGTTTTTAGTTGTTGGTTAAGGTTGTGGTTGTGTAGGTGTAGTGTTGTGTTTTGTCGTTGTTTTGTTTTGTTTGTTGTTGTGGAAGGTGTTGTGTGTAGCAATGTGTATTTTTTTTTCAGGAATTTGTGGAGGGAGTGTAGGTTTGAAGAGCTTTTGGATG"
[5] "TTCGGGATTGTTTTTTTAGTAGGTGAAGTTTTGTTATGGATTTTTTTTGTTGGGGTTTCGTGTTGTTTTGTTCGTTTTTTGTTGTTGGTTAAGGTCGCGGTCGCGTAGGCGTAGTGTCGCGTTTCGTCGTCGTTTTGTTTTGTTCGTCGTTGCGGAAGGCGGTTGCGCGTAGTAACGTGTATTTTTTTTTTAGGAATTTGTGGAGGGAGCGTAGGTTCGAAGAGTTTTTGGACG"
[6] "TTTGGGATTGTTTTTTTAGTAGGTGAAGTTTTGTTATGGATTTTTTTTGTTGGGGTTTTGTGTTGTTTTGTTTGTTTTTAGTTGTTGGTTAAGGTTGTGGTTGTGTAGGTGTAGTGTTGTGTTTTGTTGTTGTTTTGTTTTGTTTGTTGTTGTGGAAGGTGTTGTGTGTAGTAATGTGTATTTTTTTTTTTAGGAATTTGTGGAGGGAGTGTAGGTTTGAAGAGTTTTTGGATG"

$methPos

[1,]
[2,]
[3,]
[4,]
[5,]
[6,]

[1,]
[2,]
[3,]
[4,]
[5,]
[6,]

[1,]
[2,]
[3,]
[4,]
[5,]
[6,]

[1,]
[2,]
[3,]
[4,]
[5,]
[6,]

[,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
0
1
0
0
0
0

0
1
0
0
1
0

0
0
0
0
0
0

0
0
0
0
0
0

0
0
0
0
0
0

0
1
0
0
1
0

0
1
0
0
1
0

0
1
0
0
0
0

0
0
0
0
0
0

0
1
0
0
0
0

0
1
1
0
1
0

0
1
0
0
1
0

0
1
0
0
1
0

0
0
1
0
1
0

0
1
1
0
1
0

0
1
1
0
1
0

0
1
0
0
1
0

0
1
1
0
1
0

[,11] [,12] [,13] [,14] [,15] [,16] [,17] [,18] [,19]
1
1
1
1
1
0
[,20] [,21] [,22] [,23] [,24] [,25] [,26] [,27] [,28]
0
1
1
0
1
0

0
0
0
0
0
0
[,29] [,30] [,31] [,32] [,33] [,34] [,35]
0
0
0
0
1
0

0
1
0
0
1
0

0
0
0
0
0
0

0
0
0
0
1
0

0
1
1
0
0
0

0
1
0
0
0
0

0
0
0
0
1
0

0
0
0
0
1
0

0
0
1
0
1
0

0
1
0
0
1
0

0
1
0
0
1
0

0
1
0
0
0
0

0
1
1
0
1
0

0
0
1
0
1
0

5

$positionCGIRef
3

[1]

9 32 48 51 59 61 69 73 83 96 98 102 104
[15] 110 118 120 125 128 131 136 145 148 153 160 163 165 167
[29] 175 177 198 200 209 217 232

$startEnd

[,1] [,2]
1 233
1 233
1 233
1 233
1 233
1 233

[1,]
[2,]
[3,]
[4,]
[5,]
[6,]

$lengthRef
[1] 233

Now one can proceed with the visualization and statistics of the data!

5 Exploratory statistics and visualization

5.1 Amount of methylation

Plotting the absolute or relative number of methylation of all CpG positions of all sample
sequences provides a global overview of the data set in terms of methylation amounts by
genomic position (Figure 1).

> plotAbsMethyl(methData,real=TRUE)
>

5.2 Lollipop ﬁgures

A graphical representation of methylation state can be produced applying Lollipop graphs
(Figure 2). It allows the user to study the states of CpG sites in sample sequences. Each
circle marks a CpG site under study. Full circles display methylated CpG sites and the non
ﬁlled ones stand for non-methylated CpG states. The examined sequences are aligned with
respect to the CpG sites in reference sequence in order to allow an intuitive visualization of
methylation states according to their genomic order.

> MethLollipops(methData)
>

6

Figure 1: The number of methylated CpG over all 6 analyzed sequences. The x-axis is the
genomic CpG position

Figure 2: Lollipop display of binary methylation proﬁles in the genomic context

7

050100150200012345Absolute number of methylated CpGsposition of CpG methylation on genomic sequenceabsolute number of methylated CpG05101520253035index of CpG methylationindex of clone sequenceslllllllllllllllllllllllllllllllllll123456refSeqlllllllllllllllllllllllllllllllllll123456refSeqlllllllllllllllllllllllllllllllllll123456refSeqlllllllllllllllllllllllllllllllllll123456refSeqlllllllllllllllllllllllllllllllllll123456refSeqlllllllllllllllllllllllllllllllllll123456refSeqlllllllllllllllllllllllllllllllllll5.3 Neighboring cooccurrence display

The study of cooccurrence of methylated or non methylated CpG sites is frequently investi-
gated. Given a set of bisulﬁte sequenced samples one would like to detect subgroups where
speciﬁc CpG sites always occur coordinately either methylated or non methylated. One
drawback of the widely used lollipop representation is that cooccurrence displays are not
integrated. We implemented an option to visualize neighbored cooccurrence of methylation
patterns. This display is restricted to neighboring cooccurrence of CpG methylation.

> file <- file.path(R.home(component="home"),"/BiqAnalyzer/","Cooccurrence.pdf")
> Cooccurrence(methData,file=file)

5.4 Distant cooccurrence display

However, one might also want to explore cooccurrence features in a distant manner, i.e.
not directly neighbored CpG sites. Thus, we provide a comprehensive visualization of all
pairwise coccurrences of methylation (Figure 3). The correlation structure can be saved and
statistically further explored.

> summery <- matrixSNP(methData)
> plotMatrixSNP(summery,methData)
>

6 Further statistical investigations

6.1 Statistical tests

Basic statistical tests options comprise (i) testing for independence of each CpG site between
two groups (Fisher’s exact test) or (ii) of entire sets of CpG sites (Mann-Whitney U test).
More speciﬁcally, for (i) given two experimental groups for each CpG site the user can
investigate whether there is a dependence of methylation status and class membership of
the two groups (Figure 4). In the case of (ii) given two experimental groups the hypothesis
that the distribution of methylated and non-methylated sites in the proﬁle under study is
being tested.

> methFisherTest(methData, c(2,3,5), c(1,4,6))
>

Looking at the Lollipop plot (Figure 2) one can see that the clone sequences (2,3,5) seems
to have diﬀerent CpG pattern than clones (1,4,6). The calculated p-value using Whithney-
U-Test conﬁrm the signiﬁcant pattern diﬀerence.

> methWhitneyUTest(methData, c(2,3,5), c(1,4,6))

[1] 0

8

Figure 3: Distant cooccurrence plot. Each pairwise comparison, e.g. neighboring and dis-
tant, leads to a correlation value that is displayed in the matrix. Correlation is color coded
and the color coding bar is given beside the graph. The numbers in the diagonal give the
genomic position of each CpG site.

9

Distant cooccurrence plot−0.32cor 1393248515961697383969810210411011812012512813113614514815316016316516717517719820020921723210.63NA0.63NA1NANA10.630.251110.710.710.710.710.3210.630.710.250.250.63NA10.710.630.250.63NA0.6310.631NA1NA0.63NANA0.631−0.320.630.630.630.450.450.450.450.20.6310.45−0.32−0.32−0.2NA0.630.45−0.20.631NA−0.20.63−0.2NANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANA1NA0.63NANA0.631−0.320.630.630.630.450.450.450.450.20.6310.45−0.32−0.32−0.2NA0.630.45−0.20.631NA−0.20.63−0.2NANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANA1NANA10.630.251110.710.710.710.710.3210.630.710.250.250.63NA10.710.630.250.63NA0.6310.63NANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANA10.630.251110.710.710.710.710.3210.630.710.250.250.63NA10.710.630.250.63NA0.6310.631−0.320.630.630.630.450.450.450.450.20.6310.45−0.32−0.32−0.2NA0.630.45−0.20.631NA−0.20.63−0.210.250.250.250.710.710.710.710.320.25−0.320.71110.63NA0.250.710.630.25−0.32NA0.630.250.631110.710.710.710.710.3210.630.710.250.250.63NA10.710.630.250.63NA0.6310.63110.710.710.710.710.3210.630.710.250.250.63NA10.710.630.250.63NA0.6310.6310.710.710.710.710.3210.630.710.250.250.63NA10.710.630.250.63NA0.6310.6311110.450.710.4510.710.710.45NA0.7110.450.710.45NA0.450.710.451110.450.710.4510.710.710.45NA0.7110.450.710.45NA0.450.710.45110.450.710.4510.710.710.45NA0.7110.450.710.45NA0.450.710.4510.450.710.4510.710.710.45NA0.7110.450.710.45NA0.450.710.4510.320.20.450.320.320.2NA0.320.450.20.320.2NA0.20.320.210.630.710.250.250.63NA10.710.630.250.63NA0.6310.6310.45−0.32−0.32−0.2NA0.630.45−0.20.631NA−0.20.63−0.210.710.710.45NA0.7110.450.710.45NA0.450.710.45110.63NA0.250.710.630.25−0.32NA0.630.250.6310.63NA0.250.710.630.25−0.32NA0.630.250.631NA0.630.451−0.32−0.2NA10.631NANANANANANANANANANA10.710.630.250.63NA0.6310.6310.450.710.45NA0.450.710.451−0.32−0.2NA10.63110.63NA−0.320.25−0.321NA−0.20.63−0.2NANANANA10.63110.631Figure 4: P-values of methylated CpG position

6.2 Clustering

Clustering is a methods for exploring and visualizing groups with similar features. We
provide a hierarchical bi-clustering of methylation states. Due to the fact that we analyze
binary rather than continuous data the default option for distance is the binary rather than
euclidean distance (Figure 5 5).

> heatMapMeth(methData)
>

6.3 simple correspondence analysis

Using simple correspondence analysis (CA) one can detect clusters of sub-samples that show
similar cooccurrence patterns. Based on aligned sequences under study a CA plot displays
two way clustering of methylation status of all sequences and all aligned CpG positions
(Figure 6).

> methCA(methData)
>

10

lllllllllllllllllllllllllllllllllll051015202530350.20.40.60.81.0Fisher's exact testCpG indexp−valueFigure 5: Bi-clustering due to methylated CpG positions of sample sequences

Figure 6: Simple correspondence analysis of methylated CpG positions and samples se-
quences

11

3533252924112332268735303121102419342720141312916282218171516614325Dimension 1 (41.7%)Dimension 2 (29.3%)−0.50.00.5−0.6−0.4−0.20.00.20.40.6llllllclone1clone2clone3clone4clone5clone6CpG1CpG2CpG3CpG4CpG5CpG6CpG7CpG8CpG9CpG10CpG11CpG12CpG13CpG14CpG15CpG16CpG17CpG18CpG19CpG20CpG21CpG22CpG23CpG24CpG25CpG26CpG27CpG28CpG29CpG30CpG31CpG32CpG33CpG34CpG35