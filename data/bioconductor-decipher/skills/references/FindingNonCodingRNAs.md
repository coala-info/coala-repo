The Double Life of RNA: Uncovering Non-Coding RNAs

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

3 Building a Non-Coding RNA Model
.
3.1
Importing the sequences
.
.
.
3.2 Aligning the sequences .
.
3.3 Learning sequence patterns .

.
.
.

.
.

.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.

.

4 Finding Non-Coding RNAs

5 Session Information

1 Introduction

1

1
1

2
2
3
8

9

13

RNA leads a double life as both messenger (mRNA) and number of other roles in the cell (e.g., rRNA, tRNA, snRNA,
tmRNA, etc.). RNAs that take on a life of their own are notoriously difficult to detect ab initio using bioinformatics.
This is in part because their signature characteristic, that the sequence of RNA folds into a stable structure, can be
found for sequences in many regions of the genome. The ubiquity of stable secondary structures makes life difficult
because there is no clear signature that a genomic region contains a non-coding RNA in the way there are distinct
signatures for protein coding regions. The most promising approach is to search for intergenic regions with high GC-
content and a folded structure that is conserved across many genomes. But what do you do if you only have a single
genome and want to find non-coding RNAs? That is exactly what this vignette shows you how to do!

Before we can have the time of our lives finding non-coding RNAs, we must first train models on examples
of known RNAs. As a case study, this tutorial focuses on finding all known non-coding RNAs in the genome of
Chlamydia trachomatis, an intracellular bacterial pathogen known for causing chlamydia. This genome was chosen
because it is relatively small (only 1 Mbp) so the examples run quickly. Chlamydia harbors all of the standard non-
coding RNAs that date back near the origin of life (i.e., rRNAs, tRNAs, etc.). It also has one small RNA (sRNA),
named IhtA, that has only been found in Chlamydiae and is believed to play a role in regulating its life stages. We
are going to find IhtA in the genome of C. trachomatis, then we are going to use the same approach to find all of the
standard non-coding RNAs that are conserved across many forms of life.

2 Getting Started

2.1 Startup

To get started we need to load the DECIPHER package, which automatically loads a few other required packages.

1

> library(DECIPHER)

Searches for non-coding RNAs are performed by the function FindNonCoding. Help can be accessed via:

> ? FindNonCoding

Once DECIPHER is installed, the code in this tutorial can be obtained via:

> browseVignettes("DECIPHER")

3 Building a Non-Coding RNA Model

Before we can find a non-coding RNA, we need to create a multiple sequence alignment of some of its sequence
representatives. This alignment will be the input to LearnNonCoding.

3.1

Importing the sequences

The first step is to set filepaths to the sequences (in FASTA format). In this case we are going to use the IhtA sequences
included with DECIPHER, but you could follow along with your own set of homologous sequences. Be sure to change
the path names to those on your system by replacing all of the text inside quotes labeled “<<path to ...>>” with the
actual path on your system.

> # specify the path to your genome:
> fas_path <- "<<path to FASTA file>>"
> # OR use the example genome:
> fas_path <- system.file("extdata",

"IhtA.fas",
package="DECIPHER")

> # read the sequences into memory
> rna <- readRNAStringSet(fas_path)
> rna
RNAStringSet object of length 27:

width seq

names

[1]
[2]
[3]
[4]
[5]
...
[23]
[24]
[25]
[26]
[27]

103 AAGAUGAUAUUCUGCGCCAUGGA...UGAUUGUUGUUUUCUUGGCUUU KE360988.1/6443-6...
105 AAGAUGAUAUUCUCCGCCGUGGA...AACUUUAUGUUUUCUUGGCUUU AE002161.1/54676-...
107 AAGUUGGUAUUCUAACGCCAUGG...UAUCUCCGGUUCUCUUGGCUUU AE001273.1/773281...
107 AAGUUGGUAUUCUAACGCCAUGG...UGUCUCCAGUUCUCUUGGCUUU AE002160.2/53054-...
103 AAGAUGAUAUUCUACGCCAUGGA...UGAUUGUUGUUUUCUUGGCUUU AE015925.1/52097-...
... ...
107 AAGUUGGUAUUCUAACGCCAUGG...UAUCUCCGGUUCUCUUGGCUUU CP006674.1 Chlamy...
103 AAGAUGAUAUUCUGCGCCAUGGA...UGAUUGUUGUUUUCUUGGCUUU KE356008.1 Chlamy...
108 AAGUUGGUAUUCUAACGCCAUGG...UAUCUCCGGUUCUCUUGGCUUU CVNC01000001.1 Ch...
103 AAGAUGAUAUUCUGCGCCAUGGA...UGAUUGUUGUUUUCUUGGCUUU AP006861.1 Chlamy...
101 AAGAUGAUAUUCUACGCCAUGGA...AUGAUGUUGUUUUCUUGGCUUU CP015840.1 Chlamy...

