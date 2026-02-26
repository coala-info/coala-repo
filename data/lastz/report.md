# lastz CWL Generation Report

## lastz

### Tool Description
Search for PATTERN in each FILE.

### Metadata
- **Docker Image**: quay.io/biocontainers/lastz:1.04.52--h7b50bb2_1
- **Homepage**: http://www.bx.psu.edu/~rsharris/lastz/
- **Package**: https://anaconda.org/channels/bioconda/packages/lastz/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lastz/overview
- **Total Downloads**: 108.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
NOTE: the following list is not comprehensive.  The most up-to-date list is
      available at http://www.bx.psu.edu/~rsharris/lastz

  target[[start..end]]   spec/file containing target sequence (fasta, fastq,
                         nib, 2bit or hsx);  [start..end] defines a subrange of
                         the file
                         (use --help=files for more details)
  query[[start..end]]    spec/file containing query sequences;  if absent,
                         queries come from stdin (if needed)
  --self                 the target sequence is also the query
                         (this replaces the query file)
  --seed=match<length>   use a word with no gaps instead of a seed pattern
  --[no]transition[=2]   allow one or two transitions in a seed hit
                         (by default a transition is allowed)
  --step=<length>        set step length (default is 1)
  --strand=both          search both strands
  --strand=plus          search + strand only (matching strand of query spec)
  --strand=minus         search - strand only (opposite strand of query spec)
                         (by default both strands are searched)
  --ambiguous=n[,<penalty>] treat N as an ambiguous nucleotide
                         (by default N is treated as a sequence splicing
                          character)
  --ambiguous=iupac[,<penalty>] treat any ambiguous IUPAC-IUB character as a
                         completely ambiguous nucleotide
                         (by default any sequence file with B,D,H,K,M,R,S,V,W,Y
                          is rejected)
  --[no]gfextend         perform gap-free extension of seed hits to HSPs
                         (by default extension is performed)
  --[no]chain            perform chaining
  --chain=<diag,anti>    perform chaining with given penalties for diagonal and
                         anti-diagonal
                         (by default no chaining is performed)
  --[no]gapped           perform gapped alignment (instead of gap-free)
                         (by default gapped alignment is performed)
  --notrivial            do not output a trivial self-alignment block if the
                         target and query happen to be identical
  --scores=<file>        read substitution scores from a file
                         (default is HOXD70)
  --match=<R>,<P>        scores are +R/-P for match/mismatch
  --gap=<open,extend>    set gap open and extend penalties (default is 400,30)
  --xdrop=<score>        set x-drop threshold (default is 10*sub[A][A])
  --ydrop=<score>        set y-drop threshold (default is open+300extend)
  --noxtrim              if x-drop extension encounters end of sequence, don't
                         trim back to peak score (use this for short reads)
  --noytrim              if y-drop extension encounters end of sequence, don't
                         trim back to peak score (use this for short reads)
  --hspthresh=<score>    set threshold for high scoring pairs (default is 3000)
                         ungapped extensions scoring lower are discarded
                         <score> can also be a percentage or base count
  --exact=<length>       set threshold for exact matches
                         if specified, exact matches are found rather than high
                         scoring pairs (replaces --hspthresh)
  --inner=<score>        set threshold for HSPs during interpolation
                         (default is no interpolation)
  --gappedthresh=<score> set threshold for gapped alignments
                         gapped extensions scoring lower are discarded
                         <score> can also be a percentage or base count
                         (default is to use same value as --hspthresh)
  --[no]entropy          involve entropy in filtering high scoring pairs
                         (default is "entropy")
  --nomirror             don't report mirror-image alignments when using --self
                         (default is to skip processing them, but recreate them
                         in the output)
  --allocate:traceback=<bytes>  space for trace-back information
                         (default is 80.0M)
  --masking=<count>      mask any position in target hit this many times
                         zero indicates no masking
                         (default is no masking)
  --identity=<min>[..<max>] filter alignments by percent identity
                         0<=min<=max<=100;  blocks (or HSPs) outside min..max
                         are discarded
                         (default is no identity filtering)
  --coverage=<min>[..<max>] filter alignments by percentage of query covered
                         0<=min<=max<=100;  blocks (or HSPs) outside min..max
                         are discarded
                         (default is no query coverage filtering)
  --output=<file>        specify output alignment file;  otherwise alignments
                         are written to stdout
  --format=<type>        specify output format; one of lav, axt, maf, cigar,
                         rdotplot, text or general
                         (use --help=formats for more details)
                         (by default output is LAV)
  --rdotplot=<file>      create an output file suitable for plotting in R.
  --axt=<file>           create an output file in AXT format.
  --maf=<file>           create an output file in MAF format.
  --progress=<n>         report processing of every nth query
  --version              report the program version and quit
  --help                 list all options
  --help=files           list information about file specifiers
  --help=formats         list information about output file formats
  --help=shortcuts       list blastz-compatible shortcuts
  --help=defaults        list scoring defaults for your current settings
  --help=yasra           list yasra-specific shortcuts

NOTE: the preceding list is not comprehensive.  The most up-to-date list is
      available at http://www.bx.psu.edu/~rsharris/lastz
```

