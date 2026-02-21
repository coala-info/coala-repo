Motif import, export, and manipulation

Benjamin Jean-Marie Tremblay∗

17 October 2021

Abstract

The universalmotif package offers a number of functions to manipulate motifs. These are introduced
and explored here, including those relating to: import, export, motif modification, creation, visualization,
and other miscellaneous utilities.

Contents

1 Introduction

2 The universalmotif class and conversion utilities

2.1 The universalmotif class . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 Converting to and from another package’s class . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Importing and exporting motifs

Importing . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.1
3.2 Exporting . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4 Modifying motifs and related functions

4.1 Converting motif type . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.2 Merging motifs . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.3 Motif reverse complement . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.4 Switching between DNA and RNA alphabets
. . . . . . . . . . . . . . . . . . . . . . . . . . .
4.5 Motif trimming . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.6 Rounding motifs

5 Motif creation

5.1 From a PCM/PPM/PWM/ICM matrix . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5.2 From sequences or character strings
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5.3 Generating random motifs . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

6 Motif visualization
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6.1 Motif logos
6.2 Stacked motif logos . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6.3 Plot arbitrary text logos . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

7 Higher-order motifs

8 Tidy motif manipulation with the universalmotif_df data structure

9 Miscellaneous motif utilities

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
9.1 DNA/RNA/AA consensus functions
9.2 Filter through lists of motifs . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

∗benjamin.tremblay@uwaterloo.ca

1

2

2
2
4

6
6
6

6
6
9
10
11
12
13

14
14
15
15

16
16
19
20

21

23

26
26
26

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
9.3 Generate random motif matches
9.4 Motif shuffling . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
9.5 Scoring and match functions . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
9.6 Type conversion functions . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

Session info

References

1

Introduction

27
27
28
29

30

31

This vignette will introduce the universalmotif class and its structure, the import and export of motifs in
R, basic motif manipulation, creation, and visualization. For an introduction to sequence motifs, see the
introductory vignette. For sequence-related utilities, see the sequences vignette. For motif comparisons and
P-values, see the motif comparisons and P-values vignette.

2 The universalmotif class and conversion utilities

2.1 The universalmotif class

The universalmotif package stores motifs using the universalmotif class. The most basic universalmotif
object exposes the name, alphabet, type, type, strand, icscore, consensus, and motif slots; furthermore,
the pseudocount and bkg slots are also stored but not shown. universalmotif class motifs can be PCM,
PPM, PWM, or ICM type.

Motif name:
Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:

library(universalmotif)
data(examplemotif)
examplemotif
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
W
#> A 0 1 0 1 0.5 1 0.5
#> C 0 0 0 0 0.0 0 0.0
#> G 0 0 0 0 0.0 0 0.0
#> T 1 0 1 0 0.5 0 0.5

T A T A

W A

motif
DNA
PPM
+-
11.54
1
TATAWAW

A brief description of all the available slots:

• name: motif name
• altname: (optional) alternative motif name
• family: (optional) a word representing the transcription factor or matrix family
• organism: (optional) organism of origin
• motif: the actual motif matrix
• alphabet: motif alphabet
• type: motif ‘type’, one of PCM, PPM, PWM, ICM; see the introductory vignette
• icscore: (generated automatically) Sum of information content for the motif
• nsites: (optional) number of sites the motif was created from

2

• pseudocount: this value to added to the motif matrix during certain type conversions; this is necessary

to avoid -Inf values from appearing in PWM type motifs

• bkg: a named vector of probabilities which represent the background letter frequencies
• bkgsites: (optional) total number of background sequences from motif creation
• consensus: (generated automatically) for DNA/RNA/AA motifs, the motif consensus
• strand: strand motif can be found on
• pval: (optional) P-value from de novo motif search
• qval: (optional) Q-value from de novo motif search
• eval: (optional) E-value from de novo motif search
• multifreq: (optional) higher-order motif representations.
• extrainfo: (optional) any extra motif information that cannot fit in the existing slots

The other slots will be shown as they are filled.

library(universalmotif)
data(examplemotif)

## The various slots can be accessed individually using `[`

examplemotif["consensus"]
#> [1] "TATAWAW"

## To change a slot, use `[<-`

Motif name:
Family:
Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:

examplemotif["family"] <- "My motif family"
examplemotif
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
W
#> A 0 1 0 1 0.5 1 0.5
#> C 0 0 0 0 0.0 0 0.0
#> G 0 0 0 0 0.0 0 0.0
#> T 1 0 1 0 0.5 0 0.5

motif
My motif family
DNA
PPM
+-
11.54
1
TATAWAW

T A T A

W A

