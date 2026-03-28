# unikmer CWL Generation Report

## unikmer_autocompletion

### Tool Description
Generate shell autocompletion script

### Metadata
- **Docker Image**: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/unikmer
- **Package**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Total Downloads**: 4.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/shenwei356/unikmer
- **Stars**: N/A
### Original Help Text
```text
Generate shell autocompletion script

Supported shell: bash|zsh|fish|powershell

Bash:

    # generate completion shell
    unikmer autocompletion --shell bash

    # configure if never did.
    # install bash-completion if the "complete" command is not found.
    echo "for bcfile in ~/.bash_completion.d/* ; do source \$bcfile; done" >> ~/.bash_completion
    echo "source ~/.bash_completion" >> ~/.bashrc

Zsh:

    # generate completion shell
    unikmer autocompletion --shell zsh --file ~/.zfunc/_unikmer

    # configure if never did
    echo 'fpath=( ~/.zfunc "${fpath[@]}" )' >> ~/.zshrc
    echo "autoload -U compinit; compinit" >> ~/.zshrc

fish:

    unikmer autocompletion --shell fish --file ~/.config/fish/completions/unikmer.fish

Usage:
  unikmer autocompletion [flags] 

Flags:
      --file string    autocompletion file (default "/root/.bash_completion.d/unikmer.sh")
  -h, --help           help for autocompletion
      --shell string   autocompletion type (bash|zsh|fish|powershell) (default "bash")

Global Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/root/.unikmer")
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information
```


## unikmer_common

### Tool Description
Find k-mers shared by most of the binary files

### Metadata
- **Docker Image**: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/unikmer
- **Package**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Validation**: PASS

### Original Help Text
```text
Find k-mers shared by most of the binary files

This command is similar to "unikmer inter" but with a looser restriction,
k-mers shared by some number/proportion of multiple files are outputted.

Attentions:
  0. All input files should be sorted, and output file is sorted.
  1. The 'canonical/scaled/hashed' flags of all files should be consistent.
  2. Taxid information could be inconsistent when using flag --mix-taxid.
  3. At most 65535 input files allowed.
  
Tips:
  1. For comparing TWO files with really huge number of k-mers,
     you can use 'unikmer sort -u -m 100M' for each file,
     and then 'unikmer merge -' from them.
  2. Put the smallest file in the beginning to reduce memory usage.

Usage:
  unikmer common [flags] 

Flags:
  -h, --help                help for common
  -m, --mix-taxid           allow part of files being whithout taxids
  -n, --number int          minimum number of files that share a k-mer (overides -p/--proportion)
  -o, --out-prefix string   out file prefix ("-" for stdout) (default "-")
  -p, --proportion float    minimum proportion of files that share a k-mer (default 1)

Global Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/root/.unikmer")
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information
```


## unikmer_concat

### Tool Description
Concatenate multiple binary files without removing duplicates

### Metadata
- **Docker Image**: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/unikmer
- **Package**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Validation**: PASS

### Original Help Text
```text
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

Global Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/root/.unikmer")
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information
```


## unikmer_count

### Tool Description
Generate k-mers (sketch) from FASTA/Q sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/unikmer
- **Package**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Validation**: PASS

### Original Help Text
```text
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

Global Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/root/.unikmer")
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information
```


## unikmer_decode

### Tool Description
Decode encoded integer to k-mer text

### Metadata
- **Docker Image**: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/unikmer
- **Package**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Validation**: PASS

### Original Help Text
```text
Decode encoded integer to k-mer text

Usage:
  unikmer decode [flags] 

Flags:
  -a, --all               output all data: encoded integer, decoded k-mer
  -h, --help              help for decode
  -k, --kmer-len int      k-mer length
  -o, --out-file string   out file ("-" for stdout, suffix .gz for gzipped out) (default "-")

Global Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/root/.unikmer")
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information
```


## unikmer_diff

### Tool Description
Set difference of k-mers in multiple binary files

