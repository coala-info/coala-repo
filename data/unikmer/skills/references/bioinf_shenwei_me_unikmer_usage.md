[ ]
[ ]

[Skip to content](#usage)

unikmer - Toolkit for k-mer with taxonomic information

Usage

Initializing search

[GitHub](https://github.com/shenwei356/unikmer "Go to repository")

unikmer - Toolkit for k-mer with taxonomic information

[GitHub](https://github.com/shenwei356/unikmer "Go to repository")

* [Home](..)
* [Download](../download/)
* [ ]

  Usage

  [Usage](./)

  Table of contents
  + [summary](#summary)
  + [unikmer](#unikmer)
  + [count](#count)
  + [info](#info)
  + [num](#num)
  + [view](#view)
  + [dump](#dump)
  + [encode](#encode)
  + [decode](#decode)
  + [concat](#concat)
  + [inter](#inter)
  + [common](#common)
  + [union](#union)
  + [diff](#diff)
  + [sort](#sort)
  + [split](#split)
  + [tsplit](#tsplit)
  + [merge](#merge)
  + [head](#head)
  + [sample](#sample)
  + [grep](#grep)
  + [filter](#filter)
  + [rfilter](#rfilter)
  + [locate](#locate)
  + [map](#map)
* [More tools](https://github.com/shenwei356)

Table of contents

* [summary](#summary)
* [unikmer](#unikmer)
* [count](#count)
* [info](#info)
* [num](#num)
* [view](#view)
* [dump](#dump)
* [encode](#encode)
* [decode](#decode)
* [concat](#concat)
* [inter](#inter)
* [common](#common)
* [union](#union)
* [diff](#diff)
* [sort](#sort)
* [split](#split)
* [tsplit](#tsplit)
* [merge](#merge)
* [head](#head)
* [sample](#sample)
* [grep](#grep)
* [filter](#filter)
* [rfilter](#rfilter)
* [locate](#locate)
* [map](#map)

# Usage

## summary

| Category | Command | Function | Input | In.sorted | In.flag-consistency | Output | Out.sorted | Out.unique |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Counting | count | Generate k-mers (sketch) from FASTA/Q sequences | fastx | / | / | .unik | optional | optional |
| Information | info | Information of binary files | .unik | optional | no need | tsv | / | / |
|  | num | Quickly inspect the number of k-mers in binary files | .unik | optional | no need | tsv | / | / |
| Format conversion | view | Read and output binary format to plain text | .unik | optional | required | tsv | / | / |
|  | dump | Convert plain k-mer text to binary format | tsv | optional | / | .unik | optional | follow input |
|  | encode | Encode plain k-mer texts to integers | tsv | / | / | tsv | / | / |
|  | decode | Decode encoded integers to k-mer texts | tsv | / | / | tsv | / | / |
| Set operations | concat | Concatenate multiple binary files without removing duplicates | .unik | optional | required | .unik | optional | no |
|  | inter | Intersection of k-mers in multiple binary files | .unik | required | required | .unik | yes | yes |
|  | common | Find k-mers shared by most of the binary files | .unik | required | required | .unik | yes | yes |
|  | union | Union of k-mers in multiple binary files | .unik | optional | required | .unik | optional | yes |
|  | diff | Set difference of k-mers in multiple binary files | .unik | 1th file required | required | .unik | optional | yes |
| Split and merge | sort | Sort k-mers to reduce the file size and accelerate downstream analysis | .unik | optional | required | .unik | yes | optional |
|  | split | Split k-mers into sorted chunk files | .unik | optional | required | .unik | yes | optional |
|  | tsplit | Split k-mers according to TaxId | .unik | required | required | .unik | yes | yes |
|  | merge | Merge k-mers from sorted chunk files | .unik | required | required | .unik | yes | optional |
| Subset | head | Extract the first N k-mers | .unik | optional | required | .unik | follow input | follow input |
|  | sample | Sample k-mers from binary files | .unik | optional | required | .unik | follow input | follow input |
|  | grep | Search k-mers from binary files | .unik | optional | required | .unik | follow input | optional |
|  | filter | Filter out low-complexity k-mers | .unik | optional | required | .unik | follow input | follow input |
|  | rfilter | Filter k-mers by taxonomic rank | .unik | optional | required | .unik | follow input | follow input |
| Searching on genomes | locate | Locate k-mers in genome | .unik, fasta | optional | required | tsv | / | / |
|  | map | Mapping k-mers back to the genome and extract successive regions/subsequences | .unik, fasta | optional | required | bed/fasta | / | / |

## unikmer

```
unikmer - a versatile toolkit for k-mers with taxonomic information

unikmer is a toolkit for nucleic acid k-mer analysis, providing functions
including set operation on k-mers optional with TaxIds but without count
information.

K-mers are either encoded (k<=32) or hashed (k<=64) into 'uint64',
and serialized in binary file with the extension '.unik'.

TaxIds can be assigned when counting k-mers from genome sequences,
and LCA (Lowest Common Ancestor) is computed during set opertions
including computing union, intersection, set difference, unique and
repeated k-mers.

Version: v0.20.0

Author: Wei Shen <shenwei356@gmail.com>

Documents  : https://bioinf.shenwei.me/unikmer
Source code: https://github.com/shenwei356/unikmer

Dataset (optional):

  Manipulating k-mers with TaxIds needs taxonomy file from e.g.,
  NCBI Taxonomy database, please extract "nodes.dmp", "names.dmp",
  "delnodes.dmp" and "merged.dmp" from link below into ~/.unikmer/ ,
  ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz ,
  or some other directory, and later you can refer to using flag
  --data-dir or environment variable UNIKMER_DB.

  For GTDB, use 'taxonkit create-taxdump' to create NCBI-style
  taxonomy dump files, or download from:
    https://github.com/shenwei356/gtdb-taxonomy

  Note that TaxIds are represented using uint32 and stored in 4 or
  less bytes, all TaxIds should be in the range of [1, 4294967295].

Usage:
  unikmer [command]

Available Commands:
  autocompletion Generate shell autocompletion script (bash|zsh|fish|powershell)
  common         Find k-mers shared by most of the binary files
  concat         Concatenate multiple binary files without removing duplicates
  count          Generate k-mers (sketch) from FASTA/Q sequences
  decode         Decode encoded integer to k-mer text
  diff           Set difference of k-mers in multiple binary files
  dump           Convert plain k-mer text to binary format
  encode         Encode plain k-mer texts to integers
  filter         Filter out low-complexity k-mers (experimental)
  grep           Search k-mers from binary files
  head           Extract the first N k-mers
  info           Information of binary files
  inter          Intersection of k-mers in multiple binary files
  locate         Locate k-mers in genome
  map            Mapping k-mers back to the genome and extract successive regions/subsequences
  merge          Merge k-mers from sorted chunk files
  num            Quickly inspect the number of k-mers in binary files
  rfilter        Filter k-mers by taxonomic rank
  sample         Sample k-mers from binary files
  sort           Sort k-mers to reduce the file size and accelerate downstream analysis
  split          Split k-mers into sorted chunk files
  tsplit         Split k-mers according to taxid
  union          Union of k-mers in multiple binary files
  version        Print version information and check for update
  view           Read and output binary format to plain text

Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/home/shenwei/.unikmer")
  -h, --help                    help for unikmer
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information

Use "unikmer [command] --help" for more information about a command.
```

## count

```
Generate k-mers (sketch) from FASTA/Q sequences

K-mer:
  1. K-mer code (k<=32)
  2. Hashed k-mer (ntHash, k<=64)

K-mer sketches:
  1. Scaled MinHash
  2. Minimizer
  3. Closed Syncmer

Usage:
  unikmer count [flags] -K -k <k> -u -s [-t <taxid>] <seq files> -o <out prefix>

Flags:
  -K, --canonical                   only keep the canonical k-mers
      --circular                    circular genome
  -H, --hash                        save hash of k-mer, automatically on for k>32. This flag overides
                                    global flag -c/--compact
  -h, --help                        help for count
  -k, --kmer-len int                k-mer length
  -l, --linear                      output k-mers in linear order, duplicate k-mers are not removed
  -W, --minimizer-w int             minimizer window size
  -V, --more-verbose                print extra verbose information
  -o, --out-prefix string           out file prefix ("-" for stdout) (default "-")
  -T, --parse-taxid                 parse taxid from FASTA/Q header
  -r, --parse-taxid-regexp string   regular expression for passing taxid
  -d, --repeated                    only count duplicate k-mers, for removing singleton in FASTQ
  -D, --scale int                   scale/down-sample factor (default 1)
  -B, --seq-name-filter strings     list of regular expressions for filtering out sequences by
                                    header/name, case ignored.
  -s, --sort                        sort k-mers, this significantly reduce file size for k<=25. This
                                    flag overides global flag -c/--compact
  -S, --syncmer-s int               closed syncmer length
  -t, --taxid uint32                global taxid
  -u, --unique                      only count unique k-mers, which are not duplicate
```

## info

```
Information of binary files

Tips:
  1. For lots of small files (especially on SDD), use big value of '-j' to
     parallelize counting.

Usage:
  unikmer info [flags]

Aliases:
  info, stats

Flags:
  -a, --all                   all information, including number of k-mers
  -b, --basename              only output basename of files
  -h, --help                  help for info
  -o, --out-file string       out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
  -e, --skip-err              skip error, only show warning message
      --symbol-false string   smybol for false (default "✕")
      --symbol-true string    smybol for true (default "✓")
  -T, --tabular               output in machine-friendly tabular format
```

## num

```
Quickly inspect the number of k-mers in binary files

Attention:
  1. This command is designed to quickly inspect the number of k-mers in binary file,
  2. For non-sorted file, it returns '-1' unless switching on flag '-f/--force'.

Usage:
  unikmer num [flags]

Flags:
  -b, --basename          only output basename of files
  -n, --file-name         show file name
  -f, --force             read the whole file and count k-mers
  -h, --help              help for num
  -o, --out-file string   out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
```

## view

```
Read and output binary format to plain text

Attentions:
  1. The 'canonical/scaled/hashed' flags of all files should be consistent.
  2. Input files should ALL have or don't have taxid information.

Usage:
  unikmer view [flags]

Flags:
  -a, --fasta             output in FASTA format, with encoded integer as FASTA header
  -q, --fastq             output in FASTQ format, with encoded integer as FASTQ header
  -g, --genome strings    genomes in (gzipped) fasta file(s) for decoding hashed k-mers
  -h, --help              help for view
  -o, --out-file string   out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
  -n, --show-code         show encoded integer along with k-mer
  -N, --show-code-only    only show encoded integers, faster than cutting from result of -n/--show-cde
  -t, --show-taxid        show taxid
  -T, --show-taxid-only   show taxid only
```

## dump

```
Convert plain k-mer text to binary format

Attentions:
  1. Input should be one k-mer per line, or tab-delimited two columns
     with a k-mer and it's taxid.
  2. You can also assign a global taxid with flag -t/--taxid.

Usage:
  unikmer dump [flags]

Flags:
  -K, --canonical           save the canonical k-mers
  -O, --canonical-only      only save the canonical k-mers. This flag overides -K/--canonical
  -H, --hash                save hash of k-mer, automatically on for k>32. This flag overides global
                            flag -c/--compact
      --hashed              giving hash values of k-mers, This flag overides global flag -c/--compact
  -h, --help                help for dump
  -k, --kmer-len int        k-mer length
  -o, --out-prefix string   out file prefix ("-" for stdout) (default "-")
  -s, --sorted              input k-mers are sorted
  -t, --taxid uint32        global taxid
  -u, --unique              remove duplicate k-mers
```

## encode

```
Encode plain k-mer texts to integers

Usage:
  unikmer encode [flags]

Flags:
  -a, --all               output all data: orginial k-mer, parsed k-mer, encoded integer, encode bits
  -K, --canonical         keep the canonical k-mers
  -H, --hash              save hash of k-mer, automatically on for k>32
  -h, --help              help for encode
  -o, --out-file string   out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
```

## decode

```
Decode encoded integers to k-mer texts

Usage:
  unikmer decode [flags]

Flags:
  -a, --all               output all data: encoded integer, decoded k-mer
  -h, --help              help for decode
  -k, --kmer-len int      k-mer length
  -o, --out-file string   out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
```

## concat

```
Concatenate multiple binary files without removing duplicates

Attentions:
  1. The 'canonical/scaled/hashed' flags of all files should be consistent.
  2. Input files should ALL have or don't have taxid information.

Usage:
  unikmer concat [flags]

Flags:
  -h, --help                help for concat
  -n, --number int          number of k-mers (default -1)
  -o, --out-prefix string   out file prefix ("-" for stdout) (default "-")
  -s, --sorted              input k-mers are sorted
  -t, --taxid uint32        global taxid
```

## inter

```
Intersection of k-mers in multiple binary files

Attentions:
  0. All input files should be sorted, and output file 