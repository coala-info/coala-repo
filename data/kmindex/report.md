# kmindex CWL Generation Report

## kmindex_build

### Tool Description
Build index.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmindex:0.6.0--h668145b_1
- **Homepage**: https://github.com/tlemane/kmindex
- **Package**: https://anaconda.org/channels/bioconda/packages/kmindex/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kmindex/overview
- **Total Downloads**: 1.2K
- **Last updated**: 2025-12-16
- **GitHub**: https://github.com/tlemane/kmindex
- **Stars**: N/A
### Original Help Text
```text
kmindex build v0.6.0

DESCRIPTION
  Build index.

USAGE
  kmindex build -i/--index <STR> -f/--fof <STR> -d/--run-dir <STR> -r/--register-as <STR> [--from <STR>] 
                [--km-path <STR>] [-k/--kmer-size <INT>] [-m/--minim-size <INT>] 
                [--hard-min <INT>] [--nb-partitions <INT>] [--bloom-size <INT>] 
                [--nb-cell <INT>] [--bitw <INT>] [-t/--threads <INT>] [-v/--verbose <STR>] 
                [--cpr] [-h/--help] [--version] 

OPTIONS
  [global]
    -i --index       - Global index path. 
    -f --fof         - kmtricks input file. 
    -d --run-dir     - kmtricks runtime directory. Use '@inplace' to build inside the global index directory 
    -r --register-as - Index name. 
       --from        - Use parameters from a pre-registered index. 
       --km-path     - Path to kmtricks binary.
                       - If empty, kmtricks is searched in $PATH and
                         at the same location as the kmindex binary. 

  [kmtricks parameters] - See kmtricks pipeline --help
    -k --kmer-size     - Size of a k-mer. in [8, 255]) {31}
    -m --minim-size    - Size of minimizers. in [4, 15] {10}
       --hard-min      - Min abundance to keep a k-mer. {2}
       --nb-partitions - Number of partitions (0=auto). {0}
       --cpr           - Compress intermediate files. [⚑]

  [presence/absence indexing]
     --bloom-size - Bloom filter size. 

  [abundance indexing]
     --nb-cell - Number of cells in counting Bloom filter. 
     --bitw    - Number of bits per cell. {2}
                 - Abundances are indexed by log2 classes (nb classes = 2^{bitw})
                   For example, using --bitw 3 resulting in the following classes:
                     0 -> 0
                     1 -> [1,2) 
                     2 -> [2,4) 
                     3 -> [4,8) 
                     4 -> [8,16) 
                     5 -> [16,32) 
                     6 -> [32,64) 
                     7 -> [64,max(uint32_t)) 

  [common]
    -t --threads - Number of threads. {20}
    -h --help    - Show this message and exit. [⚑]
       --version - Show version and exit. [⚑]
    -v --verbose - Verbosity level [debug|info|warning|error]. {info}
```


## kmindex_register

### Tool Description
Register index.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmindex:0.6.0--h668145b_1
- **Homepage**: https://github.com/tlemane/kmindex
- **Package**: https://anaconda.org/channels/bioconda/packages/kmindex/overview
- **Validation**: PASS

### Original Help Text
```text
kmindex register v0.6.0

DESCRIPTION
  Register index.

USAGE
  kmindex register -i/--global-index <STR> [-n/--name <STR>] [-p/--index-path <STR>] [-f/--from-file <STR>] 
                   [-m/--mode <STR>] [-v/--verbose <STR>] [-h/--help] [--version] 

OPTIONS
  [global]
    -i --global-index - Global index path. 
    -n --name         - Index name. (ignored with --from-file) 
    -p --index-path   - Index path (a kmtricks run). (ignored with --from-file) 
    -f --from-file    - A tab-separated file with index_name<tab>index_path per line. 
    -m --mode         - Register mode [symlink|copy|move] {symlink}

  [common]
    -h --help    - Show this message and exit. [⚑]
       --version - Show version and exit. [⚑]
    -v --verbose - Verbosity level [debug|info|warning|error]. {info}
```


## kmindex_query

### Tool Description
Query index.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmindex:0.6.0--h668145b_1
- **Homepage**: https://github.com/tlemane/kmindex
- **Package**: https://anaconda.org/channels/bioconda/packages/kmindex/overview
- **Validation**: PASS

### Original Help Text
```text
kmindex query v0.6.0

DESCRIPTION
  Query index.

USAGE
  kmindex query -i/--index <STR> -q/--fastx <STR> [-n/--names <STR>] [-z/--zvalue <INT>] 
                [-r/--threshold <FLOAT>] [-o/--output <STR>] [-s/--single-query <STR>] 
                [-f/--format <STR>] [-b/--batch-size <INT>] [-t/--threads <INT>] 
                [-v/--verbose <STR>] [-a/--aggregate] [--fast] [-h/--help] [--version] 

OPTIONS
  [global]
    -i --index        - Global index path. 
    -n --names        - Sub-indexes to query, comma separated. {all}
    -z --zvalue       - Index s-mers and query (s+z)-mers (findere algorithm). {0}
    -r --threshold    - Shared k-mers threshold. in [0.0, 1.0] {0.0}
    -o --output       - Output directory. {output}
    -q --fastx        - Input fasta/q file (supports gz/bzip2) containing the sequence(s) to query. 
    -s --single-query - Query identifier. All sequences are considered as a unique query. 
    -f --format       - Output format [json|matrix|json_vec|jsonl|jsonl_vec] {json}
    -b --batch-size   - Size of query batches (0≈nb_seq/nb_thread). {0}
    -a --aggregate    - Aggregate results from batches into one file. [⚑]
       --fast         - Keep more pages in cache (see doc for details). [⚑]

  [common]
    -t --threads - Number of threads. {1}
    -h --help    - Show this message and exit. [⚑]
       --version - Show version and exit. [⚑]
    -v --verbose - Verbosity level [debug|info|warning|error]. {info}
```


