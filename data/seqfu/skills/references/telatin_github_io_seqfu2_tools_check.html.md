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
2. seqfu check

# seqfu check

```
**EXPERIMENTAL**: Introduced in SeqFu 1.15, updated with --deep in 1.18 (see below).
In SeqFu 2.0 a strict behaviour will be used by default, see **fu-pecheck** and **fu-secheck**.
```

Evaluates the integrity of DNA FASTQ files.

```
Usage: seqfu check [options] <FQFILE> [<REV>]
       seqfu check [options] --dir <FQDIR>

  Check the integrity of FASTQ files, returns non zero
  if an error occurs. Will print a table with a report.

  Input is a single dataset:
    <FQFILE>                   the forward read file
    <REV>                      the reverse read file
  or a directory of FASTQ files (--dir):
    <FQDIR>                    the directory containing the FASTQ files

  Options:
    -d, --deep                 Perform a deep check of the file and will not
                               lsupport multiline Sanger FASTQ [default: false]
    -n, --no-paired            Disable autodetection of second pair
    -s, --safe-exit            Exit with 0 even if errors are found
    -q, --quiet                Do not print infos, just exit status
    -v, --verbose              Verbose output
    -t, --thousands            Print numbers with thousands separator
    --debug                    Debug output
    -h, --help                 Show this help
```

### Integrity check

:warning: If not using `--deep`, the file is considered valid if `seqfu cat $INPUT > $OUTPUT` would produce a valid file (i.e. if an error is detected at the 100-th sequence, the file would be considered valid reporting 99 as total sequences)

A single FASTQ file is considered valid if:

* each record has the same sequence and quality length
* only A,C,G,T,N characters are present in the sequence

A paired-end set of FASTQ files is considered valid if:

* each file is individually valid
* the two files have the same number of sequences
* the first and last sequence of both files has the same name (the last three characters are ignored if the remaining sequence name is greater than 4 characters)
* the first and last sequence of the two files are not identical (R1 != R2)

### Deep check

If you are parsing NGS files, i.e. FASTQ files, with four lines per record and you expect them to be accepted by any program, use `--deep`.

### Usage

To test a single file:

```
seqfu check test_file.fq.gz
```

To test a pair of files:

```
seqfu check test_R1.fq.gz [test_R2.fq.gz]
```

Note that if supplying a single file but a matching pair is detected (e.g. `test_R1.fq.gz` is supplied and `test_R2.fq.gz` is found), the check will be performed on both files.

To test all files in a directory:

```
seqfu check --dir test_dir
```

#### Other options

* `--no-paired` disables the autodetection of the second pair (i.e. force single end check)
* `--thousands` will add a thousands separator to the output
* `--quiet` will not print data, but only the exit status will be used
* `--verbose` will print more information (including processing speed)
* `--debug` will print debug information
* `--safe-exit` will always exit with 0, even if errors are found (useful in pipelines)

### Exit status

If an error is identified in at least one file, the program will exit with non zero status, unless the `--safe-exit` option is used.

### Output

The output is a table with the following columns:

1. Status (`OK` or `ERR`)
2. Library type (`SE` or `PE`)
3. Filename (the path to the first pair, if `PE`)
4. Number of sequences counted (if `PE`: number of sequences in **both** files) or `-` if the dataset is not valid
5. Number of bases (if `PE`: total number of bases in **both** files) or `-` if the dataset is not valid
6. Number of errors
7. List of detected errors (if any)

#### Example

Example of output for a directory containing 3 Paired End datasets:

```
OK      PE      /tmp/data/16S_R1.fq.gz  12274   3694474 0
OK      PE      /tmp/data/16Snano_R1.fq.gz      468     140868  0
OK      PE      /tmp/data/illumina_1.fq.gz      14      1260    0
```

Example of errors (can be reproduced using the *data* directory of the repository)

```
seqfu check --dir data/primers
```

```
OK      SE      data/primers/16S_merge.fq.gz    6137    2596981 0
OK      SE      data/primers/16S_vsearch_merge.fq.gz    3935    1818111 0
ERR     SE      data/primers/artificial.fq.gz   -       -       2       Invalid character in sequence: < > in R2.REV+.middle;
OK      SE      data/primers/its-merge.fq.gz    7299    1504898 0
OK      SE      data/primers/se.fq.gz   234     70434   0
OK      SE      data/primers/small.fq   4       360     0
OK      PE      data/primers/16S_R1.fq.gz       12274   3694474 0
OK      PE      data/primers/16Snano_R1.fq.gz   468     140868  0
ERR     PE      data/primers/art_R1.fq.gz       7       -       5       R2=Invalid character in sequence: < > in R2.REV+.middle;;First sequence names do not match (R1.startFOR+, R2.startREV+);Last sequence names do not match (R1.FOR1+.start-middle, );
OK      PE      data/primers/its_R1.fq.gz       16000   3387804 0
OK      PE      data/primers/itsfilt_R1.fq.gz   15618   3272396 0
OK      PE      data/primers/pico_R1.fq.gz      24      7224    0
```

---

[Back to top](#top)

Copyright © 2019-2025 Andrea Telatin. Distributed by an [MIT license](https://github.com/telatin/seqfu2/blob/main/LICENSE).

This site uses [Just the Docs](https://github.com/just-the-docs/just-the-docs), a documentation theme for Jekyll.