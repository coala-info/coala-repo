# grabix CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| grabix_check | PASS |  |
| grabix_grab | PASS |  |
| grabix_index | PASS |  |
| grabix_random | PASS |  |
| grabix_size | PASS |  |

## grabix_index

### Tool Description
Index a tabix-indexed file.

### Metadata
- **Docker Image**: quay.io/biocontainers/grabix:0.1.8--h077b44d_12
- **Homepage**: https://github.com/arq5x/grabix
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/grabix/overview
- **Total Downloads**: 50.4K
- **Last updated**: 2025-09-04
- **GitHub**: https://github.com/arq5x/grabix
- **Stars**: N/A
### Original Help Text
```text
[grabix] --help doesn't exist or wasn't compressed with bgzip
```

## grabix_grab

### Tool Description
Extract a line or a range of lines from a bgzipped file with a grabix index.

### Metadata
- **Docker Image**: quay.io/biocontainers/grabix:0.1.8--h077b44d_12
- **Homepage**: https://github.com/arq5x/grabix
- **Package**: https://anaconda.org/channels/bioconda/packages/grabix/overview
- **Validation**: PASS

### Original Help Text
```text
usage: grabix index bgzf_file 
       grabix grab bgzf_file line_start [line_end] 

examples:
       # create a grabix index (big.vcf.gz.gbi)
       grabix index big.vcf.gz

       # extract the 100th line.
       grabix grab big.vcf.gz 100 [line_end] 

       # extract the 100th through the 200th lines.
       grabix grab big.vcf.gz 100 200 

       # extract the 100 random lines.
       grabix random big.vcf.gz 100

       # Is the file bgzipped?
       grabix check big.vcf.gz

       # get total number of lines in the file (minus the header).
       grabix size big.vcf.gz
version: 0.1.8
```

## grabix_random

### Tool Description
Extract random lines from a bgzipped file with a grabix index.

### Metadata
- **Docker Image**: quay.io/biocontainers/grabix:0.1.8--h077b44d_12
- **Homepage**: https://github.com/arq5x/grabix
- **Package**: https://anaconda.org/channels/bioconda/packages/grabix/overview
- **Validation**: PASS

### Original Help Text
```text
usage: grabix index bgzf_file 
       grabix grab bgzf_file line_start [line_end] 

examples:
       # create a grabix index (big.vcf.gz.gbi)
       grabix index big.vcf.gz

       # extract the 100th line.
       grabix grab big.vcf.gz 100 [line_end] 

       # extract the 100th through the 200th lines.
       grabix grab big.vcf.gz 100 200 

       # extract the 100 random lines.
       grabix random big.vcf.gz 100

       # Is the file bgzipped?
       grabix check big.vcf.gz

       # get total number of lines in the file (minus the header).
       grabix size big.vcf.gz
version: 0.1.8
```

## grabix_check

### Tool Description
Check whether a file is bgzipped.

### Metadata
- **Docker Image**: quay.io/biocontainers/grabix:0.1.8--h077b44d_12
- **Homepage**: https://github.com/arq5x/grabix
- **Package**: https://anaconda.org/channels/bioconda/packages/grabix/overview
- **Validation**: PASS

### Original Help Text
```text
usage: grabix index bgzf_file 
       grabix grab bgzf_file line_start [line_end] 

examples:
       # create a grabix index (big.vcf.gz.gbi)
       grabix index big.vcf.gz

       # extract the 100th line.
       grabix grab big.vcf.gz 100 [line_end] 

       # extract the 100th through the 200th lines.
       grabix grab big.vcf.gz 100 200 

       # extract the 100 random lines.
       grabix random big.vcf.gz 100

       # Is the file bgzipped?
       grabix check big.vcf.gz

       # get total number of lines in the file (minus the header).
       grabix size big.vcf.gz
version: 0.1.8
```

## grabix_size

### Tool Description
Report the number of lines (minus the header) of a bgzipped file with a grabix index.

### Metadata
- **Docker Image**: quay.io/biocontainers/grabix:0.1.8--h077b44d_12
- **Homepage**: https://github.com/arq5x/grabix
- **Package**: https://anaconda.org/channels/bioconda/packages/grabix/overview
- **Validation**: PASS

### Original Help Text
```text
usage: grabix index bgzf_file 
       grabix grab bgzf_file line_start [line_end] 

examples:
       # create a grabix index (big.vcf.gz.gbi)
       grabix index big.vcf.gz

       # extract the 100th line.
       grabix grab big.vcf.gz 100 [line_end] 

       # extract the 100th through the 200th lines.
       grabix grab big.vcf.gz 100 200 

       # extract the 100 random lines.
       grabix random big.vcf.gz 100

       # Is the file bgzipped?
       grabix check big.vcf.gz

       # get total number of lines in the file (minus the header).
       grabix size big.vcf.gz
version: 0.1.8
```
