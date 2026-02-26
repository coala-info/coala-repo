# callerpp CWL Generation Report

## callerpp

### Tool Description
A tool for consensus calling and multiple sequence alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/callerpp:0.1.6--h503566f_2
- **Homepage**: https://github.com/nh13/callerpp
- **Package**: https://anaconda.org/channels/bioconda/packages/callerpp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/callerpp/overview
- **Total Downloads**: 4.0K
- **Last updated**: 2025-09-09
- **GitHub**: https://github.com/nh13/callerpp
- **Stars**: N/A
### Original Help Text
```text
Usage: callerpp [options] <sequences>

A tool for consensus calling and multiple sequence alignment.

Version: 0.1.6

Input:
       The input will be read from standard input. Each batch of
       input sequences should start with a FASTA header line ('>').
       Each sequence in the batch should be on its own line thereafter.

Output:
       The output will be written to standard output. The input
       header line will be written first, followed by the consensus
       call, and the multiple sequence alignment if specified.

Options:
       -i, --input     FILE  Read from this input file, stdin otherwise [stdin]
       -A, --match     INT   The score for a sequence match [5]
       -B, --mismatch  INT   The penalty for a sequence mismatch [-4]
       -O, --gap       INT   The penalty for a gap [-8]
       -a, --algorithm INT   The type of alignment to perform [0]
                             0 - local (Smith-Waterman
                             1 - global (Needleman-Wunsch)
                             2 - semi-global (glocal)
       -r, --resort INT      Resort the input sequences prior to POA/MSA [0]
                             0 - do not sort
                             1 - by length sequence (shortest first)
                             2 - by length sequence (longest first)
       -c, --coverage        Output the per-base coverage for the consensus [false]
       -m, --msa             Output multiple sequence alignment [false]
       -l, --left-align      Left align the sequences in the multiple sequence alignment [false]
       -p, --pairwise-msa    Re-compute the MSA by adding in the consensus first [false]
       -h, --help            Prints out the help
       -v, --version         Prints out the version
```

