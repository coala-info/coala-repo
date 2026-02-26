# gerp CWL Generation Report

## gerp_gerpcol

### Tool Description
gpp-gerpcol options:

### Metadata
- **Docker Image**: quay.io/biocontainers/gerp:2.1--h1b792b2_2
- **Homepage**: http://mendel.stanford.edu/SidowLab/downloads/gerp/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/gerp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gerp/overview
- **Total Downloads**: 5.9K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
gpp-gerpcol options:

 -h 	 print help menu
 -v 	 verbose mode
 -t <tree filename>
    	 evolutionary tree
 -f <filename>
    	 alignment filename
 -a 	 alignment in mfa format [default = false]
 -e <reference seq>
    	 name of reference sequence
 -j 	 project out reference sequence
 -r <ratio>
    	 Tr/Tv ratio [default = 2.0]
 -p <precision>
    	 tolerance for rate estimation [default = 0.001]
 -z force start at position 0 [default = false]
 -n <rate>
    	 tree neutral rate [default = compute from tree]
 -s <factor>
    	 tree scaling factor [default = 1.0]
 -x <suffix>
    	 suffix for naming output files [default = ".rates"]

Please see README.txt for more information.
```


## gerp_gerpelem

### Tool Description
gpp-gerpelem options:

### Metadata
- **Docker Image**: quay.io/biocontainers/gerp:2.1--h1b792b2_2
- **Homepage**: http://mendel.stanford.edu/SidowLab/downloads/gerp/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/gerp/overview
- **Validation**: PASS

### Original Help Text
```text
gpp-gerpelem options:

 -h 	 print help menu
 -v 	 verbose mode
 -f <filename>
    	 column scores filename
 -c <chromosome> [default = none]
 -s <start offset> [default = 0]
 -x <suffix>
    	 suffix for naming output files [default = ".elems"]
 -w <suffix>
    	 suffix for naming exclusion region file [default = no output]
 -l <length>
    	 minimum element length [default = 4]
 -L <length>
    	 maximum element length [default = 2000]
 -t <inverse tolerance>
    	 inverse of the rounding tolerance [default = 10]
 -d <threshold>
    	 depth threshold for shallow columns, in substitutions per site [default = 0.5]
 -p <penalty>
    	 penalty coefficient for shallow columns, as fraction of the median neutral rate [default = 0.5]
 -b <number>
    	 number of border nucleotides for shallow regions [default = 2]
 -a <number>
    	 total number of allowed non-border shallow nucleotides per element [default = 10]
 -e <ratio>
    	 acceptable false positive rate [default = 0.05]
 -q <value>
    	 denominator for minimum candidate element score formula [default = 10.0]
 -r <value>
    	 exponent for minimum candidate element score formula [default = 1.15]

Please see README.txt for more information
```