Though the slots can easily be changed manually with [<-, a number of safeguards have been put in place
for some of the slots which will prevent incorrect values from being introduced.

library(universalmotif)
data(examplemotif)

## The consensus slot is dependent on the motif matrix

examplemotif["consensus"]
#> [1] "TATAWAW"

## Changing this would mean it no longer matches the motif

examplemotif["consensus"] <- "GGGAGAG"

3

#> Error in .local(x, i, ..., value): this slot is unmodifiable with [<-

## Another example of trying to change a protected slot:

examplemotif["strand"] <- "x"
#> Error: * strand must be one of +, -, +-

Below the exposed metadata slots, the actual ‘motif’ matrix is shown. Each position is its own column: row
names showing the alphabet letters, and the column names showing the consensus letter at each position.

2.2 Converting to and from another package’s class

The universalmotif package aims to unify most of the motif-related Bioconductor packages by provid-
ing the convert_motifs() function. This allows for easy transition between supported packages (see
?convert_motifs for a complete list of supported packages). Should you ever come across a motif class from
another Bioconductor package which is not supported by the universalmotif package, but believe it should
be, then feel free to bring it up with me.

The convert_motifs function is embedded in most of the universalmotif functions, meaning that compat-
ible motif classes from other packages can be used without needed to manually convert them first. However
keep in mind some conversions are final. Furthermore, internally, all motifs regardless of class are handled
as universalmotif objects, even if the returning class is not. This will result in at times slightly different
objects (though usually no information should be lost).

library(universalmotif)
library(MotifDb)
data(examplemotif)
data(MA0003.2)

## convert from a `universalmotif` motif to another class

convert_motifs(examplemotif, "TFBSTools-PWMatrix")
#> Note: motif [motif] has an empty nsites slot, using 100.
#> An object of class PWMatrix
#> ID:
#> Name: motif
#> Matrix Class: Unknown
#> strand: *
#> Pseudocounts: 1
#> Tags:
#> list()
#> Background:
#>
T
C
A
#> 0.25 0.25 0.25 0.25
#> Matrix:
W
#>
T
#> A -6.658211 1.989247 -6.658211
0.9928402
#> C -6.658211 -6.658211 -6.658211 -6.658211 -6.6582115 -6.658211 -6.6582115
#> G -6.658211 -6.658211 -6.658211 -6.658211 -6.6582115 -6.658211 -6.6582115
0.9928402
#> T 1.989247 -6.658211

W
0.9928402

0.9928402 -6.658211

1.989247 -6.658211

A
1.989247

A
1.989247

A

G

T

## convert to universalmotif

convert_motifs(MA0003.2)
#>

4

Motif name:
Alternate name:
Family:
Organism:
Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:
Target sites:
Extra info:

TFAP2A
MA0003.2
Helix-Loop-Helix
9606
DNA
PCM
+
12.9
1
NNNNGCCYSAGGSCA
5098
[centrality_logp] -4343
[family] Helix-Loop-Helix
[medline] 10497269
...

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
N
#> A 1387 2141 727 1517
#> C 1630 1060 1506 519 1199 5098 4762 1736 2729
85 1715
985 3712
#> G 851
308
131
#> T 1230 1105 1981 2077

336 3215

792 884

G
56

Y
62

C
0

C
0

0
0

0

N

N

N

C

S

S
116

G
460
0

A
346 3738
236
920 4638 5098 3455
84
204

A
G
451 3146
0
690
0 1443 3672
465
168
510 1094

0

0

## convert between two packages

convert_motifs(MotifDb[1], "TFBSTools-ICMatrix")
#> Note: motif [ABF2] has an empty nsites slot, using 100.
#> [[1]]
#> An object of class ICMatrix
#> ID: badis.ABF2
#> Name: ABF2
#> Matrix Class: Unknown
#> strand: *
#> Pseudocounts: 1
#> Schneider correction: FALSE
#> Tags:
#> $dataSource
#> [1] "ScerTF"
#>
#> Background:
#>
T
C
A
#> 0.25 0.25 0.25 0.25
#> Matrix:
A
#>
#> A 0.08997357 0.02119039 0.02119039 1.64861232 0.02119039 1.43716039
#> C 0.08997357 1.64861232 0.02119039 0.02119039 0.02119039 0.03430887
#> G 0.02188546 0.02119039 0.02119039 0.02119039 1.64861232 0.03430887
#> T 0.78058151 0.02119039 1.64861232 0.02119039 0.02119039 0.03430887

C

T

T

G

G

A

5

3

Importing and exporting motifs

3.1 Importing

The universalmotif package offers a number of read_*() functions to allow for easy import of various
motif formats. These include:

• read_cisbp(): CIS-BP (Weirauch et al. 2014)
• read_homer(): HOMER (Heinz et al. 2010)
• read_jaspar(): JASPAR (Khan et al. 2018)
• read_matrix(): generic reader for simply formatted motifs
• read_meme(): MEME (Bailey et al. 2009)
• read_motifs(): native universalmotif format (not recommended; use saveRDS() instead)
• read_transfac(): TRANSFAC (Wingender et al. 1996)
• read_uniprobe(): UniPROBE (Hume et al. 2015)

These functions should work natively with these formats, but if you are generating your own motifs in one
of these formats than it must adhere quite strictly to the format. An example of each of these is included
in this package (see system.file("extdata", package="universalmotif")). If you know of additional
motif formats which are not supported in the universalmotif package that you believe should be, or of any
mistakes in the way the universalmotif package parses supported formats, then please let me know.

3.2 Exporting

Compatible motif classes can be written to disk using:

• write_homer()
• write_jaspar()
• write_matrix()
• write_meme()
• write_motifs()
• write_transfac()

The write_matrix() function, similar to its read_matrix() counterpart, can write motifs as simple matrices
with an optional header. Additionally, please keep in mind format limitations. For example, multiple MEME
motifs written to a single file will all share the same alphabet, with identical background letter frequencies.

4 Modifying motifs and related functions

4.1 Converting motif type

Any universalmotif object can transition between PCM, PPM, PWM, and ICM types seamlessly using the
convert_type() function. The only exception to this is if the ICM calculation is performed with sample
correction, or as relative entropy. If this occurs, then back conversion to another type will be inaccurate (and
convert_type() would not warn you, since it won’t know this has taken place).
library(universalmotif)
data(examplemotif)

## This motif is currently a PPM:

examplemotif["type"]
#> [1] "PPM"

When converting to PCM, the nsites slot is needed to tell it how many sequences it originated from. If
empty, 100 is used.

6

Motif name:
Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:

convert_type(examplemotif, "PCM")
#> Note: motif [motif] has an empty nsites slot, using 100.
#>
#>
#>
#>
#>
#>
#>
#>
#>
T
W
W
T
A
#>
0 100 50 100 50
0 100
#> A
0
0
0
0
0
#> C
0
0
0
0
0
#> G
0
0
0
0
0 50
0 50
0 100
#> T 100

motif
DNA
PCM
+-
11.54
1
TATAWAW

A

A

For converting to PWM, the pseudocount slot is used to determine if any correction should be applied:
examplemotif["pseudocount"]
#> [1] 1
convert_type(examplemotif, "PWM")
#> Note: motif [motif] has an empty nsites slot, using 100.
#>
#>
#>
#>
#>
#>
#>
#>
#>
W
#>
A
#> A -6.66 1.99 -6.66 1.99
0.99
#> C -6.66 -6.66 -6.66 -6.66 -6.66 -6.66 -6.66
#> G -6.66 -6.66 -6.66 -6.66 -6.66 -6.66 -6.66
0.99
#> T 1.99 -6.66 1.99 -6.66

Motif name:
Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:

motif
DNA
PWM
+-
11.54
1
TATAWAW

0.99 -6.66

W
0.99

A
1.99

T

T

A

You can either change the pseudocount slot manually beforehand, or pass one to convert_type().
convert_type(examplemotif, "PWM", pseudocount = 1)
#> Note: motif [motif] has an empty nsites slot, using 100.
#>
#>
#>
#>
#>
#>
#>
#>
#>
W
#>
A
0.99
#> A -6.66 1.99 -6.66 1.99
#> C -6.66 -6.66 -6.66 -6.66 -6.66 -6.66 -6.66
#> G -6.66 -6.66 -6.66 -6.66 -6.66 -6.66 -6.66

Motif name:
Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:

motif
DNA
PWM
+-
11.54
1
TATAWAW

W
0.99

A
1.99

T

A

T

7

#> T 1.99 -6.66 1.99 -6.66

0.99 -6.66

0.99

There are a couple of additional options for ICM conversion: nsize_correction and relative_entropy.
The former uses the TFBSTools:::schneider_correction() function (and thus requires that the TFBSTools
package be installed) for sample size correction. The latter uses the bkg slot to calculate information content.
See the IntroductionToSequenceMotifs vignette for an overview on the various types of ICM calculations.

Motif name:
Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:
Target sites:

examplemotif["nsites"] <- 10
convert_type(examplemotif, "ICM", nsize_correction = FALSE)
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
W
#> A 0 2 0 2 0.5 2 0.5
#> C 0 0 0 0 0.0 0 0.0
#> G 0 0 0 0 0.0 0 0.0
#> T 2 0 2 0 0.5 0 0.5

motif
DNA
ICM
+-
11.54
1
TATAWAW
10

T A T A

W A

motif
DNA
ICM
+-
11.54
1
TATAWAW
10

Motif name:
Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:
Target sites:

convert_type(examplemotif, "ICM", nsize_correction = TRUE)
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
W
#> A 0.00 1.75 0.00 1.75 0.38 1.75 0.38
#> C 0.00 0.00 0.00 0.00 0.00 0.00 0.00
#> G 0.00 0.00 0.00 0.00 0.00 0.00 0.00
#> T 1.75 0.00 1.75 0.00 0.38 0.00 0.38

T

A

A

A

W

T

examplemotif["bkg"] <- c(A = 0.4, C = 0.1, G = 0.1, T = 0.4)
convert_type(examplemotif, "ICM", relative_entropy = TRUE)
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

Motif name:
Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:
Target sites:

motif
DNA
ICM
+-
11.54
1
TATAWAW
10

8

A

A

T

T

W
#>
#> A 0.00 1.32 0.00 1.32 0.16 1.32 0.16
#> C 0.00 0.00 0.00 0.00 0.00 0.00 0.00
#> G 0.00 0.00 0.00 0.00 0.00 0.00 0.00
#> T 1.32 0.00 1.32 0.00 0.16 0.00 0.16

A

W

4.2 Merging motifs

The universalmotif package includes the merge_motifs() function to combine motifs. Motifs are first
aligned, and the best match found before the motif matrices are averaged. The implementation for this is
identical to that used by compare_motifs() (see the motif comparisons vignette for more information).
library(universalmotif)

m1 <- create_motif("TTAAACCCC", name = "1")
m2 <- create_motif("AACC", name = "2")
m3 <- create_motif("AACCCCGG", name = "3")

view_motifs(c(m1, m2, m3),

show.positions.once = FALSE, show.names = FALSE)

view_motifs(merge_motifs(c(m1, m2, m3), method = "PCC"))

9

123456781234123456789012012012bitsThis functionality can also be automated to reduce the number of overly similar motifs in larger datasets via
the merge_similar() function.
library(universalmotif)
library(MotifDb)

motifs <- filter_motifs(MotifDb, family = "bHLH")[1:100]
#> motifs converted to class 'universalmotif'
length(motifs)
#> [1] 100

motifs <- merge_similar(motifs)
length(motifs)
#> [1] 63

Comparison and merging parameters can be fine-tuned as users wish. See the compare_motifs() and
merge_motifs() documentation for more details, as well as the “Motif comparison and P-values” vignette.

4.3 Motif reverse complement

Get the reverse complement of a motif.

library(universalmotif)
data(examplemotif)

## Quickly switch to the reverse complement of a motif

## Original:

Motif name:
Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:

examplemotif
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
W
#> A 0 1 0 1 0.5 1 0.5
#> C 0 0 0 0 0.0 0 0.0
#> G 0 0 0 0 0.0 0 0.0

T A T A

W A

motif
DNA
PPM
+-
11.54
1
TATAWAW

10

0121234567891011bits#> T 1 0 1 0 0.5 0 0.5

## Reverse complement:

Motif name:
Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:

motif_rc(examplemotif)
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
W T A T A
#> A 0.5 0 0.5 0 1 0 1
#> C 0.0 0 0.0 0 0 0 0
#> G 0.0 0 0.0 0 0 0 0
#> T 0.5 1 0.5 1 0 1 0

W T

motif
DNA
PPM
+-
11.54
1
WTWTATA

4.4 Switching between DNA and RNA alphabets

Since not all motif formats or programs support RNA alphabets by default, the switch_alph() function can
quickly go between DNA and RNA motifs.

library(universalmotif)
data(examplemotif)

## DNA --> RNA

motif
RNA
PPM
+-
11.54
1
UAUAWAW

Motif name:
Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:

switch_alph(examplemotif)
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
W
#> A 0 1 0 1 0.5 1 0.5
#> C 0 0 0 0 0.0 0 0.0
#> G 0 0 0 0 0.0 0 0.0
#> U 1 0 1 0 0.5 0 0.5

U A U A

W A

## RNA --> DNA

motif <- create_motif(alphabet = "RNA")
motif
#>
#>
#>
#>

Motif name:
Alphabet:
Type:

motif
RNA
PPM

11

+-
12.67
0
UCUGYRGKAU

Strands:
Total IC:
Pseudocount:
Consensus:

#>
#>
#>
#>
#>
#>
A U
#> A 0.00 0.01 0.02 0.00 0.07 0.41 0.00 0.10 0.9 0
#> C 0.00 0.80 0.01 0.24 0.43 0.00 0.07 0.00 0.0 0
#> G 0.01 0.00 0.00 0.66 0.01 0.38 0.93 0.32 0.0 0
#> U 0.99 0.18 0.96 0.10 0.49 0.21 0.00 0.58 0.1 1

R

G

U

K

C

Y

U

G

motif
DNA
PPM
+-
12.67
0
TCTGYRGKAT

Motif name:
Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:

switch_alph(motif)
#>
#>
#>
#>
#>
#>
#>
#>
#>
A T
#>
#> A 0.00 0.01 0.02 0.00 0.07 0.41 0.00 0.10 0.9 0
#> C 0.00 0.80 0.01 0.24 0.43 0.00 0.07 0.00 0.0 0
#> G 0.01 0.00 0.00 0.66 0.01 0.38 0.93 0.32 0.0 0
#> T 0.99 0.18 0.96 0.10 0.49 0.21 0.00 0.58 0.1 1

T

K

G

R

C

Y

T

G

4.5 Motif trimming

Get rid of low information content edges on motifs, such as NNCGGGCNN to CGGGC. The ‘amount’ of trimming
can also be controlled by setting a minimum required information content, as well as the direction of trimming
(by default both edges are trimmed).

library(universalmotif)

Motif name:
Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:

motif <- create_motif("NNGCSGCGGNN")
motif
#>
#>
#>
#>
#>
#>
#>
#>
#>
N
#>
#> A 0.25 0.25 0 0 0.0 0 0 0 0 0.25 0.25
#> C 0.25 0.25 0 1 0.5 0 1 0 0 0.25 0.25
#> G 0.25 0.25 1 0 0.5 1 0 1 1 0.25 0.25
#> T 0.25 0.25 0 0 0.0 0 0 0 0 0.25 0.25

motif
DNA
PPM
+-
13
0
NNGCSGCGGNN

S G C G G

N G C

N

N

trim_motifs(motif)
#>

12

G C

motif
DNA
PPM
+-
13
0
GCSGCGG
100

Motif name:
Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:
Target sites:

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
S G C G G
#> A 0 0 0.0 0 0 0 0
#> C 0 1 0.5 0 1 0 0
#> G 1 0 0.5 1 0 1 1
#> T 0 0 0.0 0 0 0 0
trim_motifs(motif, trim.from = "right")
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
S G C G G
N G C
#>
#> A 0.25 0.25 0 0 0.0 0 0 0 0
#> C 0.25 0.25 0 1 0.5 0 1 0 0
#> G 0.25 0.25 1 0 0.5 1 0 1 1
#> T 0.25 0.25 0 0 0.0 0 0 0 0

Motif name:
Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:
Target sites:

motif
DNA
PPM
+-
13
0
NNGCSGCGG
100

N

4.6 Rounding motifs

Round off near-zero probabilities.

motif1 <- create_motif("ATCGATGC", pseudocount = 10, type = "PPM", nsites = 100)
motif2 <- round_motif(motif1)
view_motifs(c(motif1, motif2))

13

5 Motif creation

Though universalmotif class motifs can be created using the new constructor, the universalmotif package
provides the create_motif() function which aims to provide a simpler interface to motif creation. The
universalmotif class was initially designed to work natively with DNA, RNA, and amino acid motifs.
Currently though, it can handle any custom alphabet just as easily. The only downsides to custom alphabets
is the lack of support for certain slots such as the consensus and strand slots.
The create_motif() function will be introduced here only briefly; see ?create_motif for details.

5.1 From a PCM/PPM/PWM/ICM matrix

Should you wish to make use of the universalmotif functions starting from a motif class unsupported by
convert_motifs(), you can instead manually create universalmotif class motifs using the create_motif()
function and the motif matrix.

motif.matrix <- matrix(c(0.7, 0.1, 0.1, 0.1,
0.7, 0.1, 0.1, 0.1,
0.1, 0.7, 0.1, 0.1,
0.1, 0.7, 0.1, 0.1,
0.1, 0.1, 0.7, 0.1,
0.1, 0.1, 0.7, 0.1,
0.1, 0.1, 0.1, 0.7,
0.1, 0.1, 0.1, 0.7), nrow = 4)

motif <- create_motif(motif.matrix, alphabet = "RNA", name = "My motif",

pseudocount = 1, nsites = 20, strand = "+")

## The 'type', 'icscore' and 'consensus' slots will be filled for you

motif
#>
#>
#>

Motif name:
Alphabet:

My motif
RNA

14

motif.1motif12345678012012bitsPPM
+
4.68
1
AACCGGUU
20

Type:
Strands:
Total IC:
Pseudocount:
Consensus:
Target sites:

#>
#>
#>
#>
#>
#>
#>
#>
U
#> A 0.7 0.7 0.1 0.1 0.1 0.1 0.1 0.1
#> C 0.1 0.1 0.7 0.7 0.1 0.1 0.1 0.1
#> G 0.1 0.1 0.1 0.1 0.7 0.7 0.1 0.1
#> U 0.1 0.1 0.1 0.1 0.1 0.1 0.7 0.7

C

A

A

U

C

G

G

As a brief aside: if you have a motif formatted simply as a matrix, you can still use it with the universalmotif
package functions natively without creating a motif with create_motif(), as convert_motifs() also has
the ability to handle motifs formatted simply as matrices. However it is much safer to first format the motif
beforehand with create_motif().

5.2 From sequences or character strings

If all you have is a particular consensus sequence in mind, you can easily create a full motif using
create_motif(). This can be convenient if you’d like to create a quick motif to use with an external
program such as from the MEME suite or HOMER. Note that ambiguity letters can be used with single strings.
motif <- create_motif("CCNSNGG", nsites = 50, pseudocount = 1)

## Now to disk:
## write_meme(motif, "meme_motif.txt")

motif
DNA
PPM
+-
8.39
1
CCNSNGG
50

Motif name:
Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:
Target sites:

motif
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
G
N
#> A 0.00 0.00 0.22 0.0 0.22 0.00 0.00
#> C 0.99 0.99 0.26 0.5 0.26 0.00 0.00
#> G 0.00 0.00 0.26 0.5 0.26 0.99 0.99
#> T 0.00 0.00 0.26 0.0 0.26 0.00 0.00

C

C

G

N

S

5.3 Generating random motifs

If you wish to, it’s easy to create random motifs. The values within the motif are generated using rgamma()
to avoid creating low information content motifs. If background probabilities are not provided, then they are
generated with rpois().
create_motif()
#>
#>

Motif name:

motif

15

DNA
PPM
+-
10.74
0
RAWGATTAWR

Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:

#>
#>
#>
#>
#>
#>
#>
#>
R
#> A 0.75 0.91 0.48 0.22 0.71 0.03 0.01 0.99 0.60 0.39
#> C 0.00 0.05 0.00 0.09 0.11 0.00 0.20 0.01 0.06 0.12
#> G 0.25 0.02 0.09 0.67 0.00 0.05 0.00 0.00 0.00 0.48
#> T 0.00 0.02 0.43 0.02 0.18 0.93 0.80 0.00 0.35 0.02

W

T

A

R

A

G

W

T

A

You can change the probabilities used to generate the values within the motif matrix:

motif
DNA
PPM
+-
11.98
0
GCCCYMYGCS

Motif name:
Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:

create_motif(bkg = c(A = 0.2, C = 0.4, G = 0.2, T = 0.2))
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
S
#> A 0.03 0.00 0.10 0.01 0.12 0.26 0.03 0.00 0.00 0.00
#> C 0.00 0.98 0.77 0.98 0.50 0.70 0.53 0.24 0.78 0.49
#> G 0.97 0.00 0.13 0.02 0.00 0.04 0.05 0.75 0.00 0.50
#> T 0.00 0.02 0.01 0.00 0.38 0.00 0.38 0.00 0.22 0.00

C

G

C

Y

C

G

Y

M

C

With a custom alphabet:

motif
EQRTWY
PPM
13.52
0

Motif name:
Alphabet:
Type:
Total IC:
Pseudocount:

create_motif(alphabet = "QWERTY")
#>
#>
#>
#>
#>
#>
#>
#>
#> E 0.00 0.41 0.22 0.45 0.01 0.00 0.01 0.00 0.02
#> Q 0.00 0.03 0.00 0.00 0.00 0.00 0.00 0.06 0.01
#> R 0.01 0.01 0.17 0.03 0.00 0.39 0.36 0.09 0.44
#> T 0.96 0.19 0.03 0.00 0.99 0.07 0.00 0.02 0.01
#> W 0.00 0.00 0.00 0.19 0.00 0.54 0.00 0.66 0.00
#> Y 0.03 0.36 0.58 0.33 0.00 0.00 0.64 0.16 0.52

[,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
0.32
0.10
0.00
0.20
0.33
0.04

6 Motif visualization

6.1 Motif logos

There are several packages which offer motif visualization capabilities, such as seqLogo, motifStack, and
ggseqlogo. The universalmotif package has its own implementation via the function view_motifs(),

16

which renders motifs using the ggplot2 package (similar to ggseqlogo). Here I will briefly show how to use
these to visualize universalmotif class motifs.
library(universalmotif)
data(examplemotif)

## With the native `view_motifs` function:
view_motifs(examplemotif)

The view_motifs() function generates ggplot objects; feel free to manipulate them as such. For example,
flipping the position numbers for larger motifs (where the text spacing can become tight):

view_motifs(create_motif(15)) +

ggplot2::theme(

axis.text.x = ggplot2::element_text(angle = 90, hjust = 1)

)

A large number of options are available for tuning the way motifs are plotted in view_motifs(). Visit the
documentation for more information.

Using the other Bioconductor packages to view universalmotif motifs is fairly easy as well:
## For all the following examples, simply passing the functions a PPM is
## sufficient
motif <- convert_type(examplemotif, "PPM")
## Only need the matrix itself
motif <- motif["motif"]

## seqLogo:

17

0121234567bits012123456789101112131415bitsseqLogo::seqLogo(motif)

## motifStack:
motifStack::plotMotifLogo(motif)
#> Loading required namespace: Cairo
#> Warning in checkValidSVG(doc, warn = warn): This picture may not have been
#> generated by Cairo graphics; errors may result
#> Warning in checkValidSVG(doc, warn = warn): This picture may not have been
#> generated by Cairo graphics; errors may result
#> Warning in checkValidSVG(doc, warn = warn): This picture may not have been
#> generated by Cairo graphics; errors may result
#> Warning in checkValidSVG(doc, warn = warn): This picture may not have been
#> generated by Cairo graphics; errors may result

Please report the issue at <https://github.com/omarwagih/ggseqlogo/issues>.

## ggseqlogo:
ggseqlogo::ggseqlogo(motif)
#> Warning: The `<scale>` argument of `guides()` cannot be `FALSE`. Use "none" instead as
#> of ggplot2 3.3.4.
#> i The deprecated feature was likely used in the ggseqlogo package.
#>
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
#> i Please use tidy evaluation idioms with `aes()`.
#> i See also `vignette("ggplot2-in-packages")` for more information.
#> i The deprecated feature was likely used in the ggseqlogo package.

18

1234567Position00.511.52Information content123456700.511.52positionbitsPlease report the issue at <https://github.com/omarwagih/ggseqlogo/issues>.

#>
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.

6.2 Stacked motif logos

The motifStack package allows for a number of different motif stacking visualizations. The universalmotif
package, while not capable of emulating most of these, still offers basic stacking via view_motifs(). The
motifs are aligned using compare_motifs().
library(universalmotif)
library(MotifDb)

motifs <- convert_motifs(MotifDb[50:54])
view_motifs(motifs, show.positions.once = FALSE, names.pos = "right")

19

0.00.51.01.52.01234567Bits6.3 Plot arbitrary text logos

The logo plotting capabilities of view_motifs() can be used for any kind of arbitrary text logo. All you
need is a numeric matrix (the heights of the characters), with the desired characters as row names. The
following example is taken from the view_logo() documentation.
library(universalmotif)
data(examplemotif)

## Start from a numeric matrix:
toplot <- examplemotif["motif"]

# Adjust the character heights as you wish (negative values are possible):
toplot[4] <- 2
toplot[20] <- -0.5

# Mix and match the number of characters per letter/position:
rownames(toplot)[1] <- "AA"

toplot <- toplot[c(1, 4), ]

toplot
#>
W
#> AA 0 1 0 1 0.5 1 0.5

T A T A

W A

20

AFT2MATA2MSN1 [RC]NRG2ROX1 [RC]1234567812345678123456781234567812345678012012012012012bits#> T 2 0 1 0 -0.5 0 0.5

view_logo(toplot)

7 Higher-order motifs

Though PCM, PPM, PWM, and ICM type motifs are still widely used today, a few ‘next generation’
motif formats have been proposed. These wish to add another layer of information to motifs: positional
interdependence. To illustrate this, consider the following sequences:

Table 1: Example sequences.

# Sequence

1
2
3
4
5
6

CAAAACC
CAAAACC
CAAAACC
CTTTTCC
CTTTTCC
CTTTTCC

This becomes the following PPM:

Table 2: Position Probability Matrix.

Position

1

A
C
G
T

0.0
1.0
0.0
0.0

2

0.5
0.0
0.0
0.5

3

0.5
0.0
0.0
0.5

4

0.5
0.0
0.0
0.5

5

0.5
0.0
0.0
0.5

6

0.0
1.0
0.0
0.0

7

0.0
1.0
0.0
0.0

Based on the PPM representation, all three of CAAAACC, CTTTTCC, and CTATACC are equally likely.
Though looking at the starting sequences, should CTATACC really be considered so? For transcription factor
binding sites, this sometimes is not the case. By incorporating this type of information into the motif, it can
allow for increased accuracy in motif searching. A few example implementations of this include: TFFM by
Mathelier and Wasserman (2013), BaMM by Siebert and Soding (2016), and KSM by Guo et al. (2018).

21

The universalmotif package implements its own, rather simplified, version of this concept. Plainly, the
standard PPM has been extended to include k-letter frequencies, with k being any number higher than 1.
For example, the 2-letter version of the table 2 motif would be:

Table 3: 2-letter probability matrix.

Position

1

AA
AC
AG
AT
CA
CC
CG
CT
GA
GC
GG
GT
TA
TC
TG
TT

0.0
0.0
0.0
0.0
0.5
0.0
0.0
0.5
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0

2

0.5
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.5

3

0.5
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.5

4

0.5
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.5

5

0.0
0.5
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.5
0.0
0.0

6

0.0
0.0
0.0
0.0
0.0
1.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0

This format shows the probability of each letter combined with the probability of the letter in the next
position. The seventh column has been dropped, since it is not needed: the information in the sixth column is
sufficient, and there is no eighth position to draw 2-letter probabilities from. Now, the probability of getting
CTATACC is no longer equal to CTTTTCC and CAAAACC. This information is kept in the multifreq slot
of universalmotif class motifs. To add this information, use the add_multifreq() function.
library(universalmotif)

motif <- create_motif("CWWWWCC", nsites = 6)
sequences <- DNAStringSet(rep(c("CAAAACC", "CTTTTCC"), 3))
motif.k2 <- add_multifreq(motif, sequences, add.k = 2)

## Alternatively:
# motif.k2 <- create_motif(sequences, add.multifreq = 2)

Motif name:
Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:
Target sites:
k-letter freqs:

motif.k2
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
W C C
W
#> A 0 0.5 0.5 0.5 0.5 0 0

C

W

W

motif
DNA
PPM
+-
10
0
CWWWWCC
6
2

22

#> C 1 0.0 0.0 0.0 0.0 1 1
#> G 0 0.0 0.0 0.0 0.0 0 0
#> T 0 0.5 0.5 0.5 0.5 0 0

To plot these motifs, use view_motifs():
view_motifs(motif.k2, use.freq = 2)

This information is most useful with functions such as scan_sequences() and enrich_motifs().
Though other tools in the universalmotif can work with multifreq motifs (such as motif_pvalue(),
compare_motifs()), keep in mind they are not as well supported as regular motifs (getting P-values from
multifreq motifs is exponentially slower, and P-values from using compare_motifs() for multifreq motifs
are not available by default). See the sequences vignette for using scan_sequences() with the multifreq
slot.

8 Tidy motif manipulation with the universalmotif_df data struc-

ture

For those who enjoy using the tidyverse functions for data handling, motifs can additionally represented
as the modified data.frame format: universalmotif_df. This format allows one to modify motif slots for
multiples motifs simultaneously using the universalmotif_df columns, and then return to a list of motifs
afterwards to resume use with universalmotif package functions. A few key functions have been provided
in relation to this format:

• to_df(): Generate a universalmotif_df object from a list of motifs.
• update_motifs(): After modifying the universalmotif_df object, apply these modifications to the

actual universalmotif objects (contained within the motif column).

• to_list(): Return to a list of universalmotif objects for use with universalmotif package functions.
Note that it is not required to use update_motifs() before using to_list(), as modifications will be
checked for and applied if found.

• requires_update(): Boolean check as

the universalmotif objects and the
to whether
universalmotif_df columns differ and require either a update_motifs() or to_list() call
to re-sync them.

library(universalmotif)
library(MotifDb)

## Obtain a `universalmotif_df` object
motifs <- to_df(MotifDb)
head(motifs)

23

024123456bitsaltname

type pseudocount

TCTAGA
CCGGAN
TGACGT
AGATC
GGAANAA
GTAAACA

icscore
organism consensus alphabet strand
9.371235
+-
7.538740
+-
9.801864
+-
6.567494
+-
+-
9.314287
+- 11.525400

motif name
#>
badis.ABF2 Scerevisiae
#> 1 <mot:ABF2> ABF2
badis.CAT8 Scerevisiae
#> 2 <mot:CAT8> CAT8
#> 3 <mot:CST6> CST6
badis.CST6 Scerevisiae
#> 4 <mot:ECM23> ECM23 badis.ECM23 Scerevisiae
badis.EDS1 Scerevisiae
#> 5 <mot:EDS1> EDS1
#> 6 <mot:FKH2> FKH2
badis.FKH2 Scerevisiae
#>
#> 1 PPM
#> 2 PPM
#> 3 PPM
#> 4 PPM
#> 5 PPM
#> 6 PPM
#>
#> [Hidden empty columns: family, nsites, bkgsites, pval, qval, eval.]

bkg dataSource
ScerTF
ScerTF
ScerTF
ScerTF
ScerTF
ScerTF

1 0.25, 0.....
1 0.25, 0.....
1 0.25, 0.....
1 0.25, 0.....
1 0.25, 0.....
1 0.25, 0.....

DNA
DNA
DNA
DNA
DNA
DNA

Some tidy manipulation:

library(dplyr)

motifs <- motifs %>%

mutate(bkg = case_when(

organism == "Athaliana" ~ list(c(A = 0.32, C = 0.18, G = 0.18, T = 0.32)),
TRUE ~ list(c(A = 0.25, C = 0.25, G = 0.25, T = 0.25))

))

name

strand

altname family

icscore type pseudocount

consensus alphabet
DNA
DNA
DNA
DNA
DNA
DNA

organism
AP2 Athaliana
MGCCGCCN
AP2 Athaliana NCRCCGCNNN
NNGCCGNNN
AP2 Athaliana
AP2 Athaliana
WATGTTGC
AP2 Athaliana NNGCCGNNNN
NNGCCGNN
AP2 Athaliana

head(filter(motifs, organism == "Athaliana"))
#>
motif
ORA59 M0005_1.02
#> 1 * <mot:ORA59>
#> 2 *
WIN1 M0006_1.02
<mot:WIN1>
#> 3 * <mot:AT1G..> AT1G22985 M0007_1.02
#> 4 *
TEM1 M0008_1.02
<mot:TEM1>
ERF11 M0009_1.02
#> 5 * <mot:ERF11>
#> 6 * <mot:RAP2.6>
RAP2.6 M0010_1.02
#>
#> 1
#> 2
#> 3
#> 4
#> 5
#> 6
#>
#> [Hidden empty columns: nsites, bkgsites, pval, qval, eval.]
#> [Rows marked with * are changed. Run update_motifs() or to_list() to apply
#>

bkg dataSource
1 0.32, 0..... cisbp_1.02
1 0.32, 0..... cisbp_1.02
1 0.32, 0..... cisbp_1.02
1 0.32, 0..... cisbp_1.02
1 0.32, 0..... cisbp_1.02
1 0.32, 0..... cisbp_1.02

+- 11.351632
+- 6.509679
+- 5.155725
+- 11.182383
+- 5.148803
+- 4.227144

PPM
PPM
PPM
PPM
PPM
PPM

changes.]

Feel free to add columns as well. You can add 1d vectors which will be added to the extrainfo slots of
motifs. (Note that they will be coerced to character vectors!)

motifs <- motifs %>%

mutate(MotifIndex = 1:n())

head(motifs)
motif
#>
#> 1 * <mot:ABF2>
#> 2 * <mot:CAT8>

altname

name
ABF2 badis.ABF2 Scerevisiae
CAT8 badis.CAT8 Scerevisiae

organism consensus alphabet strand
+-
+-

TCTAGA
CCGGAN

DNA
DNA

24

+-
+-
+-
+-

DNA
DNA
DNA
DNA

icscore type pseudocount

TGACGT
AGATC
GGAANAA
GTAAACA

badis.CST6 Scerevisiae
#> 3 * <mot:CST6> CST6
#> 4 * <mot:ECM23> ECM23 badis.ECM23 Scerevisiae
badis.EDS1 Scerevisiae
#> 5 * <mot:EDS1> EDS1
#> 6 * <mot:FKH2> FKH2
badis.FKH2 Scerevisiae
#>
#> 1 9.371235 PPM
#> 2 7.538740 PPM
#> 3 9.801864 PPM
#> 4 6.567494 PPM
#> 5 9.314287 PPM
#> 6 11.525400 PPM
#>
#> [Hidden empty columns: family, nsites, bkgsites, pval, qval, eval.]
#> [Rows marked with * are changed. Run update_motifs() or to_list() to apply
#>

bkg dataSource MotifIndex
1
2
3
4
5
6

1 0.25, 0.....
1 0.25, 0.....
1 0.25, 0.....
1 0.25, 0.....
1 0.25, 0.....
1 0.25, 0.....

ScerTF
ScerTF
ScerTF
ScerTF
ScerTF
ScerTF

changes.]

