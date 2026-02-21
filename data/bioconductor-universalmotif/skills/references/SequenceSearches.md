Sequence manipulation and scanning

Benjamin Jean-Marie Tremblay∗

17 October 2021

Abstract

Sequences stored as XStringSet objects (from the Biostrings package) can be used by several functions
in the universalmotif package. These functions are demonstrated here and fall into two categories: sequence
manipulation and motif scanning. Sequences can be generated, shuffled, and background frequencies
of any order calculated. Scanning can be done simply to find locations of motif hits above a certain
threshold, or to find instances of enriched motifs.

Contents

1 Introduction

2 Basic sequence handling

2.1 Creating random sequences
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 Calculating sequence background . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.3 Clustering sequences by k-let composition . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Shuffling

3.1 Shuffling sequences . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2 Local shuffling . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4 Sequence scanning and enrichment

4.1 Choosing a logodds threshold . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.2 Regular and higher order scanning . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.3 Visualizing motif hits across sequences . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.4 Enrichment analyses . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.5 Fixed and variable-length gapped motifs . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.6 Detecting low complexity regions and sequence masking . . . . . . . . . . . . . . . . . . . . .

5 Motif discovery with MEME

6 Miscellaneous string utilities

Session info

References

1

Introduction

1

2
2
3
4

5
5
7

8
8
12
16
20
21
22

24

26

27

29

This vignette goes through generating your own sequences from a specified background model, shuffling
sequences whilst maintaining a certain k-let size, and the scanning of sequences and scoring of motifs. For an
introduction to sequence motifs, see the introductory vignette. For a basic overview of available motif-related

∗benjamin.tremblay@uwaterloo.ca

1

functions, see the motif manipulation vignette. For a discussion on motif comparisons and P-values, see the
motif comparisons and P-values vignette.

2 Basic sequence handling

2.1 Creating random sequences

The Biostrings package offers an excellent suite of functions for dealing with biological sequences.
The universalmotif package hopes to help extend these by providing the create_sequences() and
shuffle_sequences() functions. The first of these, create_sequences(), generates a set of letters in
random order, then passes these strings to the Biostrings package to generate the final XStringSet object.
The number and length of sequences can be specified. The probabilities of individual letters can also be set.

The freqs option of create_sequences() also takes higher order backgrounds. In these cases the sequences
are constructed in a Markov-style manner, where the probability of each letter is based on which letters
precede it.

library(universalmotif)
library(Biostrings)

## Create some DNA sequences for use with an external program (default
## is DNA):

sequences.dna <- create_sequences(seqnum = 500,

freqs = c(A=0.3, C=0.2, G=0.2, T=0.3))

width seq

## writeXStringSet(sequences.dna, "dna.fasta")
sequences.dna
#> DNAStringSet object of length 500:
#>
[1]
#>
[2]
#>
[3]
#>
[4]
#>
[5]
#>
#>
...
#> [496]
#> [497]
#> [498]
#> [499]
#> [500]

100 TTATCGACGGAACTAAGAAGATAGTTTTTGCAC...GTAAGAATATTTATAGCAATATTTAGAATACT
100 CCAAATTCGTTAATACTCTGATCCTAAAACCGT...TAAAGAATAATTGTGAGATGATTCGTCTAATA
100 TCGTATACGAAATCGCATTCGGTGACAACTGAT...ACTAGATATTATGGAAAAAATTTCCATTAAAA
100 GTAGATCGACTAGTATACGAACGCCGCCATTGT...GGCCCTATATTCAAATGTCCTCATCTGAGGCA
100 GAAATGACATATGAGATATCAGCACTGATCTTA...ACTTAAATCTCTTTGGCTGAGGGAGACATAAG
... ...
100 GGGCACAACGCAAAGCATACGAGATATTGGGTT...ACACCGCTTAACCTATGATGATCTTAAGATAT
100 CACGATCAATAACACCTAAGTTTAGTTGTATAA...TTCCATCACATCAGTCAACAGTGGCACTTTCC
100 CTCTTTTGTCCCGACGTTCTTGATGGCAAATGC...AAAATCGGATTTGTCTGTTATTCTATCTTCGA
100 CTCTTTAAAGCCAAAGAGTAGTAACGTATTTAA...CTTCCAGTCCCTTATGGTACGTCGGAATTAAT
100 ATAGTATTACTGCAAAGCGAATGAGAGCCAGTC...TTTACCACCACGTAATGTGCCAAGCAATAAAT

## Amino acid:

width seq

create_sequences(alphabet = "AA")
#> AAStringSet object of length 100:
#>
[1]
#>
[2]
#>
[3]
#>
[4]
#>
[5]
#>
...
#>
#> [96]
#> [97]
#> [98]

100 SSYMCESWEVCQDCHFSQAWAMLRPFRDRFESL...PINYGPYDKWIHYAFFACMWMIAASIPNIRML
100 ETFVGSCGYEMQQGLITCDERPNIKEGADGRTE...HIISDVKWHICVQRKQTKDDPENKGGEPCDQG
100 PAASSSICSQVHDMQVLGICDHASIKPGSTGCP...CTDHGCVINKGANWPTHTDGMTRYSDIIFFAY
100 SYDEFDTHFVKKAGRNPPQDVVLFNGKDIERVM...FERLSKIYMARAFCQQPVMDFNDWAWERQEKS
100 SVHDACSVHNNAYFRRGNTIMDQTWPLINIPNG...FHFQECVHVRSAEDNNQHYCQNMHHCGWGTDI
... ...
100 HLCTQYQYTFDLKWCVIHWAMNCAQWQPKWEHA...MCNVMTCCSLSECYTDEELRWRPLNATHMFHK
100 WSHPQNDTASKNSDGYSDVMPADHVSLHNCTAC...YRNMGDGMTTNIINIMEDNWDPFYGKCWTVKT
100 CFDMVYFHYQRLYKMRPQELEEQKCPSNWKTVG...DSGEFMEWVRNQCYCESSANSQHMAPPAMPVF

2

#> [99]
#> [100]

100 CHWSVSVIFLWWVDWLIQAANGFTWILISYPIE...HADCNRKCNSVFYDMEEAYMPDRMTSRNREHT
100 MQIPHWGCIPGVASCKFRHKMFRIAHFVVYEQF...KDVFSTNPQSCQADFTTRKSAQLTYFAPFLFD

## Any set of characters can be used

width seq

create_sequences(alphabet = paste0(letters, collapse = ""))
#> BStringSet object of length 100:
#>
#>
[1]
#>
[2]
#>
[3]
#>
[4]
#>
[5]
...
#>
#> [96]
#> [97]
#> [98]
#> [99]
#> [100]

100 undorsbqotgdrpdfjyulnhhmxhndxliix...uyfwscpfkorslmbooanfhxijocgwtuld
100 qaleioqtctekwsrqhlvyphhojafndzlsc...hrvwjzjvmffvatypmzfzabfnrwgxukau
100 pdvlywoanlhkxozxdcugmghnqmvsaoawi...kedlijeyeuuizdvdixohbvguyfbkllxs
100 znnmkjvztgcnqxdejxtxsnipgdvrrzret...xvsnddfwmcpbwovqkxxbhvpmcdruibzo
100 xzomwpciumostntqpwykkpxbltkzrjobv...tjqscfbcwczqxtzerysjdwylrfwfhwkl
... ...
100 kebyvzfinhrtmaukuzfwqqicvjwxvadfi...sxessueawospwgiqkqsxujabwnrmpjhn
100 jxvklyqvwvcicwffyfhtsrjesedkgohsb...itflhmbxvzfrplznctmurzbdlkuxfplf
100 leygrqxizckpvgbuhgbmfholvmhezcdyn...mtimtxdxiiqfywnovwvxljaxyxnbxqwc
100 fqiobpbqzdgfbtoornhwnhuwkdemalbwm...foqidegqpkgdgoiwhrlkygidrpkwfgey
100 ptgbskrmirjussuiwtzfbdduupnbrukrt...qbqmprponzusfqvlyrzkuetqyyikerfm

2.2 Calculating sequence background

Sequence backgrounds can be retrieved for DNA and RNA sequences with oligonucleotideFrequency()
from "Biostrings. Unfortunately, no such Biostrings function exists for other sequence alphabets. The
universalmotif package proves get_bkg() to remedy this. Similarly, the get_bkg() function can calculate
higher order backgrounds for any alphabet as well. It is recommended to use the original Biostrings for
very long (e.g. billions of characters) DNA and RNA sequences whenever possible though, as it is much faster
than get_bkg().
library(universalmotif)

klet

## Background of DNA sequences:
dna <- create_sequences()
get_bkg(dna, k = 1:2)
#> DataFrame with 20 rows and 3 columns
#>
#>
#> 1
#> 2
#> 3
#> 4
#> 5
#> ...
#> 16
#> 17
#> 18
#> 19
#> 20

<character> <numeric>
2509
A
2457
C
2579
G
2455
T
643
AA
...
...
636
GT
591
TA
576
TC
661
TG
605
TT

