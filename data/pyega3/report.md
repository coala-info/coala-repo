# pyega3 CWL Generation Report

## pyega3_datasets

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyega3:5.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/EGA-archive/ega-download-client
- **Package**: https://anaconda.org/channels/bioconda/packages/pyega3/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/pyega3/overview
- **Total Downloads**: 48.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/EGA-archive/ega-download-client
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: pyega3 datasets [-h]
pyega3 datasets: error: argument -h/--help: ignored explicit argument 'elp'
```


## pyega3_files

### Tool Description
List files in a dataset

### Metadata
- **Docker Image**: quay.io/biocontainers/pyega3:5.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/EGA-archive/ega-download-client
- **Package**: https://anaconda.org/channels/bioconda/packages/pyega3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyega3 files [-h] identifier

positional arguments:
  identifier  Dataset ID (e.g. EGAD00000000001)

options:
  -h, --help  show this help message and exit
```


## pyega3_fetch

### Tool Description
Fetch data from EGA.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyega3:5.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/EGA-archive/ega-download-client
- **Package**: https://anaconda.org/channels/bioconda/packages/pyega3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyega3 fetch [-h] [--reference-name REFERENCE_NAME]
                    [--reference-md5 REFERENCE_MD5] [--start START]
                    [--end END] [--format {BAM,CRAM,VCF,BCF}]
                    [--max-retries MAX_RETRIES] [--retry-wait RETRY_WAIT]
                    [--output-dir OUTPUT_DIR] [--delete-temp-files]
                    identifier

positional arguments:
  identifier            Id for dataset (e.g. EGAD00000000001) or file (e.g.
                        EGAF12345678901)

options:
  -h, --help            show this help message and exit
  --reference-name REFERENCE_NAME, -r REFERENCE_NAME
                        The reference sequence name, for example 'chr1', '1',
                        or 'chrX'. If unspecified, all data is returned.
  --reference-md5 REFERENCE_MD5, -m REFERENCE_MD5
                        The MD5 checksum uniquely representing the requested
                        reference sequence as a lower-case hexadecimal string,
                        calculated as the MD5 of the upper-case sequence
                        excluding all whitespace characters.
  --start START, -s START
                        The start position of the range on the reference,
                        0-based, inclusive. If specified, reference-name or
                        reference-md5 must also be specified.
  --end END, -e END     The end position of the range on the reference,
                        0-based exclusive. If specified, reference-name or
                        reference-md5 must also be specified.
  --format {BAM,CRAM,VCF,BCF}, -f {BAM,CRAM,VCF,BCF}
                        The format of data to request.
  --max-retries MAX_RETRIES, -M MAX_RETRIES
                        The maximum number of times to retry a failed
                        transfer. Any negative number means infinite number of
                        retries.
  --retry-wait RETRY_WAIT, -W RETRY_WAIT
                        The number of seconds to wait before retrying a failed
                        transfer.
  --output-dir OUTPUT_DIR
                        Output directory. The files will be saved into this
                        directory. Must exist. Default: the current working
                        directory.
  --delete-temp-files   Do not keep those temporary, partial files which were
                        left on the disk after a failed transfer.
```


## pyega3_JSON

### Tool Description
pyega3: error: argument subcommand: invalid choice: 'JSON' (choose from 'datasets', 'files', 'fetch')

### Metadata
- **Docker Image**: quay.io/biocontainers/pyega3:5.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/EGA-archive/ega-download-client
- **Package**: https://anaconda.org/channels/bioconda/packages/pyega3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyega3 [-h] [-d] [-cf CONFIG_FILE] [-sf SERVER_FILE] [-c CONNECTIONS]
              [-t] [-ms MAX_SLICE_SIZE] [-j] [-v]
              {datasets,files,fetch} ...
pyega3: error: argument subcommand: invalid choice: 'JSON' (choose from 'datasets', 'files', 'fetch')
```


## pyega3_Download

### Tool Description
pyega3: error: argument subcommand: invalid choice: 'Download' (choose from 'datasets', 'files', 'fetch')

### Metadata
- **Docker Image**: quay.io/biocontainers/pyega3:5.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/EGA-archive/ega-download-client
- **Package**: https://anaconda.org/channels/bioconda/packages/pyega3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyega3 [-h] [-d] [-cf CONFIG_FILE] [-sf SERVER_FILE] [-c CONNECTIONS]
              [-t] [-ms MAX_SLICE_SIZE] [-j] [-v]
              {datasets,files,fetch} ...
pyega3: error: argument subcommand: invalid choice: 'Download' (choose from 'datasets', 'files', 'fetch')
```


## pyega3_this

### Tool Description
pyega3: error: argument subcommand: invalid choice: 'this' (choose from 'datasets', 'files', 'fetch')

### Metadata
- **Docker Image**: quay.io/biocontainers/pyega3:5.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/EGA-archive/ega-download-client
- **Package**: https://anaconda.org/channels/bioconda/packages/pyega3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyega3 [-h] [-d] [-cf CONFIG_FILE] [-sf SERVER_FILE] [-c CONNECTIONS]
              [-t] [-ms MAX_SLICE_SIZE] [-j] [-v]
              {datasets,files,fetch} ...
pyega3: error: argument subcommand: invalid choice: 'this' (choose from 'datasets', 'files', 'fetch')
```


## Metadata
- **Skill**: generated