Ideally we would start with a few thousand diverse sequence representatives, yet only 27 representatives of

IhtA are known. That’s life, so we will have to make due with what we have available.

2

3.2 Aligning the sequences

Next we need to align the sequences with AlignSeqs. Note that non-coding RNA alignments are more accurate if
we provide the sequences as a RNAStringSet rather than the equivalent DNAStringSet, because AlignSeqs will use
conserved secondary structure to improve the alignment. Alignment is fast, so hold on for dear life! (Consider adding
processors=NULL if you want it to go even faster with multiple processors.)

> RNA <- AlignSeqs(rna)
Predicting structures based on free energies:
================================================================================

Time difference of 0.76 secs

Determining distance matrix based on shared 7-mers:
================================================================================

Time difference of 0 secs

Clustering into groups by similarity:
================================================================================

Time difference of 0.01 secs

Aligning Sequences:
================================================================================

Time difference of 0.12 secs

Iteration 1 of 2:

Determining distance matrix based on alignment:
================================================================================

Time difference of 0 secs

Reclustering into groups by similarity:
================================================================================

Time difference of 0.01 secs

Realigning Sequences:
================================================================================

Time difference of 0.07 secs

Iteration 2 of 2:

Determining distance matrix based on alignment:
================================================================================

Time difference of 0 secs

3

Reclustering into groups by similarity:
================================================================================

Time difference of 0.01 secs

Realigning Sequences:
================================================================================

Time difference of 0.01 secs
> RNA
RNAStringSet object of length 27:

width seq

names

[1]
[2]
[3]
[4]
[5]
...
[23]
[24]
[25]
[26]
[27]

114 AAGAUGAUAUUCUG-CGCCAUGG...GA-UUGUUGUUUUCUUGGCUUU KE360988.1/6443-6...
114 AAGAUGAUAUUCUC-CGCCGUGG...AACUUUAUGUUUUCUUGGCUUU AE002161.1/54676-...
114 AAGUUGGUAUUCUAACGCCAUGG...----UCCGGUUCUCUUGGCUUU AE001273.1/773281...
114 AAGUUGGUAUUCUAACGCCAUGG...----UCCAGUUCUCUUGGCUUU AE002160.2/53054-...
114 AAGAUGAUAUUCUA-CGCCAUGG...GA-UUGUUGUUUUCUUGGCUUU AE015925.1/52097-...
... ...
114 AAGUUGGUAUUCUAACGCCAUGG...----UCCGGUUCUCUUGGCUUU CP006674.1 Chlamy...
114 AAGAUGAUAUUCUG-CGCCAUGG...GA-UUGUUGUUUUCUUGGCUUU KE356008.1 Chlamy...
114 AAGUUGGUAUUCUAACGCCAUGG...----UCCGGUUCUCUUGGCUUU CVNC01000001.1 Ch...
114 AAGAUGAUAUUCUG-CGCCAUGG...GA-UUGUUGUUUUCUUGGCUUU AP006861.1 Chlamy...
114 AAGAUGAUAUUCUA-CGCCAUGG...GA--UGUUGUUUUCUUGGCUUU CP015840.1 Chlamy...

We can see from the alignment that the sequences have both conserved and variable regions. But if we really
want to bring the sequences to life we need to look at their predicted secondary structures. The IhtA is believed to
form three back-to-back hairpin loops based on its minimum free energy structure. We can use PredictDBN (Predict
Dot-Bracket Notation) to predict the secondary structures of the sequences.

> p <- PredictDBN(RNA, type="structures")
Determining distance matrix based on alignment:
================================================================================

Time difference of 0 secs

Determining sequence weights:
================================================================================

Time difference of 0 secs

Computing Free Energies:
================================================================================

Time difference of 0.39 secs

