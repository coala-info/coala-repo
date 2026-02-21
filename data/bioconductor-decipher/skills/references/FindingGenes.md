The Magic of Gene Finding

Erik S. Wright

October 29, 2025

Contents

1 Introduction

2 Getting Started
.
2.1 Startup .

.

.

.

.

.

.

.

.

.

.

.

.

.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Finding Genes in a Genome
Importing the genome .
.
.

3.1
3.2 Finding genes .
3.3

.
Inspecting the output

.

.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4 Analyzing the Output

4.1 Extracting genes from the genome . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.2 Removing genes with too many ambiguities . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.3 Taking a look at the shortest genes . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.4 Revealing the secrets of gene finding . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.5 Taking a closer look at the output .

5 Incorporating non-coding RNAs

5.1 Examining the intergenic spaces .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5.2 Finding and including non-coding RNAs . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

6 Annotating the protein coding genes

7 Guaranteeing repeatability

8 Exporting the output

9 Session Information

1 Introduction

1

2
2

2
2
2
4

4
4
6
6
7
9

11
11
14

16

19

19

19

This vignette reveals the tricks behind the magic that is ab initio gene finding. Cells all have the magical ability
to transcribe and translate portions of their genome, somehow decoding key signals from a sea of possibilities. The
FindGenes function attempts to decipher these signals in order to accurately predict an organism’s set of genes. Cells
do much of this magic using only information upstream of the gene, whereas FindGenes uses both the content of the
gene and its upstream information to predict gene boundaries. As a case study, this tutorial focuses on finding genes in
the genome of Chlamydia trachomatis, an intracellular bacterial pathogen known for causing chlamydia. This genome
was chosen because it is relatively small (only 1 Mbp) so the examples run quickly. Nevertheless, FindGenes is
designed to work with any genome that lacks introns, making it well-suited for prokaryotic gene finding.

1

2 Getting Started

2.1 Startup

To get started we need to load the DECIPHER package, which automatically loads a few other required packages.

> library(DECIPHER)

Gene finding is performed with the function FindGenes. Help can be accessed via:

> ? FindGenes

Once DECIPHER is installed, the code in this tutorial can be obtained via:

> browseVignettes("DECIPHER")

3 Finding Genes in a Genome

Ab initio gene finding begins from a genome and locates genes without prior knowledge about the specific organism.

3.1

Importing the genome

The first step is to set filepaths to the genome sequence (in FASTA format). Be sure to change the path names to
those on your system by replacing all of the text inside quotes labeled “<<path to ...>>” with the actual path on your
system.

> # specify the path to your genome:
> genome_path <- "<<path to genome FASTA file>>"
> # OR use the example genome:
> genome_path <- system.file("extdata",

"Chlamydia_trachomatis_NC_000117.fas.gz",
package="DECIPHER")

> # read the sequences into memory
> genome <- readDNAStringSet(genome_path)
> genome
DNAStringSet object of length 1:

width seq

names

[1] 1042519 GCGGCCGCCCGGGAAATTGCTA...GTTGGCTGGCCCTGACGGGGTA NC_000117.1 Chlam...

3.2 Finding genes

The next step is to find genes in the genome using FindGenes, which does all the magic. There are fairly few choices
to make at this step. By default, the bacterial and archaeal genetic code is used for translation, including the initiation
codons “ATG”, “GTG”, “TTG”, “CTG”, “ATA”, “ATT”, and “ATC”. The default minGeneLength is 60, although we
could set this lower (e.g., 30) to locate very short genes or higher (e.g., 90) for (only slightly) better accuracy. The
argument allowEdges (default TRUE) controls whether genes are allowed to run off the ends of the genome, as would
be expected for circular or incomplete chromosomes. Here, we will only set showPlot to TRUE to display a summary
of the gene finding process and allScores to TRUE to see the scores of all open reading frames (including predicted
genes).

2

Auto

RBS

Term

Fold UpsNt

_
\
|
/
_
\
|
/
_

Models Start Motif Init

1 18.40
1 18.40
1 18.40
1 18.40
1 18.40
1 18.40
1 18.40
1 18.40
1 18.40

> orfs <- FindGenes(genome, showPlot=TRUE, allScores=TRUE)
Iter
1
1
1
1
1
1
1
1
1
2
3
4
5
6
7
8
9
10
11
12
13

12 18.40 0.48 0.90
15 18.38 0.53 1.16
11 15.63 0.52 1.26
11 15.67 0.52 1.25
13 15.64 0.51 1.24
14 15.63 0.50 1.24
11 15.63 0.51 1.25
12 15.63 0.51 1.25
12 15.62 0.51 1.24
11 15.62 0.51 1.24
11 15.62 0.50 1.24
11 15.62 0.50 1.24