### Metadata
- **Docker Image**: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/unikmer
- **Package**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Validation**: PASS

### Original Help Text
```text
Set difference of k-mers in multiple binary files

Attentions:
  0. The first file should be sorted.
  1. The 'canonical/scaled/hashed' flags of all files should be consistent.
  2. By default taxids in the 2nd and later files are ignored.
  3. You can switch on flag -t/--compare-taxid, and input
     files should ALL have or don't have taxid information.
     A same k-mer found but query taxid equals to target taxid,
     or query taxid is ancester of target taxid, this k-mer remains.

Tips:
  1. Increasing threads number (-j/--threads) to accelerate computation
     when dealing with lots of files, in cost of more memory occupation.

Usage:
  unikmer diff [flags] 

Flags:
  -t, --compare-taxid       take taxid into consideration. type unikmer "diff -h" for detail
  -h, --help                help for diff
  -o, --out-prefix string   out file prefix ("-" for stdout) (default "-")
  -s, --sort                sort k-mers, this significantly reduce file size for k<=25. This flag
                            overides global flag -c/--compact

Global Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/root/.unikmer")
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information
```


## unikmer_dump

### Tool Description
Convert plain k-mer text to binary format

### Metadata
- **Docker Image**: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/unikmer
- **Package**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Validation**: PASS

### Original Help Text
```text
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

Global Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/root/.unikmer")
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information
```


## unikmer_encode

### Tool Description
Encode plain k-mer texts to integers

### Metadata
- **Docker Image**: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/unikmer
- **Package**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Validation**: PASS

### Original Help Text
```text
Encode plain k-mer texts to integers

Usage:
  unikmer encode [flags] 

Flags:
  -a, --all               output all data: orginial k-mer, parsed k-mer, encoded integer, encode bits
  -K, --canonical         keep the canonical k-mers
  -H, --hash              save hash of k-mer, automatically on for k>32
  -h, --help              help for encode
  -o, --out-file string   out file ("-" for stdout, suffix .gz for gzipped out) (default "-")

Global Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/root/.unikmer")
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information
```


## unikmer_filter

### Tool Description
Filter out low-complexity k-mers (experimental)

### Metadata
- **Docker Image**: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/unikmer
- **Package**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Validation**: PASS

### Original Help Text
```text
Filter out low-complexity k-mers (experimental)

Attentions:
  1. This command only detects single base repeat now.

Usage:
  unikmer filter [flags] 

Flags:
  -h, --help                help for filter
  -v, --invert              invert result, i.e., output low-complexity k-mers
  -o, --out-prefix string   out file prefix ("-" for stdout) (default "-")
  -d, --penalty-d int       penalty for different bases (default 1)
  -s, --penalty-s int       penalty for successive bases (default 3)
  -t, --threshold int       penalty threshold for filter, higher is stricter (default 15)
  -w, --window int          window size for checking penalty (default 7)

Global Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/root/.unikmer")
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information
```


## unikmer_grep

### Tool Description
Search k-mers from binary files

### Metadata
- **Docker Image**: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/unikmer
- **Package**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Validation**: PASS

### Original Help Text
```text
Search k-mers from binary files

Attentions:
  1. The 'canonical/scaled/hashed' flags of all files should be consistent.
  2. Canonical k-mers are used and outputted.
  3. Input files should ALL have or don't have taxid information.

Tips:
  1. Increase value of '-j' for better performance when dealing with
     lots of files, especially on SDD.
  2. For searching using binary .unik file, use 'unikmer inter --mix-taxid',
     which is faster than 'unikmer grep' in single-thread mode.

Usage:
  unikmer grep [flags] 

Flags:
  -D, --degenerate                query k-mers contains degenerate base
      --force                     overwrite output directory
  -h, --help                      help for grep
  -v, --invert-match              invert the sense of matching, to select non-matching records
  -m, --multiple-outfiles         write results into separated files for multiple input files
  -O, --out-dir string            output directory (default "unikmer-grep")
  -o, --out-prefix string         out file prefix ("-" for stdout) (default "-")
  -S, --out-suffix string         output suffix (default ".grep")
  -q, --query strings             query k-mers/taxids (multiple values delimted by comma supported)
  -f, --query-file strings        query file (one k-mer/taxid per line)
  -t, --query-is-taxid            queries are taxids
  -F, --query-unik-file strings   query file in .unik format
  -d, --repeated                  only print duplicate k-mers
  -s, --sort                      sort k-mers, this significantly reduce file size for k<=25. This flag
                                  overides global flag -c/--compact
  -u, --unique                    remove duplicate k-mers

Global Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/root/.unikmer")
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information
```