## kmindex_query2

### Tool Description
To be used instead of kmindex query when many sub-indexes are registered, i.e. hundreds or thousands.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmindex:0.6.0--h668145b_1
- **Homepage**: https://github.com/tlemane/kmindex
- **Package**: https://anaconda.org/channels/bioconda/packages/kmindex/overview
- **Validation**: PASS

### Original Help Text
```text
kmindex query2 v0.6.0

DESCRIPTION
  To be used instead of kmindex query when many sub-indexes are registered, i.e. hundreds or thousands.

USAGE
  kmindex query2 -i/--index <STR> -q/--fastx <STR> [-n/--names <STR>] [-z/--zvalue <INT>] 
                 [-r/--threshold <FLOAT>] [-o/--output <STR>] [-f/--format <STR>] 
                 [-t/--threads <INT>] [-v/--verbose <STR>] [--fast] [-h/--help] [--version] 

OPTIONS
  [global]
    -i --index        - Global index path. 
    -n --names        - Sub-indexes to query, comma separated. {all}
    -z --zvalue       - Index s-mers and query (s+z)-mers (findere algorithm). {0}
    -r --threshold    - Shared k-mers threshold. in [0.0, 1.0] {0.0}
    -o --output       - Output directory. {output}
    -q --fastx        - Input fasta/q file (supports gz/bzip2) containing the sequence(s) to query. 
    -f --format       - Output format [json|matrix|json_vec|jsonl|jsonl_vec] {json}
       --fast         - Keep more pages in cache (see doc for details). [⚑]

  [common]
    -t --threads - Number of threads. {1}
    -h --help    - Show this message and exit. [⚑]
       --version - Show version and exit. [⚑]
    -v --verbose - Verbosity level [debug|info|warning|error]. {info}
```


## kmindex_merge

### Tool Description
Merge sub-indexes.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmindex:0.6.0--h668145b_1
- **Homepage**: https://github.com/tlemane/kmindex
- **Package**: https://anaconda.org/channels/bioconda/packages/kmindex/overview
- **Validation**: PASS

### Original Help Text
```text
kmindex merge v0.6.0

DESCRIPTION
  Merge sub-indexes.

USAGE
  kmindex merge -i/--index <STR> -n/--new-name <STR> -p/--new-path <STR> -m/--to-merge <LIST[STR]> 
                [-r/--rename <STR>] [-t/--threads <INT>] [-v/--verbose <STR>] 
                [-d/--delete-old] [-h/--help] [--version] 

OPTIONS
  [global]
    -i --index      - Global index path. 
    -n --new-name   - Name of the new index. 
    -p --new-path   - Output path. 
    -m --to-merge   - Sub-indexes to merge, comma separated. 
    -d --delete-old - Delete old sub-index files. [⚑]
    -r --rename     - Rename sample ids.
                      - A sub-index cannot contain samples with similar identifiers.
                        Sub-indexes containing identical identifiers cannot be merged, the
                        identifiers must be renamed.
                      - Renaming can be done in three different ways:

                        1. Using identifier files (one per line).
                           For example, if you want to merge three sub-indexes:
                             '-r f:id1.txt,id2.txt,id3.txt'

                        2. Using a format string ('{}' is replaced by an integer in [0, nb_samples)).
                             '-r "s:id_{}"'

                        3. Manually (not recommended).
                           Identifiers can be changed in 'kmtricks.fof' files in sub-index directories. 

  [common]
    -t --threads - Number of threads. {20}
    -h --help    - Show this message and exit. [⚑]
       --version - Show version and exit. [⚑]
    -v --verbose - Verbosity level [debug|info|warning|error]. {info}
```


## kmindex_index-infos

### Tool Description
Print index informations.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmindex:0.6.0--h668145b_1
- **Homepage**: https://github.com/tlemane/kmindex
- **Package**: https://anaconda.org/channels/bioconda/packages/kmindex/overview
- **Validation**: PASS

### Original Help Text
```text
kmindex index-infos v0.6.0

DESCRIPTION
  Print index informations.

USAGE
  kmindex index-infos -i/--index <STR> [-v/--verbose <STR>] [-h/--help] [--version] 

OPTIONS
  [global]
    -i --index - Global index path. 

  [common]
    -h --help    - Show this message and exit. [⚑]
       --version - Show version and exit. [⚑]
    -v --verbose - Verbosity level [debug|info|warning|error]. {info}
```


