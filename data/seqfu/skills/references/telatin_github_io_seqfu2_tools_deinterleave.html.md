[Skip to main content](#main-content)   Link      Menu      Expand       (external link)    Document      Search       Copy       Copied

* [Home](/seqfu2/)
* [Installation](/seqfu2/installation)
* [Overview](/seqfu2/intro)
* [Core Tools](/seqfu2/tools/README.html)
  + [seqfu bases](/seqfu2/tools/bases.html)
  + [seqfu cat](/seqfu2/tools/cat.html)
  + [seqfu check](/seqfu2/tools/check.html)
  + [seqfu count](/seqfu2/tools/count.html)
  + [seqfu deinterleave](/seqfu2/tools/deinterleave.html)
  + [seqfu derep](/seqfu2/tools/derep.html)
  + [seqfu grep](/seqfu2/tools/grep.html)
  + [seqfu head](/seqfu2/tools/head.html)
  + [seqfu interleave](/seqfu2/tools/interleave.html)
  + [seqfu lanes](/seqfu2/tools/lanes.html)
  + [seqfu less](/seqfu2/tools/less.html)
  + [seqfu list](/seqfu2/tools/list.html)
  + [seqfu merge](/seqfu2/tools/merge.html)
  + [seqfu metadata](/seqfu2/tools/metadata.html)
  + [seqfu qual](/seqfu2/tools/qual.html)
  + [seqfu rc](/seqfu2/tools/rc.html)
  + [seqfu rotate](/seqfu2/tools/rotate.html)
  + [seqfu sort](/seqfu2/tools/sort.html)
  + [seqfu stats](/seqfu2/tools/stats.html)
  + [seqfu tabulate](/seqfu2/tools/tabulate.html)
  + [seqfu tail](/seqfu2/tools/tail.html)
  + [seqfu tofasta](/seqfu2/tools/tofasta.html)
  + [seqfu trim](/seqfu2/tools/trim.html)
  + [seqfu view](/seqfu2/tools/view.html)
  + [seqfu orf](/seqfu2/tools/orf.html)
  + [seqfu tabcheck](/seqfu2/tools/tabcheck.html)
* [Usage Guide](/seqfu2/usage)
* [Utilities](/seqfu2/utilities/README.html)
  + [fu-16Sregion](/seqfu2/utilities/fu-16Sregion.html)
  + [fu-cov](/seqfu2/utilities/fu-cov.html)
  + [fu-homocom](/seqfu2/utilities/fu-homocomp.html)
  + [fu-index](/seqfu2/utilities/fu-index.html)
  + [fu-msa](/seqfu2/utilities/fu-msa.html)
  + [fu-multirelabel](/seqfu2/utilities/fu-multirelabel.html)
  + [fu-nanotags](/seqfu2/utilities/fu-nanotags.html)
  + [fu-orf](/seqfu2/utilities/fu-orf.html)
  + [fu-primers](/seqfu2/utilities/fu-primers.html)
  + [fu-shred](/seqfu2/utilities/fu-shred.html)
  + [fu-sw](/seqfu2/utilities/fu-sw.html)
  + [fu-tabcheck](/seqfu2/utilities/fu-tabcheck.html)
  + [fu-virfilter](/seqfu2/utilities/fu-virfilter.html)
* [Helper Utilities](/seqfu2/scripts/README.html)
  + [fu-pecheck](/seqfu2/scripts/fu-pecheck.html)
  + [fu-split](/seqfu2/scripts/fu-split.html)
* [About](/seqfu2/about)
* [Releases](/seqfu2/releases/README.html)
  + [History](/seqfu2/releases/history.html)

This site uses [Just the Docs](https://github.com/just-the-docs/just-the-docs), a documentation theme for Jekyll.

Search SeqFu Documentation

* [GitHub Repository](https://github.com/telatin/seqfu2)
* [Report Issue](https://github.com/telatin/seqfu2/issues)

1. [Core Tools](/seqfu2/tools/README.html)
2. seqfu deinterleave

# seqfu deinterleave

*deinterleave* (or *dei*) is one of the core subprograms of *SeqFu*. It’s used to produce two separate FASTQ files from an interleaved file.

```
ilv: interleave FASTQ files

  Usage: dei [options] -o basename <interleaved-fastq>

  -o --output-basename "str"     save output to output_R1.fq and output_R2.fq
  -f --for-ext "R1"              extension for R1 file [default: _R1.fq]
  -r --rev-ext "R2"              extension for R2 file [default: _R2.fq]
  -c --check                     enable careful mode (check sequence names and numbers)
  -v --verbose                   print verbose output

  -s --strip-comments            skip comments
  -p --prefix "string"           rename sequences (append a progressive number)

notes:
    use "-" as input filename to read from STDIN

example:

    dei -o newfile file.fq
```

### Streaming

If a program produce an interleaved output, `seqfu deinterleave` can be used in a pipe (specifying “-“ as input):

```
fu-primers -1 file_R1.fq -2 file_R2.fq | seqfu deinterleave -o fileNoPrimers -
```

## What are interleaved files?

[Paired end sequences](https://www.illumina.com/science/technology/next-generation-sequencing/plan-experiments/paired-end-vs-single-read.html) can be stored in two separate files (usually denoted with the **\_R1** and **\_R2** strings) or in a single sequence where each sequence pair is stored as two subsequent sequences.

A simple example is depicted below:

```
=======================================================================
File_R1.fq                File_R2.fq                Interleaved.fq
=======================================================================

@seq1                     @seq1                     @seq1
TTTCATTCTGACTGCAACG       GGATTAAAAAAAGAGTGTC       TTTCATTCTGACTGCAACG
+                         +                         +
IIIIIIIIIIIIIIIIIII       IIIIIIIIIIIIIIIIIII       IIIIIIIIIIIIIIIIIII
@seq2                     @seq2                     @seq1
GTGTGGATTAAAAAAAAAA       TTTTTTTTTTTTTTTTTTT       GGATTAAAAAAAGAGTGTC
+                         +                         +
IIIIIIIIIIIIIIIIIII       IIIIIIIIIIIIIIIIIII       IIIIIIIIIIIIIIIIIII
@seq3                     @seq3                     @seq2
AGAGTGTCTGATAGCA          GATAGCAG                  GTGTGGATTAAAAAAAAAA
+                         +                         +
IIIIIIIIIIIIIIII          IIIIIIII                  IIIIIIIIIIIIIIIIIII
                                                    @seq2
                                                    TTTTTTTTTTTTTTTTTTT
                                                    +
                                                    IIIIIIIIIIIIIIIIIII
                                                    @seq3
                                                    AGAGTGTCTGATAGCA
                                                    +
                                                    IIIIIIIIIIIIIIII
                                                    @seq3
                                                    GATAGCAG
                                                    +
                                                    IIIIIIII
```

## Screenshot

![Screenshot of "seqfu deinterleave"](/seqfu2/img/screenshot-deinterleave.svg "SeqFu deinterleave")

---

[Back to top](#top)

Copyright © 2019-2025 Andrea Telatin. Distributed by an [MIT license](https://github.com/telatin/seqfu2/blob/main/LICENSE).

This site uses [Just the Docs](https://github.com/just-the-docs/just-the-docs), a documentation theme for Jekyll.