Predicting RNA Secondary Structures:
================================================================================

Time difference of 0.01 secs
> BrowseSeqs(RNA, patterns=p)

4

Figure 1: Predicted secondary structure of IhtA

In this color scheme, blue regions pair to green regions and red regions are unpaired. There is clear evidence
for a hairpin loop near the 3’-end if IhtA, and weaker evidence for conserved secondary structure elsewhere in the
sequences (Fig. 1).

5

We can also visualize the secondary structure through a dot plot (Fig. 2). The top half of the dot plot shows the
probabilities of pairing, and the bottom half shows the pairs selected for the predicted structure. This view reveals the
level of ambiguity in the secondary structure based on the (low) amount of available information.

6

> evidence <- PredictDBN(RNA, type="evidence", threshold=0, verbose=FALSE)
> pairs <- PredictDBN(RNA, type="pairs", verbose=FALSE)
> dots <- matrix(0, width(RNA)[1], width(RNA)[1])
> dots[evidence[, 1:2]] <- evidence[, 3]
> dots[pairs[, 2:1]] <- 1
> image(dots, xaxt="n", yaxt="n", col=gray(seq(1, 0, -0.01)))
> abline(a=0, b=1)
> cons <- toString(ConsensusSequence(RNA, threshold=0.2))
> cons <- strsplit(cons, "")[[1]]
> at <- seq(0, 1, length.out=length(cons))
> axis(1, at, cons, tick=FALSE, cex.axis=0.3, gap.axis=0, line=-1)
> axis(2, at, cons, tick=FALSE, cex.axis=0.3, gap.axis=0, line=-1)

Figure 2: Secondary Structure Dot Plot.

7

AAGUGRUAUUCUR+CGCCAUGGAAUAGCUUCURACUCURKUGYWKU−+++CAGGGGGR−AAGYCAAGAWRHV++KMGUY−DGCCGUA+Y++++UBYKGUUYUCUUGGCUUUAAGUGRUAUUCUR+CGCCAUGGAAUAGCUUCURACUCURKUGYWKU−+++CAGGGGGR−AAGYCAAGAWRHV++KMGUY−DGCCGUA+Y++++UBYKGUUYUCUUGGCUUUTwo considerations are important at this stage: (i) that we have a clearly defined boundary representing the true
beginning and end of every sequence, and (ii) that the sequences are a diverse sample of what we hope to find. Here
we don’t have any partial sequences, but if we did they could be identified by counting gaps (“-”) at their ends with
TerminalChar. Any partial sequences should be removed before proceeding, for example by using:

> RNA <- unique(RNA)
> t <- TerminalChar(RNA)
> w <- which(t[, "leadingChar"] <= median(t[, "leadingChar"]) &

t[, "trailingChar"] <= median(t[, "trailingChar"]))

> RNA <- RemoveGaps(RNA[w], "common")

Rather than remove partial sequences, it would have been possible to shorten the alignment to the region shared

by all sequences using subseq.

3.3 Learning sequence patterns

Now we need to build a model capturing the essential characteristics of the non-coding RNA. The function LearnNonCoding
takes an alignment as input and outputs an object of class NonCoding that describes the sequences.

> y <- LearnNonCoding(RNA)
> y
NonCoding object with 16 motifs, 5 hairpins, and 2-mer frequencies.

The output object is a list containing patterns of three types: “motifs”, “hairpins”, and “kmers”. Motifs are
short regions of the sequence that can be used to identify the sequences. Each row stores information about where the
motif is expected relative to the ncRNA, as well as its position weight matrix (pwm) and associated scores.

> y[["motifs"]]

motif

begin_low begin_high end_low end_high
pwm
100
AAGATGr 0.946800....
93
TATTCTA 0.017733....
86
CGCCATG 0.018053....
85
G 0.017733....
76
AATAGCTTC 0.908696....
63
rACTCTGkTGyw 0.446377....
60
TT 0.041726....
52
CAGGGGGA 0.085348....
A 0.946800....
51
38 AGCCAAGAarrhr 0.946800....
kmGTC 0.221530....
31
dGCCGTA 0.275894....
24
A 0.946800....
20
18
T 0.017733....
TkytGTTTTC 0.018053....
8
TTGGCTTT 0.017733....
0

0
7
14
21
22
31
44
46
54
55
69
74
82
84
85
95
minscore

