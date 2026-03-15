Choose whether or not to provide control sequences to AME.

If you choose "Shuffled input sequences", AME will
create control sequences for you by shuffling the
letters in each of your input sequences, preserving 2-mers.

If you provide control sequences, they should have a similar
length distribution to that of your primary sequences
or motif enrichment *p*-values will be inaccurate.

If you choose "NONE", then AME will assume that your sequences
are either sorted according to some secondary criterion, or that
they each contain a number (a 'FASTA score') in their FASTA
header line. AME will sort your sequences in **increasing**
order of FASTA score and compute the enrichment of each motif in
sequences at the beginning of the sorted list.
The FASTA header line should have the
format:

>seq\_name fasta\_score other\_text
.

[ close ]

Use the menu below to choose how you wish to input your primary sequences.

**Note 1:** The sequences may have differing lengths.

[ close ]

Use the menu below to choose how you wish to input your control sequences.

**Note 1:** The sequences may have differing lengths.

[ close ]

Using the menu below, select the way you want to input motifs that
will be tested for enrichment in your input sequences.
Use the first menu below to choose how you want to input the motifs, and
the second menu to choose the particular motif database you require.

[ close ]

Select the statistical test for testing motif enrichment.

* Fisher's exact test - one-tailed Fisher's exact test (1)
* Ranksum test - one-tailed Wilcoxon rank-sum test, also known as the Mann-Whitney U test (1)
* Pearson CC - significance of the correlation of sequence PWM scores and FASTA scores (3)
* Spearman CC - significance of the correlation of sequence PWM score ranks and FASTA score ranks
* 3dmhg - 3-dimensional multi-hypergeometric test (2)
* 4dmhg - 4-dimensional multi-hypergeometric test (2)

--------------

(1) These tests allow control sequences.

(2) These tests require the "totalhits" sequence scoring method.

(3) This test requires [FASTA scores](../doc/ame.html#fasta_scores) in the sequence header lines.

[ close ]

Choose how a single sequence is scored for matches to a single motif.
The 'PWM score' assigned to a sequence is either:

* Average odds score - the average PWM motif score of the sequence
  (note: 'motif scores' are odds scores, not log-odds scores as in some other MEME Suite tools)* Maximum odds score - the maximum motif score of the sequence* Total odds score - the sum of the motif scores of the sequence* Total hits - the total number of positions in the sequence
        whose motif score is greater than the "hit threshold" for the motif

[ close ]

The "hit threshold" for a motif is defined as this **fraction** times
the maximum possible log-odds score for the motif.
A position is considered a "hit" if the log-odds score is greater than or equal to the "hit threshold".

[ close ]

Threshold for reporting enriched motifs. Only motifs
with enrichment *E*-values no greater than this number
will be reported in AME's output. (The *E*-value is
the motif *p*-value multiplied by the the number of motifs in the input.)

Reduce the threshold value if you want AME to report fewer,
more significantly enriched motifs.
Set the threshold value to the total number of motifs in your input
if you want AME to report the enrichment of all input motifs.

[ close ]

Select the size of the k-mer to preserve the frequencies of when
shuffling the letters of sequences to create the background sequences.
Selecting a value of 1 may work better than the default (kmer=2) in some
cases. Be wary of setting the k-mer to less than 2
if the primary sequences contain long runs of a single
letter, as is the case with repeat-masked sequences.

[ close ]

The background model normalizes for biased distribution of single letters
in the sequences. By default AME will create a 0-order Markov sequence
model from the letter frequencies in the primary sequences.
You may also choose to use a uniform background model or to use
the background model specified by the motifs.

Alternately you may select "Upload background" and input a file containing
a [background model](../doc/bfile-format.html).

The downloadable version of the MEME Suite contains a program named
"fasta-get-markov" that you can use to create background model files in
the correct format from FASTA sequence files.

[ close ]

