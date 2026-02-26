# mmvc CWL Generation Report

## mmvc

### Tool Description
call variants using a multinomial model sampled by MCMC

### Metadata
- **Docker Image**: quay.io/biocontainers/mmvc:1.0.2--0
- **Homepage**: https://github.com/veg/mmvc
- **Package**: https://anaconda.org/channels/bioconda/packages/mmvc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mmvc/overview
- **Total Downloads**: 5.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/veg/mmvc
- **Stars**: N/A
### Original Help Text
```text
usage: mmvc [-g GRID-DENSITY] [-c CHAIN-LENGTH] [-b BURNIN-FRACTION]
            [-t TARGET-RATE] [-p POSTERIOR-THRESHOLD] [-f FILTER]
            [-j JSON-REPORT] [-h] msa

call variants using a multinomial model sampled by MCMC

positional arguments:
  msa

optional arguments:
  -g, --grid-density GRID-DENSITY
                        (type: Int64, default: 10)
  -c, --chain-length CHAIN-LENGTH
                        (type: Int64, default: 2000000)
  -b, --burnin-fraction BURNIN-FRACTION
                        (type: Float64, default: 0.5)
  -t, --target-rate TARGET-RATE
                        (type: Float64, default: 0.01)
  -p, --posterior-threshold POSTERIOR-THRESHOLD
                        (type: Float64, default: 0.95)
  -f, --filter FILTER
  -j, --json-report JSON-REPORT

  -h, --help            show this help message and exit
```