0
7
15
22
23
33
46
51
59
60
75
80
86
88
89
99

96
89
82
81
72
59
56
48
47
34
27
20
19
18
8
0

prevalence

background
0, 2.082.... 0.035714.... 0.970011....
0, 5.871.... 0.035714.... 0.977774....
0, 6.119.... 0.035714.... 0.983434....
0, Inf 0.057263.... 0.550452....
0, 8.018.... 0.057263.... 0.985521....
0, 6.540.... 0.035714.... 0.976631....

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
14
15
16

1
2
3
4
5
6

8

0.756512.... 0.123059.... 0.708078....
7
5.040460.... 0.131007.... 0.997916....
8
9
0, Inf 0.035714.... 0.258942....
10 0, 9.459.... 0.061810.... 0.981447....
11 2.460447.... 0.206663.... 0.904872....
12 4.220658.... 0.021254.... 0.989102....
0, Inf 0.112712.... 0.582480....
13
0, Inf 0.281062.... 0.670569....
14
15 0, 3.463.... 0.035714.... 0.962619....
0, Inf 0.035714.... 0.990812....
16

Note that some of the motifs contain ambiguity codes (see IUPAC_CODE_MAP) that represent multiple nu-
cleotides. Motifs are defined by their distance from each end of the non-coding RNA, and their prevalence across
sequence representatives when allowing for a certain degree of distance.

> y[["hairpins"]]

begin_low begin_high end_low end_high width_low width_high length_low
6
8
5
5
7

-4
7
23
34
49

52
77
35
40
-4

1
7
29
38
54

46
19
39
22
38

57
20
46
29
58

58
81
40
44
15
prevalence

length_high

dG

background
15 -Inf, -4.... 0.107097.... 0.090727....
8 -Inf, -3.... 0.743057.... 0.008820....
9 -Inf, -4.... 0.255296.... 0.088102....
9 -Inf, -2.... 0.195755.... 0.112149....
26 -Inf, -2.... 0.139890.... 0.000105....

1
2
3
4
5

1
2
3
4
5

Hairpins are defined similarly, but allow for ambiguity in the form of varying free energy (dG). As we saw in

the predicted structures, the IhtA sequences end in a prominent hairpin that is both long and has a low free energy.

> head(y[["kmers"]])
[1] 184 109 183 162 78 84
> tail(y[["kmers"]])
[1] 236 222 216 218 155 339

Finally, the sequences are identifiable by their k-mer frequencies, which are stored in a vector as shown above.
In general, non-coding RNAs have higher GC-content than protein coding regions of genomes. Note that the value of
“k” is set automatically depending on the amount of information in the input sequence alignment.

4 Finding Non-Coding RNAs

Now that we have captured the life force of the sequences, our next goal is to find homologous non-coding RNAs in a
genome. You can either use your own genome or follow along with the example C. trachomatis genome.

> # specify the path to your genome:
> genome_path <- "<<path to genome FASTA file>>"
> # OR use the example genome:
> genome_path <- system.file("extdata",

"Chlamydia_trachomatis_NC_000117.fas.gz",

9

package="DECIPHER")

> # read the sequences into memory
> genome <- readDNAStringSet(genome_path)
> genome
DNAStringSet object of length 1:

width seq

names

[1] 1042519 GCGGCCGCCCGGGAAATTGCTA...GTTGGCTGGCCCTGACGGGGTA NC_000117.1 Chlam...

The function FindNonCoding finds matches to NonCoding models in a genome. Let’s search for the IhtA

model in the Chlamydia genome:

> FindNonCoding(y, genome)
================================================================================

Time difference of 6.73 secs
Genes object of size 1 specifying:
1 non-coding RNA of 107 nucleotides.

Index Strand Begin

1

1

0 773281 773387

End TotalScore Gene
-1

94.94

And there it is! The output tells us that the IhtA gene is found on the forward strand of the first sequence
("Index") in the genome. This match had a high score to first (and only) model in y (i.e., "Gene" is -1). Values
in the "Gene" column are negative to signify that these rows are predicted non-coding RNAs and not protein coding
genes. In this manner, non-coding and coding genes can be combined in the same Genes object.

Life’s too short to build models for every non-coding RNA, so we can load a set of pre-built models for our
bacterial genome. Replace “Bacteria” with “Archaea” or “Eukarya” for genomes from organisms belonging to other
domains of life.

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

