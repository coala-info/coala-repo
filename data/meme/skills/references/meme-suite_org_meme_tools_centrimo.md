**Centrally**
:   * Choose this mode to look for motifs that are enriched
      in the centers of your sequences relative to their flanks.* This mode is appropriate for ChIP-seq and other types of data where you expect
        the distribution of motifs to be symmetrical around the sequence centers.

    **Anywhere**
    :   * Choose this mode to look for motifs that are enriched in
          some confined (local) region along the sequences.* This mode is appropriate when your sequences are all aligned on a genomic
            landmark such as transcription start sites or splice junctions and you expect that motifs may be enriched
            at specifc locations relative to the genomic landmark.* This mode can also detect centrally enriched motifs, but will have lower statistical power due
              to more multiple tests being performed.

    [ close ]

**Absolute (single dataset)**
:   * Choose this mode if you have just one set of sequences to search for
      enriched motifs.* In this mode, CentriMo uses the binomial test
        to determine if the number of sequences that have their best
        matches to a motif in a given region is greater than expected given
        that matches should be uniformly distributed along the sequence.

**Absolute and Differential (two datasets)**
:   * Choose this mode if you would also like to find motifs that are more
      locally enriched in the first set of sequences compared to the second set.* When you choose this mode, you will be able to view the motifs sorted by either
        absolute enrichment (E-value) or by differential enrichment (Fisher E-value) via the `Sort`
        menu on CentriMo's report.* CentriMo first determines the regions of localized enrichment in the
          primary set of sequences for a given motif as in **Absolute** mode,
          and then it computes the **differential** enrichment of those regions.* For differential enrichment, CentriMo uses Fisher's exact test
            to determine if the number of best matches to the motif in the region
            in the primary sequences is surpringly higher than the number of best matches
            in the same region of the control sequences.

[ close ]

Use the menu below to choose how you wish to input your primary sequences.

**Note 1:** All sequences should be the **same length**.
Suggested lengths are 500-bp for ChIP-seq, 100-bp for CLIP-seq and 1000bp for promoter regions.

**Note 2:** You must convert your RNA sequences to the DNA alphabet (U to T)
for use with CentriMo.

See the [example DNA sequences](https://meme-suite.org/meme/doc/examples/example-datasets/Klf1.fna) which were used to create the [sample output](../doc/examples/centrimo_example_output_files/centrimo.html)
to get an idea of input that works well for CentriMo.

[ close ]

Use the menu below to choose how you wish to input your control sequences.

**Note 1:** All sequences should be the same length as the primary sequences.

**Note 2:** You must convert your RNA sequences to the DNA alphabet (U to T)
for use with CentriMo.

See the [example DNA sequences](https://meme-suite.org/meme/doc/examples/example-datasets/Klf1.fna)
to get an idea of input that works well for CentriMo.

[ close ]

Using the menu below, select the way you want to input motifs that
will be tested for enrichment in your input sequences.
Use the first menu below to choose how you want to input the motifs, and
the second menu to choose the particular motif database you require.

[ close ]

The background model normalizes for biased distribution of
individual letters in your sequences.
By default CentriMo will create a 0-order Markov sequence model from
the letter frequencies in the primary input sequences.
You may also choose to use a uniform background model or to use
the background model specified by the motifs.

Alternately you may select "Upload background" and input a file containing
a [background model](../doc/bfile-format.html).

The downloadable version of the MEME Suite contains a script named
"fasta-get-markov" that you can use to create sequence model files in
the correct format from a FASTA sequence file.

[ close ]

**match either strand**
:   * Choose this mode if your sequences are DNA and you want CentriMo
      to consider motif matches on either strand to be equivalent.* This mode is usually appropriate for ChIP-seq and similar data.

**match given strand only**
:   * Choose this mode if your sequences are RNA or if you want to
      CentriMo to ignore motif matches on the reverse-complement strand of DNA sequences.* This mode is usually appropriate with CLIP-seq and similar data.

**separately**
:   * Choose this mode if you want to treat matches on the reverse-complement
      strand separately from those on the given strand.* CentriMo will produce separate site distribution plots for each motif
        and its reverse-complement.* This mode is is useful when your sequences have strand information,
          such as when they are promoter regions.

**reflected**
:   * Choose this mode if you think the positions of motif matches on the reverse-complement strand should
      be reflected around the sequence centers.* This mode is useful with ChIP-seq data for detecting the presence
        of (non-palindromic) motifs for co-factors--transcription factors other than the one that was ChIP-ed.

[ close ]

**Score ≥**
:   * Increase the match score threshold if want CentriMo to ignore
      weaker matches to motifs, or decrease it to include them in the analysis.* Sequences with no match to a given motif above the match score threshold are ignored
        in computating that motif's enrichment.

**Optimize Score**
:   * Select option this if you want CentriMo to find the optimal match score threshold.* Independently for each motif, CentriMo will consider all thresholds
        above **0** and will choose the one
        that maximizes the statistical significance of the motif's enrichment.* This option increases running time and can reduce statistical power
          due to increased multiple tests.

[ close ]

Check this option and specify the maximum width for enriched
regions if you have prior knowledge of what is a reasonable limit.

By default CentriMo considers regions up to one minus the maximum
number of places that a given motif will fit in a sequence.

Reducing the maximum width increases the statistical power of CentriMo.
and can help cut-down the multiple testing correction.

[ close ]

Reduce the *E*-value threshold if you want CentriMo to report
only more significant motif enrichments; increase it to include less significant motif enrichments in the report.

Setting the *E*-value threshold to the number of motifs in the input database
will cause CentriMo to report a result for every motif.

Note that if there are multiple, overlapping enriched regions, then CentriMo
reports the most significant overlapping region.

[ close ]

Disable this option if you don't want CentriMo to store sequence identifiers
in its output file.

Disabling this option will make the CentriMo output file smaller, but the
CentriMo output will not be able to interactively show you the sizes of the intersection and union
sets of sequences matching the motifs you select.

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
| Leucine o