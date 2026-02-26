# ffq CWL Generation Report

## ffq

### Tool Description
A command line tool to find sequencing data from SRA / GEO / ENCODE
/ ENA / EBI-EMBL / DDBJ / Biosample.

### Metadata
- **Docker Image**: quay.io/biocontainers/ffq:0.3.1--pyhdfd78af_0
- **Homepage**: https://github.com/pachterlab/ffq
- **Package**: https://anaconda.org/channels/bioconda/packages/ffq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ffq/overview
- **Total Downloads**: 14.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pachterlab/ffq
- **Stars**: N/A
### Original Help Text
```text
usage: ffq [-h] [-o OUT] [-l LEVEL] [--ftp] [--aws] [--gcp] [--ncbi] [--split]
           [--verbose] [--version]
           IDs [IDs ...]

ffq 0.3.1: A command line tool to find sequencing data from SRA / GEO / ENCODE
/ ENA / EBI-EMBL / DDBJ / Biosample.

positional arguments:
  IDs         One or multiple SRA / GEO / ENCODE / ENA / EBI-EMBL / DDBJ /
              Biosample accessions, DOIs, or paper titles

options:
  -h, --help  Show this help message and exit
  -o OUT      Path to write metadata (default: standard out)
  -l LEVEL    Max depth to fetch data within accession tree
  --ftp       Return FTP links
  --aws       Return AWS links
  --gcp       Return GCP links
  --ncbi      Return NCBI links
  --split     Split output into separate files by accession (`-o` is a
              directory)
  --verbose   Print debugging information
  --version   show program's version number and exit
```

