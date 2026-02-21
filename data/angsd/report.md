# angsd CWL Generation Report

## angsd

### Tool Description
Analysis of Next Generation Sequencing Data. Methods for estimating allele frequencies, genotype likelihoods, and other population genetic parameters from NGS data.

### Metadata
- **Docker Image**: quay.io/biocontainers/angsd:0.940--h13024bc_4
- **Homepage**: http://www.popgen.dk/angsd/index.php/ANGSD
- **Package**: https://anaconda.org/channels/bioconda/packages/angsd/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/angsd/overview
- **Total Downloads**: 50.0K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
	-> angsd version: 0.940-dirty (htslib: 1.21) build(Dec 15 2024 09:11:59)
	-> /usr/local/bin/angsd -h 
	-> Analysis helpbox/synopsis information:
	-> Fri Feb  6 17:57:41 2026
--------------------
[shared.cpp:init()]
	-nThreads	1	Number of threads to use
	-nQueueSize	-1	Maximum number of queud elements
	-howOften	100	How often should the program show progress
	-> doMcall=0

Unknown argument supplied: '-h'


	-> angsd version: 0.940-dirty (htslib: 1.21) build(Dec 15 2024 09:11:58)
	-> Please use the website "http://www.popgen.dk/angsd" as reference
	-> Use -nThreads or -P for number of threads allocated to the program
Overview of methods:
	-GL		Estimate genotype likelihoods
	-doCounts	Calculate various counts statistics
	-doAsso		Perform association study
	-doMaf		Estimate allele frequencies
	-doError	Estimate the type specific error rates
	-doAncError	Estimate the errorrate based on perfect fastas
	-HWE_pval	Est inbreedning per site or use as filter
	-doGeno		Call genotypes
	-doFasta	Generate a fasta for a BAM file
	-doAbbababa	Perform an ABBA-BABA test
	-sites		Analyse specific sites (can force major/minor)
	-doSaf		Estimate the SFS and/or neutrality tests genotype calling
	-doHetPlas	Estimate hetplasmy by calculating a pooled haploid frequency

	Below are options that can be usefull
	-bam		Options relating to bam reading
	-doMajorMinor	Infer the major/minor using different approaches
	-ref/-anc	Read reference or ancestral genome
	-doSNPstat	Calculate various SNPstat
	-cigstat	Printout CIGAR stat across readlength
	many others

Output files:
	 In general the specific analysis outputs specific files, but we support basic bcf output
	-doBcf		Wrapper around -dopost -domajorminor -dofreq -gl -dovcf docounts
For information of specific options type: 
	./angsd METHODNAME eg 
		./angsd -GL
		./angsd -doMaf
		./angsd -doAsso etc
		./angsd sites for information about indexing -sites files
Examples:
	Estimate MAF for bam files in 'list'
		'./angsd -bam list -GL 2 -doMaf 2 -out RES -doMajorMinor 1'
```


## Metadata
- **Skill**: generated
