### Navigation

* [index](../genindex.html "General Index")
* [next](blog-posts.html "Blog posts and additional documentation") |
* [previous](guide.html "An assembly handbook for khmer - rough draft") |
* [khmer 3.0.0a1+98.gfe0ce11 documentation](../index.html) »
* [The khmer user documentation](index.html) »

## Contents

* khmer’s command-line interface
  + [k-mer counting and abundance filtering](#k-mer-counting-and-abundance-filtering)
    - [load-into-counting.py](#load-into-counting-py)
    - [abundance-dist.py](#abundance-dist-py)
    - [abundance-dist-single.py](#abundance-dist-single-py)
    - [filter-abund.py](#filter-abund-py)
    - [filter-abund-single.py](#filter-abund-single-py)
    - [trim-low-abund.py](#trim-low-abund-py)
    - [count-median.py](#count-median-py)
    - [unique-kmers.py](#unique-kmers-py)
  + [Partitioning](#partitioning)
    - [do-partition.py](#do-partition-py)
    - [load-graph.py](#load-graph-py)
    - [partition-graph.py](#partition-graph-py)
    - [merge-partition.py](#merge-partition-py)
    - [annotate-partitions.py](#annotate-partitions-py)
    - [extract-partitions.py](#extract-partitions-py)
    - [Artifact removal](#artifact-removal)
      * [make-initial-stoptags.py](#make-initial-stoptags-py)
      * [find-knots.py](#find-knots-py)
      * [filter-stoptags.py](#filter-stoptags-py)
  + [Digital normalization](#digital-normalization)
    - [normalize-by-median.py](#normalize-by-median-py)
  + [Read handling: interleaving, splitting, etc.](#read-handling-interleaving-splitting-etc)
    - [extract-long-sequences.py](#extract-long-sequences-py)
    - [extract-paired-reads.py](#extract-paired-reads-py)
    - [fastq-to-fasta.py](#fastq-to-fasta-py)
    - [interleave-reads.py](#interleave-reads-py)
    - [readstats.py](#readstats-py)
    - [sample-reads-randomly.py](#sample-reads-randomly-py)
    - [split-paired-reads.py](#split-paired-reads-py)

#### Previous topic

[An assembly handbook for khmer - rough draft](guide.html "previous chapter")

#### Next topic

[Blog posts and additional documentation](blog-posts.html "next chapter")

### This Page

* [Show Source](../_sources/user/scripts.rst.txt)

1. [Docs](../index.html)
2. [The khmer user documentation](index.html)
3. khmer’s command-line interface

# khmer’s command-line interface[¶](#khmer-s-command-line-interface "Permalink to this headline")

The simplest way to use khmer’s functionality is through the command
line scripts, located in the [scripts/](https://github.com/dib-lab/khmer/tree/stable/scripts) directory of the
khmer distribution. Below is our documentation for these scripts. Note
that all scripts can be given `-h`/`--help` which will print out
a list of arguments taken by that script.

Scripts that use k-mer counting tables or k-mer graphs take an
[`-M`](#cmdoption-load-into-counting-py-m) parameter, which sets the maximum
memory usage in bytes. This should generally be set as high as possible; see
[Setting khmer memory usage](choosing-table-sizes.html) for more information.

1. [k-mer counting and abundance filtering](#scripts-counting)
2. [Partitioning](#scripts-partitioning)
3. [Digital normalization](#scripts-diginorm)
4. [Read handling: interleaving, splitting, etc.](#scripts-read-handling)

Note

Almost all scripts take in either FASTA and FASTQ format, and
output the same.

Gzip and bzip2 compressed files are detected automatically.

## k-mer counting and abundance filtering[¶](#k-mer-counting-and-abundance-filtering "Permalink to this headline")

### load-into-counting.py[¶](#load-into-counting-py "Permalink to this headline")

Build a k-mer countgraph from the given sequences.

```
usage: load-into-counting.py [--version] [--info] [-h] [-k KSIZE]
                             [-U UNIQUE_KMERS] [--fp-rate FP_RATE]
                             [-M MAX_MEMORY_USAGE] [--small-count]
                             [-T THREADS] [-b] [-s FORMAT] [-f] [-q]
                             output_countgraph_filename
                             input_sequence_filename
                             [input_sequence_filename ...]
```

`output_countgraph_filename`[¶](#cmdoption-load-into-counting-py-arg-output-countgraph-filename "Permalink to this definition")
:   The name of the file to write the k-mer countgraph to.

`input_sequence_filename`[¶](#cmdoption-load-into-counting-py-arg-input-sequence-filename "Permalink to this definition")
:   The names of one or more FAST[AQ] input sequence files.

`--version`[¶](#cmdoption-load-into-counting-py-version "Permalink to this definition")
:   show program’s version number and exit

`--info`[¶](#cmdoption-load-into-counting-py-info "Permalink to this definition")
:   print citation information

`-h``,` `--help`[¶](#cmdoption-load-into-counting-py-h "Permalink to this definition")
:   show this help message and exit

`-k` `<ksize>``,` `--ksize` `<ksize>`[¶](#cmdoption-load-into-counting-py-k "Permalink to this definition")
:   k-mer size to use

`-U` `<unique_kmers>``,` `--unique-kmers` `<unique_kmers>`[¶](#cmdoption-load-into-counting-py-u "Permalink to this definition")
:   approximate number of unique kmers in the input set

`--fp-rate` `<fp_rate>`[¶](#cmdoption-load-into-counting-py-fp-rate "Permalink to this definition")
:   Override the automatic FP rate setting for the current script

`-M` `<max_memory_usage>``,` `--max-memory-usage` `<max_memory_usage>`[¶](#cmdoption-load-into-counting-py-m "Permalink to this definition")
:   maximum amount of memory to use for data structure

`--small-count`[¶](#cmdoption-load-into-counting-py-small-count "Permalink to this definition")
:   Reduce memory usage by using a smaller counter for individual kmers.

`-T` `<threads>``,` `--threads` `<threads>`[¶](#cmdoption-load-into-counting-py-t "Permalink to this definition")
:   Number of simultaneous threads to execute

`-b``,` `--no-bigcount`[¶](#cmdoption-load-into-counting-py-b "Permalink to this definition")
:   The default behaviour is to count past 255 using bigcount. This flag turns bigcount off, limiting counts to 255.

`-s` `{json,tsv}``,` `--summary-info` `{json,tsv}`[¶](#cmdoption-load-into-counting-py-s "Permalink to this definition")
:   What format should the machine readable run summary be in? (json or tsv, disabled by default)

`-f``,` `--force`[¶](#cmdoption-load-into-counting-py-f "Permalink to this definition")
:   Overwrite output file if it exists

`-q``,` `--quiet`[¶](#cmdoption-load-into-counting-py-q "Permalink to this definition")

Note: with [`-b`](#cmdoption-load-into-counting-py-b)/[`--no-bigcount`](#cmdoption-load-into-counting-py-b) the output will be the
exact size of the k-mer countgraph and this script will use a constant
amount of memory. In exchange k-mer counts will stop at 255. The memory
usage of this script with [`-b`](#cmdoption-load-into-counting-py-b) will be about 1.15x the product of
the `-x` and `-N` numbers.

Example:

```
load-into-counting.py -k 20 -x 5e7 out data/100k-filtered.fa
```

Multiple threads can be used to accelerate the process, if you have extra
cores to spare.

Example:

```
load-into-counting.py -k 20 -x 5e7 -T 4 out data/100k-filtered.fa
```

### abundance-dist.py[¶](#abundance-dist-py "Permalink to this headline")

Calculate abundance distribution of the k-mers in the sequence file using a pre-made k-mer countgraph.

```
usage: abundance-dist.py [--version] [--info] [-h] [-z] [-s] [-b] [-f] [-q]
                         input_count_graph_filename input_sequence_filename
                         output_histogram_filename
```

`input_count_graph_filename`[¶](#cmdoption-abundance-dist-py-arg-input-count-graph-filename "Permalink to this definition")
:   The name of the input k-mer countgraph file.

`input_sequence_filename`[¶](#cmdoption-abundance-dist-py-arg-input-sequence-filename "Permalink to this definition")
:   The name of the input FAST[AQ] sequence file.

`output_histogram_filename`[¶](#cmdoption-abundance-dist-py-arg-output-histogram-filename "Permalink to this definition")
:   The columns are: (1) k-mer abundance, (2) k-mer count, (3) cumulative count, (4) fraction of total distinct k-mers.

`--version`[¶](#cmdoption-abundance-dist-py-version "Permalink to this definition")
:   show program’s version number and exit

`--info`[¶](#cmdoption-abundance-dist-py-info "Permalink to this definition")
:   print citation information

`-h``,` `--help`[¶](#cmdoption-abundance-dist-py-h "Permalink to this definition")
:   show this help message and exit

`-z``,` `--no-zero`[¶](#cmdoption-abundance-dist-py-z "Permalink to this definition")
:   Do not output zero-count bins

`-s``,` `--squash`[¶](#cmdoption-abundance-dist-py-s "Permalink to this definition")
:   Overwrite existing output\_histogram\_filename

`-b``,` `--no-bigcount`[¶](#cmdoption-abundance-dist-py-b "Permalink to this definition")
:   Do not count k-mers past 255

`-f``,` `--force`[¶](#cmdoption-abundance-dist-py-f "Permalink to this definition")
:   Continue even if specified input files do not exist or are empty.

`-q``,` `--quiet`[¶](#cmdoption-abundance-dist-py-q "Permalink to this definition")

Example:

```
load-into-counting.py -x 1e7 -N 2 -k 17 counts \
        tests/test-data/test-abund-read-2.fa
abundance-dist.py counts tests/test-data/test-abund-read-2.fa test-dist
```

### abundance-dist-single.py[¶](#abundance-dist-single-py "Permalink to this headline")

Calculate the abundance distribution of k-mers from a single sequence file.

```
usage: abundance-dist-single.py [--version] [--info] [-h] [-k KSIZE]
                                [-U UNIQUE_KMERS] [--fp-rate FP_RATE]
                                [-M MAX_MEMORY_USAGE] [--small-count]
                                [-T THREADS] [-z] [-b] [-s]
                                [--savegraph filename] [-f] [-q]
                                input_sequence_filename
                                output_histogram_filename
```

`input_sequence_filename`[¶](#cmdoption-abundance-dist-single-py-arg-input-sequence-filename "Permalink to this definition")
:   The name of the input FAST[AQ] sequence file.

`output_histogram_filename`[¶](#cmdoption-abundance-dist-single-py-arg-output-histogram-filename "Permalink to this definition")
:   The name of the output histogram file. The columns are: (1) k-mer abundance, (2) k-mer count, (3) cumulative count, (4) fraction of total distinct k-mers.

`--version`[¶](#cmdoption-abundance-dist-single-py-version "Permalink to this definition")
:   show program’s version number and exit

`--info`[¶](#cmdoption-abundance-dist-single-py-info "Permalink to this definition")
:   print citation information

`-h``,` `--help`[¶](#cmdoption-abundance-dist-single-py-h "Permalink to this definition")
:   show this help message and exit

`-k` `<ksize>``,` `--ksize` `<ksize>`[¶](#cmdoption-abundance-dist-single-py-k "Permalink to this definition")
:   k-mer size to use

`-U` `<unique_kmers>``,` `--unique-kmers` `<unique_kmers>`[¶](#cmdoption-abundance-dist-single-py-u "Permalink to this definition")
:   approximate number of unique kmers in the input set

`--fp-rate` `<fp_rate>`[¶](#cmdoption-abundance-dist-single-py-fp-rate "Permalink to this definition")
:   Override the automatic FP rate setting for the current script

`-M` `<max_memory_usage>``,` `--max-memory-usage` `<max_memory_usage>`[¶](#cmdoption-abundance-dist-single-py-m "Permalink to this definition")
:   maximum amount of memory to use for data structure

`--small-count`[¶](#cmdoption-abundance-dist-single-py-small-count "Permalink to this definition")
:   Reduce memory usage by using a smaller counter for individual kmers.

`-T` `<threads>``,` `--threads` `<threads>`[¶](#cmdoption-abundance-dist-single-py-t "Permalink to this definition")
:   Number of simultaneous threads to execute

`-z``,` `--no-zero`[¶](#cmdoption-abundance-dist-single-py-z "Permalink to this definition")
:   Do not output zero-count bins

`-b``,` `--no-bigcount`[¶](#cmdoption-abundance-dist-single-py-b "Permalink to this definition")
:   Do not count k-mers past 255

`-s``,` `--squash`[¶](#cmdoption-abundance-dist-single-py-s "Permalink to this definition")
:   Overwrite output file if it exists

`--savegraph` `<filename>`[¶](#cmdoption-abundance-dist-single-py-savegraph "Permalink to this definition")
:   Save the k-mer countgraph to the specified filename.

`-f``,` `--force`[¶](#cmdoption-abundance-dist-single-py-f "Permalink to this definition")
:   Override sanity checks

`-q``,` `--quiet`[¶](#cmdoption-abundance-dist-single-py-q "Permalink to this definition")

Note that with [`-b`](#cmdoption-abundance-dist-single-py-b)/[`--no-bigcount`](#cmdoption-abundance-dist-single-py-b) this script is constant
memory; in exchange, k-mer counts will stop at 255. The memory usage of
this script with [`-b`](#cmdoption-abundance-dist-single-py-b) will be about 1.15x the product of the
`-x` and `-N` numbers.

To count k-mers in multiple files use **load\_into\_counting.py** and
**abundance\_dist.py**.

Example:

```
abundance-dist-single.py -x 1e7 -N 2 -k 17 \
        tests/test-data/test-abund-read-2.fa test-dist
```

### filter-abund.py[¶](#filter-abund-py "Permalink to this headline")

Trim sequences at a minimum k-mer abundance.

```
usage: filter-abund.py [--version] [--info] [-h] [-T THREADS] [-C CUTOFF] [-V]
                       [-Z NORMALIZE_TO] [-o optional_output_filename] [-f]
                       [-q] [--gzip | --bzip]
                       input_count_graph_filename input_sequence_filename
                       [input_sequence_filename ...]
```

`input_count_graph_filename`[¶](#cmdoption-filter-abund-py-arg-input-count-graph-filename "Permalink to this definition")
:   The input k-mer countgraph filename

`input_sequence_filename`[¶](#cmdoption-filter-abund-py-arg-input-sequence-filename "Permalink to this definition")
:   Input FAST[AQ] sequence filename

`--version`[¶](#cmdoption-filter-abund-py-version "Permalink to this definition")
:   show program’s version number and exit

`--info`[¶](#cmdoption-filter-abund-py-info "Permalink to this definition")
:   print citation information

`-h``,` `--help`[¶](#cmdoption-filter-abund-py-h "Permalink to this definition")
:   show this help message and exit

`-T` `<threads>``,` `--threads` `<threads>`[¶](#cmdoption-filter-abund-py-t "Permalink to this definition")
:   Number of simultaneous threads to execute

`-C` `<cutoff>``,` `--cutoff` `<cutoff>`[¶](#cmdoption-filter-abund-py-c "Permalink to this definition")
:   Trim at k-mers below this abundance.

`-V``,` `--variable-coverage`[¶](#cmdoption-filter-abund-py-v "Permalink to this definition")
:   Only trim low-abundance k-mers from sequences that have high coverage.

`-Z` `<normalize_to>``,` `--normalize-to` `<normalize_to>`[¶](#cmdoption-filter-abund-py-z "Permalink to this definition")
:   Base the variable-coverage cutoff on this median k-mer abundance.

`-o` `<optional_output_filename>``,` `--output` `<optional_output_filename>`[¶](#