## unikmer_head

### Tool Description
Extract the first N k-mers

### Metadata
- **Docker Image**: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/unikmer
- **Package**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Validation**: PASS

### Original Help Text
```text
Extract the first N k-mers

Attentions:
  1. The 'canonical/scaled/hashed' flags of all files should be consistent.
  2. Input files should ALL have or don't have taxid information.

Usage:
  unikmer head [flags] 

Flags:
  -h, --help                help for head
  -n, --number int          number of k-mers to extract (default 10)
  -o, --out-prefix string   out file prefix ("-" for stdout) (default "-")

Global Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/root/.unikmer")
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information
```


## unikmer_info

### Tool Description
Information of binary files

### Metadata
- **Docker Image**: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/unikmer
- **Package**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Validation**: PASS

### Original Help Text
```text
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

Global Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/root/.unikmer")
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information
```


## unikmer_inter

### Tool Description
Intersection of k-mers in multiple binary files

### Metadata
- **Docker Image**: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/unikmer
- **Package**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Validation**: PASS

### Original Help Text
```text
Intersection of k-mers in multiple binary files

Attentions:
  0. All input files should be sorted, and output file is sorted.
  1. The 'canonical/scaled/hashed' flags of all files should be consistent.
  2. Taxid information could be inconsistent when using flag --mix-taxid.
  
Tips:
  1. For comparing TWO files with really huge number of k-mers,
     you can use 'unikmer sort -u -m 100M' for each file,
     and then 'unikmer merge -' from them.
  2. Put the smallest file in the beginning to reduce memory usage.

Usage:
  unikmer inter [flags] 

Flags:
  -h, --help                help for inter
  -m, --mix-taxid           allow part of files being whithout taxids
  -o, --out-prefix string   out file prefix ("-" for stdout) (default "-")

Global Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/root/.unikmer")
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information
```


## unikmer_locate

### Tool Description
Locate k-mers in genome

### Metadata
- **Docker Image**: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/unikmer
- **Package**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Validation**: PASS

### Original Help Text
```text
Locate k-mers in genome

Attention:
  0. All files should have the 'canonical' flag.
  1. The 'canonical/scaled/hashed' flags of all files should be consistent.
  2. Output is BED6 format.
  3. When using experimental flag --circular, leading subsequence of k-1 bp
     is appending to end of sequence. End position of k-mers that crossing
     sequence end would be greater than sequence length.

Usage:
  unikmer locate [flags] 

Flags:
      --circular                  circular genome. type "unikmer locate -h" for details
  -g, --genome strings            genomes in (gzipped) fasta file(s)
  -h, --help                      help for locate
  -o, --out-prefix string         out file prefix ("-" for stdout) (default "-")
  -B, --seq-name-filter strings   list of regular expressions for filtering out sequences by
                                  header/name, case ignored

Global Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/root/.unikmer")
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information
```


## unikmer_map

### Tool Description
Mapping k-mers back to the genome and extract successive regions/subsequences

### Metadata
- **Docker Image**: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/unikmer
- **Package**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Validation**: PASS

