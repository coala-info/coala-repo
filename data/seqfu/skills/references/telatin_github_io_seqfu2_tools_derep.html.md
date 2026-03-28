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
2. seqfu derep

# seqfu derep

*derep* is one of the core subprograms of *SeqFu*, that allows the dereplication of FASTA and FASTQ files. Dereplication, in R. C. Edgard [words](https://drive5.com/usearch/manual/dereplication.html) is *A rather obscure name for finding the set of unique sequences. Or, equivalently, the process of finding duplicated (replicate) sequences.*

In simple words, given a FASTA file, only unique sequences will be printed in the output. A core feature is printing the number of identical sequences found in the original dataset.

Dereplication is a step commonly used in NGS sequencing of amplicons, to reduce the computational time dedicated to the analysis of each representative sequence, and some tools will require dereplicated sequences as input (e.g. [USEARCH](https://rcedgar.github.io/usearch12_documentation/)).

```
Usage: derep [options] [<inputfile> ...]

Options:
  -k, --keep-name              Do not rename sequence, but use the first sequence name
  -i, --ignore-size            Do not count 'size=INT;' annotations (they will be stripped in any case)
  -m, --min-size=MIN_SIZE      Print clusters with size equal or bigger than INT sequences [default: 0]
  -p, --prefix=PREFIX          Sequence name prefix [default: seq]
  -5, --md5                    Use MD5 as sequence name (overrides other parameters)
  -j, --json=JSON_FILE         Save dereplication metadata to JSON file
  -s, --separator=SEPARATOR    Sequence name separator [default: .]
  -w, --line-width=LINE_WIDTH  FASTA line width (0: unlimited) [default: 0]
  -l, --min-length=MIN_LENGTH  Discard sequences shorter than MIN_LEN [default: 0]
  -x, --max-length=MAX_LENGTH  Discard sequences longer than MAX_LEN [default: 0]
  -c, --size-as-comment        Print cluster size as comment, not in sequence name
  --add-len                    Add length to sequence
  -v, --verbose                Print verbose messages
  -h, --help                   Show this help
```

## Size values

By default the program will add the number of identical sequences found to the sequence name, as USEARCH does: For example, if a sequence is found 18.335 times in the input file, the output will contain a sequence with “;size=18335” in the name (unless `--ignore-size` is passed). The term “size” can be confusing, but it was adopted for compatibility with USEARCH/VSERACH.

```
>seq.1;size=18335
CTTGGTCATTTAGAGGAAGTAAAAGTCGTAACAAGGTTTCCGTAGGTGAACCTGCGGAAGGATCATTACAGTATTCTTTTTGCCAGCGCTTAATTGCGCGGCGAAAAAACCTTACACACAGTGTTTTTTGTTATTACAAGAACTTTTGCTTTGGTCTGGACTAGAAATAGTTTGGGCCAGAGGTTTACTGAACTAAACTTCAATATTTATATTGAATTGTTATTTATTTAATTGTCAATTTGTTGATTAAATTCAAAAAATCTTCAAAACTTTCAACAACGGATCTCTTGGTTCTCGCATCGATGAAGAACGCAGC
>seq.2;size=4085
CTTGGTCATTTAGAGGAAGTAAAAGTCGTAACAAGGTTTCCGTAGGTGAACCTGCGGAAGGATCATTATTGAAGTTTAACTCAGAGGGTTGTAGCTGGCTCCTCCAAGAGCATGTGCACGCCCTTTGTCTTTACTCTTTTCCACCTGTGCACCTTTTGTAGACCATGAGTGAACTCTCGAGAGCGTTGGCAACGACGTGATCGGTTTGGGGATTTGCGTTCAGCTTTCCCTGTAGCTCGTGGTTTATGTCTTATAAACTCTATAGTCTGTTTTGAATGTCTTATGGGTTTTGCGCTGTAATGGTGCGACCTTTATAAACTATACAACTTTTAGCAACGGATCTCTTGGCTCTCGCATCGATGAAGAACGCAGC
>seq.3;size=2453
CTTGGTCATTTAGAGGAAGTAAGAGAGAAATGTATAAACTCATAATTGACGAATGATAATTGTTATTGAAGTTTTTGTAAAGGGGCTTCTTTATGAATAAGGGATACACGTTTGACGATATGATTAATACCATGATGCCCCTGGCCCTTTGACGGCTCGGCAAAGGGTGAAGGAATTTACTGCACGGTCAGGCCCTCGTCGCATCGATGAAGAACGCAGC
```

To keep the size separate from the sequence name it’s possible to used `-c` (`--size-as-comment`):

```
>seq.1 size=18335
CTTGGTCATTTAGAGGAAGTAAAAGTCGTAACAAGGTTTCCGTAGGTGAACCTGCGGAAGGATCATTACAGTATTCTTTTTGCCAGCGCTTAATTGCGCGGCGAAAAAACCTTACACACAGTGTTTTTTGTTATTACAAGAACTTTTGCTTTGGTCTGGACTAGAAATAGTTTGGGCCAGAGGTTTACTGAACTAAACTTCAATATTTATATTGAATTGTTATTTATTTAATTGTCAATTTGTTGATTAAATTCAAAAAATCTTCAAAACTTTCAACAACGGATCTCTTGGTTCTCGCATCGATGAAGAACGCAGC
>seq.2 size=4085
CTTGGTCATTTAGAGGAAGTAAAAGTCGTAACAAGGTTTCCGTAGGTGAACCTGCGGAAGGATCATTATTGAAGTTTAACTCAGAGGGTTGTAGCTGGCTCCTCCAAGAGCATGTGCACGCCCTTTGTCTTTACTCTTTTCCACCTGTGCACCTTTTGTAGACCATGAGTGAACTCTCGAGAGCGTTGGCAACGACGTGATCGGTTTGGGGATTTGCGTTCAGCTTTCCCTGTAGCTCGTGGTTTATGTCTTATAAACTCTATAGTCTGTTTTGAATGTCTTATGGGTTTTGCGCTGTAATGGTGCGACCTTTATAAACTATACAACTTTTAGCAACGGATCTCTTGGCTCTCGCATCGATGAAGAACGCAGC
>seq.3 size=2453
CTTGGTCATTTAGAGGAAGTAAGAGAGAAATGTATAAACTCATAATTGACGAATGATAATTGTTATTGAAGTTTTTGTAAAGGGGCTTCTTTATGAATAAGGGATACACGTTTGACGATATGATTAATACCATGATGCCCCTGGCCCTTTGACGGCTCGGCAAAGGGTGAAGGAATTTACTGCACGGTCAGGCCCTCGTCGCATCGATGAAGAACGCAGC
```

## Summing dereplicated outputs

If the input files were already dereplicated printing the “size” of the cluster, `derep` will sum the size values.

This is a feature that to our knowledge is only available in SeqFu and allows to process in parallel multiple samples and generating a single “dereplicated file” at the end, propagating the correct cluster sizes.

## Screenshot

![Screenshot of "seqfu derep"](/seqfu2/img/screenshot-derep.svg "SeqFu derep")

---

[Back to top](#top)

Copyright © 2019-2025 Andrea Telatin. Distributed by an [MIT license](https://github.com/telatin/seqfu2/blob/main/LICENSE).

This site uses [Just the Docs](https://github.com/just-the-docs/just-the-docs), a documentation theme for Jekyll.