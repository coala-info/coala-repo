# bior_annotate CWL Generation Report

## bior_annotate

### Tool Description
Annotates variants in a given input file (vcf)

### Metadata
- **Docker Image**: biocontainers/bior_annotate:v2.1.1_cv3
- **Homepage**: https://github.com/michaelmeiners/biorAnnotateLite
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bior_annotate/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/michaelmeiners/biorAnnotateLite
- **Stars**: N/A
### Original Help Text
```text
NAME
	bior_annotate -- Annotates variants in a given input file (vcf)

SYNOPSIS
	bior_annotate [--configfile <CONFIG FILE>] [--help] [--log]

DESCRIPTION
	The bior_annotate command adds functional annotation to a given set of variants and the
	results are sent to STDOUT.

	The options are as follows:

	-c, --configfile <CONFIG FILE>
		The config file containing the columns to be shown in the result.

	-h, --help
		print this message

	-l, --log
		Use this option to generate the log file. By default, the log file is not generated.

EXAMPLE
	Given a file with rsIDs, fetch annotations for just the columns that we specify in the config
	file 
	(with results compressed so that multiple lines with the same variant but different
	annotations are still on one line):
	cat data.txt
		#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO
		chr1	216424275	rs696723	C	G	.	.	.
	
	cat data.txt | bior_annotate -c myAnnotConfig.txt
		#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	rsID	dbSNP.SuspectRegion	dbSNP.ClinicalSig	dbSNP.DiseaseVariant	COSMIC.Mutation_ID	COSMIC.Mutation_CDS	COSMIC.Mutation_AA	COSMIC.strand	1000Genomes.AMR_AF	1000Genomes.AFR_AF	1000Genomes.EUR_AF
		chr1	216424275	rs696723	C	G	.	.	.	rs696723	unspecified	untested	0	.	.	.	.	.	0.02	0.17	0.01
```

