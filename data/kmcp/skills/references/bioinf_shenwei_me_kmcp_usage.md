[ ]
[ ]

[Skip to content](#usage)

[![logo](../favicon.svg)](.. "KMCP - accurate metagenomic profiling and fast large-scale sequence/genome searching")

KMCP - accurate metagenomic profiling and fast large-scale sequence/genome searching

Usage

Initializing search

[GitHub](https://github.com/shenwei356/kmcp/ "Go to repository")

[![logo](../favicon.svg)](.. "KMCP - accurate metagenomic profiling and fast large-scale sequence/genome searching")
KMCP - accurate metagenomic profiling and fast large-scale sequence/genome searching

[GitHub](https://github.com/shenwei356/kmcp/ "Go to repository")

* [Home](..)
* [Download](../download/)
* [Databases](../database/)
* [ ]

  Usage
  [Usage](./)

  Table of contents
  + [kmcp](#kmcp)
  + [compute](#compute)
  + [index](#index)
  + [search](#search)
  + [merge](#merge)
  + [profile](#profile)
  + [utils](#utils)
  + [ref-info](#ref-info)
  + [index-info](#index-info)
  + [index-density](#index-density)
  + [unik-info](#unik-info)
  + [merge-regions](#merge-regions)
  + [filter](#filter)
  + [split-genomes](#split-genomes)
  + [cov2simi](#cov2simi)
  + [query-fpr](#query-fpr)
  + [autocompletion](#autocompletion)
* [ ]

  Tutorials

  Tutorials
  + [Taxonomic profiling](../tutorial/profiling/)
  + [Detecting specific pathogens](../tutorial/detecting-pathogens/)
  + [Detecting contaminated sequences](../tutorial/detecting-contaminated-seqs/)
  + [Sequence and genome searching](../tutorial/searching/)
* [ ]

  Benchmarks

  Benchmarks
  + [Taxonomic profiling](../benchmark/profiling/)
  + [Sequence and genome searching](../benchmark/searching/)
* [FAQs](../faq/)
* [More tools](https://github.com/shenwei356)

Table of contents

* [kmcp](#kmcp)
* [compute](#compute)
* [index](#index)
* [search](#search)
* [merge](#merge)
* [profile](#profile)
* [utils](#utils)
* [ref-info](#ref-info)
* [index-info](#index-info)
* [index-density](#index-density)
* [unik-info](#unik-info)
* [merge-regions](#merge-regions)
* [filter](#filter)
* [split-genomes](#split-genomes)
* [cov2simi](#cov2simi)
* [query-fpr](#query-fpr)
* [autocompletion](#autocompletion)

# Usage

![](../kmcp-workflow.jpg)

KMCP is a command-line tool consisting of several subcommands.

| Subcommand | Function |
| --- | --- |
| [**compute**](https://bioinf.shenwei.me/kmcp/usage/#compute) | Generate k-mers (sketch) from FASTA/Q sequences |
| [**index**](https://bioinf.shenwei.me/kmcp/usage/#index) | Construct adatabase from k-mer files |
| [**search**](https://bioinf.shenwei.me/kmcp/usage/#search) | Search sequences against a database |
| [**merge**](https://bioinf.shenwei.me/kmcp/usage/#merge) | Merge search results from multiple databases |
| [**profile**](https://bioinf.shenwei.me/kmcp/usage/#profile) | Generate the taxonomic profile from search results |
| [utils split-genomes](https://bioinf.shenwei.me/kmcp/usage/#split-genomes) | Split genomes into chunks |
| [utils unik-info](https://bioinf.shenwei.me/kmcp/usage/#unik-info) | Print information of .unik files |
| [utils index-info](https://bioinf.shenwei.me/kmcp/usage/#index-info) | Print information of index files |
| [utils index-density](https://bioinf.shenwei.me/kmcp/usage/#index-density) | Plot the element density of bloom filters for an index file |
| [utils ref-info](https://bioinf.shenwei.me/kmcp/usage/#ref-info) | Print information of reference chunks in a database |
| [utils cov2simi](https://bioinf.shenwei.me/kmcp/usage/#icov2simi) | Convert k-mer coverage to sequence similarity |
| [utils query-fpr](https://bioinf.shenwei.me/kmcp/usage/#query-fpr) | Compute the false positive rate of a query |
| [utils filter](https://bioinf.shenwei.me/kmcp/usage/#filter) | Filter search results and find species/assembly-specific queries |
| [utils merge-regions](https://bioinf.shenwei.me/kmcp/usage/#merge-regions) | Merge species/assembly-specific regions |

## kmcp

```
    Program: kmcp (K-mer-based Metagenomic Classification and Profiling)
    Version: v0.9.4
  Documents: https://bioinf.shenwei.me/kmcp
Source code: https://github.com/shenwei356/kmcp

KMCP is a tool for metagenomic classification and profiling.

KMCP can also be used for:
  1. Fast sequence search against large scales of genomic datasets
     as BIGSI and COBS do.
  2. Fast assembly/genome similarity estimation as Mash and sourmash do,
     by utilizing Minimizer, FracMinHash (Scaled MinHash), or Closed Syncmers.

Usage:
  kmcp [command]

Available Commands:
  autocompletion Generate shell autocompletion script
  compute        Generate k-mers (sketches) from FASTA/Q sequences
  index          Construct a database from k-mer files
  merge          Merge search results from multiple databases
  profile        Generate the taxonomic profile from search results
  search         Search sequences against a database
  utils          Some utilities
  version        Print version information and check for update

Flags:
  -h, --help                 help for kmcp
  -i, --infile-list string   ► File of input files list (one file per line). If given, they are
                             appended to files from CLI arguments.
      --log string           ► Log file.
  -q, --quiet                ► Do not print any verbose information. But you can write them to file
                             with --log.
  -j, --threads int          ► Number of CPUs cores to use. (default 16)

Use "kmcp [command] --help" for more information about a command.
```

## compute

```
Generate k-mers (sketches) from FASTA/Q sequences

Input:
  1. Input plain or gzipped FASTA/Q files can be given via positional
     arguments or the flag -i/--infile-list with the list of input files,
  2. Or a directory containing sequence files via the flag -I/--in-dir,
     with multiple-level sub-directories allowed. A regular expression
     for matching sequencing files is available via the flag -r/--file-regexp.
 *3. For taxonomic profiling, the sequences of each reference genome should be
     saved in a separate file, with the reference identifier in the file name.

  Attention:
    You may rename the sequence files for convenience because the
  sequence/genome identifier in the index and search results would be:
    1). For the default mode (computing k-mers for the whole file):
          the basename of file with common FASTA/Q file extension removed,
          captured via the flag -N/--ref-name-regexp.
    2). For splitting sequence mode (see details below):
          same to 1).
    3). For computing k-mers for each sequence:
          the sequence identifier.

Attentions:
  1. Unwanted sequences like plasmid can be filtered out by
     the name via regular expressions (-B/--seq-name-filter).
  2. By default, kmcp computes k-mers (sketches) of every file,
     you can also use --by-seq to compute for every sequence,
     where sequence IDs in all input files are better to be distinct.
  3. It also supports splitting sequences into chunks, this
     could increase the specificity in search results at the cost
     of a slower searching speed.
  4. Multiple sizes of k-mers are supported.

Supported k-mer (sketches) types:
  1. K-mer:
     1). ntHash of k-mer (-k)
  2. K-mer sketchs (all using ntHash):
     1). FracMinHash    (-k -D), previously named Scaled MinHash
     2). Minimizer      (-k -W), optionally scaling/down-sampling (-D)
     3). Closed Syncmer (-k -S), optionally scaling/down-sampling (-D)

Splitting sequences:
  1. Sequences can be splitted into chunks by a chunk size
     (-s/--split-size) or number of chunks (-n/--split-number)
     with overlap (-l/--split-overlap).
     In this mode, the sequences of each genome should be saved in an
     individual file.
  2. When splitting by number of chunks, all sequences (except for
     these matching any regular expression given by -B/--seq-name-filter)
     in a sequence file are concatenated with k-1 N's before splitting.
  3. Both sequence IDs and chunks indices are saved for later use,
     in form of meta/description data in .unik files.

Metadata:
  1. Every outputted .unik file contains the sequence/reference ID,
     chunk index, number of chunks, and genome size of reference.
  2. When parsing whole sequence files or splitting by the number of chunks,
     the identifier of a reference is the basename of the input file
     by default. It can also be extracted from the input file name via
     -N/--ref-name-regexp, e.g., "^(\w{3}_\d{9}\.\d+)" for RefSeq records.

Output:
  1. All outputted .unik files are saved in ${outdir}, with path
     ${outdir}/xxx/yyy/zzz/${infile}-id_${seqID}.unik
     where dirctory tree '/xxx/yyy/zzz/' is built for > 1000 output files.
  2. For splitting sequence mode (--split-size > 0 or --split-number > 0),
     output files are:
     ${outdir}//xxx/yyy/zzz/${infile}/{seqID}-chunk_${chunkIdx}.unik
  3. A summary file ("${outdir}/_info.txt") is generated for later use.
     Users need to check if the reference IDs (column "name") are what
     supposed to be.

Performance tips:
  1. Decrease the value of -j/--threads for data in hard disk drives to
     reduce I/O pressure.

Next step:
  1. Check the summary file (${outdir}/_info.txt) to see if the reference
     IDs (column "name") are what supposed to be.
  2. Run "kmcp index" with the output directory.

Examples:
  1. From few sequence files:

        kmcp compute -k 21 -n 10 -l 150 -O tmp-k21-n10-l150 NC_045512.2.fna.gz

  2. From a list file:

        kmcp compute -k 21 -n 10 -l 150 -O tmp-k21-210-l150 -i list.txt

  3. From a directory containing many sequence files:

        kmcp compute -k 21 -n 10 -l 150 -B plasmid \
            -O gtdb-k21-n10-l150 -I gtdb-genomes/

Usage:
  kmcp compute [flags] [-k <k>] [-n <chunks>] [-l <overlap>] {[-I <seqs dir>] | <seq files>} -O <out dir>

Flags:
      --by-seq                    ► Compute k-mers (sketches) for each sequence, instead of the whole file.
      --circular                  ► Input sequences are circular. Note that it only applies to genomes
                                  with a single chromosome.
  -c, --compress                  ► Output gzipped .unik files, it's slower and can save little space.
  -r, --file-regexp string        ► Regular expression for matching sequence files in -I/--in-dir,
                                  case ignored. (default "\\.(f[aq](st[aq])?|fna)(.gz)?$")
      --force                     ► Overwrite existed output directory.
  -h, --help                      help for compute
  -I, --in-dir string             ► Directory containing FASTA/Q files. Directory symlinks are followed.
  -k, --kmer ints                 ► K-mer size(s). K needs to be <=64. Multiple values are supported,
                                  e.g., "-k 21,31" or "-k 21 -k 31" (default [21])
  -W, --minimizer-w int           ► Minimizer window size.
  -O, --out-dir string            ► Output directory.
  -N, --ref-name-regexp string    ► Regular expression (must contains "(" and ")") for extracting
                                  reference name from filename. (default
                                  "(?i)(.+)\\.(f[aq](st[aq])?|fna)(.gz)?$")
  -D, --scale int                 ► Scale of the FracMinHash (Scaled MinHash), or down-sample factor
                                  for Syncmers and Minimizer. (default 1)
  -B, --seq-name-filter strings   ► List of regular expressions for filtering out sequences by
                                  header/name, case ignored.
  -m, --split-min-ref int         ► Only splitting sequences >= X bp. (default 1000)
  -n, --split-number int          ► Chunk number for splitting sequences, incompatible with
                                  -s/--split-size.
  -l, --split-overlap int         ► Chunk overlap for splitting sequences. The default value will be
                                  set to k-1 unless you change it.
  -s, --split-size int            ► Chunk size for splitting sequences, incompatible with
                                  -n/--split-number.
  -S, --syncmer-s int             ► Length of the s-mer in Closed Syncmers.
```

## index

```
Construct a database from k-mer files

We build the index for k-mers (sketches) with a modified compact bit-sliced
signature index (COBS). We totally rewrite the algorithms, data structure,
and file format, and have improved the indexing and searching speed.

Input:
  The output directory generated by "kmcp compute".

Database size and searching accuracy:
  0. Use --dry-run to adjust parameters and check the final number of
     index files (#index-files) and the total file size.
  1. -f/--false-positive-rate: the default value 0.3 is enough for a
     query with tens of k-mers (see BIGSI/COBS paper).
     Small values could largely increase the size of the database.
  2. -n/--num-hash: large values could reduce the database size,
     at the cost of a slower searching speed. Values <=4 are recommended.
  3. The value of block size -b/--block-size better to be multiple of 64.
     The default value is:  (#unikFiles/#threads + 7) / 8 * 8
  4. Use flag -x/--block-sizeX-kmers-t, -8/--block-size8-kmers-t,
     and -1/--block-size1-kmers-t to separately create indexes for
     inputs with a huge number of k-mers, for precise control of
     database size.

References:
  1. COBS: https://arxiv.org/abs/1905.09624

Taxonomy data:
  1. No taxonomy data are included in the database.
  2. Taxonomy information are only needed in "profile" command.

Performance tips:
  1. The number of blocks (.uniki files) is better be smaller than
     or equal to the number of CPU cores for faster searching speed.
     We can set the flag -j/--threads to control the blocks number.
     When more threads (>= 1.3 * #blocks) are given, extra workers are
     automatically created.
  2. #threads files are simultaneously opened, and the max number
     of opened files is limited by the flag -F/--max-open-files.
     You may use a small value of -F/--max-open-files for
     hard disk drive storages.
  3. When the database is used in a new computer with more CPU cores,
     'kmcp search' could automatically scale to utilize as many cores
     as possible.

Next step:
  1. Use 'kmcp search' for searching.
  2. Use 'kmcp utils ref-info' to check the number of k-mers and FPR
     of each genome chunk.

Examples:
  1. For bacterial genomes:

       kmcp index -f 0.3 -n 1 -j 32 -I gtdb-k21-n10-l150/ -O gtdb.kmcp

  2. For viruses, use -x and -8 to control index size of the largest chunks:

       kmcp index -f 0.05 -n 1 -j 32 -x 100K -8 1M \
           -I genbank-viral-k21-n10-l150/ -O genbank-viral.kmcp

Usage:
  kmcp index [flags] [-f <fpr>] [-n <hashes>] [-j <blocks>] -I <compute output> -O <kmcp db>

Flags:
  -a, --alias string                 ► Database alias/name. (default: basename of --out-dir). You can
                                     also manually edit it in info file: ${outdir}/__db.yml.
  -b, --block-size int               ► Block size, better be multiple of 64 for large