### Original Help Text
```text
Mapping k-mers back to the genome and extract successive regions/subsequences

Attention:
  0. By default, only unique-mapped k-mers are considered.
     You can use -M/--allow-multiple-mapped-kmerss to allow mutiple-mapped k-mers.
  1. The 'canonical/scaled/hashed' flags of all files should be consistent.
  2. Default output is in BED3 format, with left-closed and right-open
     0-based interval.
  3. When using flag --circular, end position of subsequences that 
     crossing genome sequence end would be greater than sequence length.

Usage:
  unikmer map [flags] 

Aliases:
  map, uniqs

Flags:
  -M, --allow-multiple-mapped-kmers    allow multiple mapped k-mers
      --circular                       circular genome. type "unikmer uniqs -h" for details
  -g, --genome strings                 genomes in (gzipped) fasta file(s)
  -h, --help                           help for map
  -X, --max-gap-num int                max number of gaps (consecutive unmapped k-mers)
  -x, --max-gap-size int               max gap size (the number of consecutive unmapped k-mers)
  -m, --min-len int                    minimum length of subsequence (default 200)
  -o, --out-prefix string              out file prefix ("-" for stdout) (default "-")
  -a, --output-fasta                   output fasta format instead of BED3
  -B, --seq-name-filter strings        list of regular expressions for filtering out sequences by
                                       header/name, case ignored
  -W, --seqs-in-a-file-as-one-genome   treat seqs in a genome file as one genome

Global Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/root/.unikmer")
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information
```


## unikmer_merge

### Tool Description
Merge k-mers from sorted chunk files

### Metadata
- **Docker Image**: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/unikmer
- **Package**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Validation**: PASS

### Original Help Text
```text
Merge k-mers from sorted chunk files

Attentions:
  1. The 'canonical/scaled/hashed' flags of all files should be consistent.
  2. Input files should ALL have or don't have taxid information.
  3. Input files should be sorted.
  
Tips:
  1. If you don't need to compute unique or repeated k-mers, 
     use 'unikmer concat -s', which is faster.

Usage:
  unikmer merge [flags] 

Flags:
      --force                overwrite tmp dir
  -h, --help                 help for merge
  -D, --is-dir               intput files are directory containing chunk files
  -k, --keep-tmp-dir         keep tmp dir
  -M, --max-open-files int   max number of open files (default 400)
  -o, --out-prefix string    out file prefix ("-" for stdout) (default "-")
  -p, --pattern string       chunk file pattern (regular expression) (default "^chunk_\\d+\\.unik$")
  -d, --repeated             only print duplicate k-mers
  -t, --tmp-dir string       directory for intermediate files (default "./")
  -u, --unique               remove duplicate k-mers

Global Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/root/.unikmer")
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information
```


## unikmer_num

### Tool Description
Quickly inspect the number of k-mers in binary files

### Metadata
- **Docker Image**: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/unikmer
- **Package**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Validation**: PASS

### Original Help Text
```text
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

Global Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/root/.unikmer")
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information
```


## unikmer_rfilter

### Tool Description
Filter k-mers by taxonomic rank

### Metadata
- **Docker Image**: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/unikmer
- **Package**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Validation**: PASS

