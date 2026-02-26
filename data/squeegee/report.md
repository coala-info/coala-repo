# squeegee CWL Generation Report

## squeegee

### Tool Description
Scoring and final predictions.

### Metadata
- **Docker Image**: quay.io/biocontainers/squeegee:0.2.0--hdfd78af_0
- **Homepage**: https://gitlab.com/treangenlab/squeegee
- **Package**: https://anaconda.org/channels/bioconda/packages/squeegee/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/squeegee/overview
- **Total Downloads**: 5.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: squeegee [-h] [--numcore NUMCORE] [--min-reads MIN_READS]
                [--min-abundance MIN_ABUNDANCE]
                [--min-prevalence MIN_PREVALENCE] [--min-score MIN_SCORE]
                [--min-align MIN_ALIGN] [--stacked-idx STACKED_IDX]
                [--version]
                metadata krakendb output

Scoring and final predictions.

positional arguments:
  metadata              input matadata in txt format
  krakendb              directory of kraken database
  output                squeegee output directory

optional arguments:
  -h, --help            show this help message and exit
  --numcore NUMCORE     Number of threads.
  --min-reads MIN_READS
                        Minimum number of reads for a species to be consider
                        as truely present in a sample.
  --min-abundance MIN_ABUNDANCE
                        Minimum abundance for a species to be consider as
                        truely present in a sample.
  --min-prevalence MIN_PREVALENCE
                        Minimum prevalence threshold for a species to be
                        indentified as a contaminant species.
  --min-score MIN_SCORE
                        Minimum contaminant score threshold for a species to
                        be indentified as a contaminant species.
  --min-align MIN_ALIGN
                        Minimum breadth of genome coverge threshold for a
                        species to be indentified as a contaminant species.
  --stacked-idx STACKED_IDX
                        Index to determine whether or not aligned reads have
                        been stacked in small region.
  --version             show program's version number and exit
```

