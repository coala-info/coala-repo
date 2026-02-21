# biocode CWL Generation Report

## biocode

### Tool Description
FAIL to generate CWL: biocode not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/biocode:0.12.1--pyhdfd78af_0
- **Homepage**: http://github.com/jorvis/biocode
- **Package**: https://anaconda.org/channels/bioconda/packages/biocode/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/biocode/overview
- **Total Downloads**: 11.3K
- **Last updated**: 2025-07-22
- **GitHub**: https://github.com/jorvis/biocode
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: biocode not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: biocode not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## biocode_fastq_simple_stats.py

### Tool Description
Provides simple quantitative statistics for a given FASTQ file

### Metadata
- **Docker Image**: quay.io/biocontainers/biocode:0.12.1--pyhdfd78af_0
- **Homepage**: http://github.com/jorvis/biocode
- **Package**: https://anaconda.org/channels/bioconda/packages/biocode/overview
- **Validation**: PASS
### Original Help Text
```text
usage: fastq_simple_stats.py [-h] [-o OUTPUT_FILE] [--individual]
                             [-p PROGRESS_INTERVAL]
                             N [N ...]

Provides simple quantitative statistics for a given FASTQ file

positional arguments:
  N                     Path to one or more input files, separated by spaces

options:
  -h, --help            show this help message and exit
  -o, --output_file OUTPUT_FILE
                        Optional path to an output file to be created, else
                        prints on STDOUT
  --individual          Report stats on each file individually
  -p, --progress_interval PROGRESS_INTERVAL
                        Pass an integer to show progress ever N entries on
                        STDERR
```

## biocode_filter_fasta_by_header_regex.py

### Tool Description
Filters a FASTA file by user-supplied regular expression to match the headers

### Metadata
- **Docker Image**: quay.io/biocontainers/biocode:0.12.1--pyhdfd78af_0
- **Homepage**: http://github.com/jorvis/biocode
- **Package**: https://anaconda.org/channels/bioconda/packages/biocode/overview
- **Validation**: PASS
### Original Help Text
```text
usage: filter_fasta_by_header_regex.py [-h] -i INPUT_FILE [-o OUTPUT_FILE]
                                       -r REGEX

Filters a FASTA file by user-supplied regular expression to match the headers

options:
  -h, --help            show this help message and exit
  -i, --input_file INPUT_FILE
                        Path to an input FASTA file
  -o, --output_file OUTPUT_FILE
                        Path to an output file to be created
  -r, --regex REGEX     Regular expression to match against each header
```

## biocode_strip_fasta_headers_after_regex.py

### Tool Description
Modified the headers of a FASTA file based on user options

### Metadata
- **Docker Image**: quay.io/biocontainers/biocode:0.12.1--pyhdfd78af_0
- **Homepage**: http://github.com/jorvis/biocode
- **Package**: https://anaconda.org/channels/bioconda/packages/biocode/overview
- **Validation**: PASS
### Original Help Text
```text
usage: strip_fasta_headers_after_regex.py [-h] -i INPUT_FILE [-o OUTPUT_FILE]
                                          -r REGEX -n INCLUDE

Modified the headers of a FASTA file based on user options

options:
  -h, --help            show this help message and exit
  -i, --input_file INPUT_FILE
                        Path to an input FASTA file
  -o, --output_file OUTPUT_FILE
                        Path to an output file to be created
  -r, --regex REGEX     Regular expression to match against each header
  -n, --include INCLUDE
                        Include the regex portion in the output? Values are
                        yes or no
```

## biocode_add_blast_results_to_gff3_product.py

### Tool Description
Updates GFF3 files with gene products from BLAST

### Metadata
- **Docker Image**: quay.io/biocontainers/biocode:0.12.1--pyhdfd78af_0
- **Homepage**: http://github.com/jorvis/biocode
- **Package**: https://anaconda.org/channels/bioconda/packages/biocode/overview
- **Validation**: PASS
### Original Help Text
```text
usage: add_blast_results_to_gff3_product.py [-h] -i INPUT_FILE -b BLAST
                                            -s SOURCE -o OUTPUT_FILE

Updates GFF3 files with gene products from BLAST

options:
  -h, --help            show this help message and exit
  -i, --input_file INPUT_FILE
                        Path to an input GFF3 file to be read
  -b, --blast BLAST     Path to an input BLAST tab file to be read
  -s, --source SOURCE   Becomes the source (2nd) column of the GFF output
  -o, --output_file OUTPUT_FILE
                        Path to an output GFF3 file to be created
```

