# tgtools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| tgtools_import_hmmIBD | PASS |  |
| tgtools_import_snp-distance | PASS |  |
| tgtools_import_transphylo | PASS |  |

## tgtools_import_snp-distance

### Tool Description
Convert snp-distance output to trjson format.

### Metadata
- **Docker Image**: quay.io/biocontainers/tgtools:0.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/jodyphelan/tgtools
- **Package**: https://anaconda.org/channels/bioconda/packages/tgtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tgtools import snp-distance [-h] -i INPUT -o OUTPUT -d MAX_DIST

options:
  -h, --help            show this help message and exit
  -i, --input INPUT     input file
  -o, --output OUTPUT   output file
  -d, --max-dist MAX_DIST
                        Maximum snp distance
```

## tgtools_import_transphylo

### Tool Description
Convert transphylo output to trjson format.

### Metadata
- **Docker Image**: quay.io/biocontainers/tgtools:0.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/jodyphelan/tgtools
- **Package**: https://anaconda.org/channels/bioconda/packages/tgtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tgtools import transphylo [-h] -i INPUT -o OUTPUT -p MIN_PROBABILITY

options:
  -h, --help            show this help message and exit
  -i, --input INPUT     input file
  -o, --output OUTPUT   output file
  -p, --min-probability MIN_PROBABILITY
                        Minimum probability for edge
```

## tgtools_import_hmmIBD

### Tool Description
Convert hmmIBD output to trjson format.

### Metadata
- **Docker Image**: quay.io/biocontainers/tgtools:0.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/jodyphelan/tgtools
- **Package**: https://anaconda.org/channels/bioconda/packages/tgtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tgtools import hmmIBD [-h] -i INPUT -o OUTPUT -d MIN_IBD

options:
  -h, --help            show this help message and exit
  -i, --input INPUT     input file
  -o, --output OUTPUT   output file
  -d, --min-ibd MIN_IBD
                        Minimum IBD value
```