If your sequences are not in a standard alphabet ([DNA](../doc/alphabets.html#dna),
[RNA](../doc/alphabets.html#rna) or
[protein](../doc/alphabets.html#protein)), you must input a
[custom alphabet file](../doc/alphabet-format.html).

[ close ]

**Click on the menu at the left to see which of the following motif input methods are available.**

**Type in motifs**
:   When this option is available you may directly input multiple motifs
    by typing them (or using "cut-and-paste").
    First select the desired motif alphabet using the menu
    immediately to the left. If you select the "Custom" option then
    you must provide an [alphabet definition](../doc/alphabet-format.html)
    in the file input that immediately follows. Warning: custom alphabets are *case-sensitive*.
    You may optionally give each motif an identifier and alternate name by
    inputting a line like >Identifer Alternate-Name preceeding the motif.
    You can then enter each motif as either matrices, sequence sites or fixed-length regular expressions.
    You can enter multiple motifs by typing an empty line after each motif.
    Individual motifs will be shown in square brackets, and errors in your
    motifs will be highlighted in red while warnings will be highlighted in
    yellow.
    Mouse-over individual motifs to display their sequence logos.
    View the examples for more information on what is possible.

**Upload motifs**
:   When this option is available you may upload a file containing
    motifs in MEME motif format.  This includes the outputs generated by MEME
    and DREME, as well as files you create using the
    [motif conversion scripts](../doc/motif_conversion.html)
    or manually following the
    [MEME motif format](../doc/meme-format.html) guidelines.

**Databases (select category)**
:   When this option is available you can select the category of
    motif database desired from the list below it. Then select the motif
    database from the displayed list.
    Consult the
    [motif database documentation](../db/motifs)
    for descriptions of all the motif databases present on this MEME Suite server.

    **Submitted motifs**
    :   This option is only available when you have invoked the current
        program by clicking on a button in the output report of a different MEME Suite program.
        By selecting this option you will input the motifs sent by that program.

[ close ]

<< back to overview

#### Typed Motifs - Matrices

You may input both probability and count matrices of either orientation
and the rules described below will be used to convert the matrix into a
MEME formatted motif.

#### Alphabet Order

The counts/probabilities are expected to be ordered based on the
alphabetical ordering of their codes.  So DNA is ordered ACGT and
protein is ordered ACDEFGHIKLMNPQRSTVWY. For custom alphabets the ordering
goes uppercase letters (A-Z), lowercase letters (a-z), numbers (0-9) and
finally the symbols '\*', '-' and '.'.

#### Matrix Orientation

Matrix motifs may be input with either one position per row (preferred)
which is called row orientation, or one position per column which is
called column orientation.  The orientation is determined by picking
which dimension (row or column) is equal to the alphabet size.  If both
dimensions are equal to the alphabet size then row orientation is assumed.
If neither dimension is equal to the alphabet size then the closest
that is still smaller than the alphabet size is picked, however if both
are equally smaller then column orientation is assumed.  Finally if none of
the above rules work to determine the orientation then row orientation is
assumed.

#### Site counts

Once the orientation is determined, the sum of the numbers that make up
the first position is calculated and rounded to the nearest integer.
If that value is larger than 1 then the matrix is assumed to be a count
matrix and that value is used as the site count, otherwise the matrix is
assumed to be a probability matrix and a site count of 20 is used.

#### Converting to a normalized probability matrix

Once the orientation is determined then each number in the matrix is
converted to a normalized probability by dividing by the sum of all the
numbers for that motif position.  If any numbers are missing they are
assumed to have the value zero.  As a special case if all numbers in a
motif position have the value zero then they are given the uniform
probability of 1 / alphabet size.

#### Yellow highlighting and red annotations

Red asterisks (\*) indicate where the
parser thinks values are missing.  A yellow highlighted row or column
with a red number at the end indicates that the counts for that position
don't sum to the same count as the first position. The red number shows
the difference. If the red number is negative then that position sums to
less then the first position, if it is positive then it sums to more than
the first position.

[ close ]

<< back to overview

#### Typed Motifs - Sequence Sites or Regular Expressions

You may input one or more sites of the motif including using ambiguity
codes or bracket expressions to represent multiple possibilities for a
single motif position.

#### Ambiguity Codes

The DNA and protein alphabets include additional codes that represent
multiple possible bases. For example the DNA alphabet includes W (for weak)
which represents that the given position could be either a A (for adenosine)
or a T (for thymidine). Note that MEME Suite regular expressions must be **fixed-length**,
so they may not include the Kleene star character `*`.

#### Bracket Expressions

Bracket expressions also group together multiple codes so they share
a single position.  Their syntax is a opening square bracket '[' followed
by one or more codes and a closing square bracket ']'. For example with a
DNA motif the bracket expression [AT] means that both A and T are
acceptable and is equivalent to the ambiguity code W.  Any repeats of a
base in a bracket expression are ignored so for example a DNA bracket
expression [AAT] has the same effect as [AT] or [AW] or W.

#### Multiple sites

When only one site is provided the site count is set to 20, however
you can precisely control the motif by providing multiple sites.  Each of
these sites can still contain ambiguity codes and bracket expressions
but a single count will be divided among the selected bases for each
position.  When multiple sites are provided the site count will be set
to the number of sites provided.

[ close ]

<< back to sequence site motifs

#### DNA Alphabet

DNA motifs support the standard 4 codes for the bases: adenosine (A),
cytidine (C), guanosine (G) and thymidine (T) as well as supporting
the following ambiguity codes.

| Description | Code | Bases |
| --- | --- | --- |
| **U**racil | U | T |
| **W**eak | W | A, T |
| **S**trong | S | C, G |
| A**m**ino | M | A, C |
| **K**eto | K | G, T |
| Pu**r**ine | R | A, G |
| P**y**rimidine | Y | C, T |
| Not A | B | C, G, T |
| Not C | D | A, G, T |
| Not G | H | A, C, T |
| Not T | V | A, C, G |
| Any | N | A, C, G, T |

[ close ]

<< back to sequence site motifs

#### Protein Alphabet

Protein motifs support the standard 20 codes for the amino acids:
Alanine (A), Arginine (R), Asparagine (N), Aspartic acid (D), Cysteine (C),
Glutamic acid (E), Glutamine (Q), Glycine (G), Histidine (H), Isoleucine (I),
Leucine (L), Lysine (K), Methionine (M), Phenylalanine (F), Proline (P),
Serine (S), Threonine (T), Tryptophan (W), Tyrosine (Y) and Valine (V)
as well as supporting the following ambiguity codes.

| Description | Code | Bases |
| --- | --- | --- |
| Asparagine or aspartic acid | B | N, D |
| Glutamine or glutamic acid | Z | E, Q |
| Leucine or Isoleucine | J | I, L |
| Unspecified or unknown amino acid | X | A, C, D, E, F, G, H, I, K, L, M, N, P, Q, R, S, T, V, W, Y |

Note that the two amino acids Selenocysteine (U) and Pyrrolysine (O)
are not supported by the MEME Suite.

[ close ]

<< back to overview

#### Typed Motifs - Examples

Single site motif using ambiguity codes N and R or bracket expressions.
These give an approximation of the other motifs below.

NTRGGTCAN or
[ACGT]T[AG]GGTCA[ACGT]

Multiple site motif. This lists all 28 sites and gives the same result as the count matrix below.

CTAGGTCAT
ATAGGTCAC
GTAGGTCAC
GTAGGGCAC
GTAGGGCAC
GTGGGTCAC
GTAGGTCAC
GTAGGTCAC
TTGGGTCAC
CTAGGTCAT
CTAGGTCAT
CTAGGTCAT
CTGGGTCAC
ATAGGTCAG
GTAGGTCAA
GTAGGTGAG
ATGGGTCAC
GTAGGTCAG
GTGGGTGAA
GTAGGGCAC
CTGGGTCAC
TTGGGTCAC
CTAGGTCAC
GAAGGTGAC
GTAGGTAAA
GTAGGTCAA
CAGCAGCTG
TAGGTCACA

Count matrix motif showing row and column orientations.

3 8 14 3
3 0 0 25
19 0 9 0
0 1 27 0
1 0 26 1
0 1 4 23
2 23 3 0
26 1 0 1
5 15 4 4
or
 3 3 19 0 1 0 2 26 5
8 0 0 1 0 1 23 1 15
14 0 9 27 26 4 3 0 4
3 25 0 0 1 23 0 1 4

Note that all of these can be used with an identifier and alternate name like these 3 count matrix motifs from Jaspar.

>MA0001.1 SEP4
0 3 79 40 66 48 65 11 65 0
94 75 4 3 1 2 5 2 3 3
1 0 3 4 1 0 5 3 28 88
2 19 11 50 29 47 22 81 1 6
>MA0002.1 RUNX1
10 12 4 1 2 2 0 0 0 8 13
2 2 7 1 0 8 0 0 1 2 2
3 1 1 0 23 0 26 26 0 0 4
11 11 14 24 1 16 0 0 25 16 7
>MA0003.1 TFAP2A
0 0 0 22 19 55 53 19 9
0 185 185 71 57 44 30 16 78
185 0 0 46 61 67 91 137 79
0 0 0 46 48 19 11 13 19

[ close ]

When enabled this field supports selecting motifs from the file with a
space separated list of motif identifiers and/or their positions in the
file.

Any numbers in the range 1 to 999 are assumed to refer to the position
of the selected motif in the file, so the entry "3" always refers to the
third motif.  Any other entry is assumed to be a motif identifier.

Motif identifiers can not start with a dash and can only contain
alphanumeric characters as well as colon ':', underscore '\_', dot '.'
and dash '-'.

[ close ]

Select the desired motif database.

Consult the [motif database documentation](../db/motifs)
for descriptions of all the DNA, RNA and protein motif databases present on this
MEME Suite server.

[ close ]

This option can help change the alphabet of motifs from
a base alphabet to a derived alphabet.

This might be useful if you need to compare an extended DNA motif with
a library of DNA motifs, or if you wish to compare RNA motifs to DNA motifs.
Note that this option will also let you do nonsensical things like compare
Protein motifs to DNA motifs so use it with care.

The derived alphabet must have all the core symbols of the alphabet
that it is derived from. For example if the alphabet is derived from DNA
it must have ACGT as core symbols. Expanding the alphabet 