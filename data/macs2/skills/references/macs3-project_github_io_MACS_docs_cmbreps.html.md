[MACS3](../index.html)

* [INSTALL Guide For MACS3](INSTALL.html)
* [Subcommands](subcommands_index.html)
  + [callpeak](callpeak.html)
  + [callvar](callvar.html)
  + [hmmratac](hmmratac.html)
  + [bdgbroadcall](bdgbroadcall.html)
  + [bdgcmp](bdgcmp.html)
  + [bdgdiff](bdgdiff.html)
  + [bdgopt](bdgopt.html)
  + [bdgpeakcall](bdgpeakcall.html)
  + cmbreps
    - [Overview](#overview)
    - [Detailed Description](#detailed-description)
    - [Command Line Options](#command-line-options)
    - [Example Usage](#example-usage)
  + [filterdup](filterdup.html)
  + [pileup](pileup.html)
  + [predictd](predictd.html)
  + [randsample](randsample.html)
  + [refinepeak](refinepeak.html)
* [File Formats](fileformats_index.html)
* [Tutorial](tutorial.html)
* [Common Q & A](qa.html)
* [Contributor Covenant Code of Conduct](../CODE_OF_CONDUCT.html)
* [Contributing to MACS project](../CONTRIBUTING.html)
* [MACS3 API reference](api/index.html)

[MACS3](../index.html)

* [Subcommands](subcommands_index.html)
* cmbreps
* [View page source](../_sources/docs/cmbreps.md.txt)

---

# cmbreps[](#cmbreps "Link to this heading")

## Overview[](#overview "Link to this heading")

The `cmbreps` command is part of the MACS3 suite of tools and is used
to combine bedGraph files from replicates. It is particularly useful
in ChIP-Seq analysis where multiple replicates of the same experiment
are performed.

## Detailed Description[](#detailed-description "Link to this heading")

The `cmbreps` command takes a list of input bedGraph files
(replicates) and produces an output file with combined scores. Note:
All regions on the same chromosome in the bedGraph file should be
continuous so bedGraph files from MACS3 are recommended.

The `cmbreps` command provides different way to combine replicates,
compared with the `callpeak` command where all replicates will be
simply pooled. A possible usage is that: for each replicate, we can
first follow the instructions in the [Advanced Step-by-step Peak
Calling](Advanced_Step-by-step_Peak_Calling.html) to generate the
p-value scores through `bdgcmp -m ppois`, use `cmbreps -m fisher` to
use Fisher’s combined probability test to combine all the p-value
score tracks and generate a single BedGraph, then call peaks using
`bdgpeakcall`.

## Command Line Options[](#command-line-options "Link to this heading")

Here is a brief overview of command line options:

* `-i IFILE1 IFILE2 [IFILE3 ...]`: MACS score in bedGraph for each
  replicate. Require at least 2 files. REQUIRED
* `-m` or `--method`: Method to use while combining scores from
  replicates.

  + `fisher`: Fisher’s combined probability test. It requires scores
    in ppois form (-log10 pvalues) from `bdgcmp`. Other types of
    scores for this method may cause cmbreps unexpected errors.
  + `max`: Take the maximum value from replicates for each genomic
    position.
  + `mean`: Take the average value. Note, except for Fisher’s method,
    max or mean will take scores AS IS which means they won’t convert
    scores from log scale to linear scale or vice versa.
* `--outdir`: If specified, all output files will be written to that
  directory. Default: the current working directory
* `-o` or `--ofile`: Output BEDGraph filename for combined scores.
* `--verbose`: Set the verbose level of runtime messages. 0: only show
  critical messages, 1: show additional warning messages, 2: show
  process information, 3: show debug messages. DEFAULT: 2

## Example Usage[](#example-usage "Link to this heading")

Here is an example of how to use the `cmbreps` command:

```
macs3 cmbreps -i replicate1.bedGraph replicate2.bedGraph replicate3.bedGraph -o combined.bedGraph --method mean
```

In this example, the program will combine the scores in the
`replicate1.bedGraph`, `replicate2.bedGraph`, and
`replicate3.bedGraph` files and write the result to
`combined.bedGraph`. The method used for combining scores is `mean` so
it will take the average score from the three replicates at each
genomic location.

[Previous](bdgpeakcall.html "bdgpeakcall")
[Next](filterdup.html "filterdup")

---

© Copyright 2025, Tao Liu, Philippa Doherty.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).