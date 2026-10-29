# yacrd CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| yacrd | PASS |  |
| yacrd_extract | PASS |  |
| yacrd_filter | PASS |  |
| yacrd_scrubb | PASS |  |
| yacrd_split | PASS |  |

## yacrd_extract

### Tool Description
Record mark as chimeric or NotCovered is extract

### Metadata
- **Docker Image**: quay.io/biocontainers/yacrd:1.0.0--hc308579_0
- **Homepage**: https://github.com/natir/yacrd
- **Package**: https://anaconda.org/channels/bioconda/packages/yacrd/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/yacrd/overview
- **Total Downloads**: 278.1K
- **Last updated**: 2025-08-04
- **GitHub**: https://github.com/natir/yacrd
- **Stars**: N/A
### Original Help Text
```text
yacrd-extract 
Record mark as chimeric or NotCovered is extract

USAGE:
    yacrd --input <INPUT> --output <OUTPUT> extract --input <INPUT> --output <OUTPUT>

OPTIONS:
    -h, --help               Print help information
    -i, --input <INPUT>      path to sequence input (fasta|fastq), compression is autodetected
                             (none|gzip|bzip2|lzma)
    -o, --output <OUTPUT>    path to output file, format and compression of input is preserved
```


## yacrd_filter

### Tool Description
Record mark as chimeric or NotCovered is filter

### Metadata
- **Docker Image**: quay.io/biocontainers/yacrd:1.0.0--hc308579_0
- **Homepage**: https://github.com/natir/yacrd
- **Package**: https://anaconda.org/channels/bioconda/packages/yacrd/overview
- **Validation**: PASS

### Original Help Text
```text
yacrd-filter 
Record mark as chimeric or NotCovered is filter

USAGE:
    yacrd --input <INPUT> --output <OUTPUT> filter --input <INPUT> --output <OUTPUT>

OPTIONS:
    -h, --help               Print help information
    -i, --input <INPUT>      path to sequence input (fasta|fastq), compression is autodetected
                             (none|gzip|bzip2|lzma)
    -o, --output <OUTPUT>    path to output file, format and compression of input is preserved
```


## yacrd_scrubb

### Tool Description
All bad region of read is removed

### Metadata
- **Docker Image**: quay.io/biocontainers/yacrd:1.0.0--hc308579_0
- **Homepage**: https://github.com/natir/yacrd
- **Package**: https://anaconda.org/channels/bioconda/packages/yacrd/overview
- **Validation**: PASS

### Original Help Text
```text
yacrd-scrubb 
All bad region of read is removed

USAGE:
    yacrd --input <INPUT> --output <OUTPUT> scrubb --input <INPUT> --output <OUTPUT>

OPTIONS:
    -h, --help               Print help information
    -i, --input <INPUT>      path to sequence input (fasta|fastq), compression is autodetected
                             (none|gzip|bzip2|lzma)
    -o, --output <OUTPUT>    path to output file, format and compression of input is preserved
```


## yacrd_split

### Tool Description
Record mark as chimeric or NotCovered is split

### Metadata
- **Docker Image**: quay.io/biocontainers/yacrd:1.0.0--hc308579_0
- **Homepage**: https://github.com/natir/yacrd
- **Package**: https://anaconda.org/channels/bioconda/packages/yacrd/overview
- **Validation**: PASS

### Original Help Text
```text
yacrd-split 
Record mark as chimeric or NotCovered is split

USAGE:
    yacrd --input <INPUT> --output <OUTPUT> split --input <INPUT> --output <OUTPUT>

OPTIONS:
    -h, --help               Print help information
    -i, --input <INPUT>      path to sequence input (fasta|fastq), compression is autodetected
                             (none|gzip|bzip2|lzma)
    -o, --output <OUTPUT>    path to output file, format and compression of input is preserved
```


## yacrd

### Tool Description
Detect chimeric and not covered reads from read overlaps (yacrd report mode).

### Metadata
- **Docker Image**: quay.io/biocontainers/yacrd:1.0.0--hc308579_0
- **Homepage**: https://github.com/natir/yacrd
- **Package**: https://anaconda.org/channels/bioconda/packages/yacrd/overview
- **Validation**: PASS

### Original Help Text
```text
yacrd 1.0.0 Magby
Pierre Marijon <pierre@marijon.fr>
Yacrd use overlap between reads, to detect 'good' and 'bad' region, a region with coverage over the
threshold is 'good' others are 'bad'. If read has a 'bad' region in middle this reads is mark as
'Chimeric'. If the ratio of 'bad' region length on total read length is larger than threshold this
reads is marked as 'Not_covered'. Yacrd can make some other actions: - filter: for sequence or
overlap file, record with reads marked as Chimeric or NotCovered isn't written in the output -
extract: for sequence or overlap file, record contains reads marked as Chimeric or NotCovered is
written in the output - split: for sequence file bad region in the middle of reads are removed,
NotCovered read is removed - scrubb: for sequence file all bad region are removed, NotCovered read
is removed

USAGE:
    yacrd [OPTIONS] --input <INPUT> --output <OUTPUT> [SUBCOMMAND]

OPTIONS:
    -c, --coverage <COVERAGE>
            if coverage reach this value region is marked as bad [default: 0]

    -d, --ondisk <ONDISK>
            yacrd switches to 'ondisk' mode which will reduce memory usage but increase computation
            time. The value passed as a parameter is used as a prefix for the temporary files
            created by yacrd. Be careful if the prefix contains path separators (`/` for unix or
            `\\` for windows) this folder will be deleted

    -h, --help
            Print help information

    -i, --input <INPUT>
            path to input file overlap (.paf|.m4|.mhap) or yacrd report (.yacrd), format is
            autodetected and compression input is allowed (gz|bzip2|lzma)

    -n, --not-coverage <NOT_COVERAGE>
            if the ratio of bad region length on total length is lower than this value, read is
            marked as NotCovered [default: 0.8]

    -o, --output <OUTPUT>
            path output file

        --ondisk-buffer-size <ONDISK_BUFFER_SIZE>
            with the default value yacrd in 'ondisk' mode use around 1 GBytes, you can increase to
            reduce runtime but increase memory usage [default: 64000000]

        --read-buffer-size <BUFFER_SIZE>
            Control the size of the buffer used to read paf file [default: 8192]

    -t, --thread <THREADS>
            number of thread use by yacrd, 0 mean all threads available, default 1

    -V, --version
            Print version information

SUBCOMMANDS:
    extract    Record mark as chimeric or NotCovered is extract
    filter     Record mark as chimeric or NotCovered is filter
    help       Print this message or the help of the given subcommand(s)
    scrubb     All bad region of read is removed
    split      Record mark as chimeric or NotCovered is split
```

## Metadata
- **Skill**: generated
