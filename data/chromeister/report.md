# chromeister CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| chromeister_CHROMEISTER | PASS |  |
| chromeister_compute_score.R | PASS |  |
| chromeister_detect_events.py | PASS |  |

## Metadata
- **Skill**: generated

## chromeister_detect_events.py

### Tool Description
Detect genomic events (synteny, inversions, translocations) from Chromeister comparison results.

### Metadata
- **Docker Image**: quay.io/biocontainers/chromeister:1.5.a--h7b50bb2_6
- **Homepage**: https://github.com/estebanpw/chromeister
- **Package**: https://anaconda.org/channels/bioconda/packages/chromeister/overview
- **Validation**: PASS
### Original Help Text
```text
Error, use:  /usr/local/bin/detect_events.py  <raw matrix> [plot|png]
```

## chromeister_CHROMEISTER

### Tool Description
Ultra-fast pairwise genome comparison that writes a comparison matrix (dotplot) and a .csv axis label file

### Metadata
- **Docker Image**: quay.io/biocontainers/chromeister:1.5.a--h7b50bb2_6
- **Homepage**: https://github.com/estebanpw/chromeister
- **Package**: https://anaconda.org/channels/bioconda/packages/chromeister/overview
- **Validation**: PASS
### Original Help Text
```text
USAGE:
           CHROMEISTER -query [query] -db [database] -out [outfile]
OPTIONAL:
           -kmer       [Integer:   k>1 (default 32)]
           -diffuse    [Integer:   z>0 (default 4)]
           -dimension  Size of the output [Integer:   d>0 (default 1000)]
           -out        [File path]
           --help      Shows help for program usage

PLEASE NOTICE: The reverse complementary is calculated for the QUERY.
```

## chromeister_compute_score.R

### Tool Description
Compute the similarity score of a CHROMEISTER comparison matrix and write the filtered matrix, its plot and the conserved hits (usage: compute_score.R <matrix> <matsize>)

### Metadata
- **Docker Image**: quay.io/biocontainers/chromeister:1.5.a--h7b50bb2_6
- **Homepage**: https://github.com/estebanpw/chromeister
- **Package**: https://anaconda.org/channels/bioconda/packages/chromeister/overview
- **Validation**: PASS
### Original Help Text
```text
Error: USE: Rscript --vanilla plot.R <matrix> <matsize>
Execution halted
```

