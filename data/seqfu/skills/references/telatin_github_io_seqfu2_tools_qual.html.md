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
2. seqfu qual

# seqfu qual

*qual* allows to detect the range of qualities of a FASTQ file, returning the possible encodings. Can be used to detect the last qualified position ().

```
Usage: qual [options] [<FASTQ>...]

Quickly check the quality of input files returning the detected encoding
and the profile of quality scores.
To read from STDIN, use - as filename.

  -m, --max INT          Check the first INT reads [default: 5000]
  -l, --maxlen INT       Maximum read length [default: 1000]
  -k, --skip INT         Print one sequence every INT [default: 1]

Qualified position:
  -w, --wnd INT          Sliding window size [default: 4]
  -q, --wnd-qual FLOAT   Minimum quality in the sliding window [default: 30.0]
  -z, --min-qual FLOAT   Stop the sliding windows when quality is below [default: 18.0]

Additional output:
  --gc                   Print GC content as extra column
  -p, --profile          Quality profile per position (will comment the summary lines)
  -c, --colorbars        Print graphical average quality profile

Other options:
  -v, --verbose          Verbose output
  -O, --offset INT       Quality encoding offset [default: 33]
  --help                 Show this help
```

## Example

Check if a set of files is likely in Illumina 1.8 encoding:

```
seqfu qual data/primers/*

data/primers/16S_R1.fq.gz	7.0	38.0	Sanger;Illumina-1.8;	33.42+/-8.47	249
data/primers/16S_R2.fq.gz	2.0	38.0	Sanger;Illumina-1.8;	31.96+/-9.53	205
data/primers/16Snano_R1.fq.gz	7.0	38.0	Sanger;Illumina-1.8;	33.37+/-8.63	246
data/primers/16Snano_R2.fq.gz	2.0	38.0	Sanger;Illumina-1.8;	32.05+/-9.54	220
data/primers/art_R1.fq.gz	40.0	40.0	Illumina-1.3;Sanger;Illumina-1.5;Solexa;Illumina-1.8;	40.00+/-0.00	95
data/primers/art_R2.fq.gz	40.0	40.0	Illumina-1.3;Sanger;Illumina-1.5;Solexa;Illumina-1.8;	40.00+/-0.00	93
```

The artifical datasets (`art*`) were designed to be compatible with most encodings, while the `16S*` files are real Illumina 1.8 sequences.

## Output

For each file a tab separated record is printed:

1. Filename
2. Minimum quality value
3. Maximum quality value
4. Possible encoding (semicolon separated list)
5. Mean, StDev of the quality value
6. Last qualified position
7. GC content (5 decimal positions) if enabled via `--gc`

## Per base statistics

With the `--profile` option tabular overview of the quality scores per nucleotide position of the read is printed:

```
#data/primers/16Snano_R1.fq.gz  40.0    71.0    Sanger;Illumina-1.8;    66.37+/-8.63
#Pos    Min     Max     Mean    StDev   Skewness
0       27.0    34.0    33.95   0.50    -12.36
1       27.0    34.0    33.97   0.46    -14.78
2       11.0    34.0    33.73   2.28    -9.08
3       23.0    34.0    33.92   0.76    -13.09
4       31.0    34.0    33.99   0.20    -15.20
5       28.0    38.0    37.76   0.86    -7.20
6       10.0    38.0    36.26   3.98    -4.89
...
298     7.0     37.0    26.34   10.34   -0.58
299     7.0     37.0    25.62   11.23   -0.55
300     7.0     37.0    21.29   9.26    -0.09
```

## Graphical summary

With the `--colorbar` option a graphical (Unicode) colored histogram of the *average* quality *per base position* is printed after each file.

![View](/seqfu2/img/qual.png)

## Use with DADA2

The last column of the tabular report (*last qualified position*), can be used to automatically detect the truncating position when using [DADA2](https://benjjneb.github.io/dada2/tutorial_1_8.html). [Dadaist](https://quadram-institute-bioscience.github.io/dadaist2/) uses *SeqFu* to automatically detect the qualified region.

---

[Back to top](#top)

Copyright © 2019-2025 Andrea Telatin. Distributed by an [MIT license](https://github.com/telatin/seqfu2/blob/main/LICENSE).

This site uses [Just the Docs](https://github.com/just-the-docs/just-the-docs), a documentation theme for Jekyll.