count probability
<numeric>
0.2509000
0.2457000
0.2579000
0.2455000
0.0649495
...
0.0642424
0.0596970
0.0581818
0.0667677
0.0611111

## Background of non DNA/RNA sequences:
qwerty <- create_sequences("QWERTY")
get_bkg(qwerty, k = 1:2)
#> DataFrame with 42 rows and 3 columns
#>

count probability

klet

3

#>
#> 1
#> 2
#> 3
#> 4
#> 5
#> ...
#> 38
#> 39
#> 40
#> 41
#> 42

<character> <numeric>
1629
E
1648
Q
1679
R
1687
T
1732
W
...
...
283
YQ
244
YR
261
YT
293
YW
262
YY

<numeric>
0.1629
0.1648
0.1679
0.1687
0.1732
...
0.0285859
0.0246465
0.0263636
0.0295960
0.0264646

2.3 Clustering sequences by k-let composition

One way to compare sequences is by k-let composition. The following example illustrates how one could go
about doing this using only the universalmotif package and base graphics.
library(universalmotif)

## Generate three random sets of sequences:
s1 <- create_sequences(seqnum = 20,

freqs = c(A = 0.3, C = 0.2, G = 0.2, T = 0.3))

s2 <- create_sequences(seqnum = 20,

freqs = c(A = 0.4, C = 0.4, G = 0.1, T = 0.1))

s3 <- create_sequences(seqnum = 20,

freqs = c(A = 0.2, C = 0.3, G = 0.3, T = 0.2))

## Create a function to get properly formatted k-let counts:
get_klet_matrix <- function(seqs, k, groupName) {
bkg <- get_bkg(seqs, k = k, merge.res = FALSE)
bkg <- bkg[, c("sequence", "klet", "count")]
bkg <- reshape(bkg, idvar = "sequence", timevar = "klet",

direction = "wide")

suppressWarnings(as.data.frame(cbind(Group = groupName, bkg)))

}

## Calculate k-let content (up to you what size k you want!):
s1 <- get_klet_matrix(s1, 4, 1)
s2 <- get_klet_matrix(s2, 4, 2)
s3 <- get_klet_matrix(s3, 4, 3)

# Combine everything into a single object:
sAll <- rbind(s1, s2, s3)

## Do the PCA:
sPCA <- prcomp(sAll[, -(1:2)])

## Plot the PCA:
plot(sPCA$x, col = c("red", "forestgreen", "blue")[sAll$Group], pch = 19)

4

This example could be improved by using tidyr::spread() instead of reshape() (the former is much faster),
and plotting the PCA using the ggfortify package to create a nicer ggplot2 plot. Feel free to play around
with different ways of plotting the data! Additionally, you could even try using t-SNE instead of PCA (such
as via the Rtsne package).

3 Shuffling

3.1 Shuffling sequences

When performing de novo motif searches or motif enrichment analyses, it is common to do so against a set of
background sequences. In order to properly identify consistent patterns or motifs in the target sequences,
it is important that there be maintained a certain level of sequence composition between the target and
background sequences. This reduces results which are derived purely from base differential letter frequency
biases.

In order to avoid these results, typically it desirable to use a set of background sequences which preserve a
certain k-let size (such as dinucleotide or trinucleotide frequencies in the case of DNA sequences). Though
for some cases a set of similar sequences may already be available for use as background sequences, usually
background sequences are obtained by shuffling the target sequences, while preserving a desired k-let size.
For this purpose, a commonly used tool is uShuffle (Jiang et al. 2008). The universalmotif package aims
to provide its own k-let shuffling capabilities for use within R via shuffle_sequences().
The universalmotif package offers three different methods for sequence shuffling: euler, markov and
linear. The first method, euler, can shuffle sequences while preserving any desired k-let size. Furthermore
1-letter counts will always be maintained. However due to the nature of the method, the first and last letters
will remain unshuffled. This method is based on the initial random Eulerian walk algorithm proposed by
Altschul and Erickson (1985) and the subsequent cycle-popping algorithm detailed by Propp and Wilson
(1998) for quickly and efficiently finding Eulerian walks.

The second method, markov can only guarantee that the approximate k-let frequency will be maintained, but
not that the original letter counts will be preserved. The markov method involves determining the original
k-let frequencies, then creating a new set of sequences which will have approximately similar k-let frequency.
As a result the counts for the individual letters will likely be different. Essentially, it involves a combination

5

−50510−6−4−20246PC1PC2of determining k-let frequencies followed by create_sequences(). This type of pseudo-shuffling is discussed
by Fitch (1983).

The third method linear preserves the original 1-letter counts exactly, but uses a more crude shuffling
technique. In this case the sequence is split into sub-sequences every k-let (of any size), which are then
re-assembled randomly. This means that while shuffling the same sequence multiple times with method
= "linear" will result in different sequences, they will all have started from the same set of k-length
sub-sequences (just re-assembled differently).

library(universalmotif)
library(Biostrings)
data(ArabidopsisPromoters)

## Potentially starting off with some external sequences:
# ArabidopsisPromoters <- readDNAStringSet("ArabidopsisPromoters.fasta")

euler <- shuffle_sequences(ArabidopsisPromoters, k = 2, method = "euler")
markov <- shuffle_sequences(ArabidopsisPromoters, k = 2, method = "markov")
linear <- shuffle_sequences(ArabidopsisPromoters, k = 2, method = "linear")
k1 <- shuffle_sequences(ArabidopsisPromoters, k = 1)

Let us compare how the methods perform:

o.letter <- get_bkg(ArabidopsisPromoters, 1)
e.letter <- get_bkg(euler, 1)
m.letter <- get_bkg(markov, 1)
l.letter <- get_bkg(linear, 1)

data.frame(original=o.letter$count, euler=e.letter$count,

markov=m.letter$count, linear=l.letter$count, row.names = DNA_BASES)

#>
#> A
#> C
#> G
#> T

original euler markov linear
17384
8081
7583
16952

17384 17384 17280
8195
7539
16952 16952 16986

8081 8081
7583 7583

o.counts <- get_bkg(ArabidopsisPromoters, 2)
e.counts <- get_bkg(euler, 2)
m.counts <- get_bkg(markov, 2)
l.counts <- get_bkg(linear, 2)

data.frame(original=o.counts$count, euler=e.counts$count,

markov=m.counts$count, linear=l.counts$count,
row.names = get_klets(DNA_BASES, 2))
original euler markov linear
6497
2714
2608
5549
2903
1291
1149
2729
2668
1162
1173

6893 6893
2614 2614
2592 2592
5276 5276
3014 3014
1376 1376
1051 1051
2621 2621
2734 2734
1104 1104
1176 1176

6100
2821
2522
5820
2736
1338
1252
2858
2611
1245
1148

#>
#> AA
#> AC
#> AG
#> AT
#> CA
#> CC
#> CG
#> CT
#> GA
#> GC
#> GG

6

#> GT
#> TA
#> TC
#> TG
#> TT

2561 2561
4725 4725
2977 2977
2759 2759
6477 6477

2529
5812
2788
2608
5762

2571
5295
2906
2649
6086

3.2 Local shuffling

If you have a fairly heterogeneous sequence and wish to preserve the presence of local “patches” of differential
sequence composition, you can set window = TRUE in the shuffle_sequences() function. In the following
example, the sequence of interest has an AT rich first half followed by a second half with an even background.
The impact on this specific sequence composition is observed after regular and local shuffling, using the
per-window functionality of get_bkg() (via window = TRUE). Fine-tune the window size and overlap between
windows with window.size and window.overlap.
library(Biostrings)
library(universalmotif)
library(ggplot2)

myseq <- DNAStringSet(paste0(

create_sequences(seqlen = 500, freqs = c(A=0.4, T=0.4, C=0.1, G=0.1)),
create_sequences(seqlen = 500)

))

myseq_shuf <- shuffle_sequences(myseq)
myseq_shuf_local <- shuffle_sequences(myseq, window = TRUE)

myseq_bkg <- get_bkg(myseq, k = 1, window = TRUE)
myseq_shuf_bkg <- get_bkg(myseq_shuf, k = 1, window = TRUE)
myseq_shuf_local_bkg <- get_bkg(myseq_shuf_local, k = 1, window = TRUE)

myseq_bkg$group <- "original"
myseq_shuf_bkg$group <- "shuffled"
myseq_shuf_local_bkg$group <- "shuffled-local"

myseq_all <- suppressWarnings(as.data.frame(

rbind(myseq_bkg, myseq_shuf_bkg, myseq_shuf_local_bkg)

))

ggplot(myseq_all, aes(x = start, y = probability, colour = klet)) +

geom_line() +
theme_minimal() +
scale_colour_manual(values = universalmotif:::DNA_COLOURS) +
xlab(element_blank()) +
facet_wrap(~group, ncol = 1)

#> Warning: `label` cannot be a <ggplot2::element_blank> object.

7

4 Sequence scanning and enrichment

