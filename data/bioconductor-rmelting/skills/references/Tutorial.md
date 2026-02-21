Computation of melting temperature of nucleic
acid duplexes with rmelting

Aravind, J.1 and Krishna, G. K.2

2025-10-30

1. Division of Germplasm Conservation, ICAR-National Bureau of Plant
Genetic Resources, New Delhi.

2. Division of Crop Physiology, ICAR-Indian Agricultural Research Institute,
New Delhi.

Contents

1 Introduction

2 Installation

3 Basic usage

4 Melting temperature computation

4.1 Approximative methods . . . . . . . . . . . . . . . . . . . . . . .
4.2 Nearest neighbour methods . . . . . . . . . . . . . . . . . . . . .
4.2.1 Perfectly matching sequences . . . . . . . . . . . . . . . .
4.2.2 GU wobble base pairs effect . . . . . . . . . . . . . . . . .
Single mismatch effect . . . . . . . . . . . . . . . . . . . .
4.2.3
4.2.4 Tandem mismatches effect . . . . . . . . . . . . . . . . . .
Single dangling end effect . . . . . . . . . . . . . . . . . .
4.2.5
4.2.6 Double dangling end effect
. . . . . . . . . . . . . . . . .
4.2.7 Long dangling end effect . . . . . . . . . . . . . . . . . . .
Internal loop effect . . . . . . . . . . . . . . . . . . . . . .
4.2.8
4.2.9
. . . . . . . . . . . . . . . . . . .
Single bulge loop effect
4.2.10 Long bulge loop effect . . . . . . . . . . . . . . . . . . . .
4.2.11 CNG repeats effect . . . . . . . . . . . . . . . . . . . . . .
4.2.12 Inosine bases effect . . . . . . . . . . . . . . . . . . . . . .
4.2.13 Hydroxyadenine bases effect . . . . . . . . . . . . . . . . .
4.2.14 Azobenzenes effect . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . .
4.2.15 Single Locked nucleic acid effect

2

2

3

7
7
10
10
14
15
17
18
20
22
23
24
26
27
28
29
30
31

Computation of melting temperature of nucleic acid duplexes with rmelting

31
32

33
33
33
33
37
39
40
41
41
43

43

44

62

62

62

63

4.3 Consecutive Locked nucleic acids effect . . . . . . . . . . . . . . .
.
4.4 Consecutive Locked nucleic acids with a single mismatch effect

5 Corrections

5.1 Nucleic acid concentration . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . .
5.2
Ion corrections
5.2.1
Sodium corrections . . . . . . . . . . . . . . . . . . . . . .
5.2.2 Magnesium corrections . . . . . . . . . . . . . . . . . . . .
. . . . . . . .
5.2.3 Mixed Sodium and Magnesium corrections
Sodium equivalent concentration methods . . . . . . . . .
5.2.4
. . . . . . . . . . . . . . . . . . . .
5.3.1 DMSO corrections . . . . . . . . . . . . . . . . . . . . . .
5.3.2 Formamide corrections . . . . . . . . . . . . . . . . . . . .

5.3 Denaturing agent corrections

6 Equivalent options in MELTING 5

7 Batch computation

8 Further reading

9 Citing rmelting

10 Session Info

References

1

Introduction

The R package rmelting is an interface to the
MELTING 5 program (Le Novère, 2001; Du-
mousseau et al., 2012) to compute melting tem-
peratures of nucleic acid duplexes (DNA/DNA,
DNA/RNA, RNA/RNA or 2’-O-MeRNA/RNA)
along with other thermodynamic parameters such
as hybridisation enthalpy and entropy.

Melting temperatures are computed by Nearest-
neighbour methods for short sequences or approx-
imative estimation formulae for long sequences.
Apart from these, multiple corrections are avail-
able to take into account the presence of Cations
(Na, Tris, K and Mg) or denaturing agents (DMSO and formamide).

2

Installation

The package can be installed from Bioconductor as follows.

2

3 Basic usage

if (!"BiocManager" %in% rownames(installed.packages()))

install.packages("BiocManager")
BiocManager::install("rmelting")

The development version can be installed from github as follows.
if (!require('devtools')) install.packages('devtools')
devtools::install_github("aravind-j/rmelting")

Then the package can be loaded as follows.
library(rmelting)

3 Basic usage

Melting temperatures are computed in rmelting through the core function
melting which takes a number of arguments (see ?melting). The following are
the essential arguments which are mandatory for computation.

• sequence

– 5’ to 3’ sequence of one strand of the nucleic acid duplex as a character
string. Recognises A, C, G, T, U, I, X_C, X_T, A*, AL, TL, GL
and CL (Table 1). U and T are not considered identical.

Table 1: Recognized sequences

Code Type

Adenine
Cytosine
Guanine
Thymine
Uracil
Inosine

A
C
G
T
U
I
X_C Trans azobenzenes
X_T Cis azobenzenes
Hydroxyadenine
A*
Locked nucleic acid
AL
”
TL
”
GL
”
CL

• Comp.sequence

– Mandatory if there are mismatches, inosine(s) or hydroxyadenine(s)
between the two strands. If not specified, it is computed as the com-
plement of sequence. Self-complementarity in sequence is detected

3

Computation of melting temperature of nucleic acid duplexes with rmelting

even though there may be (are) dangling end(s) and comp.sequence
is computed.

• nucleic.acid.conc

– In molar concentration (M or mol L-1).

• Na.conc, Mg.conc, Tris.conc, K.conc

– At least one cation (Na, Mg, Tris, K) concentration is mandatory, the

other agents(dNTP, DMSO, formamide) are optional.

• hybridisation.type

– The possible options for hybridisation type are as follows (Table 2).

Table 2: Hybridisation type options

Option

Sequence

Complementary sequence

dnadna
rnarna
dnarna
rnadna
mrnarna
rnamrna RNA

DNA
DNA
RNA
RNA
RNA
DNA
RNA
DNA
2-o-methyl RNA RNA

2-o-methyl RNA

With these arguments, the melting temperature can be computed as follows.
melting(sequence = "CAGTGAGACAGCAATGGTCG", nucleic.acid.conc = 2e-06,

hybridisation.type = "dnadna", Na.conc = 1)

## [1] 73.35168

Only the melting temperature is given as a console output. However, the output
can be assigned to an object which contains the details of the environment,
options and the thermodynamics results as a list.

# Get output as list
out <- melting(sequence = "CAGTGAGACAGCAATGGTCG", nucleic.acid.conc = 2e-06,

hybridisation.type = "dnadna", Na.conc = 1)

# Environment output
out$Environment

## $Sequence
## [1] "CAGTGAGACAGCAATGGTCG"
##
## $`Complementary sequence`
## [1] "GTCACTCTGTCGTTACCAGC"
##
## $`Nucleic acid concentration (M)`
## [1] 2e-06
##
## $`Hybridization type`

4

## [1] "dnadna"
##
## $`Na concentration (M)`
## [1] 1
##
## $`Mg concentration (M)`
## [1] 0
##
## $`Tris concentration (M)`
## [1] 0
##
## $`K concentration (M)`
## [1] 0
##
## $`dNTP concentration (M)`
## [1] 0
##
## $`DMSO concentration (%)`
## [1] 0
##
## $`Formamide concentration (M or %)`
## [1] 0
##
## $`Self complementarity`
## [1] FALSE
##
## $`Correction factor`
## [1] 4

# Options used
out$Options

## $`Approximative formula`
## [1] NA
##
## $`Nearest neighbour model`
## [1] NA
##
## $`GU model`
## [1] NA
##
## $`Single mismatch model`
## [1] NA
##
## $`Tandem mismatch model`
## [1] NA

3 Basic usage

5

Computation of melting temperature of nucleic acid duplexes with rmelting

##
## $`Single dangling end model`
## [1] NA
##
## $`Double dangling end model`
## [1] NA
##
## $`Long dangling end model`
## [1] NA
##
## $`Internal loop model`
## [1] NA
##
## $`Single bulge loop model`
## [1] NA
##
## $`Long bulge loop model`
## [1] NA
##
## $`CNG repeats model`
## [1] NA
##
## $`Inosine bases model`
## [1] NA
##
## $`Hydroxyadenine bases model`
## [1] NA
##
## $`Azobenzenes model`
## [1] NA
##
## $`Locked nucleic acids model`
## [1] NA
##
## $`Ion correction method`
## [1] NA
##
## $`Na equivalence correction method`
## [1] NA
##
## $`DMSO correction method`
## [1] NA
##
## $`Formamide correction method`
## [1] NA
##

6

4 Melting temperature computation

## $Mode
## [1] NA

# Thermodynamics results
out$Results

## $`Enthalpy (cal)`
## [1] -159000
##
## $`Entropy (cal)`
## [1] -430
##
## $`Enthalpy (J)`
## [1] -664620
##
## $`Entropy (J)`
## [1] -1797.4
##
## $`Melting temperature (C)`
## [1] 73.35168

The command for the MELTING 5 java version is saved as an attribute in the
list out and can be retrieved as follows.
# Command for MELTING 5
attributes(out)$command

## [1] "-S CAGTGAGACAGCAATGGTCG -H dnadna -P 2e-06 -E Na=1 -T 60"

4 Melting temperature computation

Melting temperature is computed by either approximative or nearest neigh-
bour methods according to the length of the oligonucleotide sequences. For
longer sequences (longer than the threshold value, the threshold value set by
size.threshold with the default value 60) approximative method is used, while
for others, nearest neighbour method is used.

4.1 Approximative methods

The approximative method for computation can be specified by the argument
method.approx. The available methods are given in Table 3.

Table 3: Details of approximative methods

Formula

ahs01

Type

DNA

Limits/Remarks Reference

No mismatch

Ahsen et al. (2001)

7

Computation of melting temperature of nucleic acid duplexes with rmelting

Limits/Remarks Reference

Formula

che93

Type

DNA

che93corr

DNA

schdot

DNA

No mismatch;
Na=0,
Mg=0.0015,
Tris=0.01,
K=0.05
No mismatch;
Na=0,
Mg=0.0015,
Tris=0.01,
K=0.05
No mismatch

Marmur and Doty (1962)

Marmur and Doty (1962)

Wetmur (1991), Marmur and
Doty (1962), Chester and
Marshak (1993), Schildkraut and
Lifson (1965), Wahl et al.
(1987), Britten et al. (1974),
Hall et al. (1980)
Owen et al. (1969),
Frank-Kamenetskii (1971), Blake
(1996), Blake and Delcourt
(1998)
SantaLucia (1998), Ahsen et al.
(2001)
Wetmur (1991)
Wetmur (1991)
Wetmur (1991)

owe69

DNA

No mismatch

san98

DNA

No mismatch

wetdna91*
wetrna91*
wetdnarna91* DNA/RNA

DNA
RNA

* Default method for computation.

Examples

DNA:TCTAATGTGCTGTTAGATGTATCCAGAGATAGCCGAGCATAAACTTCAACACACGAGACGTTGATTGGATTTAACCATAG
||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
DNA:AGATTACACGACAATCTACATAGGTCTCTATCGGCTCGTATTTGAAGTTGTGTGCTCTGCAACTAACCTAAATTGGTATC

RNA:UUAAUCUCCGUCAUCUUUAAGCCGUGGAGAGACUGUAGACUUGAACAGGGGUAAGCGGAGGCACGUAGGAUUCACAUCAU
||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
RNA:AAUUAGAGGCAGUAGAAAUUCGGCACCUCUCUGACAUCUGAACUUGUCCCCAUUCGCCUCCGUGCAUCCUAAGUGUAGUA

DNA:TCTAATGTGCTGTTAGATGTATCCAGAGATAGCCGAGCATAAACTTCAACACACGAGACGTTGATTGGATTTAACCATAG
||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
RNA:AGAUUACACGACAAUCUACAUAGGUCUCUAUCGGCUCGUAUUUGAAGUUGUGUGCUCUGCAACUAACCUAAAUUGGUAUC

8

4 Melting temperature computation

# Long Nucleotide sequence
DNAseq <- c("TCTAATGTGCTGTTAGATGTATCCAGAGATAGCCGAGCATAAACTTCAACACACGAGACGTTGATTGGATTTAACCATAG")
RNAseq <- c("UUAAUCUCCGUCAUCUUUAAGCCGUGGAGAGACUGUAGACUUGAACAGGGGUAAGCGGAGGCACGUAGGAUUCACAUCAU")

# Approximative method - default (DNA/DNA)
melting(sequence = DNAseq, nucleic.acid.conc = 2e-06,

hybridisation.type = "dnadna", Na.conc = 1)

## [1] 87.82455

# Approximative method - wetdna91 (DNA/DNA)
melting(sequence = DNAseq, nucleic.acid.conc = 2e-06,

hybridisation.type = "dnadna", Na.conc = 1,
method.approx = "wetdna91")

## [1] 87.82455

# Approximative method - ahs01 (DNA/DNA)
melting(sequence = DNAseq, nucleic.acid.conc = 2e-06,

hybridisation.type = "dnadna", Na.conc = 1,
method.approx = "ahs01")

## [1] 87.325

# Approximative method - che93 (DNA/DNA)
melting(sequence = DNAseq, nucleic.acid.conc = 2e-06,

hybridisation.type = "dnadna", Na.conc = 1,
method.approx = "che93")

## [1] 77.575

# Approximative method - che93corr (DNA/DNA)
melting(sequence = DNAseq, nucleic.acid.conc = 2e-06,

hybridisation.type = "dnadna", Na.conc = 1,
method.approx = "che93corr")

## [1] 79.0125

# Approximative method - schdot (DNA/DNA)
melting(sequence = DNAseq, nucleic.acid.conc = 2e-06,

hybridisation.type = "dnadna", Na.conc = 1,
method.approx = "schdot")

## [1] 89.4625

# Approximative method - owe69 (DNA/DNA)
melting(sequence = DNAseq, nucleic.acid.conc = 2e-06,

hybridisation.type = "dnadna", Na.conc = 1,
method.approx = "owe69")

9

Computation of melting temperature of nucleic acid duplexes with rmelting

## [1] 100.96

# Approximative method - san98 (DNA/DNA)
melting(sequence = DNAseq, nucleic.acid.conc = 2e-06,

hybridisation.type = "dnadna", Na.conc = 1,
method.approx = "san98")

## [1] 86.9

