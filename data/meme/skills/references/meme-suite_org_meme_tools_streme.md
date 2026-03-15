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

STREME looks for motifs that are enriched in your sequences relative
to a control set of sequences.

By default STREME creates the control
set by shuffling each of your sequences, conserving k-mer
frequencies ("Shuffled input sequences"), where k=3 for
DNA and RNA sequences, and k=1 for protein or custom
alphabet sequences.

Alternatively, you may
may provide a set of control sequences ("User-provided sequences").

**IMPORTANT NOTE:** If you provide control sequences,
they should have the same length distribution as your
the primary sequences. For example, all sequences
in both sets could have the same length, or, for each sequence in
the primary set there could be exactly *N* sequences with the
same length as it in in the control set.
Failure to ensure this may cause STREME to report inaccurate
estimates of the statistical significance (*p*-value)
of the motifs it finds.

[ close ]

Select a file of [FASTA formatted](../doc/fasta-format.html)
biological sequences or paste in [FASTA formatted](../doc/fasta-format.html) biological sequences to search sequence motifs.

The more sequences that you can give STREME the
more subtle the motifs it can find.
For ChIP-seq we recommend using sequences of length 100bp centered on
the summit or center of the peak. For CLIP-seq we recommend using
the actual peak regions.

The STREME webserver limits the total
length of the sequences to 10,000,000 (DNA and RNA) and 1,000,000
(protein and custom alphabets).

