# blastmining CWL Generation Report

## blastmining_blastMining

### Tool Description
BLAST outfmt 6 only:
("qseqid","sseqid","pident","length","mismatch","gapopen","evalue","bitscore","staxid")

### Metadata
- **Docker Image**: quay.io/biocontainers/blastmining:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/NuruddinKhoiry/blastMining
- **Package**: https://anaconda.org/channels/bioconda/packages/blastmining/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/blastmining/overview
- **Total Downloads**: 6.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/NuruddinKhoiry/blastMining
- **Stars**: N/A
### Original Help Text
```text
usage: blastMining [-h] [-v] {vote,voteSpecies,lca,besthit,full_pipeline} ...

blastMining v.1.2.0

Written by: Ahmad Nuruddin Khoiri (nuruddinkhoiri34@gmail.com)

BLAST outfmt 6 only:
("qseqid","sseqid","pident","length","mismatch","gapopen","evalue","bitscore","staxid")  

positional arguments:
  {vote,voteSpecies,lca,besthit,full_pipeline}
    vote                blastMining: voting method with pident cut-off
    voteSpecies         blastMining: vote at species level for all
    lca                 blastMining: lca method
    besthit             blastMining: besthit method
    full_pipeline       blastMining: Running BLAST + mining the output

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
```