### Original Help Text
```text
Filter k-mers by taxonomic rank

Attentions:
  1. Flag -L/--lower-than and -H/--higher-than are exclusive, and can be
     used along with -E/--equal-to which values can be different.
  2. A list of pre-ordered ranks is in ~/.unikmer/ranks.txt, you can use
     your list by -r/--rank-file, the format specification is below.
  3. All ranks in taxonomy database should be defined in rank file.
  4. Ranks can be removed with black list via -B/--black-list.
  5. TaxIds with no rank can be optionally discarded by -N/--discard-noranks.
  6. But when filtering with -L/--lower-than, you can use
    -n/--save-predictable-norank to save some special ranks without order,
    where rank of the closest higher node is still lower than rank cutoff.

Rank file:
  1. Blank lines or lines starting with "#" are ignored.
  2. Ranks are in decending order and case ignored.
  3. Ranks with same order should be in one line separated with comma (",", no space).
  4. Ranks without order should be assigned a prefix symbol "!" for each rank.

Usage:
  unikmer rfilter [flags] 

Flags:
  -B, --black-list strings        black list of ranks to discard, e.g., '"no rank", "clade"'
  -N, --discard-noranks           discard ranks without order, type "unikmer filter --help" for details
  -R, --discard-root              discard root taxid, defined by --root-taxid
  -E, --equal-to strings          output taxIDs with rank equal to some ranks, multiple values can be
                                  separated with comma "," (e.g., -E "genus,species"), or give multiple
                                  times (e.g., -E genus -E species)
  -h, --help                      help for rfilter
  -H, --higher-than string        output ranks higher than a rank, exclusive with --lower-than
      --list-order                list defined ranks in order
      --list-ranks                list ordered ranks in taxonomy database
  -L, --lower-than string         output ranks lower than a rank, exclusive with --higher-than
  -o, --out-prefix string         out file prefix ("-" for stdout) (default "-")
  -r, --rank-file string          user-defined ordered taxonomic ranks, type "unikmer rfilter --help"
                                  for details
      --root-taxid uint32         root taxid (default 1)
  -n, --save-predictable-norank   do not discard some special ranks without order when using -L, where
                                  rank of the closest higher node is still lower than rank cutoff

Global Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/root/.unikmer")
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information
```


## unikmer_sample

### Tool Description
Sample k-mers from binary files.

### Metadata
- **Docker Image**: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/unikmer
- **Package**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Validation**: PASS

### Original Help Text
```text
Sample k-mers from binary files.

The Sampling type is fixed sampling.

Attentions:
  1. The 'canonical/scaled/hashed' flags of all files should be consistent.
  2. Input files should ALL have or don't have taxid information.

Usage:
  unikmer sample [flags] 

Flags:
  -h, --help                help for sample
  -o, --out-prefix string   out file prefix ("-" for stdout) (default "-")
  -s, --start int           start location (default 1)
  -w, --window int          window size (default 1)

Global Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/root/.unikmer")
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information
```


## unikmer_sort

### Tool Description
Sort k-mers to reduce the file size and accelerate downstream analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/unikmer
- **Package**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Validation**: PASS

### Original Help Text
```text
Sort k-mers to reduce the file size and accelerate downstream analysis

Attentions:
  1. The 'canonical/scaled/hashed' flags of all files should be consistent.
  2. Input files should ALL have or don't have taxid information.

Notes:
  1. When sorting from large number of files, this command is equivalent to
     'unikmer split' + 'unikmer merge'.

Tips:
  1. You can use '-m/--chunk-size' to limit memory usage, and chunk file size
     depends on k-mers and file save mode (sorted/compact/normal).
  2. Increasing value of -j/--threads can accelerates splitting stage,
     in cost of more memory occupation.
  3. For sorted input files, the memory usage is very low and speed is fast.

Usage:
  unikmer sort [flags] 

Flags:
  -m, --chunk-size string    split input into chunks of N k-mers, supports K/M/G suffix, type "unikmer
                             sort -h" for detail
      --force                overwrite tmp dir
  -h, --help                 help for sort
  -k, --keep-tmp-dir         keep tmp dir
  -M, --max-open-files int   max number of open files (default 400)
  -o, --out-prefix string    out file prefix ("-" for stdout) (default "-")
  -d, --repeated             only print duplicate k-mers
  -t, --tmp-dir string       directory for intermediate files (default "./")
  -u, --unique               remove duplicate k-mers

Global Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/root/.unikmer")
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information
```


## unikmer_split

### Tool Description
Split k-mers into sorted chunk files

### Metadata
- **Docker Image**: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/unikmer
- **Package**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Validation**: PASS

