|  |
| --- |
| Raptor 4.0.0-rc.1  A fast and space-efficient pre-filter |

Loading...

Searching...

No Matches

raptor prepare

### Table of Contents

* [Main Parameters](#autotoc_md41)
  + [-​-input](#autotoc_md42)
  + [-​-output](#usage_prepare_output)
  + [-​-threads](#autotoc_md43)
  + [-​-quiet](#autotoc_md44)
  + [-​-kmer](#autotoc_md45)
  + [-​-window](#autotoc_md46)
  + [-​-kmer-count-cutoff](#autotoc_md47)
  + [-​-use-filesize-dependent-cutoff](#autotoc_md48)

Optionally preprocesses files for the use with `raptor layout` and `raptor build`.

Can continue where it left off after a crash or in multiple runs.

When to use:

* Applying k-mer filtering based on abundance.

# Main Parameters

## -​-input

The input file contains paths to the sequence data. Each line may contain multiple paths (separated by a whitespace).

/absolute/path/to/file1.fasta /absolute/path/to/file2.fasta

/absolute/path/to/file3.fa.gz

Many file types and compressions are supported. Click to show a list.

Supported file extensions are (possibly followed by bz2, gz, or bgzf):
  • embl
  • fasta
  • fa
  • fna
  • ffn
  • faa
  • frn
  • fas
  • fastq
  • fq
  • genbank
  • gb
  • gbk
  • sam

## -​-output

A path to the output directory. The directory will be created if it does not exist.

Will create a `minimiser.list` inside the output directory. This file contains a list of generated minimiser files, in the same order as the input. This file can be used as input for `raptor layout` or `raptor build`.

Created output files for each input file:

* `*.header`: Contains the shape, window size, cutoff and minimiser count.
* `*.minimiser`: Contains binary minimiser values, one minimiser per line.
* `*.in_progress`: Temporary file to track process. Deleted after finishing computation.

Attention
:   The window and k-mer sized used for preprocessing are propagated to `raptor layout` and `raptor build` and cannot be overwritten there.

Note
:   If `raptor prepare` aborts unexpectedly, you can rerun the same command. Files that have already preprocessed will be skipped.

Attention
:   When you manually delete a `.in_progress` file, also delete the corresponding `.header` and `.minimiser` file.

## -​-threads

The number of threads to use. Multiple files will be handled in parallel. While more threads speed up the preprocessing, the RAM usage also increases.

Note
:   Use less threads if `raptor prepare` fails due to RAM restrictions.

## -​-quiet

By default, runtime and memory statistics are printed to stderr at the end.

This flag disables this behaviour.

## -​-kmer

See [Choosing window and k-mer size](usage_quickstart.html#usage_w_vs_k).

Attention
:   This parameter will be used by `raptor build` and hence should be chosen carefully. The k-mer size cannot be changed afterwards.

## -​-window

See [Choosing window and k-mer size](usage_quickstart.html#usage_w_vs_k).

Attention
:   This parameter will be used by `raptor build` and hence should be chosen carefully. The window size cannot be changed afterwards.

## -​-kmer-count-cutoff

Only store k-mers with at least (>=) x occurrences.

Note
:   Mutually exclusive with –use-filesize-dependent-cutoff.

## -​-use-filesize-dependent-cutoff

Apply cutoffs from Mantis(Pandey et al., 2018).

| File size | Cutoff |
| --- | --- |
| ≤ 300 MiB | 1 |
| ≤ 500 MiB | 3 |
| ≤ 1 GiB | 10 |
| ≤ 3 GiB | 20 |
| > 3 GiB | 50 |

File sizes are based of gzipped FASTQ files. Compression reduces the file size by around factor `3`. FASTA files are approximately `2` times smaller than FASTQ.

Note
:   Mutually exclusive with –kmer-count-cutoff.

[Hide me](doxygen_crawl.html)

* Version:* * Generated on Mon Mar 23 2026 14:04:40 for Raptor by [![doxygen](doxygen.svg)](https://www.doxygen.org/index.html) 1.10.0