There are many motif-programs available with sequence scanning capabilities, such as HOMER and tools
from the MEME suite. The universalmotif package does not aim to supplant these, but rather provide
convenience functions for quickly scanning a few sequences without needing to leave the R environment.
Furthermore, these functions allow for taking advantage of the higher-order (multifreq) motif format
described here.

Two scanning-related functions are provided: scan_sequences() and enrich_motifs(). The latter simply
runs scan_sequences() twice on a set of target and background sequences. Given a motif of length n,
scan_sequences() considers every possible n-length subset in a sequence and scores it using the PWM
format. If the match surpasses the minimum threshold, it is reported. This is case regardless of whether one
is scanning with a regular motif, or using the higher-order (multifreq) motif format (the multifreq matrix
is converted to a PWM).

4.1 Choosing a logodds threshold

Before scanning a set of sequences, one must first decide the minimum logodds threshold for retrieving
matches. This decision is not always the same between scanning programs out in the wild, nor is it usually
told to the user what the cutoff is or how it is decided. As a result, universalmotif aims to be as transparent
as possible in this regard by allowing for complete control of the threshold. For more details on PWMs, see
the introductory vignette.

Logodds thresholds

One way is to set a cutoff between 0 and 1, then multiplying the highest possible PWM score to get a
threshold. The matchPWM() function from the Biostrings package for example uses a default of 0.8 (shown

8

shuffled−localshuffledoriginal02505007500.10.20.30.40.10.20.30.40.10.20.30.4probabilitykletACGTas "80%"). This is quite arbitrary of course, and every motif will end up with a different threshold. For high
information content motifs, there is really no right or wrong threshold, as they tend to have fewer non-specific
positions. This means that incorrect letters in a match will be more punishing. To illustrate this, contrast
the following PWMs:

library(universalmotif)
m1 <- create_motif("TATATATATA", nsites = 50, type = "PWM", pseudocount = 1)
m2 <- matrix(c(0.10,0.27,0.23,0.19,0.29,0.28,0.51,0.12,0.34,0.26,
0.36,0.29,0.51,0.38,0.23,0.16,0.17,0.21,0.23,0.36,
0.45,0.05,0.02,0.13,0.27,0.38,0.26,0.38,0.12,0.31,
0.09,0.40,0.24,0.30,0.21,0.19,0.05,0.30,0.31,0.08),

byrow = TRUE, nrow = 4)

A

A

A

A

1.978626 -5.672425

1.978626 -5.672425

T
1.978626 -5.672425

T
1.978626 -5.672425

m2 <- create_motif(m2, alphabet = "DNA", type = "PWM")
m1["motif"]
T
T
#>
#> A -5.672425
1.978626 -5.672425
#> C -5.672425 -5.672425 -5.672425 -5.672425 -5.672425 -5.672425 -5.672425
#> G -5.672425 -5.672425 -5.672425 -5.672425 -5.672425 -5.672425 -5.672425
1.978626
#> T 1.978626 -5.672425
A
#>
T
#> A 1.978626 -5.672425
1.978626
#> C -5.672425 -5.672425 -5.672425
#> G -5.672425 -5.672425 -5.672425
#> T -5.672425
1.978626 -5.672425
m2["motif"]
#>
S
#> A -1.3219281
#> C 0.5260688
#> G 0.8479969 -2.33628339 -3.64385619 -0.9434165
#> T -1.4739312
N
N
R
#>
#> A 1.0430687 -1.0732490
0.4436067
#> C -0.5418938 -0.2658941 -0.1202942
0.5897160 -1.0588937
#> G 0.0710831
0.2486791
#> T -2.3074285

N
N
0.1491434
0.2141248
0.6040713 -0.1202942 -0.6582115
0.5897160
0.1110313
0.2630344 -0.2515388 -0.4102840

V
0.04222824
0.51171352
0.29598483
0.3103401 -1.65821148

N
0.09667602 -0.12029423 -0.3959287
1.02856915
0.19976951

0.66371661 -0.05889369

H

C

In the first example, sequences which do not have a matching base in every position are punished heavily.
The maximum logodds score in this case is approximately 20, and for each incorrect position the score is
reduced approximately by 5.7. This means that a threshold of zero would allow for at most three mismatches.
At this point, it is up to you how many mismatches you would deem appropriate.

P-values

This thinking becomes impossible for the second example. In this case, mismatches are much less punishing,
to the point that one could ask: what even constitutes a mismatch? The answer to this question is usually
much more difficult in such cases. An alternative to manually deciding upon a threshold is to instead start
with maximum P-value one would consider appropriate for a match. If, say, we want matches with a P-value of
at most 0.001, then we can use motif_pvalue() to calculate the appropriate threshold (see the comparisons
and P-values vignette for details on motif P-values).

motif_pvalue(m2, pvalue = 0.001)
#> [1] 4.858

9

Multiple testing-corrected P-values

This P-value can be further refined to correct for multiple testing (and becomes a Q-value). There are three
available corrections that can be set in scan_sequences(): Bonferroni (“bonferroni”), Benjamini & Hochberg
(“BH”), and the false discovery rate (“fdr”) based on the empirical null distribution of motif hits in a set of
sequences. They are excellently explained in Noble (2009), and these explanations will be briefly regurgitated
here.

To begin to understand how these different corrections are implemented, consider the following motif,
sequences, example P-value for an example motif hit, and the theoretical maximum number of motif hits:

library(universalmotif)
data(ArabidopsisMotif)
data(ArabidopsisPromoters)

(Example.Score <- score_match(ArabidopsisMotif, "TTCTCTTTTTTTTTT"))
#> [1] 16.81
(Example.Pvalue <- motif_pvalue(ArabidopsisMotif, Example.Score))
#> [1] 6.612819e-07

(Max.Possible.Hits <- sum(width(ArabidopsisPromoters) - ncol(ArabidopsisMotif) + 1))
#> [1] 49300

The first correction method, Bonferroni, is by far the simplest. To calculate it, take the P-value of a motif hit
and multiply it by the theoretical maximum number of hits:

(Example.bonferroni <- Example.Pvalue * Max.Possible.Hits)
#> [1] 0.0326012

As you can imagine, the level of punishment the P-value receives corresponds to the size of the sequences you
are scanning. If you are scanning an entire genome, then you can expect this to be very punishing and only
return near-perfect matches (or no matches). However for smaller sets of sequences this correction can be
more appropriate.

Next, Benjamini & Hochberg. To perform this correction, the P-value is divided by the percentile rank of the
P-value in the list of P-values for all theoretically possible hits sorted in ascending order (it also assumes that
P-values are normally distributed under the null hypothesis). It is important to note that this means the
correction cannot be calculated before the sequences have been scanned for the motif, and P-values have
been calculated for all returned hits. When requesting this type of Q-value for the minimum threshold of
score, scan_sequences() instead calculates the threshold from the input Q-value as a P-value, then filters
the final results after Q-values have been calculated. Returning to our example:

(Scan.Results <- scan_sequences(ArabidopsisMotif, ArabidopsisPromoters,

threshold = 0.8, threshold.type = "logodds", calc.qvals = FALSE))

sequence sequence.i

motif.i

#> DataFrame with 20 rows and 14 columns
#>
motif
#>
YTTTYTTTTTYTTTY
#> 1
YTTTYTTTTTYTTTY
#> 2
YTTTYTTTTTYTTTY
#> 3
YTTTYTTTTTYTTTY
#> 4
YTTTYTTTTTYTTTY
#> 5
#> ...
...
#> 16 YTTTYTTTTTYTTTY
#> 17 YTTTYTTTTTYTTTY
#> 18 YTTTYTTTTTYTTTY
#> 19 YTTTYTTTTTYTTTY

<character> <integer> <character>
AT1G05670
AT1G19510
AT1G49840
AT2G22500
AT2G22500
...
AT3G23170
AT4G19520
AT4G19520
AT4G27652

1
1
1
1
1
...
1
1
1
1

start

stop
<integer> <integer> <integer>
82
416
913
960
962
...
617
806
807
893

47
45
27
14
14
...
34
3
3
20

68
402
899
946
948
...
603
792
793
879

10

1

20

881

AT4G27652

<character>
15.407 GTTTCTTTTTTCTTT
17.405 TTTTCTTTTTCTTTT
15.177 CTTTTTGTTTTTTTC
15.827 TCCTCTCTTTCTCTC
15.908 CTCTCTTTCTCTCTT
...
15.734 GTTTCTTCTTTTTTT
15.352 TTTTTTTTTTTTTTT
15.352 TTTTTTTTTTTTTTT
16.410 TTTTCTCTTTTTTTT
16.810 TTCTCTTTTTTTTTT

895
match thresh.score min.score max.score score.pct
<numeric> <numeric> <numeric> <numeric>
82.0219
92.6586
80.7975
84.2579
84.6891
...
83.7628
81.7291
81.7291
87.3616
89.4911

15.0272
15.0272
15.0272
15.0272
15.0272
...
15.0272
15.0272
15.0272
15.0272
15.0272

-125.07
-125.07
-125.07
-125.07
-125.07
...
-125.07
-125.07
-125.07
-125.07
-125.07

