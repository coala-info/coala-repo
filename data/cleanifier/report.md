# cleanifier CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| cleanifier_download | Not completed | needs network access and downloads the 6.8 GB (probabilistic) or 13.9 GB (exact) human index from Zenodo, too large for this test. |
| cleanifier_filter | PASS |  |
| cleanifier_index | PASS |  |
| cleanifier_info | Failed | tool bug: cleanifier info imports its module as '..fastcash_info' relative to the cleanifier package, so every run stops with 'attempted relative import beyond top-level package'. |

## cleanifier_index

### Tool Description
build index of all species' FASTA/Q files

### Metadata
- **Docker Image**: quay.io/biocontainers/cleanifier:1.2.0--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rahmannlab/cleanifier
- **Package**: https://anaconda.org/channels/bioconda/packages/cleanifier/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cleanifier/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-11-29
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: cleanifier [options] index [-h] [--cfg CFG] [--print_config [=flags]]
                                  --index INDEX
                                  [--files FASTA/Q [FASTA/Q ...]] [-n INT]
                                  (--mask MASK | -k INT) [--bucketsize INT]
                                  [--fill FLOAT] [--subtables INT]
                                  [--threads-read THREADS_READ]
                                  [--threads-split THREADS_SPLIT]
                                  [--shortcutbits INT] [--hashfunctions SPEC]
                                  [--aligned]
                                  [--statistics {none,summary,details,full}]
                                  [--maxwalk INT] [--maxfailures INT]
                                  [--walkseed INT] [--filter] [--fpr INT]
                                  [--windowsize WINDOWSIZE]

build index of all species' FASTA/Q files

default config file locations:
  ['/usr/local/lib/python3.13/site-
  packages/cleanifier/cleanifier/config/index.yaml', 'config/index.yaml',
  'index.yaml'], Note: default values below are the ones overridden by the
  contents of: /usr/local/lib/python3.13/site-
  packages/cleanifier/cleanifier/config/index.yaml

options:
  -h, --help            Show this help message and exit.
  --cfg, --config CFG   Path to a configuration file.
  --print_config [=flags]
                        Print the configuration after applying all other
                        arguments and exit. The optional flags customizes the
                        output and are one or more keywords separated by
                        comma. The supported flags are: comments,
                        skip_default, skip_null.
  --index INDEX         name of the resulting index (.hash and .info output)
                        (required)
  --files, -H FASTA/Q [FASTA/Q ...]
                        FASTA/Q file(s) for the genomes that should be
                        removed. (default: null)
  -n, --nobjects INT    number of k-mers to be stored in hash table
                        (2_512_390_070 for human T2T and k=31) (required,
                        type: int)
  --mask MASK           gapped k-mer mask (quoted string like '#__##_##__#')
                        (type: str, default: null)
  -k, --kmersize INT    k-mer size (type: int, default: null)
  --bucketsize, -b, -p INT
                        bucket size, i.e. number of elements in a bucket
                        (required, type: int, default: 4)
  --fill FLOAT          desired fill rate (< 1.0) of the hash table (type:
                        float, default: 0.85)
  --subtables INT       number of subtables used; subtables+1 threads are used
                        (type: int, default: null)
  --threads-read THREADS_READ
                        Number of reader threads (type: int, default: null)
  --threads-split THREADS_SPLIT
                        Number of splitter threads (type: int, default: null)
  --shortcutbits, -S INT
                        number of shortcut bits (0,1,2) (type: from_0_to_2,
                        default: 0)
  --hashfunctions, --functions SPEC
                        hash functions: 'random', or 'func0:func1:func2:func3'
                        (default: random)
  --aligned             use power-of-two-bits-aligned buckets (slightly
                        faster, but larger) (default: False)
  --statistics, --stats {none,summary,details,full}
                        level of detail for statistics (none, summary,
                        details, full (all subtables)) (default: summary)
  --maxwalk INT         maximum length of random walk through hash table
                        before failing (type: int, default: 500)
  --maxfailures INT     continue even after this many failures; forever: -1]
                        (type: int, default: 0)
  --walkseed INT        seed for random walks while inserting elements (type:
                        int, default: 42)
  --filter              use cuckoo filter instead of cuckoo hash table
                        (default: False)
  --fpr INT             integer k to build a cuckoo filter with an FPR of
                        1/2^k (only for --filter) (type: int, default: 14)
  --windowsize WINDOWSIZE
                        windowsize of cuckoo filter (only for --filter) (type:
                        int, default: 2)
