Suffix Array Kernel Smoothing for de novo discovery of
correlative sequence motifs and multi-motif domains:
the sarks package

Dennis Wylie, Hans A. Hofmann, Boris V. Zemelman

October 30, 2025

This vignette describes the R interface sarks to the java implementation of the Suffix Array
Kernel Smoothing, or SArKS, algorithm for identification of correlative motifs and multi-
motif domains (MMDs).

If you use sarks in your work, please cite Wylie et al. [2019] (see references).

Contents

1 How to install sarks

2

2 How to use sarks

2.1 Starting sarks . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
Input . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2
SArKS run parameters . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2.1
2.3 Output . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.3.1
k-mers . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.3.2 Reducing redundancy in peaks . . . . . . . . . . . . . . . . . . . . . .
Suffix arrays . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.3.3
. . . . . . . . . . . . . . . . . .
2.3.4 Window averaging (kernel smoothing)

2
2
2
4
5
5
7
8
9
2.4 Permutations and thresholds . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
2.4.1 Gini impurity filter . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
2.4.2 Multithreading sarks permutational analyses . . . . . . . . . . . . . . 12
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
. . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
. . . . . . . . . . . . . . . . . . 15

2.5 Spatial smoothing
2.6 Varying SArKS parameters
2.7 Clustering similar k-mers into broader motifs

3 How sarks works

17
3.1 Sarks constructor . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
catSeq . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
sa . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
saInv . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
scores . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
windowed . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
spatialWindowed . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18

3.1.1
3.1.2
3.1.3
3.1.4
3.1.5
3.1.6

1

3.2.1

3.1.7
3.1.8

windGini . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
spatGini . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
3.2 permutationDistribution . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
in sarks . . . . . . . . . . . . . . . . . . . . . . . 21
3.3 permutationThresholds . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21
3.4 kmerPeaks . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21
3.5 mergedKmerSubPeaks . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
3.6 estimateFalsePositiveRate . . . . . . . . . . . . . . . . . . . . . . . . . . . 23

Specification of g(α)
min

4 Session Info

5 Notation glossary

References

1 How to install sarks

24

26

27

The sarks package relies on Java (1.8 or greater) through use of the rJava package. Once
both of these are installed and correctly configured, you can install sarks by running the
following code within an R session:

> if(!requireNamespace("BiocManager", quietly = TRUE))
+
> BiocManager::install("sarks")

install.packages("BiocManager")

2 How to use sarks

2.1 Starting sarks

Because sarks is implemented using rJava, and because the default setting for the java
virtual machine (JVM) heap space with rJava is quite low, you should initialize java with
increased heap size before loading sarks (or any other rJava-dependent R packages):

## sets to 8 gigabytes: modify as needed

> options(java.parameters = '-Xmx8G')
> library(rJava)
> .jinit()
> ## ---------------------------------------------------------------------
> ## once you've set the java.parameters and then called .jinit from rJava
> ## (making sure not to load any other rJava-dependent packages prior to
> ## initializing the JVM with .jinit!),
> ## you are now ready to load the sarks library:
> ## ---------------------------------------------------------------------
> library(sarks)

2.2

Input

Aside from the specification of a few analysis parameters to be discussed below, sarks
requires two pieces of input data:

sequences which may be specified as either a:

2

FASTA formatted text file (may be gzipped) or, equivalently, a

named character vector

scores which may be specified as either a:

named numeric vector (with names matching those of input sequences) or a

tsv two-column tab-delimited file (containing header line), with columns

1. containing names matching those of input sequences and

2. containing numeric scores assigned to those sequences

For the purposes of this vignette, we’ll take the sequences to be the named character vector
simulatedSeqs included in the sarks package. simulatedSeqs is a character vector of
length 30—representing 30 different (fake) DNA sequences—each 250 characters in length:

> options(continue=" ")
> data(simulatedSeqs)
> length(simulatedSeqs)

[1] 30

## for vignette formatting, can be ignored

> table(nchar(simulatedSeqs))

250
30

Take a look at the first few characters of each sequence:

> vapply(simulatedSeqs, function(s) {paste0(substr(s, 1, 10), '...')}, '')

0

5

7

6

3

2

1

10

4
"GCGGAGGCTG..." "CGTTGAATGT..." "AGTCAGTTCT..." "AGAGCTTCAG..." "GTTTCTGCCC..."
9
"CTAAGGGCGA..." "ATTAGGTAAA..." "GCTCGGAGGA..." "TTCCTGCCTA..." "ACAATCTGCG..."
14
"CCACAGCGTT..." "TGACGACGCG..." "GCGCACTAGC..." "TCAAAGTAGG..." "GGTACAATCA..."
19
"TATGACACCG..." "CACTCGTATG..." "TGGTCTCGAC..." "GTCTCCCCGA..." "TACGAGGCTC..."
24
"CGGACGCGTG..." "GATGTGCCAT..." "TGAAAGGAGA..." "TAATGTAATG..." "CATCGAGATG..."
29
"CATACTGAGA..." "ACCAACAGTC..." "GCACGACAAA..." "GAAACAGAGG..." "GTTGATCTCA..."

12

13

22

17

18

23

27

28

11

15

16

20

21

25

26

8

Notice that the names of the simulated sequences are just the (string representations of) the
numbers "0" through "29".

Now let’s look at the simulatedScores:

> data(simulatedScores)
> simulatedScores

0
0

1 2
0 0

3 4
0 0

5 6
0 0

7 8
0 0

9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
1 1
0 0

0 0

0 0

0 0

0 0

1 1

1 1

0

3

26 27 28 29
1
1 1

1

Let’s check that the names of the scores match those of the sequences:

> all(names(simulatedScores) == names(simulatedSeqs))

[1] TRUE

Looking back at the scores themselves, note that for this simple illustrative example the
scores are just defined to be 0 for the first 20 sequences ("0"–"19") and 1 for the last 10
sequences ("20"–"29").

Note regarding SArKS input: the scores input to SArKS are not required to be positive, nor
are they required to be integers. Similarly, the sequences input to SArKS do not have to
use the DNA alphabet.

2.2.1 SArKS run parameters

Aside from input of data in the form of sequences with matching scores, sarks also requires
specification of run parameters halfWindow, spatialLength, and minGini.

I would recommend that users try several (2-4) values of halfWindow and, if interested in spa-
tial smoothing, spatialLength, using the method described in 2.6 below. For halfWindow,
you might start with halfWindow values on the order of

halfWindow ∈

(cid:110) n
20

,

n
10

,

n
5

(cid:111)

(1)

where n is the number of input sequences.

To get a sense of the intuition behind the values in (1): If we take halfWindow= n
20
full smoothing window of size 2*halfWindow+1 ≈ n
10
which would be expected to occur about once in every 10 input sequences.

, we get a
, which amounts to looking for motifs

The user should of course feel free to vary these fractions in either direction based on his
or her own data and goals! Especially if the number n of input sequences is very high, so
that n
is very large (say, in the thousands or more), these halfWindow values may be larger
20
than optimal.

