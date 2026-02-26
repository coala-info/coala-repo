# mtsv-tools CWL Generation Report

## mtsv-tools_mtsv-chunk

### Tool Description
Split a FASTA reference database into chunks for index generation.

### Metadata
- **Docker Image**: quay.io/biocontainers/mtsv-tools:2.1.0--h54198d6_0
- **Homepage**: https://github.com/FofanovLab/mtsv_tools
- **Package**: https://anaconda.org/channels/bioconda/packages/mtsv-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mtsv-tools/overview
- **Total Downloads**: 18.6K
- **Last updated**: 2026-02-20
- **GitHub**: https://github.com/FofanovLab/mtsv_tools
- **Stars**: N/A
### Original Help Text
```text
mtsv-chunk 2.1.0
Tara Furstenau <tara.furstenau@gmail.com>
Split a FASTA reference database into chunks for index generation.

USAGE:
    mtsv-chunk [FLAGS] --input <INPUT> --output <OUTPUT> --gb <SIZE_GB>

FLAGS:
    -v               Include this flag to trigger debug-level logging.
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -i, --input <INPUT>      Path(s) to vedro results files to collapse
    -o, --output <OUTPUT>    Folder path to write split output files to.
    -g, --gb <SIZE_GB>       Chunk size (in gigabytes). [default: 10]
```


## mtsv-tools_mtsv-build

### Tool Description
Index construction for mtsv metagenomic and metatranscriptomic assignment tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/mtsv-tools:2.1.0--h54198d6_0
- **Homepage**: https://github.com/FofanovLab/mtsv_tools
- **Package**: https://anaconda.org/channels/bioconda/packages/mtsv-tools/overview
- **Validation**: PASS

### Original Help Text
```text
mtsv-build 2.1.0
Tara Furstenau <tara.furstenau@gmail.com>
Index construction for mtsv metagenomic and metatranscriptomic assignment tool.

USAGE:
    mtsv-build [FLAGS] [OPTIONS] --fasta <FASTA> --index <INDEX>

FLAGS:
        --skip-missing    Skip FASTA records missing from the mapping file (warn instead of error).
    -v                    Include this flag to trigger debug-level logging.
    -h, --help            Prints help information
    -V, --version         Prints version information

OPTIONS:
    -f, --fasta <FASTA>                           Path to FASTA database file.
        --sample-interval <FM_SAMPLE_INTERVAL>
            BWT occurance sampling rate. If sample interval is k, every k-th entry will be kept. [default: 64]

    -i, --index <INDEX>                           Absolute path to mtsv index file.
        --mapping <MAPPING>
            Path to header->taxid/seqid mapping file (columns: header, taxid, seqid).

        --sa-sample <SA_SAMPLE_RATE>
            Suffix array sampling rate. If sampling rate is k, every k-th entry will be kept. [default: 32]
```


## mtsv-tools_mtsv-binner

### Tool Description
Metagenomic and metatranscriptomic assignment tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/mtsv-tools:2.1.0--h54198d6_0
- **Homepage**: https://github.com/FofanovLab/mtsv_tools
- **Package**: https://anaconda.org/channels/bioconda/packages/mtsv-tools/overview
- **Validation**: PASS

### Original Help Text
```text
mtsv 2.1.0
Tara Furstenau <tara.furstenau@gmail.com>
Metagenomic and metatranscriptomic assignment tool.

USAGE:
    mtsv-binner [FLAGS] [OPTIONS] --fasta <FASTA> --fastq <FASTQ> --index <INDEX>

FLAGS:
        --force-overwrite    Always overwrite the results file instead of resuming from existing output.
    -v                       Include this flag to trigger debug-level logging.
    -h, --help               Prints help information
    -V, --version            Prints version information

OPTIONS:
    -e, --edit-rate <EDIT_TOLERANCE>           The maximum proportion of edits allowed for alignment. [default: 0.13]
    -f, --fasta <FASTA>                        Path to FASTA reads.
    -f, --fastq <FASTQ>                        Path to FASTQ reads.
    -i, --index <INDEX>                        Path to MG-index file.
        --max-assignments <MAX_ASSIGNMENTS>    Stop after this many successful assignments per read.
        --max-candidates <MAX_CANDIDATES>      Stop checking candidates after this many per read.
        --max-hits <MAX_HITS>                  Skip seeds with more than MAX_HITS hits. [default: 2000]
        --min-seed <MIN_SEED>                  Set the minimum percentage of seeds required to perform an alignment.
                                               [default: 0.015]
    -t, --threads <NUM_THREADS>                Number of worker threads to spawn. [default: 4]
        --output-format <OUTPUT_FORMAT>        Output format: default (taxid=edit) or long (taxid-gi-offset=edit).
                                               [default: default]  [possible values: default, long]
        --read-offset <READ_OFFSET>            Skip this many reads before processing. [default: 0]
    -m, --results <RESULTS_PATH>               Path to write results file.
        --seed-interval <SEED_INTERVAL>        Set the interval between seeds used for initial exact match. [default:
                                               15]
        --seed-size <SEED_SIZE>                Set seed size. [default: 18]
        --tune-max-hits <TUNE_MAX_HITS>        Each time the number of seed hits is greater than TUNE_MAX_HITS but less
                                               than MAX_HITS, the seed interval will be doubled to reduce the number of
                                               seed hits and reduce runtime. [default: 200]
```


## mtsv-tools_mtsv-collapse

### Tool Description
Tool for combining the output of multiple separate mtsv runs.

### Metadata
- **Docker Image**: quay.io/biocontainers/mtsv-tools:2.1.0--h54198d6_0
- **Homepage**: https://github.com/FofanovLab/mtsv_tools
- **Package**: https://anaconda.org/channels/bioconda/packages/mtsv-tools/overview
- **Validation**: PASS

### Original Help Text
```text
mtsv-collapse 2.1.0
Tara Furstenau <tara.furstenau@gmail.com>
Tool for combining the output of multiple separate mtsv runs.

USAGE:
    mtsv-collapse [FLAGS] [OPTIONS] <FILES>... --output <OUTPUT>

FLAGS:
    -v               Include this flag to trigger debug-level logging.
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
        --mode <MODE>          Collapse mode: taxid (min edit per taxid) or taxid-gi (min edit per taxid-gi). [default:
                               taxid]  [possible values: taxid, taxid-gi]
    -o, --output <OUTPUT>      Path to write combined outupt file to.
        --report <REPORT>      Write per-taxid stats TSV report.
    -t, --threads <THREADS>    Number of worker threads for sorting. [default: 4]

ARGS:
    <FILES>...    Path(s) to mtsv results files to collapse
```

