# oases CWL Generation Report

## oases

### Tool Description
De novo transcriptome assembler for the Velvet package

### Metadata
- **Docker Image**: quay.io/biocontainers/oases:0.2.09--h7b50bb2_2
- **Homepage**: https://github.com/coin-or/qpOASES
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/oases/overview
- **Total Downloads**: 10.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/coin-or/qpOASES
- **Stars**: N/A
### Original Help Text
```text
oases - De novo transcriptome assembler for the Velvet package
Version 0.2.09

Copyright 2009- Daniel Zerbino (dzerbino@soe.ucsc.edu)
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Compilation settings:
CATEGORIES = 4
MAXKMERLENGTH = 191
OPENMP
LONGSEQUENCES

Usage:
./oases directory [options]

	directory			: working directory name

Standard options:
	--help				: this help message
	--version			: print version and exit
	--citation			: print citation to Oases manuscript and exit
	-ins_length2 <integer>		: expected distance between two paired-end reads in the second short-read dataset (default: no read pairing)
	-ins_length_long <integer>	: expected distance between two long paired-end reads (default: no read pairing)
	-ins_length*_sd <integer>	: est. standard deviation of respective dataset (default: 10% of corresponding length)
		[replace '*' by nothing, '2' or '_long' as necessary]
	-unused_reads <yes|no>		: export unused reads in UnusedReads.fa file (default: no)
	-amos_file <yes|no>		: export assembly to AMOS file (default: no export)
	-alignments <yes|no>		: export a summary of contig alignment to the reference sequences (default: no)

Advanced options:
	-cov_cutoff <floating-point>	: removal of low coverage nodes AFTER tour bus or allow the system to infer it (default: 3)
	-min_pair_count <integer>	: minimum number of paired end connections to justify the scaffolding of two long contigs (default: 4)
	-min_trans_lgth <integer>	: Minimum length of output transcripts (default: hash-length)
	-paired_cutoff <floating-point>	: minimum ratio allowed between the numbers of observed and estimated connecting read pairs
		Must be part of the open interval ]0,1[ (default: 0.1)
	-merge <yes|no>		:Preserve contigs mapping onto long sequences to be preserved from coverage cutoff (default: no)
	-edgeFractionCutoff <floating-point>	: Remove edges which represent less than that fraction of a nodes outgoing flow
		Must be part of the open interval ]0,1[ (default: 0.01)
	-scaffolding <yes|no>		: Allow gaps in transcripts (default: no)
	-degree_cutoff <integer>	: Maximum allowed degree on either end of a contigg to consider it 'unique' (default: 3)

Output:
	directory/transcripts.fa
	directory/contig-ordering.txt
```

