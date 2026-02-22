# abacas CWL Generation Report

## abacas

### Tool Description
Algorithm Based Automatic Contiguation of Assembled Sequences. Used for ordering and orienting contigs against a reference genome.

### Metadata
- **Docker Image**: biocontainers/abacas:v1.3.1-5-deb_cv1
- **Homepage**: http://abacas.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/abacas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/abacas/overview
- **Total Downloads**: 4.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
INFO:    Inserting Singularity configuration...
INFO:    Creating SIF file...
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").

***********************************************************************************
* ABACAS: Algorithm Based Automatic Contiguation of Assembled Sequences           *
*                                                                                 *
*                                                                                 *
*   Copyright (C) 2008-10 The Wellcome Trust Sanger Institute, Cambridge, UK.     *
*   All Rights Reserved.                                                          *
*                                                                                 *
***********************************************************************************

USAGE
abacas -r <reference file: single fasta> -q <query sequence file: fasta> -p <nucmer/promer>  [OPTIONS]

	-r	reference sequence in a single fasta file
	-q	contigs in multi-fasta format
	-p	MUMmer program to use: 'nucmer' or 'promer'
OR
abacas -r <reference file: single fasta>  -q <pseudomolecule/ordered sequence file: fasta> -e 
OPTIONS
        -h              print usage
	-d		use default nucmer/promer parameters 
	-s	int	minimum length of exact matching word (nucmer default = 12, promer default = 4)
	-m		print ordered contigs to file in multifasta format 
	-b		print contigs in bin to file 
	-N		print a pseudomolecule without "N"s 
	-i 	int 	mimimum percent identity [default 40]
	-v	int	mimimum contig coverage [default 40]
	-V	int	minimum contig coverage difference [default 1]
	-l	int	minimum contig length [default 1]
	-t		run tblastx on contigs that are not mapped 
	-g 	string (file name)	print uncovered regions (gaps) on reference to file name
	-a		append contigs in bin to the pseudomolecule
	-o	prefix  output files will have this prefix
	-P		pick primer sets to close gaps
	-f	int	number of flanking bases on either side of a gap for primer design (default 350)
        -R      int     Run mummer [default 1, use -R 0 to avoid running mummer]
	-e 		Escape contig ordering i.e. go to primer design
	-c 		Reference sequence is circular
```


## Metadata
- **Skill**: not generated
