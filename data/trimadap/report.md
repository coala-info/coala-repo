# trimadap CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| trimadap_trimadap-mt | Failed | image problem: trimadap-mt cannot start, libz.so.1 is missing in the image |

## trimadap_trimadap-mt

### Tool Description
Trim adapter sequences from Illumina data (multi-threaded stream filter).

### Metadata
- **Docker Image**: quay.io/biocontainers/trimadap:r9--0
- **Homepage**: https://github.com/lh3/trimadap
- **Package**: https://anaconda.org/channels/bioconda/packages/trimadap/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: trimadap-mt [options] <in.fq>
Options:
  -5 STR     5'-end adapter
  -3 STR     3'-end adapter
  -l INT     min length [30]
  -s INT     min score [12]
  -t INT     trim down [don't trim]
  -d FLOAT   max difference [0.250]
  -p INT     number of trimmer threads [2]
  -v         print version number
```

