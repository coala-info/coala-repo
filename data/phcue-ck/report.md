# phcue-ck CWL Generation Report

## phcue-ck

### Tool Description
phcue-ck is a command line tool to obtain FTP links to FASTQ files from ENA using run accession

### Metadata
- **Docker Image**: quay.io/biocontainers/phcue-ck:0.2.0--h3dc2dae_4
- **Homepage**: https://lgi-onehealth.github.io/phcue-ck/
- **Package**: https://anaconda.org/channels/bioconda/packages/phcue-ck/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phcue-ck/overview
- **Total Downloads**: 5.6K
- **Last updated**: 2025-08-28
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
phcue-ck 0.2.0
Anders Goncalves da Silva <andersgs@gmail.com>
phcue-ck is a command line tool to obtain FTP links to FASTQ files from ENA using run accession

USAGE:
    phcue-ck [OPTIONS]

OPTIONS:
    -a, --accession <ACCESSION>...    The accession of the run to query (must be an SRR, ERR or DRR
                                      accession)
    -f, --file <FILE>                 File containing accessions to query
    -h, --help                        Print help information
    -k, --keep-single-end             Keep single end reads if there are paired end reads too
    -n, --num-requests <NUM>          Maximum number of concurrent requests to make to the ENA API
                                      (max of 10 are allowed) [default: 1]
    -o, --output-format <FORMAT>      Format for output of data. [default: json] [possible values:
                                      json, csv, csv-wide, csv-long]
    -V, --version                     Print version information
```

