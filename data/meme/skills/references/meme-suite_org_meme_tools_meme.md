If your sequences are not in a standard alphabet ([DNA](../doc/alphabets.html#dna),
[RNA](../doc/alphabets.html#rna) or
[protein](../doc/alphabets.html#protein)), you must input a
[custom alphabet file](../doc/alphabet-format.html).

[ close ]

**Click on the menu at the left to see which of the following sequence input methods are available.**

**Type in sequences**
:   When this option is available you may directly input multiple
    sequences by typing them. Sequences must be input in
    [FASTA format](../doc/fasta-format.html).

**Upload sequences**
:   When this option is available you may upload a file containing
    sequences in [FASTA format](../doc/fasta-format.html).

**Upload BED file** ![new](../doc/images/new_icon.png)
:   When this option is available you may upload a file containing
    sequence coordinates in [BED format](../doc/bed-format.html).

**Databases (select category)**
:   When this option is available you may first select a category of
    sequence database from the list below it. Two additional menus will then appear
    where you can select the particular database and version desired, respectively.
    The full list of available sequence databases and their descriptions
    can be viewed [HERE](../db/sequences).

**Submitted sequences**
:   This option is only available when you have invoked the current
    program by clicking on a button in the output report of a different MEME Suite program.
    By selecting this option you will input the sequences sent by that program.

[ close ]

Specify a file to upload containing
sequence coordinates in [BED format](../doc/bed-format.html).
The file must be based on the exact genome version you specified in the
menus above.

[ close ]

Select an available sequence database from this menu.

[ close ]

Select an available version of the sequence database from this menu.

[ close ]

Select an available tissue/cell-specificity from this menu.

[ close ]

Selecting this option will filter the sequence menu to only contain
databases that have additional information that is specific to a tissue
or cell line.

This option causes MEME Suite to use tissue/cell-specific information
(typically from DNase I or histone modification ChIP-seq data) encoded
as a [position specific prior](../doc/psp-format.html) that
has been created by the MEME Suite [create-priors](../doc/create-priors.html)
utility. You can see a description of the sequence databases
for which we provide tissue/cell-specific priors
[here](../doc/FixMe.html).

**Note that you cannot upload or type in your own sequences
when tissue/cell-specific scanning is selected.**

[ close ]

Enter the email address where you want the job notification email to
be sent. Please check that this is a valid email address!

The notification email will include a link to your job results.

**Note:** You can also access your jobs via the **Recent Jobs**
menu on the left of all MEME Suite input pages. That menu only
keeps track of jobs submitted during the current session of your internet browser.

**Note:** Most MEME Suite servers only store results for a couple of days.
So be sure to download any results you wish to keep.

[ close ]

Enter text naming or describing this analysis. The job description will be included in the notification email you
receive and in the job output.

[ close ]

Classic mode
:   You provide **one** set of sequences and MEME discovers motifs enriched
    in this set. Enrichment is measured relative to a (higher order) random model based on
    frequencies of the letters in your sequences, or relative to the frequencies
    given in a "Custom background model" that you may provide (see Advanced options).

Discriminative mode
:   You provide **two** sets of sequences and MEME discovers motifs that
    are enriched in the first (primary) set relative to the second (control) set.
    In Discriminative mode, we first calculate a
    position-specific prior
    from the two sets of sequences.
    MEME then searches the first set of sequences for motifs using the
    position-specific prior to inform the search. This approach is based on the
    simple discriminative prior "D" described in Section 3.5 of
    [Narlikar et al](http://www.springerlink.com/content/av526j7u275n1508/).
    We modify their approach to search for the "best" initial motif width, and
    to handle protein sequences using
    spaced triples.

    Refer to the [psp-gen](../doc/psp-gen.html#detail) documentation
    and to [our paper](http://www.biomedcentral.com/1471-2105/11/179)
    for more details.

Differential Enrichment mode
:   You provide **two** sets of sequences and MEME discovers motifs that
    are enriched in the first (primary) set relative to the second (control) set.
    In Differential Enrichment mode, MEME optimizes an objective function based on the
    hypergeometric distribution to determine the relative enrichment of sites in the
    primary sequences compared to the control sequences.

[ close ]

<< back to discovery mode description

Position-specific priors (PSPs) assign a probability that a motif
starts at each possible location in your sequence data. MEME uses PSPs to
guide its search, biasing the search towards sites that have higher values
in the PSP. MEME creates a PSP when you use it in "Discriminative mode",
up-weighting words in the primary dataset that occur frequently there but
are infrequent in the negative dataset.

[ close ]

<< back to modes description

Spaced triples are sub-sequences in which only the first and last
letter (residue or amino acid for protein) and one interior letter are
used in matches. For example, the subsequence MTFEKI contains the
following triples:

```
          MT...I
          M.F..I
          M..E.I
          M...KI
```

where "." matches anything. We use spaced triples for protein because the
probability of exact matches is much lower than for DNA due to the much
larger amino acid alphabet.

To score a word using spaced triples, we count how often each
triple contained in the word occurs in the primary and control sequence
sets, and use the maximum over all triples as the word count in the
formula for scoring words described by
[Narlikar et al](http://www.springerlink.com/content/av526j7u275n1508/).

[ close ]

Please enter sequences that you believe share one or more motifs.
When running MEME in "Discriminative" or Differential Enrichment" mode, this set of sequences
is referred to as the "primary sequence set".

There may be at most **500,000 (primary) sequences**
in [FASTA format](../doc/fasta-format.html). There is also
a limit of 80,000,000 bytes for the entire contents of the input form.

See the [example DNA sequences](https://meme-suite.org/meme/doc/examples/example-datasets/crp0.fna) which were used to create the [sample output](../doc/examples/meme_example_output_files/meme.html).

[ close ]

Please enter sequences that you believe contain patterns you wish to
avoid making motifs from. This set of sequences is referred to as the "control sequence set.

The control sequence set should contain sequences that are in some sense a
contrast to likely sites for motifs (e.g. sequences rejected as unlikely
to contain a transcription factor binding site), but otherwise similar to
the primary sequence set.

There may be at most **500,000 control sequences**
in [FASTA format](../doc/fasta-format.html). There is also
a limit of 80,000,000 bytes for the entire contents of the input form.

[ close ]

You can use a background model with MEME in order to normalize
for biased distribution of letters and groups of letters in your sequences.
A 0-order model adjusts for single letter biases, a 1-order model adjusts for
dimer biases (e.g., GC content in DNA sequences), etc.

By default MEME will use a the letter frequencies in the primary sequence
set to create a 0-order background model.
Alternatively, you may select 'Upload background model' and you
can then specify here a file containing a [background model](../doc/bfile-format.html) in a simple format.

The downloadable version of the MEME Suite also contains a program named
[fasta-get-markov](../doc/fasta-get-markov.html) that you can
use to create background model files in the correct format from FASTA
sequence files.

[ close ]

This is where you tell MEME how you believe occurrences of the motifs
are distributed among the sequences. Selecting the correct type of
distribution improves the sensitivity and quality of the motif search.

Zero or One Occurrence per Sequence (zoops)
:   MEME assumes that each sequence may contain **at most** one
    occurrence of each motif. This option is useful when you suspect that
    some motifs may be missing from some of the sequences. In that case, the
    motifs found will be more accurate than using the One Occurrence per
    Sequence option. This option takes more computer time than the One
    Occurrence Per Sequence option (about twice as much) and is slightly less
    sensitive to weak motifs present in all of the sequences.

One Occurrence Per Sequence (oops)
:   MEME assumes that each sequence in the dataset contains
    **exactly** one occurrence of each motif. This option is the fastest
    and most sensitive but the motifs returned by MEME will be "blurry" (less specific)
    if they do not occur in every input sequence.

Any Number of Repetitions (anr)
:   MEME assumes each sequence may contain **any number** of
    non-overlapping occurrences of each motif. This option is useful when
    you suspect that motifs repeat multiple times within a single sequence.
    In that case, the motifs found will be much more accurate than using one
    of the other options. This option can also be used to discover repeats
    within a single sequence. This option takes much more computer time than
    the One Occurrence Per Sequence option (about ten times as much) and is
    somewhat less sensitive to weak motifs that do not repeat within a
    single sequence than the other two options.

[ close ]

MEME will keep searching until it finds this many motifs or until it
exceeds one of its other thresholds (e.g., maximum run time). Note that
unlike DREME, MEME does not use an *E*-value threshold, so you should always
check the *E*-value of any motifs discovered by MEME.

[ close ]

This is the width (number of characters in the sequence pattern) of a
single motif. MEME chooses the optimal width of each motif individually
using a heuristic function. You can choose limits
for the minimum and maximum motif widths that MEME will consider. The
width of each motif that MEME reports will lie within the limits you
choose.

[ close ]

This is the total number of sites in the primary sequence set where a single
motif occurs. You can choose limits for the minimum and maximum
number of occurrences that MEME will consider. If you have prior knowledge
about the number of occurrences that motifs have in your primary sequence set,
limiting MEME's search in this way can can increase the likelihood of
MEME finding true motifs.

MEME chooses the number of occurrences to report for each motif by
optimizing a heuristic function, restricting the number of
occurrences to the range you give here.

If you do not select one of these fields, MEME uses the following defaults
for the range of the number of motif sites, where "n" is the number of sequences in
the primary sequence set:

| Distribution | Minimum | Maximum |
| --- | --- | --- |
| Zero or One Occurrence per Sequence | sqrt(n) | n |
| One Occurrence per Sequence | n | n |
| Any Number of Repetitions | sqrt(n) | min(5\*n, 600) |

[ close ]

Checking this box instructs MEME to **NOT** check the reverse
complement of the input sequences for motif sites when analyzing
DNA or RNA sequences.

**Note:** When your sequences are RNA, you should select this option
to ensure that only the given strand is searched for motifs.

[ close ]

Checking this box causes MEME to search only for DNA palindromes.

This causes MEME to average the letter frequencies in corresponding motif
columns together. For instance, if the width of the motif is 10, columns
1 and 10, 2 and 9, 3 and 8, etc., are averaged together. The averaging
combines the frequency of A in one column with T in the other, and the
frequency of C in one column with G in the other. If this box is not
checked, the columns are not averaged together.

[ close ]

Checking this box causes MEME to shuffle each of the primary sequences
individually. The sequences will still be the same length and have
the same character frequencies but any existing patterns will be obliterated.

Using this option repeatedly you can get an idea of the *E*-values of motifs
discovered in "random" sequence datasets similar to your primary dataset.
This can help you determine a reasonable *E*-value cutoff
for motifs discovered in your unshuffled primary sequence dataset.

[ close ]

# Javascript is disabled! ☹

The MEME Suite web application requires the use of JavaScript but
Javascript doesn't seem to be available on your browser.

Please re-enable Javascript to use the MEME Suite.

![MEME Logo](../doc/images/meme_icon.png)

# MEME

## Multiple Em for Motif Elicitation

Version 5.5.9

Data Submission Form

Perform motif discovery on DNA, RNA, protein or custom alphabet datasets.

## Select the motif discovery mode

Classic mode

Discriminative mode

Differential Enrichment mode

## Select the sequence alphabet

#### Use sequences with a standard alphabet or specify a custom alphabet.

DNA, RNA or Protein

Custom

## Input the primary sequences

#### Enter sequences in which you want to find motifs.

Type in sequences
Upload sequences
Upload BED file

## Input the control sequences

#### MEME will find motifs that are enriched relative to these sequences.

Type in sequences
Upload sequences
Upload BED file

## Select the site distribution

#### How do you expect motif sites to be distributed in sequences?

Zero or One Occurrence Per Sequence (zoops)
One Occurrence Per Sequence (oops)
Any Number of Repetitions (anr)

## Select the number of motifs

#### How many motifs should MEME find?

## Input job details

#### (Optional) Enter your email address.

#### (Optional) Enter a job description.

▶
▼
Advanced options
hidden modifications!
[Reset]

### What should be used as the background model?

0-order model of sequences
1st order model of sequences
2nd order model of sequences
3rd order model of sequences
4th order model of sequences
Upload background model

### How wide can motifs be?

 Minimum width:

Maximum width:

### How many sites must each motif have?

[ ]
Minimum sites:

[ ]
Maximum sites:

### Can motif sites be on both strands? (DNA/RNA only)

[ ]
Search given strand only.

### Should MEME restrict the search to palindromes? (DNA only)

[ ]
Look for palindromes only.

### Should MEME shuffle the sequences?

[ ]
Shuffle the sequences.

**Warning:**
Your maximum job quota has been reached! You will need to wait until
one of you