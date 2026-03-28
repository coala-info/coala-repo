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
2. seqfu stats

# seqfu stats

*stats* is one of the core subprograms of *SeqFu*.

```
Versions prior to v1.22.1 were calculating auN incorrectly.
```

```
Usage: stats [options] [<inputfile> ...]

Options:
  -a, --abs-path         Print absolute paths
  -b, --basename         Print only filenames
  -n, --nice             Print nice terminal table
  -j, --json             Print json (EXPERIMENTAL)
  -T, --interactive-table  Open interactive table view (TUI)
  -s, --sort-by KEY      Sort by KEY from: filename, counts, n50, tot, avg, min, max
                         descending for values, ascending for filenames [default: none]
  -r, --reverse          Reverse sort order
  --threads INT          Worker threads [default: 8]
  -t, --thousands        Add thousands separator (only tabbed/nice output)
  --csv                  Separate output by commas instead of tabs
  --gc                   Also print %GC
  --index                Also print contig index (L50, L90)
  --multiqc FILE         Saves a MultiQC report to FILE (suggested: name_mqc.txt)
  --precision INT        Number of decimal places to round to [default: 2]
  --noheader             Do not print header
  -v, --verbose          Verbose output
  -h, --help             Show this help
```

### Sorting

```
Sorting added in SeqFu 1.11.
```

To sort by filename (ascending alphabetical order) add `--sort filename`. Numerical values are sorted from the largest (descending), supported values are:

* *n50*, *n75* or *N90*
* *count* or *counts* (number of reads)
* *sum* or *tot* (total bases)
* *min* or *minimum* (minimum length)
* *max* or *maximum* (maximum length)
* *avg* or *mean* (average length)
* *aun* (area under the Nx curve)

**NOTE** Specifying an invalid key returns a non-zero exit code with an error message.

### Example output

Output is a TSV table (or CSV with `--csv`):

```
File,#Seq,Total bp,Avg,N50,N75,N90,auN,Min,Max
data/filt.fa.gz,78730,24299931,308.65,316,316,220,318.44,180,485
```

### Screen friendly output

When using `-n` (`--nice`) output:

```
seqfu stats data/filt.fa.gz  -n
┌─────────────────┬───────┬──────────┬───────┬─────┬─────┬─────┬───────┬─────┬─────┐
│ File            │ #Seq  │ Total bp │ Avg   │ N50 │ N75 │ N90 │ auN   │ Min │ Max │
├─────────────────┼───────┼──────────┼───────┼─────┼─────┼─────┼───────┼─────┼─────┤
│ data/filt.fa.gz │ 78730 │ 24299931 │ 308.6 │ 316 │ 316 │ 220 │ 0.385 │ 180 │ 485 │
└─────────────────┴───────┴──────────┴───────┴─────┴─────┴─────┴───────┴─────┴─────┘
```

### Interactive table output

Using `-T` (`--interactive-table`) opens the `tableview` TUI instead of printing to stdout. Columns keep numeric types (integers/floats), so interactive sorting behaves numerically.

`--interactive-table` is mutually exclusive with `--json` and `--nice`.

### JSON output

Using `-j` (`--json`) prints an array of JSON objects. Numeric fields are emitted as JSON numbers (not strings), while `Filename` is a string.

### Multithreading

Use `--threads INT` to process multiple input files in parallel. If STDIN (`-`) is used, stats are processed sequentially.

## MultiQC output

Using the `--multiqc OUTPUTFILE` option it’s possible to save a MultiQC compatible file (we recommend to use the *projectname\_mqc.tsv* filename format). After coolecting all the MultiQC files in a directory, using `multiqc -f .` will generate the MultiQC report. MultiQC itself can be installed via Bioconda with `conda install -y -c bioconda multiqc`.

