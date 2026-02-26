# kingfisher CWL Generation Report

## kingfisher_get

### Tool Description
Download data from ENA or SRA.

### Metadata
- **Docker Image**: quay.io/biocontainers/kingfisher:0.4.1--pyh7cba7a3_0
- **Homepage**: https://github.com/wwood/kingfisher-download
- **Package**: https://anaconda.org/channels/bioconda/packages/kingfisher/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kingfisher/overview
- **Total Downloads**: 14.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/wwood/kingfisher-download
- **Stars**: N/A
### Original Help Text
```text
usage: kingfisher get [-h] [-r RUN_IDENTIFIERS [RUN_IDENTIFIERS ...]]
                      [--run-identifiers-list RUN_IDENTIFIERS_LIST]
                      [-p BIOPROJECTS [BIOPROJECTS ...]] -m
                      {aws-http,prefetch,aws-cp,gcp-cp,ena-ascp,ena-ftp}
                      [{aws-http,prefetch,aws-cp,gcp-cp,ena-ascp,ena-ftp} ...]
                      [--output-directory OUTPUT_DIRECTORY]
                      [--download-threads DOWNLOAD_THREADS]
                      [--hide-download-progress] [--ascp-ssh-key ASCP_SSH_KEY]
                      [--ascp-args ASCP_ARGS] [--allow-paid]
                      [--allow-paid-from-aws]
                      [--aws-user-key-id AWS_USER_KEY_ID]
                      [--aws-user-key-secret AWS_USER_KEY_SECRET]
                      [--guess-aws-location] [--allow-paid-from-gcp]
                      [--gcp-project GCP_PROJECT]
                      [--gcp-user-key-file GCP_USER_KEY_FILE]
                      [--prefetch-max-size PREFETCH_MAX_SIZE]
                      [--check-md5sums]
                      [-f {sra,fastq,fastq.gz,fasta,fasta.gz} [{sra,fastq,fastq.gz,fasta,fasta.gz} ...]]
                      [--force] [--unsorted] [--stdout]
                      [-t EXTRACTION_THREADS] [--debug] [--version] [--quiet]
                      [--full-help] [--full-help-roff]
kingfisher get: error: ambiguous option: --h could match --help, --hide-download-progress, --hide_download_progress
```


## kingfisher_extract

### Tool Description
Extract .sra format files into FASTQ or FASTA format, compressed or uncompressed.

### Metadata
- **Docker Image**: quay.io/biocontainers/kingfisher:0.4.1--pyh7cba7a3_0
- **Homepage**: https://github.com/wwood/kingfisher-download
- **Package**: https://anaconda.org/channels/bioconda/packages/kingfisher/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kingfisher extract [-h] --sra SRA [--output-directory OUTPUT_DIRECTORY]
                          [-f {sra,fastq,fastq.gz,fasta,fasta.gz} [{sra,fastq,fastq.gz,fasta,fasta.gz} ...]]
                          [--force] [--unsorted] [--stdout] [-t THREADS]
                          [--debug] [--version] [--quiet] [--full-help]
                          [--full-help-roff]

Extract .sra format files into FASTQ or FASTA format, compressed or
uncompressed.

options:
  -h, --help            show this help message and exit

extraction options:
  --sra SRA             Extract this SRA file [required]
  --output-directory OUTPUT_DIRECTORY, --output_directory OUTPUT_DIRECTORY
                        Output directory to write to [default: current working
                        directory]
  -f {sra,fastq,fastq.gz,fasta,fasta.gz} [{sra,fastq,fastq.gz,fasta,fasta.gz} ...], --output-format-possibilities {sra,fastq,fastq.gz,fasta,fasta.gz} [{sra,fastq,fastq.gz,fasta,fasta.gz} ...], --output_format_possibilities {sra,fastq,fastq.gz,fasta,fasta.gz} [{sra,fastq,fastq.gz,fasta,fasta.gz} ...]
                        Allowable output formats. If more than one is
                        specified, downloaded data will processed as little as
                        possible [default: "fastq fastq.gz"]
  --force               Re-download / extract files even if they already exist
                        [default: Do not].
  --unsorted            Output the sequences in arbitrary order, usually the
                        order that they appear in the .sra file. Even pairs of
                        reads may be in the usual order, but it is possible to
                        tell which pair is which, and which is a forward and
                        which is a reverse read from the name [default: Do
                        not]. Currently requires download from NCBI rather
                        than ENA.
  --stdout              Output sequences to STDOUT. Currently requires
                        --unsorted [default: Do not].
  -t THREADS, --threads THREADS
                        Number of threads to use for extraction [default: 8]

