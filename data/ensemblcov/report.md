# ensemblcov CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ensemblcov_auto-generate | Not completed | too heavy: downloads the 1.9 GB GENCODE v48 GTF and converts about 200 genes per minute (1592 of 86364 genes in 8 minutes) |
| ensemblcov_countconvert | Failed | tool bug: gene names are matched to counts by line position, so a counts file with a header row or a different row order gets values on the wrong genes and a gene subset crashes |
| ensemblcov_differentialexpression | Failed | tool bug: gene names are matched to the table by line position, so a header row or a different row order gives values on the wrong genes |
| ensemblcov_exon-ensembl | Not completed | too heavy: downloads the 1.9 GB GENCODE v48 GTF and did not finish 3 exon ids in 10 minutes |
| ensemblcov_gene-ensembl | Failed | image problem: the program stops at the extract step with file not found; it calls ./src/awk.sh, which is not in the image |
| ensemblcov_gtf-annotate-generate | PASS |  |
| ensemblcov_threaded-auto | PASS |  |

## ensemblcov_threaded-auto

### Tool Description
threaded version of ensembl auto gene conversion

### Metadata
- **Docker Image**: quay.io/biocontainers/ensemblcov:0.1.0--h4349ce8_0
- **Homepage**: https://github.com/IBCHgenomic/ensemlcov
- **Package**: https://anaconda.org/channels/bioconda/packages/ensemblcov/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ensemblcov/overview
- **Total Downloads**: 290
- **Last updated**: 2025-07-21
- **GitHub**: https://github.com/IBCHgenomic/ensemlcov
- **Stars**: N/A
### Original Help Text
```text
threaded version of ensembl auto gene conversion

Usage: ensemblcov threaded-auto <GENERATE>

Arguments:
  <GENERATE>  provide yes as argument

Options:
  -h, --help  Print help
```


## ensemblcov_auto-generate

### Tool Description
autogenerate the ensemble gene conversion

### Metadata
- **Docker Image**: quay.io/biocontainers/ensemblcov:0.1.0--h4349ce8_0
- **Homepage**: https://github.com/IBCHgenomic/ensemlcov
- **Package**: https://anaconda.org/channels/bioconda/packages/ensemblcov/overview
- **Validation**: PASS

### Original Help Text
```text
autogenerate the ensemble gene conversion

Usage: ensemblcov auto-generate <GENERATE>

Arguments:
  <GENERATE>  provide yes as argument

Options:
  -h, --help  Print help
```


## ensemblcov_gtf-annotate-generate

### Tool Description
Generate annotations from GTF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ensemblcov:0.1.0--h4349ce8_0
- **Homepage**: https://github.com/IBCHgenomic/ensemlcov
- **Package**: https://anaconda.org/channels/bioconda/packages/ensemblcov/overview
- **Validation**: PASS

### Original Help Text
```text
error: unexpected argument '--h' found

  tip: a similar argument exists: '--help'

Usage: ensemblcov gtf-annotate-generate --help <GTF>

For more information, try '--help'.
```


## ensemblcov_countconvert

### Tool Description
Convert counts from one format to another.

### Metadata
- **Docker Image**: quay.io/biocontainers/ensemblcov:0.1.0--h4349ce8_0
- **Homepage**: https://github.com/IBCHgenomic/ensemlcov
- **Package**: https://anaconda.org/channels/bioconda/packages/ensemblcov/overview
- **Validation**: PASS

### Original Help Text
```text
error: unexpected argument '--h' found

  tip: a similar argument exists: '--help'

Usage: ensemblcov countconvert --help <COUNTS>

For more information, try '--help'.
```


## ensemblcov_differentialexpression

### Tool Description
id convert from differential expression

### Metadata
- **Docker Image**: quay.io/biocontainers/ensemblcov:0.1.0--h4349ce8_0
- **Homepage**: https://github.com/IBCHgenomic/ensemlcov
- **Package**: https://anaconda.org/channels/bioconda/packages/ensemblcov/overview
- **Validation**: PASS

### Original Help Text
```text
id convert from differential expression

Usage: ensemblcov differentialexpression <DIFFERNTIALEXPRESSION>

Arguments:
  <DIFFERNTIALEXPRESSION>  path to the differential expression

Options:
  -h, --help  Print help
```


## ensemblcov_gene-ensembl

### Tool Description
For more information, try '--help'.

### Metadata
- **Docker Image**: quay.io/biocontainers/ensemblcov:0.1.0--h4349ce8_0
- **Homepage**: https://github.com/IBCHgenomic/ensemlcov
- **Package**: https://anaconda.org/channels/bioconda/packages/ensemblcov/overview
- **Validation**: PASS

### Original Help Text
```text
error: unexpected argument '--h' found

  tip: a similar argument exists: '--help'

Usage: ensemblcov gene-ensembl --help <ENSEMBLID>

For more information, try '--help'.
```


## ensemblcov_exon-ensembl

### Tool Description
Generates exon-ensembl coverage data.

### Metadata
- **Docker Image**: quay.io/biocontainers/ensemblcov:0.1.0--h4349ce8_0
- **Homepage**: https://github.com/IBCHgenomic/ensemlcov
- **Package**: https://anaconda.org/channels/bioconda/packages/ensemblcov/overview
- **Validation**: PASS

### Original Help Text
```text
error: unexpected argument '--h' found

  tip: a similar argument exists: '--help'

Usage: ensemblcov exon-ensembl --help <EXONENSEMBL>

For more information, try '--help'.
```


## Metadata
- **Skill**: not generated
