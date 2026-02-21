MassArray Analytical Tools

Reid F. Thompson and John M. Greally

October 30, 2025

Contents

1 Introduction

2 Changes for MassArray in current BioC release

3 Optimal Amplicon Design

4 Conversion Controls

5 Data Import

6 Data Visualization

7 Single Nucleotide Polymorphism Detection

A Previous Release Notes

2

3

4

10

14

16

19

23

1

1 Introduction

The MassArray package provides a number of tools for the analysis of MassArray data,
with particular application to DNA methylation and SNP detection. The package in-
cludes plotting functions for individual and combined assays, putative fragmentation
profiles, and potential SNP locations level data useful for quality control, as well as flex-
ible functions that allow the user to convert probe level data to methylation measures.

In order to use these tools, you must first load the MassArray package:

> library(MassArray)

It is assumed that the reader is already familiar with mass spectrometry analysis
of base-specific cleavage reactions using the Sequenom workflow and MassCLEAVE as-
say. If this is not the case, consult the Sequenom User’s Guide for further information
(Sequenom, 2008).

Throughout this vignette, we will be exploring actual data for 2 amplicons, each

containing a set of samples.

2

2 Changes for MassArray in current BioC release

• This is the first public release of the MassArray package.

3

3 Optimal Amplicon Design

The ampliconPrediction() function is designed to take an input nucleotide sequence
and output a graphic depiction of the pattern of individual CGs that are measurable by
any of the four possible RNase reaction/strand combinations (either a T or C reaction
for either the forward or reverse strands). The function also returns a tabular output of
the measurability of each CG in the amplicon under each of the four possible conditions.
This functionality will be demonstrated for a short nucleotide sequence containing
two different CG sites. This sequence is far too short for use as a successful MassArray
assay; however, this example should be illustrative of the differences between reactions.
Both the graphical and tabular depictions are shown here, although similar representa-
tions throughout the remainder of this documentation will only show graphical output.

4

> results <- ampliconPrediction("AAAATTTTCCCCTCTGCGTGAGAGAGTTGTCCGACAAAA")
> results

$summary

required summary

1
2

FALSE
FALSE

T+

C+

T-
TRUE TRUE FALSE FALSE
TRUE TRUE FALSE

C-
TRUE
TRUE FALSE

$counts

all
required

summary + T+ C+ - T- C-
1
2
0
0

2 2
0 0

0 2
0 0

1
0

Figure 1: Basic amplicon prediction for a short sequence containing two CG sites. Pu-
tative fragmentation patterns are shown for T and C-cleavage reactions on both the
plus and minus strands. CG dinucleotides (filled circles) are numbered and color-coded
according to their ability to be assayed: fragment molecular weight outside the testable
mass window (gray), uniquely assayable site (blue). Yellow highlights represent tagged
5
sequences.

