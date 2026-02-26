# emvc-2 CWL Generation Report

## emvc-2

### Tool Description
EMVC-2 v1.0

### Metadata
- **Docker Image**: quay.io/biocontainers/emvc-2:1.0--h7b50bb2_4
- **Homepage**: https://github.com/guilledufort/EMVC-2
- **Package**: https://anaconda.org/channels/bioconda/packages/emvc-2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/emvc-2/overview
- **Total Downloads**: 2.2K
- **Last updated**: 2025-06-27
- **GitHub**: https://github.com/guilledufort/EMVC-2
- **Stars**: N/A
### Original Help Text
```text
usage: emvc-2 [-h] -i BAM_FILE -r REF_FILE [-p THREADS] [-t ITERATIONS]
              [-m LEARNERS] [-v VERBOSE] [-b BYPASS_DT] -o OUT_FILE

EMVC-2 v1.0

options:
  -h, --help            show this help message and exit
  -i, --bam_file BAM_FILE
                        The bam file
  -r, --ref_file REF_FILE
                        The reference fasta file
  -p, --threads THREADS
                        The number of parallel threads (default 8)
  -t, --iterations ITERATIONS
                        The number of EM iterations (default 5)
  -m, --learners LEARNERS
                        The number of learners (default 7)
  -v, --verbose VERBOSE
                        Make output verbose (default 0)
  -b, --bypass_dt BYPASS_DT
                        Bypass Decision Tree filter (default False=0)
  -o, --out_file OUT_FILE
                        The output file name
```