18.784
18.784
18.784
18.784
18.784
...
18.784
18.784
18.784
18.784
18.784

...

score
<numeric>

#> 20 YTTTYTTTTTYTTTY
#>
#>
#> 1
#> 2
#> 3
#> 4
#> 5
#> ...
#> 16
#> 17
#> 18
#> 19
#> 20
#>
#>
#> 1
#> 2
#> 3
#> 4
#> 5
#> ...
#> 16
#> 17
#> 18
#> 19
#> 20

strand
<character>

...

pvalue
<numeric>
+ 3.95595e-06
+ 2.44369e-07
+ 5.01977e-06
+ 2.53853e-06
+ 2.39165e-06
...
+ 2.83419e-06
+ 4.33848e-06
+ 4.33848e-06
+ 1.23950e-06
+ 6.61282e-07

First we sort and calculate the percentile ranks of our P-values, and then divide the P-values:

Pvalues <- Scan.Results$pvalue
Pvalues.Ranks <- (rank(Pvalues) / Max.Possible.Hits) * 100
Qvalues.BH <- Pvalues / Pvalues.Ranks
(Example.BH <- Qvalues.BH[Scan.Results$match == "TTCTCTTTTTTTTTT"][1])
#> [1] 6.52024e-05

Finally, calculating the false discovery rate from the empirical distribution of scores. This method requires
some additional steps, as we must obtain the observed and null distributions of hits in our sequences. Then
for each hit, divide the number of hits with a score equal to or greater in the null distribution with the
number of hits with a score equal to or greater in the observed distribution. Along the way we must be
wary of the nonmonotonicity of the final Q-values (meaning that as scores get smaller the Q-value does not
always increase), and thus always select the minimum available Q-value as the score increases. To get the
null distribution of hits, we can simply use the P-values associated with each score as these are analytically
calculated from the null based on the background probabilities (see ?motif_pvalue).
Scan.Results <- Scan.Results[order(Scan.Results$score, decreasing = TRUE), ]
Observed.Hits <- 1:nrow(Scan.Results)
Null.Hits <- Max.Possible.Hits * Scan.Results$pvalue
Qvalues.fdr <- Null.Hits / Observed.Hits
Qvalues.fdr <- rev(cummin(rev(Qvalues.fdr)))
(Example.fdr <- Qvalues.fdr[Scan.Results$match == "TTCTCTTTTTTTTTT"][1])
#> [1] 0.00652024

Similarly to Benjamini & Hochberg, these can only be known after scanning has occurred.

To summarize, we can compare the initial P-value with the different corrections:

11

knitr::kable(
data.frame(

What = c("Score", "P-value", "bonferroni", "BH", "fdr"),
Value = format(

c(Example.Score, Example.Pvalue, Example.bonferroni, Example.BH, Example.fdr),
scientific = FALSE

)

),
format = "markdown", caption = "Comparing P-value correction methods"

)

Table 1: Comparing P-value correction methods

What

Value

Score
P-value
bonferroni
BH
fdr

16.8100000000000
0.0000006612819
0.0326011986749
0.0000652023973
0.0065202397350

Use your best judgement as to which method is most appropriate for your specific use case.

4.2 Regular and higher order scanning

Furthermore, the scan_sequences() function offers the ability to scan using the multifreq slot, if available.
This allows to take into account inter-positional dependencies, and get matches which more faithfully represent
the original sequences from which the motif originated.

library(universalmotif)
library(Biostrings)
data(ArabidopsisPromoters)

## A 2-letter example:

motif.k2 <- create_motif("CWWWWCC", nsites = 6)
sequences.k2 <- DNAStringSet(rep(c("CAAAACC", "CTTTTCC"), 3))
motif.k2 <- add_multifreq(motif.k2, sequences.k2)

Regular scanning:

scan_sequences(motif.k2, ArabidopsisPromoters, RC = TRUE,

threshold = 0.9, threshold.type = "logodds")

sequence sequence.i

motif

motif.i

#> DataFrame with 94 rows and 15 columns
#>
#>
#> 1
#> 2
#> 3
#> 4
#> 5
#> ...
#> 90
#> 91
#> 92

<character> <integer> <character>
AT1G03850
AT1G03850
AT1G03850
AT1G05670
AT1G06160
...
AT5G22690
AT5G22690
AT5G24660

motif
motif
motif
motif
motif
...
motif
motif
motif

1
1
1
1
1
...
1
1
1

stop

start

score
<integer> <integer> <integer> <numeric>
9.08
9.08
9.08
9.08
9.08
...
9.08
9.08
9.08

209
328
707
700
492
...
87
368
140

203
334
713
706
498
...
81
362
146

4
4
4
47
48
...
46
46
49

12

9.08
9.08

1
1

332
motif
motif
343
match thresh.score min.score max.score score.pct

16
16

AT5G58430
AT5G58430

338
349
strand
<numeric> <numeric> <numeric> <numeric> <character>
+
-
-
-
-
...
+
+
-
+
+

-19.649
-19.649
-19.649
-19.649
-19.649
...
-19.649
-19.649
-19.649
-19.649
-19.649

8.172
8.172
8.172
8.172
8.172
...
8.172
8.172
8.172
8.172
8.172

9.08
9.08
9.08
9.08
9.08
...
9.08
9.08
9.08
9.08
9.08

100
100
100
100
100
...
100
100
100
100
100

<character>
CTAATCC
CTTTTCC
CTTAACC
CTTTACC
CTAAACC
...
CAATACC
CAAATCC
CATTACC
CATAACC
CAAATCC
pvalue

#> 93
#> 94
#>
#>
#> 1
#> 2
#> 3
#> 4
#> 5
#> ...
#> 90
#> 91
#> 92
#> 93
#> 94
#>
#>
0.000976562
#> 1
0.000976562
#> 2
0.000976562
#> 3
0.000976562
#> 4
0.000976562
#> 5
#> ...
...
#> 90 0.000976562
#> 91 0.000976562
#> 92 0.000976562
#> 93 0.000976562
#> 94 0.000976562

qvalue
<numeric> <numeric>
1
1
1
1
1
...
1
1
1
1
1

Using 2-letter information to scan:

scan_sequences(motif.k2, ArabidopsisPromoters, use.freq = 2, RC = TRUE,

threshold = 0.9, threshold.type = "logodds")

stop

motif

start

motif.i

1
1
1
1
1
1
1
1

45
27
32
32
15
33
12
35

sequence sequence.i

score
<integer> <integer> <integer> <numeric>
17.827
17.827
17.827
17.827
17.827
17.827
17.827
17.827

<character> <integer> <character>
AT1G19510
AT1G49840
AT1G77210
AT1G77210
AT2G37950
AT3G57640
AT4G12690
AT4G14365

#> DataFrame with 8 rows and 15 columns
#>
#>
#> 1
#> 2
#> 3
#> 4
#> 5
#> 6
#> 7
#> 8
#>
#>
#> 1
#> 2
#> 3
#> 4
#> 5
#> 6
#> 7
#> 8

motif
960
motif
959
motif
184
motif
954
motif
751
motif
917
motif
938
977
motif
match thresh.score min.score max.score score.pct

965
964
189
959
756
922
943
982
strand
<numeric> <numeric> <numeric> <numeric> <character>
+
17.827
+
17.827
+
17.827
+
17.827
+
17.827
+
17.827
+
17.827
+
17.827

<character>
CTTTTC
CTTTTC
CAAAAC
CAAAAC
CAAAAC
CTTTTC
CAAAAC
CTTTTC

-16.842
-16.842
-16.842
-16.842
-16.842
-16.842
-16.842
-16.842

16.0443
16.0443
16.0443
16.0443
16.0443
16.0443
16.0443
16.0443

100
100
100
100
100
100
100
100

13

pvalue

qvalue
#>
#>
<numeric> <numeric>
#> 1 1.90735e-06 0.0236988
#> 2 1.90735e-06 0.0236988
#> 3 1.90735e-06 0.0236988
#> 4 1.90735e-06 0.0236988
#> 5 1.90735e-06 0.0236988
#> 6 1.90735e-06 0.0236988
#> 7 1.90735e-06 0.0236988
#> 8 1.90735e-06 0.0236988

Furthermore, sequence scanning can be further refined to avoid overlapping hits. Consider:

motif <- create_motif("AAAAAA")

## Leave in overlapping hits:

scan_sequences(motif, ArabidopsisPromoters, RC = TRUE, threshold = 0.9,

threshold.type = "logodds")

stop

start

motif

motif.i

sequence sequence.i

4
4
4
4
4
...
22
22
22
22
22

1
1
1
1
1
...
1
1
1
1
1

score
<integer> <integer> <integer> <numeric>
11.934
11.934
11.934
11.934
11.934
...
11.934
11.934
11.934
11.934
11.934

56
motif
57
motif
58
motif
59
motif
243
motif
...
...
589
motif
590
motif
591
motif
592
motif
motif
696
match thresh.score min.score max.score score.pct

