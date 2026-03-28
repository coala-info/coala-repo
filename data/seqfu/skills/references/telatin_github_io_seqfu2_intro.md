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

# Overview

SeqFu consists of core programs, accessible as subcommands, and a set of corollary utilities, having the prefix `fu-`.

Some historical utilities are now also available as core subcommands (`seqfu orf`, `seqfu tabcheck`) while keeping the legacy wrappers (`fu-orf`, `fu-tabcheck`) for compatibility.

Type `seqfu` alone to list the core subprograms, and `seqfu {command} --help` to access the help of each specific subcommand.

To simply print the version type `seqfu version` and to print the citation `seqfu cite`.

## Basic operations: cat, head, tail, grep, rc

These commands have been inspired by the common *GNU commands*, and all can read from the standard input.

Their usage is quite intuitive, so here we highlight some special feature.

**[seqfu cat](/seqfu2/tools/cat.html)** can read mixed FASTA and FASTQ files, and be forced to output in either FASTA or FASTQ format. Some basic manipulations are bundled, like:

* Forcing FASTA or FASTQ output
* Manipulating sequence name (prefix, suffix, prepend filename, remove comments…)
* Add infos in the header (length, gc content, original name)
* Filter by length (minimum length, maximum length, trim bases at the beginning or the end…)
* …

**[seqfu grep](/seqfu2/tools/grep.html)** can be used to extract sequences by matching oligonucleotides, that would be scanned also in the reverse strand and allowing for mismatches or partial matches. The oligo can be in IUPAC alphabet with ambiguous bases (e.g. degenerate primers).

**[seqfu head](/seqfu2/tools/head.html)** can skip a number of sequences (*i. e.* print the first *N* sequences taking one every *M*), to extract a small subset sampling deeper.

The *reverse complement* function (**[seqfu rc](/seqfu2/tools/rc.html)**) is unique in taking as input both files and sequences, and properly supports IUPAC degenerate bases.

## Getting an idea: view, qual, stats, count

**[seqfu view](/seqfu2/tools/view.html)** is only for interactive use, and can be used to have a visual feedback on the quality values and on the presence of oligonucleotides:

![View](/seqfu2/img/view.png)

**[seqfu stats](/seqfu2/tools/stats.html)** can print the total number of sequences, bases, average, N50, N75, N90 and AuN, minimum and maximum length of a dataset, both in TSV format and with a nicer console oriented output:

```
┌────────────────────┬───────┬──────────┬───────┬─────┬─────┬─────┬────────┬─────┬─────┐
│ File               │ #Seq  │ Total bp │ Avg   │ N50 │ N75 │ N90 │ auN    │ Min │ Max │
├────────────────────┼───────┼──────────┼───────┼─────┼─────┼─────┼────────┼─────┼─────┤
│ filt.fa.gz         │ 78730 │ 24299931 │ 308.6 │ 316 │ 316 │ 220 │ 0.385  │ 180 │ 485 │
│ illumina_1.fq.gz   │ 7     │ 630      │ 90.0  │ 90  │ 90  │ 90  │ 12.857 │ 90  │ 90  │
│ illumina_2.fq.gz   │ 7     │ 630      │ 90.0  │ 90  │ 90  │ 90  │ 12.857 │ 90  │ 90  │
│ illumina_nocomm.fq │ 7     │ 630      │ 90.0  │ 90  │ 90  │ 90  │ 12.857 │ 90  │ 90  │
└────────────────────┴───────┴──────────┴───────┴─────┴─────┴─────┴────────┴─────┴─────┘
```

## Managing datasets: interleave, deinterleave, lanes

Very common tasks when dealing with Illumina Paired-End sequences are interleaving and deinterleaving the datasets.

**[seqfu interleave](/seqfu2/tools/interleave.html)** and **[seqfu deinterleave](/seqfu2/tools/deinterleave.html)** can do that, with high speed and lower corruption risks.

Multiple lanes can be quickly merged with **[seqfu lanes](/seqfu2/tools/merge_lanes.html)**.

## Sorting, dereplicating

**[seqfu sort](/seqfu2/tools/sort.html)** can sort sequences by length.

**[seqfu derep](/seqfu2/tools/derep.html)** can be used to dereplicate datasets, printing the number of identical sequences. In particular, this information can be used also from the input dataset, allowing to dereplicating a set of dereplicated files keeping trace of the number of sequences.

---

[Back to top](#top)

Copyright © 2019-2025 Andrea Telatin. Distributed by an [MIT license](https://github.com/telatin/seqfu2/blob/main/LICENSE).

This site uses [Just the Docs](https://github.com/just-the-docs/just-the-docs), a documentation theme for Jekyll.