Another consideration to keep in mind when choosing halfWindow values is that there is a
link between n, the average sequence length |w|, halfWindow, the size (really entropy) of the
sequence alphabet and the length ˆk of the k-mer motif sequences sarks is likely to detect.
Assuming an approximately uniformly distributed alphabet (often not a valid assumption
in practice) of a distinct characters:

ˆk ≈ loga

n ∗ |w|
halfWindow

(2)

should give a very rough sense of what length the motifs returned are likely to have (though
when employing spatial smoothing with merging of consecutive motifs, this will be less
accurate). Equation (2) is mosly useful for understanding how changes to halfWindow are
likely to impact output k-mer lengths, not truly predicting the exact lengths which will be
seen.

4

Aside from the trivial value of spatialLength=0 used to turn off spatial smoothing entirely,
it is a bit more difficult to provide general guidelines for spatialLength. Small values (say,
3–10) can be useful to help detect individual motifs even when no larger spatial structure
is really expected; in Wylie et al. [2019] we also tried spatialLength=100 when studying
regulation of gene expression as that is on the order of the low end of the length of DNA
enhancer regions. Users should feel free to experiment with spatialLength values that
make sense in their own applications.

Finally, for minGini, my current advice would be to start with the value minGini=1.1 (or
minGini=0 to see what happens without this filter). Interested users should consult sections
2.4.1 and 3.2 (especially 3.2.1) as well as Wylie et al. [2019] to get a better understanding
of what this parameter does in order to get a sense of how they might choose better values
for their own applications.

2.3 Output

sarks then aims to identify short sequence motifs, and potentially longer sequence domains
enriched in such motifs (MMDs), where the occurrence of the identified motifs in the input
sequences is correlated with the numeric scores assigned to the sequences.

Let’s consider a minimal sarks workflow (which we’ll discuss in more detail below) to
illustrate the way in which this output is constructed):

> sarks <- Sarks(simulatedSeqs, simulatedScores, halfWindow=4)
> filters <- sarksFilters(halfWindow=4, spatialLength=0, minGini=1.1)
> permDist <- permutationDistribution(sarks, reps=250, filters, seed=123)
> thresholds <- permutationThresholds(filters, permDist, nSigma=2.0)
> peaks <- kmerPeaks(sarks, filters, thresholds)
> peaks[ , c('i', 's', 'block', 'wi', 'kmer', 'windowed')]

1

wi
ATACTGAG
24 175
ATACTGAGA
21 31
22 195 ATACTGAGA
25
ATACTGAGA
20 193 ATACTGAGA
ATACTGAG
29 73
21 30 CATACTGAGA
22 194 CATACTGAGA
0 CATACTGAGA
25
TACTGAG
24 176
TACTGAGA
21
32
TACTGAGA
22 196
TACTGAGA
2
25

kmer windowed
1
1
1
1
1
1
1
1
1
1
1
1
1

i

s block

1458 4442
1
1459 3545
2
1460 3960
3
1461 4519
4
1462 3456
5
1463 5595
6
2256 3544
7
2257 3959
8
2258 4518
9
10 5862 4443
11 5863 3546
12 5864 3961
13 5865 4520

2.3.1

k-mers

For now let’s focus specifically on the column peaks$kmer, which tells us that SArKS has
identified

> unique(peaks$kmer)

5

[1] "ATACTGAG"

"ATACTGAGA"

"CATACTGAGA" "TACTGAG"

"TACTGAGA"

as k-mers whose occurrence in simulatedSeqs is associated with higher values of simulatedScores.
sarks provides a convenience function kmerCounts:

> kmerCounts(unique(peaks$kmer), simulatedSeqs)

ATACTGAG ATACTGAGA CATACTGAGA TACTGAG TACTGAGA
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
1
1
1
1
1
1
1
1
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
1
1
1
1
1
1
1
1
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
1
1
1
1
1
1
1
1
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
1
1
1
1
1
1
1
1
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
1
1
1
1
1
1
1
1
1

0
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

which shows us that each of the identified k-mers appears exactly once in each of the higher-
scoring sequences ("20"-"29") and never in any of the lower-scoring sequences. Looking a
bit more closely at the specific k-mers identified here, you can see that they are all substrings
of the longest one, the 10-mer "CATACTGAGA", so that the perfect agreement between the
columns of the kmerCounts output above are perhaps to be expected. sarks provides
functionality to help to identify such situations and simplify the output, as discussed further
in section 2.3.2 below.

First let’s go back to the output peaks from the call to kmerPeaks (focusing on the 8th row
of peaks):

6

> peak8 = peaks[8, ]
> peak8[ , c('i', 's', 'block', 'wi', 'kmer', 'windowed')]

i
8 2257 3959

s block

wi

22 194 CATACTGAGA

kmer windowed
1

and consider the columns:

i suffix array index

s suffix array value si
block the name of the input sequence from which the indicated k-mer is derived

wi the (0-based!) position ωi of the k-mer within the indicated block/sequence
Considering block and wi first, this tells us that, setting

> block <- simulatedSeqs[[peak8$block]]
> kmerStart <- peak8$wi + 1
> kmerEnd <- kmerStart + nchar(peak8$kmer) - 1

(noting the + 1 required to define kmerStart in 1-based R relative to 0-based wi) we should
find that

> substr(block, kmerStart, kmerEnd)

[1] "CATACTGAGA"

yields the same value as

> peak8$kmer

[1] "CATACTGAGA"

2.3.2 Reducing redundancy in peaks

In cases such as "CATACTGAGA" in the simulated data set analyzed here, sarks can simplify
k-mer output using a couple of auxiliary functions:

> nonRedundantPeaks <- mergedKmerSubPeaks(sarks, filters, thresholds)
> nonRedundantPeaks[ , c('i', 's', 'block', 'wi', 'kmer', 'windowed')]

s block

i
1 1462 3456
2 2256 3544
3 2257 3959
4 1458 4442
5 2258 4518
6 1463 5595

wi

20 193 ATACTGAGA
21 30 CATACTGAGA
22 194 CATACTGAGA
ATACTGAG
24 175
0 CATACTGAGA
25
ATACTGAG
29 73

kmer windowed
1
1
1
1
1
1

Here mergedKmerSubPeaks removes redundant k-mer output where multiple k-mer peaks
are reported with successive spatial s coordinates (e.g., the reported peak peaks[3, ]
from block="22" at wi=195 and kmer="ATACTGAGA" immediately follows peaks[8, ] with
block="22" and wi=194 and kmer="CATACTGAGA", and is thus merged with that peak).

Further simplification is still possible in this case using:

7

> extendedPeaks <- extendKmers(sarks, nonRedundantPeaks)
> extendedPeaks[ , c('i', 's', 'block', 'wi', 'kmer', 'windowed')]

s block

i
1 2259 3455
2 2256 3544
3 2257 3959
4 2255 4441
5 2258 4518
6 2260 5594

wi

20 192 CATACTGAGA
21 30 CATACTGAGA
22 194 CATACTGAGA
24 174 CATACTGAGA
0 CATACTGAGA
25
29 72 CATACTGAGA

