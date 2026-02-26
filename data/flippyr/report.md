# flippyr CWL Generation Report

## flippyr

### Tool Description
A simple python script to search for allele switches, strand flips, multiallelic sites, ambiguous sites, and indels. The output is in the form of a .bim-like table and a log file.

### Metadata
- **Docker Image**: quay.io/biocontainers/flippyr:0.6.1--pyh7e72e81_0
- **Homepage**: https://github.com/BEFH/flippyr
- **Package**: https://anaconda.org/channels/bioconda/packages/flippyr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/flippyr/overview
- **Total Downloads**: 6.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/BEFH/flippyr
- **Stars**: N/A
### Original Help Text
```text
usage: flippyr [-h] [-s] [-p] [--plinkMem PLINKMEM] [-o OUTPUTPREFIX]
               [--outputSuffix OUTPUTSUFFIX] [-m] [-i] [--rebuildFasta]
               fasta bim

A simple python script to search for allele switches, strand flips,
multiallelic sites, ambiguous sites, and indels. The output is in the form of
a .bim-like table and a log file.

positional arguments:
  fasta                 Fasta file containing all chromosomes in the plink
                        fileset
  bim                   .bim file from binary plink fileset.

options:
  -h, --help            show this help message and exit
  -s, --silent          Supress output to stdout.
  -p, --plink           Run the plink command.
  --plinkMem PLINKMEM   Set the memory limit for plink.
  -o, --outputPrefix OUTPUTPREFIX
                        Change output file prefix.
  --outputSuffix OUTPUTSUFFIX
                        Change output file suffix for plink file.
  -m, --keepMultiallelic
                        Do not delete multiallelic sites.
  -i, --keepIndels      Do not delete insertions/deletions.
  --rebuildFasta        Rebuild the fasta index if out of date.
```