1.41
1.78
1.82
1.90
1.93
1.93
1.94
1.94
1.95
1.95
1.95

0.37
0.44
0.45
0.50
0.48
0.48
0.49
0.49
0.50
0.49
0.50

0.24
0.25
0.25
0.25
0.25
0.25
0.25
0.25
0.25
0.25

0.97
1.06
1.07
1.07
1.07
1.08
1.10
1.10
1.13

0.10
0.10
0.09
0.09
0.09
0.10
0.10
0.10
0.10

Stop Genes
886
886
886
886
886
886
886
886
886
888
890
892
894
895
894
895
894
893
893
894
894

0.07
0.07
0.07
0.07
0.07
0.07
0.07
0.07
0.07

Time difference of 34.49 secs

3

Figure 1: Plot summarizing the gene finding process of FindGenes. See ?plot.Genes for details.

100500200050000.00.51.01.52.02.53.0ORF length (nucleotides)log10(Frequency)BackgroundInterceptsORF502005002000100000.00.20.40.60.8Length (nucleotides)Frequency (%)BackgroundEstimatedGene−200−1000100200−4−2024Intergenic length (nucleotides)Log−oddsStrandSameOppo.100500200050000100300500ORF length (nucleotides)Total scoreORFGeneThreshold3.3

Inspecting the output

And presto! With a wave of our magic wand we now have our gene predictions in the form of an object belonging to
class Genes. Now that we have our genes in hand, let’s take a look at them:

> orfs
Genes object of size 109,490 specifying:
894 protein coding genes from 66 to 5,361 nucleotides.
108,596 open reading frames from 60 to 5,370 nucleotides.

Index Strand Begin End TotalScore ... Gene
1
0
0
0
0
0

1
0
2
0
3
0
4
0
5
1
1
6
... with 109,484 more rows.

79.30 ...
-4.75 ...
62.59 ...
-9.00 ...
-13.58 ...
-35.34 ...

1 1176
82
2
16 1176
17
82
41 106
91 150

1
1
1
1
1
1

Open reading frames are defined by their Begin and End position, as well as whether they are on the top (i.e.,
Strand is 0) or bottom strand. Here, genes are flagged by having a non-zero value in the Gene column. We see all
the open reading frames in the output because allScores was set to TRUE. If we only want to look at the subset of open
reading frames that are predicted as genes, we can subset the object:

> genes <- orfs[orfs[, "Gene"]==1,]

The "Gene" column is one of several describing the open reading frames. Objects of class Genes are stored

as matrices with many columns:

> colnames(genes)

[1] "Index"
[3] "Begin"
[5] "TotalScore"
[7] "CodingScore"
[9] "CouplingScore"

[11] "StopScore"
[13] "TerminationCodonScore"
[15] "AutocorrelationScore"
[17] "UpstreamMotifScore"
[19] "FractionReps"

4 Analyzing the Output

4.1 Extracting genes from the genome

"Strand"
"End"
"LengthScore"
"CodonModel"
"StartScore"
"InitialCodonScore"
"RibosomeBindingSiteScore"
"UpstreamNucleotideScore"
"FoldingScore"
"Gene"

Predictions in hand, the first thing we can do is extract the genes from the genome. This can be easily done using
ExtractGenes.

> dna <- ExtractGenes(genes, genome)
> dna

4

DNAStringSet object of length 894:

width seq

[1] 1176 GCGGCCGCCCGGGAAATTGCTAAAAGATGGGAG...GGCGTTGGAATAGAGAAGTCGATAGGGAATAA
273 ATGCTTTGTAAAGTTTGTAGAGGATTATCTTCT...GATACCACCACCATCATATGGATAGAGAATAA
[2]
[3]
303 ATGACAGAGTCATATGTAAACAAAGAAGAAATC...GATTAGTCAAAGTCCCTACAGTTATCAAATAG
[4] 1476 ATGTATCGTAAGAGTGCTTTAGAATTAAGAGAT...TGAATGGACTTTTTGACGGAGGAATAGAATAA
[5] 1467 ATGGGCATAGCACATACTGAATGGGAGTCTGTG...AATTGCTATTAGCAGCTATGCGAGATATGTAA
...

... ...

[890] 3051 ATGCCTTTTTCTTTGAGATCTACATCATTTTGT...TTGTATCCATGGGCTTGAATAGAATCTTTTAA
[891]
303 ATGCTGGCAACAATTAAAAAAATTACTGTGTTG...GAGATTCTCGCCTAGAATGCAAGAAGATATAA
[892] 2637 ATGCGACCTGATCATATGAACTTCTGTTGTCTA...CCCTGGATCTGGGGACCACTTACAGGTTCTAG
96 ATGTCAAAAAAAAGTAATAATTTACAGACTTTT...ATGAAGAGTTAAGGAAGATTTTTGGATTGTGA
[893]
600 ATGAGCATCAGGGGAGTAGGAGGCAACGGGAAT...AAGCGAACAAGTTGGCTGGCCCTGACGGGGTA
[894]

