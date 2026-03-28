# clinvar-tsv CWL Generation Report

## clinvar-tsv_clinvar_tsv

### Tool Description
A tool for processing ClinVar data.

### Metadata
- **Docker Image**: quay.io/biocontainers/clinvar-tsv:0.6.3--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/clinvar-tsv
- **Package**: https://anaconda.org/channels/bioconda/packages/clinvar-tsv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clinvar-tsv/overview
- **Total Downloads**: 18.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/clinvar-tsv
- **Stars**: N/A
### Original Help Text
```text
usage: clinvar-tsv [-h] [--version]
                   {inspect,main,parse_xml,normalize_tsv,merge_tsvs} ...

positional arguments:
  {inspect,main,parse_xml,normalize_tsv,merge_tsvs}
    inspect             Show files to be created
    main                Run the full process pipeline
    parse_xml           Parse the Clinvar XML
    normalize_tsv       Parse the Clinvar XML
    merge_tsvs          Merge TSV file (result: one per VCV)

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
```


## clinvar-tsv_clinvar_tsv main

### Tool Description
Main command for clinvar-tsv

### Metadata
- **Docker Image**: quay.io/biocontainers/clinvar-tsv:0.6.3--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/clinvar-tsv
- **Package**: https://anaconda.org/channels/bioconda/packages/clinvar-tsv/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clinvar-tsv main [-h] [--verbose] --b37-path B37_PATH --b38-path
                        B38_PATH [--work-dir WORK_DIR] [--cores CORES]
                        [--debug] --clinvar-version CLINVAR_VERSION

options:
  -h, --help            show this help message and exit
  --verbose             Enable verbose output
  --b37-path B37_PATH   Path to GRCh37 FAI-indexed FASTA file.
  --b38-path B38_PATH   Path to GRCh38 FAI-indexed FASTA file.
  --work-dir WORK_DIR   Path to working directory
  --cores CORES         Number of cores to use
  --debug               Enables debugging helps
  --clinvar-version CLINVAR_VERSION
                        String to put as clinvar version
```


## clinvar-tsv_clinvar_tsv parse_xml

### Tool Description
Parse ClinVar XML file into TSV format.

### Metadata
- **Docker Image**: quay.io/biocontainers/clinvar-tsv:0.6.3--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/clinvar-tsv
- **Package**: https://anaconda.org/channels/bioconda/packages/clinvar-tsv/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clinvar-tsv parse_xml [-h] --clinvar-xml CLINVAR_XML --output-b37-small
                             OUTPUT_B37_SMALL --output-b37-sv OUTPUT_B37_SV
                             --output-b38-small OUTPUT_B38_SMALL
                             --output-b38-sv OUTPUT_B38_SV
                             [--max-rcvs MAX_RCVS]

options:
  -h, --help            show this help message and exit
  --clinvar-xml CLINVAR_XML
                        Path to Clinvar XML file.
  --output-b37-small OUTPUT_B37_SMALL
                        Output path for small vars GRCh37 file.
  --output-b37-sv OUTPUT_B37_SV
                        Output path for SV GRCh37 file.
  --output-b38-small OUTPUT_B38_SMALL
                        Output path for small vars GRCh38 file.
  --output-b38-sv OUTPUT_B38_SV
                        Output path for SV GRCh38 file.
  --max-rcvs MAX_RCVS   Maximal number of RCV records to process.
```


## Metadata
- **Skill**: generated