10

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
[42] "Glycine_Riboswitch-RF00504"
[43] "HEARO-RF02033"
[44] "Flavo_1-RF01705"
[45] "Acido_Lenti_1-RF01687"
[46] "5'_ureB-RF02514"

What a life saver! Our new dataset (x) is a list of models, including tRNAs (by amino acid), transfer-messenger
RNA, RNase P, SsrS (6S RNA), group I and II introns, the signal recognition particle, and three rRNAs (5S, 16S, and
23S). Let’s add the model we built of IhtA into the list:

> x[[length(x) + 1]] <- y
> names(x)[length(x)] <- "IhtA"

Now we can search for them all at once with FindNonCoding:

> rnas <- FindNonCoding(x, genome)
================================================================================

Time difference of 57.87 secs
> rnas
Genes object of size 47 specifying:
47 non-coding RNAs from 72 to 2,938 nucleotides.

Index Strand Begin

1
2
3
4
5
6
... with 41 more rows.

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

11

> class(rnas)
[1] "Genes"

Wow! That has to be one of life’s simplest pleasures. FindNonCoding returned an object of class Genes.
By convention, the starting position of non-coding RNAs on the forward (0) Strand is at Begin, while those on the
reverse (1) Strand start at End. We can take a look at which RNAs were found:

> annotations <- attr(rnas, "annotations")
> m <- match(rnas[, "Gene"], annotations)
> sort(table(names(annotations)[m]))

1
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

IhtA RNase_P_class_A-RF00010
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

We see that the C. trachomatis genome has multiple tRNA genes, two copies of each ribosomal RNA gene, and

the RNaseP and tmRNA genes. Finally, it is possible to extract the non-coding RNAs from the genome:

> ExtractGenes(rnas, genome, type="RNAStringSet")
RNAStringSet object of length 47:

width seq

[1]
[2]
[3]
[4]
[5]
...
[43]
[44]
[45]
[46]
[47]

420 GGGGGUGUAAAGGUUUCGACUUAGAAAUGAAGC...AGGACGAGAGUUCGACUCUCUCCACCUCCAUAG
75 UCCGGAGUAGCUCAGCGGUAGAGCAGUGGACUG...UGGUCGUUGGUUCGAACCCAUCCUCCGGAGUCU
76 CGGAGUAUAGCGCAGCCUGGUUAGCGCGGUUGC...AUAGGUCGGGGGUUCGAAUCCCUCUACUCCGAU
75 GCUGGAGUAGCUCAAUUGGCAGAGCAUUCGAUU...ACGGUUGAGGGUUCAAUUCCUUUCUCCAGCAUC
84 GGGGGUGUCGCAUAGCGGUCAAUUGCAUCGGAC...CGGAUACGUUGGUUCAAAUCCAGCCACCCCCAG

... ...

72 GGUGGCAUCGCCAAGCGGUAAGGCCGAGGCCUG...CUCUAUCCCCGGUUCGAUUCCGGGUGCCACCUU
74 UGGGGUGUGGCCAAGCGGUAAGGCAGCGGUUUU...CGCAUCGGAGGUUCGAAUCCUUCCACCCCAGAG
75 GGGGUAUUAGCUCAGUUGGUUAGAGCGUCACGU...GAAGGUCAGCUGUUCAAGUCAGCUAUAUCCCAA
88 GGAAGAAUGGCAGAGCGGUUUAAUGCACCUGUC...GGUCCGGGGGUUCGAAUCCCUCUUCUUCCGCAU
85 GCCCAGGUGGUGAAAUUGGUAGACACGCUGGAU...GGCAUGUAGGUUCAAGUCCUAUCCUGGGCAUAG

You’ll be the life of the party now that you know how to build models for non-coding RNAs and find them in a

genome.

12

5 Session Information

All of the output in this vignette was produced under the following conditions:

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats, stats4, utils

• Other packages: BiocGenerics 0.56.0, Biostrings 2.78.0, DECIPHER 3.6.0, IRanges 2.44.0, S4Vectors 0.48.0,

Seqinfo 1.0.0, XVector 0.50.0, generics 0.1.4

• Loaded via a namespace (and not attached): DBI 1.2.3, KernSmooth 2.23-26, compiler 4.5.1, crayon 1.5.3,

tools 4.5.1

13

