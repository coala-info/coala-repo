# paraclu CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| paraclu | PASS | synthetic data: planted tag clusters were found. |
| paraclu_paraclu-cut | PASS | synthetic data: planted clusters were kept after cutting. |

## paraclu

### Tool Description
A tool for finding clusters in data (typically used for transcription start site clustering), requiring a minimum value threshold and an input file.

### Metadata
- **Docker Image**: quay.io/biocontainers/paraclu:10--h077b44d_6
- **Homepage**: http://cbrc3.cbrc.jp/~martin/paraclu/
- **Package**: https://anaconda.org/channels/bioconda/packages/paraclu/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/paraclu/overview
- **Total Downloads**: 9.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
paraclu: I need a minValue and a fileName
```


## paraclu_paraclu-cut

### Tool Description
Extract a subset of clusters from the output of paraclu.

### Metadata
- **Docker Image**: quay.io/biocontainers/paraclu:10--h077b44d_6
- **Homepage**: http://cbrc3.cbrc.jp/~martin/paraclu/
- **Package**: https://anaconda.org/channels/bioconda/packages/paraclu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: paraclu-cut [options] [paraclu-output-file(s)]
Extract a subset of clusters from the output of paraclu.

Options:
  -h  show this help message and exit
  -l  maximum cluster length (default 200)
  -d  minimum density increase (default 2)
  -s  density increase applies to single clusters, not cumulatively
```

## Metadata
- **Skill**: generated
