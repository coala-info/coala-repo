# pftools CWL Generation Report

## pftools_pfsearchV3

### Tool Description
Scan a protein sequence library for profile matches

### Metadata
- **Docker Image**: quay.io/biocontainers/pftools:3.2.13--pl5321r44hcf78210_0
- **Homepage**: https://web.expasy.org/pftools/
- **Package**: https://anaconda.org/channels/bioconda/packages/pftools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pftools/overview
- **Total Downloads**: 23.6K
- **Last updated**: 2025-10-13
- **GitHub**: https://github.com/sib-swiss/pftools3
- **Stars**: N/A
### Original Help Text
```text
Expected arguments after options
Scan a protein sequence library for profile matches:
 pfsearchV3 [options] [profile|regex{...}|pattern{...}] database

 Options:
  Profile
   --level <int>                      [-L] : level to use for cutoff (default 0)
   --mode <int>                            : mode to use for normalization (default 1)
   --reverse-profile                       : reverse the profile
   --unknown-symbol <character>            : change unknown symbol to given character

  Sequence
   --optimal                          [-a] : report optimal alignment for all sequences
     --satisfy-cutoff                      : but satisfying cutoff
   --reverse-sequence                      : read sequence backward
   --complement                            : does a complementary sequence alignment.
                                             note that --reverse is NOT automatic
   --both                             [-b] : compute both forward and reverse complemented

  Regular expressions
   --max-regex-match <uint>                : maximum number of returned matches per sequence
   --header-only                           : search in headers only

  Database
   --fasta                            [-f] : FASTA file database as input
   --fastq                            [-q] : FASTQ file database as input
   --database-index <file>            [-i] : use indices stored in given file (optional)

  Heuristic
   --no-heuristic                     [-n] : bypass heuristic
   --heuristic-cutoff <uint>          [-H] : heuristic cutoff value
   --dump-heuristic-scores                 : only print heuristic scores to stdout

  Filter
   --filter-cutoff <int>              [-C] : filter raw cutoff value
   --filter-normalized-cutoff <float> [-N] : filter normalized cutoff value
   --dump-filter-scores                    : only print filter scores to stdout
   --dump-filter-sequences            [-d] : dump passed heuristic sequences

  Alignment
   --dump-alignment-sequences         [-D] : dump passed heuristic and filter
                                             sequences

  Optimizations
   --sse2                                  : enforces SSE 2 only instruction set,
                                             default to using SSE 4.1
   --nthreads <uint>                  [-t] : max number of threads to use
                                             default to all available cores
   --max-heuristic-nthreads <uint>         : max number of threads to use for
                                             heuristic phase only. (IO bounds)
                                             default to all available cores

  Printing output
   --output-method <uint>  [-o] : printing output method (default 0)
                                     == 0 replicates the pfsearch output without options
                                     == 1 InterPro
                                     == 2 IncMatch
                                     == 3 PSMaker
                                     == 4 Pfscan
                                     == 5 Pfscan long
                                     == 6 xPSA output
                                     == 7 tsv output (single line tab delimited)
                                     == 8 SAM output
                                     == 9 Family classification (ONLY for pfsearch)
                                     == 10 Turtle/RDF output for HAMAP as SPARQL style rules (pfsearch)
   --output-length <uint>  [-W] : maximum number of column for sequence
                                  output printing (default 60)
  Other
   --verbose               [-V] : verbose on stderr
   --help                  [-h] : output command help

 Version 3.2.12 built on Oct 13 2025 at 21:47:48.
```


## pftools_pfscanV3

### Tool Description
Scan a protein sequence with a profile library

### Metadata
- **Docker Image**: quay.io/biocontainers/pftools:3.2.13--pl5321r44hcf78210_0
- **Homepage**: https://web.expasy.org/pftools/
- **Package**: https://anaconda.org/channels/bioconda/packages/pftools/overview
- **Validation**: PASS

### Original Help Text
```text
Expected arguments after options
Scan a protein sequence with a profile library:
 pfscanV3 [options] profiles sequences

 Options:
  Profile
   --level <int>                      [-L] : level to use for cutoff (default 0)
   --mode <int>                            : mode to use for normalization (default 1)
   --pattern-only                          : only pattern profile will be treated
   --matrix-only                           : only matrix profile will be treated
                                             default is to treat all
   --unknown-synbol <character>            : change unknown symbol to given character

  Regular expressions
   --max-regex-match <uint>                : maximum number of returned matches per
                                             sequence (default 16)

 Heuristic
   --no-heuristic                     [-n] : bypass heuristic

 Filter
   --filter-normalized-cutoff <float> [-N] : filter normalized cutoff value
                                             heuritic cutoff will be adjusted
                                             provided profiles data allows

  Database
   --fasta                            [-f] : FASTA file database as input
   --fastq                            [-q] : FASTQ file database as input
   --database-index <file>            [-i] : use indices stored in given file

 Optimizations
   --sse2                                  : enforces SSE 2 only instruction set,
                                             default to using SSE 4.1
   --nthreads <uint>                  [-t] : max number of threads to use,
                                             default to all available cores
   --max-heuristic-nthreads <uint>         : max number of threads to use for
                                             heuristic phase only. (IO bounds)
                                             default to all available cores

  Printing output
   --output-method <uint>     [-o] : printing output method (default 5)
                                     == 0 replicates the pfsearch output without options
                                     == 1 InterPro
                                     == 2 IncMatch
                                     == 3 PSMaker
                                     == 4 Pfscan
                                     == 5 Pfscan long
                                     == 6 xPSA output
                                     == 7 tsv output (single line tab delimited)
                                     == 8 SAM output
                                     == 9 Print a classification
                                     == 10 Turtle/RDF output
   --output-length <uint>     [-W] : maximum number of column for sequence
                                     output printing (default 60)
  Other
   --verbose                  [-V] : verbose on stderr
   --help                     [-h] : output command help

 Version 3.2.12 built on Oct 13 2025 at 21:47:49.
```