ABF2
badis.ABF2
Scerevisiae
DNA
PPM
+-
9.37
1
TCTAGA
[dataSource] ScerTF
[MotifIndex] 1

Motif name:
Alternate name:
Organism:
Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:
Extra info:

to_list(motifs)[[1]]
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
A
#> A 0.09 0.01 0.01 0.97 0.01 0.94
#> C 0.09 0.97 0.01 0.01 0.01 0.02
#> G 0.02 0.01 0.01 0.01 0.97 0.02
#> T 0.80 0.01 0.97 0.01 0.01 0.02

G

T

A

C

T

to preserve these).

If during the course of your manipulation you’ve generated temporary columns which you wish to drop, you
can set extrainfo = FALSE to discard all extra columns. Be careful though, this will discard any previously
existing extrainfo data as well.
to_list(motifs, extrainfo = FALSE)[[1]]
#> Discarding unknown slot(s) 'dataSource', 'MotifIndex' (set `extrainfo=TRUE`
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

Motif name:
Alternate name:
Organism:
Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:

ABF2
badis.ABF2
Scerevisiae
DNA
PPM
+-
9.37
1
TCTAGA

25

T

C

A

T

A
#>
#> A 0.09 0.01 0.01 0.97 0.01 0.94
#> C 0.09 0.97 0.01 0.01 0.01 0.02
#> G 0.02 0.01 0.01 0.01 0.97 0.02
#> T 0.80 0.01 0.97 0.01 0.01 0.02