kmer windowed
NA
1
1
NA
1
NA

which detects, for example, that even though the full occurrence of "CATACTGAGA" in in-
put sequence "24" was not reported as a k-mer by SArKS, the k-mer "ACACTGAG" in
nonRedundantPeaks[4, ] is flanked in sequence "24" by a "C" to the left and an "A"
to the right and can hence be extended to math the full motif.

2.3.3 Suffix arrays

How are we to interpret the columns i and s in peaks? This requires understanding a bit
more about SArKS: Specifically, that the method begins by concatenating all of the input
sequences into one big string (called catSeq in the underlying java object referenced by
sarks):

> concatenated <- sarks$getCatSeq()
> nchar(concatenated)

[1] 7530

concatenated is actually a bit longer than the sum of the lengths of the input sequences
because it keeps track of where one sequence ends and another begins using a special (dollar-
sign) character. In this way, concatenated is divided into separate “blocks,” each corre-
sponding to one of the input sequences.

The column s in peaks then gives us the (0-based!) position of the annotated k-mer in the
concatenated sequence:

> kmerCatStart <- peak8$s + 1
> kmerCatEnd <- kmerCatStart + nchar(peak8$kmer) - 1
> substr(concatenated, kmerCatStart, kmerCatEnd)

[1] "CATACTGAGA"

But what about i? As we will confirm, it is the (0-based) position of the suffix

> theSuffix <- substr(concatenated, kmerCatStart, nchar(concatenated))

in the list of all suffixes after they have been lexicographically sorted :

> extractSuffix <- function(s) {

## returns suffix of concatenated starting at position s (1-based)
substr(concatenated, s, nchar(concatenated))

}

> allSuffixes <- vapply(1:nchar(concatenated), extractSuffix, '')
> sortedSuffixes <- sort(allSuffixes)

8

Sure enough,

> i1based <- peak8$i + 1
> sortedSuffixes[i1based] == theSuffix

[1] TRUE

2.3.4 Window averaging (kernel smoothing)

Because the suffixes in sortedSuffixes are sorted, the suffixes in a window centered on
i1based all start with the same few characters (a k-mer):

> iCenteredWindow <- (i1based - 4):(i1based + 4)
> iCenteredWindowSuffixes <- sortedSuffixes[iCenteredWindow]
> all(substr(iCenteredWindowSuffixes, 1, 10) == 'CATACTGAGA')

[1] TRUE

For each suffix in sortedSuffixes, we can identify which input sequence contributed the
block of concatenated where the suffix begins:

> iCenteredWindow0Based <- iCenteredWindow - 1
> sourceBlock(sarks, i=iCenteredWindow0Based)

[1] "26" "28" "24" "21" "22" "25" "20" "29" "27"

Note that the 9 suffixes in iCenteredWindowSuffixes derive from come from 9 of the 10
higher-scoring sequences (all but "23"). This is not an accident: since the motif "CATACTGAGA"
is only present in high-scoring sequences, the suffixes starting with "CATACTGAGA" must de-
rive from blocks associated with high-scoring sequences. Thus the average score of the
sequences contributing the suffixes specified by iCenteredWindowSuffixes must be high
(value of 1) as well.

The SArKS algorithm turns this around to identify motifs by hunting for windows in the
sorted suffix list where the average score of the corresponding sourceBlock sequences is
high.

The windowed column of the peaks output contains the average sourceBlock sequence
scores for the windows centered around each sorted suffix position i and extending to both
the left and right by halfWindow=4 positions. These average values are also referred to as
ˆyi in Wylie et al. [2019]; a vector containing all of these values can be obtained from the
object sarks:

> yhat <- sarks$getYhat()
> i0based <- seq(0, length(yhat)-1)
> plot(i0based, yhat, type='l', xlab='i')

9

From the plot of ˆyi against i, we can see three peaks at which ˆyi spikes up to 1, corresponding
to the ranges i ∈ [1458, 1463], i ∈ [2256, 2258], and i ∈ [5862, 5865] which make up the values
in peaks$i.

2.4 Permutations and thresholds

How do we know that a given value of ˆyi (or, equivalently, peaks$windowed) is high enough
to include in the peaks output? In order to set such a threshold without having to make pos-
sibly unwarranted assumptions about the structure of the input sequences or the distribution
of the scores, SArKS employs a permutational approach.

To illustrate the idea here, let’s randomly permute the scores—so that the permuted scores
have no relationship with which sequences contain "CATACTGAGA"—and construct a new
Sarks object using the permuted scores:

> set.seed(12345)
> scoresPerm <- sample(simulatedScores)
> names(scoresPerm) <- names(simulatedScores)
> sarksPerm <- Sarks(simulatedSeqs, scoresPerm, halfWindow=4)

If we try using the same procedure we did before to look for k-mer peaks:

> permDistNull <- permutationDistribution(

sarksPerm, reps=250, filters, seed=123)

> thresholdsNull <- permutationThresholds(

filters, permDistNull, nSigma=2.0)

> peaksNull <- kmerPeaks(sarksPerm, filters, thresholdsNull)
> peaksNull[ , c('i', 's', 'block', 'wi', 'kmer', 'windowed')]

[1] i
<0 rows> (or 0-length row.names)

block

s

wi

kmer

windowed

10

02000400060000.00.20.40.60.81.0iyhatwe find that SArKS does not detect anything worthy of reporting after we disrupt any
association between input sequences and input scores by permuting the scores.

This is to be expected given that the thresholds θ used by SArKS are defined by consid-
ering many (here, reps=250) such permutations and choosing θ such that only very few
random permutations would produce smoothed ˆyi scores exceeding θ. The adjustable pa-
rameter nSigma controls how stringent the thresholds are: higher nSigma values lead to
higher thresholds, reducing sensitivity but also reducing the false positive rate.

Once we’ve set thresholds using permutationThresholds, we can estimate the false positive
rate, defined here as the frequency of seeing nonempty k-mer result sets when there is really
no association between sequence and score:

> fpr = estimateFalsePositiveRate(

sarks, reps=250, filters, thresholds, seed=321)

> fpr$ci

method x

upper
exact 5 250 0.02 0.00652507 0.04605358

n mean

lower

1

indicating a point estimate of 2% for the false positive rate, with a 95% confidence interval
of (0.65%, 4.6%). This confidence interval can be made tighter by using a higher number
for reps in the estimateFalsePositiveRate call.

Note regarding random number generator seed for estimateFalsePositiveRate: do not use
the same seed for estimateFalsePositiveRate as was used in permutationDistribution
call used to set thresholds. The false positive rate estimation procedure assumes that the
random permutations used in estimateFalsePositiveRate are independent of those used
to set thresholds.

2.4.1 Gini impurity filter

When considering how to set SArKS thresholds in order to obtain a reasonable tradeoff
between sensitivity and false positive rate, the mysterious minGini parameter should be
factored in as well. This parameter is discussed in more detail in sections 3.1.7 and 3.2.1,
but the basic idea is to filter likely false positive suffix array index positions i out of consid-
eration regardless of their smoothed scores ˆyi. These likely false positive indices i come from
excessive repetition of the same input sequences contributing repeatedly to the smoothing
windows centered on i.

