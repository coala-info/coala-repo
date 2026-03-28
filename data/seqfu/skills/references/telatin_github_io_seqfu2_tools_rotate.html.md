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
2. seqfu rotate

# seqfu rotate

Rotate a sequence setting a new starting position, using a new position or an oligonucleotide.

Introduced with SeqFu 1.8.6.

```
sage:
    fu-rotate [options] -i POS [<fastq-file>...]
    fu-rotate [options] -m STR [<fastq-file>...]

  Rotate the sequences of one or more sequence files using
  coordinates or motifs.

  Position based:
    -i, --start-pos POS        Restart from base POS, where 1 is the first base [default: 1]

  Motif based:
    -m, --motif STR            Rotate sequences using motif STR as the new start,
                               where STR is a string of bases
    -s, --skip-unmached        If a motif is provided, skip sequences that do not
                               match the motif
    -r, --revcomp              Also scan for reverse complemented motif

  Other options:
    -v, --verbose              Verbose output
    -h, --help                 Show this help
```

## Examples

Given an input file with a single sequence:

```
>polyA
ACACGTACTACTGAAAAAAAAAACTGCTACTA
```

### Rotate by new position

```
seqfu rotate -i 14  data/homopolymer.fa
```

Output:

```
>polyA
AAAAAAAAAACTGCTACTAACACGTACTACTG
```

### Rotate by oligonucleotide

:warning: rotation by oligo will only produce an output if the match is unique

```
seqfu rotate -m AAAAAAAAAA data/homopolymer.fa
```

Output:

```
>polyA
AAAAAAAAAACTGCTACTAACACGTACTACTG
```

### Rotate by oligonucleotide (also in reverse)

```
seqfu rotate -r -m GTTTTTTTTTT  data/homopolymer.fa
```

Output:

```
>polyA
GTTTTTTTTTTCAGTAGTACGTGTTAGTAGCA
```

## Screenshot

![Screenshot of "seqfu rotate"](/seqfu2/img/screenshot-rotate.svg "SeqFu rotate")

---

[Back to top](#top)

Copyright © 2019-2025 Andrea Telatin. Distributed by an [MIT license](https://github.com/telatin/seqfu2/blob/main/LICENSE).

This site uses [Just the Docs](https://github.com/just-the-docs/just-the-docs), a documentation theme for Jekyll.