To understand how to use MultiQC, if you never did so, check their excellent [documentation](https://multiqc.info).

## Legacy

The pre 1.11 version of the statistics has been made available via `seqfu oldstats`. There are no breaking changes at the moment, and an expanded set of tests ensures the compatibility not only of the metrics (unchanged) but also of the output (now supporting sorting options).

## Benchmark

A similar functionality is provided by `SeqKit`, so we compared the performance of SeqFu with [SeqKit](https://bioinf.shenwei.me/seqkit/) and [n50](https://metacpan.org/pod/release/PROCH/Proch-N50-1.3.0/bin/n50), both available from bioconda. We used a Linux Virtual Machine running Ubuntu 18.04, with 8 cores and 64 Gb of RAM for the test, with Miniconda (4.9.2) to install the required tools.

:warning: SeqKit, by default, omits N50 calculation, that is a core feature (always enabled) in SeqFu. The correct comparison is thus between `seqfu stats` and `seqkit stats --all`.

Speed evaluate with [hyperfine](https://github.com/sharkdp/hyperfine), peak memory usage with this [bash script](https://gist.github.com/MattForshaw/86b82b6c09bdbfce5ff5ee570e8a8bef).

As dataset we used the Human Genome (see [this benchmark page](https://bioinf.shenwei.me/seqkit/benchmark/)), which contains few large sequences, and the reference genome of the gastrointestinal tract, which is composed by many short sequences instead.

The test can be replicated with these commands:

```
# Download tools (can be done in a new environment)
conda install -c conda-forge -c bioconda hyperfine n50=1.3.0 seqkit=0.16.0 seqfu=0.9.6

# Download datasets: many short sequences and few large sequences
wget http://downloads.hmpdacc.org/data/reference_genomes/body_sites/Gastrointestinal_tract.nuc.fsa
wget ftp://ftp.ensembl.org/pub/release-84/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa.gz

# Compare execution times
FILE1=Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa.gz
FILE2=Gastrointestinal_tract.nuc.fsa

for FILE in $FILE1 $FILE2; do
  hyperfine --export-markdown stat_$(basename $FILE | cut -f1 -d.).md --warmup 1 --min-runs 3 \
    "seqfu stats $FILE" \
    "seqkit stats $FILE" \
    "seqkit stats --all $FILE" \
    "n50 -x $FILE"
done
```

The result, for the **Human Genome** (few large sequences), has been:

| Command | Mean [s] | Min [s] | Max [s] | Relative |
| --- | --- | --- | --- | --- |
| `seqfu stats $FILE` | 27.420 ± 0.349 | 27.090 | 27.785 | 1.00 |
| `seqkit stats $FILE` :warning: | 116.693 ± 0.236 | 116.512 | 116.960 | 4.26 ± 0.05 |
| `seqkit stats --all $FILE` | 120.435 ± 0.434 | 120.054 | 120.907 | 4.39 ± 0.06 |
| `n50 -x $FILE` | 34.888 ± 0.628 | 34.167 | 35.316 | 1.27 ± 0.03 |

For the **Gastrointestinal reference genomes** (many short sequences):

| Command | Mean [s] | Min [s] | Max [s] | Relative |
| --- | --- | --- | --- | --- |
| `seqfu stats $FILE` | 6.885 ± 0.307 | 6.602 | 7.211 | 1.82 ± 0.09 |
| `seqkit stats $FILE` :warning: | 3.793 ± 0.082 | 3.699 | 3.854 | 1.00 |
| `seqkit stats --all $FILE` | 7.667 ± 0.081 | 7.583 | 7.746 | 2.02 ± 0.05 |
| `n50 -x $FILE` | 76.377 ± 1.990 | 74.891 | 78.638 | 20.14 ± 0.68 |

## Screenshot

![Screenshot of "seqfu stats"](/seqfu2/img/screenshot-stats.svg "SeqFu stats")

---

[Back to top](#top)

Copyright © 2019-2025 Andrea Telatin. Distributed by an [MIT license](https://github.com/telatin/seqfu2/blob/main/LICENSE).

This site uses [Just the Docs](https://github.com/just-the-docs/just-the-docs), a documentation theme for Jekyll.