My recommendation is to set minGini to a value slightly greater than 1: the value 1.1 seems
empirically to work well in many situations. Note that for minGini > 1, this filter becomes
more stringent the closer to 1 it is set; the opposite is true if you set minGini to a value less
than 1, and you can turn the filter off entirely by setting it to 0. See section 3.2.1 and Wylie
et al. [2019] for more details.

Here we examine the effects of this parameter using the simulated data:

> estimateFalsePositiveRate(

sarks, reps=250, filters, thresholds, seed=321)$ci

method x

upper
exact 5 250 0.02 0.00652507 0.04605358

n mean

lower

1

11

> filtersNoGini <- sarksFilters(halfWindow=4, spatialLength=0, minGini=0)
> estimateFalsePositiveRate(

sarks, reps=250, filtersNoGini, thresholds, seed=321)$ci

method

upper
exact 42 250 0.168 0.1238429 0.2202254

lower

mean

x

n

1

Of course we could compute a new set of thresholdsNoGini using filtersNoGini, but the
results of this on our ability to detect anything are worth considering:

> permDistNoGini <-

permutationDistribution(sarks, reps=250, filtersNoGini, seed=123)

> thresholdsNoGini <-

permutationThresholds(filtersNoGini, permDistNoGini, nSigma=2.0)

> peaksNoGini <- kmerPeaks(sarks, filtersNoGini, thresholdsNoGini)
> peaksNoGini[ , c('i', 's', 'block', 'wi', 'kmer', 'windowed')]

[1] i
<0 rows> (or 0-length row.names)

block

s

wi

kmer

windowed

2.4.2 Multithreading sarks permutational analyses

Setting thresholds and estimating false positive rates using permutation methods is usually
the most time-consuming step in the SArKS workflow. To facilitate more rapid turnaround,
the java back end of sarks supports multithreading for these processes. In order to take
advantage of multithreading, you just need to specify how many threads you’d like to use
when you invoke the Sarks constructor using the nThreads argument to that function; all
permutation steps performed using the resulting sarks object will then use the specified
number of threads.

Note regarding sarks multithreading: while the different threads performing the permuta-
tional analyses share as many data structures as possible to reduce the memory requirements
of sarks, each thread will need to keep track of its own permuted smoothed scores (and
spatially smoothed scores if necessary). This can increase memory requirements quickly, so
make sure you are running sarks on a machine with large RAM if you are planning to use
many threads on a large data set.

2.5 Spatial smoothing

So far we have not taken advantage of the spatial smoothing features in SArKS. While one of
the major uses of spatial smoothing is to detect multi-motif domains (MMDs), which are not
present in the simple simulated data set included in the sarks package, spatial smoothing
can also help sharpen the ability of SArKS to detect individual motifs:

> sarks <- Sarks(

simulatedSeqs, simulatedScores, halfWindow=4, spatialLength=3

)

> filters <- sarksFilters(halfWindow=4, spatialLength=3, minGini=1.1)
> permDist <- permutationDistribution(sarks, reps=250, filters, seed=123)
> thresholds <- permutationThresholds(filters, permDist, nSigma=5.0)
> ## note setting of nSigma to higher value of 5.0 here!

12

> peaks <- kmerPeaks(sarks, filters, thresholds)
> peaks[ , c('i', 's', 'block', 'wi', 'kmer', 'spatialWindowed')]

s block

i
1 1458 4442
2 1459 3545
3 1460 3960
4 1461 4519
5 2256 3544
6 2257 3959
7 2258 4518
8 5863 3546

wi
ATACTGAG
24 175
21 31 ATACTGAGA
22 195 ATACTGAGA
25
ATACTGAGA
21 30 CATACTGAGA
22 194 CATACTGAGA
0 CATACTGAGA
25
TACTGAGA
21 32

kmer spatialWindowed
0.9259259
0.9629630
0.9259259
0.9259259
1.0000000
1.0000000
1.0000000
0.9259259

1

Note that here we use nSigma=5.0, a much more stringent setting than the nSigma=2.0
value used when no spatial smoothing was employed; had we tried nSigma=5.0 without
spatial smoothing, SArKS would not have been able to detect the "CATACTGAGA" motif.

The peaks object returned by kmerPeaks when spatial smoothing is employed contains the i
and s coordinates for the left endpoints of spatial windows (windows in s-space, not i-space)
enriched in high ˆy scores. Especially when these windows have longer spatialLength values,
it can also be useful to pick out individual motif “subpeaks” within these spatial windows:

> subpeaks <- mergedKmerSubPeaks(sarks, filters, thresholds)
> subpeaks[ , c('i', 's', 'block', 'wi', 'kmer')]

i
1 2256 3544
2 2257 3959
3 1458 4442
4 2258 4518

s block

wi

kmer
21 30 CATACTGAGA
22 194 CATACTGAGA
ATACTGAG
24 175
0 CATACTGAGA
25

In this case, with spatialLength=3, this is not such an important step—although it does
serve to accomplish some simplification of results as was described when mergedKmerSubPeaks
was first introduced in section 2.3.2—but in general it is a critical piece of the SArKS method-
ology when spatial smoothing is in use.

The subpeaks output of mergedKmerSubPeaks should generally be regarded as the main
individual motif output for SArKS. Section 3.5 provides more details.

When employing spatial smoothing to identify MMDs, you may want to inspect individual
input sequences of interest by visualizing the SArKS results:

> block22 <- blockInfo(sarks, block='22', filters, thresholds)
> library(ggplot2)
> ggo <- ggplot(block22, aes(x=wi+1))
> ggo <- ggo + geom_point(aes(y=windowed), alpha=0.6, size=1)
> ggo <- ggo + geom_line(aes(y=spatialWindowed), alpha=0.6)
> ggo <- ggo + geom_hline(aes(yintercept=spatialTheta), color='red')
> ggo <- ggo + ylab('yhat') + ggtitle('Input Sequence "22"')
> ggo <- ggo + theme_bw()
> print(ggo)

## +1 because R indexing is 1-based

13

which here clearly shows the spike at the location wi+1=195 of the "CATACTGAGA" motif in
sequence "22".

The use of the more stringent nSigma=5.0 setting reduces the false positive rate relative to
the nSigma=2.0 setting we used when not employing spatial smoothing:

> estimateFalsePositiveRate(

sarks, reps=250, filters, thresholds, seed=321)$ci

method x

1

exact 0 250

n mean lower
0

upper
0 0.01464719

2.6 Varying SArKS parameters

You may be wondering what the point of the filters object created in the SArKS workflow
is, as it seems to specify the halfWindow and spatialLength parameters in a manner
redundant to their specification in the Sarks constructor. Aside from the specification of
the minGini parameter, the motivation for this step is that we usually don’t know exactly
what halfWindow or spatialLength values will yield the most useful output (and the answer
to these questions will be different for different data sets and different questions).

