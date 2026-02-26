# vmatch CWL Generation Report

## vmatch

### Tool Description
vmatch

### Metadata
- **Docker Image**: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
- **Homepage**: http://www.vmatch.de/
- **Package**: https://anaconda.org/channels/bioconda/packages/vmatch/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vmatch/overview
- **Total Downloads**: 21.9K
- **Last updated**: 2025-09-23
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
-q           specify files containing queries to be matched
-complete    specify that query sequences must match completely
-online      run algorithms online without using the index
-d           compute direct matches (default)
-p           compute palindromic (i.e. reverse complemented matches)
-l           specify that match must have the given length
             optionally specify minimum and maximum size of
             gaps between repeat instances
-h           specify the allowed hamming distance > 0
             in combination with option -complete one can switch on
             the percentage search mode or the best search mode
             for the percentage search mode use an argument
             of the form ip where i is a positive integer
             this means that up to i*100/m mismatches are
             allowed in a match of a query of length m
             for the best search mode use an argument
             of the form ib where i is a positive integer
             this means that in a first phase the minimum threshold q
             is determined such that there is still a match
             with q mismatches. q is in the range 0 to i*100/m
-e           specify the allowed edit distance > 0
             in combination with option -complete one can switch on
             the percentage search mode or the best search mode
             for the percentage search mode use an argument
             of the form ip where i is a positive integer
             this means that up to i*100/m differences are
             allowed in a match of a query of length m
             for the best search mode use an argument
             of the form ib where i is a positive integer
             this means that in a first phase the minimum threshold q
             is determined such that there is still a match
             with q differences. q is in the range 0 to i*100/m
-hxdrop      specify the xdrop value for hamming distance extension
-exdrop      specify the xdrop value for edit distance extension
-leastscore  specify the minimum score of a match
-evalue      specify the maximum E-value of a match
-identity    specify minimum identity of match in range [1..100%]
-s           show the alignment of matching sequences
-showdesc    show sequence description of match
-v           verbose mode
-version     show the version of the Vmatch package
-help        show basic options
-help+       show all options
```