We see that the first gene has no start codon and the last gene has no stop codon. This implies that the genes
likely connect to each other because the genome is circular and the genome end splits one gene into two. Therefore,
the first predicted gene’s first codon is not a true start codon and we need to drop this first sequence from our analysis
of start codons. We can look at the distribution of predicted start codons with:

> table(subseq(dna[-1], 1, 3))
ATG GTG TTG
94 20
779

There are the typical three bacterial initiation codons, “ATG”, “GTG”, and “TTG”, and one predicted non-

canonical initiation codon: “CTG”. Let’s take a closer look at genes with non-canonical initiation codons:

> w <- which(!subseq(dna, 1, 3) %in% c("ATG", "GTG", "TTG"))
> w
[1] 1
> w <- w[-1] # drop the first sequence because it is a fragment
> w
integer(0)
> dna[w]
DNAStringSet object of length 0
> genes[w]
Genes object of size 0.

That worked like a charm, so let’s look at the predicted protein sequences by translating the genes:

> aa <- ExtractGenes(genes, genome, type="AAStringSet")
> aa
AAStringSet object of length 894:

width seq

[1]
[2]
[3]
[4]
[5]
...

392 AAAREIAKRWEQRVRDLQDKGAARKLLNDPLGR...QVEGILRDMLTNGSQTFRDLMRRWNREVDRE*
91 MLCKVCRGLSSLIVVLGAINTGILGVTGYKVNL...CLNFLKCCFKKRHGDCCSSKGGYHHHHMDRE*
101 MTESYVNKEEIISLAKNAALELEDAHVEEFVTS...DMVTSDFTQEEFLSNVPVSLGGLVKVPTVIK*
492 MYRKSALELRDAVVNRELSVTAITEYFYHRIES...ICQVGYSFQEHSQIKQLYPKAVNGLFDGGIE*
489 MGIAHTEWESVIGLEVHVELNTESKLFSPARNH...GFLVGQIMKRTEGKAPPKRVNELLLAAMRDM*
... ...

[890] 1017 MPFSLRSTSFCFLACLCSYSYGFASSPQVLTPN...HHFGRAYMNYSLDARRRQTAHFVSMGLNRIF*
101 MLATIKKITVLLLSKRKAGIRIDYCALALDAVE...LDASLESAQVRLAGLMLDYWDGDSRLECKKI*
[891]

5

[892]
[893]
[894]

879 MRPDHMNFCCLCAAILSSTAVLFGQDPLGETAL...LHRLQTLLNVSYVLRGQSHSYSLDLGTTYRF*

32 MSKKSNNLQTFSSRALFHVFQDEELRKIFGL*

200 MSIRGVGGNGNSRIPSHNGDGSNRRSQNTKGNN...NLDVNEARLMAAYTSECADHLEANKLAGPDGV

All of the genes start with a methionine (“M”) residue and end with a stop (“*”) except the first and last gene
because they wrap around the end of the genome. If so inclined, we could easily remove the first and last positions
with:

> subseq(aa, 2, -2)
AAStringSet object of length 894:

width seq

[1]
[2]
[3]
[4]
[5]
...

390 AAREIAKRWEQRVRDLQDKGAARKLLNDPLGRR...QQVEGILRDMLTNGSQTFRDLMRRWNREVDRE
89 LCKVCRGLSSLIVVLGAINTGILGVTGYKVNLL...VCLNFLKCCFKKRHGDCCSSKGGYHHHHMDRE
99 TESYVNKEEIISLAKNAALELEDAHVEEFVTSM...EDMVTSDFTQEEFLSNVPVSLGGLVKVPTVIK
490 YRKSALELRDAVVNRELSVTAITEYFYHRIESH...QICQVGYSFQEHSQIKQLYPKAVNGLFDGGIE
487 GIAHTEWESVIGLEVHVELNTESKLFSPARNHF...LGFLVGQIMKRTEGKAPPKRVNELLLAAMRDM
... ...

[890] 1015 PFSLRSTSFCFLACLCSYSYGFASSPQVLTPNV...IHHFGRAYMNYSLDARRRQTAHFVSMGLNRIF
99 LATIKKITVLLLSKRKAGIRIDYCALALDAVEY...QLDASLESAQVRLAGLMLDYWDGDSRLECKKI
[891]
[892]
877 RPDHMNFCCLCAAILSSTAVLFGQDPLGETALL...ALHRLQTLLNVSYVLRGQSHSYSLDLGTTYRF
[893]
[894]

