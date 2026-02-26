# aci CWL Generation Report

## aci

### Tool Description
Amplicon Coverage Inspector (aci) for analyzing coverage across amplicons using BAM and BED files.

### Metadata
- **Docker Image**: quay.io/biocontainers/aci:1.45.251125--pyhdfd78af_0
- **Homepage**: https://github.com/erinyoung/ACI
- **Package**: https://anaconda.org/channels/bioconda/packages/aci/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/aci/overview
- **Total Downloads**: 2.5K
- **Last updated**: 2025-11-27
- **GitHub**: https://github.com/erinyoung/ACI
- **Stars**: N/A
### Original Help Text
```text
usage: aci [-h] -b BAM [BAM ...] -d BED [-o OUT] [-t THREADS]
           [--tmpdir TMPDIR] [--fail-threshold FAIL_THRESHOLD]
           [--fail-percentage FAIL_PERCENTAGE] [-log LOGLEVEL] [-v]

options:
  -h, --help            show this help message and exit
  -b, --bam BAM [BAM ...]
                        (required) input bam file(s). Supports wildcards or
                        space-separated lists.
  -d, --bed BED         (required) amplicon bedfile (4-column format)
  -o, --out OUT         directory for results (default: aci)
  -t, --threads THREADS
                        specifies number of threads to use for sorting and
                        counting (default: 4)
  --tmpdir TMPDIR       custom directory for temporary files (default: system
                        tmp)
  --fail-threshold FAIL_THRESHOLD
                        Minimum depth to consider an amplicon 'passed'
                        (default: 10)
  --fail-percentage FAIL_PERCENTAGE
                        Percentage of samples that must fail for an amplicon
                        to be flagged (default: 50)
  -log, --loglevel LOGLEVEL
                        logging level (DEBUG, INFO, WARNING, ERROR, CRITICAL)
                        (default: INFO)
  -v, --version         print version and exit
```

