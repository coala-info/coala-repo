# get_fasta_info CWL Generation Report

## get_fasta_info

### Tool Description
Get basic summary info about fasta formatted files.

### Metadata
- **Docker Image**: quay.io/biocontainers/get_fasta_info:2.5.0--h577a1d6_0
- **Homepage**: https://github.com/nylander/get_fasta_info
- **Package**: https://anaconda.org/channels/bioconda/packages/get_fasta_info/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/get_fasta_info/overview
- **Total Downloads**: 2.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nylander/get_fasta_info
- **Stars**: N/A
### Original Help Text
```text
Error: Need input fasta file(s) to process.

get_fasta_info v2.5.0

Get basic summary info about fasta formatted files.

Usage:

 get_fasta_info [options] infile(s).

Options:

 -h        help
 -V        version
 -n        noverbose
 -g        count gaps, i.e. missing data symbols. Default: Nn?Xx-
 -C chars  use char(s) as missing symbols and use -g
 -N        -C N -g
 -X        -C X -g
 -Q        -C ? -g
 -G        -C - -g
 -p        print full path to file

 infile should be in fasta format.
```