G

9 Miscellaneous motif utilities

A number of convenience functions are included for manipulating motifs.

9.1 DNA/RNA/AA consensus functions

For DNA, RNA and AA motifs, the universalmotif will automatically generate a consensus string slot.
Furthermore, create_motif() can generate motifs from consensus strings. The internal functions for these
have been made available:

• consensus_to_ppm()
• consensus_to_ppmAA()
• get_consensus()
• get_consensusAA()
library(universalmotif)

get_consensus(c(A = 0.7, C = 0.1, G = 0.1, T = 0.1))
#> [1] "A"

consensus_to_ppm("G")
#> [1] 0.001 0.001 0.997 0.001

9.2 Filter through lists of motifs

Filter a list of motifs, using the universalmotif slots with filter_motifs().
library(universalmotif)
library(MotifDb)

## Let us extract all of the Arabidopsis and C. elegans motifs

motifs <- filter_motifs(MotifDb, organism = c("Athaliana", "Celegans"))
#> motifs converted to class 'universalmotif'

## Only keeping motifs with sufficient information content and length:

motifs <- filter_motifs(motifs, icscore = 10, width = 10)

altname family

head(summarise_motifs(motifs))
name
#>
ERF1 M0025_1.02
#> 1
ATERF6 M0027_1.02
#> 2
#> 3
ATCBF3 M0032_1.02
#> 4 AT2G18300 M0155_1.02
bHLH104 M0159_1.02
#> 5
#> 6
hlh-16 M0173_1.02
#>

