# ucsc-bedintersect CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ucsc-bedintersect | PASS |  |

## ucsc-bedintersect

### Tool Description
Find overlaps between two bed files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-bedintersect:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-bedintersect/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-bedintersect/overview
- **Total Downloads**: 29.9K
- **Last updated**: 2025-06-28
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
bedIntersect - Intersect two bed files
usage:
bed columns four(name) and five(score) are optional
   bedIntersect a.bed b.bed output.bed
options:
   -aHitAny        output all of a if any of it is hit by b
   -minCoverage=0.N  min coverage of b to output match (or if -aHitAny, of a).
                   Not applied to 0-length items.  Default 0.000010
   -bScore         output score from b.bed (must be at least 5 field bed)
   -tab            chop input at tabs not spaces
   -allowStartEqualEnd  Don't discard 0-length items of a or b
                        (e.g. point insertions)
```

## Metadata
- **Skill**: generated

