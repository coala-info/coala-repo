# consensify CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| consensify_consensify_c | PASS |  |

## Metadata
- **Skill**: generated

## consensify_consensify_c

### Tool Description
Generate a consensus fasta from counts and positions files using a random read sampling approach.

### Metadata
- **Docker Image**: quay.io/biocontainers/consensify:2.4.0--h077b44d_2
- **Homepage**: https://github.com/jlapaijmans/Consensify
- **Package**: https://anaconda.org/channels/bioconda/packages/consensify/overview
- **Validation**: PASS
### Original Help Text
```text
consensify_c v2.4.0
Available options:

-p filename(with path) of the positions file (required)
-c filename(with path) of the counts file (required)
-s filename(with path) of the scaffold file (required)
-o filename(with path) of the output fasta (required
-min minimum coverage for which positions should be called (defaults to 3)
-max maximum coverage for which positions should be called (defaults to 100)
-n_matches number of matches required to call a position (defaults to 2)
-n_random_reads number of random reads used; note that fewer reads might be used if a position has depth<n_random_reads (defaults to 3)
-seed seed for the random number generator (if not set, random device is used to initialise the Marsenne-Twister)
-v if set, verbose output to stout
-no_empty_scaffold if set, empty scaffolds in the counts file are NOT printed in the fasta output
-h a list of available options (note that other options will be ignored)

example usage: consensify_c -c eg.counts -p eg.pos -o eg.fasta
```