nsites

organism
AP2 Athaliana
AP2 Athaliana
AP2 Athaliana
bHLH Athaliana
bHLH Athaliana
bHLH

NMGCCGCCRN
NTGCCGGCGB
ATGTCGGYNN
NNNGCACGTGNN
GGCACGTGCC
Celegans NNNCAATATKGNN

consensus alphabet strand

DNA
DNA
DNA
DNA
DNA
DNA

icscore
+- 12.40700
+- 11.77649
+- 10.66970
+- 11.50133
+- 16.05350
+- 10.32432

26

#> 1
#> 2
#> 3
#> 4
#> 5
#> 6

NA
NA
NA
NA
NA
NA

9.3 Generate random motif matches

Get a random set of sequences which are created using the probabilities of the motif matrix, in effect
generating motif sites, with sample_sites().
library(universalmotif)
data(examplemotif)

width seq

7 TATATAT
7 TATAAAA
7 TATATAA
7 TATAAAT
7 TATATAT

sample_sites(examplemotif)
#> DNAStringSet object of length 100:
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
#> [96]
#> [97]
#> [98]
#> [99]
#> [100]

7 TATATAT
7 TATATAT
7 TATATAA
7 TATATAA
7 TATATAA

... ...

9.4 Motif shuffling

Shuffle a set of motifs with shuffle_motifs(). The original shuffling implementation is taken from the
linear shuffling method of shuffle_sequences(), described in the sequences vignette.
library(universalmotif)
library(MotifDb)

