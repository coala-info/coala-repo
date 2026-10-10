# mikrokondo-tools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mikrokondo-tools_download | Not completed | every database is large (smallest is 660 MB, others up to 7.7 GB); CWL rewritten with NetworkAccess and a created output directory |
| mikrokondo-tools_samplesheet | PASS | real SARS-CoV-2 read pair and contigs give the expected sample sheet rows; FASTA input must be gzipped |

## mikrokondo-tools_download

### Tool Description
Download a external file for use in mikrokondo. This script only downloads
the file and will not untar or unzip them.

### Metadata
- **Docker Image**: quay.io/biocontainers/mikrokondo-tools:0.0.1rc0--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/mikrokondo-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/mikrokondo-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mikrokondo-tools/overview
- **Total Downloads**: 584
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/DOED-DAAD/mikrokondo-tools
- **Stars**: N/A
### Original Help Text
```text
Usage: mikrokondo-tools download [OPTIONS]

  Download a external file for use in mikrokondo. This script only downloads
  the file and will not untar or unzip them.

Options:
  -f, --file [gtdb-sketch|gtdb-shigella|dehost|kraken-std|bakta-light|bakta-full]
                                  Pick an option from the list to download
                                  [required]
  -o, --output PATH               An existing directory to download files to.
                                  [default: /]
  -h, --help                      Show this message and exit.
```


## mikrokondo-tools_samplesheet

### Tool Description
Generate a sample sheet for mikrokondo

### Metadata
- **Docker Image**: quay.io/biocontainers/mikrokondo-tools:0.0.1rc0--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/mikrokondo-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/mikrokondo-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mikrokondo-tools samplesheet [OPTIONS] INPUT_DIRECTORY

Options:
  -o, --output-sheet PATH   The file to write your created output sheet to,
                            this directory must already exist.  [required]
  -1, --read-1-suffix TEXT  A suffix to identify read 1  [default: _R1_]
  -2, --read-2-suffix TEXT  A suffix to identify read 2  [default: _R2_]
  -s, --schema-input PATH   An optional schema_input.json file pre-downloaded
                            for mikrokondo.
  -h, --help                Show this message and exit.
```

## Metadata
- **Skill**: generated
