# mummer CWL Generation Report

## mummer

### Tool Description
Find and output (to stdout) the positions and length of all sufficiently long maximal matches of a substring in <query-file> and <reference-file>

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
- **Homepage**: https://github.com/mummer4/mummer
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mummer/overview
- **Total Downloads**: 145.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mummer4/mummer
- **Stars**: N/A
### Original Help Text
```text
Usage: mummer [options] <reference-file> <query-files>

Find and output (to stdout) the positions and length of all
sufficiently long maximal matches of a substring in
<query-file> and <reference-file>

Options:
-mum           compute maximal matches that are unique in both sequences
-mumcand       same as -mumreference
-mumreference  compute maximal matches that are unique in the reference-
               sequence but not necessarily in the query-sequence (default)
-maxmatch      compute all maximal matches regardless of their uniqueness
-n             match only the characters a, c, g, or t
               they can be in upper or in lower case
-l             set the minimum length of a match
               if not set, the default value is 20
-b             compute forward and reverse complement matches
-r             only compute reverse complement matches
-s             show the matching substrings
-c             report the query-position of a reverse complement match
               relative to the original query sequence
-F             force 4 column output format regardless of the number of
               reference sequence inputs
-L             show the length of the query sequences on the header line
-h             show possible options
-help          show possible options
```

