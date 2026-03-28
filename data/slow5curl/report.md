# slow5curl CWL Generation Report

## slow5curl_get

### Tool Description
Display the read entry for each specified READ_ID from a blow5 file. If READ_ID is not specified, a newline separated list of read ids will be read from the standard input.

### Metadata
- **Docker Image**: quay.io/biocontainers/slow5curl:0.3.0--h86e5fe9_0
- **Homepage**: https://github.com/BonsonW/slow5curl
- **Package**: https://anaconda.org/channels/bioconda/packages/slow5curl/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/slow5curl/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2026-01-30
- **GitHub**: https://github.com/BonsonW/slow5curl
- **Stars**: N/A
### Original Help Text
```text
Display the read entry for each specified READ_ID from a blow5 file.
If READ_ID is not specified, a newline separated list of read ids will be read from the standard input.
Usage: slow5curl get [OPTIONS] [SLOW5_FILE] [READ_ID]...

OPTIONS:
    --to FORMAT                   specify output file format (slow5 or blow5)
    -o, --output [FILE]           output contents to FILE (.slow5 or .blow5 extensions) [default: stdout]
        --index FILE              specify path to a custom slow5 index
        --cache FILE              save the downloaded index to the specified file path [false]
    -c, --compress REC_MTD        record compression method [zlib] (only for blow5 format)
    -s, --sig-compress SIG_MTD    signal compression method [svb-zd] (only for blow5 format)
    -t, --threads INT             number of threads [128]
    -K, --batchsize INT           number of records loaded to the memory at once [4096]
    -l --list [FILE]              list of read ids provided as a single-column text file with one read id per line.
    --skip                        warn and continue if a read_id was not found.
    -r, --retry INT               number of retries on a fetch before aborting the batch [1]
    -w, --wait INT                time (sec) to wait before the next fetch retry [1]
    -h, --help                    display this message and exit

FORMAT:
    slow5 - SLOW5 ASCII
    blow5 - SLOW5 binary (BLOW5)
REC_MTD:
    none - no record compression
    zlib - Z library (also known as gzip or DEFLATE)
    zstd - Z standard 
SIG_MTD:
    none - no special signal compression
    svb-zd - StreamVByte with zig-zag delta 

See https://slow5.bioinf.science/slow5curl for a detailed description of these command-line options.
```


## slow5curl_head

### Tool Description
Prints the header for a remote BLOW5 file.

### Metadata
- **Docker Image**: quay.io/biocontainers/slow5curl:0.3.0--h86e5fe9_0
- **Homepage**: https://github.com/BonsonW/slow5curl
- **Package**: https://anaconda.org/channels/bioconda/packages/slow5curl/overview
- **Validation**: PASS

### Original Help Text
```text
Prints the header for a remote BLOW5 file. Usage: slow5curl head [OPTIONS] [SLOW5_FILE]

    -h, --help                    display this message and exit

See https://slow5.bioinf.science/slow5curl for a detailed description of these command-line options.
```


## slow5curl_reads

### Tool Description
Prints the reads in a remote BLOW5 file.

### Metadata
- **Docker Image**: quay.io/biocontainers/slow5curl:0.3.0--h86e5fe9_0
- **Homepage**: https://github.com/BonsonW/slow5curl
- **Package**: https://anaconda.org/channels/bioconda/packages/slow5curl/overview
- **Validation**: PASS

### Original Help Text
```text
Prints the reads in a remote BLOW5 file. Usage: slow5curl reads [OPTIONS] [SLOW5_FILE]

        --cache FILE              save the downloaded index to the specified file path [false]
        --index FILE              specify path to a custom slow5 index
    -h, --help                    display this message and exit

See https://slow5.bioinf.science/slow5curl for a detailed description of these command-line options.
```


## Metadata
- **Skill**: generated