198 SIRGVGGNGNSRIPSHNGDGSNRRSQNTKGNNK...GNLDVNEARLMAAYTSECADHLEANKLAGPDG

30 SKKSNNLQTFSSRALFHVFQDEELRKIFGL

4.2 Removing genes with too many ambiguities

Genomes sometimes contain ambiguous positions (e.g., “N”) within open reading frames. These ambiguities can make
an open reading frame look longer than it actually is, giving the illusion of a single gene when none (or more than
one) is present. We can easily remove those with more than some magic number (let’s say 20 or 5%) of ambiguous
positions:

> a <- alphabetFrequency(dna, baseOnly=TRUE)
> w <- which(a[, "other"] <= 20 & a[, "other"]/width(dna) <= 5)
> genes <- genes[w]

Abracadabra! The genes with many ambiguities have magically disappeared from our gene set.

4.3 Taking a look at the shortest genes

You might think finding short genes (< 90 nucleotides) would require black magic, but FindGenes can do it quite
well. We can select the subset of short genes and take a look at how repeatedly they were called genes during iteration:

> w <- which(width(dna) < 90)
> dna[w]
DNAStringSet object of length 3:

width seq

[1]
[2]
[3]
> aa[w]

69 ATGAGTCATATAAGTATTCGCAATAGTAGTTATTTATTCGCTAATCCAAATCAAGAAATCGTATTTTGA
87 ATGAAATTAAAACAAAAGATCGGAATAAAAACAT...GCTCTGGGCCTTGCGAAAAAAACCAAAAAATAG
66 ATGTTAGTGTGGGTTATGAGACAGCCGCGTTATAACTCGGAAGTAGAGAAAAAACAAGATTTTTAG

6

AAStringSet object of length 3:

width seq

23 MSHISIRNSSYLFANPNQEIVF*
29 MKLKQKIGIKTFGQKKRKALGLAKKTKK*
22 MLVWVMRQPRYNSEVEKKQDF*

[1]
[2]
[3]
> genes[w]
Genes object of size 3 specifying:
3 protein coding genes from 66 to 87 nucleotides.

Index Strand Begin

4606
9793
45975
> genes[w, "End"] - genes[w, "Begin"] + 1 # lengths

1 44025 44093
1 94116 94202
1 443090 443155

End TotalScore ... Gene
1
1
1

9.29 ...
7.06 ...
7.40 ...

1
1
1

4606
69

9793 45975
66

87

> genes[w, "FractionReps"]

4606
1

9793 45975
1

1

We can see from the FractionReps column always being 100% that these short genes were repeatedly identified

during iteration, suggesting they weren’t pulled out of a hat. That’s impressive given how short they are!

4.4 Revealing the secrets of gene finding

All of this might seem like hocus pocus, but the predictions made by FindGenes are supported by many scores.
Some scores are related because they make use of information from the same region relative to the gene boundaries.
We can take a look at score correlations with:

7

> pairs(genes[, 5:16], pch=46, col="#00000033", panel=panel.smooth)

Figure 2: Scatterplot matrix of scores used by FindGenes to make gene predictions.

8

TotalScore020028−42−42−130600−440200LengthScoreCodingScore040028CodonModelCouplingScore0−42StartScoreStopScore−0.5−42InitialCodonScoreTerminationCodonScore−22−13RibosomeBindingSiteScoreAutocorrelationScore−23−44060004000−0.5−22−23UpstreamNucleotideScoreCertainly some of the magic of gene finding is having a lot of scores! We can see that the ribosome binding
site score and upstream nucleotide score are the most correlated. This isn’t just magical thinking, both scores rely on
the same nucleotides immediately upstream of the start codon. The different scores are defined as follows:

1. Upstream signals

(a) Ribosome Binding Site Score - Binding strength and position of the Shine-Delgarno sequence, as well as

other motifs in the first bases upstream of the start codon.

(b) Upstream Nucleotide Score - Nucleotides in each position immediately upstream of the start codon.

(c) Upstream Motif Score - K-mer motifs further upstream of the start codon.

2. Start site signals

(a) Start Score - Choice of start codon relative to the background distribution of open reading frames.

(b) Folding Score - Free energy of RNA-RNA folding around the start codon and relative to locations upstream

and downstream of the start.

(c) Initial Codon Score - Choice of codons in the first few positions after the start codon.

3. Gene content signals

(a) Coding Score - Usage of codons or pairs of codons within the open reading frame.

(b) Codon Model - Number of the codon model that best fit each open reading frame.

(c) Length Score - Length of the open reading frame relative to the background of lengths expected by chance.

(d) Autocorrelation Score - The degree to which the same or different codons are used sequentially to code for

an amino acid.

(e) Coupling Score - Likelihood of observing neighboring amino acids in real proteins.

4. Termination signals

(a) Termination Codon Score - Codon bias immediately before the stop codon.

