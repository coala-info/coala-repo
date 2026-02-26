# amused CWL Generation Report

## amused_AMUSED

### Tool Description
AMUSED: A tool for sequence analysis, likely for motif discovery or n-mer enrichment analysis comparing query sequences against background or randomized sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/amused:1.0--1
- **Homepage**: https://github.com/Carldeboer/AMUSED
- **Package**: https://anaconda.org/channels/bioconda/packages/amused/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amused/overview
- **Total Downloads**: 6.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Carldeboer/AMUSED
- **Stars**: N/A
### Original Help Text
```text
Usage: AMUSED -q <inFPQuery>  -o <outFP> [-b <inFPBG> | -r <randomizeNMer>] [-s <maxTreeSize>]
  -q <inFPQuery> = query sequences
  -b <inFPBG> = compare seqs to these background seqs
  -bp <bgPseudo> = pseudocount to add to background [default=0.5]
  -o <outFP> = output file
  -s <maxTreeSize> = max n-mer to consider [default=8]
  -z <subZCutoff> = minimum absolute Sub-Z-score [default = 0; print all]
  -t <numThreads> = number of CPU threads to use [default=1]
  -1p = sequences not in fasta format: each line is a full sequence
  -ng = no inserting gaps
  -nu = no changing to upper case before scan (non ATGC bases are discarded)
  -ds = double stranded (reverse complement sequences too)
  -ns = don't sort
  -do = descriptive output: lots of intermediate values also output (but many columns)
  -bc = add lines to output for base content
  -nsz = don't calculate super Zs
```

