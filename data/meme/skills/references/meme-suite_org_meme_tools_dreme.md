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

DREME looks for motifs that are enriched in your sequences relative
to a control set of sequences.

By default DREME creates the control
set by shuffling each of your sequences, conserving dinucleotide
frequencies ("Shuffled input sequences").

Alternatively, you may
may provide a set of control sequences ("User-provided sequences").

**IMPORTANT:** If you provide the control sequences,
they should have exactly the same length distribution as the
the primary sequences. (E.g., all sequences
in both sets could have the same length, or for each sequence in
the primary set there could be exactly *N* sequences with the
same length as it in in the control set.)
Failure to ensure this may cause DREME to fail to find motifs or
to report inaccurate *E*-values.

[ close ]

Select a file of [FASTA formatted](../doc/fasta-format.html)
nucleotide sequences or paste in actual [FASTA formatted](../doc/fasta-format.html) nucleotide sequences to search for small regular expression
motifs.

DREME works best with sequences which are less than 500 nucleotides
long so if you have very long sequences DREME might work better if you
split long sequences into shorter ones.
For ChIP-seq we recommend using sequences of length 100 centered on
the summit or center of the peak.
The more sequences that you can give DREME the
more subtle the motifs it can find.

See the [example DNA sequences](https://meme-suite.org/meme/doc/examples/example-datasets/Klf1.fna) which were used to create the [sample output](../doc/examples/dreme_example_output_files/dreme.html)
to get an idea of input that works well for DREME.

[ close ]

Input comparative sequences which have approximately the same length
distribution and background frequencies but which are unlikely to contain
the motifs that you are attempting to find.

Note that using comparative sequences that are much longer or shorter
than your input sequences has the potential to create incorrect
p-values.

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
receive and in the DREME output.

[ close ]

DREME stops looking for motifs when one of these limits is met. There
is an additional time limit which is set by the server operator.

*E*-value threshold
:   The expected number of false positives. This may be any positive
    number. DREME stops if a motif is found whose *E*-value exceeds
    this threshold.

Number of motifs
:   DREME stops if it has found this many motifs. By default DREME
    does not limit the number of motifs to be found.

[ close ]

Checking this box instructs DREME to **NOT** check the reverse
complement of the input sequences for motif sites when reading
sequences.

**Note:** When your sequences are RNA, you should select this option
to ensure that only the given strand is searched for motifs.

[ close ]

# Javascript is disabled! ☹

The MEME Suite web application requires the use of JavaScript but
Javascript doesn't seem to be available on your browser.

Please re-enable Javascript to use the MEME Suite.

![DREME Logo](../doc/images/dreme_icon.png)

# DREME

## Discriminative Regular Expression Motif Elicitation

Version 5.5.9

Data Submission Form

Perform motif discovery on DNA or RNA datasets for short regular expression motifs.

## Select the type of control sequences to use

Shuffled input sequences

User-provided sequences

## Select the sequence alphabet

#### Use sequences with a standard alphabet or specify a custom alphabet.

DNA, RNA or Protein

Custom

## Input the sequences

#### Enter sequences in which you want to find motifs

Type in sequences
Upload sequences

## Input the control sequences

#### DREME will find motifs that are enriched relative to these sequences.

Type in sequences
Upload sequences
Upload BED file

## Input job details

#### (Optional) Enter your email address.

#### (Optional) Enter a job description.

▶
▼
Advanced options
hidden modifications!
[Reset]

### How should the search be limited?

*E*-value threshold:

motif count:

### Can motif sites be on both strands?

[ ]
search given strand only

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