See the [example DNA sequences](https://meme-suite.org/meme/doc/examples/example-datasets/Klf1.fna) that were used to create the [sample output](../doc/examples/streme_example_output_files/streme.html)
to get an idea of input that works well for STREME.

[ close ]

Select a file of [FASTA formatted](../doc/fasta-format.html)
biological sequences or paste in [FASTA formatted](../doc/fasta-format.html) biological sequences to use as controls in the
search for motifs.

Your control sequences should have approximately the same length
distribution and background frequencies as your primary sequences
the motifs that you are attempting to find.
The more control sequences that you can give STREME, the
more subtle the motifs it can find.

The STREME webserver limits the total
length of the control sequences to 10,000,000 (DNA and RNA) and 1,000,000
(protein and custom alphabets).

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

The job description will be included in the notification email you
receive and in the STREME output.

[ close ]

This is the width (number of characters in the sequence pattern) of a
single motif. STREME chooses the optimal width of each motif individually
using a heuristic function. You can choose limits
for the minimum and maximum motif widths that STREME will consider. The
width of each motif that STREME reports will lie within the limits you
choose.

[ close ]

The background model normalizes for biased distribution of
letters and groups of letters in your sequences.
A 0-order model adjusts for single letter biases, a 1-order model adjusts for
dimer biases (e.g., GC content in DNA sequences), etc.

By default STREME will determine the background Markov model from
the control sequences (or from the primary sequences if you do not provide
control sequences). The order of the background model depends
on the sequence alphabet, but you can also set it manually (see option "What Markov order...", below).
Alternately you may select "Upload background model" and input a file containing
a [background model](../doc/bfile-format.html).

The downloadable version of the MEME Suite contains a program named
"fasta-get-markov" that you can use to create background model files in
the correct format from FASTA sequence files.

[ close ]

Specify the order (*m*) for the background model and sequence shuffling.
By default, STREME uses *m*=2 for DNA and RNA sequences, and *m*=0 for
protein or custom alphabet sequences.
Check this box and set the value of *m* if you want to override
the default value of *m* that STREME uses.

If you upload a background model (see option above), STREME will only
use the *m*-order portion of that model.
If you do not upload a background model,
STREME will create an order-*m* model
from the control sequences that you provide, or from the shuffled primary sequences
if you don't provide control sequences.

If you do not specify a set of control sequences, STREME will
create one by shuffling each primary sequence while preserving
the frequencies of all words of length *k* that it contains,
where *k*=*m*+1.

[ close ]

If this option is checked, STREME will **NOT** trim the control sequences
even if their average length exceeds that of the primary sequences.
This will cause STREME to use the (less accurate) Binomial test rather
than the Fisher Exact test if the control sequences are longer (on average)
than the primary sequences.

[ close ]

STREME stops looking for motifs when one of the limits below is met. There
is an additional time limit which is set by the server operator.

*p*-value threshold
:   The probability of a motif being found that would discriminate
    the primary sequences from the control sequences at least as well,
    assuming that the letters in the primary sequences were randomly shuffled.
    STREME stops when 3 motifs have been found whose *p*-values exceed
    this threshold. If STREME is unable to estimate the *p*-values of motifs, it will
    stop when 5 motifs have been found.

Number of motifs
:   Check this box and set the (maximum) number of motifs
    you want STREME to find before it stops. STREME will ignore
    the *p*-value threshold if this box is checked.
    By default STREME does not limit the number of motifs to be found,
    but uses the *p*-value threshold as its stopping criterion.

[ close ]

When your sequences are in the DNA alphabet but you want
them to be treated as single-stranded RNA, check this box.

[ close ]

For the site positional distribution diagrams, align the sequences
on their left ends, on their centers, or on their right ends.
For visualizing motif distributions, center alignment is
ideal for ChIP-seq and similar data; right alignment
for sequences upstream of transcription start sites; left
alignment for many proteins or 3' UTR sequences.

[ close ]

When this option is selected, if the FASTA sequence header of an input
sequence contains genomic coordinates in UCSC or Galaxy format the discovered motif sites
will be output in genomic coordinates. If the sequence header does
not contain valid coordinates, the sites will be output with
the start of the sequences as position 1.

[ close ]

# Javascript is disabled! ☹

The MEME Suite web application requires the use of JavaScript but
Javascript doesn't seem to be available on your browser.

Please re-enable Javascript to use the MEME Suite.

![STREME Logo](../doc/images/streme_icon.png)

# STREME

## Sensitive, Thorough, Rapid, Enriched Motif Elicitation

Version 5.5.9

Data Submission Form

Perform discriminative motif discovery in sequence datasets (including in very **large** datasets).
The sequences may be in the DNA, RNA or protein alphabet, or in a custom alphabet.

## Select the type of control sequences to use

Shuffled input sequences

User-provided sequences

## Select the sequence alphabet

#### Use sequences with a standard alphabet or specify a custom alphabet.

DNA, RNA or Protein

Custom

## Input the sequences

#### Enter the sequences in which you want to find motifs.

Type in sequences
Upload sequences
Upload BED file

## Input the control sequences

#### STREME will find motifs that are enriched relative to these sequences.

Type in sequences
Upload sequences
Upload BED file

### Convert DNA sequences to RNA?

[ ]
Convert DNA to RNA

## Input job details

#### (Optional) Enter your email address.

#### (Optional) Enter a job description.

▶
▼
Advanced options
hidden modifications!
[Reset]

NEW OPTIONS

### How wide can motifs be?

  Minimum width:

Maximum width:

### How should the search be limited?

*p*-value threshold:

Number of motifs:

### What should be used as the background model?

Model of control sequences
Upload background model

### What Markov order should be used for shuffling sequences and background model creation?

[ ]
Order:

### Should STREME trim the control sequences if needed?

[ ]
Do NOT trim the control sequences.

### How should sequences be aligned for site positional diagrams?

  Align sequences on their:

**Left Ends**

**Centers**

**Right Ends**

### Should STREME parse genomic coordinates?

[x]
Parse genomic coordinates.![new](../doc/images/new_icon.png)

**Warning:**
Your maximum job quota has been reached! You will need to wait until
one of your jobs completes or 1 second has
elapsed before submitting another job.

This server has the job quota set to 10 unfinished jobs
every 1 hour.

Note: if the combined form inputs exceed 80MB the job will be rejected.

Version 5.5.9

Powered by [Opal](http://sourceforge.net/projects/opaltoolkit/)

Please send comments and questions to:
meme-suite@uw.edu

---

* [Home](../index.html)
* [Documentation](../doc/overview.html)
* [Downloads](../doc/download.html)
* [Authors](../doc/authors.html)
* [Citing](../doc/cite.html)