```


## cleanifier_filter

### Tool Description
remove all reads that belong to the specified species

### Metadata
- **Docker Image**: quay.io/biocontainers/cleanifier:1.2.0--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rahmannlab/cleanifier
- **Package**: https://anaconda.org/channels/bioconda/packages/cleanifier/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cleanifier/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-11-29
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: cleanifier [options] filter [-h] [--cfg CFG] [--print_config [=flags]]
                                   --fastq FASTQ [FASTQ ...]
                                   [--pairs FASTQ [FASTQ ...]] --index INDEX
                                   [--shared] [--count | --out PREFIX]
                                   [--keep-host] [--threads INT]
                                   [--compression {none,gz,bz2,xz}]
                                   [--compression-threads COMPRESSION_THREADS]
                                   [--compression-level COMPRESSION_LEVEL]
                                   [--sensitive] [--threshold INT]
                                   [--prefetchlevel INT]
                                   [--prefetch-offset INT] [--buffersize INT]
                                   [--progress]

remove all reads that belong to the specified species

default config file locations:
  ['/usr/local/lib/python3.13/site-
  packages/cleanifier/cleanifier/config/filter.yaml', 'config/filter.yaml',
  'filter.yaml'], Note: default values below are the ones overridden by the
  contents of: /usr/local/lib/python3.13/site-
  packages/cleanifier/cleanifier/config/filter.yaml

options:
  -h, --help            Show this help message and exit.
  --cfg, --config CFG   Path to a configuration file.
  --print_config [=flags]
                        Print the configuration after applying all other
                        arguments and exit. The optional flags customizes the
                        output and are one or more keywords separated by
                        comma. The supported flags are: comments,
                        skip_default, skip_null.
  --fastq, -q FASTQ [FASTQ ...]
                        single or first paired-end FASTQ file to filter
                        (required)
  --pairs, -p FASTQ [FASTQ ...]
                        second paired-end FASTQ file (only together with
                        --fastq) (default: null)
  --index INDEX         existing index (required)
  --shared              index should be loaded via shared memory (default:
                        False)
  --count               only count reads or read pairs for each class, do not
                        output any FASTQ (default: False)
  --out, -o, --prefix PREFIX
                        prefix for output files (directory and name prefix)
                        (default: null)
  --keep-host           output both the filtered FASTQ file and a file with
                        the removed host reads; only together with --out
                        (default: False)
  --threads, -T, -j INT
                        maximum number of worker threads for classification
                        (type: int, default: 8)
  --compression {none,gz,bz2,xz}
                        compression of output files (default: null)
  --compression-threads COMPRESSION_THREADS
                        maximum number of compression threads (type: int,
                        default: 2)
  --compression-level COMPRESSION_LEVEL
                        compression level; supported levels depend on
                        compression type (1-11 for gz, 1-9 for bz2 and 0-9 for
                        xz) (type: int, default: 1)
  --sensitive           sensitive (slower) mode that queries all k-mers
                        (default: False)
  --threshold INT       threshold at which reads are filtered (type: float,
                        default: 0.5)
  --prefetchlevel INT   amount of prefetching: none (0), second bucket (1),
                        all buckets (2); supported only for hash table (type:
                        from_0_to_2, default: 0)
  --prefetch-offset INT
                        position to prefetch in advance (> 0) (type: int,
                        default: 8)
  --buffersize INT      io buffersize; in powers of two default 16 (2^16
                        bytes, fast on SDDs); increase on HDD to e.g. 24
                        (type: int, default: 16)
  --progress, -P        show progress (default: False)
```


## cleanifier_info

### Tool Description
get information about a hash table and dump its data

### Metadata
- **Docker Image**: quay.io/biocontainers/cleanifier:1.2.0--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rahmannlab/cleanifier
- **Package**: https://anaconda.org/channels/bioconda/packages/cleanifier/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cleanifier/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-11-29
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: cleanifier [options] info [-h] [--outprefix OUTPREFIX]
                                 [--format {native,packed,text,txt,dna}]
                                 [--filterexpression EXPRESSION]
                                 [--compilefilter FUNCTIONPATH [PARAM ...]]
                                 [--statistics LEVEL] [--showvalues INT]
                                 INPUTPREFIX

get information about a hash table and dump its data

positional arguments:
  INPUTPREFIX           file name of existing hash table (without extension
                        .hash or .info) (required)

options:
  -h, --help            Show this help message and exit.
  --outprefix, --export, -o, -e OUTPREFIX
                        file name prefix of exported data, extended by
                        .{key,chc.val}.{txt,data}. (default: null)
  --format {native,packed,text,txt,dna}
                        output format [native (default): use native integer
                        arrays (uint{8,16,32,64}); packed: use bit-backed
                        arrays; text: use text files (one integer per line);
                        dna: text file with DNA k-mers (one k-mer per line)]
                        (default: null)
  --filterexpression, -f EXPRESSION
                        filter expression using variables `key`, `choice`,
                        `value`, e.g. '(choice != 0) and (value & 3 == 3)'.
                        Output (but not statistics) will be restricted to
                        items for which the filter expression is true.
                        (default: null)
  --compilefilter, -c FUNCTIONPATH [PARAM ...]
                        string specifying `path/module::compiler_func` that
                        will be called with the valueset, the appinfo and
                        given additional parameters (PARAM) to compile a
                        filter function that takes key, choice and value as
                        arguments. (default: null)
  --statistics LEVEL    level of detail of statistics to be shown (none,
                        summary, details, full) (default: summary)
  --showvalues INT      number of values to show in value statistics (none,
                        all, INT) (default: 1023)
```


## cleanifier_download

### Tool Description
Download the human index from Zenodo.

### Metadata
- **Docker Image**: quay.io/biocontainers/cleanifier:1.2.0--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rahmannlab/cleanifier
- **Package**: https://anaconda.org/channels/bioconda/packages/cleanifier/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cleanifier/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-11-29
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: cleanifier [options] download [-h] [--dir DIR] [--version VERSION]
                                     [--checksum]

Download the human index from Zenodo.

options:
  -h, --help         Show this help message and exit.
  --dir DIR          directory name to store the index; default current
                     directory (default: null)
  --version VERSION  index version (probabilistic or exact); default
                     probabilistic. (default: probabilistic)
  --checksum         check the checksum of the downloaded file, might take
                     some time (default: False)
```


## Metadata
- **Skill**: generated