(b) Stop Score - Choice of stop codon relative to the observed distribution of possible stop codons.

4.5 Taking a closer look at the output

If we have a particular gene of interest, it can sometimes be useful to plot the output of FindGenes as the set of
all possible open reading frames with the predicted genes highlighted. The plot function for a Genes object is
interactive, so it is possible to pan left and right by setting the interact argument equal to TRUE. For now we will only
look at the beginning of the genome:

9

> plot(orfs, interact=FALSE)

Figure 3: All possible open reading frames (red and blue) with predicted genes highlighted in green.

10

0200040006000800010000−1000100200300400500Cumulative genome positionTotal score5 Incorporating non-coding RNAs

5.1 Examining the intergenic spaces

The space between genes sometimes contains promoter sequences, pseudogenes, or non-coding RNA genes that are
of interest. We can conjure up the intergenic sequences longer than a given width (e.g., 30 nucleotides) with the
commands:

> s <- c(1, genes[, "End"] + 1)
> e <- c(genes[, "Begin"] - 1, width(genome))
> w <- which(e - s >= 30)
> intergenic <- unlist(extractAt(genome, IRanges(s[w], e[w])))
> intergenic
DNAStringSet object of length 500:

width seq

names

[1]
[2]
[3]
[4]
[5]
...
[496]
[497]
[498]
[499]
[500]

144 ACTGGTATCTACCATAGGTTTG...TATAATCTGAAAGGAAGGCGTT NC_000117.1 Chlam...
200 GACGTTTCTCCAACGTAGATGT...TTGACCATGTTTAGGATGGAAG NC_000117.1 Chlam...
98 TTTGCAGCATCCTCAAAAAAGG...AGGCTTTATCGCTTTTCCAATA NC_000117.1 Chlam...
127 AAAATTATCCCAAAAACAAAAA...ACATAGATTCTAGCACTTCTTA NC_000117.1 Chlam...
312 TTTTCCAACTAGGTGTTATGTA...GCTGATTGTATGATGGAGTGGT NC_000117.1 Chlam...
... ...
164 CGCAGGTTAAAAGGGGGATGTT...TTTATCTCTCAGCTTTTGTGTG NC_000117.1 Chlam...
596 TAAAGATTTTTCTTTTCAGAAG...AAAGAAGATGTCATCAAACAGG NC_000117.1 Chlam...
174 TCGCCAGGTTTCGAGACAAAGT...AACGCAATGCTAGGCAAGGGAA NC_000117.1 Chlam...
NC_000117.1 Chlam...
144 AATTAGAAAAATCAGAATTATC...TTTAGTTTTGGGTTGGTTTGTT NC_000117.1 Chlam...

33 GGGATTCCCCCTAAGAGTCTAAAAGAAGAGGTT

Some of these intergenic regions might be similar to each other. We can find related intergenic sequences by

