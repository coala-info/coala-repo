# kmtricks CWL Generation Report

## kmtricks_pipeline

### Tool Description
run all the steps, repart -> superk -> count -> merge

### Metadata
- **Docker Image**: quay.io/biocontainers/kmtricks:1.5.1--h22625ea_0
- **Homepage**: https://github.com/tlemane/kmtricks
- **Package**: https://anaconda.org/channels/bioconda/packages/kmtricks/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kmtricks/overview
- **Total Downloads**: 3.0K
- **Last updated**: 2025-12-16
- **GitHub**: https://github.com/tlemane/kmtricks
- **Stars**: N/A
### Original Help Text
```text
kmtricks pipeline v1.5.1

DESCRIPTION
  kmtricks pipeline (run all the steps, repart -> superk -> count -> merge)

USAGE
  kmtricks pipeline --file <FILE> --run-dir <DIR> [--kmer-size <INT>] [--hard-min <INT>] 
                    [--mode <MODE:FORMAT:OUT>] [--repart-from <STR>] 
                    [--soft-min <INT/STR/FLOAT>] [--recurrence-min <INT>] 
                    [--share-min <INT>] [--until <STR>] [--minimizer-size <INT>] 
                    [--minimizer-type <INT>] [--repartition-type <INT>] 
                    [--nb-partitions <INT>] [--restrict-to <FLOAT>] 
                    [--restrict-to-list <STR>] [--focus <FLOAT>] [--bloom-size <INT>] 
                    [--bf-format <STR>] [--bitw <INT>] [-t/--threads <INT>] 
                    [-v/--verbose <STR>] [--hist] [--kff-output] [--keep-tmp] [--cpr] 
                    [-h/--help] [--version] 

OPTIONS
  [global]
     --file        - kmtricks input file, see README.md. 
     --run-dir     - kmtricks runtime directory. 
     --kmer-size   - size of a k-mer. [8, 255]. {31}
     --hard-min    - min abundance to keep a k-mer. {2}
     --mode        - matrix mode <mode:format:out>, see README {kmer:count:bin}
     --hist        - compute k-mer histograms. [⚑]
     --kff-output  - output counted k-mers in kff format (only with --until count). [⚑]
     --keep-tmp    - keep tmp files. [⚑]
     --repart-from - use repartition from another kmtricks run. 

  [merge options]
     --soft-min       - during merge, min abundance to keep a k-mer, see README. {1}
     --recurrence-min - min recurrence to keep a k-mer. {1}
     --share-min      - save a non-solid k-mer if it is solid in N other samples. {0}

  [pipeline control]
     --until - run until [all|repart|superk|count|merge] {all}

  [advanced performance tweaks]
     --minimizer-size   - size of minimizers. [4, 15] {10}
     --minimizer-type   - minimizer type (0=lexi, 1=freq). {0}
     --repartition-type - minimizer repartition (0=unordered, 1=ordered). {0}
     --nb-partitions    - number of partitions (0=auto). {0}
     --restrict-to      - Process only a fraction of partitions. [0.05, 1.0] {1.0}
     --restrict-to-list - Process only some partitions, comma separated. 
     --focus            - 0: focus on disk usage, 1: focus on speed. [0.0, 1.0] {0.5}
     --cpr              - compression for kmtricks's tmp files. [⚑]

  [hash mode configuration]
     --bloom-size - bloom filter size {10000000}
     --bf-format  - bloom filter format. [howdesbt|sdsl] {howdesbt}
     --bitw       - entry width of cbf, with --mode hash:bfc:bin {2}

  [common]
    -t --threads - number of threads. {20}
    -h --help    - show this message and exit. [⚑]
       --version - show version and exit. [⚑]
    -v --verbose - verbosity level [debug|info|warning|error]. {info}
```


## kmtricks_repart

### Tool Description
Compute minimizer repartition.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmtricks:1.5.1--h22625ea_0
- **Homepage**: https://github.com/tlemane/kmtricks
- **Package**: https://anaconda.org/channels/bioconda/packages/kmtricks/overview
- **Validation**: PASS