51
52
53
54
248
...
594
595
596
597
701
strand
<numeric> <numeric> <numeric> <numeric> <character>
-
11.934
-
11.934
-
11.934
-
11.934
+
11.934
...
...
+
11.934
+
11.934
+
11.934
+
11.934
+
11.934

<character> <integer> <character>
AT1G03850
AT1G03850
AT1G03850
AT1G03850
AT1G03850
...
AT5G64310
AT5G64310
AT5G64310
AT5G64310
AT5G64310

#> DataFrame with 491 rows and 15 columns
#>
#>
#> 1
#> 2
#> 3
#> 4
#> 5
#> ...
#> 487
#> 488
#> 489
#> 490
#> 491
#>
#>
#> 1
#> 2
#> 3
#> 4
#> 5
#> ...
#> 487
#> 488
#> 489
#> 490
#> 491
#>
#>
#> 1
#> 2
#> 3
#> 4
#> 5
#> ...

qvalue
<numeric> <numeric>
0.000244141 0.0494745
0.000244141 0.0494745
0.000244141 0.0494745
0.000244141 0.0494745
0.000244141 0.0494745
...

<character>
AAAAAA
AAAAAA
AAAAAA
AAAAAA
AAAAAA
...
AAAAAA
AAAAAA
AAAAAA
AAAAAA
AAAAAA
pvalue

10.7406
10.7406
10.7406
10.7406
10.7406
...
10.7406
10.7406
10.7406
10.7406
10.7406

-39.948
-39.948
-39.948
-39.948
-39.948
...
-39.948
-39.948
-39.948
-39.948
-39.948

100
100
100
100
100
...
100
100
100
100
100

...

14

#> 487 0.000244141 0.0494745
#> 488 0.000244141 0.0494745
#> 489 0.000244141 0.0494745
#> 490 0.000244141 0.0494745
#> 491 0.000244141 0.0494745

## Only keep the highest scoring hit amongst overlapping hits:

scan_sequences(motif, ArabidopsisPromoters, RC = TRUE, threshold = 0.9,

threshold.type = "logodds", no.overlaps = TRUE)

stop

start

motif

motif.i

sequence sequence.i

1
1
1
1
1
...
1
1
1
1
1

4
4
4
47
47
...
22
22
22
22
22

score
<integer> <integer> <integer> <numeric>
11.934
11.934
11.934
11.934
11.934
...
11.934
11.934
11.934
11.934
11.934

56
motif
243
motif
735
motif
32
motif
78
motif
...
...
251
motif
342
motif
586
motif
592
motif
motif
696
match thresh.score min.score max.score score.pct

51
248
740
27
73
...
246
347
591
597
701
strand
<numeric> <numeric> <numeric> <numeric> <character>
-
11.934
+
11.934
+
11.934
-
11.934
-
11.934
...
...
-
11.934
+
11.934
+
11.934
+
11.934
+
11.934

<character> <integer> <character>
AT1G03850
AT1G03850
AT1G03850
AT1G05670
AT1G05670
...
AT5G64310
AT5G64310
AT5G64310
AT5G64310
AT5G64310

#> DataFrame with 220 rows and 15 columns
#>
#>
#> 1
#> 2
#> 3
#> 4
#> 5
#> ...
#> 216
#> 217
#> 218
#> 219
#> 220
#>
#>
#> 1
#> 2
#> 3
#> 4
#> 5
#> ...
#> 216
#> 217
#> 218
#> 219
#> 220
qvalue
#>
<numeric> <numeric>
#>
0.000244141 0.0494745
#> 1
0.000244141 0.0494745
#> 2
0.000244141 0.0494745
#> 3
0.000244141 0.0494745
#> 4
0.000244141 0.0494745
#> 5
#> ...
...
#> 216 0.000244141 0.0494745
#> 217 0.000244141 0.0494745
#> 218 0.000244141 0.0494745
#> 219 0.000244141 0.0494745
#> 220 0.000244141 0.0494745

<character>
AAAAAA
AAAAAA
AAAAAA
AAAAAA
AAAAAA
...
AAAAAA
AAAAAA
AAAAAA
AAAAAA
AAAAAA
pvalue

-39.948
-39.948
-39.948
-39.948
-39.948
...
-39.948
-39.948
-39.948
-39.948
-39.948

10.7406
10.7406
10.7406
10.7406
10.7406
...
10.7406
10.7406
10.7406
10.7406
10.7406

100
100
100
100
100
...
100
100
100
100
100

...

Finally, the results can be returned as a GRanges object for further manipulation:

15

motif.i sequence.i

score
<integer> <numeric>
9.08
9.08
9.08
9.08
9.08
...
9.08
9.08
9.08
9.08
9.08

4
4
4
47
48
...
46
46
49
16
16

pvalue
<numeric>
100 0.000976562
100 0.000976562
100 0.000976562
100 0.000976562
100 0.000976562
...
...
100 0.000976562
100 0.000976562
100 0.000976562
100 0.000976562
100 0.000976562

match thresh.score min.score max.score score.pct
<numeric> <numeric> <numeric> <numeric>

scan_sequences(motif.k2, ArabidopsisPromoters, RC = TRUE,

threshold = 0.9, threshold.type = "logodds",
return.granges = TRUE)

motif

seqnames

ranges strand |

+ |
- |
- |
- |
+ |
... .
+ |
- |
- |
+ |
+ |

motif
motif
motif
motif
motif
...
motif
motif
motif
motif
motif

[1] AT1G03850
[2] AT1G03850
[3] AT1G03850
[4] AT1G05670
[5] AT1G06160
...
...
[90] AT5G22690
[91] AT5G22690
[92] AT5G24660
[93] AT5G58430
[94] AT5G58430

<Rle> <IRanges>
203-209
328-334
707-713
700-706
956-962
...
362-368
52-58
140-146
332-338
343-349

<Rle> | <character> <integer>
1
1
1
1
1
...
1
1
1
1
1

#> GRanges object with 94 ranges and 11 metadata columns:
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>

[1]
[2]
[3]
[4]
[5]
...
[90]
[91]
[92]
[93]
[94]
-------
seqinfo: 50 sequences from an unspecified genome

<character>
CTAATCC
CTTTTCC
CTTAACC
CTTTACC
CTAATCC
...
CAAATCC
CATTACC
CATTACC
CATAACC
CAAATCC

qvalue
<numeric>
1
1
1
1
1
...
1
1
1
1
1

-19.649
-19.649
-19.649
-19.649
-19.649
...
-19.649
-19.649
-19.649
-19.649
-19.649

8.172
8.172
8.172
8.172
8.172
...
8.172
8.172
8.172
8.172
8.172

9.08
9.08
9.08
9.08
9.08
...
9.08
9.08
9.08
9.08
9.08

[1]
[2]
[3]
[4]
[5]
...
[90]
[91]
[92]
[93]
[94]

4.3 Visualizing motif hits across sequences

A few suggestions for different ways of plotting hits across sequences are presented here.

Using the ggbio package, it is rather trivial to generate nice visualizations of the output of scan_sequences().
This requires having the GenomicRanges and ggbio packages installed, and outputting the scan_sequences()
result as a GRanges object (via return.granges = TRUE).

16

library(universalmotif)
library(GenomicRanges)
library(ggbio)

data(ArabidopsisPromoters)

motif1 <- create_motif("AAAAAA", name = "Motif A")
motif2 <- create_motif("CWWWWCC", name = "Motif B")

res <- scan_sequences(c(motif1, motif2), ArabidopsisPromoters[1:10],

return.granges = TRUE, calc.pvals = TRUE, no.overlaps = TRUE,
threshold = 0.2, threshold.type = "logodds")

## Just plot the motif hits:
autoplot(res, layout = "karyogram", aes(fill = motif, color = motif)) +

theme(

strip.background = element_rect(fill = NA, colour = NA),
panel.background = element_rect(fill = NA, colour = NA)

)

#> Scale for x is already present.
#> Adding another scale for x, which will replace the existing scale.
#> Scale for x is already present.
#> Adding another scale for x, which will replace the existing scale.

## Plot Motif A hits by P-value:
autoplot(res[res$motif.i == 1, ], layout = "karyogram",
aes(fill = log10(pvalue), colour = log10(pvalue))) +
scale_fill_gradient(low = "black", high = "grey75") +
scale_colour_gradient(low = "black", high = "grey75") +
theme(

strip.background = element_rect(fill = NA, colour = NA),
panel.background = element_rect(fill = NA, colour = NA)

)

#> Scale for x is already present.
#> Adding another scale for x, which will replace the existing scale.
#> Scale for x is already present.
#> Adding another scale for x, which will replace the existing scale.

17

AT1G03850AT1G19380AT2G15390AT4G11370AT4G12970AT4G15760AT4G19520AT4G28150AT5G01810AT5G223900 bp200 bp400 bp600 bp800 bp1000 bpmotifMotif AMotif BAlternatively, just a simple heatmap with only ggplot2.
library(universalmotif)
library(ggplot2)

