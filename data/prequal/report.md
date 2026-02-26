# prequal CWL Generation Report

## prequal

### Tool Description
PREQUAL v.1.02

### Metadata
- **Docker Image**: quay.io/biocontainers/prequal:1.02--hb97b32f_2
- **Homepage**: https://github.com/simonwhelan/prequal
- **Package**: https://anaconda.org/channels/bioconda/packages/prequal/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/prequal/overview
- **Total Downloads**: 5.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/simonwhelan/prequal
- **Stars**: N/A
### Original Help Text
```text
----------------------------------------------------
	PREQUAL v.1.02  by Simon Whelan
----------------------------------------------------

Simple options (-h all for full options)
	-filterthresh X     	: Filter the sequences to the posterior probabilities threshold X [DEFAULT = 0.994]
					(range 0.0 - 1.0). DEFAULT filtering option with threshold
	-corerun X       	: X number of high posterior residues at beginning and end before 
					a core region is defined [DEFAULT 3]
	-pptype X [Y]       	: Specify the algorithm used to calculate posterior probabilities
					X = all : for all against all sequence comparisons
					X = closest : for Y closest relatives [DEFAULT; Y = 10]
					X = longest : for comparing the Y longest sequences [Y = 10]
	-filterjoin X       	: Extend filtering over regions of unfiltered sequence less than X [DEFAULT X = 10]
	-nofilterlist X     	: Specify a file X that contains a list of taxa names that will 
					not be filtered. In X one name per line.

Usage: 
	./prequal [options] input_file
	-h [all] for [full] options

Typical usage (should do a good job with most sequences):
	 ./prequal input_file
```