### Original Help Text
```text
kmtricks repart v1.5.1

DESCRIPTION
  Compute minimizer repartition.

USAGE
  kmtricks repart --file <FILE> [--run-dir <DIR>] [--kmer-size <INT>] [--minimizer-size <INT>] 
                  [--minimizer-type <INT>] [--repartition-type <INT>] 
                  [--nb-partitions <INT>] [--bloom-size <INT>] [-t/--threads <INT>] 
                  [-v/--verbose <STR>] [-h/--help] [--version] 

OPTIONS
  [global]
     --file      - kmtricks input file, see README.md. 
     --run-dir   - kmtricks runtime directory. {km_dir}
     --kmer-size - size of a k-mer. [8, 255] {31}

  [advanced performance tweaks]
     --minimizer-size   - size of minimizers. [4, 15] {10}
     --minimizer-type   - minimizer type (0=lexi, 1=freq). {0}
     --repartition-type - minimizer repartition (0=unordered, 1=ordered). {0}
     --nb-partitions    - number of partitions (0=auto). {0}
     --bloom-size       - bloom filter size {10000000}

  [common]
    -t --threads - number of threads. {20}
    -h --help    - show this message and exit. [⚑]
       --version - show version and exit. [⚑]
    -v --verbose - verbosity level [debug|info|warning|error]. {info}
```


## kmtricks_superk

### Tool Description
Compute super-k-mers.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmtricks:1.5.1--h22625ea_0
- **Homepage**: https://github.com/tlemane/kmtricks
- **Package**: https://anaconda.org/channels/bioconda/packages/kmtricks/overview
- **Validation**: PASS

### Original Help Text
```text
kmtricks superk v1.5.1

DESCRIPTION
  Compute super-k-mers.

USAGE
  kmtricks superk --run-dir <DIR> --id <STR> [--restrict-to-list <STR>] [-t/--threads <INT>] 
                  [-v/--verbose <STR>] [--cpr] [-h/--help] [--version] 

OPTIONS
  [global]
     --run-dir          - kmtricks runtime directory. 
     --id               - sample ID, as define in the input fof. 
     --restrict-to-list - process only some partitions, comma separated. 
     --cpr              - output compressed super-k-mers. [⚑]

  [common]
    -t --threads - number of threads. {20}
    -h --help    - show this message and exit. [⚑]
       --version - show version and exit. [⚑]
    -v --verbose - verbosity level [debug|info|warning|error]. {info}
```


## kmtricks_count

### Tool Description
Count k-mers/hashes in partitions.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmtricks:1.5.1--h22625ea_0
- **Homepage**: https://github.com/tlemane/kmtricks
- **Package**: https://anaconda.org/channels/bioconda/packages/kmtricks/overview
- **Validation**: PASS

### Original Help Text
```text
kmtricks count v1.5.1

DESCRIPTION
  Count k-mers/hashes in partitions.

USAGE
  kmtricks count --id <STR> --run-dir <DIR> --mode <STR> [--hard-min <INT>] [--partition-id <INT>] 
                 [-t/--threads <INT>] [-v/--verbose <STR>] [--hist] [--clear] [--cpr] 
                 [-h/--help] [--version] 

OPTIONS
  [global]
     --id           - sample ID, as define in kmtricks fof. 
     --run-dir      - kmtricks runtime directory. 
     --hard-min     - min abundance to keep a k-mer/hash. {2}
     --partition-id - partition id (default: all partitions are processed. {-1}
     --mode         - count k-mers or hashes. [kmer|hash|vector|kff] 
     --hist         - compute k-mer histograms. [⚑]
     --clear        - clear super-k-mer files. [⚑]
     --cpr          - output compressed partitions. [⚑]

  [common]
    -t --threads - number of threads. {20}
    -h --help    - show this message and exit. [⚑]
       --version - show version and exit. [⚑]
    -v --verbose - verbosity level [debug|info|warning|error]. {info}
```


## kmtricks_merge

