# bedtk CWL Generation Report

## bedtk_isec

### Tool Description
Find intersections between two BED files

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtk:1.2--h9990f68_0
- **Homepage**: https://github.com/lh3/bedtk
- **Package**: https://anaconda.org/channels/bioconda/packages/bedtk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bedtk/overview
- **Total Downloads**: 7.0K
- **Last updated**: 2025-08-28
- **GitHub**: https://github.com/lh3/bedtk
- **Stars**: N/A
### Original Help Text
```text
Usage: bedtk isec [options] <A.bed> <B.bed>
Options:
  -s FILE   list of contig IDs to specify the output order []
```


## bedtk_flt

### Tool Description
Filter BED records based on overlap with another BED file or VCF/PAF.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtk:1.2--h9990f68_0
- **Homepage**: https://github.com/lh3/bedtk
- **Package**: https://anaconda.org/channels/bioconda/packages/bedtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bedtk flt [options] <loaded.bed> <streamed.bed>
Options:
  -c        the second input is VCF
  -p        the second input is PAF
  -C        print records contained in the union of <loaded.bed>
  -v        print non-satisfying records
  -w INT    window size [0]
  -f FLOAT  min overlap fraction [0]
```


## bedtk_cov

### Tool Description
Calculate coverage of intervals in a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtk:1.2--h9990f68_0
- **Homepage**: https://github.com/lh3/bedtk
- **Package**: https://anaconda.org/channels/bioconda/packages/bedtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bedtk cov [options] <loaded.bed> <streamed.bed>
Options:
  -c       only count; no breadth of depth
  -C       containment only
```


## bedtk_sub

### Tool Description
Subtracts regions from another set of regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtk:1.2--h9990f68_0
- **Homepage**: https://github.com/lh3/bedtk
- **Package**: https://anaconda.org/channels/bioconda/packages/bedtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bedtk sub <minuend.bed> <subtrahend.bed>
Note: <subtrahend.bed> is loaded into memory.
```


## bedtk_sum

### Tool Description
Sum the lengths of intervals in a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtk:1.2--h9990f68_0
- **Homepage**: https://github.com/lh3/bedtk
- **Package**: https://anaconda.org/channels/bioconda/packages/bedtk/overview
- **Validation**: PASS

### Original Help Text
```text
0
```

