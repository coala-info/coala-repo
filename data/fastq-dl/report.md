# fastq-dl CWL Generation Report

## fastq-dl

### Tool Description
Download FASTQ files from ENA or SRA.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastq-dl:3.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/rpetit3/fastq-dl
- **Package**: https://anaconda.org/channels/bioconda/packages/fastq-dl/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fastq-dl/overview
- **Total Downloads**: 42.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rpetit3/fastq-dl
- **Stars**: N/A
### Original Help Text
```text
Usage: fastq-dl [OPTIONS]                                                      
                                                                                
 Download FASTQ files from ENA or SRA.                                          
                                                                                
╭─ Required Options ───────────────────────────────────────────────────────────╮
│ *  --accession  -a  TEXT  ENA/SRA accession to query. (Study, Sample,        │
│                           Experiment, Run accession)                         │
│                           [required]                                         │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Download Options ───────────────────────────────────────────────────────────╮
│ --provider                    [ena|sra]  Specify which provider (ENA or SRA) │
│                                          to use.                             │
│                                          [default: ena]                      │
│ --group-by-experiment                    Group Runs by experiment accession. │
│ --group-by-sample                        Group Runs by sample accession.     │
│ --max-attempts            -m  INTEGER    Maximum number of download          │
│                                          attempts.                           │
│                                          [default: 10]                       │
│ --sra-lite                               Set preference to SRA Lite          │
│ --only-provider                          Only attempt download from          │
│                                          specified provider.                 │
│ --only-download-metadata                 Skip FASTQ downloads, and retrieve  │
│                                          only the metadata.                  │
│ --ignore                  -I             Ignore MD5 checksums for downloaded │
│                                          files.                              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Additional Options ─────────────────────────────────────────────────────────╮
│ --outdir   -o  TEXT     Directory to output downloads to. [default: ./]      │
│ --prefix       TEXT     Prefix to use for naming log files. [default: fastq] │
│ --cpus         INTEGER  Total cpus used for downloading from SRA.            │
│                         [default: 1]                                         │
│ --force    -F           Overwrite existing files.                            │
│ --silent                Only critical errors will be printed.                │
│ --sleep    -s  INTEGER  Minimum amount of time to sleep between retries (API │
│                         query and download)                                  │
│                         [default: 10]                                        │
│ --version  -V           Show the version and exit.                           │
│ --verbose  -v           Print debug related text.                            │
│ --help     -h           Show this message and exit.                          │
╰──────────────────────────────────────────────────────────────────────────────╯
```