clustering those within a certain distance (e.g., 20

> intergenic <- c(intergenic, reverseComplement(intergenic))
> names(intergenic) <- c(w, paste(w, "rc", sep="_"))
> clusts <- Clusterize(myXStringSet=intergenic, cutoff=0.3)
Partitioning sequences by 6-mer similarity:
================================================================================

Time difference of 0.25 secs

Sorting by relatedness within 572 groups:

iteration 2 of up to 202 (100.0% stability)

Time difference of 0.14 secs

Clustering sequences by 8-mer to 12-mer similarity:
================================================================================

Time difference of 11.86 secs

Clusters via relatedness sorting: 100% (0% exclusively)
Clusters via rare 6-mers: 100% (0% exclusively)
Estimated clustering effectiveness: 100%

11

Since we used inexact clustering, the clusters containing the longest sequences will be first. We can look at

sequences belonging to the first cluster:

> t <- sort(table(clusts$cluster), decreasing=TRUE)
> head(t) # the biggest clusters
157 174 309 387 389 423
3

3

3

3

3

3

> AlignSeqs(intergenic[clusts$cluster == names(t)[1]], verbose=FALSE)
DNAStringSet object of length 3:

width seq

names

[1]
[2]
[3]

319 TTTGTCACCCTTATTTTTTAGAA...----------------------- 317
319 -CTCTCCCCTCTCTTCTTAAAAA...----------------------- 381
319 -ACAGCCCCCTCATTGGAAAACA...AAACCAAAAAAATTTTTTAGAAT 866_rc

These two long intergenic regions probably contain copies of the ribosomal RNA operon. A signature of non-
coding RNAs is that they tend to have higher GC content than expected. We can create a plot of GC content in
intergenic regions versus size. Since our genome averages 41% GC content, we can use statistics to add a line for the
95% confidence interval. Only a few intergenic regions have unexpectedly high GC content.

12

> gc <- alphabetFrequency(intergenic, as.prob=TRUE, baseOnly=TRUE)
> gc <- gc[, "G"] + gc[, "C"]
> plot(width(intergenic),
100*gc,
xlab="Length (nucleotides)",
ylab="GC content (%)",
main="Intergenic regions",
log="x")
> size <- 10^seq(1, 4, 0.1)
> expected <- 0.413*size
> lines(size, 100*(expected + 1.96*sqrt(expected))/size)

Figure 4: Non-coding RNAs are often found in intergenic regions with unexpectedly high GC content.

13

501002005001000200050001020304050Intergenic regionsLength (nucleotides)GC content (%)5.2 Finding and including non-coding RNAs

The DECIPHER has a separate function, FindNonCoding, to find non-coding RNAs in a genome. It searches for
predefined models created from multiple sequence alignments of non-coding RNAs. Thankfully DECIPHER includes
pre-built models of non-coding RNAs commonly found in bacteria, archaea, and eukarya. Since C. trachomatis is a
bacterium, we will load the bacterial models. For genomes belonging to organisms from other domains of life, simply
replace “Bacteria” with “Archaea” or “Eukarya”.

> data(NonCodingRNA_Bacteria)
> x <- NonCodingRNA_Bacteria
> names(x)

[1] "tRNA-Ala"
[2] "tRNA-Arg"
[3] "tRNA-Asn"
[4] "tRNA-Asp"
[5] "tRNA-Cys"
[6] "tRNA-Gln"
[7] "tRNA-Glu"
[8] "tRNA-Gly"
[9] "tRNA-His"
[10] "tRNA-Ile"
[11] "tRNA-Leu"
[12] "tRNA-Lys"
[13] "tRNA-Met"
[14] "tRNA-Phe"
[15] "tRNA-Pro"
[16] "tRNA-Ser"
[17] "tRNA-Thr"
[18] "tRNA-Trp"
[19] "tRNA-Tyr"
[20] "tRNA-Val"
[21] "tRNA-Sec"
[22] "rRNA_5S-RF00001"
[23] "rRNA_16S-RF00177"
[24] "rRNA_23S-RF02541"
[25] "tmRNA-RF00023"
[26] "tmRNA_Alpha-RF01849"
[27] "RNase_P_class_A-RF00010"
[28] "RNase_P_class_B-RF00011"
[29] "SsrS-RF00013"
[30] "Intron_Gp_I-RF00028"
[31] "Intron_Gp_II-RF00029"
[32] "SmallSRP-RF00169"
[33] "Cyclic-di-GMP_Riboswitch-RF01051"
[34] "Cyclic-di-AMP_Riboswitch-RF00379"
[35] "T-box_Leader-RF00230"
[36] "Ribosomal_Protein_L10_Leader-RF00557"
[37] "Cobalamin_Riboswitch-RF00174"
[38] "TPP_Riboswitch-RF00059"
[39] "SAM_Riboswitch-RF00162"
[40] "Fluoride_Riboswitch-RF01734"
[41] "FMN_Riboswitch-RF00050"

14

[42] "Glycine_Riboswitch-RF00504"
[43] "HEARO-RF02033"
[44] "Flavo_1-RF01705"
[45] "Acido_Lenti_1-RF01687"
[46] "5'_ureB-RF02514"

We need to search for these models in our genome before we can incorporate them into our gene calls.

> rnas <- FindNonCoding(x, genome)
================================================================================

Time difference of 57.61 secs
> rnas
Genes object of size 46 specifying:
46 non-coding RNAs from 72 to 2,938 nucleotides.

Index Strand Begin

1
2
3
4
5
6
... with 40 more rows.

1 20663 21082
1 42727 42801
1 68920 68995
0 158662 158736
0 158744 158827
1 202339 202414

1
1
1
1
1
1

End TotalScore Gene
-25
-3
-15
-17
-19
-10

88.31
69.82
78.58
55.72
52.24
68.58

Tada! FindNonCoding outputs an object of class Genes just like FindGenes. However, non-coding RNAs
are denoted with negative numbers in the Gene column. Each number corresponds to the model that was identified.
We can look at the set of non-coding RNAs that were found in the C. trachomatis genome:

> annotations <- attr(rnas, "annotations")
> m <- match(rnas[, "Gene"], annotations)
> sort(table(names(annotations)[m]))
RNase_P_class_A-RF00010
1
tRNA-Asp
1
tRNA-Glu
1
tRNA-Lys
1
tRNA-Tyr
1
rRNA_23S-RF02541
2
tRNA-Gly
2
tRNA-Arg
3
tRNA-Ser
4

SmallSRP-RF00169
1
tRNA-Cys
1
tRNA-His
1
tRNA-Phe
1
tmRNA-RF00023
1
rRNA_5S-RF00001
2
tRNA-Pro
2
tRNA-Met
3
tRNA-Leu
5

15

tRNA-Asn
1
tRNA-Gln
1
tRNA-Ile
1
tRNA-Trp
1
rRNA_16S-RF00177
2
tRNA-Ala
2
tRNA-Val
2
tRNA-Thr
3

There was at least one tRNA gene found for each amino acid, as well as two copies of each ribosomal RNA

gene, and the RNaseP and tmRNA genes. Now, we can easily include these non-coding RNAs into our gene calls.

Term

Fold UpsNt

_
\
|
/
_
\
|
/
_

Models Start Motif Init

1 18.40
1 18.40
1 18.40
1 18.40
1 18.40
1 18.40
1 18.40
1 18.40
1 18.40

> genes <- FindGenes(genome, includeGenes=rnas)
Iter
1
1
1
1
1
1
1
1
1
2
3
4
5
6
7
8
9
10

12 18.40 0.48 0.91
15 18.38 0.53 1.16
13 15.60 0.52 1.25
12 15.62 0.52 1.25
10 15.62 0.51 1.22
13 15.62 0.51 1.22
13 15.64 0.51 1.22
14 15.63 0.51 1.22
14 15.63 0.51 1.22

1.41
1.78
1.82
1.91
1.95
1.96
1.97
1.97

0.37
0.45
0.46
0.49
0.49
0.49
0.51
0.51

0.24
0.25
0.25
0.25
0.25
0.25
0.25

RBS

Auto

0.98
1.07
1.11
1.09
1.08
1.14

0.10
0.10
0.10
0.10
0.10
0.10

Stop Genes
931
931
931
931
931
931
931
931
931
934
936
938
940
941
941
940
940
940

0.07
0.07
0.07
0.07
0.07
0.07

Time difference of 28.53 secs
> genes
Genes object of size 940 specifying:
894 protein coding genes from 66 to 5,361 nucleotides.
46 non-coding RNAs from 72 to 2,938 nucleotides.

Index Strand Begin End TotalScore ... Gene
1
1
1
1
1
1

1
2
3
4
5
6
... with 934 more rows.

0
1 1176
1 1321 1593
0 1794 2096
0 2108 3583
0 3585 5051
1 5150 6241

79.06 ...
19.98 ...
31.47 ...
139.66 ...
125.99 ...
78.68 ...

1
1
1
1
1
1

That worked like magic! Now the Genes object contains both protein coding genes and non-coding RNAs.

6 Annotating the protein coding genes

The magic doesn’t have to end there. We can annotate our protein coding genes just like we did with the non-coding
RNAs. To master this sleight of hand, we first need a training set of labeled protein sequences. We have exactly that
included in DECIPHER for Chlamydia.

> fas <- system.file("extdata",

"PlanctobacteriaNamedGenes.fas.gz",
package="DECIPHER")

16

> prot <- readAAStringSet(fas)
> prot
AAStringSet object of length 2497:

width seq

names

[1]
[2]
[3]
[4]
[5]
...

227 MAGPKHVLLVSEHWDLFFQTKE...VGYLFSDDGDKKFSQQDTKLS A0A0H3MDW1|Root;N...
394 MKRNPHFVSLTKNYLFADLQKR...GKREDILAACERLQMAPALQS O84395|Root;2;6;1...
195 MAYGTRYPTLAFHTGGIGESDD...GFCLTALGFLNFENAEPAKVN Q9Z6M7|Root;4;1;1...
437 MMLRGVHRIFKCFYDVVLVCAF...TASFDRTWRALKSYIPLYKNS Q46222|Root;2;4;9...
539 MSFKSIFLTGGVVSSLGKGLTA...FIEFIRAAKAYSLEKANHEHR Q59321|Root;6;3;4...
... ...

[2493] 1038 MFEEVLQESFDEREKKVLKFWQ...EGTDWDLNGEPTKIIIKKSEY Q6MDY1|Root;6;1;1...
102 MVQIVSQDNFADSIASGLVLVD...VERSVGLKDKDSLVKLISKHQ Q9PJK3|Root;NoEC;...
[2494]
224 MKPQDLKLPYFWEDRCPKIENH...NLWRSKGEKIFCTEFVKRVGI Q9PL91|Root;2;1;1...
[2495]
427 MLRRLFVSTFLIFGMVSLYAKD...KIVIGLGEKRFPSWGGFPNNQ Q256H8|Root;NoEC;...
[2496]
[2497]
344 MLTLGLESSCDETACALVDAKG...GIHPCARYHWESISASLSPLP Q822Y4|Root;2;3;1...
> head(names(prot))
[1] "A0A0H3MDW1|Root;NoEC;chxR"
[3] "Q9Z6M7|Root;4;1;1;19;aaxB"
[5] "Q59321|Root;6;3;4;2;pyrG"

"O84395|Root;2;6;1;83;dapL"
"Q46222|Root;2;4;99;Multiple;waaA"
"P0C0Z7|Root;NoEC;groL"

The training sequences are named by their enzyme commission (EC) number and three or four-letter gene

name. The process of training a classifier is described elsewhere. For now, let’s jump straight to the solution:

> trainingSet <- LearnTaxa(train=prot,
taxonomy=names(prot),
maxChildren=1)

================================================================================

Time difference of 0.64 secs
> trainingSet

A training set of class 'Taxa'

* K-mer size: 6
* Number of rank levels: 7
* Total number of sequences: 2497
* Number of groups: 532
* Number of problem groups: 0
* Number of problem sequences: 0

Now we need to take the proteins we just found with FindGenes and classify them using our classifier.
Finally, we can assign each of our protein coding sequences to a classification in the Genes object:

> annotations <- sapply(ids, function(x) paste(x$taxon[-1], collapse="; "))
> u_annotations <- unique(annotations)
> genes[w, "Gene"] <- match(annotations, u_annotations) + 1L
> attr(genes, "annotations") <- c(attr(genes, "annotations"),

setNames(seq_along(u_annotations) + 1L,

u_annotations))

> genes
Genes object of size 940 specifying:
894 protein coding genes from 66 to 5,361 nucleotides.
46 non-coding RNAs from 72 to 2,938 nucleotides.

17

> w <- which(genes[, "Gene"] > 0)
> aa <- ExtractGenes(genes[w], genome, type="AAStringSet")
> ids <- IdTaxa(aa,

trainingSet,
fullLength=0.99,
threshold=50,
processors=1)

================================================================================

Time difference of 3.47 secs
> ids

A test set of class 'Taxa' with length 894

confidence taxon

9% Root; unclassified_Root
6% Root; unclassified_Root

100% Root; 6; 3; 5; -; gatC
100% Root; 6; 3; 5; 7; gatA
99% Root; 6; 3; 5; -; gatB
... ...
99% Root; NoEC; pmpH

[1]
[2]
[3]
[4]
[5]
...
[890]
[891]
[892]
[893]
[894]
> plot(trainingSet, ids[grep("unclassified", ids, invert=TRUE)])

0% Root; unclassified_Root
9% Root; unclassified_Root

8% Root; unclassified_Root

100% Root; NoEC; pmpI

18

Figure 5: Annotations of protein coding sequences in C. trachomatis and their distribution on the taxonomy of

functions.

Level 1Level 2Level 3Level 4Level 5Distribution on taxonomic treeIndex Strand Begin End TotalScore ... Gene
2
2
3
4
5
2

1
2
3
4
5
6
... with 934 more rows.

0
1 1176
1 1321 1593
0 1794 2096
0 2108 3583
0 3585 5051
1 5150 6241

79.06 ...
19.98 ...
31.47 ...
139.66 ...
125.99 ...
78.68 ...

1
1
1
1
1
1

With a little wizardry, we can now look at the top annotations in the genome.

> annotations <- attr(genes, "annotations")
> m <- match(genes[, "Gene"], annotations)
> head(sort(table(names(annotations)[m]), decreasing=TRUE))
unclassified_Root
564
tRNA-Met
3

tRNA-Leu
5
tRNA-Thr
3

tRNA-Ser
4

tRNA-Arg
3

7 Guaranteeing repeatability

FindGenes sometimes uses random sampling to increase speed of the algorithm. For this reason, gene predictions
may change slightly if the prediction process is repeated with the same inputs. For some applications this randomness
is undesirable, and it can easily be avoided by setting the random seed before using FindGenes. The process of
setting and then unsetting the seed in R is straightforward:

> set.seed(123) # choose a whole number as the random seed
> # then make gene predictions with FindGenes (not shown)
> set.seed(NULL) # return to the original state by unsetting the seed

8 Exporting the output

The genes can be exported in a variety of formats, including as a FASTA file with writeXStringSet, GenBank
(gbk) or general feature format (gff) file with WriteGenes, or delimited file formats (e.g., csv, tab, etc.) with
write.table.

Now that you know the tricks of the trade, you can work your own magic to find new genes!

9 Session Information

All of the output in this vignette was produced under the following conditions:

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

19

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats, stats4, utils

• Other packages: BiocGenerics 0.56.0, Biostrings 2.78.0, DECIPHER 3.6.0, IRanges 2.44.0, S4Vectors 0.48.0,

Seqinfo 1.0.0, XVector 0.50.0, generics 0.1.4

• Loaded via a namespace (and not attached): DBI 1.2.3, KernSmooth 2.23-26, compiler 4.5.1, crayon 1.5.3,

tools 4.5.1

20