To address this, we can use sarksFilters to test a variety of combinations of halfWindow
and spatialLength (and, if so desired, minGini as well) values like so:

> filters <- sarksFilters(

halfWindow=c(4, 8), spatialLength=c(2, 3), minGini=1.1)

> permDist <- permutationDistribution(sarks, reps=250, filters, seed=123)
> thresholds <- permutationThresholds(filters, permDist, nSigma=5.0)
> peaks <- mergedKmerSubPeaks(sarks, filters, thresholds)
> peaks[ , c('halfWindow', 'spatialLength', 'i', 's', 'block', 'wi', 'kmer')]

14

0.250.500.751.00050100150200250wi + 1yhatInput Sequence "22"halfWindow spatialLength

s block wi

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

4
4
4
4
4
4
4
4
8
8
8
8
8
8
8

i
2 2256 3544
2 2257 3959
2 1458 4442
2 2258 4518
3 2256 3544
3 2257 3959
3 1458 4442
3 2258 4518
2 1459 3545
2 2261 5173
3 1459 3545
3 3498 4445
3 5860 4947
3 2261 5173
3 3497 5432

kmer
21 30 CATACTGAGA
22 194 CATACTGAGA
24 175
ATACTGAG
0 CATACTGAGA
25
21 30 CATACTGAGA
22 194 CATACTGAGA
24 175
ATACTGAG
0 CATACTGAGA
25
ATACTGA
21 31
CATACTGA
27 153
ATACTGAG
31
21
CTGAGA
24 178
TACTGA
26 178
CATACTGA
27 153
CTGAG
28 161

Note that, as is generally true with SArKS, the results obtained using larger halfWindow
values tend to have shorter identified k-mers.

As always, testing multiple parameter sets can increase false positive rates:

> estimateFalsePositiveRate(

sarks, reps=250, filters, thresholds, seed=321)$ci

method x

1

exact 0 250

n mean lower
0

upper
0 0.01464719

As suggested in section 2.5 above, this can be countered by using increased nSigma values
when setting thresholds if we plan to test a wider range of possible SArKS parameters.

Note regarding multiple hypothesis testing in SArKS : The false positive rates estimated by
SArKS test the rate of detecting any results using any of the specified parameter settings, and
are thus a type of family-wise error rate. As long as all parameter combinations tested are
included in the filters employed in estimateFalsePositiveRate, no further adjustment
for multiple testing should be applied to the estimated false positive rates.

2.7 Clustering similar k-mers into broader motifs

While there is essentially one unambiguous k-mer "CATACTGAGA" of note in the simulatedSeqs-
simulatedScores example, real data sets will generally have more complex sequence motifs
allowing for some variation both in length and composition of the patterns. When applying
SArKS methodology to real data, many similar k-mers representing the same basic motif
may result: sarks provides functions for clustering these k-mers into broader motif patterns.

For example, let’s say we had obtained the following k-mers using sarks:

> kmers <- c(

'CAGCCTGG', 'CCTGGAA', 'CAGCCTG', 'CCTGGAAC', 'CTGGAACT',
'ACCTGC', 'CACCTGC', 'TGGCCTG', 'CACCTG', 'TCCAGC',
'CTGGAAC', 'CACCTGG', 'CTGGTCTA', 'GTCCTG', 'CTGGAAG', 'TTCCAGC'

)

15

We could cluster these like so:

> kmClust <- clusterKmers(kmers, directional=FALSE)
> ## directional=FALSE indicates that we want to treat each kmer
> ##
> kmClust

as equivalent to its reverse-complement

$CAGCCTGG
[1] "CAGCCTGG" "CAGCCTG"

"CCTGGAAC" "CTGGAACT" "TCCAGC"

"CTGGAAC"

"CTGGAAG"

"TTCCAGC"

"CACCTGC" "CACCTG"

"CACCTGG"

$CTGGAAC
[1] "CCTGGAA"

$CACCTGC
[1] "ACCTGC"

$TGGCCTG
[1] "TGGCCTG"

$CTGGTCTA
[1] "CTGGTCTA"

$GTCCTG
[1] "GTCCTG"

The resulting object kmClust is a named list: each element of this list is a character vector
listing the elements of the vector kmers composing the corresponding cluster, while the name
of the cluster is a k-mer from kmers found to be particularly representative of the cluster.

sarks then allows us to count how many times each motif (=cluster of k-mers) occurs in
each sequence:

> clCounts <- clusterCounts(kmClust, simulatedSeqs, directional=FALSE)
> ## directional=FALSE to count hits of either a kmer from the cluster
> ##
> ## clCounts is a matrix with:
> ## - one row for each sequence in simulatedSeqs
> ## - one column for each *cluster* in kmClust
> head(clCounts)

or the reverse-complement of such a kmer

CAGCCTGG CTGGAAC CACCTGC TGGCCTG CTGGTCTA GTCCTG
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
1
2
3
4
5

Can also get specific information about the location of these matches:

> clLoci <- locateClusters(

kmClust, simulatedSeqs, directional=FALSE, showMatch=TRUE

16

)

> ## showMatch=TRUE includes column specifying exactly what k-mer
> ##
> ##
> clLoci

registered as a hit;
this can be very slow, so default is showMatch=FALSE

seqid

cluster location

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

25 CAGCCTGG
6 CTGGAAC
16 CTGGAAC
28 CTGGAAC
1 CACCTGC
28 CACCTGC
5 TGGCCTG
19 CTGGTCTA
GTCCTG
GTCCTG
GTCCTG
GTCCTG
GTCCTG
GTCCTG
GTCCTG

5
9
13
15
17
19
24

25

match
143 CAGCCTGG
190 GCTGGAA
196 AGTTCCAG
36 GTTCCAG
242 GCAGGTG
GCAGGT
216 TGGCCTG
51 TAGACCAG
GTCCTG
19
GTCCTG
67
CAGGAC
86
CAGGAC
19
CAGGAC
151
CAGGAC
76
GTCCTG
38

This shows us that, for example, there is one match for the cluster "CAGCCTGG" spanning
sequence characters 143-150 of sequence "25", and that this is an exact match of the k-mer
"CAGCCTGG" in its forward orientation.

These results also tells us that there are three matches of k-mers from the cluster "CTGGAAC",
in sequences "6", "16", and "28". The specific k-mers found are different in each case:

• sequence "6" has a hit for the reverse-complement of k-mer "TTCCAGC", while

• sequence "16" has a hit for k-mer "CTGGAACT" in reverse-complement orientation and

• sequence "28" has a hit for "CTGGAAC" also in reverse-complement orientation.

3 How sarks works

3.1 Sarks constructor

> sarks = Sarks(

simulatedSeqs, simulatedScores, halfWindow=4, spatialLength=3, nThreads=4

)

The object sarks created by the Sarks constructor is an R representation of a java ob-
ject which contains several attributes worth noting: these are described in the next few
subsections, the headings of which match the names of the corresponding java Sarks class
attributes.

17

3.1.1

catSeq

