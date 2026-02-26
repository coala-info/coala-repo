# miranda CWL Generation Report

## miranda

### Tool Description
microRNA Target Scanning Algorithm. miRAnda is an miRNA target scanner which aims to predict mRNA targets for microRNAs using dynamic-programming alignment and thermodynamics.

### Metadata
- **Docker Image**: quay.io/biocontainers/miranda:3.3a--h7b50bb2_9
- **Homepage**: https://github.com/miranda-ng/miranda-ng
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/miranda/overview
- **Total Downloads**: 14.4K
- **Last updated**: 2025-09-24
- **GitHub**: https://github.com/miranda-ng/miranda-ng
- **Stars**: N/A
### Original Help Text
```text
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
miranda v3.3a    microRNA Target Scanning Algorithm
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
(c) 2003 Memorial Sloan-Kettering Cancer Center, New York

Authors: Anton Enright, Bino John, Chris Sander and Debora Marks
(mirnatargets (at) cbio.mskcc.org - reaches all authors)

Software written by: Anton Enright
Distributed for anyone to use under the GNU Public License (GPL),
See the files 'COPYING' and 'LICENSE' for details

If you use this software please cite:
Enright AJ, John B, Gaul U, Tuschl T, Sander C and Marks DS;
(2003) Genome Biology; 5(1):R1.

   miranda comes with ABSOLUTELY NO WARRANTY;
   This is free software, and you are welcome to redistribute it
   under certain conditions; type `miranda --license' for details.

miRanda is an miRNA target scanner which aims to predict mRNA
targets for microRNAs using dynamic-programming alignment and
thermodynamics.

Usage:	miranda file1 file2 [options..]

Where:
	'file1' is a FASTA file with a microRNA query
	'file2' is a FASTA file containing the sequence(s)
	to be scanned.

OPTIONS

 --help -h	Display this message
 --version -v	Display version information
 --license	Display license information

Core algorithm parameters:
 -sc S		Set score threshold to S		[DEFAULT: 140.0]
 -en -E		Set energy threshold to -E kcal/mol	[DEFAULT: 1.0]
 -scale Z	Set scaling parameter to Z		[DEFAULT: 4.0]
 -strict	Demand strict 5' seed pairing		[DEFAULT: off]

Alignment parameters:
 -go -X		Set gap-open penalty to -X		[DEFAULT: -4.0]
 -ge -Y		Set gap-extend penalty to -Y		[DEFAULT: -9.0]

General Options:
 -out file	Output results to file			[DEFAULT: off]
 -quiet		Output fewer event notifications	[DEFAULT: off]
 -trim T	Trim reference sequences to T nt	[DEFAULT: off]
 -noenergy	Do not perform thermodynamics		[DEFAULT: off]

 -restrict file	Restricts scans to those between
             	specific miRNAs and UTRs
             	provided in a pairwise
             	tab-separated file			[DEFAULT: off]

Other Options:
 -keyval	Key value pairs ??			[DEFAULT:]


This software will be further developed under the open source model,
coordinated by Anton Enright and Chris Sander (miranda (at) cbio.mskcc.org).

Please send bug reports to: miranda (at) cbio.mskcc.org.
```


## Metadata
- **Skill**: generated
