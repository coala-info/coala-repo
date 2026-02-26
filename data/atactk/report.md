# atactk CWL Generation Report

## atactk_trim_adapters

### Tool Description
Trim adapters from paired-end HTS reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/atactk:0.1.9--pyh3252c3a_0
- **Homepage**: http://theparkerlab.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/atactk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/atactk/overview
- **Total Downloads**: 11.9K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: trim_adapters [-h] [-d EDIT_DISTANCE] [-f FUDGE] [-s TRIM_START]
                     [-r RC_LENGTH] [-v]
                     forward reverse

Trim adapters from paired-end HTS reads.

positional arguments:
  forward               The (optionally gzipped) FASTQ file containing the
                        forward reads.
  reverse               The (optionally gzipped) FASTQ file containing the
                        reverse reads.

optional arguments:
  -h, --help            show this help message and exit
  -d EDIT_DISTANCE, --max-edit-distance EDIT_DISTANCE
                        The maximum edit distance permitted when aligning the
                        paired reads (default: 1).
  -f FUDGE, --fudge FUDGE
                        An arbitrary number of extra bases to trim from the
                        ends of reads (default: 1) because the original
                        pyadapter_trim.py script did so.
  -s TRIM_START, --trim-from-start TRIM_START
                        Trim this number of bases from the start of each
                        sequence (default: 0).
  -r RC_LENGTH, --rc-length RC_LENGTH
                        Use the reverse complement of this number of bases
                        from the beginning of the reverse read to align the
                        reads (default: 20).
  -v, --verbose         Report on the handling of each FASTQ record.
```