The concatenated sequence x = w0 ∗ w1 ∗ · · · ∗ wn−1, which may be extracted using the R
code sarks$getCatSeq().

3.1.2

sa

The suffix array si mapping sorted suffix index i to spatial position si in the concatenated
sequence x. Calculated using the java code internally implemented in SkewSuffixArray class
implementing the skew algorithm initially described in Kärkkäinen and Sanders [2003]. The
suffix array may be extracted via the R code sarks$getSuffixArray().

3.1.3

saInv

The inverted suffix array is mapping spatial position s of the suffix formed by deleting
the first s characters of the concatenated sequence x to the position i of this suffix in the
sorted list of all suffixes of x. The inverted suffix array may be extracted via the R code
sarks$getInvertedSuffixArray().

3.1.4

scores

The array of sequence (block) scores yb. May be extracted via R code blockScores(sarks).

3.1.5

windowed

The kernel- (or window-)smoothed scores ˆyi defined by

ˆyi =

1
2κ + 1

i+κ
(cid:88)

j=i−κ

ybj

(3)

where:

κ is the specified halfWindow value and

bj is the input sequence block in which suffix with suffix array index j begins.

In R, the value of bj for any suffix array index j can be assessed using the code
sourceBlock(sarks, i=j).

The array of kernel-smoothed scores ˆyi can be extracted using the R code sarks$getYhat().

spatialWindowed

3.1.6
The spatially-smoothed scores ˆˆyi (here indexed by suffix array index i, not spatial position
si) defined by

ˆˆyi =

1
λ

si+λ−1
(cid:88)

s=si

ˆyis

(4)

where:

λ is the specified spatialLength value and

18

is is the sorted suffix index associated with the suffix starting at spatial position s (obtained

from the inverted suffix array described in section 3.1.3 above).

The array of spatially-smoothed scores ˆˆyi can be extracted using the R code sarks$getYdoubleHat().

3.1.7

windGini

Array whose ith value is the Gini impurity value gi of smoothing window centered on suffix
array index i, defined by

gi =

(cid:88)

(cid:16)

f (i)
b

1 − f (i)
b

(cid:17)

(5)

where:

b

j+κ
(cid:80)
j=i−κ

f (i)
δbj b is the fraction of positions within the smoothing window associated
b = 1
2κ+1
with sequence (or block) b (note δbj b is Kronecker delta taking value 1 if bj = b and 0
otherwise).

Low values of the Gini impurity values gi are used by SArKS to filter out likely false positive
suffix array positions i: First note that equation (3) may be rewritten

ˆyi =

1
2κ + 1

(cid:88)

f (i)
b yb

b

(6)

Now:

• shuffling the sequence/block scores yb by a random permutation Π,
• recomputing the resulting smoothed scores ˆy(Π)
• noting that by symmetry V (cid:2)yΠ(b)
(cid:3) = V (cid:2)yΠ(b′)

using equation (6),
(cid:3) for all sequences b, b′ under random

i

permutation Π and

• neglecting the small interdepence between yΠ(b) and yΠ(b′) for distinct sequences b and b′,

we can approximate

V

(cid:105)

(cid:104)
ˆy(Π)
i

∝

(cid:105)2

(cid:104)
f (i)
b

= 1 − gi

(7)

Equation (7) tells us that, even under the null hypothesis of no association between sequence
wb and sequence score yb, at positions i for which the Gini impurity gi is particularly far
below the maximum value of 1, the smoothed scores will tend to be more extreme (high or
low) than at other positions. Hence a high score ˆyi for such a position is less informative
than would be the same score at a different position j.

The array of Gini impurity values gi can be extracted using the R code sarks$getGini().

3.1.8

spatGini

Array whose ith value is the spatially averaged Gini impurity value ¯gi of smoothing window
centered on suffix array index i, defined by

¯gi =

1
λ

si+λ−1
(cid:88)

s=si

gis

19

(8)

The spatially averaged Gini impurities are again used to filter out likely false-positive po-
sitions i, this time when spatial smoothing is employed to calculate ˆˆyi values. The idea
behind this filter is that, now neglecting the interdependence between ˆy(Π)
for
distinct suffix array indices i and j, we can get a crude estimate of the variance

and ˆy(Π)

j

i

from

V

(cid:105)

(cid:104)ˆˆy(Π)

i

= V

(cid:34)

1
λ

si+λ−1
(cid:88)

s=si

(cid:35)

ˆy(Π)
is

1
λ2

si+λ−1
(cid:88)

s=si

(cid:104)

V

(cid:105)

ˆy(Π)
is

∝ 1 − ¯gi

(9)

(10)

The degree of approximation involved in the independence assumption required to pass from
equation (9) to equation (10) depends on how dissimilar the smoothing window compositions
f (i)
are for the various suffix array indices i appearing in equation (9). For the sake of
b
simplicity and tractability, the approach taken in the current implementation of SArKS is
to employ the spatial Gini filter as a heuristic parameter whose utility is to be assessed
empirically via permutation testing.

3.2 permutationDistribution

Once the object sarks has been constructed using the Sarks constructor function, we can
select a range of halfWindow, spatialLength, and minGini parameter values for motif and
MMD selection. The R function sarksFilters puts all combinations of values of these
values (specificied as numeric vectors in R) into a java object to pass along to downstream
SArKS functions including permutationDistribution:

> filters <- sarksFilters(halfWindow=4, spatialLength=c(0, 3), minGini=1.1)
> permDist <- permutationDistribution(

sarks, reps=250, filters=filters, seed=123)

(cid:16)

(cid:17)

κ(α), λ(α), g(α)
min

be the resulting SArKS halfWindow, spatialLength, and minGini pa-

Let
rameters, with α here indexing the set of desired combinations. The permutationDistribution
call generates reps=250 random permutations πr:
• for each of these permutations πr and
(cid:16)

(cid:17)

• for each combination of parameters

κ(α), λ(α), g(α)
min

,

it then computes

• the smoothed scores ˆy(α,πr)

and,

i
• if applicable, the spatially-smoothed scores ˆˆy(α,πr)

.

i

The resulting permDist object is a named list in R. The first two elements, ‘windowed’ and
‘spatial’ are data.frames with reps=250 rows per combination of parameters in filters.
Both of these have a column named ‘max’ containing either

• permDists$windowed$max:

ˆy(α,πr)
max =

max
{i | gi ≥ g(α)

min}

ˆy(α,πr)
i

20

(11)

• permDists$spatial$max:

ˆˆy(α,πr)
max =

3.2.1 Specification of g(α)

min in sarks

max
{i | ¯gi ≥ g(α)

min}

ˆˆy(α,πr)
i

(12)

i < g(α)

SArKS currently allows the user to directly set g(α)
min < 1 excluding suffix array index values
i with g(α)
from permutational analysis and ˆyi peak calling if so desired. Given the
interpretation afforded by equation (7), however, it can be more convenient to indirectly
specify g(α)
min

by choosing γ in the following:

min

1 − g(α)

min = (1 + γ)

(cid:18)

1 − median

i

(cid:19)

g(α)
i

(13)

