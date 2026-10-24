# ucsc-bedjointaboffset CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ucsc-bedjointaboffset | Failed | image problem: bedJoinTabOffset is a Python 2 script run by Python 3.7 in the image and crashes with AttributeError: module 'string' has no attribute 'split'. |

## ucsc-bedjointaboffset

### Tool Description
Joins two BED files, aligning them by tab and offset.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-bedjointaboffset:377--h199ee4e_0
- **Homepage**: http://hgdownload.cse.ucsc.edu/admin/exe/
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-bedjointaboffset/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-bedjointaboffset/overview
- **Total Downloads**: 9.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: bedJoinTabOffset [options] inTabFile inBedFile outBedFile - given a bed file and tab file where each have a column with matching values: first get the value of column0, the offset and line length from inTabFile. Then go over the bed file, use the name field and append its offset and length to the bed file as two separate fields. Write the new bed file to outBed.

Options:
  -h, --help            show this help message and exit
  -d, --debug           show debug messages
  -t TABKEYFIELD, --tabKeyField=TABKEYFIELD
                        the index of the key field in the tab file that
                        matches the key field in the bed file. default 0
  -b BEDKEYFIELD, --bedKeyField=BEDKEYFIELD
                        the index of the key field in the bed file that
                        matches the key field in the tab file. default 3
```