### Tool Description
Merge partitions.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmtricks:1.5.1--h22625ea_0
- **Homepage**: https://github.com/tlemane/kmtricks
- **Package**: https://anaconda.org/channels/bioconda/packages/kmtricks/overview
- **Validation**: PASS

### Original Help Text
```text
kmtricks merge v1.5.1

DESCRIPTION
  Merge partitions.

USAGE
  kmtricks merge --run-dir <DIR> [--partition-id <INT>] [--soft-min <INT/STR/FLOAT>] [--recurrence-min <INT>] 
                 [--share-min <INT>] [--mode <MODE:FORMAT:OUT>] [-t/--threads <INT>] 
                 [-v/--verbose <STR>] [--clear] [--cpr] [-h/--help] [--version] 

OPTIONS
  [global]
     --run-dir        - kmtricks runtime directory. 
     --partition-id   - partition id (-1 = all partitions are processed). {-1}
     --soft-min       - min abundance to keep a k-mer/hash, see README. {1}
     --recurrence-min - min recurrence to keep a k-mer/hash. {1}
     --share-min      - save a non-solid k-mer if it is solid in N other samples. {0}
     --mode           - matrix mode <mode:format:out>, see README {kmer:count:bin}
     --clear          - clear partition files. [⚑]
     --cpr            - output compressed matrices. [⚑]

  [common]
    -t --threads - number of threads. {20}
    -h --help    - show this message and exit. [⚑]
       --version - show version and exit. [⚑]
    -v --verbose - verbosity level [debug|info|warning|error]. {info}
```


## kmtricks_filter

### Tool Description
Filter existing matrix with a new sample.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmtricks:1.5.1--h22625ea_0
- **Homepage**: https://github.com/tlemane/kmtricks
- **Package**: https://anaconda.org/channels/bioconda/packages/kmtricks/overview
- **Validation**: PASS

### Original Help Text
```text
kmtricks filter v1.5.1

DESCRIPTION
  Filter existing matrix with a new sample.

USAGE
  kmtricks filter --in-matrix <DIR> --key <FILE> --output <DIR> [--hard-min <INT>] [--out-types <STR>] 
                  [-t/--threads <INT>] [-v/--verbose <STR>] [--cpr-in] [--cpr-out] 
                  [-h/--help] [--version] 

OPTIONS
  [global]
     --in-matrix - kmtricks runtime directory which contains the matrix. 
     --key       - filtering key (a kmtricks fof with only one sample). 
     --output    - output directory. 
     --hard-min  - min abundance to keep a k-mer in --key. {2}
     --out-types - output types: (comma separated, ex: --out-types k,m)
                     k: The set of k-mers which are present in the key but absent in the input matrix.
                     m: A new matrix which is the intersection of the key and the input matrix.
                        In count mode, the matrix contains an new column corresponding to the abundances
                        of k-mers from the key.
                     v: A text vector (column) representing the abundances or presence/absence of k-mers
                        from the key in the input matrix. {m,v}
     --cpr-in    - compressed inputs. [⚑]
     --cpr-out   - compressed outputs. [⚑]

  [common]
    -t --threads - number of threads. {20}
    -h --help    - show this message and exit. [⚑]
       --version - show version and exit. [⚑]
    -v --verbose - verbosity level [debug|info|warning|error]. {info}
```


## kmtricks_dump

### Tool Description
Dump kmtricks's files in human readable format.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmtricks:1.5.1--h22625ea_0
- **Homepage**: https://github.com/tlemane/kmtricks
- **Package**: https://anaconda.org/channels/bioconda/packages/kmtricks/overview
- **Validation**: PASS

### Original Help Text
```text
kmtricks dump v1.5.1

DESCRIPTION
  Dump kmtricks's files in human readable format.

USAGE
  kmtricks dump --run-dir <DIR> --input <FILE> [-o/--output <FILE>] [-t/--threads <INT>] [-v/--verbose <STR>] 
                [-h/--help] [--version] 

OPTIONS
  [global]
       --run-dir - kmtricks runtime directory. 
       --input   - path to file. 
    -o --output  - output file. {stdout}

  [common]
    -t --threads - number of threads. {20}
    -h --help    - show this message and exit. [⚑]
       --version - show version and exit. [⚑]
    -v --verbose - verbosity level [debug|info|warning|error]. {info}
```