Together equations (7) and (13) imply that fixing γ restricts analysis to suffix indices i for
which the variance of the permuted smoothed scores is at most (1 + γ) times the median
such variance.

If minGini is set to a value ≥ 1, each of the g(α)
min
γ = minGini −1.

values will be set using equation (13) with

3.3 permutationThresholds

> thresholds = permutationThresholds(

filters=filters, permDist=permDist, nSigma=5.0)

SArKS uses a simple method for setting thresholds θ(α) or θ(α)
domly generated permutations {πr}:

spatial

based on the set of ran-

θ(α) = mean

r

θ(α)
spatial = mean

r

(cid:110)

ˆy(α,πr)
max
(cid:110)ˆˆy(α,πr)

max

(cid:111)

(cid:111)

+ z stdev

r

+ z stdev

r

(cid:110)

ˆy(α,πr)
max
(cid:110)ˆˆy(α,πr)

max

(cid:111)

(cid:111)

(14)

(15)

The quantity z appearing in equations (14)-(15) is specified by the nSigma argument to
permutationThresholds. Higher values of z trade reduced sensitivity for lower false positive
rates.

As currently implemented, equation (14) is only applied for parameter sets α for which no
spatial smoothing is done (encoded as spatialLength or λ(α) = 0). For those parameter
sets α such that λ(α) > 1, equation (15) is instead applied to obtain θ(α)
, with θ(α) = −∞.

spatial

3.4 kmerPeaks

> peaks = kmerPeaks(sarks, filters=filters, thresholds=thresholds)

If the option peakify is turned on (set to TRUE, as it is by default), the set of suffix array
indices I (α) or J (α)
—depending on whether spatial smoothing is employed or not—defining

spatial

21

the SArKS peak set for parameter combination α is determined by:

I (α) =

J (α)
spatial =

(cid:110)
i
(cid:110)
i

(cid:12)
(cid:12)
(cid:12)
(cid:12)
(cid:12)
(cid:12)

where:

(cid:16)

i ≥ θ(α)(cid:17)
ˆy(α)
(cid:16)ˆˆy(α)
i ≥ θ(α)

spatial

∧
(cid:17)

i ≥ ˆy(α)

ρ(i)

(cid:16)

ˆy(α)
η(i) ≤ ˆy(α)
(cid:16)ˆˆy(α)

∧

η(i) ≤ ˆˆy(α)

i ≥ ˆˆy(α)

ρ(i)

(cid:17)

(cid:16)

∧
(cid:17)

(cid:17)(cid:111)

min

i ≥ g(α)
g(α)
(cid:16)
i ≥ g(α)
¯g(α)

min

∧

(cid:17)(cid:111)

(16)

(17)

η(i) is the negative spatial shift operator defined by η(i) = isi−1, and
ρ(i) is the positive spatial shift operator defined by ρ(i) = isi+1.
The condition that ˆy(α)
i ≥ ˆy(α)
) restricts the peak set to only
those suffix array indices i for which there is not a higher smoothed score immediately
spatially adjacent in either direction.

