# elph CWL Generation Report

## elph

### Tool Description
Motif finder program ELPH (Estimated Locations of Pattern Hits)

### Metadata
- **Docker Image**: biocontainers/elph:v1.0.1-2-deb_cv1
- **Homepage**: https://github.com/emacsmirror/elpher
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/elph/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/emacsmirror/elpher
- **Stars**: N/A
### Original Help Text
```text
Motif finder program ELPH (Estimated Locations of Pattern Hits)
Usage:
  elph <multi-fasta_file> [options] OR
  elph <multi-fasta_file-1> <multi-fasta_file-2> [-t <matrix>]
  Options:
  -h             : print this help
  -b             : just brief results; don't print motif
  -d             : find significance deterministically
  -v             : find motif deterministically
  -o <out_file>  : write output in <out_file> instead of stdout
  -m <motif>     : use the given pattern <motif> to compute its best fit matrix
                   to the data
  -a             : use aac residues; default = nucleotides residues
  -s <seed>      : sets the seed for the random generation
  -p n           : n = no of iterations before deciding local maximum; plateau
                   period variable
  -x             : print maximum positions within sequences
  -g             : find significance of motif
  -t <matrix>    : test if there is significant difference between the two 
                   input files for a given motif matrix; <matrix> is the file
                   containing the motif matrix
  -l             : compute Least Likely Consensus (LLC) for given motif 
  -r             : in conjunction with -m option: motif is not necessarily in
                   the closest edit distance from input motif
  -e             : only when an additional file is used to test the significance
                   of the motif: find only the motifs that exactly match the
                   input pattern (-m or -t options) 
  -n [0..5]      : degree of Markov chain used to generate the random file 
                   used to test the significance of the motif
                   default = 2
  LEN=n          : n = length of motif
  ITERNO=n       : n = no of iterations to compute the global maximum;
                   default = 10
  MAXLOOP=n      : n = no of iterations to compute the local maximum;
                   default = 500
  SGFNO=n        : n = no of iterations to compute significance of motif;
                   default = 1000
```

