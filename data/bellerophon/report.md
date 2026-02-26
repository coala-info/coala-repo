# bellerophon CWL Generation Report

## bellerophon

### Tool Description
Filter chimeric reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/bellerophon:1.0--pyh5e36f6f_0
- **Homepage**: https://github.com/davebx/bellerophon/
- **Package**: https://anaconda.org/channels/bioconda/packages/bellerophon/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bellerophon/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/davebx/bellerophon
- **Stars**: N/A
### Original Help Text
```text
usage: bellerophon [-h] --forward FORWARD --reverse REVERSE --output OUTPUT
                   [--quality QUALITY] [--threads THREADS]
                   [--log-level {CRITICAL,ERROR,WARNING,INFO,DEBUG}]
                   [--version]

Filter chimeric reads.

optional arguments:
  -h, --help            show this help message and exit
  --forward FORWARD, -f FORWARD
                        SAM/BAM/CRAM file with the first set of reads.
  --reverse REVERSE, -r REVERSE
                        SAM/BAM/CRAM file with the second set of reads.
  --output OUTPUT, -o OUTPUT
                        Output BAM file for filtered and paired reads.
  --quality QUALITY, -q QUALITY
                        Minimum mapping quality.
  --threads THREADS, -t THREADS
                        Threads.
  --log-level {CRITICAL,ERROR,WARNING,INFO,DEBUG}, -l {CRITICAL,ERROR,WARNING,INFO,DEBUG}
                        Log level.
  --version             show program's version number and exit

Filter two single-end BAM, SAM, or CRAM files for reads where there is high-
quality mapping on both sides of a ligation junction, retaining the 5´ side of
that mapping, then merge them into one paired-end BAM file.
```


## Metadata
- **Skill**: generated
