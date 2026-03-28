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
2. seqfu grep

# seqfu grep

*grep* is one of the core subprograms of *SeqFu*.

It can be used to select sequences by their name, comments or sequence using IUPAC degenerate oligo as query.

```
Usage: grep [options] [<inputfile> ...]

Print sequences selected if they match patterns or contain oligonucleotides

Options:
  -n, --name STRING      String required in the sequence name
  -r, --regex PATTERN    Pattern to be matched in sequence name
  -c, --comment          Also search -n and -r in the comment
  -f, --full             The string or pattern covers the whole name
                         (mainly used without -c)
  -w, --word             The string or pattern is a whole word
                         (only effective with -c, as names do not contain spaces)
  -i, --ignore-case      Ignore case when matching names (is already enabled with regexes)
  -o, --oligo IUPAC      Oligonucleotide required in the sequence,
                         using ambiguous bases and reverse complement
  -A, --append-pos       Append matching positions to the sequence comment
  --max-mismatches INT   Maximum mismatches allowed [default: 0]
  --min-matches INT      Minimum number of matches [default: oligo-length]
  -v, --verbose          Verbose output
  --help                 Show this help
```

## Get sequences by name

In a sequence the name, or id, is the string before the first white space character, while we define as comment all the rest:

```
>Seq_Name_Here  after the name or ID, everything else is the comment
ATTACAAACAGTCGATCGTAGCTAGCTAGCTGATC
```

To extract all the sequences containing “Here” in the name:

```
seqfu grep -n Here file.fasta
```

If we also want to extend the search to comments we need to add the `-c` (or `--comment`) switch:

```
seqfu grep -c -n extend file.fasta
```

Finally, [regular expressions](https://www.regular-expressions.info/) are supported only enabling `-r` (or `--regex`):

```
seqfu grep -r -n Seq_N..._ file.fasta
```

## Matching patterns in DNA sequences

A simple text search (even with regular expressions) cannot be a handy way to identify matches in a DNA/RNA sequence.

Using the `-o` (`--oligo`) parameter, we scan the sequence for matches of oligonucleotides supporting [IUPAC degenerate bases](https://www.bioinformatics.org/sms/iupac.html), supporting **reverse complement** matches and partial matches.

```
>Example
CAGATAAAA
```

if we scan for `TTTT` we will match the sequence, as it’s in the reverse complement strand:

```
seqfu -o TTTT file.fasta
```

We can also use IUPAC bases (N for any base, B for C, G or A…):

```
seqfu -o TTTTNT file.fasta
```

## Screenshot

![Screenshot of "seqfu grep"](/seqfu2/img/screenshot-grep.svg "SeqFu grep")

---

[Back to top](#top)

Copyright © 2019-2025 Andrea Telatin. Distributed by an [MIT license](https://github.com/telatin/seqfu2/blob/main/LICENSE).

This site uses [Just the Docs](https://github.com/just-the-docs/just-the-docs), a documentation theme for Jekyll.