Other general options:
  --debug               output debug information
  --version             output version information and quit
  --quiet               only output errors
  --full-help, --full_help
                        print longer help message
  --full-help-roff, --full_help_roff
                        print longer help message in ROFF (manpage) format
```


## kingfisher_compressed

### Tool Description
kingfisher: error: argument subparser_name: invalid choice: 'compressed' (choose from 'get', 'extract', 'annotate')

### Metadata
- **Docker Image**: quay.io/biocontainers/kingfisher:0.4.1--pyh7cba7a3_0
- **Homepage**: https://github.com/wwood/kingfisher-download
- **Package**: https://anaconda.org/channels/bioconda/packages/kingfisher/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kingfisher [-h] {get,extract,annotate} ...
kingfisher: error: argument subparser_name: invalid choice: 'compressed' (choose from 'get', 'extract', 'annotate')
```


## kingfisher_annotate

### Tool Description
Annotate runs by their metadata e.g. number of sequenced bases, BioSample attributes, etc.

### Metadata
- **Docker Image**: quay.io/biocontainers/kingfisher:0.4.1--pyh7cba7a3_0
- **Homepage**: https://github.com/wwood/kingfisher-download
- **Package**: https://anaconda.org/channels/bioconda/packages/kingfisher/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kingfisher annotate [-h] [-r RUN_IDENTIFIERS [RUN_IDENTIFIERS ...]]
                           [--run-identifiers-list RUN_IDENTIFIERS_LIST]
                           [-p BIOPROJECTS [BIOPROJECTS ...]] [-o OUTPUT_FILE]
                           [-f {human,csv,tsv,json,feather,parquet}] [-a]
                           [--debug] [--version] [--quiet] [--full-help]
                           [--full-help-roff]

Annotate runs by their metadata e.g. number of sequenced bases, BioSample
attributes, etc.

options:
  -h, --help            show this help message and exit
  -r RUN_IDENTIFIERS [RUN_IDENTIFIERS ...], --run-identifiers RUN_IDENTIFIERS [RUN_IDENTIFIERS ...], --run_identifiers RUN_IDENTIFIERS [RUN_IDENTIFIERS ...]
                        Run number to download/extract e.g. ERR1739691
  --run-identifiers-list RUN_IDENTIFIERS_LIST, --run_identifiers_list RUN_IDENTIFIERS_LIST, --run-accession-list RUN_IDENTIFIERS_LIST, --run_accession_list RUN_IDENTIFIERS_LIST, --run-identifiers-list RUN_IDENTIFIERS_LIST, --run_identifiers_list RUN_IDENTIFIERS_LIST
                        Text file containing a newline-separated list of run
                        identifiers i.e. a 1 column CSV file.
  -p BIOPROJECTS [BIOPROJECTS ...], --bioprojects BIOPROJECTS [BIOPROJECTS ...]
                        BioProject IDs number(s) to download/extract from e.g.
                        PRJNA621514 or SRP260223
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        Output file to write to [default: stdout]
  -f {human,csv,tsv,json,feather,parquet}, --output-format {human,csv,tsv,json,feather,parquet}, --output_format {human,csv,tsv,json,feather,parquet}
                        Output format [default human]
  -a, --all-columns, --all_columns
                        Print all metadata columns [default: Print only a few
                        select ones]

Other general options:
  --debug               output debug information
  --version             output version information and quit
  --quiet               only output errors
  --full-help, --full_help
                        print longer help message
  --full-help-roff, --full_help_roff
                        print longer help message in ROFF (manpage) format
```


## kingfisher_sequenced

### Tool Description
kingfisher: error: argument subparser_name: invalid choice: 'sequenced' (choose from 'get', 'extract', 'annotate')

### Metadata
- **Docker Image**: quay.io/biocontainers/kingfisher:0.4.1--pyh7cba7a3_0
- **Homepage**: https://github.com/wwood/kingfisher-download
- **Package**: https://anaconda.org/channels/bioconda/packages/kingfisher/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kingfisher [-h] {get,extract,annotate} ...
kingfisher: error: argument subparser_name: invalid choice: 'sequenced' (choose from 'get', 'extract', 'annotate')
```

