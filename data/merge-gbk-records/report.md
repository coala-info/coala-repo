# merge-gbk-records CWL Generation Report

## merge-gbk-records

### Tool Description
Merge GenBank records with a defined spacer sequence

### Metadata
- **Docker Image**: quay.io/biocontainers/merge-gbk-records:0.2.0--pyhdfd78af_0
- **Homepage**: http://github.com/kblin/merge-gbk-records
- **Package**: https://anaconda.org/channels/bioconda/packages/merge-gbk-records/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/merge-gbk-records/overview
- **Total Downloads**: 1.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/kblin/merge-gbk-records
- **Stars**: N/A
### Original Help Text
```text
usage: merge-gbk-records [-h] [-l LENGTH] [-s {n,stop}] [-o OUTFILE] [-V]
                         records [records ...]

Merge GenBank records with a defined spacer sequence

positional arguments:
  records               A GenBank file to merge

options:
  -h, --help            show this help message and exit
  -l LENGTH, --length LENGTH
                        Length of the spacer in kbp (default: 20).
  -s {n,stop}, --spacer {n,stop}
                        Spacer sequence to use, can be Ns or all-frame stop
                        codons (default: n).
  -o OUTFILE, --outfile OUTFILE
                        Output file to write to, or 'stdout' to write to
                        terminal (default: stdout).
  -V, --version         show program's version number and exit
```