# Approximative method - default (RNA/RNA)
melting(sequence = RNAseq, nucleic.acid.conc = 2e-06,

hybridisation.type = "rnarna", Na.conc = 1)

## [1] 101.1745

# Approximative method - wetrna91 (RNA/RNA)
melting(sequence = RNAseq, nucleic.acid.conc = 2e-06,

hybridisation.type = "rnarna", Na.conc = 1,
method.approx = "wetrna91")

## [1] 101.1745

# Approximative method - wetdnarna91 (DNA/RNA)
melting(sequence = DNAseq, nucleic.acid.conc = 2e-06,

hybridisation.type = "dnarna", Na.conc = 1)

## [1] 88.92455

# Approximative method - wetdnarna91 (DNA/RNA)
melting(sequence = DNAseq, nucleic.acid.conc = 2e-06,

hybridisation.type = "dnarna", Na.conc = 1,
method.approx = "wetdnarna91")

## [1] 88.92455

4.2 Nearest neighbour methods

4.2.1 Perfectly matching sequences

The nearest neighbour model for computation in case of perfectly matching
sequences can be specified by the argument method.nn. The available methods
are given in Table 4.

Table 4: Details of nearest neighbour methods for perfectly matching sequences

Type

DNA
DNA
DNA
DNA

Model
all97*
bre86
san04
san96

10

Limits/Remarks

Reference

Allawi and SantaLucia (1997)
Breslauer et al. (1986)
SantaLucia and Hicks (2004)
SantaLucia et al. (1996)

Model

sug96
tan04
fre86
xia98*
sug95*

tur06*

4 Melting temperature computation

Type

Limits/Remarks

Reference

Sugimoto et al. (1996)
Tanaka et al. (2004)
Freier et al. (1986)
Xia et al. (1998)
SantaLucia et al. (1996)

Kierzek et al. (2006)

DNA
DNA
RNA
RNA
DNA/
RNA
2’-O-
MeRNA/
RNA

A sodium
correction (san04)
is automatically
applied to convert
the entropy (Na =
0.1M) into the
entropy (Na = 1M)

* Default method for computation.

Examples

DNA:CAGTGAGACAGCAATGGTCG
||||||||||||||||||||
DNA:GTCACTCTGTCGTTACCAGC

RNA:CAGUGAGACAGCAAUGGUCG
||||||||||||||||||||
RNA:GUCACUCUGUCGUUACCAGC

DNA:CAGTGAGACAGCAATGGTCG
||||||||||||||||||||
RNA:GUCACUCUGUCGUUACCAGC

# Nearest neighbour method - default (DNA/DNA: No Self-Complimentarity)
melting(sequence = "CAGTGAGACAGCAATGGTCG", nucleic.acid.conc = 2e-06,

hybridisation.type = "dnadna", Na.conc = 1)

## [1] 73.35168

# Nearest neighbour method - all97 (DNA/DNA: No Self-Complimentarity)
melting(sequence = "CAGTGAGACAGCAATGGTCG", nucleic.acid.conc = 2e-06,

hybridisation.type = "dnadna", Na.conc = 1, method.nn = "all97")

## [1] 73.35168

11

Computation of melting temperature of nucleic acid duplexes with rmelting

# Nearest neighbour method - bre86 (DNA/DNA: No Self-Complimentarity)
melting(sequence = "CAGTGAGACAGCAATGGTCG", nucleic.acid.conc = 2e-06,

hybridisation.type = "dnadna", Na.conc = 1, method.nn = "bre86")

## [1] 83.2203

# Nearest neighbour method - san04 (DNA/DNA: No Self-Complimentarity)
melting(sequence = "CAGTGAGACAGCAATGGTCG", nucleic.acid.conc = 2e-06,

hybridisation.type = "dnadna", Na.conc = 1, method.nn = "san04")

## [1] 73.30191

# Nearest neighbour method - san96 (DNA/DNA: No Self-Complimentarity)
melting(sequence = "CAGTGAGACAGCAATGGTCG", nucleic.acid.conc = 2e-06,

hybridisation.type = "dnadna", Na.conc = 1, method.nn = "san96")

## [1] 75.7102

# Nearest neighbour method - sug96 (DNA/DNA: No Self-Complimentarity)
melting(sequence = "CAGTGAGACAGCAATGGTCG", nucleic.acid.conc = 2e-06,

hybridisation.type = "dnadna", Na.conc = 1, method.nn = "sug96")

## [1] 78.17556

# Nearest neighbour method - tan04 (DNA/DNA: No Self-Complimentarity)
melting(sequence = "CAGTGAGACAGCAATGGTCG", nucleic.acid.conc = 2e-06,

hybridisation.type = "dnadna", Na.conc = 1, method.nn = "tan04")

## [1] 71.31413

# Nearest neighbour method - default (RNA/RNA: No Self-Complimentarity)
melting(sequence = "CAGUGAGACAGCAAUGGUCG", nucleic.acid.conc = 2e-06,

hybridisation.type = "rnarna", Na.conc = 1)

## [1] 86.77685

# Nearest neighbour method - xia98 (RNA/RNA: No Self-Complimentarity)
melting(sequence = "CAGUGAGACAGCAAUGGUCG", nucleic.acid.conc = 2e-06,

hybridisation.type = "rnarna", Na.conc = 1, method.nn = "xia98")

## [1] 86.77685

# Nearest neighbour method - fre86 (RNA/RNA: No Self-Complimentarity)
melting(sequence = "CAGUGAGACAGCAAUGGUCG", nucleic.acid.conc = 2e-06,

hybridisation.type = "rnarna", Na.conc = 1, method.nn = "fre86")

## [1] 83.81257

# Nearest neighbour method - default (mRNA/RNA: No Self-Complimentarity)
melting(sequence = "CAGUGAGACAGCAAUGGUCG", nucleic.acid.conc = 2e-06,

hybridisation.type = "mrnarna", Na.conc = 1)

12

4 Melting temperature computation

## [1] 99.01986

# Nearest neighbour method - tur06 (mRNA/RNA: No Self-Complimentarity)
melting(sequence = "CAGUGAGACAGCAAUGGUCG", nucleic.acid.conc = 2e-06,

hybridisation.type = "mrnarna", Na.conc = 1, method.nn = "tur06")

## [1] 99.01986

# Nearest neighbour method - default (DNA/RNA: No Self-Complimentarity)
melting(sequence = "CAGTGAGACAGCAATGGTCG", nucleic.acid.conc = 2e-06,

hybridisation.type = "dnarna", Na.conc = 1)

## [1] 66.77049

# Nearest neighbour method - sug95 (DNA/RNA: No Self-Complimentarity)
melting(sequence = "CAGTGAGACAGCAATGGTCG", nucleic.acid.conc = 2e-06,

hybridisation.type = "dnarna", Na.conc = 1, method.nn = "sug95")

## [1] 66.77049

Self complementarity for perfect matching sequences or sequences with dangling
ends is detected automatically. However it can be enforced by the argument
force.self = TRUE.

Examples

DNA:CATATGGCCATATG
||||||||||||||
DNA:GTATACCGGTATAC

RNA:AUGUACAU
||||||||
RNA:UACAUGUA

# Nearest neighbour method - default (DNA/DNA: Self-Complimentarity)
melting(sequence = "CATATGGCCATATG", nucleic.acid.conc = 2e-06,

hybridisation.type = "dnadna", Na.conc = 1)

## [1] 56.00644

# Nearest neighbour method - all97 (DNA/DNA: Self-Complimentarity)
melting(sequence = "CATATGGCCATATG", nucleic.acid.conc = 2e-06,

hybridisation.type = "dnadna", Na.conc = 1, method.nn = "all97")

## [1] 56.00644

# Nearest neighbour method - bre86 (DNA/DNA: Self-Complimentarity)
melting(sequence = "CATATGGCCATATG", nucleic.acid.conc = 2e-06,

hybridisation.type = "dnadna", Na.conc = 1, method.nn = "bre86")

## [1] 63.44605

13

Computation of melting temperature of nucleic acid duplexes with rmelting

# Nearest neighbour method - san04 (DNA/DNA: Self-Complimentarity)
melting(sequence = "CATATGGCCATATG", nucleic.acid.conc = 2e-06,

hybridisation.type = "dnadna", Na.conc = 1, method.nn = "san04")

## [1] 57.80792

# Nearest neighbour method - san96 (DNA/DNA: Self-Complimentarity)
melting(sequence = "CATATGGCCATATG", nucleic.acid.conc = 2e-06,

hybridisation.type = "dnadna", Na.conc = 1, method.nn = "san96")

## [1] 55.0921

# Nearest neighbour method - sug96 (DNA/DNA: Self-Complimentarity)
melting(sequence = "CATATGGCCATATG", nucleic.acid.conc = 2e-06,

hybridisation.type = "dnadna", Na.conc = 1, method.nn = "sug96")

## [1] 59.06213

# Nearest neighbour method - tan04 (DNA/DNA: Self-Complimentarity)
melting(sequence = "CATATGGCCATATG", nucleic.acid.conc = 2e-06,

hybridisation.type = "dnadna", Na.conc = 1, method.nn = "tan04")

## [1] 55.65824

# Nearest neighbour method - default (RNA/RNA: Self-Complimentarity)
melting(sequence = "AUGUACAU", nucleic.acid.conc = 2e-06,
hybridisation.type = "rnarna", Na.conc = 1)

## [1] 30.27015

# Nearest neighbour method - xia98 (RNA/RNA: Self-Complimentarity)
melting(sequence = "AUGUACAU", nucleic.acid.conc = 2e-06,

hybridisation.type = "rnarna", Na.conc = 1, method.nn = "xia98")

## [1] 30.27015

# Nearest neighbour method - fre86 (RNA/RNA: Self-Complimentarity)
melting(sequence = "AUGUACAU", nucleic.acid.conc = 2e-06,

hybridisation.type = "rnarna", Na.conc = 1, method.nn = "fre86")

## [1] 31.48175

4.2.2 GU wobble base pairs effect

The nearest neighbour model for computation in case of sequences with GU
wobble base pairs can be specified by the argument method.GU. The available
methods are given in Table 5.

Table 5: Details of methods for sequences with GU wobble base pairs

14

4 Melting temperature computation

Model

tur99
ser12*

Type

RNA
RNA

Limits/Remarks Reference

Mathews et al. (1999)
Chen et al. (2012)

* Default method for computation.

Examples

RNA:CCAGCGUCCU
||||||||||
RNA:GGTCGCAGGA

# GU wobble base pairs effect - default (RNA/RNA)
melting(sequence = "CCAGCGUCCU", nucleic.acid.conc = 0.0001,
hybridisation.type = "rnarna", Na.conc = 1)

## [1] 79.46955

# GU wobble base pairs effect - ser12 (RNA/RNA)
melting(sequence = "CCAGCGUCCU", nucleic.acid.conc = 0.0001,

hybridisation.type = "rnarna", Na.conc = 1, method.GU = "ser12")

## [1] 79.46955

# GU wobble base pairs effect - tur99 (RNA/RNA)
melting(sequence = "CCAGCGUCCU", nucleic.acid.conc = 0.0001,

hybridisation.type = "rnarna", Na.conc = 1, method.GU = "tur99")

## [1] 79.46955

4.2.3 Single mismatch effect

The nearest neighbour model for computation in case of sequences with a single
mismatch can be specified by the argument method.singleMM. The available
methods are given in Table 6.

Table 6: Details of methods for sequences with single mismatch

Model
allsanpey*

Type

DNA

wat11*

DNA/RNA

Limits/Remarks

Reference

Allawi and SantaLucia (1997),
Allawi and SantaLucia
(1998a), Allawi and
SantaLucia (1998b), Allawi
and SantaLucia (1998c),
Peyret et al. (1999)
Watkins et al. (2011)

15

Computation of melting temperature of nucleic acid duplexes with rmelting

Model

tur06
zno07*
zno08

Type

RNA
RNA
RNA

Limits/Remarks

Reference

Lu et al. (2006)
Davis and Znosko (2007)
Davis and Znosko (2008)

At least one
adjacent GU base
pair.

* Default method for computation.

Examples

DNA:CAACTTGATATTAATA
|||||||| |||||||
DNA:GTTGAACTCTAATTAT

RNA:GACAGGCUG
|||| ||||
RNA:CUGUGCGAC

DNA:CCATAACTACC
|||| ||||||
RNA:GGUAAUGAUGG

# Single mismatch effect - default (DNA/DNA)
melting(sequence = "CAACTTGATATTAATA", comp.sequence = "GTTGAACTCTAATTAT",

nucleic.acid.conc = 0.0004, hybridisation.type = "dnadna", Na.conc = 1)

## [1] 51.97499

# Single mismatch effect - allsanpey (DNA/DNA)
melting(sequence = "CAACTTGATATTAATA", comp.sequence = "GTTGAACTCTAATTAT",
nucleic.acid.conc = 0.0004, hybridisation.type = "dnadna",
Na.conc = 1, method.singleMM = "allsanpey")

## [1] 51.97499