name

altname

motifs <- convert_motifs(MotifDb[1:50])
head(summarise_motifs(motifs))
#>
#> 1 ABF2 badis.ABF2 Scerevisiae
#> 2 CAT8 badis.CAT8 Scerevisiae
#> 3 CST6 badis.CST6 Scerevisiae
#> 4 ECM23 badis.ECM23 Scerevisiae
#> 5 EDS1 badis.EDS1 Scerevisiae
#> 6 FKH2 badis.FKH2 Scerevisiae

icscore
organism consensus alphabet strand
9.371235
+-
7.538740
+-
9.801864
+-
6.567494
+-
+-
9.314287
+- 11.525400

TCTAGA
CCGGAN
TGACGT
AGATC
GGAANAA
GTAAACA

DNA
DNA
DNA
DNA
DNA
DNA

motifs.shuffled <- shuffle_motifs(motifs, k = 3)
head(summarise_motifs(motifs.shuffled))
#>
#> 1 ABF2 [shuffled]
#> 2 CAT8 [shuffled]
#> 3 CST6 [shuffled]
#> 4 ECM23 [shuffled]

name consensus alphabet strand

TAWNGT
AACACR
YTTATC
TGAAG

DNA
DNA
DNA
DNA

icscore
+- 5.994039
+- 6.695024
+- 8.280817
+- 8.388374

