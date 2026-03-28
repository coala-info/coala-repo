# eagle CWL Generation Report

## eagle_valid

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/eagle:0.9.4.6--pyh5ca1d4c_0
- **Homepage**: https://bitbucket.org/christopherschroeder/eagle
- **Package**: https://anaconda.org/channels/bioconda/packages/eagle/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/eagle/overview
- **Total Downloads**: 19.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: eagle [-h] {interface,convert,meta,extract} ...
eagle: error: argument command: invalid choice: 'valid' (choose from 'interface', 'convert', 'meta', 'extract')
```


## eagle_interface

### Tool Description
Starts the EAGLE web interface.

### Metadata
- **Docker Image**: quay.io/biocontainers/eagle:0.9.4.6--pyh5ca1d4c_0
- **Homepage**: https://bitbucket.org/christopherschroeder/eagle
- **Package**: https://anaconda.org/channels/bioconda/packages/eagle/overview
- **Validation**: PASS

### Original Help Text
```text
usage: eagle interface [-h] [--port PORT] [--public] [--nodebug] --config
                       CONFIG [--processes PROCESSES]

optional arguments:
  -h, --help            show this help message and exit
  --port PORT, -p PORT  port (default: 8000)
  --public              listen for external connections
  --nodebug             disable debug messages
  --config CONFIG, -c CONFIG
                        config file to use.
  --processes PROCESSES, -m PROCESSES
                        use up to M parallel processes to serve HTTP requests
                        (default=1).
```


## eagle_convert

### Tool Description
Convert VCF files to other formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/eagle:0.9.4.6--pyh5ca1d4c_0
- **Homepage**: https://bitbucket.org/christopherschroeder/eagle
- **Package**: https://anaconda.org/channels/bioconda/packages/eagle/overview
- **Validation**: PASS

### Original Help Text
```text
usage: eagle convert [-h] [--samples [SAMPLES [SAMPLES ...]]] [--ref REF]
                     input outdir

positional arguments:
  input                 the input in vcf format
  outdir                the output directory

optional arguments:
  -h, --help            show this help message and exit
  --samples [SAMPLES [SAMPLES ...]]
                        limit the output creation to these samples
  --ref REF             the reference in fasta format to extract a variant
                        motifs information
```


## eagle_meta

### Tool Description
Manage meta information for eagle-data-files.

### Metadata
- **Docker Image**: quay.io/biocontainers/eagle:0.9.4.6--pyh5ca1d4c_0
- **Homepage**: https://bitbucket.org/christopherschroeder/eagle
- **Package**: https://anaconda.org/channels/bioconda/packages/eagle/overview
- **Validation**: PASS

### Original Help Text
```text
usage: eagle meta [-h] [-s S] [--delete] [--storelist [STORELIST]]
                  input [name]

positional arguments:
  input                 the eagle-data-file
  name                  the name of the meta information

optional arguments:
  -h, --help            show this help message and exit
  -s S                  write this value as meta information
  --delete              delete the meta information
  --storelist [STORELIST]
                        a list containing key value pairs to store
```


## eagle_files

### Tool Description
A command-line tool with subcommands for various operations.

### Metadata
- **Docker Image**: quay.io/biocontainers/eagle:0.9.4.6--pyh5ca1d4c_0
- **Homepage**: https://bitbucket.org/christopherschroeder/eagle
- **Package**: https://anaconda.org/channels/bioconda/packages/eagle/overview
- **Validation**: PASS

### Original Help Text
```text
usage: eagle [-h] {interface,convert,meta,extract} ...
eagle: error: argument command: invalid choice: 'files' (choose from 'interface', 'convert', 'meta', 'extract')
```


## eagle_extract

### Tool Description
Extracts regions from BAM/SAM/CRAM files based on a capture kit file.

### Metadata
- **Docker Image**: quay.io/biocontainers/eagle:0.9.4.6--pyh5ca1d4c_0
- **Homepage**: https://bitbucket.org/christopherschroeder/eagle
- **Package**: https://anaconda.org/channels/bioconda/packages/eagle/overview
- **Validation**: PASS

### Original Help Text
```text
usage: eagle extract [-h] [--samplerate SAMPLERATE] [-w W] bam capturekit

positional arguments:
  bam                   a bam/sam/cram file
  capturekit            a capturekit gff or bed file

optional arguments:
  -h, --help            show this help message and exit
  --samplerate SAMPLERATE
                        only use this fraction of regions
  -w W                  directly write the stats to this eagle file
```


## Metadata
- **Skill**: generated