# Single mismatch effect - default (RNA/RNA)
melting(sequence = "GACAGGCUG", comp.sequence = "CUGUGCGAC",

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna", Na.conc = 1)

## [1] 54.40363

# Single mismatch effect - zno07 (RNA/RNA)
melting(sequence = "GACAGGCUG", comp.sequence = "CUGUGCGAC",

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1, method.singleMM = "zno07")

16

4 Melting temperature computation

## [1] 54.40363

# Single mismatch effect - zno08 (RNA/RNA)
melting(sequence = "CAGUACGUC", comp.sequence = "GUCGGGCAG",

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1, method.singleMM = "zno08")

## [1] 38.26298

# Single mismatch effect - tur06 (RNA/RNA)
melting(sequence = "GACAGGCUG", comp.sequence = "CUGUGCGAC",

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1, method.singleMM = "tur06")

## [1] 58.27825

# Single mismatch effect - default (DNA/RNA)
melting(sequence = "CCATAACTACC", comp.sequence = "GGUAAUGAUGG",

nucleic.acid.conc = 0.0001, hybridisation.type = "dnarna", Na.conc = 1)

## [1] 40.32976

# Single mismatch effect - wat11 (DNA/RNA)
melting(sequence = "CCATAACTACC", comp.sequence = "GGUAAUGAUGG",

nucleic.acid.conc = 0.0001, hybridisation.type = "dnarna",
Na.conc = 1, method.singleMM = "wat11")

## [1] 40.32976

4.2.4 Tandem mismatches effect

The nearest neighbour model for computation in case of sequences with tandem
mismatches can be specified by the argument method.tandemMM. The available
methods are given in Table 7.

Table 7: Details of methods for sequences with tandem mismatches

Model
allsanpey*

Type

DNA

Limits/Remarks

Reference

Only GT
mismatches and
TA/TG mismatches.

tur99*

RNA

No adjacent GU or
UG base pairs.

* Default method for computation.

Allawi and SantaLucia
(1997), Allawi and
SantaLucia (1998a), Allawi
and SantaLucia (1998b),
Allawi and SantaLucia
(1998c), Peyret et al. (1999)
Mathews et al. (1999), Lu et
al. (2006)

17

Computation of melting temperature of nucleic acid duplexes with rmelting

Examples

DNA:GACGTTGGAC
||||
DNA:CTGCGGCCTG

||||

RNA:GAGCGGAG
||| |||
RNA:CUCCACUC

# Tandem mismatches effect - default (DNA/DNA)
melting(sequence = "GACGTTGGAC", comp.sequence = "CTGCGGCCTG",

nucleic.acid.conc = 0.0004, hybridisation.type = "dnadna", Na.conc = 1)

## [1] 50.20175

# Tandem mismatches effect - allsanpey (DNA/DNA)
melting(sequence = "GACGTTGGAC", comp.sequence = "CTGCGGCCTG",

nucleic.acid.conc = 0.0004, hybridisation.type = "dnadna",
Na.conc = 1, method.tandemMM = "allsanpey")

## [1] 50.20175

# Tandem mismatches effect - default (RNA/RNA)
melting(sequence = "GAGCGGAG", comp.sequence = "CUCCACUC",

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna", Na.conc = 1)

## [1] 21.07224

# Tandem mismatches effect -
melting(sequence = "GAGCGGAG", comp.sequence = "CUCCACUC",

tur06 (RNA/RNA)

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1, method.tandemMM = "tur99")

## [1] 21.07224

4.2.5 Single dangling end effect

The nearest neighbour model for computation in case of sequences with a single
dangling end can be specified by the argument method.single.dangle. The
available methods are given in Table 8.

Table 8: Details of methods for sequences with single dangling end

Model
bom00*

Type

DNA

Limits/Remarks

Reference

Bommarito et al. (2000)

18

4 Melting temperature computation

Model

sugdna02

Type

DNA

sugrna02

RNA

ser08*

RNA

Limits/Remarks

Reference

Ohmichi et al. (2002)

Ohmichi et al. (2002)

O’Toole et al. (2006), Miller
et al. (2008)

Only terminal poly A
self complementary
sequences.
Only terminal poly A
self complementary
sequences.
Only 3’ UA, GU and
UG terminal base
pairs only 5’ UG and
GU terminal base
pairs.

* Default method for computation.

Examples

DNA:-GTAGCTACA

||||||||

DNA:ACATCGATG-

RNA:-GGCGCUG
|||||||
RNA: CCGCGAC

DNA:-GGCGCUG
|||||||
RNA: CCGCGAC

# Single dangling end effect - default (DNA/DNA)
melting(sequence = "-GTAGCTACA",

nucleic.acid.conc = 0.0004, hybridisation.type = "dnadna",
Na.conc = 1)

## [1] 52.58935

# Single dangling end effect - bom00 (DNA/DNA)
melting(sequence = "-GTAGCTACA",

nucleic.acid.conc = 0.0004, hybridisation.type = "dnadna",
Na.conc = 1, method.single.dangle = "bom00")

## [1] 52.58935

# Single dangling end effect - sugdna02 (DNA/DNA)
melting(sequence = "-GTAGCTACA",

19

Computation of melting temperature of nucleic acid duplexes with rmelting

nucleic.acid.conc = 0.0004, hybridisation.type = "dnadna",
Na.conc = 1, method.single.dangle = "sugdna02")

## [1] 50.78548

# Single dangling end effect - default (RNA/RNA)
melting(sequence = "-GGCGCUG",

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1)

## [1] 65.7647

# Single dangling end effect -
melting(sequence = "-GGCGCUG",

ser08 (RNA/RNA)

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1, method.single.dangle = "ser08")

## [1] 65.7647

# Single dangling end effect -
melting(sequence = "-GGCGCUG",

sugrna02 (RNA/RNA)

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1, method.single.dangle = "sugrna02")

## [1] 65.7647

4.2.6 Double dangling end effect

The nearest neighbour model for computation in case of sequences with
a double or secondary dangling ends can be specified by the argument
method.double.dangle. The available methods are given in Table 9.

Table 9: Details of methods for sequences with double dangling ends

Model
sugdna02*

Type

DNA

sugrna02

RNA

ser05

RNA

Limits/Remarks

Reference

Ohmichi et al. (2002)

Ohmichi et al. (2002)

O’Toole et al. (2005)

Only terminal poly A
self complementary
sequences.
Only terminal poly A
self complementary
sequences.
Depends on the
available
thermodynamic
parameters for single
dangling end.

ser06*

RNA

O’Toole et al. (2006)

20

4 Melting temperature computation

* Default method for computation.

Examples

DNA:--ATGCATAA

||||||

DNA:AATACGTA--

RNA:--AUGCAUAA

||||||

RNA:AAUACGUA--

# Double dangling end effect - default (DNA/DNA)
melting(sequence = "--ATGCATAA",

nucleic.acid.conc = 0.0004, hybridisation.type = "dnadna",
Na.conc = 1)

## [1] 44.88615

# Double dangling end effect - sugdna02 (DNA/DNA)
melting(sequence = "--ATGCATAA",

nucleic.acid.conc = 0.0004, hybridisation.type = "dnadna",
Na.conc = 1, method.double.dangle = "sugdna02")

## [1] 44.88615

# Double dangling end effect - default (RNA/RNA)
melting(sequence = "--AUGCAUAA",

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1)

## [1] 42.79724

# Double dangling end effect -
melting(sequence = "--AUGCAUAA",

ser06 (RNA/RNA)

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1, method.double.dangle = "ser06")

## [1] 42.79724

# Double dangling end effect -
melting(sequence = "--AUGCAUAA",

sugrna02 (RNA/RNA)

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1, method.double.dangle = "sugrna02")

## [1] 41.82788

# Double dangling end effect -
melting(sequence = "--AUGCAUAA",

ser05 (RNA/RNA)

21

Computation of melting temperature of nucleic acid duplexes with rmelting

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1, method.double.dangle = "ser05")

## [1] 42.78815

4.2.7 Long dangling end effect

The nearest neighbour model for computation in case of sequences with
a double or secondary dangling ends can be specified by the argument
method.long.dangle. The available methods are given in Table 10.

Table 10: Details of methods for sequences with long dangling ends

Model
sugdna02*

Type

DNA

sugrna02*

RNA

Limits/Remarks

Reference

Only terminal poly A
self complementary
sequences.
Only terminal poly A
self complementary
sequences.

Ohmichi et al. (2002)

Ohmichi et al. (2002)

* Default method for computation.

Examples

DNA:----GCATATGCAAAA

||||||||

DNA:AAAACGTATACG----

RNA:AAAAGCAUAUGC----

||||||||

RNA:----CGUAUACGAAAA

# Long dangling end effect - default (DNA/DNA)
melting(sequence = "----GCATATGCAAAA",

nucleic.acid.conc = 0.0004, hybridisation.type = "dnadna",
Na.conc = 1)

## [1] 55.69854

# Long dangling end effect - sugdna02 (DNA/DNA)
melting(sequence = "----GCATATGCAAAA",

nucleic.acid.conc = 0.0004, hybridisation.type = "dnadna",
Na.conc = 1, method.long.dangle = "sugdna02")

## [1] 55.69854

22

4 Melting temperature computation

# Long dangling end effect - default (RNA/RNA)
melting(sequence = "AAAAGCAUAUGC----",

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1)

## [1] 57.21314

# Long dangling end effect -
melting(sequence = "AAAAGCAUAUGC----",

sugrna02 (RNA/RNA)

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1, method.long.dangle = "sugrna02")

## [1] 57.21314

4.2.8

Internal loop effect

The nearest neighbour model for computation in case of sequences with an
internal loop (more than two adjacent mismatches) can be specified by the
argument method.internal.loop. The available methods are given in Table
11.

Table 11: Details of methods for sequences with internal loops

Type

Limits/Remarks

Reference

Model
san04*

tur06

zno07*

DNA Missing asymmetry
penalty. Not tested
with experimental
results.
Not tested with
experimental results.
Only for 1x2 loop.

RNA

RNA

SantaLucia and Hicks (2004)

Lu et al. (2006)

Badhwar et al. (2007)

23

* Default method for computation.

Examples

DNA:GCGATTGGCACTTTGGTGAAC
||||||||||||
DNA:CGCTACATATGAAACCACTTG

|||||

RNA:GACAC-GCUG
||||
RNA:CUGUAUCGAC

||||

Computation of melting temperature of nucleic acid duplexes with rmelting

# Internal loop effect - default (DNA/DNA)
melting(sequence = "GCGATTGGCACTTTGGTGAAC", comp.sequence = "CGCTACATATGAAACCACTTG",

nucleic.acid.conc = 0.0001, hybridisation.type = "dnadna",
Na.conc = 1)

## [1] 84.09052

# Internal loop effect - san04 (DNA/DNA)
melting(sequence = "GCGATTGGCACTTTGGTGAAC", comp.sequence = "CGCTACATATGAAACCACTTG",

nucleic.acid.conc = 0.0001, hybridisation.type = "dnadna",
Na.conc = 1, method.internal.loop = "san04")

## [1] 84.09052

# Internal loop effect - default (RNA/RNA)
melting(sequence = "GACAC-GCUG", comp.sequence = "CUGUAUCGAC",

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1)

## [1] 45.98713

# Internal loop effect -
melting(sequence = "GACAC-GCUG", comp.sequence = "CUGUAUCGAC",

zno07 (RNA/RNA)

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1, method.internal.loop = "zno07")

## [1] 40.49012

# Internal loop effect -
melting(sequence = "GACAC-GCUG", comp.sequence = "CUGUAUCGAC",

tur06 (RNA/RNA)

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1, method.internal.loop = "tur06")

## [1] 45.98713

4.2.9 Single bulge loop effect

The nearest neighbour model for computation in case of sequences with a single
bulge loop can be specified by the argument method.single.bulge.loop. The
available methods are given in Table 12.

Table 12: Details of methods for sequences with single bulge loop

Type

Limits/Remarks

Reference

DNA
DNA Missing closing AT
penalty.

Tan and Chen (2007)
SantaLucia and Hicks (2004)

Model
tan04*
san04

24

4 Melting temperature computation

Model

ser07

Type

RNA

Limits/Remarks

Reference

Less reliable results.
Some missing
parameters.

Blose et al. (2007)

tur06*

RNA

Lu et al. (2006)

* Default method for computation.

Examples

DNA:TCGATTAGCGACACAGG
|||||||| ||||||||
DNA:AGCTAATC-CTGTGTCC

RNA:GACUCUGUC
|||| ||||
RNA:CUGA-ACAG

# Single bulge loop effect - default (DNA/DNA)
melting(sequence = "TCGATTAGCGACACAGG", comp.sequence = "AGCTAATC-CTGTGTCC",
nucleic.acid.conc = 0.0001, hybridisation.type = "dnadna",
Na.conc = 1)

## [1] 71.12754

# Single bulge loop effect - tan04 (DNA/DNA)
melting(sequence = "TCGATTAGCGACACAGG", comp.sequence = "AGCTAATC-CTGTGTCC",
nucleic.acid.conc = 0.0001, hybridisation.type = "dnadna",
Na.conc = 1, method.single.bulge.loop = "tan04")

## [1] 71.12754

# Single bulge loop effect - san04 (DNA/DNA)
melting(sequence = "TCGATTAGCGACACAGG", comp.sequence = "AGCTAATC-CTGTGTCC",
nucleic.acid.conc = 0.0001, hybridisation.type = "dnadna",
Na.conc = 1, method.single.bulge.loop = "san04")

## [1] 62.0496

# Single bulge loop effect - default (RNA/RNA)
melting(sequence = "GACUCUGUC", comp.sequence = "CUGA-ACAG",

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1)

## [1] 39.47787

25

Computation of melting temperature of nucleic acid duplexes with rmelting

# Single bulge loop effect -
melting(sequence = "GACUCUGUC", comp.sequence = "CUGA-ACAG",

tur06 (RNA/RNA)

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1, method.single.bulge.loop = "tur06")

## [1] 39.47787

# Single bulge loop effect -
melting(sequence = "GACUCUGUC", comp.sequence = "CUGA-ACAG",

ser07 (RNA/RNA)

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1, method.single.bulge.loop = "ser07")

## [1] 31.42849

4.2.10 Long bulge loop effect

The nearest neighbour model for computation in case of sequences with long
bulge loop can be specified by the argument method.long.bulge.loop. The
available methods are given in Table 13.

Table 13: Details of methods for sequences with long bulge loop

Model
san04*

tur06*

Type

Limits/Remarks

Reference

RNA

DNA Missing closing AT
penalty.
Not tested with
experimental
results.

SantaLucia and Hicks (2004)

Mathews et al. (1999), Lu et al.
(2006)

* Default method for computation.

Examples

DNA:ATATGACGCCACAGCG
||||||||
DNA:TATAC---GGTGTCGC

|||||

RNA:AUAUGACGCCACAGCG
||||||||
RNA:UAUAC---GGUGUCGC

|||||

# Long bulge loop effect - default (DNA/DNA)
melting(sequence = "ATATGACGCCACAGCG", comp.sequence = "TATAC---GGTGTCGC",
nucleic.acid.conc = 0.0001, hybridisation.type = "dnadna",
Na.conc = 1)

26

4 Melting temperature computation

## [1] 51.7104

# Long bulge loop effect - san04 (DNA/DNA)
melting(sequence = "ATATGACGCCACAGCG", comp.sequence = "TATAC---GGTGTCGC",
nucleic.acid.conc = 0.0001, hybridisation.type = "dnadna",
Na.conc = 1, method.long.bulge.loop = "san04")

## [1] 51.7104

# Long bulge loop effect - default (RNA/RNA)
melting(sequence = "AUAUGACGCCACAGCG", comp.sequence = "UAUAC---GGUGUCGC",
nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1)

## [1] 66.0497

# Long bulge loop effect -
melting(sequence = "AUAUGACGCCACAGCG", comp.sequence = "UAUAC---GGUGUCGC",
nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1, method.long.bulge.loop = "tur06")

tur06 (RNA/RNA)

## [1] 66.0497

4.2.11 CNG repeats effect

The nearest neighbour model for computation in case of sequences with CNG
repeats can be specified by the argument method.CNG. The available methods
are given in Table 14.

Table 14: Details of methods for sequences with CNG repeats

Model
bro05*

Type

RNA

Limits/Remarks

Reference

Self complementary
sequences. 2 to 7
CNG repeats.

Broda et al. (2005)

* Default method for computation.

Examples

RNA:GCGGCGGCGGC
|||||||||||
RNA:CGCCGCCGCCG

# CNG repeats effect - default (RNA/RNA)
melting(sequence = "GCGGCGGCGGC",

27

Computation of melting temperature of nucleic acid duplexes with rmelting

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1)

## [1] 94.25719

# CNG repeats effect -
melting(sequence = "GCGGCGGCGGC",

bro05 (RNA/RNA)

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1, method.CNG = "bro05")

## [1] 94.25719

4.2.12 Inosine bases effect

The nearest neighbour model for computation in case of sequences with inosine
bases (I) can be specified by the argument method.inosine. The available
methods are given in Table 15.

Table 15: Details of methods for sequences with inosine bases

Model
san05*

Type

Limits/Remarks

Reference

DNA Missing parameters

Watkins and SantaLucia (2005)

for tandem base pairs
containing inosine
bases.
Only IU base pairs. Wright et al. (2007)

zno07*

RNA

* Default method for computation.

Examples

DNA:CCGICTGTIGCG
||| |||| |||
DNA:GGCCGACACCGC

RNA:GCAICGC
||| |||
RNA:CGUUGCG

# Inosine bases effect - default (DNA/DNA)
melting(sequence = "CCGICTGTIGCG", comp.sequence = "GGCCGACACCGC",
nucleic.acid.conc = 0.0001, hybridisation.type = "dnadna",
Na.conc = 1)

## [1] 65.36853

28

4 Melting temperature computation

# Inosine bases effect - san05 (DNA/DNA)
melting(sequence = "CCGICTGTIGCG", comp.sequence = "GGCCGACACCGC",
nucleic.acid.conc = 0.0001, hybridisation.type = "dnadna",
Na.conc = 1, method.inosine = "san05")

## [1] 65.36853

# Inosine bases effect - default (RNA/RNA)
melting(sequence = "GCAICGC", comp.sequence = "CGUUGCG",

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1)

## [1] 46.75042

# Inosine bases effect -
melting(sequence = "GCAICGC", comp.sequence = "CGUUGCG",

zno07 (RNA/RNA)

nucleic.acid.conc = 0.0001, hybridisation.type = "rnarna",
Na.conc = 1, method.inosine = "zno07")

## [1] 46.75042

4.2.13 Hydroxyadenine bases effect

The nearest neighbour model for computation in case of sequences with hydrox-
yadenine bases can be specified by the argument method.hydroxyadenine. The
available methods are given in Table 16.

Table 16: Details of methods for sequences with hydroxyadenine bases

Model
sug01*

Type

DNA

Limits/Remarks

Reference

Only 5’ GA*C 3’and
5’ TA*A 3’ contexts.

Kawakami et al. (2001)

* Default method for computation.

Examples

*

DNA:AGAAATGACACGGTG
|||||||||||||||
DNA:TCTTTACCGTGCCAC

# Hydroxyadenine bases effect - default (DNA/DNA)
melting(sequence = "AGAAATGA*CACGGTG", comp.sequence = "TCTTTACCGTGCCAC",
nucleic.acid.conc = 0.0001, hybridisation.type = "dnadna",
Na.conc = 1)

29

Computation of melting temperature of nucleic acid duplexes with rmelting

## [1] 68.46041

# Hydroxyadenine bases effect - sug01 (DNA/DNA)
melting(sequence = "AGAAATGA*CACGGTG", comp.sequence = "TCTTTACCGTGCCAC",
nucleic.acid.conc = 0.0001, hybridisation.type = "dnadna",
Na.conc = 1, method.hydroxyadenine = "sug01")

## [1] 68.46041

4.2.14 Azobenzenes effect

The nearest neighbour model for computation in case of sequences with azoben-
zenes (X_T for trans azobenzenes and X_C for cis azobenzenes) can be specified
by the argument method.azobenzenes. The available methods are given in
Table 17.

Table 17: Details of methods for sequences with azobenzenes

Model
asa05*

Type

DNA

Limits/Remarks

Reference

Asanuma et al. (2005)

Less reliable
results when the
number of cis
azobenzene
increases.

* Default method for computation.

Examples

C

C

C

C

C

DNA:CTXTTAAXGAAGXGAGAXTATAXCC
|| |||| |||| |||| |||| ||
DNA:GA AATT CTTC CTCT ATAT GG

# Azobenzenes effect - default (DNA/DNA)
melting(sequence = "CTX_CTTAAX_CGAAGX_CGAGAX_CTATAX_CCC",

nucleic.acid.conc = 0.0001, hybridisation.type = "dnadna",
Na.conc = 1)

## [1] 47.85385

# Azobenzenes effect - asa05 (DNA/DNA)
melting(sequence = "CTX_CTTAAX_CGAAGX_CGAGAX_CTATAX_CCC",

nucleic.acid.conc = 0.0001, hybridisation.type = "dnadna",
Na.conc = 1, method.azobenzenes = "asa05")

## [1] 47.85385

30

4 Melting temperature computation

4.2.15 Single Locked nucleic acid effect

The nearest neighbour model for computation in case of sequences with single
locked nucleic acids can be specified by the argument method.locked. The
available methods are given in Table 18.

Table 18: Details of methods for sequences with single locked nucleic acids

Model

mct04
owc11*

Type

DNA
DNA

Limits/Remarks Reference

McTigue et al. (2004)
Owczarzy et al. (2011)

* Default method for computation.

Examples

L

DNA:CCATTGCTACC
|||||||||||
DNA:GGTAACGATGG

# Single locked nucleic acids effect - default (DNA/DNA)
melting(sequence = "CCATTLGCTACC",

nucleic.acid.conc = 0.0001, hybridisation.type = "dnadna",
Na.conc = 1)

## [1] 63.48299

# Single locked nucleic acids effect - mct04 (DNA/DNA)
melting(sequence = "CCATTLGCTACC",

nucleic.acid.conc = 0.0001, hybridisation.type = "dnadna",
Na.conc = 1, method.locked = "mct04")

## [1] 63.61426

# Single locked nucleic acids effect - owc11 (DNA/DNA)
melting(sequence = "CCATTLGCTACC",

nucleic.acid.conc = 0.0001, hybridisation.type = "dnadna",
Na.conc = 1, method.locked = "owc11")

## [1] 63.48299

4.3 Consecutive Locked nucleic acids effect

The nearest neighbour model
sequences
with consecutive locked nucleic acids can be specified by the argument
method.consecutive.locked. The available methods are given in Table 19.

for computation in case of

31

Computation of melting temperature of nucleic acid duplexes with rmelting

Table 19: Details of methods for sequences with single locked nucleic acids

Model
owc11*

Type

DNA

Limits/Remarks Reference

Owczarzy et al. (2011)

* Default method for computation.

Examples

LL
DNA:GACC
||||
DNA:CTGG

# Consecutive locked nucleic acids effect - default (DNA/DNA)
melting(sequence = "GALCLC",

nucleic.acid.conc = 0.0001, hybridisation.type = "dnadna",
Na.conc = 1)

## [1] 12.94323

# Consecutive locked nucleic acids effect - owc11 (DNA/DNA)
melting(sequence = "GALCLC",

nucleic.acid.conc = 0.0001, hybridisation.type = "dnadna",
Na.conc = 1, method.consecutive.locked = "owc11")

## [1] 12.94323

4.4 Consecutive Locked nucleic acids with a single mis-

match effect

The nearest neighbour model for computation in case of sequences with consecu-
tive locked nucleic acids with single mismatch can be specified by the argument
method.consecutive.locked.singleMM. The available methods are given in
Table 20.

Table 20: Details of methods for sequences with single locked nucleic acids

Model
owc11*

Type

DNA

Limits/Remarks Reference

Owczarzy et al. (2011)

* Default method for computation.

32

5 Corrections

Examples

LLL
DNA:GACGC
|| ||
DNA:CTTCG

# Consecutive locked nucleic acids effect - default (DNA/DNA)
melting(sequence = "GALCLGLC", comp.sequence = "CTTCG",

nucleic.acid.conc = 0.0001, hybridisation.type = "dnadna",
Na.conc = 1)

## [1] 0.2520424

# Consecutive locked nucleic acids effect - owc11 (DNA/DNA)
melting(sequence = "GALCLGLC", comp.sequence = "CTTCG",

nucleic.acid.conc = 0.0001, hybridisation.type = "dnadna",
Na.conc = 1, method.consecutive.locked.singleMM = "owc11")

## [1] 0.2520424

5 Corrections

Once the melting temperature is computed, a correction is applied to it according
to the concentration of nucleic acids, cations and/or denaturing agents.

5.1 Nucleic acid concentration

For self complementary sequences (auto detected or specified by force.self) it
is 1. Otherwise it is 4 if the both strands are present in equivalent amount and 1
if one strand is in excess.

5.2 Ion corrections

Melting temperature is computed initially for [Na+] = 1 M, after which a
correction for the presence of cations ([Na+], [K+], [Tris+] and [Mg+]) is applied
either directly on the computed melting temperature or on the computed entropy.

Th correction methods for cation concentration can be specified by the argument
correction.ion.

5.2.1 Sodium corrections

The available correction methods for sodium concentration are given in Table
21.

Table 21: Details of the corrections for sodium concentration

33

Computation of melting temperature of nucleic acid duplexes with rmelting

Correction Type

Limits/Remarks Reference

ahs01
kam71

DNA
DNA

marschdot DNA

owc1904

owc2004

owc2104

DNA

DNA

DNA

owc2204* DNA

san96
san04

DNA
DNA

schlif

tanna06

tanna07*

wet91

DNA

DNA

RNA or
2’-O-
MeRNA/RNA
RNA, DNA
and
RNA/DNA

Na>0.
Na>0;
Na>=0.069;
Na<=1.02.
Na>=0.069;
Na<=1.02.
Na>0. (equation
19)
Na>0. (equation
20)
Na>0. (equation
21)
Na>0. (equation
22)
Na>=0.1.
Na>=0.05;
Na<=1.1;
Oligonucleotides
inferior to 16
bases.
Na>=0.07;
Na<=0.12.
Na>=0.001;
Na<=1.
Na>=0.003;
Na<=1.

Ahsen et al. (2001)
Frank-Kamenetskii (1971)

Marmur and Doty (1962),
Blake and Delcourt (1998)
Owczarzy et al. (2004)

Owczarzy et al. (2004)

Owczarzy et al. (2004)

Owczarzy et al. (2004)

SantaLucia et al. (1996)
SantaLucia and Hicks (2004),
SantaLucia (1998)

Schildkraut and Lifson (1965)

Tan and Chen (2006)

Tan and Chen (2007)

Na>0.

Wetmur (1991)

* Default method for computation.

# Na correction - default (DNA/DNA)
melting(sequence = "CCAGCCAGTCTCTCC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 0.069)

## [1] 56.70492

# Na correction - owc2204 (DNA/DNA)
melting(sequence = "CCAGCCAGTCTCTCC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",

34

5 Corrections

Na.conc = 0.069, correction.ion = "owc2204")

## [1] 56.70492

# Na correction - ahs01 (DNA/DNA)
melting(sequence = "CCAGCCAGTCTCTCC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 0.069, correction.ion = "ahs01")

## [1] 54.1569

# Na correction - kam71 (DNA/DNA)
melting(sequence = "CCAGCCAGTCTCTCC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 0.069, correction.ion = "kam71")

## [1] 51.72963

# Na correction - marschdot (DNA/DNA)
melting(sequence = "CCAGCCAGTCTCTCC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 0.069, correction.ion = "marschdot")

## [1] 49.18075

# Na correction - owc1904 (DNA/DNA)
melting(sequence = "CCAGCCAGTCTCTCC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 0.069, correction.ion = "owc1904")

## [1] 56.18571

# Na correction - owc2004 (DNA/DNA)
melting(sequence = "CCAGCCAGTCTCTCC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 0.069, correction.ion = "owc2004")

## [1] 56.67553

# Na correction - owc2104 (DNA/DNA)
melting(sequence = "CCAGCCAGTCTCTCC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 0.069, correction.ion = "owc2104")

## [1] 56.63967

# Na correction - san96 (DNA/DNA)
melting(sequence = "CCAGCCAGTCTCTCC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 0.069, correction.ion = "san96")

35

Computation of melting temperature of nucleic acid duplexes with rmelting

## [1] 53.01651

# Na correction - san04 (DNA/DNA)
melting(sequence = "CCAGCCAGTCTCTCC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 0.069, correction.ion = "san04")

## [1] 54.15157

# Na correction - schlif (DNA/DNA)
melting(sequence = "CCAGCCAGTCTCTCC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 0.069, correction.ion = "schlif")

## [1] 48.25579

# Na correction - tanna06 (DNA/DNA)
melting(sequence = "CCAGCCAGTCTCTCC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 0.069, correction.ion = "tanna06")

## [1] 55.26711

# Na correction - wet91 (DNA/DNA)
melting(sequence = "CCAGCCAGTCTCTCC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 0.069, correction.ion = "wet91")

## [1] 51.74573

# Na correction - default (RNA/RNA)
melting(sequence = "CCAGCCAGUCUCUCC",

nucleic.acid.conc = 0.000002, hybridisation.type = "rnarna",
Na.conc = 0.069)

## [1] 75.1552

# Na correction -
tanna07 (RNA/RNA)
melting(sequence = "CCAGCCAGUCUCUCC",

nucleic.acid.conc = 0.000002, hybridisation.type = "rnarna",
Na.conc = 0.069, correction.ion = "tanna07")

## [1] 75.1552

# Na correction -
melting(sequence = "CCAGCCAGUCUCUCC",

wet91 (RNA/RNA)

nucleic.acid.conc = 0.000002, hybridisation.type = "rnarna",
Na.conc = 0.069, correction.ion = "wet91")

## [1] 69.55572

36

5 Corrections

# Na correction - default (mRNA/RNA)
melting(sequence = "UACGCGUCAAUAACGCUA",

nucleic.acid.conc = 0.000002, hybridisation.type = "mrnarna",
Na.conc = 0.069)

## [1] 81.57763

# Na correction -
melting(sequence = "UACGCGUCAAUAACGCUA",

tanna07 (mRNA/RNA)

nucleic.acid.conc = 0.000002, hybridisation.type = "mrnarna",
Na.conc = 0.069, correction.ion = "tanna07")

## [1] 81.57763

# Na correction - default (DNA/RNA)
melting(sequence = "CCAGCCAGTCTCTCC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnarna",
Na.conc = 0.069)

## [1] 62.08869

# Na correction - wet91 (DNA/RNA)
melting(sequence = "CCAGCCAGTCTCTCC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnarna",
Na.conc = 0.069, correction.ion = "wet91")

## [1] 62.08869

5.2.2 Magnesium corrections

The available correction methods for magnesium concentration are given in
Table 22.

Table 22: Details of the corrections for magnesium concentration

Correction Type
owcmg08*

DNA

tanmg06

DNA

tanmg07*

RNA or 2’-O-
MeRNA/RNA

Limits/Remarks

Reference

Mg>=0.0005;
Mg<=0.6.
Mg>=0.0001;
Mg<=1; Oligomer
length superior to 6
base pairs.
Mg>=0.1;
Mg<=0.3.

Owczarzy et al. (2008)

Tan and Chen (2006)

Tan and Chen (2007)

* Default method for computation.

37

Computation of melting temperature of nucleic acid duplexes with rmelting

# Mg correction - default (DNA/DNA)
melting(sequence = "CAGCCTCGTCGCAGC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Mg.conc = 0.0015)

## [1] 65.52043

# Mg correction - owcmg08 (DNA/DNA)
melting(sequence = "CAGCCTCGTCGCAGC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Mg.conc = 0.0015, correction.ion = "owcmg08")

## [1] 65.52043

# Mg correction - tanmg06 (DNA/DNA)
melting(sequence = "CAGCCTCGTCGCAGC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Mg.conc = 0.0015, correction.ion = "tanmg06")

## [1] 64.88082

# Mg correction - default (RNA/RNA)
melting(sequence = "CAGCCUCGUCGCAGC",

nucleic.acid.conc = 0.000002, hybridisation.type = "rnarna",
Mg.conc = 0.0015)

## [1] 82.0796

# Mg correction -
tanmg07 (RNA/RNA)
melting(sequence = "CAGCCUCGUCGCAGC",

nucleic.acid.conc = 0.000002, hybridisation.type = "rnarna",
Mg.conc = 0.0015, correction.ion = "tanmg07")

## [1] 82.0796

# Mg correction - default (mRNA/RNA)
melting(sequence = "UACGCGUCAAUAACGCUA",

nucleic.acid.conc = 0.000002, hybridisation.type = "mrnarna",
Mg.conc = 0.0015)

## [1] 90.06842

# Mg correction -
melting(sequence = "UACGCGUCAAUAACGCUA",

tanmg07 (mRNA/RNA)

nucleic.acid.conc = 0.000002, hybridisation.type = "mrnarna",
Mg.conc = 0.0015, correction.ion = "tanmg07")

## [1] 90.06842

38

5 Corrections

5.2.3 Mixed Sodium and Magnesium corrections

The available correction methods for mixed sodium magnesium concentration
are given in Table 23.

Table 23: Details of the corrections for mixed sodium and magnesium concen-
tration

Correction
owcmix08*

Type

DNA

tanmix07

DNA, RNA or
2’-O-
MeRNA/RNA

Limits/Remarks

Reference

Owczarzy et al. (2008)

Tan and Chen (2007)

Mg>=0.0005;
Mg<=0.6;
Na+K+Tris/2>0.
Mg>=0.1;
Mg<=0.3;
Na+K+Tris/2>=0.1;
Na+K+Tris/2<=0.3.

* Default method for computation.

# Mixed Na & Mg correction - default (DNA/DNA)
melting(sequence = "CAGCCTCGTCGCAGC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 0.069, Mg.conc = 0.0015)

## [1] 65.83371

# Mixed Na & Mg correction - owcmix08 (DNA/DNA)
melting(sequence = "CAGCCTCGTCGCAGC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 0.069, Mg.conc = 0.0015, correction.ion = "owcmix08")

## [1] 65.83371

# Mixed Na & Mg correction - tanmix07 (DNA/DNA)
melting(sequence = "CAGCCTCGTCGCAGC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 0.069, Mg.conc = 0.0015, correction.ion = "tanmix07")

## [1] 63.21723

# Mixed Na & Mg correction - default (RNA/RNA)
melting(sequence = "CAGCCUCGUCGCAGC",

nucleic.acid.conc = 0.000002, hybridisation.type = "rnarna",
Na.conc = 0.069, Mg.conc = 0.0015)

## [1] 79.40119

39

Computation of melting temperature of nucleic acid duplexes with rmelting

# Mixed Na & Mg correction - tanmix07 (RNA/RNA)
melting(sequence = "CAGCCUCGUCGCAGC",

nucleic.acid.conc = 0.000002, hybridisation.type = "rnarna",
Na.conc = 0.069, Mg.conc = 0.0015, correction.ion = "tanmix07")

## [1] 79.40119

# Mixed Na & Mg correction - default (mRNA/RNA)
melting(sequence = "UACGCGUCAAUAACGCUA",

nucleic.acid.conc = 0.000002, hybridisation.type = "mrnarna",
Na.conc = 0.069, Mg.conc = 0.0015)

## [1] 96.46186

# Mixed Na & Mg correction - tanmix07 (mRNA/RNA)
melting(sequence = "UACGCGUCAAUAACGCUA",

nucleic.acid.conc = 0.000002, hybridisation.type = "mrnarna",
Na.conc = 0.069, Mg.conc = 0.0015, correction.ion = "tanmix07")

## [1] 96.46186

The ion correction by Owczarzy et al. (2008) is used by default according to the
[Mg2+]0.5
[Mon+]

ratio, where [Mon+] = Na+] + [Tris+] + [K+].

If,

• [K+] = 0, default sodium correction is used;
• Ratio < 0.22, default sodium correction is used;
• 0.22 ≤ Ratio < 6, default mixed Na and Mg correction is used and
• Ratio ≥ 6,default magnesium correction is used.

Note that [Tris+] is about half of the total tris buffer concentration.

5.2.4 Sodium equivalent concentration methods

The available correction methods for mixed sodium magnesium concentration
are given in Table 24.

Table 24: Details of the methods for computation of sodium equivalent concen-
tration in the presence of other ions

Correction
ahs01*
mit96
pey00

Type

DNA
DNA
DNA

Limits/Remarks Reference

Ahsen et al. (2001)
Mitsuhashi (1996)
Peyret (2000)

* Default method for computation.

40

5 Corrections

# Na equivalent concentration method - default (DNA/DNA)
melting(sequence = "CAGCCTCGTCGCAGC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 0.069, Mg.conc = 0.0015)

## [1] 65.83371

# Na equivalent concentration method - ahs01 (DNA/DNA)
melting(sequence = "CAGCCTCGTCGCAGC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 0.069, Mg.conc = 0.0015, method.Naeq = "ahs01")

## [1] 65.83371

# Na equivalent concentration method - mit96 (DNA/DNA)
melting(sequence = "CAGCCTCGTCGCAGC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 0.069, Mg.conc = 0.0015, method.Naeq = "mit96")

## [1] 65.83371

# Na equivalent concentration method - pey00 (DNA/DNA)
melting(sequence = "CAGCCTCGTCGCAGC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 0.069, Mg.conc = 0.0015, method.Naeq = "pey00")

## [1] 65.83371

5.3 Denaturing agent corrections

These include melting temperature corrections for concentration of formamide
and DMSO.

5.3.1 DMSO corrections

The available correction methods for DMSO concentration are given in Table
25.

Table 25: Details of the corrections for DMSO concentration

Correction
ahs01*

Type

DNA

cul76

DNA

Limits/Remarks

Reference

Not tested with
experimental
results.
Not tested with
experimental
results.

Ahsen et al. (2001)

Cullen and Bick (1976)

41

Computation of melting temperature of nucleic acid duplexes with rmelting

Correction

esc80

Type

DNA

mus81

DNA

Limits/Remarks

Reference

Not tested with
experimental
results.
Not tested with
experimental
results.

Escara and Hutton (1980)

Musielski et al. (1981)

* Default method for computation.

# DMSO correction - default (DNA/DNA)
melting(sequence = "CAGCCTCGTCGCAGC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 1, DMSO.conc = 10)

## [1] 65.40154

# DMSO correction - ahs01 (DNA/DNA)
melting(sequence = "CAGCCTCGTCGCAGC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 1, DMSO.conc = 10, correction.DMSO = "ahs01")

## [1] 65.40154

# DMSO correction - cul76 (DNA/DNA)
melting(sequence = "CAGCCTCGTCGCAGC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 1, DMSO.conc = 10, correction.DMSO = "cul76")

## [1] 67.90154

# DMSO correction - esc80 (DNA/DNA)
melting(sequence = "CAGCCTCGTCGCAGC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 1, DMSO.conc = 10, correction.DMSO = "esc80")

## [1] 66.15154

# DMSO correction - mus80 (DNA/DNA)
melting(sequence = "CAGCCTCGTCGCAGC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 1, DMSO.conc = 10, correction.DMSO = "mus81")

## [1] 66.90154

42

6 Equivalent options in MELTING 5

5.3.2 Formamide corrections

The available correction methods for formamide concentration are given in Table
26.

Table 26: Details of the corrections for formamide concentration

Correction
bla96*

lincorr

Type

Limits/Remarks

Reference

DNA With formamide
concentration in
mol/L.

DNA With a % of

formamide volume.

Blake (1996)

McConaughy et al. (1969),
Record (1967), Casey and
Davidson (1977), Hutton
(1977)

* Default method for computation.

# Formamide correction - default (DNA/DNA)
melting(sequence = "CAGCCTCGTCGCAGC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 1, formamide.conc = 0.06)

## [1] 72.74867

# Formamide correction - bla96 (DNA/DNA)
melting(sequence = "CAGCCTCGTCGCAGC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 1, formamide.conc = 0.06, correction.formamide = "bla96")

## [1] 72.74867

# Formamide correction - lincorr (DNA/DNA)
melting(sequence = "CAGCCTCGTCGCAGC",

nucleic.acid.conc = 0.000002, hybridisation.type = "dnadna",
Na.conc = 1, formamide.conc = 10, correction.formamide = "lincorr")

## [1] 66.40154

6 Equivalent options in MELTING 5

The options in MELTING 5 command line equivalent to the arguments in
rmelting are given in Table 27.

Table 27: Arguments in rmelting and their equivalent options in MELTING 5
command line.

43

Computation of melting temperature of nucleic acid duplexes with rmelting

rmelting

MELTING 5 (command line)

sequence
comp.sequence
nucleic.acid.conc
hybridisation.type
Na.conc
Mg.conc
Tris.conc
K.conc
dNTP.conc
DMSO.conc
formamide.conc
size.threshold
self
correction.factor
method.approx
method.nn
method.GU
method.singleMM
method.tandemMM
method.single.dangle
method.double.dangle
method.long.dangle
method.internal.loop
method.single.bulge.loop
method.long.bulge.loop
method.CNG
method.inosine
method.hydroxyadenine
method.azobenzenes
method.locked
method.consecutive.locked
method.consecutive.locked.singleMM
correction.ion
method.Naeq

-S
-C
-P
-H
-E
-E
-E
-E
-E
-E
-E
-T
-self
-F
-am
-nn
-GU
-sinMM
-tanMM
-sinDE
-secDE
-lonDE
-intLP
-sinBU
-lonBU
-CNG
-ino
-ha
-azo
-lck
-tanLck
-sinMMLck
-ion
-naeq

7 Batch computation

Melting temperature for multiple nucleic acid duplexes can be computed using
the meltingBatch function.
sequence <- c("CAAAAAG", "CAAAAAAG", "TTTTATAATAAA", "CCATCGCTACC",

"CAAACAAAG", "CCATTGCTACC", "CAAAAAAAG", "GTGAAC", "AAAAAAAA",
"CAACTTGATATTATTA", "CAAATAAAG", "GCGAGC", "GGGACC",

44

7 Batch computation

"CAAAGAAAG", "CTGACAAGTGTC", "GCGAAAAGCG")

meltingBatch(sequence, nucleic.acid.conc = 0.0004,

hybridisation.type = "dnadna", Na.conc = 1)

Environment.Sequence Environment.Complementary sequence

"GTTTTTC"
"GTTTTTTC"
"AAAATATTATTT"
"GGTAGCGATGG"
"GTTTGTTTC"
"GGTAACGATGG"
"GTTTTTTTC"
"CACTTG"
"TTTTTTTT"
"GTTGAACTATAATAAT"
"GTTTATTTC"
"CGCTCG"
"CCCTGG"
"GTTTCTTTC"
"GACTGTTCACAG"
"CGCTTTTCGC"

##
## [1,] "CAAAAAG"
## [2,] "CAAAAAAG"
## [3,] "TTTTATAATAAA"
## [4,] "CCATCGCTACC"
## [5,] "CAAACAAAG"
## [6,] "CCATTGCTACC"
## [7,] "CAAAAAAAG"
## [8,] "GTGAAC"
## [9,] "AAAAAAAA"
## [10,] "CAACTTGATATTATTA"
## [11,] "CAAATAAAG"
## [12,] "GCGAGC"
## [13,] "GGGACC"
## [14,] "CAAAGAAAG"
## [15,] "CTGACAAGTGTC"
## [16,] "GCGAAAAGCG"
##
## [1,] "4e-04"
## [2,] "4e-04"
## [3,] "4e-04"
## [4,] "4e-04"
## [5,] "4e-04"
## [6,] "4e-04"
## [7,] "4e-04"
## [8,] "4e-04"
## [9,] "4e-04"
## [10,] "4e-04"
## [11,] "4e-04"
## [12,] "4e-04"
## [13,] "4e-04"
## [14,] "4e-04"
## [15,] "4e-04"
## [16,] "4e-04"
##
## [1,] "1"
## [2,] "1"
## [3,] "1"
## [4,] "1"
## [5,] "1"

"dnadna"
"dnadna"
"dnadna"
"dnadna"
"dnadna"
"dnadna"
"dnadna"
"dnadna"
"dnadna"
"dnadna"
"dnadna"
"dnadna"
"dnadna"
"dnadna"
"dnadna"
"dnadna"

"0"
"0"
"0"
"0"
"0"

45

Environment.Na concentration (M) Environment.Mg concentration (M)

Environment.Nucleic acid concentration (M) Environment.Hybridization type

Computation of melting temperature of nucleic acid duplexes with rmelting

Environment.Tris concentration (M) Environment.K concentration (M)

Environment.dNTP concentration (M) Environment.DMSO concentration (%)

Environment.Formamide concentration (M or %)

## [6,] "1"
## [7,] "1"
## [8,] "1"
## [9,] "1"
## [10,] "1"
## [11,] "1"
## [12,] "1"
## [13,] "1"
## [14,] "1"
## [15,] "1"
## [16,] "1"
##
## [1,] "0"
## [2,] "0"
## [3,] "0"
## [4,] "0"
## [5,] "0"
## [6,] "0"
## [7,] "0"
## [8,] "0"
## [9,] "0"
## [10,] "0"
## [11,] "0"
## [12,] "0"
## [13,] "0"
## [14,] "0"
## [15,] "0"
## [16,] "0"
##
## [1,] "0"
## [2,] "0"
## [3,] "0"
## [4,] "0"
## [5,] "0"
## [6,] "0"
## [7,] "0"
## [8,] "0"
## [9,] "0"
## [10,] "0"
## [11,] "0"
## [12,] "0"
## [13,] "0"
## [14,] "0"
## [15,] "0"
## [16,] "0"
##

46

"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"

"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"

"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"

## [1,] "0"
## [2,] "0"
## [3,] "0"
## [4,] "0"
## [5,] "0"
## [6,] "0"
## [7,] "0"
## [8,] "0"
## [9,] "0"
## [10,] "0"
## [11,] "0"
## [12,] "0"
## [13,] "0"
## [14,] "0"
## [15,] "0"
## [16,] "0"
##
## [1,] "FALSE"
## [2,] "FALSE"
## [3,] "FALSE"
## [4,] "FALSE"
## [5,] "FALSE"
## [6,] "FALSE"
## [7,] "FALSE"
## [8,] "FALSE"
## [9,] "FALSE"
## [10,] "FALSE"
## [11,] "FALSE"
## [12,] "FALSE"
## [13,] "FALSE"
## [14,] "FALSE"
## [15,] "FALSE"
## [16,] "FALSE"
##
## [1,] NA
## [2,] NA
## [3,] NA
## [4,] NA
## [5,] NA
## [6,] NA
## [7,] NA
## [8,] NA
## [9,] NA
## [10,] NA
## [11,] NA
## [12,] NA

7 Batch computation

"4"
"4"
"4"
"4"
"4"
"4"
"4"
"4"
"4"
"4"
"4"
"4"
"4"
"4"
"4"
"4"

Environment.Self complementarity Environment.Correction factor

Options.Approximative formula Options.Nearest neighbour model
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

47

Computation of melting temperature of nucleic acid duplexes with rmelting

NA
NA
NA
NA

Options.GU model Options.Single mismatch model

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

## [13,] NA
## [14,] NA
## [15,] NA
## [16,] NA
##
## [1,] NA
## [2,] NA
## [3,] NA
## [4,] NA
## [5,] NA
## [6,] NA
## [7,] NA
## [8,] NA
## [9,] NA
## [10,] NA
## [11,] NA
## [12,] NA
## [13,] NA
## [14,] NA
## [15,] NA
## [16,] NA
##
## [1,] NA
## [2,] NA
## [3,] NA
## [4,] NA
## [5,] NA
## [6,] NA
## [7,] NA
## [8,] NA
## [9,] NA
## [10,] NA
## [11,] NA
## [12,] NA
## [13,] NA
## [14,] NA
## [15,] NA
## [16,] NA
##
## [1,] NA
## [2,] NA
## [3,] NA
## [4,] NA
## [5,] NA
## [6,] NA
## [7,] NA

48

Options.Tandem mismatch model Options.Single dangling end model
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

Options.Double dangling end model Options.Long dangling end model

NA
NA
NA
NA
NA
NA
NA

## [8,] NA
## [9,] NA
## [10,] NA
## [11,] NA
## [12,] NA
## [13,] NA
## [14,] NA
## [15,] NA
## [16,] NA
##
## [1,] NA
## [2,] NA
## [3,] NA
## [4,] NA
## [5,] NA
## [6,] NA
## [7,] NA
## [8,] NA
## [9,] NA
## [10,] NA
## [11,] NA
## [12,] NA
## [13,] NA
## [14,] NA
## [15,] NA
## [16,] NA
##
## [1,] NA
## [2,] NA
## [3,] NA
## [4,] NA
## [5,] NA
## [6,] NA
## [7,] NA
## [8,] NA
## [9,] NA
## [10,] NA
## [11,] NA
## [12,] NA
## [13,] NA
## [14,] NA
## [15,] NA
## [16,] NA
##
## [1,] NA
## [2,] NA

7 Batch computation

NA
NA
NA
NA
NA
NA
NA
NA
NA

Options.Internal loop model Options.Single bulge loop model
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

Options.Long bulge loop model Options.CNG repeats model

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
Options.Inosine bases model Options.Hydroxyadenine bases model

NA
NA

49

Computation of melting temperature of nucleic acid duplexes with rmelting

Options.Azobenzenes model Options.Locked nucleic acids model

## [3,] NA
## [4,] NA
## [5,] NA
## [6,] NA
## [7,] NA
## [8,] NA
## [9,] NA
## [10,] NA
## [11,] NA
## [12,] NA
## [13,] NA
## [14,] NA
## [15,] NA
## [16,] NA
##
## [1,] NA
## [2,] NA
## [3,] NA
## [4,] NA
## [5,] NA
## [6,] NA
## [7,] NA
## [8,] NA
## [9,] NA
## [10,] NA
## [11,] NA
## [12,] NA
## [13,] NA
## [14,] NA
## [15,] NA
## [16,] NA
##
## [1,] NA
## [2,] NA
## [3,] NA
## [4,] NA
## [5,] NA
## [6,] NA
## [7,] NA
## [8,] NA
## [9,] NA
## [10,] NA
## [11,] NA
## [12,] NA
## [13,] NA
## [14,] NA

50

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

Options.Ion correction method Options.Na equivalence correction method

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

7 Batch computation

NA
NA

Options.DMSO correction method Options.Formamide correction method

## [15,] NA
## [16,] NA
##
## [1,] NA
## [2,] NA
## [3,] NA
## [4,] NA
## [5,] NA
## [6,] NA
## [7,] NA
## [8,] NA
## [9,] NA
## [10,] NA
## [11,] NA
## [12,] NA
## [13,] NA
## [14,] NA
## [15,] NA
## [16,] NA
##
## [1,] NA
## [2,] NA
## [3,] NA
## [4,] NA
## [5,] NA
## [6,] NA
## [7,] NA
## [8,] NA
## [9,] NA
## [10,] NA
## [11,] NA
## [12,] NA
## [13,] NA
## [14,] NA
## [15,] NA
## [16,] NA
##
## [1,] "-199386"
## [2,] "-232408"
## [3,] "-329384"
## [4,] "-349030"
## [5,] "-270028"
## [6,] "-338998"
## [7,] "-265430"
## [8,] "-172216"
## [9,] "-211926"

Options.Mode Results.Enthalpy (cal) Results.Entropy (cal)

"-47700"
"-55600"
"-78800"
"-83500"
"-64600"
"-81100"
"-63500"
"-41200"
"-50700"
"-113800"
"-62100"
"-46000"
"-40400"
"-63700"
"-90400"
"-80300"

"-138.1"
"-160.3"
"-229.7"
"-227"
"-183.2"
"-222.5"
"-182.5"
"-117.5"
"-147.2"
"-323.6"
"-179.8"
"-124.8"
"-109.9"
"-181.3"
"-249.5"
"-218.6"

"-577.258"
"-670.054"
"-960.146"
"-948.86"
"-765.776"
"-930.05"
"-762.85"
"-491.15"
"-615.296"

"31.7814953255144"
"38.1103863719918"
"44.5553259145469"
"67.2098590318261"
"47.400072116762"
"63.6040550863501"
"43.0400604037136"
"30.1735038367475"
"33.1415226764116"

51

Results.Enthalpy (J) Results.Entropy (J) Results.Melting temperature (C)

Computation of melting temperature of nucleic acid duplexes with rmelting

"-1352.648"
"-751.564"
"-521.664"
"-459.382"
"-757.834"
"-1042.91"
"-913.748"

"59.6680431282422"
"40.2828264688437"
"48.2393469411973"
"41.9123740666287"
"45.9425910944819"
"64.379329012421"
"65.7707030297917"

Message

## [10,] "-475684"
## [11,] "-259578"
## [12,] "-192280"
## [13,] "-168872"
## [14,] "-266266"
## [15,] "-377872"
## [16,] "-335654"
##
## [1,] NA
## [2,] NA
## [3,] NA
## [4,] NA
## [5,] NA
## [6,] NA
## [7,] NA
## [8,] NA
## [9,] NA
## [10,] NA
## [11,] NA
## [12,] NA
## [13,] NA
## [14,] NA
## [15,] NA
## [16,] NA

Complementary sequences are computed by default, but need to be specified in
case of mismatches, inosine(s) or hydroxyadenine(s) between the two strands.
seq <- c("GCAUACG", "CAGUAGGUC", "CGCUCGC", "GAGUGGAG", "GACAGGCUG",

"CAGUACGUC", "GACAUCCUG", "GACCACCUG", "CAGAAUGUC", "GCGUCGC",
"CGUCCGG", "GACUCUCUG", "CAGCUGGUC", "GACUAGCUG", "CUCUGCUC",
"GCGUCCG", "GUCCGCG", "CGAUCAC", "GACUACCUG", "GACGAUCUG")

comp.seq <- c("CGUUUGC", "GUCGGCCAG", "GCGUGCG", "CUCUUCUC", "CUGUGCGAC",

"GUCGGGCAG", "CUGUUGGAC", "CUGGGGGAC", "GUCUGGCAG", "CGCUGCG",
"GCUGGCC", "CUGAUAGAC", "GUCGUUCAG", "CUGAGCGAC", "GAGUUGAG",
"CGCUGGC", "CUGGCGC", "GCUUGUG", "CUGAGGGAC", "CUGCCAGAC")

meltingBatch(sequence = seq, comp.seq = comp.seq, nucleic.acid.conc = 0.0004,

hybridisation.type = "rnarna", Na.conc = 1,
method.singleMM = "tur06")

Environment.Sequence Environment.Complementary sequence

##
## [1,] "GCAUACG"
## [2,] "CAGUAGGUC"
## [3,] "CGCUCGC"
## [4,] "GAGUGGAG"

52

"CGUUUGC"
"GUCGGCCAG"
"GCGUGCG"
"CUCUUCUC"

Environment.Nucleic acid concentration (M) Environment.Hybridization type

## [5,] "GACAGGCUG"
## [6,] "CAGUACGUC"
## [7,] "GACAUCCUG"
## [8,] "GACCACCUG"
## [9,] "CAGAAUGUC"
## [10,] "GCGUCGC"
## [11,] "CGUCCGG"
## [12,] "GACUCUCUG"
## [13,] "CAGCUGGUC"
## [14,] "GACUAGCUG"
## [15,] "CUCUGCUC"
## [16,] "GCGUCCG"
## [17,] "GUCCGCG"
## [18,] "CGAUCAC"
## [19,] "GACUACCUG"
## [20,] "GACGAUCUG"
##
## [1,] "4e-04"
## [2,] "4e-04"
## [3,] "4e-04"
## [4,] "4e-04"
## [5,] "4e-04"
## [6,] "4e-04"
## [7,] "4e-04"
## [8,] "4e-04"
## [9,] "4e-04"
## [10,] "4e-04"
## [11,] "4e-04"
## [12,] "4e-04"
## [13,] "4e-04"
## [14,] "4e-04"
## [15,] "4e-04"
## [16,] "4e-04"
## [17,] "4e-04"
## [18,] "4e-04"
## [19,] "4e-04"
## [20,] "4e-04"
##
## [1,] "1"
## [2,] "1"
## [3,] "1"
## [4,] "1"
## [5,] "1"
## [6,] "1"
## [7,] "1"
## [8,] "1"

7 Batch computation

"CUGUGCGAC"
"GUCGGGCAG"
"CUGUUGGAC"
"CUGGGGGAC"
"GUCUGGCAG"
"CGCUGCG"
"GCUGGCC"
"CUGAUAGAC"
"GUCGUUCAG"
"CUGAGCGAC"
"GAGUUGAG"
"CGCUGGC"
"CUGGCGC"
"GCUUGUG"
"CUGAGGGAC"
"CUGCCAGAC"

"rnarna"
"rnarna"
"rnarna"
"rnarna"
"rnarna"
"rnarna"
"rnarna"
"rnarna"
"rnarna"
"rnarna"
"rnarna"
"rnarna"
"rnarna"
"rnarna"
"rnarna"
"rnarna"
"rnarna"
"rnarna"
"rnarna"
"rnarna"

"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"

53

Environment.Na concentration (M) Environment.Mg concentration (M)

Computation of melting temperature of nucleic acid duplexes with rmelting

Environment.Tris concentration (M) Environment.K concentration (M)

## [9,] "1"
## [10,] "1"
## [11,] "1"
## [12,] "1"
## [13,] "1"
## [14,] "1"
## [15,] "1"
## [16,] "1"
## [17,] "1"
## [18,] "1"
## [19,] "1"
## [20,] "1"
##
## [1,] "0"
## [2,] "0"
## [3,] "0"
## [4,] "0"
## [5,] "0"
## [6,] "0"
## [7,] "0"
## [8,] "0"
## [9,] "0"
## [10,] "0"
## [11,] "0"
## [12,] "0"
## [13,] "0"
## [14,] "0"
## [15,] "0"
## [16,] "0"
## [17,] "0"
## [18,] "0"
## [19,] "0"
## [20,] "0"
##
## [1,] "0"
## [2,] "0"
## [3,] "0"
## [4,] "0"
## [5,] "0"
## [6,] "0"
## [7,] "0"
## [8,] "0"
## [9,] "0"
## [10,] "0"
## [11,] "0"
## [12,] "0"

54

"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"

"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"

"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"

Environment.dNTP concentration (M) Environment.DMSO concentration (%)

## [13,] "0"
## [14,] "0"
## [15,] "0"
## [16,] "0"
## [17,] "0"
## [18,] "0"
## [19,] "0"
## [20,] "0"
##
## [1,] "0"
## [2,] "0"
## [3,] "0"
## [4,] "0"
## [5,] "0"
## [6,] "0"
## [7,] "0"
## [8,] "0"
## [9,] "0"
## [10,] "0"
## [11,] "0"
## [12,] "0"
## [13,] "0"
## [14,] "0"
## [15,] "0"
## [16,] "0"
## [17,] "0"
## [18,] "0"
## [19,] "0"
## [20,] "0"
##
## [1,] "FALSE"
## [2,] "FALSE"
## [3,] "FALSE"
## [4,] "FALSE"
## [5,] "FALSE"
## [6,] "FALSE"
## [7,] "FALSE"
## [8,] "FALSE"
## [9,] "FALSE"
## [10,] "FALSE"
## [11,] "FALSE"
## [12,] "FALSE"
## [13,] "FALSE"
## [14,] "FALSE"
## [15,] "FALSE"
## [16,] "FALSE"

7 Batch computation

"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"

Environment.Formamide concentration (M or %)

Environment.Self complementarity Environment.Correction factor

"4"
"4"
"4"
"4"
"4"
"4"
"4"
"4"
"4"
"4"
"4"
"4"
"4"
"4"
"4"
"4"

55

Computation of melting temperature of nucleic acid duplexes with rmelting

"4"
"4"
"4"
"4"

Options.Approximative formula Options.Nearest neighbour model
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

Options.GU model Options.Single mismatch model

## [17,] "FALSE"
## [18,] "FALSE"
## [19,] "FALSE"
## [20,] "FALSE"
##
## [1,] NA
## [2,] NA
## [3,] NA
## [4,] NA
## [5,] NA
## [6,] NA
## [7,] NA
## [8,] NA
## [9,] NA
## [10,] NA
## [11,] NA
## [12,] NA
## [13,] NA
## [14,] NA
## [15,] NA
## [16,] NA
## [17,] NA
## [18,] NA
## [19,] NA
## [20,] NA
##
## [1,] NA
## [2,] NA
## [3,] NA
## [4,] NA
## [5,] NA
## [6,] NA
## [7,] NA
## [8,] NA
## [9,] NA
## [10,] NA
## [11,] NA
## [12,] NA
## [13,] NA
## [14,] NA
## [15,] NA
## [16,] NA
## [17,] NA
## [18,] NA
## [19,] NA
## [20,] NA

56

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

##
## [1,] NA
## [2,] NA
## [3,] NA
## [4,] NA
## [5,] NA
## [6,] NA
## [7,] NA
## [8,] NA
## [9,] NA
## [10,] NA
## [11,] NA
## [12,] NA
## [13,] NA
## [14,] NA
## [15,] NA
## [16,] NA
## [17,] NA
## [18,] NA
## [19,] NA
## [20,] NA
##
## [1,] NA
## [2,] NA
## [3,] NA
## [4,] NA
## [5,] NA
## [6,] NA
## [7,] NA
## [8,] NA
## [9,] NA
## [10,] NA
## [11,] NA
## [12,] NA
## [13,] NA
## [14,] NA
## [15,] NA
## [16,] NA
## [17,] NA
## [18,] NA
## [19,] NA
## [20,] NA
##
## [1,] NA
## [2,] NA
## [3,] NA

7 Batch computation

Options.Tandem mismatch model Options.Single dangling end model
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

Options.Double dangling end model Options.Long dangling end model

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

Options.Internal loop model Options.Single bulge loop model
NA
NA
NA

57

Computation of melting temperature of nucleic acid duplexes with rmelting

## [4,] NA
## [5,] NA
## [6,] NA
## [7,] NA
## [8,] NA
## [9,] NA
## [10,] NA
## [11,] NA
## [12,] NA
## [13,] NA
## [14,] NA
## [15,] NA
## [16,] NA
## [17,] NA
## [18,] NA
## [19,] NA
## [20,] NA
##
## [1,] NA
## [2,] NA
## [3,] NA
## [4,] NA
## [5,] NA
## [6,] NA
## [7,] NA
## [8,] NA
## [9,] NA
## [10,] NA
## [11,] NA
## [12,] NA
## [13,] NA
## [14,] NA
## [15,] NA
## [16,] NA
## [17,] NA
## [18,] NA
## [19,] NA
## [20,] NA
##
## [1,] NA
## [2,] NA
## [3,] NA
## [4,] NA
## [5,] NA
## [6,] NA
## [7,] NA

58

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

NA
NA
NA
NA
NA
NA
NA

Options.Long bulge loop model Options.CNG repeats model

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
Options.Inosine bases model Options.Hydroxyadenine bases model

7 Batch computation

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

Options.Azobenzenes model Options.Locked nucleic acids model

## [8,] NA
## [9,] NA
## [10,] NA
## [11,] NA
## [12,] NA
## [13,] NA
## [14,] NA
## [15,] NA
## [16,] NA
## [17,] NA
## [18,] NA
## [19,] NA
## [20,] NA
##
## [1,] NA
## [2,] NA
## [3,] NA
## [4,] NA
## [5,] NA
## [6,] NA
## [7,] NA
## [8,] NA
## [9,] NA
## [10,] NA
## [11,] NA
## [12,] NA
## [13,] NA
## [14,] NA
## [15,] NA
## [16,] NA
## [17,] NA
## [18,] NA
## [19,] NA
## [20,] NA
##
## [1,] NA
## [2,] NA
## [3,] NA
## [4,] NA
## [5,] NA
## [6,] NA
## [7,] NA
## [8,] NA
## [9,] NA
## [10,] NA
## [11,] NA

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

Options.Ion correction method Options.Na equivalence correction method

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

59

Computation of melting temperature of nucleic acid duplexes with rmelting

Options.DMSO correction method Options.Formamide correction method

NA
NA
NA
NA
NA
NA
NA
NA
NA

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

Options.Mode Results.Enthalpy (cal) Results.Entropy (cal)

"-47650"
"-71130"
"-57930"
"-60570"
"-79870"
"-68380"
"-73880"
"-78430"
"-59650"
"-61330"
"-58350"
"-64570"
"-70970"
"-72010"
"-58820"

"-138.8"
"-200.5"
"-164.1"
"-176.6"
"-219.9"
"-194.5"
"-208.3"
"-218.3"
"-171.5"
"-173.8"
"-165.4"
"-184.7"
"-200.6"
"-203"
"-171"

## [12,] NA
## [13,] NA
## [14,] NA
## [15,] NA
## [16,] NA
## [17,] NA
## [18,] NA
## [19,] NA
## [20,] NA
##
## [1,] NA
## [2,] NA
## [3,] NA
## [4,] NA
## [5,] NA
## [6,] NA
## [7,] NA
## [8,] NA
## [9,] NA
## [10,] NA
## [11,] NA
## [12,] NA
## [13,] NA
## [14,] NA
## [15,] NA
## [16,] NA
## [17,] NA
## [18,] NA
## [19,] NA
## [20,] NA
##
## [1,] NA
## [2,] NA
## [3,] NA
## [4,] NA
## [5,] NA
## [6,] NA
## [7,] NA
## [8,] NA
## [9,] NA
## [10,] NA
## [11,] NA
## [12,] NA
## [13,] NA
## [14,] NA
## [15,] NA

60

7 Batch computation

"-59840"
"-59840"
"-50210"
"-70520"
"-69730"

"-169.6"
"-169.6"
"-148.3"
"-198.8"
"-198.2"

Results.Enthalpy (J) Results.Entropy (J) Results.Melting temperature (C)

## [16,] NA
## [17,] NA
## [18,] NA
## [19,] NA
## [20,] NA
##
## [1,] "-199177"
## [2,] "-297323.4"
## [3,] "-242147.4"
## [4,] "-253182.6"
## [5,] "-333856.6"
## [6,] "-285828.4"
## [7,] "-308818.4"
## [8,] "-327837.4"
## [9,] "-249337"
## [10,] "-256359.4"
## [11,] "-243903"
## [12,] "-269902.6"
## [13,] "-296654.6"
## [14,] "-301001.8"
## [15,] "-245867.6"
## [16,] "-250131.2"
## [17,] "-250131.2"
## [18,] "-209877.8"
## [19,] "-294773.6"
## [20,] "-291471.4"
##
## [1,] NA
## [2,] NA
## [3,] NA
## [4,] NA
## [5,] NA
## [6,] NA
## [7,] NA
## [8,] NA
## [9,] NA
## [10,] NA
## [11,] NA
## [12,] NA
## [13,] NA
## [14,] NA
## [15,] NA
## [16,] NA
## [17,] NA
## [18,] NA
## [19,] NA

Message

"-580.184"
"-838.09"
"-685.938"
"-738.188"
"-919.182"
"-813.01"
"-870.694"
"-912.494"
"-716.87"
"-726.484"
"-691.372"
"-772.046"
"-838.508"
"-848.54"
"-714.78"
"-708.928"
"-708.928"
"-619.894"
"-830.984"
"-828.476"

"30.1048299398322"
"51.8989532242754"
"44.3989325444856"
"37.5791954133529"
"62.1162425798375"
"48.141439592185"
"52.845957204839"
"58.2977096620104"
"41.08087522322"
"46.0633145887674"
"44.4380466975271"
"44.8840464672343"
"51.0196486690585"
"52.203376709706"
"37.5268181873443"
"45.2688421309843"
"45.2688421309843"
"28.1788644808993"
"51.6345164549562"
"48.8860141674642"

61

Computation of melting temperature of nucleic acid duplexes with rmelting

## [20,] NA

8 Further reading

Further details about algorithm, formulae and methods are available in the
MELTING 5 documentation.

9 Citing rmelting

@Manual{,

rmelting: R Interface to

Aravind, J. and Krishna, G. K. (2025).
MELTING 5. R package version 1.26.0,
https://aravind-j.github.io/rmelting/.

## To cite the R package 'rmelting' in publications use:
##
##
##
##
##
## A BibTeX entry for LaTeX users is
##
##
##
##
##
##
##
##
## This free and open-source software implements academic research by the
## authors and co-workers. If you use it, please support the project by
## citing the package.

title = {rmelting: R Interface to MELTING 5},
author = {J. Aravind and G. K. Krishna},
year = {2025},
note = {R package version 1.26.0 https://aravind-j.github.io/rmelting/},

}

10 Session Info

sessionInfo()

## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
##
## locale:
## [1] LC_CTYPE=en_US.UTF-8
## [3] LC_TIME=en_GB
## [5] LC_MONETARY=en_US.UTF-8

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

62

LAPACK version 3.12.0

10 Session Info

LC_NAME=en_US.UTF-8
LC_TELEPHONE=en_US.UTF-8
LC_IDENTIFICATION=en_US.UTF-8

datasets

methods

base

graphics

grDevices utils

## [7] LC_PAPER=en_US.UTF-8
## [9] LC_ADDRESS=en_US.UTF-8
## [11] LC_MEASUREMENT=en_US.UTF-8
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats
##
## other attached packages:
## [1] rmelting_1.26.0 readxl_1.4.5
##
## loaded via a namespace (and not attached):
## [1] digest_0.6.37
## [5] magrittr_2.0.4
## [9] pkgconfig_2.0.3
## [13] lifecycle_1.0.4
## [17] vctrs_0.6.5
## [21] pillar_1.11.1
## [25] rlang_1.1.6

xfun_0.53
fastmap_1.2.0
glue_1.8.0
tibble_3.3.0
htmltools_0.5.8.1 rJava_1.0-11
Rdpack_2.6.4
compiler_4.5.1
evaluate_1.0.5

cli_3.6.5
rbibutils_2.3
Rcpp_1.1.0

cellranger_1.1.0
knitr_1.50
rmarkdown_2.30
pander_0.6.6
tools_4.5.1
yaml_2.3.10

References

Ahsen, N. von, Wittwer, C. T., and Schütz, E. (2001). Oligonucleotide melting
temperatures under PCR conditions: Nearest-neighbor corrections for Mg2+,
deoxynucleotide triphosphate, and dimethyl sulfoxide concentrations with com-
parison to alternative empirical formulas. Clinical Chemistry 47, 1956–1961.
Available at: http://clinchem.aaccjnls.org/content/47/11/1956.

Allawi, H. T., and SantaLucia, J. (1997). Thermodynamics and NMR of internal
G·T mismatches in dna. Biochemistry 36, 10581–10594. doi:10.1021/bi962590c.

Allawi, H. T., and SantaLucia, J. (1998a). Nearest neighbor thermodynamic
parameters for internal G·A mismatches in DNA. Biochemistry 37, 2170–2179.
doi:10.1021/bi9724873.

Allawi, H. T., and SantaLucia, J. (1998b). Nearest-neighbor thermodynamics
of internal A·C mismatches in dna: Sequence dependence and pH effects.
Biochemistry 37, 9435–9444. doi:10.1021/bi9803729.

Allawi, H. T., and SantaLucia, J. (1998c). Thermodynamics of
inter-
nal C·T mismatches in DNA. Nucleic Acids Research 26, 2694–2701.
doi:10.1093/nar/26.11.2694.

Asanuma, H., Matsunaga, D., and Komiyama, M. (2005). Clear-cut photo-
regulation of the formation and dissociation of the DNA duplex by modified

63

Computation of melting temperature of nucleic acid duplexes with rmelting

oligonucleotide involving multiple azobenzenes. Nucleic Acids Symposium Series,
35–36. doi:10.1093/nass/49.1.35.

Badhwar, J., Karri, S., Cass, C. K., Wunderlich, E. L., and Znosko, B. M.
(2007). Thermodynamic characterization of RNA duplexes containing natu-
rally occurring 1 × 2 nucleotide internal loops. Biochemistry 46, 14715–14724.
doi:10.1021/bi701024w.

Blake, R. D. (1996). “Denaturation of DNA,” in Encyclopedia of molecular
biology and molecular medicine, ed. R. A. Meyers (Weinheim, Germany: VCH
Verlagsgesellschaft), 1–19.

Blake, R. D., and Delcourt, S. G. (1998). Thermal stability of DNA. Nucleic
Acids Research 26, 3323–3332. doi:10.1093/nar/26.14.3323.

Blose, J. M., Manni, M. L., Klapec, K. A., Stranger-Jones, Y., Zyra, A. C.,
Sim, V., et al. (2007). Non-nearest-neighbor dependence of stability for RNA
bulge loops based on the complete set of group i single nucleotide bulge loops.
Biochemistry 46, 15123–15135. doi:10.1021/bi700736f.

Bommarito, S., Peyret, N., and SantaLucia, J. (2000). Thermodynamic pa-
rameters for DNA sequences with dangling ends. Nucleic Acids Research 28,
1929–1934. doi:10.1093/nar/28.9.1929.

Breslauer, K. J., Frank, R., Blöcker, H., and Marky, L. A. (1986). Predicting
DNA duplex stability from the base sequence. Proceedings of the National
Academy of Sciences 83, 3746. doi:10.1073/pnas.83.11.3746.

Britten, R. J., Graham, D. E., and Neufeld, B. R. (1974). Analysis of re-
peating DNA sequences by reassociation. Methods in Enzymology 29, 363–418.
doi:10.1016/0076-6879(74)29033-5.

Broda, M., Kierzek, E., Gdaniec, Z., Kulinski, T., and Kierzek, R. (2005).
Thermodynamic stability of RNA structures formed by CNG trinucleotide
repeats. Implication for prediction of RNA structure. Biochemistry 44, 10873–
10882. doi:10.1021/bi0502339.

Casey, J., and Davidson, N. (1977). Rates of formation and thermal stabilities
of RNA:DNA and DNA:DNA duplexes at high concentrations of formamide.
Nucleic Acids Research 4, 1539–1552. doi:10.1093/nar/4.5.1539.

Chen, J. L., Dishler, A. L., Kennedy, S. D., Yildirim, I., Liu, B., Turner, D. H.,
et al. (2012). Testing the nearest neighbor model for canonical rna base pairs:
Revision of GU parameters. Biochemistry 51, 3508–3522. doi:10.1021/bi3002709.

Chester, N., and Marshak, D. R. (1993). Dimethyl sulfoxide-mediated primer
Tm reduction: A method for analyzing the role of renaturation tempera-
ture in the polymerase chain reaction. Analytical Biochemistry 209, 284–290.
doi:10.1006/abio.1993.1121.

Cullen, B. R., and Bick, M. D. (1976). Thermal denaturation of DNA
from bromodeoxyuridine substituted cells. Nucleic Acids Research 3, 49–62.

64

10 Session Info

doi:10.1093/nar/3.1.49.

Davis, A. R., and Znosko, B. M. (2007). Thermodynamic characterization of
single mismatches found in naturally occurring RNA. Biochemistry 46, 13425–
13436. doi:10.1021/bi701311c.

Davis, A. R., and Znosko, B. M. (2008). Thermodynamic characterization
of naturally occurring RNA single mismatches with G-U nearest neighbors.
Biochemistry 47, 10178–10187. doi:10.1021/bi800471z.

Dumousseau, M., Rodriguez, N., Juty, N., and Le Novère, N. (2012). MELTING,
a flexible platform to predict the melting temperatures of nucleic acids. BMC
Bioinformatics 13, 101. doi:10.1186/1471-2105-13-101.

Escara, J. F., and Hutton, J. R. (1980). Thermal stability and renaturation
of DNA in dimethyl sulfoxide solutions: Acceleration of the renaturation rate.
Biopolymers 19, 1315–1327. doi:10.1002/bip.1980.360190708.

Frank-Kamenetskii, M. D. (1971). Simplification of the empirical relationship
between melting temperature of DNA, its GC content and concentration of
sodium ions in solution. Biopolymers 10, 2623–2624. doi:10.1002/bip.360101223.

Freier, S. M., Kierzek, R., Jaeger, J. A., Sugimoto, N., Caruthers, M. H., Neilson,
Improved free-energy parameters for predictions of RNA
T., et al. (1986).
duplex stability. Proceedings of the National Academy of Sciences 83, 9373.
doi:10.1073/pnas.83.24.9373.

Hall, T. J., Grula, J. W., Davidson, E. H., and Britten, R. J. (1980). Evolution
of sea urchin non-repetitive DNA. Journal of Molecular Evolution 16, 95–110.
doi:10.1007/BF01731580.

Hutton, J. R. (1977). Renaturation kinetics and thermal stability of DNA in
aqueous solutions of formamide and urea. Nucleic Acids Research 4, 3537–3555.
doi:10.1093/nar/4.10.3537.

Kawakami, J., Kamiya, H., Yasuda, K., Fujiki, H., Kasai, H., and Sugimoto, N.
(2001). Thermodynamic stability of base pairs between 2-hydroxyadenine and in-
coming nucleotides as a determinant of nucleotide incorporation specificity during
replication. Nucleic Acids Research 29, 3289–3296. doi:10.1093/nar/29.16.3289.

Kierzek, E., Mathews, D. H., Ciesielska, A., Turner, D. H., and Kierzek, R. (2006).
Nearest neighbor parameters for Watson-Crick complementary heteroduplexes
formed between 2’-O-methyl RNA and RNA oligonucleotides. Nucleic Acids
Research 34, 3609–3614. doi:10.1093/nar/gkl232.

Le Novère, N. (2001). MELTING, computing the melting temperature of nucleic
acid duplex. Bioinformatics 17, 1226–1227. doi:10.1093/bioinformatics/17.12.1226.

Lu, Z. J., Turner, D. H., and Mathews, D. H. (2006). A set of nearest neighbor
parameters for predicting the enthalpy change of RNA secondary structure
formation. Nucleic Acids Research 34, 4912–4924. doi:10.1093/nar/gkl472.

65

Computation of melting temperature of nucleic acid duplexes with rmelting

Marmur, J., and Doty, P. (1962). Determination of the base composition of
deoxyribonucleic acid from its thermal denaturation temperature. Journal of
Molecular Biology 5, 109–118. doi:10.1016/S0022-2836(62)80066-7.

Mathews, D. H., Sabina, J., Zuker, M., and Turner, D. H. (1999). Expanded
sequence dependence of thermodynamic parameters improves prediction
of RNA secondary structure. Journal of Molecular Biology 288, 911–940.
doi:10.1006/jmbi.1999.2700.

McConaughy, B. L., Laird, C., and McCarthy, B. J. (1969). Nucleic acid reasso-
ciation in formamide. Biochemistry 8, 3289–3295. doi:10.1021/bi00836a024.

McTigue, P. M., Peterson, R. J., and Kahn, J. D. (2004). Sequence-dependent
thermodynamic parameters for locked nucleic acid (LNA)-DNA duplex formation.
Biochemistry 43, 5388–5405. doi:10.1021/bi035976d.

Miller, S., Jones, L. E., Giovannitti, K., Piper, D., and Serra, M. J. (2008).
Thermodynamic analysis of 5’ and 3’ single- and 3’ double-nucleotide overhangs
neighboring wobble terminal base pairs. Nucleic Acids Research 36, 5652–5659.
doi:10.1093/nar/gkn525.

Mitsuhashi, M. (1996). Technical report: Part 1. Basic requirements for designing
optimal oligonucleotide probe sequences. Journal of Clinical Laboratory Analysis
10, 277–284. doi:10/cw9bn6.

Musielski, H., Mann, W., Laue, R., and Michel, S. (1981).
of dimethylsulfoxide
RNA polymerase.
doi:10.1002/jobm.19810210606.

Influence
on transcription by bacteriophage T3-induced
Zeitschrift für allgemeine Mikrobiologie 21, 447–456.

Ohmichi, T., Nakano, S.-i., Miyoshi, D., and Sugimoto, N. (2002). Long RNA
dangling end has large energetic contribution to duplex stability. Journal of the
American Chemical Society 124, 10367–10372. doi:10.1021/ja0255406.

O’Toole, A. S., Miller, S., Haines, N., Zink, M. C., and Serra, M. J. (2006).
Comprehensive thermodynamic analysis of 3’ double-nucleotide overhangs neigh-
boring Watson-Crick terminal base pairs. Nucleic Acids Research 34, 3338–3344.
doi:10.1093/nar/gkl428.

O’Toole, A. S., Miller, S., and Serra, M. J. (2005). Stability of 3’ double
nucleotide overhangs that model the 3’ ends of siRNA. RNA 11, 512–516.
doi:10.1261/rna.7254905.

Owczarzy, R., Moreira, B. G., You, Y., Behlke, M. A., and Walder, J. A. (2008).
Predicting stability of DNA duplexes in solutions containing magnesium and
monovalent cations. Biochemistry 47, 5336–5353. doi:10.1021/bi702363u.

Owczarzy, R., You, Y., Groth, C. L., and Tataurov, A. V. (2011). Stability and
mismatch discrimination of locked nucleic acid–DNA duplexes. Biochemistry 50,
9352–9367. doi:10.1021/bi200904e.

66

10 Session Info

Owczarzy, R., You, Y., Moreira, B. G., Manthey, J. A., Huang, L., Behlke,
M. A., et al.
(2004). Effects of sodium ions on DNA duplex oligomers:
Improved predictions of melting temperatures. Biochemistry 43, 3537–3554.
doi:10.1021/bi034621r.

Owen, R., Hill, L., and Lapage, S. (1969). Determination of DNA base com-
positions from melting profiles in dilute buffers. Biopolymers 7, 503–516.
doi:10.1002/bip.1969.360070408.

Peyret, N. (2000). Prediction of nucleic acid hybridization: Parameters and
algorithms. Available at: http://elibrary.wayne.edu/record=2760965.

Peyret, N., Seneviratne, P. A., Allawi, H. T., and SantaLucia, J. (1999).
Nearest-Neighbor Thermodynamics and NMR of DNA Sequences with Inter-
nal A·A, C·C, G·G, and T·T Mismatches. Biochemistry 38, 3468–3477.
doi:10.1021/bi9825091.

Record, M. T. (1967). Electrostatic effects on polynucleotide transitions. I. Be-
havior at neutral pH. Biopolymers 5, 975–992. doi:10.1002/bip.1967.360051010.

SantaLucia, J. (1998). A unified view of polymer, dumbbell, and oligonucleotide
DNA nearest-neighbor thermodynamics. Proceedings of the National Academy
of Sciences 95, 1460. doi:10.1073/pnas.95.4.1460.

SantaLucia, J., and Hicks, D. (2004). The thermodynamics of DNA structural
motifs. Annual Review of Biophysics and Biomolecular Structure 33, 415–440.
doi:10.1146/annurev.biophys.32.110601.141800.

Improved
SantaLucia, John, Allawi, H. T., and Seneviratne, P. A. (1996).
nearest-neighbor parameters for predicting DNA duplex stability. Biochemistry
35, 3555–3562. doi:10.1021/bi951907q.

Schildkraut, C., and Lifson, S. (1965). Dependence of the melting temperature of
DNA on salt concentration. Biopolymers 3, 195–208. doi:10.1002/bip.360030207.

Sugimoto, N., Nakano, S., Yoneyama, M., and Honda, K. (1996). Improved
thermodynamic parameters and helix initiation factor to predict stability of DNA
duplexes. Nucleic Acids Research 24, 4501–4505. doi:10.1093/nar/24.22.4501.

Tan, Z.-J., and Chen, S.-J. (2006). Nucleic acid helix stability: Effects of salt
concentration, cation valence and size, and chain length. Biophysical Journal 90,
1175–1190. doi:10.1529/biophysj.105.070904.

Tan, Z.-J., and Chen, S.-J. (2007). RNA helix stability in mixed Na(+)/Mg(2+)
solution. Biophysical Journal 92, 3615–3632. doi:10.1529/biophysj.106.100388.

Tanaka, F., Kameda, A., Yamamoto, M., and Ohuchi, A. (2004). Thermody-
namic parameters based on a nearest-neighbor model for DNA sequences with a
single-bulge loop. Biochemistry 43, 7143–7150. doi:10.1021/bi036188r.

Wahl, G. M., Barger, S. L., and Kimmel, A. R. (1987). Molecular hybridization
of immobilized nucleic acids: Theoretical concepts and practical considerations.

67

Computation of melting temperature of nucleic acid duplexes with rmelting

Methods in Enzymology 152, 399–407. doi:10.1016/0076-6879(87)52046-8.

Watkins, N. E., Kennelly, W. J., Tsay, M. J., Tuin, A., Swenson, L., Lee, H.-R.,
et al. (2011). Thermodynamic contributions of single internal rA·dA, rC·dC,
rG·dG and rU·dT mismatches in RNA/DNA duplexes. Nucleic Acids Research
39, 1894–1902. doi:10/cdm4jh.

Watkins, N. E., and SantaLucia, J. (2005). Nearest-neighbor thermodynamics
of deoxyinosine pairs in DNA duplexes. Nucleic Acids Research 33, 6258–6267.
doi:10.1093/nar/gki918.

Wetmur, J. G. (1991). DNA probes: Applications of the principles of nucleic
acid hybridization. Critical Reviews in Biochemistry and Molecular Biology 26,
227–259. doi:10.3109/10409239109114069.

Wright, D. J., Rice, J. L., Yanker, D. M., and Znosko, B. M. (2007). Nearest
neighbor parameters for inosine·uridine pairs in RNA duplexes. Biochemistry
46, 4625–4634. doi:10.1021/bi0616910.

Xia, T., SantaLucia, J., Burkard, M. E., Kierzek, R., Schroeder, S. J., Jiao, X., et
al. (1998). Thermodynamic parameters for an expanded nearest-neighbor model
for formation of RNA duplexes with Watson-Crick base pairs. Biochemistry 37,
14719–14735. doi:10.1021/bi9809425.

68