27

#> 5 EDS1 [shuffled]
#> 6 FKH2 [shuffled]

YHACCGA
CSCGTWG

DNA
DNA

+- 9.517282
+- 7.680190

9.5 Scoring and match functions

Motif matches in a set of sequences are typically obtained using logodds scores. Several functions are exposed
to reveal some of the internal work that goes on.

• get_matches(): show all possible sequence matches above a certain score
• get_scores(): obtain all possible scores from all possible sequence matches
• motif_score(): translate score thresholds to logodds scores
• prob_match(): return probabilities for sequence matches
• score_match(): return logodds scores for sequence matches

Motif name:
Alphabet:
Type:
Strands:
Total IC:
Pseudocount:
Consensus:

library(universalmotif)
data(examplemotif)
examplemotif
#>
#>
#>
#>
#>
#>
#>
#>
#>
W
#>
#> A 0 1 0 1 0.5 1 0.5
#> C 0 0 0 0 0.0 0 0.0
#> G 0 0 0 0 0.0 0 0.0
#> T 1 0 1 0 0.5 0 0.5

T A T A

W A

motif
DNA
PPM
+-
11.54
1
TATAWAW

## Get the min and max possible scores:
motif_score(examplemotif)
100%
0%
#>
#> -46.606 11.929

## Show matches above a score of 10:
get_matches(examplemotif, 10)
#> [1] "TATAAAA" "TATATAA" "TATAAAT" "TATATAT"

## Get the probability of a match:
prob_match(examplemotif, "TTTTTTT", allow.zero = FALSE)
#> [1] 6.103516e-05

## Score a specific sequence:
score_match(examplemotif, "TTTTTTT")
#> [1] -14.012

## Take a look at the distribution of scores:
plot(density(get_scores(examplemotif), bw = 5))

28

9.6 Type conversion functions

While convert_type() will take care of switching the current type for universalmotif objects, the individual
type conversion functions are also available for personal use. These are:

• icm_to_ppm()
• pcm_to_ppm()
• ppm_to_icm()
• ppm_to_pcm()
• ppm_to_pwm()
• pwm_to_ppm()

These functions take a one dimensional vector. To use these for matrices:

library(universalmotif)

m <- create_motif(type = "PCM")["motif"]
m
T
#>
Y A C G
0
#> A 16 98 0 0
#> C 26 0 81 13 4
#> G 3 2 19 84 0
#> T 55 0 0 3 96 90 13

T C
A
0 0 96 81
6 79
4

S
2
4 27
5 69
2

0
8 0

4 10

A

C

A

apply(m, 2, pcm_to_ppm)
#>
S
Y
#> [1,] 0.16 0.98 0.00 0.00 0.00 0.00 0.00 0.96 0.81 0.02
#> [2,] 0.26 0.00 0.81 0.13 0.04 0.06 0.79 0.00 0.04 0.27
#> [3,] 0.03 0.02 0.19 0.84 0.00 0.04 0.08 0.00 0.05 0.69
#> [4,] 0.55 0.00 0.00 0.03 0.96 0.90 0.13 0.04 0.10 0.02