data(ArabidopsisMotif)
data(ArabidopsisPromoters)

res <- scan_sequences(ArabidopsisMotif, ArabidopsisPromoters,

threshold = 0, threshold.type = "logodds.abs")

res <- suppressWarnings(as.data.frame(res))
res$x <- mapply(function(x, y) mean(c(x, y)), res$start, res$stop)

ggplot(res, aes(x, sequence, fill = score)) +

scale_fill_viridis_c() +
scale_x_continuous(expand = c(0, 0)) +
xlim(0, 1000) +
xlab(element_blank()) +
ylab(element_blank()) +
geom_tile(width = ncol(ArabidopsisMotif)) +
theme_bw() +
theme(panel.grid = element_blank(), axis.text.y = element_text(size = 6))

#> Warning: `label` cannot be a <ggplot2::element_blank> object.
#> `label` cannot be a <ggplot2::element_blank> object.

18

AT1G03850AT1G19380AT2G15390AT4G11370AT4G12970AT4G15760AT4G19520AT4G28150AT5G01810AT5G223900 bp200 bp400 bp600 bp800 bp1000 bplog10(pvalue)−3.6−3.3−3.0−2.7−2.4Using packages such as ggExtra or ggpubr, one could even plot marginal histogram or density plots above or
below to illustrate any motif positional preference within the sequences. (Though keep in mind that the hit
coordinates and sequence lengths would need to be normalized if not all sequences were of the same length,
as they are here.)

Finally, the distribution of all possible motif scores could be shown as a line plot across the sequences.

library(universalmotif)
library(ggplot2)

data(ArabidopsisMotif)
data(ArabidopsisPromoters)

res <- scan_sequences(ArabidopsisMotif, ArabidopsisPromoters[1:5],

threshold = -Inf, threshold.type = "logodds.abs")

res <- suppressWarnings(as.data.frame(res))
res$position <- mapply(function(x, y) mean(c(x, y)), res$start, res$stop)

ggplot(res, aes(position, score, colour = score)) +

geom_line() +
geom_hline(yintercept = 0, colour = "red", alpha = 0.3) +
theme_bw() +
scale_colour_viridis_c() +
facet_wrap(~sequence, ncol = 1) +
xlab(element_blank()) +
ylab(element_blank()) +
theme(strip.background = element_blank())

#> Warning: `label` cannot be a <ggplot2::element_blank> object.

19

AT1G03850AT1G05670AT1G06160AT1G07490AT1G08090AT1G12990AT1G19380AT1G19510AT1G49120AT1G49840AT1G51700AT1G75490AT1G76590AT1G77210AT2G04025AT2G15390AT2G17450AT2G19810AT2G22500AT2G24240AT2G27690AT2G28140AT2G37950AT3G15610AT3G19200AT3G23170AT3G57640AT4G11370AT4G12690AT4G12970AT4G14365AT4G15760AT4G19520AT4G27652AT4G28150AT4G33467AT4G33970AT5G05090AT5G08790AT5G10210AT5G10695AT5G20200AT5G22390AT5G22690AT5G47230AT5G58430AT5G6431002505007501000score051015#> `label` cannot be a <ggplot2::element_blank> object.

4.4 Enrichment analyses

The universalmotif package offers the ability to search for enriched motif sites in a set of sequences via
enrich_motifs(). There is little complexity to this, as it simply runs scan_sequences() twice: once on a
set of target sequences, and once on a set of background sequences. After which the results between the two
sequences are collated and run through enrichment tests. The background sequences can be given explicitly,
or else enrich_motifs() will create background sequences on its own by using shuffle_sequences() on
the target sequences.

Let us consider the following basic example:

library(universalmotif)
data(ArabidopsisMotif)
data(ArabidopsisPromoters)

enrich_motifs(ArabidopsisMotif, ArabidopsisPromoters, shuffle.k = 3,

threshold = 0.001, RC = TRUE)

motif

#> DataFrame with 1 row and 15 columns
#>
#>
#> 1 YTTTYTTTTTYTTTY
#>
#>

<integer>
244
target.seq.count bkg.hits bkg.seq.hits bkg.seq.count
<integer>

motif.i motif.consensus target.hits target.seq.hits
<integer>
50

<character>
1 YTYTYTTYTTYTTTY

<character> <integer>

<integer> <integer>

<integer>

Pval
<numeric>

Qval
<numeric>

20

AT5G01810AT4G28150AT4G19520AT1G19380AT1G0385002505007501000−80−400−80−400−80−400−80−400−80−400score−80−40050

144

48

50 2.27389e-07 2.27389e-07

#> 1
#>
#>
<numeric>
#> 1 4.54779e-07

Eval pct.target.seq.hits pct.bkg.seq.hits target.enrichment
<numeric>
1.04167

<numeric>
96

<numeric>
100

Here we can see that the motif is significantly enriched in the target sequences. The Pval was calculated by
calling stats::fisher.test().
One final point: always keep in mind the threshold parameter, as this will ultimately decide the number of
hits found. (A bad threshold can lead to a false negative.)

4.5 Fixed and variable-length gapped motifs

universalmotif class motifs can be gapped, which can be used by scan_sequences() and enrich_motifs().
Note that gapped motif support is currently limited to these two functions. All other functions will ignore
the gap information, and even discard them in functions such as merge_motifs().
First, obtain the component motifs:

library(universalmotif)
data(ArabidopsisPromoters)

m1 <- create_motif("TTTATAT", name = "PartA")
m2 <- create_motif("GGTTCGA", name = "PartB")

Then, combine them and add the desired gap. In this case, a gap will be added between the two motifs which
can range in size from 4-6 bases.

Motif name:
Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:
Target sites:
Gap locations:
Gap sizes:

m <- cbind(m1, m2)
m <- add_gap(m, gaploc = ncol(m1), mingap = 4, maxgap = 6)
m
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
G G T T C G A
#> A 0 0 0 1 0 1 0 .. 0 0 0 0 0 0 1
#> C 0 0 0 0 0 0 0 .. 0 0 0 0 1 0 0
#> G 0 0 0 0 0 0 0 .. 1 1 0 0 0 1 0
#> T 1 1 1 0 1 0 1 .. 0 0 1 1 0 0 0

PartA/PartB
DNA
PCM
+-
28
0
TTTATAT..GGTTCGA
1
7-8
4-6

T T T A T A T

Now, it can be used directly in scan_sequences() or enrich_motifs():
scan_sequences(m, ArabidopsisPromoters, threshold = 0.4, threshold.type = "logodds")
#> DataFrame with 75 rows and 15 columns
#>
#>
#> 1
#> 2

score
<integer> <integer> <integer> <numeric>
11.178
12.168

<character> <integer> <character>
AT1G03850
PartA/PartB
AT1G03850
PartA/PartB

sequence sequence.i

motif.i

394
432

376
414

start

motif

stop

1
1

4
4

21

match thresh.score min.score max.score score.pct

AT1G06160
AT1G12990
AT1G19380
...
AT5G22690
AT5G47230
AT5G47230
AT5G64310
AT5G64310

48
28
2
...
46
24
24
22
22

144
71
226
...
638
91
449
869
909

161
90
245
...
656
110
468
888
927

11.918
11.428
11.428
...
11.178
12.418
11.428
11.428
11.178

strand
<numeric> <numeric> <numeric> <numeric> <character>
+
27.846
+
27.846
+
27.846
+
27.846
+
27.846
...
...
+
27.846
+
27.846
+
27.846
+
27.846
+
27.846

11.1384
11.1384
11.1384
11.1384
11.1384
...
11.1384
11.1384
11.1384
11.1384
11.1384

40.1422
43.6975
42.7997
41.0400
41.0400
...
40.1422
44.5953
41.0400
41.0400
40.1422

-93.212
-93.212
-93.212
-93.212
-93.212
...
-93.212
-93.212
-93.212
-93.212
-93.212

1
1
1
...
1
1
1
1
1

PartA/PartB
#> 3
PartA/PartB
#> 4
PartA/PartB
#> 5
#> ...
...
#> 71 PartA/PartB
#> 72 PartA/PartB
#> 73 PartA/PartB
#> 74 PartA/PartB
#> 75 PartA/PartB
#>
#>
<character>
#> 1
TATATGT.....GGTGCAA
#> 2
TTGATAT.....TGTTAGA
#> 3
TTTATGT....GGTTTGT
#> 4
GTTATGT......TGTTAGA
#> 5
TTTACAG......CGTTCGT
#> ...
...
TTCATTT.....GGCTTGA
#> 71
#> 72 TTTATAC......TGTTCCA
#> 73 TATATGT......GGGTCAA
#> 74 ATAATAT......CGTTAGA
TTCATAT.....GTCACGA
#> 75
qvalue
#>
<numeric>
#>
1.60187e-07 0.000105403
#> 1
1.60187e-07 0.000105403
#> 2
1.60187e-07 0.000105403
#> 3
1.60187e-07 0.000105403
#> 4
1.60187e-07 0.000105403
#> 5
...
#> ...
#> 71 1.60187e-07 0.000105403
#> 72 1.60187e-07 0.000105403
#> 73 1.60187e-07 0.000105403
#> 74 1.60187e-07 0.000105403
#> 75 1.60187e-07 0.000105403