## kmtricks_aggregate

### Tool Description
Aggregate partition files.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmtricks:1.5.1--h22625ea_0
- **Homepage**: https://github.com/tlemane/kmtricks
- **Package**: https://anaconda.org/channels/bioconda/packages/kmtricks/overview
- **Validation**: PASS

### Original Help Text
```text
kmtricks aggregate v1.5.1

DESCRIPTION
  Aggregate partition files.

USAGE
  kmtricks aggregate --run-dir <DIR> [--count <ID:TYPE>] [--matrix <TYPE>] [--pa-matrix <TYPE:P>] [--format <STR>] 
                     [--output <FILE>] [-t/--threads <INT>] [-v/--verbose <STR>] [--sorted] 
                     [--cpr-in] [--cpr-out] [--no-count] [-h/--help] [--version] 

OPTIONS
  [global]
     --run-dir - kmtricks runtime directory. 

  [file type]
     --count     - aggregate counted k-mers/hashes. [id:kmer|hash] 
     --matrix    - aggregate count matrices. [kmer|hash] 
     --pa-matrix - aggregate presence/absence matrices. [kmer|hash] 

  [I/O options]
     --format   - dump in human readable format. [text|bin] {text}
     --sorted   - sorted output (A < C < T < G). [⚑]
     --cpr-in   - compressed inputs. [⚑]
     --cpr-out  - compressed output (ignored with --format text). [⚑]
     --no-count - output only k-mers (ignored with --format bin). [⚑]
     --output   - output path. {stdout}

  [common]
    -t --threads - number of threads. {20}
    -h --help    - show this message and exit. [⚑]
       --version - show version and exit. [⚑]
    -v --verbose - verbosity level [debug|info|warning|error]. {info}
```


## kmtricks_combine

### Tool Description
Combine kmtricks's matrices (support kmer/hash matrices).

### Metadata
- **Docker Image**: quay.io/biocontainers/kmtricks:1.5.1--h22625ea_0
- **Homepage**: https://github.com/tlemane/kmtricks
- **Package**: https://anaconda.org/channels/bioconda/packages/kmtricks/overview
- **Validation**: PASS

### Original Help Text
```text
kmtricks combine v1.5.1

DESCRIPTION
  Combine kmtricks's matrices (support kmer/hash matrices).

USAGE
  kmtricks combine --fof <FILE> --output <FILE> [-t/--threads <INT>] [-v/--verbose <STR>] [--cpr] [-h/--help] 
                   [--version] 

OPTIONS
  [global]
     --fof    - input fof, one kmtricks run per line. 
     --output - output directory. 
     --cpr    - compress output. [⚑]

  [common]
    -t --threads - number of threads. {20}
    -h --help    - show this message and exit. [⚑]
       --version - show version and exit. [⚑]
    -v --verbose - verbosity level [debug|info|warning|error]. {info}
```


## kmtricks_infos

### Tool Description
Display build and configuration information for kmtricks.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmtricks:1.5.1--h22625ea_0
- **Homepage**: https://github.com/tlemane/kmtricks
- **Package**: https://anaconda.org/channels/bioconda/packages/kmtricks/overview
- **Validation**: PASS

### Original Help Text
```text
kmtricks v1.5.1

- HOST -
build host: Linux-6.8.0-1041-azure
run host: Linux 6.8.0-100-generic

- BUILD -
c compiler: GNU 12.4.0
cxx compiler: GNU 12.4.0
conda: ON
static: OFF
native: OFF
modules: ON
dev: OFF
kmer: 32,64,96,128,160,192,224,256
max_c: 4294967295

- GIT SHA1 / VERSION -
kmtricks: 
bcli: 
fmt: 
kff: 
lz4: 
spdlog: 
xxhash: 
gtest: 
robin-hood-hasing: 
turbop: 
cfrcat: 
indicators: 

Contact: teo.lemane@genoscope.cns.fr
```


## Metadata
- **Skill**: generated
