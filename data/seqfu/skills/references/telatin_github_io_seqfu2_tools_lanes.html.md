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
2. seqfu lanes

# seqfu lanes

```
This function was called `merge` in a pre-release.
```

*lanes* is one of the core subprograms of *SeqFu*, that allows to quickly and easily merge Illumina lanes.

```
Usage: lanes [options] -o <outdir> <input_directory>

A program to merge Illumina lanes for a whole directory.

Options:
  -o, --outdir DIR           Output directory
  -e, --extension STR        File extension [default: .fastq]
  -s, --file-separator STR   Field separator in filenames [default: _]
  --comment-separator STR    String separating sequence name and its comment [default: TAB]
  -v, --verbose              Verbose output
  -h, --help                 Show this help
```

## Input

A directory containing files in the standard Illumina naming scheme, like:

```
ID1_S99_L001_R1_001.fastq.gz
ID1_S99_L001_R2_001.fastq.gz
ID1_S99_L002_R1_001.fastq.gz
ID1_S99_L002_R2_001.fastq.gz
ID1_S99_L003_R1_001.fastq.gz
ID1_S99_L003_R2_001.fastq.gz
ID1_S99_L004_R1_001.fastq.gz
ID1_S99_L004_R2_001.fastq.gz
ID2_S99_L001_R1_001.fastq.gz
ID2_S99_L001_R2_001.fastq.gz
ID2_S99_L002_R1_001.fastq.gz
ID2_S99_L002_R2_001.fastq.gz
ID2_S99_L003_R1_001.fastq.gz
ID2_S99_L003_R2_001.fastq.gz
ID2_S99_L004_R1_001.fastq.gz
ID2_S99_L004_R2_001.fastq.gz
ID3_S99_L001_R1_001.fastq.gz
ID3_S99_L001_R2_001.fastq.gz
ID3_S99_L002_R1_001.fastq.gz
ID3_S99_L002_R2_001.fastq.gz
ID3_S99_L003_R1_001.fastq.gz
ID3_S99_L003_R2_001.fastq.gz
ID3_S99_L004_R1_001.fastq.gz
ID3_S99_L004_R2_001.fastq.gz
```

## Performance

If compared with an efficient Bash implementation (as described [here](https://github.com/stephenturner/mergelanes#an-easier-way)), *SeqFu* is >10X faster.

| Command | Mean [ms] | Min [ms] | Max [ms] | Relative |
| --- | --- | --- | --- | --- |
| `seqfu merge -o /tmp/ data/lane` | 2.6 ± 0.9 | 1.6 | 10.4 | 1.00 |
| `merge_lanes.sh data/lane/` | 31.8 ± 4.0 | 25.4 | 49.5 | 12.42 ± 4.46 |

The *merge\_lanes.sh* script is as follows:

```
DIR=$PWD
cd $1
ls *R1* | cut -d _ -f 1 | sort | uniq \
    | while read id; do \
        cat $id*R1*.fastq.gz > $id.R1.fastq.gz;
        cat $id*R2*.fastq.gz > $id.R2.fastq.gz;
      done

cd $DIR/
rm $1/*.R{1,2}.*
```

and the test was performed against the `/data/lane` directory of SeqFu repository using the [hyperfine](https://github.com/sharkdp/hyperfine) program.

---

[Back to top](#top)

Copyright © 2019-2025 Andrea Telatin. Distributed by an [MIT license](https://github.com/telatin/seqfu2/blob/main/LICENSE).

This site uses [Just the Docs](https://github.com/just-the-docs/just-the-docs), a documentation theme for Jekyll.