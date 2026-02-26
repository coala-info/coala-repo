# atol-genome-launcher CWL Generation Report

## atol-genome-launcher_rnaseq-manifest-generator

### Tool Description
Generate a manifest of RNAseq data for an organism.

### Metadata
- **Docker Image**: quay.io/biocontainers/atol-genome-launcher:0.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/TomHarrop/atol-genome-launcher
- **Package**: https://anaconda.org/channels/bioconda/packages/atol-genome-launcher/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/atol-genome-launcher/overview
- **Total Downloads**: 171
- **Last updated**: 2026-02-20
- **GitHub**: https://github.com/TomHarrop/atol-genome-launcher
- **Stars**: N/A
### Original Help Text
```text
usage: rnaseq-manifest-generator [-h] --resources RESOURCES
                                 --packages PACKAGES
                                 organism_grouping_key manifest

Generate a manifest of RNAseq data for an organism.

positional arguments:
  organism_grouping_key
                        Data Mapper organism_grouping_key
  manifest              Path to output the manifest

options:
  -h, --help            show this help message and exit
  --resources RESOURCES
                        Mapped Resources CSV. FIXME. Should be JSON.
  --packages PACKAGES   Mapped Packages CSV. FIXME. Should be JSON.
```


## atol-genome-launcher_rnaseq-reads-downloader

### Tool Description
Downloads RNA-Seq reads based on a manifest file.

### Metadata
- **Docker Image**: quay.io/biocontainers/atol-genome-launcher:0.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/TomHarrop/atol-genome-launcher
- **Package**: https://anaconda.org/channels/bioconda/packages/atol-genome-launcher/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rnaseq-reads-downloader [-h] [--parallel_downloads PARALLEL_DOWNLOADS]
                               manifest outdir

positional arguments:
  manifest              Path to the manifest
  outdir                Output directory

options:
  -h, --help            show this help message and exit
  --parallel_downloads PARALLEL_DOWNLOADS
                        Number of parallel downloads
```


## atol-genome-launcher_bpa-file-downloader

### Tool Description
Downloads files from a given URL and saves them with a specified name.

### Metadata
- **Docker Image**: quay.io/biocontainers/atol-genome-launcher:0.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/TomHarrop/atol-genome-launcher
- **Package**: https://anaconda.org/channels/bioconda/packages/atol-genome-launcher/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bpa-file-downloader [-h] [--file_checksum FILE_CHECKSUM]
                           bioplatforms_url file_name

positional arguments:
  bioplatforms_url
  file_name

options:
  -h, --help            show this help message and exit
  --file_checksum FILE_CHECKSUM
```

