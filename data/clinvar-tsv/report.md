# clinvar-tsv CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| clinvar-tsv_clinvar_tsv_main | Not completed | pipeline, skipped: main runs the full Snakemake pipeline, which downloads the whole ClinVar release and needs GRCh37 and GRCh38 genomes. |
| clinvar-tsv_clinvar_tsv_parse_xml | PASS |  |
| clinvar-tsv_merge_tsvs | PASS |  |
| clinvar-tsv_normalize_tsv | PASS |  |

## clinvar-tsv_clinvar_tsv_main

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


## clinvar-tsv_clinvar_tsv_parse_xml

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


## clinvar-tsv_normalize_tsv

### Tool Description
Normalize variants of a parsed ClinVar TSV file against a reference FASTA (the help says: Parse the Clinvar XML)

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
usage: clinvar-tsv normalize_tsv [-h] --reference REFERENCE --input-tsv
                                 INPUT_TSV --output-tsv OUTPUT_TSV

options:
  -h, --help            show this help message and exit
  --reference REFERENCE
                        Path to reference FASTA file
  --input-tsv INPUT_TSV
                        Path to input TSV file.
  --output-tsv OUTPUT_TSV
                        Path to output TSV file.
```

## clinvar-tsv_merge_tsvs

### Tool Description
Merge TSV file (result: one per VCV)

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
usage: clinvar-tsv merge_tsvs [-h] --input-tsv INPUT_TSV --output-tsv
                              OUTPUT_TSV --clinvar-version CLINVAR_VERSION

options:
  -h, --help            show this help message and exit
  --input-tsv INPUT_TSV
                        Path to input TSV file.
  --output-tsv OUTPUT_TSV
                        Path to output TSV file.
  --clinvar-version CLINVAR_VERSION
                        String to put as clinvar version
```

## Metadata
- **Skill**: generated
