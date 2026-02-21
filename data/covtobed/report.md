# covtobed CWL Generation Report

## covtobed

### Tool Description
Computes coverage from alignments

### Metadata
- **Docker Image**: quay.io/biocontainers/covtobed:1.4.0--h077b44d_0
- **Homepage**: https://github.com/telatin/covtobed/
- **Package**: https://anaconda.org/channels/bioconda/packages/covtobed/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/covtobed/overview
- **Total Downloads**: 48.6K
- **Last updated**: 2025-06-17
- **GitHub**: https://github.com/telatin/covtobed
- **Stars**: N/A
### Original Help Text
```text
Usage: covtobed [options] [BAM]...

Computes coverage from alignments

Options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --physical-coverage   compute physical coverage (needs paired alignments in input)
  -q MINQ, --min-mapq=MINQ
                        skip alignments whose mapping quality is less than MINQ
                        (default: 0)
  -m MINCOV, --min-cov=MINCOV
                        print BED feature only if the coverage is bigger than
                        (or equal to) MINCOV (default: 0)
  -x MAXCOV, --max-cov=MAXCOV
                        print BED feature only if the coverage is lower than
                        MAXCOV (default: 100000)
  -l MINLEN, --min-len=MINLEN
                        print BED feature only if its length is bigger (or equal
                        to) than MINLELN (default: 1)
  -z MINCTGLEN, --min-ctg-len=MINCTGLEN
                        Skip reference sequences (contigs) shorter than this value
  -d, --discard-invalid-alignments
                        skip duplicates, failed QC, and non primary alignment,
                        minq>0 (or user-defined if higher) (default: enabled)
  --keep-invalid-alignments
                        Keep duplicates, failed QC, and non primary alignment,
                        min=0 (or user-defined if higher) - reverts to legacy behavior
  --output-strands      output coverage and stats separately for each strand
  --format=CHOICE       output format
```


## Metadata
- **Skill**: generated
