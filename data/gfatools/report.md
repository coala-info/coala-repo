# gfatools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gfatools_asm | PASS | repo test/MT.gfa (8 segments, 11 links): reduction, tip, bubble, overlap and unitig options change the graph; options now ordered and repeatable |
| gfatools_blacklist | PASS | repo test/MT.gfa (8 segments, 11 links): three regions reported |
| gfatools_bubble | PASS | repo test/MT.gfa (8 segments, 11 links): three bubble-like regions with sequences |
| gfatools_gfa2bed | PASS | repo test/MT.gfa (8 segments, 11 links): 8 BED intervals match the segment tags |
| gfatools_gfa2fa | PASS | repo test/MT.gfa (8 segments, 11 links): 8 FASTA records with 60 bp lines |
| gfatools_paf2gfa | PASS | overlaps of nf-core HiFi reads (minimap2 ava-pb) give 30 unitigs with sequences |
| gfatools_sql | PASS | repo test/MT.gfa (8 segments, 11 links): 8 CREATE TABLE and 59 INSERT statements |
| gfatools_stat | PASS | repo test/MT.gfa (8 segments, 11 links): counts and rank-0 length 16569 match the graph |
| gfatools_view | PASS | repo test/MT.gfa (8 segments, 11 links): subset by list file, names, radius, delete and region give expected counts; list file now passed as @file |

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


## gfatools_sql

### Tool Description
Export an rGFA graph to SQLite statements (written to standard output).

### Metadata
- **Docker Image**: quay.io/biocontainers/gfatools:0.5.5--h577a1d6_0
- **Homepage**: https://github.com/lh3/gfatools
- **Package**: https://anaconda.org/channels/bioconda/packages/gfatools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gfatools sql <in.gfa>
Options:
  -s      write sequence
```

## gfatools_paf2gfa

### Tool Description
Build a miniasm-like string graph (GFA) from all-vs-all read overlaps in PAF format.

### Metadata
- **Docker Image**: quay.io/biocontainers/gfatools:0.5.5--h577a1d6_0
- **Homepage**: https://github.com/lh3/gfatools
- **Package**: https://anaconda.org/channels/bioconda/packages/gfatools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: paf2gfa [options] <in.paf>
Options:
  -n INT      threshold for tips and small bubbles [3]
  -b          both directions of an arc are present in input
  -U          keep unidirectional edges (effective with -b)
  -f          cut and filter initial hits
  -h NUM      max overhang length [100]
  -o NUM      min overlap length [500]
  -c          apply graph cleaning (up to 3)
  -r FLOAT    max edge cut ratio (between 0.5 and 1) [0.9]
  -u          generate unitigs
  -i FILE     input reads []
```

## Metadata
- **Skill**: generated
