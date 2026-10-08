# gfa1 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gfa1_falcon2gfa | Not completed | no usable test data (needs a real FALCON, fermi or Supernova assembly graph) |
| gfa1_fastg2gfa | PASS | SPAdes FASTG with 3 contigs gives 3 GFA segments |
| gfa1_gfaview | PASS | nf-core B-3106.gfa (469 segments): unitig, bubble, tip, transitive, subgraph and delete options give plausible graphs; option order fixed, segment lists need a leading comma |
| gfa1_mag2gfa | Not completed | no usable test data (needs a real FALCON, fermi or Supernova assembly graph) |
| gfa1_supernova2gfa | Not completed | no usable test data (needs a real FALCON, fermi or Supernova assembly graph) |

## gfa1_gfaview

### Tool Description
View and simplify a GFA graph.

### gfa1_fastg2gfa

### Tool Description
Convert a FASTG assembly graph to GFA.

### Metadata
- **Docker Image**: quay.io/biocontainers/gfa1:0.53.alpha--h577a1d6_3
- **Homepage**: https://github.com/lh3/gfa1
- **Package**: https://anaconda.org/channels/bioconda/packages/gfa1/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fastg2gfa <in.fastg>
```

## gfa1_falcon2gfa

### Tool Description
Convert a FALCON string graph edge list (sg_edges_list) to GFA.

### Metadata
- **Docker Image**: quay.io/biocontainers/gfa1:0.53.alpha--h577a1d6_3
- **Homepage**: https://github.com/lh3/gfa1
- **Package**: https://anaconda.org/channels/bioconda/packages/gfa1/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: falcon2gfa [-S] <sg_edges_list>
```

## gfa1_mag2gfa

### Tool Description
Convert a MAG assembly graph to GFA.

### Metadata
- **Docker Image**: quay.io/biocontainers/gfa1:0.53.alpha--h577a1d6_3
- **Homepage**: https://github.com/lh3/gfa1
- **Package**: https://anaconda.org/channels/bioconda/packages/gfa1/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mag2gfa [-Sm] <in.mag>
Options:
  -m    Fermi's native MAG format
  -S    don't output sequence in GFA (effective w/o -m)
```

## gfa1_supernova2gfa

### Tool Description
Convert a Supernova assembly graph (.snfa) to GFA.

### Metadata
- **Docker Image**: quay.io/biocontainers/gfa1:0.53.alpha--h577a1d6_3
- **Homepage**: https://github.com/lh3/gfa1
- **Package**: https://anaconda.org/channels/bioconda/packages/gfa1/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: supernova2gfa <in.snfa>
```

## Metadata
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

