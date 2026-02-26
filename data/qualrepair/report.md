# qualrepair CWL Generation Report

## qualrepair

### Tool Description
Update the FASTQ quality scores from a subsequence FASTQ.

### Metadata
- **Docker Image**: quay.io/biocontainers/qualrepair:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/clintval/qualrepair
- **Package**: https://anaconda.org/channels/bioconda/packages/qualrepair/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/qualrepair/overview
- **Total Downloads**: 137
- **Last updated**: 2025-10-31
- **GitHub**: https://github.com/clintval/qualrepair
- **Stars**: N/A
### Original Help Text
```text
usage: qualrepair [-h] --in-source IN_SOURCE --in-subseq IN_SUBSEQ
                  [--output OUTPUT]

Update the FASTQ quality scores from a subsequence FASTQ.

This tool exists because splitcode is unable to retain quality scores when
extracting subsequences from FASTQ files. This script takes a source FASTQ
file and a subsequence FASTQ file (produced by splitcode) and updates the
quality scores in the subsequence file based on the source file.

Upstream issue:

    - https://github.com/pachterlab/splitcode/issues/18

───────

options:
  -h, --help            show this help message and exit
  --in-source IN_SOURCE
                        Source FASTQ file.
  --in-subseq IN_SUBSEQ
                        Subsequence FASTQ file.
  --output OUTPUT       Output repaired FASTQ file.

Copyright © Clint Valentine 2025
```