(or similar for ˆˆy(α)
η(i)

η(i) ≤ ˆy(α)

ρ(i)

If peakify is disabled, this condition is not required, so that instead

I (α) =

J (α)
spatial =

is used to define I (α) or J (α)

spatial

(cid:110)
i
(cid:110)
i

(cid:12)
(cid:12)
(cid:12)
(cid:12)
(cid:12)
(cid:12)

.

(cid:16)

i ≥ θ(α)(cid:17)
ˆy(α)
(cid:16)ˆˆy(α)
i ≥ θ(α)

spatial

∧
(cid:17)

(cid:16)

(cid:17)(cid:111)

min

i ≥ g(α)
g(α)
(cid:16)
i ≥ g(α)
¯g(α)

min

∧

(cid:17)(cid:111)

(18)

(19)

If no spatial smoothing is employed, we can use ˆk(α)

i

defined by

ˆk(α)
i =

1
2κ(α)

i+κ(α)
(cid:88)

j=i−κ(α)

(1 − δij) max {k ≤ kmax | x[sj, sj + k) = x[si, si + k)}

(20)

to estimate the characteristic length ⌊ˆk(α)
⌉ (where ⌊· · · ⌉ indicates nearest integer) of the
k-mer x[si, si + ⌊ˆk(α)
⌉) associated with the smoothing window centered on the suffix with
sorted index i. We can then identify the set of k-mers reported by SArKS using parameter
set α when not using spatial smoothing (i.e., when spatialLength = λ(α) = 0) by:

i

i

M (α) =

(cid:110)
x[si, si + ⌊ˆk(α)

i

⌉) | i ∈ I (α)(cid:111)

(21)

3.5 mergedKmerSubPeaks

> mergedPeaks = mergedKmerSubPeaks(sarks, filters, thresholds)

The set of suffix array indices marking the left ends of merged k-mer subpeaks when spatial
smoothing is employed is given by:

I (α)
spatial =

(cid:110)
i

(cid:12)
(cid:12)
(cid:12)

(cid:16)

i < λ(α)(cid:17)
δ(α)

∧

(cid:16)

i ≥ θ(α)
ˆy(α)

spatial

(cid:17)

(cid:104) (cid:16)

η(i) ≥ λ(α)(cid:17)
δ(α)

∨

(cid:16)

∧

η(i) < θ(α)
ˆy(α)

spatial

where

δ(α)
j = min
i

(cid:110)

sj − si

(cid:16)

(cid:12)
(cid:12)
(cid:12)

i ∈ J (α)

spatial

(cid:17)

∧ (si ≤ sj)

(cid:111)

(cid:17) (cid:105)(cid:111)

(22)

(23)

is the distance from spatial position sj to the nearest element of J (α)
and

spatial

spatially left of sj,

22

δ(α)
i < λ(α) : requires the suffix i to be spatially located within one of the identified MMDs,
i ≥ θ(α)
ˆy(α)
and finally, we require either that:

: requires the singly-smoothed score ˆy(α)

to be above the threshold θ(α)

spatial

spatial

i

δ(α)
η(i) ≥ λ(α) : si is at the beginning of MMD, or
η(i) < θ(α)
ˆy(α)

spatial

: score of suffix immediately spatially prior to si is below threshold θ(α)

—
idea here is that if this condition is not met we want to merge suffix at si into suffix
initiated spatially to left.

spatial

Once we have defined I (α)
spatial
spatially smoothed suffix array index peaks i ∈ I (α)

by

spatial

, SArKS estimates the associated k-mer lengths for merged

ˆˆk(α)
i = max

j

(cid:110)ˆk(α)

j + sj − si

(cid:12)
(cid:12) s ∈ [si, sj] =⇒ ˆy(α)
(cid:12)

is

(cid:111)

≥ θ(α)

spatial

(24)

j

where ˆk(α)
is defined by equation (20) and the condition s ∈ [si, sj] =⇒ ˆy(α)
is
spatial
requires that all spatial positions s between si and sj (including both si and sj) have
(and should hence be merged together). The resulting
smoothed scores ˆyis
motif set is then defined by:

exceeding θ(α)

≥ θ(α)

spatial

M (α)

spatial =

(cid:110)

(cid:104)
si, si +
x

(cid:106)ˆˆk(α)

i

(cid:109)(cid:17) (cid:12)
(cid:12) i ∈ I (α)
(cid:12)

spatial

(cid:111)

(25)

3.6 estimateFalsePositiveRate

> fpr = estimateFalsePositiveRate(sarks, reps=250,

filters=filters, thresholds=thresholds,
seed=123456)

The false positive rate associated with a given set of parameters

thresholds

(cid:110)(cid:16)

θ(α), θ(α)

spatial

(cid:17)(cid:111)

is estimated by

• generating a second (independent) permutation set {π′

r},

(cid:110)(cid:16)

κ(α), λ(α), g(α)
min

(cid:17)(cid:111)

and

• for each combination of parameters α, use equation (11) replacing πr with π′
r

max and equation (12) similarly to calculate ˆˆy ′(α)

to cal-
max (if λ(α) > 1; otherwise, take

culate ˆy ′(α)
ˆˆy ′(α)
max = ∞).

The set of reps yielding false positive hits is calculated according to:

false positives =

r

(cid:40)

(cid:12)
(cid:12)
(cid:12)
(cid:12)
(cid:12)

(cid:95)

(cid:104) (cid:16)

max ≥ θ(α)(cid:17)
ˆy ′(α)

∧

α

(cid:16)ˆˆy ′(α)

max ≥ θ(α)

spatial

(cid:41)

(cid:17) (cid:105)

(26)

where we again take either θ(α) = −∞ when λ(α) = 0 or θ(α)
spatial = −∞ when λ(α) > 1, so
that, depending on the value of λ(α), one or the other of the two logical expressions inside
the square brackets in equation (26) is trivially true for each α.

The false positive rate can then be estimated by comparing the number of false positive re-
generated. SArKS uses binom::binom.exact
sults with the number reps of permutations π′
r

23

to estimate confidence intervals for the false positive rate according to the Pearson-Klopper
method.

r} be
Note regarding random number generator seeds: In order that the permutation set {π′
(cid:17)(cid:111)
,
independent of the initial permutation set {πr} used to select thresholds
you should make sure that you do not repeat the same seed for the random number generator
in the calls to permutationDistribution and estimateFalsePositiveRate.

θ(α), θ(α)

spatial

(cid:110)(cid:16)

4 Session Info

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

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=en_US.UTF-8

[11] LC_MEASUREMENT=en_US.UTF-8

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=en_US.UTF-8
LC_TELEPHONE=en_US.UTF-8
LC_IDENTIFICATION=en_US.UTF-8

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats

graphics

grDevices utils

datasets

methods

base

other attached packages:
[1] ggplot2_4.0.0 sarks_1.22.0 rJava_1.0-11

loaded via a namespace (and not attached):

[1] crayon_1.5.3
[4] rlang_1.1.6
[7] labeling_0.4.3

[10] Biostrings_2.78.0
[13] grid_4.5.1
[16] IRanges_2.44.0
[19] compiler_4.5.1
[22] pkgconfig_2.0.3
[25] farver_2.1.2
[28] dichromat_2.0-0.1

vctrs_0.6.5
generics_0.1.4
glue_1.8.0
stats4_4.5.1
Seqinfo_1.0.0
lifecycle_1.0.4
dplyr_1.1.4
XVector_0.50.0
R6_2.6.1
pillar_1.11.1

cli_3.6.5
S7_0.2.0
S4Vectors_0.48.0
scales_1.4.0
tibble_3.3.0
cluster_2.1.8.1
RColorBrewer_1.1-3
binom_1.1-1.1
tidyselect_1.2.1
magrittr_2.0.4

24

[31] withr_3.0.2
[34] BiocGenerics_0.56.0

tools_4.5.1

gtable_0.3.6

25

5 Notation glossary

⌊r⌉
u ∗ v
|u|
u[i, j)

u[i, j]

{a | C(a)}
{a | C1(a) ∧ C2(a)}
{a | C1(a) ∨ C2(a)}
E[A]
V[A]
i

si

is
bi

ωi
ˆyi
κ
ˆki
η(i)
ρ(i)
θ
I

nearest integer to real number r
concatenation of strings u and v
length of string u
substring of u starting at ith character (inclusive) and continuing up until
jth character (exclusive) using 0-based indexing
substring of u starting at ith character (inclusive) and continuing through
the jth character (inclusive) using 0-based indexing
set containing all elements a satisfying condition C(a)
set containing all elements a satisfying conditions C1(a) and C2(a)
set containing all elements a satisfying conditions C1(a) or C2(a)
expectation value of random variable A
variance of random variable A
suffix array index: 0-based position of suffix in lexicographically sorted list
of all suffixes of string x
suffix array value: 0-based spatial position of suffix with suffix array index
i within string x
suffix array index i associated with spatial position s
block array value: 0-based position of block/word in which suffix with
suffix array index i begins
0-based position of suffix with suffix array index i within block bi
kernel smoothed score associated with suffix array index i
half-width of kernel applied to generate ˆyi
estimate of smoothed k-mer length at suffix array index i
negative spatial shift operator defined by η(i) = isi−1
positive spatial shift operator defined by ρ(i) = isi+1
threshold value for ˆyi for sequence-smoothed peak calling
set of suffix array indices identified as peaks by SArKS

M set of k-mer motifs derived from suffix array peak set
f (i)
b

weighted frequency of block/word b within smoothing window centered on
suffix array index i

gi Gini impurity of smoothing window centered on suffix array index i

gmin minimum value of smoothing window Gini impurity for inclusion in peak

¯gi

set I
spatially-averaged Gini impurity over spatial window starting at position
si

¯gmin minimum value of spatially-averaged Gini impurity for inclusion in peak

ˆˆyi
λ
ˆˆki
θspatial
Jspatial
Ispatial

Mspatial

set Jspatial
spatially smoothed score associated with suffix array index i
length of spatial kernel applied to generate spatially smoothed scores ˆˆyi
estimate of merged k-mer length at suffix array index i
threshold value for ˆˆyi to call significant spatial windows
set of suffix array indices identified as spatial window starting positions
set of suffix array indices identified as k-mer starting positions using spatial
smoothing
set of k-mer motifs derived from suffix array index set Ispatial using spatial
smoothing
permutation of n blocks/words

π
Π random variable representing randomly generated permutation

ˆy(π)
i
ˆˆy(π)
i

sequence smoothed scores calculated with word scores permuted by π
spatially smoothed scores calculated with word scores permuted by π

26

References

J. Kärkkäinen and P. Sanders. Simple linear work suffix array construction. In International Collo-

quium on Automata, Languages, and Programming, pages 943–955. Springer, 2003.

D. Wylie, H. Hofmann, and B. Zemelman. SArKS: de novo discovery of gene expression regulatory
motif sites and domains by suffix array kernel smoothing. Bioinformatics, 35(20):3944–3952, 2019.

27

