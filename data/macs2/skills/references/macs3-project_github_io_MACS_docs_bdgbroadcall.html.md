[MACS3](../index.html)

* [INSTALL Guide For MACS3](INSTALL.html)
* [Subcommands](subcommands_index.html)
  + [callpeak](callpeak.html)
  + [callvar](callvar.html)
  + [hmmratac](hmmratac.html)
  + bdgbroadcall
    - [Overview](#overview)
    - [Detailed Description](#detailed-description)
    - [Command Line Options](#command-line-options)
    - [Example Usage](#example-usage)
  + [bdgcmp](bdgcmp.html)
  + [bdgdiff](bdgdiff.html)
  + [bdgopt](bdgopt.html)
  + [bdgpeakcall](bdgpeakcall.html)
  + [cmbreps](cmbreps.html)
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
* bdgbroadcall
* [View page source](../_sources/docs/bdgbroadcall.md.txt)

---

# bdgbroadcall[](#bdgbroadcall "Link to this heading")

## Overview[](#overview "Link to this heading")

The `bdgbroadcall` subcommand of the MACS3 suite identifies ‘nested’
broad peaks from a single bedGraph track for scores, a function
essential in certain ChIP-Seq analyses.

## Detailed Description[](#detailed-description "Link to this heading")

The `bdgbroadcall` command takes an input bedGraph file and produces
an output file with broad peaks called. It is important to note: only
bedGraph files from MACS3 are acceptable to use in the `bdgbroadcall`
command, as All regions on the same chromosome in the bedGraph file
should be continuous.

Unlike narrow peak calling performed using `bdgpeakcall` or `callpeak`
without the `--broad` option, this command, along with the `--broad`
option in `callpeak`, facilitates broad peak calling, producing
results in the UCSC gappedPeak format which encapsulates a nested
structure of peaks. To conceptualize ‘nested’ peaks, picture a gene
structure housing regions analogous to exons (strong peaks) and
introns coupled with UTRs (weak peaks). The broad peak calling process
utilizes two distinct cutoffs to discern broader, weaker peaks and
narrower, stronger peaks, which are subsequently nested to provide a
detailed peak landscape.

Please note that, if you only want to call ‘broader’ peak and not
interested in the nested peak structure, please simply use
`bdgpeakcall` with weaker cutoff.

## Command Line Options[](#command-line-options "Link to this heading")

The command line options for `bdgbroadcall` are defined in `macs3 bdgbroadcall --help` command. Here is a brief overview of these
options:

* `-i` or `--ifile`: Genome-wide score for each possible location in
  bedGraph format. This is REQUIRED.
* `-c` or `--cutoff-peak`: Cutoff for stronger and narrower peaks
  depending on which method you used for the score track. If the file
  contains qvalue scores from MACS3, score 2 means qvalue 0.01.
  DEFAULT: 2
* `-C` or `--cutoff-link`: Cutoff for weaker and broader regions
  depending on which method you used for the score track. If the file
  contains qvalue scores from MACS3, score 1 means qvalue 0.1, and
  score 0.3 means qvalue 0.5. DEFAULT: 1
* `-l` or `--min-length`: Minimum length of stronger peak, better to
  set it as d value. DEFAULT: 200
* `-g` or `--lvl1-max-gap`: Maximum gap between stronger peaks, better
  to set it as the tag size. DEFAULT: 30
* `-G` or `--lvl2-max-gap`: Maximum gap between weaker peaks, better
  to set it as 4 times the d value. DEFAULT: 800
* `--no-trackline`: Tells MACS not to include a trackline with
  bedGraph files. The trackline is used by UCSC for display.
* `--verbose`: Set verbose level of runtime messages. 0: only show
  critical messages, 1: show additional warning messages, 2: show
  process information, 3: show debug messages. DEFAULT: 2
* `--outdir`: If specified, all output files will be written to that
  directory. Default: the current working directory
* `-o` or `--ofile`: Output file name. Mutually exclusive with
  `--o-prefix`.
* `--o-prefix`: Output file prefix. Mutually exclusive with
  `-o/--ofile`.

## Example Usage[](#example-usage "Link to this heading")

Here is an example of how to use the `bdgbroadcall` command:

```
macs3 bdgbroadcall -i input.bedGraph -o output.gappedPeak -c 2 -C 1.5 -l 500 -g 500 -G 1000
```

In this example, the program will call broad peaks from the
`input.bedGraph` file and write the result to `output.gappedPeak`. The
cutoff value for calling stronger peaks is set to 2.0, the minimum
length of stronger peaks is set to 500, the maximum gap between
stronger peaks is set to 500, the cutoff value for weaker peaks is set
to 1.5, and the maximum gap for weaker peaks is set to 1000.

[Previous](hmmratac.html "hmmratac")
[Next](bdgcmp.html "bdgcmp")

---

© Copyright 2025, Tao Liu, Philippa Doherty.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).