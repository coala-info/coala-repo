# zagros CWL Generation Report

## zagros

### Tool Description
Finds motifs in DNA sequences based on cross-linking data.

### Metadata
- **Docker Image**: quay.io/biocontainers/zagros:1.0.0--ha24e720_10
- **Homepage**: https://github.com/Aryvyo/Zagros
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/zagros/overview
- **Total Downloads**: 8.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Aryvyo/Zagros
- **Stars**: N/A
### Original Help Text
```text
Usage: zagros [OPTIONS] <target_regions/sequences>

Options:
  -o, -output             output file name (default: stdout) 
  -w, -width              width of motifs to find (4 <= w <= 12; default: 6) 
  -n, -number             number of motifs to output (default: 10) 
  -c, -chrom              directory with chrom files (FASTA format) 
  -t, -structure          structure information file 
  -d, -diagnostic_events  diagnostic events information file 
  -l, -delta              provide a fixed value for delta, the offset of 
                          cross-linking site from motif occurrences. -8 <= l <= 
                          8; if omitted, delta is optimised using an exhaustive 
                          search 
  -g, -geo                optimize the geometric distributionparameter for 
                          the distirbution of cross-link sites around motif 
                          occurrences, using the Newton-Raphson algorithm. 
                          If omitted, this parameter is not optimised and is set 
                          to a empirically pre-determined default value. 
  -k, -de_weight          A weight to determine the diagnostic events' level of 
                          contribution (default: 1.1) 
  -a, -indicators         output indicator probabilities for each sequence 
                          and motif to this file 
  -s, -starting-points    number of starting points to try for EM search. Higher 
                          values will be slower, but more likely to find the 
                          global maximum (default: 10) 
  -v, -verbose            print more run info 

Help options:
  -?, -help               print this help message 
      -about              print about message 

PROGRAM: zagros
```

