# smithwaterman CWL Generation Report

## smithwaterman

### Tool Description
When called with literal reference and query sequences, smithwaterman prints the cigar match positional string and the match position for the query sequence against the reference sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/smithwaterman:1.0.0--h9948957_0
- **Homepage**: https://github.com/ekg/smithwaterman
- **Package**: https://anaconda.org/channels/bioconda/packages/smithwaterman/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/smithwaterman/overview
- **Total Downloads**: 403
- **Last updated**: 2025-05-21
- **GitHub**: https://github.com/ekg/smithwaterman
- **Stars**: N/A
### Original Help Text
```text
usage: smithwaterman [options] <reference sequence> <query sequence>

options:
    -m, --match-score         the match score (default 10.0)
    -n, --mismatch-score      the mismatch score (default -9.0)
    -g, --gap-open-penalty    the gap open penalty (default 15.0)
    -z, --entropy-gap-open-penalty  enable entropy scaling of the gap open penalty
    -e, --gap-extend-penalty  the gap extend penalty (default 6.66)
    -r, --repeat-gap-extend-penalty  use repeat information when generating gap extension penalties
    -b, --bandwidth           bandwidth to use (default 0, or non-banded algorithm)
    -p, --print-alignment     print out the alignment
    -R, --reverse-complement  report the reverse-complement alignment if it scores better

When called with literal reference and query sequences, smithwaterman
prints the cigar match positional string and the match position for the
query sequence against the reference sequence.
```


## Metadata
- **Skill**: generated