### Original Help Text
```text
Split k-mers into sorted chunk files

Attentions:
  1. The 'canonical/scaled/hashed' flags of all files should be consistent.
  2. Input files should ALL have or don't have taxid information.
  
Tips:
  1. You can use '-m/--chunk-size' to limit memory usage, and chunk file size
     depends on k-mers and file save mode (sorted/compact/normal).
  2. Increasing value of -j/--threads can accelerates splitting stage,
     in cost of more memory occupation.
  3. For sorted input files, the memory usage is very low and speed is fast.

Usage:
  unikmer split [flags] 

Flags:
  -m, --chunk-size string   split input into chunks of N k-mers, supports K/M/G suffix, type "unikmer
                            sort -h" for detail
      --force               overwrite output directory
  -h, --help                help for split
  -O, --out-dir string      output directory
  -d, --repeated            split for further printing duplicate k-mers
  -u, --unique              split for further removing duplicate k-mers

Global Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/root/.unikmer")
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information
```


## unikmer_tsplit

### Tool Description
Split k-mers according to taxid

### Metadata
- **Docker Image**: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/unikmer
- **Package**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Validation**: PASS

### Original Help Text
```text
Split k-mers according to taxid

Attentions:
  1. The 'canonical/scaled/hashed' flags of all files should be consistent.
  2. Input files should ALL have taxid information.
  3. Input files should be sorted using 'unikmer sort'.
  4. All k-mers will loaded into RAM, for big input files,
     you can 'split' them first, 'tsplit' and then 'concat'
     for every taxid.
  
Tips:
  1. Increasing value of -j/--threads can accelerates splitting stage,
     in cost of more memory occupation.

Usage:
  unikmer tsplit [flags] 

Flags:
      --force               overwrite output directory
  -h, --help                help for tsplit
  -O, --out-dir string      output directory
  -o, --out-prefix string   out file prefix (default "tsplit")

Global Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/root/.unikmer")
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information
```


## unikmer_union

### Tool Description
Union of k-mers in multiple binary files

### Metadata
- **Docker Image**: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/unikmer
- **Package**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Validation**: PASS

### Original Help Text
```text
Union of k-mers in multiple binary files

Attentions:
  1. The 'canonical/scaled/hashed' flags of all files should be consistent.
  2. Input files should ALL have or don't have taxid information.

Tips:
  1. 'unikmer sort -u' is slightly faster in cost of more memory usage.
  2. For really huge number of k-mers, you can use 'unikmer sort -m 100M -u'.
  3. For large number of sorted .unik files, you can use 'unikmer merge'.

Usage:
  unikmer union [flags] 

Flags:
  -h, --help                help for union
  -o, --out-prefix string   out file prefix ("-" for stdout) (default "-")
  -s, --sort                sort k-mers, this significantly reduce file size for k<=25. This flag
                            overides global flag -c/--compact

Global Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/root/.unikmer")
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information
```


## unikmer_view

### Tool Description
Read and output binary format to plain text

### Metadata
- **Docker Image**: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
- **Homepage**: https://github.com/shenwei356/unikmer
- **Package**: https://anaconda.org/channels/bioconda/packages/unikmer/overview
- **Validation**: PASS

### Original Help Text
```text
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

Global Flags:
  -c, --compact                 write compact binary file with little loss of speed
      --compression-level int   compression level (default -1)
      --data-dir string         directory containing NCBI Taxonomy files, including nodes.dmp,
                                names.dmp, merged.dmp and delnodes.dmp (default "/root/.unikmer")
  -I, --ignore-taxid            ignore taxonomy information
  -i, --infile-list string      file of input files list (one file per line), if given, they are
                                appended to files from cli arguments
      --max-taxid uint32        for smaller TaxIds, we can use less space to store TaxIds. default value
                                is 1<<32-1, that's enough for NCBI Taxonomy TaxIds (default 4294967295)
  -C, --no-compress             do not compress binary file (not recommended)
      --nocheck-file            do not check binary file, when using process substitution or named pipe
  -j, --threads int             number of CPUs to use (default 4)
      --verbose                 print verbose information
```


## Metadata
- **Skill**: generated
