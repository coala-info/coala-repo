# gfa1 CWL Generation Report

## gfa1_gfaview

### Tool Description
View and simplify a GFA graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/gfa1:0.53.alpha--h577a1d6_3
- **Homepage**: https://github.com/lh3/gfa1
- **Package**: https://anaconda.org/channels/bioconda/packages/gfa1/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gfa1/overview
- **Total Downloads**: 3.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lh3/gfa1
- **Stars**: N/A
### Original Help Text
```text
Usage: gfaview [options] <in.gfa>
Options:
  General:
    -v INT      verbose level [2]
    -1          only output CIGAR-M operators (for compatibility)
    -u          generate unitig graph (unambiguous merge)
  Subgraph:
    -s EXPR     list of segment names to extract []
    -S INT      include neighbors in a radius [0]
    -d EXPR     list of segment names to delete []
  Graph simplification:
    -r          transitive reduction
    -R INT      fuzzy length for -r [1000]
    -t          trim tips
    -T INT      tip length for -t [4]
    -b          pop bubbles
    -B INT      max bubble dist for -b [50000]
    -o          drop shorter overlaps
    -O FLOAT    dropped/longest<FLOAT, for -o [0.7]
    -m          misc trimming
Note: the order of options matters; one option may be applied >1 times.
```

