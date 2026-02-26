# mdust CWL Generation Report

## mdust

### Tool Description
Masks low-complexity DNA sequences in FASTA format.

### Metadata
- **Docker Image**: quay.io/biocontainers/mdust:2006.10.17--h7b50bb2_7
- **Homepage**: https://github.com/lh3/mdust
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mdust/overview
- **Total Downloads**: 17.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lh3/mdust
- **Stars**: N/A
### Original Help Text
```text
Usage: mdust [<fasta-file>] [-w <wsize>] [-v <cut-off>] [-m N|X|L] [-c] 
   if no <fasta-file> is given, a multi-fasta stream is expected at stdin
   -v default <cut-off> value is 28 (lower values might mask more, 
      but possibly still useful sequence; > 64 will rarely mask poly-triplets)
   -w set maximum word size to <wsize> (default 3)
   -m if fasta output is not disabled by -c, set the masking letter type:
        N ('N', default), X ('X'), L (make lowercase)
   -c output masking coordinates only: 
        seq_name, seqlength, mask_start, mask_end  (tab delimited)
```


## Metadata
- **Skill**: generated