inSilico Assay PredictionNucleotide position (bp)21T(+) 1 bp39 bp21C(+) 1 bp39 bp12T(−) 1 bp39 bp12C(−) 1 bp39 bpAGGAAGAGAGAAAATTTTCCCCTCTGCGTGAGAGAGTTGTCCGACAAAAAGCCTTCTCCCYou may also highlight specific sequences (or individual CG dinucleotides) using
paired parentheses or arrowheads in the input nucleotide sequence.
In the following
example, the second CG dinucleotide (CG#2) is marked/highlighted in lavendar as an
important site of analysis. A four basepair "primer" is labeled on each end of the input
sequence using arrowheads.

> ampliconPrediction("AAAA>TTTTCCCCTCTGCGTGAGAGAGTTGTC(CG)AC<AAAA")

Figure 2: Basic amplicon prediction for a short sequence containing two CG sites, the
second of which is highlighted. Putative fragmentation patterns are shown for T and
C-cleavage reactions on both the plus and minus strands for the specified sequence. CG
dinucleotides (filled circles) are numbered and color-coded according to their ability to
be assayed, where gray indicates that the CG is located on a fragment whose molecular
weight is outside the usable mass window and blue indicates a uniquely assayable site.
Yellow highlights represent tagged/primer sequences, while lavender highlights denote
user-specified "required" sites.

6

inSilico Assay PredictionNucleotide position (bp)21T(+) 1 bp39 bp21C(+) 1 bp39 bp12T(−) 1 bp39 bp12C(−) 1 bp39 bpAGGAAGAGAGAAAATTTTCCCCTCTGCGTGAGAGAGTTGTCCGACAAAAAGCCTTCTCCCHowever, the large majority of assays are complicated by molecular weight overlaps
between CG-containing fragments and one or more non CG-containing fragments, or
alteratively between more than one CG-containing fragment. These overlaps reduce the
ability to resolve independent methylation status for a given site, and thus are flagged in
red to alert the user to this situation. All CG sites or fragments marked in red contain
some form of molecular weight overlap with one or more other fragments. CG sites that
are linked by gray arrows indicate fragments that have molecular weight overlap(s) with
other CG-containing fragments. Methylation status at these labeled sites cannot be
measured independently from the methylation status of overlapping CG dinucleotides
using the indicated reaction/strand combination(s). A simple example of such an assay
is shown below.

7

8

)
"
A
A
A
A
C
A
G
C
C
T
G
T
T
G
A
G
A
G
A
G
T
G
C
G
T
C
T
C
C
C
C
T
T
C
A
)
G
C
(
C
T
G
T
T
G
A
G
A
G
A
G
T
G
C
G
T
C
T
C
C
C
C
T
T
T
T
A
A
A
A
"
(
n
o
i
t
c
i
d
e
r
P
n
o
c
i
l
p
m
a

>

.
s
p
a
l
r
e
v
o

t
h
g
i
e
w
r
a
l
u
c
e
l
o
m
e
m
o
s

h
t
i
w
s
e
t
i
s
G
C
r
u
o
f

g
n
i
n
i
a
t
n
o
c

e
c
n
e
u
q
e
s

t
r
o
h
s

a

r
o
f

n
o
i
t
c
i
d
e
r
p

n
o
c
i
l

p
m
a

c
i
s
a
B

:
3

e
r
u
g
i
F

e
h
t

r
o
f

s
d
n
a
r
t
s

s
u
n
i
m
d
n
a

s
u
l
p

e
h
t

h
t
o
b

n
o

s
n
o
i
t
c
a
e
r

e
g
a
v
a
e
l
c
-
C

d
n
a

T

r
o
f

n
w
o
h
s

e
r
a

s
n
r
e
t
t
a
p

n
o
i
t
a
t
n
e
m
g
a
r
f

e
v
i
t
a
t
u
P

,
d
e
y
a
s
s
a

e
b
o
t
y
t
i
l
i
b
a

r
i
e
h
t

o
t

g
n
i
d
r
o
c
c
a
d
e
d
o
c
-
r
o
l
o
c
d
n
a
d
e
r
e
b
m
u
n
e
r
a

)
s
e
l
c
r
i
c
d
e
l
l
fi
(

s
e
d
i
t
o
e
l
c
u
n
d
G
C

i

.
e
c
n
e
u
q
e
s
d
e
fi
i
c
e
p
s

,

w
o
d
n
i
w
s
s
a
m
e
l
b
a
s
u

e
h
t

e
d
i
s
t
u
o

s
i

t
h
g
i
e
w
r
a
l
u
c
e
l
o
m
e
s
o
h
w
t
n
e
m
g
a
r
f

a

n
o

d
e
t
a
c
o
l

s
i

G
C
e
h
t

t
a
h
t

s
e
t
a
c
i

d
n

i

y
a
r
g

e
r
e
h
w

d
e
k
n
i
L

.
e
t
i
s

e
l
b
a
y
a
s
s
a

y
l
e
u
q
i
n
u

a

s
e
t
a
c
i
d
n
i

e
u
l
b

d
n
a

,
t
n
e
m
g
a
r
f

r
e
h
t
o
n
a

h
t
i
w

p
a
l
r
e
v
o

t
h
g
i
e
w

r
a
l
u
c
e
l
o
m
a

s
e
t
a
c
i

d
n
i

d
e
r

t
n
e
s
e
r
p
e
r

s
t
h
g
i
l
h
g
i
h

w
o
l
l
e
Y

.
s
t
n
e
m
g
a
r
f

g
n
i
n
i
a
t
n
o
c
-
G
C

e
l
p
i
t
l
u
m
n
e
e
w
t
e
b

s
p
a
l
r
e
v
o

t
h
g
i
e
w

r
a
l
u
c
e
l
o
m
e
t
o
n
e
d

s
d
a
e
h
w
o
r
r
a

.
s
e
t
i
s

"
d
e
r
i
u
q
e
r
"

d
e
fi
i
c
e
p
s
-
r
e
s
u

e
t
o
n
e
d

s
t
h
g
i
l
h
g
i
h

r
e
d
n
e
v
a
l

e
l
i

h
w

,
s
e
c
n
e
u
q
e
s

r
e
m

i
r
p
/
d
e
g
g
a
t

9

inSilico Assay PredictionNucleotide position (bp)4321T(+) 1 bp68 bp4321C(+) 1 bp68 bp1234T(−) 1 bp68 bp1234C(−) 1 bp68 bpAGGAAGAGAGAAAATTTTCCCCTCTGCGTGAGAGAGTTGTCCGACTTCCCCTCTGCGTGAGAGAGTTGTCCGACAAAAAGCCTTCTCCC4 Conversion Controls

Accurate measurement of methylation status presupposes that the bisulphite conversion
reaction runs to completion. If, however, bisulphite conversion is incomplete, "methyla-
tion" measured at any CG dinucleotide will be composed of actual methylation mixed
with signal from remnant unconverted, unmethylated cytosines. For many target regions,
this issue is mitigated by selective amplification of fully-converted templates (primers
should contain at least 4 non-CG ’C’s). Nevertheless, amplicons may still contain some
background level of partially unconverted DNA: primer selection criteria occasionally
need to be relaxed, and PCR tends to enrich underrepresented sequences.

In order to measure levels of unconverted non-CG cytosines in a given MassArray
sample, we implemented a conversion control measurement function (evaluateConversion(),
which is itself a wrapper function for convControl()), to search the predicted frag-
mentation profile for non-CG cytosines that occur in the absence of CG dinucleotides.
Moreover, potential conversion controls are automatically filtered to remove any molec-
ular weight overlaps with other predicted fragments, so that they may be considered in
isolation.

The identification of fragments usable as conversion controls occurs during amplicon
prediction for a given sequence input. Approximately 91% of assays are likely to contain
such conversion controls, however, some amplicons may lack this particular measure-
able (Thompson et al., 2009). Called as an accessory function, convControl() defines
conversion control fragments wherever they meet the following criteria:

1. sequence containing no CGs

2. sequence containing at least one non-CG cytosine

3. sequence containing at least one TG

4. molecular weight within the useable mass window

5. no molecular weight overlap with other predicted fragments

6. no molecular weight overlap of sequence containing one unconverted cytosine with

other predicted fragments

Here is an example of usable conversion controls identified in a given amplicon.
Three reactions contain measureable conversion controls (labeled in green), however,
one reaction lacks usable conversion controls as shown.

10

11

)
"
G
C
T
T
C
A
A
C
G
A
C
C
C
T
A
G
G
G
A
C
A
A
A
T
T
A
A
A
C
A
A
A
A
A
T
G
T
T
C
G
T
T
T
C
T
C
C
C
T
G
T
C
C
A
T
C
C
T
T
T
T
A
T
A
C
C
T
C
A
C
G
G
G
G
A
C
C
T
G
T
C
C
"
(
n
o
i
t
c
i
d
e
r
P
n
o
c
i
l
p
m
a

>

e
v
i
t
a
t
u
P

.
s
l
o
r
t
n
o
c
n
o
i
s
r
e
v
n
o
c

e
l
b
a
s
u
f
o
n
o
i
t
a
c
fi
i
t
n
e
d
i

e
h
t
g
n
i
w
o
h
s

e
c
n
e
u
q
e
s

t
r
o
h
s
a
r
o
f
n
o
i
t
c
i

d
e
r
p
n
o
c
i
l

p
m
a
c
i
s
a
B

:
4
e
r
u
g
i
F

d
e
fi
i
c
e
p
s

e
h
t

r
o
f

s
d
n
a
r
t
s

s
u
n
i
m
d
n
a

s
u
l
p

e
h
t

h
t
o
b

n
o

s
n
o
i
t
c
a
e
r

e
g
a
v
a
e
l
c
-
C

d
n
a

T

r
o
f

n
w
o
h
s

e
r
a

s
n
r
e
t
t
a
p

n
o
i
t
a
t
n
e
m
g
a
r
f

e
r
e
h
w

,
d
e
y
a
s
s
a

e
b

o
t

y
t
i
l
i
b
a

r
i
e
h
t

o
t

g
n
i
d
r
o
c
c
a

d
e
d
o
c
-
r
o
l
o
c

d
n
a

d
e
r
e
b
m
u
n

e
r
a

)
s
e
l
c
r
i
c

d
e
l
l

fi
(

s
e
d

i
t
o
e
l
c
u
n

i

d
G
C

.
e
c
n
e
u
q
e
s

d
e
r

,

w
o
d
n
i
w

s
s
a
m
e
l
b
a
s
u

e
h
t

e
d
i
s
t
u
o

s
i

t
h
g
i
e
w

r
a
l
u
c
e
l
o
m
e
s
o
h
w

t
n
e
m
g
a
r
f

a

n
o

d
e
t
a
c
o
l

s
i

G
C

e
h
t

t
a
h
t

s
e
t
a
c
i

d
n
i

y
a
r
g

n
o
i
t
a
t
n
e
m
g
a
r
F

.
e
t
i
s

e
l
b
a
y
a
s
s
a

y
l
e
u
q
i
n
u

a

s
e
t
a
c
i
d
n
i

e
u
l
b

d
n
a

,
t
n
e
m
g
a
r
f

r
e
h
t
o
n
a

h
t
i
w
p
a
l
r
e
v
o

t
h
g
i
e
w
r
a
l
u
c
e
l
o
m
a

s
e
t
a
c
i
d
n
i

.
s
l
o
r
t
n
o
c

n
o
i
s
r
e
v
n
o
c

e
l
b
a
s
u

g
n
i
t
a
c
i
d
n
i

s
t
n
e
m
g
a
r
f

n
e
e
r
g

f
o

n
o
i
t
i
d
d
a

e
h
t

h
t
i
w

,
s
r
o
l
o
c

g
n
i
d
n
o
p
s
e
r
r
o
c

n

i

n
w
o
h
s

e
r
a

s
n
r
e
t
t
a
p

.
s
e
c
n
e
u
q
e
s

r
e
m

i
r
p
/
d
e
g
g
a
t

t
n
e
s
e
r
p
e
r

s
t
h
g
i
l

h
g
i

h
w
o
l
l
e
Y

12

inSilico Assay PredictionNucleotide position (bp)1T(+) 1 bp82 bp1C(+) 1 bp82 bp1T(−) 1 bp82 bp1C(−) 1 bp82 bpAGGAAGAGAGCCTGTCCAGGGGCACTCCATATTTTCCTACCTGTCCCTCTTTGCTTGTAAAAACAAATTAAACAGGGATCCCAGCAACTTCGAGCCTTCTCCCThose fragments meeting the above criteria are flagged appropriately and are treated
as if they contained a CG, thus enabling the software to determine the extent of the
bisulphite conversion reaction. We then applied this tool to data from a number of
samples and show detected levels of unconverted cytosines for two examples. For the
large majority of samples, we find that bisulphite conversion is near-complete (rang-
ing from 98-100%). However, we also show significant retention of unconverted cy-
tosines for an amplicon (rat chr17:48916975-48917295, rn4 Nov. 2004 assembly, UCSC
Genome Browser) that approaches 25%. This incomplete conversion is a relatively rare
experimental outcome in our experience, nevertheless it demonstrates the necessity of a
conversion control measure as part of each experiment to ensure accuracy of the data
(Thompson et al., 2009).

Figure 5: Measurement of conversion controls for two amplicons shows variable extent
of bisulphite conversion. Conversion controls were measured for two different amplicons
using two sets of six biological replicates (each, the product of a separate bisulphite
conversion reaction); samples (labeled 1-6) are shown here divided by amplicon (one
set at left, one set at right). Bar height (black) depicts the percentage of unconverted
cytosines detected, with 0% indicating complete conversion of measured cytosines and
100% indicating a complete failure of conversion. Four of six samples among the second
set (at right) show significant retention of unconverted cytosines (numbered 1-4), as
measured by conversion controls.

13

5 Data Import

In order for MassArray data to be loaded into an R workspace using this software, it
must first be exported from Sequenom’s EpiTyper in a tab-delimited file format. Please
note that it is imperative that a single amplicon be exported at a single time, otherwise
the import will fail. Once you have successfully opened an individual amplicon in the
EpiTyper application, enable display of the ’Matched Peaks’ tab, both the ’T’ and ’C’
reactions, and the ’Show All Matched Peaks’ and ’Show All Missing Peaks’ options. Data
must be exported using the ’Export Grid’ command in a tab-delimited text format. For
further clarification and support, consult the EpiTyper Application Guide provided with
the software or available from the Sequenom website.

Once data has been properly exported, it may be loaded into an open R workspace.
An example of the import commands for an amplicon with two samples (A and B) is
shown here:

> sequence <- "CCAGGTCCAAAGGTTCAGACCAGTCTGAA>CCTGTCCAGGGGCACTCCATATTTTCC"
> sequence <- paste(sequence, "TACCTGTCCCTCTTTGCTTGTAAAAACAAATTAAACAGGGA", sep="")
> sequence <- paste(sequence, "TCCCAGCAACTTCGGGGCATGTGTGTAACTGTGCAAGGAGC", sep="")
> sequence <- paste(sequence, "GCGAAGCCCAGAGCATCGCCCTAGAGTTCGGGCCGCAGCTG", sep="")
> sequence <- paste(sequence, "CAGAGGCACATCTGGAAAAGGGGGAGGGGTCGAAGCGGAGG", sep="")
> sequence <- paste(sequence, "GGACAAGAAGCCCCCAAACGACTAGCTTCTGGGTGCAGAGT", sep="")
> sequence <- paste(sequence, "CTGTGTCAC(CG)GGGGTTAGTTACCTGTCCTACGTTGATG", sep="")
> sequence <- paste(sequence, "AATCCGTACTTGCTGGCTATGCGGTCTGCCTCCGCGAATCC", sep="")
> sequence <- paste(sequence, "GC(CG)GC<GATCTTCACTGCCCAGTGGTTGGTGTA", sep="")
> data <- new("MassArrayData", sequence, file="Example.txt")

Performing inSilico Fragmentation: T, C ... FINISHED
Importing matched peaks file (Example.txt):

Reading assay (Example), 2T+0C rxns (EpiTyper v1.0.5):

T reaction:

Reading sample (A) ... FINISHED
Reading sample (B) ... FINISHED

Analyzing conversion control(s) ... FINISHED
Estimating primer dimer level(s) ... FINISHED
Estimating adduct level(s) ... FINISHED
Analyzing CpG methylation ..... FINISHED

Note that additional options may be specified. For more information, consult the
description of the MassArrayData-class in the R help documentation. Also, note that
the MassArrayData-class is a structural composite of many individual pieces of data
describing everything from the fragmentation structure (MassArrayFragment-class) to
the actual MassArray peak information (MassArrayPeak-class, which taken together
form spectral data – see MassArraySpectrum-class). The user need not concern them-
selves with these particulars as data import creates the relevant structures automatically.

14

However, individual data elements may be interrogated or modified through knowledge
of this structure which may prove useful in certain circumstances after data has already
been imported. Please consult the relevant help files for a further discussion of each of
these detailed data structures.

15

6 Data Visualization

We have implemented a visual alternative to the epigram that takes methylation data
and displays it in the form of color-filled bars, where the shaded height indicates percent
methylation.

> plot(data, collapse=FALSE, bars=FALSE, scale=FALSE)

Figure 6: Basic plotting tool for MassArray data (individual samples). Bar height
denotes percent methylation on a scale from 0% (low) to 100% (high) for each CG
(eighteen of which are shown here in order from left to right). Note red stars indicate
user-defined "required" sites. CG dinucleotides located on a fragment with other CGs
are indicated as bars with yellow background. CG sites that are putatively outside the
usable mass window are shown in gray outline.

16

Nucleotide position (CG number)123456789101112131415161718123456789101112131415161718A****B****This graphical depiction also includes the ability to display "error bars" which corre-
spond to the median absolute deviation as a measure of variability among a collection of
measurements. The methylation data displayed represents the average among samples.

> plot(data, collapse=TRUE, bars=TRUE, scale=FALSE)

Figure 7: Basic plotting tool for MassArray data (data averaged across samples). Bar
height denotes percent methylation on a scale from 0% (low) to 100% (high) for each CG
(eighteen of which are shown here in order from left to right), with error bars indicating
median absolute deviation. Note red stars indicate user-defined "required" sites. CG
dinucleotides located on a fragment with other CGs are indicated as bars with yellow
background. CG sites that are putatively outside the usable mass window are shown in
gray outline.

17

Nucleotide position (CG number)123456789101112131415161718123456789101112131415161718****The data can also be displayed in a positionally-informative manner, wherein the x
axis represents relative nucleotide position for each measured CG. Display of error bars
may be optionally deactivated.

> plot(data, collapse=TRUE, bars=FALSE, scale=TRUE)

Figure 8: Basic plotting tool for MassArray data (data scaled to relative nucleotide
positions). Bar height denotes percent methylation on a scale from 0% (low) to 100%
(high) for each CG (eighteen of which are shown here in order from left to right), with
error bars indicating median absolute deviation. Note red stars indicate user-defined
"required" sites. CG dinucleotides located on a fragment with other CGs are indicated
as bars with yellow background. CG sites that are putatively outside the usable mass
window are shown in gray outline.

18

Nucleotide position (bp)050100150200250300350400123456789101112131415161718AGGAAGAGAGCCAGGTCCAAAGGTTCAGACCAGTCTGAACCTGTCCAGGGGCACTCCATATTTTCCTACCTGTCCCTCTTTGCTTGTAAAAACAAATTAAACAGGGATCCCAGCAACTTCGGGGCATGTGTGTAACTGTGCAAGGAGCGCGAAGCCCAGAGCATCGCCCTAGAGTTCGGGCCGCAGCTGCAGAGGCACATCTGGAAAAGGGGGAGGGGTCGAAGCGGAGGGGACAAGAAGCCCCCAAACGACTAGCTTCTGGGTGCAGAGTCTGTGTCACCGGGGGTTAGTTACCTGTCCTACGTTGATGAATCCGTACTTGCTGGCTATGCGGTCTGCCTCCGCGAATCCGCCGGCGATCTTCACTGCCCAGTGGTTGGTGTAAGCCTTCTCCC****7 Single Nucleotide Polymorphism Detection

Single nucleotide polymorphisms (SNP) can interrupt the ability to interpret methylation
status at one or more CG dinucleotides. This R package thus enables the identification
of putative SNPs by comparison of expected and observed data. Any mismatches may
be analyzed using an exhaustive string substitution approach (identifySNPs()), where
each existent base pair in the sequence is substituted with one of the three remaining
bases or a gap (representing a single base-pair deletion) and then judged for its ability
to modify the expected fragmentation pattern in a manner that matches the observed
data. The identifySNPs() function, however, serves as an internal method. The best
way to access the built-in SNP dectection is via the evaluateSNPs() function.

19

> SNP.results <- evaluateSNPs(data)

Figure 9: Graphical output from putative SNP detection. The T-cleavage fragmentation
profile is shown (top panel). CG dinucleotides (filled circles) are numbered and colored
in blue. Other fragments are colored according to their ability to be assayed: fragment
molecular weight outside the testable mass window (gray), fragment molecular weight
overlapping with another fragment (red), fragment containing a potential conversion
control (green), or fragment uniquely assayable but containing no CGs (black). Puta-
tive SNPs are shown directly below their location within the amplicon fragmentation
profile. Each row represents analysis from a single sample (two different biological sam-
ples). Small, gray symbols represent potential SNPs that do not have sufficient evidence
(presence of a new peak with corresponding absence of an expected peak). Larger black
symbols indicate a potential SNP with both new peaks and missing expected peaks.
Triangles indicate base pair substitution, while circles indicate single base pair deletion.

20

inSilico SNP PredictionNucleotide position (bp)T: 1 bp374 bp16..13..1211109875.42.1AOOOOOOOOOOOOOOBThe data returned from a call to evaluateSNPs() includes a list of potential SNPs
for each identified novel peak among the input MassArray spectrum. Each novel peak
is associated with the following list elements:

1. SNP - Contains a list of SNPs, each of which takes the form "position:base" where
position is the base pair location within the amplicon sequence, and base is the
mutated character

2. SNR - Contains a numerical list of signal-to-noise ratios corresponding to the ex-
pected original peak for the fragment mapping to the identified SNP position

3. fragment - Contains a numerical list of fragment IDs which map the SNP position

to a specific fragment

4. SNP.quality - Contains a numerical list (values ranging from 0 to 2, with 0 being
a highly unlikely SNP and 2 being a SNP with increased likelihood. This number
is calculated as a function of new peak SNR and expected peak SNR.

5. samples - Contains a list of samples whose spectral data contained the given new

peak

6. count - Specifies the number of unique SNP and sample pairs, exactly equivalent

to the length of SNP, SNR, fragment, SNP.quality, or samples

Note that each novel peak may be explained by any number of potential SNPs;
the list returned only includes the most reliable, but the redundant nature of the data
necessitates returning a nested list, as shown below:

> length(SNP.results)

[1] 2

> SNP.results[[2]]

$sequence
[1] "AAACGGT"

$fragment
[1] 10

6 10

$SNR
[1] 16.0079 29.8730 29.8730

$SNP
[1] "312:G" "355:T" "312:G"

21

$SNP.quality
[1] 1.742775 1.000000 2.000000

$samples
[1] "A" "B" "B"

$count
[1] 3

22

A Previous Release Notes

• No previous releases to date.

23

References

Sequenom. EpiTYPER Application Guide. Sequenom, Inc., San Diego, CA, v1.0.5

edition, 2008.

R.F. Thompson, M. Suzuki, K.W. Lau, and J.M. Greally. A pipeline for the quantitative
analysis of cg dinucleotide methylation using mass spectrometry. Bioinformatics, 25
(17):2164–2170, 2009.

24