A

G

T

C

A

T

29

−60−40−200200.0000.0100.0200.030density(x = get_scores(examplemotif), bw = 5)N = 16384   Bandwidth = 5DensityAdditionally, the position_icscore() can be used to get the total information content per position:
library(universalmotif)

position_icscore(c(0.7, 0.1, 0.1, 0.1))
#> [1] 0.6307803

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
#> [1] TFBSTools_1.48.0
#> [4] ggtree_4.0.1
#> [7] GenomicRanges_1.62.0
#> [10] XVector_0.50.0
#> [13] BiocGenerics_0.56.0
#>
#> loaded via a namespace (and not attached):
#>
#>
#>
#>
#>
#> [11] vctrs_0.6.5
#> [13] pkgconfig_2.0.3
#> [15] fastmap_1.2.0
#> [17] labeling_0.4.3
#> [19] splitstackshape_1.4.8
#> [21] rmarkdown_2.30
#> [23] tinytex_0.57
#> [25] bit_4.6.0
#> [27] ggseqlogo_0.2

bitops_1.0-9
magrittr_2.0.4
matrixStats_1.5.0
RSQLite_2.4.3
systemfonts_1.3.1
pwalign_1.6.0
crayon_1.5.3
motifStack_1.54.0
caTools_1.18.3
Rsamtools_2.26.0
DirichletMultinomial_1.52.0
purrr_1.1.0
xfun_0.54
cachem_1.1.0

[1] DBI_1.2.3
[3] rlang_1.1.6
[5] ade4_1.7-23
[7] compiler_4.5.1
[9] png_0.1-8

cowplot_1.2.0
ggplot2_4.0.0
Biostrings_2.78.0
IRanges_2.44.0
generics_0.1.4

grDevices utils

datasets

30

dplyr_1.1.4
MotifDb_1.52.0
Seqinfo_1.0.0
S4Vectors_0.48.0
universalmotif_1.28.0

#> [29] cigarillo_1.0.0
#> [31] jsonlite_2.0.0
#> [33] DelayedArray_0.36.0
#> [35] jpeg_0.1-11
#> [37] R6_2.6.1
#> [39] rtracklayer_1.70.0
#> [41] bookdown_0.45
#> [43] knitr_1.50
#> [45] Matrix_1.7-4
#> [47] dichromat_2.0-0.1
#> [49] yaml_2.3.10
#> [51] curl_7.0.0
#> [53] tibble_3.3.0
#> [55] treeio_1.34.0
#> [57] S7_0.2.0
#> [59] gridGraphics_0.5-1
#> [61] MatrixGenerics_1.22.0
#> [63] grImport2_0.3-3
#> [65] scales_1.4.0
#> [67] gtools_3.9.5
#> [69] gdtools_0.4.4
#> [71] seqLogo_1.76.0
#> [73] TFMPvalue_0.0.9
#> [75] data.table_1.17.8
#> [77] GenomicAlignments_1.46.0
#> [79] fs_1.6.6
#> [81] Cairo_1.7-0
#> [83] tidyr_1.3.1
#> [85] nlme_3.1-168
#> [87] restfulr_0.0.16
#> [89] rappdirs_0.3.3
#> [91] S4Arrays_1.10.0
#> [93] yulab.utils_0.2.1
#> [95] fontquiver_0.2.1
#> [97] ggplotify_0.1.3
#> [99] htmlwidgets_1.6.4
#> [101] memoise_2.0.1
#> [103] lifecycle_1.0.4
#> [105] fontLiberation_0.1.0
#> [107] MASS_7.3-65

References

aplot_0.2.9
blob_1.2.4
BiocParallel_1.44.0
parallel_4.5.1
RColorBrewer_1.1-3
Rcpp_1.1.0
SummarizedExperiment_1.40.0
base64enc_0.1-3
tidyselect_1.2.1
abind_1.4-8
codetools_0.2-20
lattice_0.22-7
Biobase_2.70.0
withr_3.0.2
evaluate_1.0.5
pillar_1.11.1
ggfun_0.2.0
RCurl_1.98-1.17
tidytree_0.4.6
glue_1.8.0
lazyeval_0.2.2
tools_4.5.1
BiocIO_1.20.0
BSgenome_1.78.0
ggiraph_0.9.2
XML_3.99-0.19
grid_4.5.1
ape_5.8-1
patchwork_1.3.2
cli_3.6.5
fontBitstreamVera_0.1.1
gtable_0.3.6
digest_0.6.37
SparseArray_1.10.0
rjson_0.2.23
farver_2.1.2
htmltools_0.5.8.1
httr_1.4.7
bit64_4.6.0-1

Bailey, T. L., M. Boden, F. A. Buske, M. Frith, C. E. Grant, L. Clementi, J. Ren, W. W. Li, and W. S. Noble.
2009. “MEME Suite: Tools for Motif Discovery and Searching.” Nucleic Acids Research 37: W202–W208.

Guo, Y., K. Tian, H. Zeng, X. Guo, and D. K. Gifford. 2018. “A Novel K-Mer Set Memory (KSM) Motif
Representation Improves Regulatory Variant Prediction.” Genome Research 28: 891–900.

Heinz, S., C. Benner, N. Spann, E. Bertolino, Y. C. Lin, P. Laslo, J. X. Cheng, C. Murre, H. Singh, and C.
K. Glass. 2010. “Simple Combinations of Lineage-Determining Transcription Factors Prime Cis-Regulatory
Elements Required for Macrophage and B Cell Identities.” Molecular Cell 38 (4): 576–89.

Hume, M. A., L. A. Barrera, S. S. Gisselbrecht, and M. L. Bulyk. 2015. “UniPROBE, Update 2015: New
Tools and Content for the Online Database of Protein-Binding Microarray Data on Protein-Dna Interactions.”

31

Nucleic Acids Research 43: D117–D122.

Khan, A., O. Fornes, A. Stigliani, M. Gheorghe, J. A. Castro-Mondragon, R. van der Lee, A. Bessy, et al.
2018. “JASPAR 2018: Update of the Open-Access Database of Transcription Factor Binding Profiles and Its
Web Framework.” Nucleic Acids Research 46 (D1): D260–D266.

Mathelier, A., and W. W. Wasserman. 2013. “The Next Generation of Transcription Factor Binding Site
Prediction.” PLoS Computational Biology 9 (9): e1003214.

Siebert, M., and J. Soding. 2016. “Bayesian Markov Models Consistently Outperform PWMs at Predicting
Motifs in Nucleotide Sequences.” Nucleic Acids Research 44 (13): 6055–69.

Weirauch, M. T., A. Yang, M. Albu, A. G. Cote, A. Montenegro-Montero, P. Drewe, H. S. Najafabadi, et al.
2014. “Determination and Inference of Eukaryotic Transcription Factor Sequence Specificity.” Cell 158 (6):
1431–43.

Wingender, E., P. Dietze, H. Karas, and R. Knuppel. 1996. “TRANSFAC: A Database on Transcription
Factors and Their Dna Binding Sites.” Nucleic Acids Research 24 (1): 238–41.

32

