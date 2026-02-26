# tn93 CWL Generation Report

## tn93

### Tool Description
compute Tamura Nei 93 distances between aligned sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/tn93:1.0.15--h9948957_0
- **Homepage**: https://github.com/veg/tn93
- **Package**: https://anaconda.org/channels/bioconda/packages/tn93/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tn93/overview
- **Total Downloads**: 32.7K
- **Last updated**: 2025-07-16
- **GitHub**: https://github.com/veg/tn93
- **Stars**: N/A
### Original Help Text
```text
usage: tn93 [-h] [-v] [-o OUTPUT] [-t THRESHOLD] [-w MIN_THRESHOLD] [-a AMBIGS] [-g FRACTION] [-l OVERLAP] [-d COUNTS_IN_NAME] [-f FORMAT] [-s SECOND_FASTA] [-b] [-r] [-c] [-n] [-0] [-q] [-D DELIMITER][FASTA]

compute Tamura Nei 93 distances between aligned sequences

optional arguments:
  -h, --help               show this help message and exit
  -v, --version            show tn93 version 
  -o OUTPUT                direct the output to a file named OUTPUT (default=stdout)
  -t THRESHOLD             only report (count) distances below this threshold (>=0, default=0.015)
  -w MINIMUM THRESHOLD     report distances above minimum threshold 
  -a AMBIGS                handle ambigous nucleotides using one of the following strategies (default=resolve)
                           resolve: resolve ambiguities to minimize distance (e.g.R matches A);
                           average: average ambiguities (e.g.R-A is 0.5 A-A and 0.5 G-A);
                           skip: do not include sites with ambiguous nucleotides in distance calculations;
                           gapmm: a gap ('-') matched to anything other than another gap is like matching an N (4-fold ambig) to it;
                           a string (e.g. RY): any ambiguity in the list is RESOLVED; any ambiguitiy NOT in the list is averaged (LIST-NOT LIST will also be averaged);
  -g FRACTION              in combination with AMBIGS, works to limit (for resolve and string options to AMBIG)
                           the maximum tolerated FRACTION of ambiguous characters; sequences whose pairwise comparisons
                           include no more than FRACTION [0,1] of sites with resolvable ambiguities will be resolved
                           while all others will be AVERAGED (default = 1.0)
  -f FORMAT                controls the format of the output unless -c is set (default=csv)
                           csv: seqname1, seqname2, distance;
                           csvn: 1, 2, distance;
                           hyphy: {{d11,d12,..,d1n}...{dn1,dn2,...,dnn}}, where distances above THRESHOLD are set to 100;
  -l OVERLAP               only process pairs of sequences that overlap over at least OVERLAP nucleotides (an integer >0, default=100):
  -d COUNTS_IN_NAME        if sequence name is of the form 'somethingCOUNTS_IN_NAMEinteger' then treat the integer as a copy number
                           when computing distance histograms (a character, default=':'):
  -s SECOND_FASTA          if specified, read another FASTA file from SECOND_FASTA and perform pairwise comparison BETWEEN the files (default=NULL)
  -b                       bootstrap alignment columns before computing distances (default = false)
                           when -s is supplied, permutes the assigment of sequences to files
                           interacts with -r option
  -r                       if -b is specified AND -s is supplied, using -r will bootstrap across sites
                           instead of allocating sequences to 'compartments' randomly
  -c                       only count the pairs below a threshold, do not write out all the pairs 
  -n                       if set, do NOT write out headers for delimited files (default is to write) 
  -m                       compute inter- and intra-population means suitable for FST caclulations
                           only applied when -s is used to provide a second file
  -u PROBABILITY           subsample sequences with specified probability (a value between 0 and 1, default = 1.0)
  -D DELIMITER             use this character as a delimiter in the output column-file (a character, default = ',')
  -0                       report distances between each sequence and itself (as 0); this is useful to ensure every sequence
                           in the input file appears in the output, e.g. for network construction to contrast clustered/unclustered
  -q                       do not report progress updates and other diagnostics to stderr 
  FASTA                    read sequences to compare from this file (default=stdin)
```

