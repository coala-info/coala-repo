# gfatools CWL Generation Report

## gfatools_view

### Tool Description
View and subset GFA graphs

### Metadata
- **Docker Image**: quay.io/biocontainers/gfatools:0.5.5--h577a1d6_0
- **Homepage**: https://github.com/lh3/gfatools
- **Package**: https://anaconda.org/channels/bioconda/packages/gfatools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gfatools/overview
- **Total Downloads**: 23.0K
- **Last updated**: 2025-06-06
- **GitHub**: https://github.com/lh3/gfatools
- **Stars**: N/A
### Original Help Text
```text
Usage: gfatools view [options] <in.gfa>
Options:
  -v INT        verbose level [2]
  -l STR/@FILE  segment list to subset []
  -R STR        a region like chr1:101-200 (a 1-based closed region) []
  -r INT        subset radius (effective with -l) [0]
  -d            delete the list of segments (requiring -l; ignoring -r)
  -M            remove multiple edges
  -S            don't print sequences
```


## gfatools_stat

### Tool Description
Print statistics about a GFA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/gfatools:0.5.5--h577a1d6_0
- **Homepage**: https://github.com/lh3/gfatools
- **Package**: https://anaconda.org/channels/bioconda/packages/gfatools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gfatools stat <in.gfa>
```


## gfatools_gfa2fa

### Tool Description
Convert a GFA file to FASTA format

### Metadata
- **Docker Image**: quay.io/biocontainers/gfatools:0.5.5--h577a1d6_0
- **Homepage**: https://github.com/lh3/gfatools
- **Package**: https://anaconda.org/channels/bioconda/packages/gfatools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gfatools gfa2fa [options] <in.gfa>
Options:
  -l INT   line length [60]
  -s       output stable sequences (rGFA only)
  -P       skip rank-0 sequences (rGFA only; force -s)
  -0       only output rank-0 sequences (rGFA only; force -s)
```


## gfatools_gfa2bed

### Tool Description
Convert GFA to BED format

### Metadata
- **Docker Image**: quay.io/biocontainers/gfatools:0.5.5--h577a1d6_0
- **Homepage**: https://github.com/lh3/gfatools
- **Package**: https://anaconda.org/channels/bioconda/packages/gfatools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gfatools gfa2bed [options] <in.gfa>
Options:
  -s     merge adjacent intervals on stable sequences
```


## gfatools_blacklist

### Tool Description
Identify and output regions from a GFA graph that are considered 'blacklisted'.

### Metadata
- **Docker Image**: quay.io/biocontainers/gfatools:0.5.5--h577a1d6_0
- **Homepage**: https://github.com/lh3/gfatools
- **Package**: https://anaconda.org/channels/bioconda/packages/gfatools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gfatools blacklist [options] <in.gfa>
Options:
  -l INT    min region length [100]
  -b        include regions involving both strands (mostly inversions)
```


## gfatools_bubble

### Tool Description
Extract bubbles from a GFA graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/gfatools:0.5.5--h577a1d6_0
- **Homepage**: https://github.com/lh3/gfatools
- **Package**: https://anaconda.org/channels/bioconda/packages/gfatools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gfatools bubble <in.gfa>
```


## gfatools_asm

### Tool Description
Perform assembly operations on a GFA graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/gfatools:0.5.5--h577a1d6_0
- **Homepage**: https://github.com/lh3/gfatools
- **Package**: https://anaconda.org/channels/bioconda/packages/gfatools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gfatools asm [options] <in.gfa>
Options:
  -r INT          transitive reduction (fuzzy length)
  -t INT1[,INT2]  cut tips (tip seg count, tip length [inf])
  -b INT1[,INT2]  pop bubbles (max radius, max deletions [inf])
  -B INT1[,INT2]  pop bubbles along with small tips (max radius, max del [inf])
  -o FLOAT[,INT]  cut short overlaps (ratio to the longest overlap, overlap length [0])
  -c FLOAT[,INT1[,INT2]]
                  cut overlaps, topology aware (ratio, tip seg count [3], tip length [inf])
  -u              generate unitigs
  -v INT          verbose level [2]
Note: the order of options matters; one option may be applied >1 times.
```


## Metadata
- **Skill**: generated