pvalue
<numeric>

...

4.6 Detecting low complexity regions and sequence masking

Highly-repetitive low complexity regions can oftentimes cause problems during de novo motif discovery,
leading to obviously false motifs being returned. One way to get around this issue is to preemptively remove
or mask these regions. The universalmotif package includes a few functions which can help carry out this
task.

Using mask_seqs(), one can mask a specific pattern of letters in XStringSet objects. Consider the following
sequences:

library(universalmotif)
library(Biostrings)

Ex.seq <- DNAStringSet(c(

A = "GTTGAAAAAAAAAAAAAAAACAGACGT",
B = "TTAGATGGCCCATAGCTTATACGGCAA",
C = "AATAAAATGCTTAGGAAATCGATTGCC"

))

22

We can easily mask portions that contain, say, stretches of at least 8 As:
mask_seqs(Ex.seq, "AAAAAAAA")
#> DNAStringSet object of length 3:
#>
#> [1]
#> [2]
#> [3]

27 GTTG----------------CAGACGT
27 TTAGATGGCCCATAGCTTATACGGCAA
27 AATAAAATGCTTAGGAAATCGATTGCC

width seq

names
A
B
C

Alternatively, instead of masking a know stretch of letters one can find low complexity regions using
sequence_complexity(), and then mask specific regions in the sequences using mask_ranges(). The
sequence_complexity() function has several complexity metrics available: the Wootton-Federhen (Wootton
and Federhen 1993) and Trifonov (Trifonov 1990) algorithms (and their approximations) are well described
in Orlov and Potapov (2004), and DUST in Morgulis et al. (2006). See ?sequence_complexity for more
details.

(Ex.DUST <- sequence_complexity(Ex.seq, window.size = 10, method = "DUST",

return.granges = TRUE))

seqnames

#> GRanges object with 15 ranges and 1 metadata column:
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>

[1]
[2]
[3]
[4]
[5]
...
[11]
[12]
[13]
[14]
[15]
-------
seqinfo: 3 sequences from an unspecified genome

ranges strand | complexity
<numeric>
0.857143
4.000000
4.000000
0.428571
0.000000
...
0.285714
0.000000
0.000000
0.000000
0.000000

<Rle> <IRanges>
1-10
6-15
11-20
16-25
21-27
...
1-10
6-15
11-20
16-25
21-27

<Rle> |
* |
* |
* |
* |
* |
... .
* |
* |
* |
* |
* |

A
A
A
A
A
...
C
C
C
C
C

seqnames

Using the DUST algorithm, we can see there are a couple of regions which spike in the complexity score (for
this particular algorithm, more complex sequences converge towards zero). Now it is only a matter of filtering
for those regions and using mask_ranges().
(Ex.DUST <- Ex.DUST[Ex.DUST$complexity >= 3])
#> GRanges object with 2 ranges and 1 metadata column:
#>
#>
#>
#>
#>
#>
mask_ranges(Ex.seq, Ex.DUST)
#> DNAStringSet object of length 3:
#>
#> [1]
#> [2]
#> [3]

[1]
[2]
-------
seqinfo: 3 sequences from an unspecified genome

ranges strand | complexity
<numeric>
4
4

27 GTTGA---------------CAGACGT
27 TTAGATGGCCCATAGCTTATACGGCAA
27 AATAAAATGCTTAGGAAATCGATTGCC

<Rle> <IRanges>
6-15
11-20

<Rle> |
* |
* |

names
A
B
C

width seq

A
A

Now these sequences could be used directly with scan_sequences() or written to a fasta file using
Biostrings::writeXStringSet() for use with an external de novo motif discovery program such as MEME.

23

5 Motif discovery with MEME

Note: In the time since the inception of the run_meme() function, Spencer Nystrom (a contributor to
universalmotif) has created the memes package as a interface to much of the MEME suite.
It is fully
interoperable with the universalmotif package and provides a much more convenient way to run MEME
programs from within R. Install it from Bioconductor with BiocManager::install("memes").
The universalmotif package provides a simple wrapper to the powerful motif discovery tool MEME (Bailey
and Elkan 1994). To run an analysis with MEME, all that is required is a set of XStringSet class sequences
(defined in the Biostrings package), and run_meme() will take care of running the program and reading the
output for use within R.
The first step is to check that R can find the MEME binary in your $PATH by running run_meme() without any
parameters. If successful, you should see the default MEME help message in your console. If not, then you’ll
need to provide the complete path to the MEME binary. There are two options:
library(universalmotif)

## 1. Once per session: via `options()`

options(meme.bin = "/path/to/meme/bin/meme")

run_meme(...)

## 2. Once per run: via `run_meme()`

run_meme(..., bin = "/path/to/meme/bin/meme")

Now we need to get some sequences to use with run_meme(). At this point we can read sequences from disk
or extract them from one of the Bioconductor BSgenome packages.
library(universalmotif)
data(ArabidopsisPromoters)

## 1. Read sequences from disk (in fasta format):

library(Biostrings)

# The following `read*()` functions are available in Biostrings:
# DNA: readDNAStringSet
# DNA with quality scores: readQualityScaledDNAStringSet
# RNA: readRNAStringSet
# Amino acid: readAAStringSet
# Any: readBStringSet

sequences <- readDNAStringSet("/path/to/sequences.fasta")

run_meme(sequences, ...)

## 2. Extract from a `BSgenome` object:

library(GenomicFeatures)
library(TxDb.Athaliana.BioMart.plantsmart28)
library(BSgenome.Athaliana.TAIR.TAIR9)

# Let us retrieve the same promoter sequences from ArabidopsisPromoters:

24

gene.names <- names(ArabidopsisPromoters)

# First get the transcript coordinates from the relevant `TxDb` object:
transcripts <- transcriptsBy(TxDb.Athaliana.BioMart.plantsmart28,

by = "gene")[gene.names]

# There are multiple transcripts per gene, we only care for the first one
# in each:

transcripts <- lapply(transcripts, function(x) x[1])
transcripts <- unlist(GRangesList(transcripts))

# Then the actual sequences:

# Unfortunately this is a case where the chromosome names do not match
# between the two databases

seqlevels(TxDb.Athaliana.BioMart.plantsmart28)
#> [1] "1" "2" "3"
"4"
seqlevels(BSgenome.Athaliana.TAIR.TAIR9)
#> [1] "Chr1" "Chr2" "Chr3" "Chr4" "Chr5" "ChrM" "ChrC"

"Mt" "Pt"

"5"

# So we must first rename the chromosomes in `transcripts`:
seqlevels(transcripts) <- seqlevels(BSgenome.Athaliana.TAIR.TAIR9)

# Finally we can extract the sequences
promoters <- getPromoterSeq(transcripts,

BSgenome.Athaliana.TAIR.TAIR9,
upstream = 1000, downstream = 0)

run_meme(promoters, ...)

Once the sequences are ready, there are few important options to keep in mind. One is whether to conserve
the output from MEME. The default is not to, but this can be changed by setting the relevant option:
run_meme(sequences, output = "/path/to/desired/output/folder")

The second important option is the search function (objfun). Some search functions such as the default
classic do not require a set of background sequences, whilst some do (such as de). If you choose one of
the latter, then you can either let MEME create them for you (it will shuffle the target sequences) or you can
provide them via the control.sequences parameter.
Finally, choose how you’d like the data imported into R. Once the MEME program exits, run_meme() will import
the results into R with read_meme(). At this point you can decide if you want just the motifs themselves
(readsites = FALSE) or if you’d like the original sequence sites as well (readsites = TRUE, the default).
Doing the latter gives you the option of generating higher order representations for the imported MEME motifs
as shown here:

motifs <- run_meme(sequences)
motifs.k23 <- mapply(add_multifreq, motifs$motifs, motifs$sites)

There are a wealth of other MEME options available, such as the number of desired motifs (nmotifs), the
width of desired motifs (minw, maxw), the search mode (mod), assigning sequence weights (weights), using a
custom alphabet (alph), and many others. See the output from run_meme() for a brief description of the
options, or visit the online manual for more details.

25

6 Miscellaneous string utilities

Since biological sequences are usually contained in XStringSet class objects, sequence_complexity(),
get_bkg() and shuffle_sequences() are designed to work with such objects. For cases when strings are
not XStringSet objects, the following functions are available:

• calc_complexity(): alternative to sequence_complexity()
• count_klets(): alternative to get_bkg()
• shuffle_string(): alternative to shuffle_sequences()

library(universalmotif)

string <- "DASDSDDSASDSSA"

calc_complexity(string)
#> [1] 0.7823323

count_klets(string, 2)
klets counts
#>
0
#> 1
0
#> 2
2
#> 3
1
#> 4
1
#> 5
3
#> 6
2
#> 7
3
#> 8
1
#> 9

AA
AD
AS
DA
DD
DS
SA
SD
SS