## kmindex_compress

### Tool Description
Compress index.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmindex:0.6.0--h668145b_1
- **Homepage**: https://github.com/tlemane/kmindex
- **Package**: https://anaconda.org/channels/bioconda/packages/kmindex/overview
- **Validation**: PASS

### Original Help Text
```text
kmindex compress v0.6.0

DESCRIPTION
  Compress index.

USAGE
  kmindex compress -i/--global-index <STR> -n/--name <STR> [-b/--block-size <INT>] [-s/--sampling <INT>] 
                   [-c/--column-per-block <INT>] [-l/--cpr-level <INT>] 
                   [-t/--threads <INT>] [-v/--verbose <STR>] [-d/--delete] [--check] 
                   [-r/--reorder] [-h/--help] [--version] 

OPTIONS
  [global]
    -i --global-index - Global index path. 
    -n --name         - Index name. 
    -d --delete       - Delete uncompressed index after compressing. [⚑]
       --check        - Check query results after compressing. [⚑]

  [Reordering options]
    -b --block-size       - Size of uncompressed blocks, in megabytes. {8}
    -r --reorder          - Reorder columns before compressing. [⚑]
    -s --sampling         - Number of rows to sample for reordering. {20000}
    -c --column-per-block - Reorder columns by group of N. Should be a multiple of 8 (0=all) {0}
    -l --cpr-level        - Compression level in [1,22]) {6}

  [common]
    -t --threads - Number of threads. {20}
    -h --help    - Show this message and exit. [⚑]
       --version - Show version and exit. [⚑]
    -v --verbose - Verbosity level [debug|info|warning|error]. {info}
```


## kmindex_sum-index

### Tool Description
Make a lightweight summarized index, at query time, reports only the number samples containing each k-mer. (experimental)

### Metadata
- **Docker Image**: quay.io/biocontainers/kmindex:0.6.0--h668145b_1
- **Homepage**: https://github.com/tlemane/kmindex
- **Package**: https://anaconda.org/channels/bioconda/packages/kmindex/overview
- **Validation**: PASS

### Original Help Text
```text
kmindex sum-index v0.6.0

DESCRIPTION
  Make a lightweight summarized index, at query time,
                reports only the number samples containing each k-mer. (experimental)

USAGE
  kmindex sum-index -i/--global-index <STR> -n/--name <STR> [-c/--fp-correction <FLOAT>] [-s/--nbk <INT>] 
                    [-t/--threads <INT>] [-v/--verbose <STR>] [-e/--estimate-correction] 
                    [-h/--help] [--version] 

OPTIONS
  [global]
    -i --global-index        - Global index path. 
    -n --name                - Index name. 
    -c --fp-correction       - False positive rate correction factor in [0.0,1.0]. {0.0}
    -e --estimate-correction - Estimate the false positive rate correction factor. [⚑]
    -s --nbk                 - Number of k-mers to use for estimating the correction factor (only with -e). {10000}

  [common]
    -t --threads - Number of threads. {20}
    -h --help    - Show this message and exit. [⚑]
       --version - Show version and exit. [⚑]
    -v --verbose - Verbosity level [debug|info|warning|error]. {info}
```


## kmindex_reports

### Tool Description
Reports on kmindex files.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmindex:0.6.0--h668145b_1
- **Homepage**: https://github.com/tlemane/kmindex
- **Package**: https://anaconda.org/channels/bioconda/packages/kmindex/overview
- **Validation**: PASS

### Original Help Text
```text
[2026-02-25 08:10:20.616] [error] [UnknownCmdError] -> Unknown command: reports, choices -> [build|register|query|query2|merge|index-infos|compress|sum-index|sum-query]
```


## kmindex_sum-query

### Tool Description
Query a summarized index. (experimental)

### Metadata
- **Docker Image**: quay.io/biocontainers/kmindex:0.6.0--h668145b_1
- **Homepage**: https://github.com/tlemane/kmindex
- **Package**: https://anaconda.org/channels/bioconda/packages/kmindex/overview
- **Validation**: PASS

### Original Help Text
```text
kmindex sum-query v0.6.0

DESCRIPTION
  Query a summarized index. (experimental)

USAGE
  kmindex sum-query -i/--global-index <STR> -q/--fastx <STR> [-n/--names <STR>] [-z/--zvalue <INT>] 
                    [-o/--output <STR>] [-t/--threads <INT>] [-v/--verbose <STR>] 
                    [-h/--help] [--version] 

OPTIONS
  [global]
    -i --global-index - Global index path. 
    -q --fastx        - Input fasta/q file (supports gz/bzip2) containing the sequence(s) to query. 
    -n --names        - Sub-indexes to query, comma separated. {all}
    -z --zvalue       - Index s-mers and query (s+z)-mers (findere algorithm). {0}
    -o --output       - Output directory. {output}

  [common]
    -t --threads - Number of threads. {20}
    -h --help    - Show this message and exit. [⚑]
       --version - Show version and exit. [⚑]
    -v --verbose - Verbosity level [debug|info|warning|error]. {info}
```

