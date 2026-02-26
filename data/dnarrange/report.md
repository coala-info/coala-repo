# dnarrange CWL Generation Report

## dnarrange

### Tool Description
Find rearranged query sequences in query-to-reference alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/dnarrange:1.6.3--pyh7e72e81_0
- **Homepage**: https://github.com/mcfrith/dnarrange
- **Package**: https://anaconda.org/channels/bioconda/packages/dnarrange/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dnarrange/overview
- **Total Downloads**: 15.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mcfrith/dnarrange
- **Stars**: N/A
### Original Help Text
```text
Usage: dnarrange [options] case-file(s) [: control-file(s)]

Find rearranged query sequences in query-to-reference alignments.

Options:
  -h, --help            show this help message and exit
  -s N, --min-seqs=N    minimum query sequences per group (default=2)
  -c N, --min-cov=N     omit any query with any rearrangement shared by < N
                        other queries (default: 1 if s>1, else 0)
  -t LETTERS, --types=LETTERS
                        rearrangement types: C=inter-chromosome, S=inter-
                        strand, N=non-colinear, G=big gap (default=CSNG)
  -g BP, --min-gap=BP   minimum forward jump in the reference sequence counted
                        as a "big gap" (default=10000)
  -r BP, --min-rev=BP   minimum reverse jump in the reference sequence counted
                        as "non-colinear" (default=1000)
  -f N, --filter=N      discard case reads sharing any (0) or "strongest" (1)
                        rearrangements with control reads (default=1)
  -d BP, --max-diff=BP  maximum query-length difference for shared
                        rearrangement (default=500)
  -m PROB, --max-mismap=PROB
                        discard any alignment with mismap probability > PROB
                        (default=1.0)
  --insert=NAME         find insertions of the sequence with this name
  --shrink              shrink the output
  -v, --verbose         show progress messages
  -w W, --width=W       line-wrap width of group summary lines (default=79)
```

