# ucsc-netchainsubset CWL Generation Report

## ucsc-netchainsubset_netChainSubset

### Tool Description
Create chain file with subset of chains that appear in the net

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-netchainsubset:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-netchainsubset/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-netchainsubset/overview
- **Total Downloads**: 21.6K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
netChainSubset - Create chain file with subset of chains that appear in the net
usage:
   netChainSubset in.net in.chain out.chain
options:
   -gapOut=gap.tab - Output gap sizes to file
   -type=XXX - Restrict output to particular type in net file
   -splitOnInsert - Split chain when get an insertion of another chain
   -wholeChains - Write entire chain references by net, don't split
    when a high-level net is encoundered.  This is useful when nets
    have been filtered.
   -skipMissing - skip chains that are not found instead of generating
    an error.  Useful if chains have been filtered.
```