shuffle_string(string, 2)
#> [1] "DDSSDSDASDSASA"

A few other utilities have also been made available (based on the internal code of other universalmotif
functions) that work on simple character vectors:

• calc_windows(): calculate the coordinates for sliding windows from 1 to any number n
• get_klets(): get a list of all possible k-lets for any sequence alphabet
• slide_fun(): apply a function over sliding windows across a single string
• window_string(): retrieve characters from sliding windows of a single string

library(universalmotif)

calc_windows(n = 12, window = 4, overlap = 2)
#>
#> 1
#> 2
#> 3
#> 4
#> 5

start stop
4
1
6
3
8
5
10
7
12
9

get_klets(c("A", "S", "D"), 2)
#> [1] "AA" "AS" "AD" "SA" "SS" "SD" "DA" "DS" "DD"

slide_fun("ABCDEFGH", charToRaw, raw(2), window = 2, overlap = 1)
#>
#> [1,]

[,1] [,2] [,3] [,4] [,5] [,6] [,7]
47

46

42

44

41

43

45

26

#> [2,]

42

43

44

45

46

47

48

window_string("ABCDEFGH", window = 2, overlap = 1)
#> [1] "AB" "BC" "CD" "DE" "EF" "FG" "GH"

Session info

LAPACK version 3.12.0

methods

stats

graphics

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
#>
#> locale:
#> [1] LC_CTYPE=en_US.UTF-8
#> [3] LC_TIME=en_GB
#> [5] LC_MONETARY=en_US.UTF-8
#> [7] LC_PAPER=en_US.UTF-8
#> [9] LC_ADDRESS=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4
#> [8] base
#>
#> other attached packages:
#> [1] ggbio_1.58.0
#> [4] dplyr_1.1.4
#> [7] MotifDb_1.52.0
#> [10] Seqinfo_1.0.0
#> [13] S4Vectors_0.48.0
#> [16] universalmotif_1.28.0
#>
#> loaded via a namespace (and not attached):
[1] RColorBrewer_1.1-3
#>
[3] jsonlite_2.0.0
#>
[5] GenomicFeatures_1.62.0
#>
[7] rmarkdown_2.30
#>
#>
[9] BiocIO_1.20.0
#> [11] memoise_2.0.1
#> [13] Rsamtools_2.26.0
#> [15] base64enc_0.1-3
#> [17] htmltools_0.5.8.1
#> [19] curl_7.0.0
#> [21] Formula_1.2-5
#> [23] htmlwidgets_1.6.4
#> [25] cachem_1.1.0
#> [27] lifecycle_1.0.4

rstudioapi_0.17.1
magrittr_2.0.4
farver_2.1.2
fs_1.6.6
vctrs_0.6.5
Cairo_1.7-0
RCurl_1.98-1.17
tinytex_0.57
S4Arrays_1.10.0
SparseArray_1.10.0
gridGraphics_0.5-1
plyr_1.8.9
GenomicAlignments_1.46.0
pkgconfig_2.0.3

TFBSTools_1.48.0
ggtree_4.0.1
GenomicRanges_1.62.0
XVector_0.50.0
BiocGenerics_0.56.0

grDevices utils

datasets

cowplot_1.2.0
ggplot2_4.0.0
Biostrings_2.78.0
IRanges_2.44.0
generics_0.1.4

27

#> [29] Matrix_1.7-4
#> [31] fastmap_1.2.0
#> [33] digest_0.6.37
#> [35] colorspace_2.1-2
#> [37] OrganismDbi_1.52.0
#> [39] patchwork_1.3.2
#> [41] RSQLite_2.4.3
#> [43] labeling_0.4.3
#> [45] abind_1.4-8
#> [47] bit64_4.6.0-1
#> [49] withr_3.0.2
#> [51] htmlTable_2.4.3
#> [53] BiocParallel_1.44.0
#> [55] MASS_7.3-65
#> [57] DelayedArray_0.36.0
#> [59] gtools_3.9.5
#> [61] tools_4.5.1
#> [63] foreign_0.8-90
#> [65] ggseqlogo_0.2
#> [67] glue_1.8.0
#> [69] nlme_3.1-168
#> [71] checkmate_2.3.3
#> [73] reshape2_1.4.4
#> [75] gtable_0.3.6
#> [77] ensembldb_2.34.0
#> [79] data.table_1.17.8
#> [81] stringr_1.5.2
#> [83] treeio_1.34.0
#> [85] rtracklayer_1.70.0
#> [87] biovizBase_1.58.0
#> [89] tidyselect_1.2.1
#> [91] fontLiberation_0.1.0
#> [93] fontBitstreamVera_0.1.1
#> [95] grImport2_0.3-3
#> [97] ProtGenerics_1.42.0
#> [99] xfun_0.54
#> [101] matrixStats_1.5.0
#> [103] stringi_1.8.7
#> [105] ggfun_0.2.0
#> [107] evaluate_1.0.5
#> [109] cigarillo_1.0.0
#> [111] tibble_3.3.0
#> [113] BiocManager_1.30.26
#> [115] cli_3.6.5
#> [117] systemfonts_1.3.1
#> [119] dichromat_2.0-0.1
#> [121] png_0.1-8
#> [123] parallel_4.5.1
#> [125] jpeg_0.1-11
#> [127] bitops_1.0-9
#> [129] viridisLite_0.4.2
#> [131] VariantAnnotation_1.56.0
#> [133] scales_1.4.0
#> [135] purrr_1.1.0

R6_2.6.1
MatrixGenerics_1.22.0
aplot_0.2.9
TFMPvalue_0.0.9
AnnotationDbi_1.72.0
Hmisc_5.2-4
seqLogo_1.76.0
httr_1.4.7
compiler_4.5.1
fontquiver_0.2.1
backports_1.5.0
S7_0.2.0
DBI_1.2.3
rappdirs_0.3.3
rjson_0.2.23
caTools_1.18.3
splitstackshape_1.4.8
ape_5.8-1
nnet_7.3-20
restfulr_0.0.16
grid_4.5.1
cluster_2.1.8.1
ade4_1.7-23
BSgenome_1.78.0
tidyr_1.3.1
pillar_1.11.1
yulab.utils_0.2.1
lattice_0.22-7
bit_4.6.0
RBGL_1.86.0
DirichletMultinomial_1.52.0
knitr_1.50
gridExtra_2.3
bookdown_0.45
SummarizedExperiment_1.40.0
Biobase_2.70.0
UCSC.utils_1.6.0
lazyeval_0.2.2
yaml_2.3.10
codetools_0.2-20
gdtools_0.4.4
graph_1.88.0
ggplotify_0.1.3
rpart_4.1.24
GenomeInfoDb_1.46.0
Rcpp_1.1.0
XML_3.99-0.19
blob_1.2.4
AnnotationFilter_1.34.0
pwalign_1.6.0
tidytree_0.4.6
ggiraph_0.9.2
motifStack_1.54.0
crayon_1.5.3

28

#> [137] rlang_1.1.6

KEGGREST_1.50.0

References

Altschul, Stephen F., and Bruce W. Erickson. 1985. “Significance of Nucleotide Sequence Alignments: A
Method for Random Sequence Permutation That Preserves Dinucleotide and Codon Usage.” Molecular
Biology and Evolution 2 (6): 526–38.

Bailey, T. L., and C. Elkan. 1994. “Fitting a Mixture Model by Expectation Maximization to Discover Motifs
in Biopolymers.” Proceedings of the Second International Conference on Intelligent Systems for Molecular
Biology 2: 28–36.

Fitch, Walter M. 1983. “Random Sequences.” Journal of Molecular Biology 163 (2): 171–76.

Jiang, M., J. Anderson, J. Gillespie, and M. Mayne. 2008. “uShuffle: A Useful Tool for Shuffling Biological
Sequences While Preserving K-Let Counts.” BMC Bioinformatics 9 (192).

Morgulis, A., E. M. Gertz, A. A. Schaffer, and R. Agarwala. 2006. “A Fast and Symmetric DUST
Implementation to Mask Low-Complexity Dna Sequences.” Journal of Computational Biology 13: 1028–40.

Noble, William S. 2009. “How Does Multiple Testing Correction Work?” Nature Biotechnology 27 (12):
1135–7.

Orlov, Y. L., and V. N. Potapov. 2004. “Complexity: An Internet Resource for Analysis of DNA Sequence
Complexity.” Nucleic Acids Research 32: W628–W633.

Propp, J. G., and D. W. Wilson. 1998. “How to Get a Perfectly Random Sample from a Generic Markov
Chain and Generate a Random Spanning Tree of a Directed Graph.” Journal of Algorithms 27: 170–217.

Trifonov, E. N. 1990. “Making Sense of the Human Genome.” In Structure & Methods, edited by R. H. Sarma,
69–77. Albany: Adenine Press.

Wootton, J. C., and S. Federhen. 1993. “Statistics of Local Complexity in Amino Acid Sequences and
Sequence Databases.” Computers & Chemistry 17: 149–63.

29

