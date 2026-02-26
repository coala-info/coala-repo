# rtg-tools CWL Generation Report

## rtg-tools_rtg

### Tool Description
RTG-Tools command-line interface. Type 'rtg help COMMAND' for help on a specific command.

### Metadata
- **Docker Image**: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
- **Homepage**: https://github.com/RealTimeGenomics/rtg-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rtg-tools/overview
- **Total Downloads**: 187.5K
- **Last updated**: 2025-05-29
- **GitHub**: https://github.com/RealTimeGenomics/rtg-tools
- **Stars**: N/A
### Original Help Text
```text
Usage: rtg COMMAND [OPTION]...
       rtg RTG_MEM=16G COMMAND [OPTION]...  (e.g. to set maximum memory use to
	             	16 GB)

Type 'rtg help COMMAND' for help on a specific command.
The following commands are available:

Data formatting:
	format       	convert sequence data files to SDF
	sdf2fasta    	convert SDF to FASTA
	sdf2fastq    	convert SDF to FASTQ
	sdf2sam      	convert SDF to SAM/BAM
	fastqtrim    	trim reads in FASTQ files

Simulation:
	genomesim    	generate simulated genome sequence
	cgsim        	generate simulated reads from a sequence
	readsim      	generate simulated reads from a sequence
	popsim       	generate a VCF containing simulated population variants
	samplesim    	generate a VCF containing a genotype simulated from a population
	childsim     	generate a VCF containing a genotype simulated as a child of two
	             	parents
	denovosim    	generate a VCF containing a derived genotype containing de novo
	             	variants
	pedsamplesim 	generate simulated genotypes for all members of a pedigree
	samplereplay 	generate the genome corresponding to a sample genotype

Utility:
	bgzip        	compress a file using block gzip
	index        	create a tabix index
	extract      	extract data from a tabix indexed file
	sdfstats     	print statistics about an SDF
	sdfsubset    	extract a subset of an SDF into a new SDF
	sdfsubseq    	extract a subsequence from an SDF as text
	mendelian    	check a multisample VCF for Mendelian consistency
	vcfstats     	print statistics about variants contained within a VCF file
	vcfmerge     	merge single-sample VCF files into a single multi-sample VCF
	vcffilter    	filter records within a VCF file
	vcfannotate  	annotate variants within a VCF file
	vcfsubset    	create a VCF file containing a subset of the original columns
	vcfsplit     	split a multi-sample VCF into one file per sample
	vcfdecompose 	decompose complex variants within a VCF file
	vcfeval      	evaluate called variants for agreement with a baseline variant
	             	set
	vcf2rocplot  	produce rocplot compatible ROC data files from vcfeval annotated
	             	VCFs
	svdecompose  	split composite structural variants into a breakend
	             	representation
	bndeval      	evaluate called breakends for agreement with a baseline breakend
	             	set
	cnveval      	evaluate called CNV regions for agreement with a baseline CNV
	             	set
	pedfilter    	filter and convert a pedigree file
	pedstats     	print information about a pedigree file
	rocplot      	plot ROC curves from vcfeval ROC data files
	version      	print version and license information
	license      	print license information for all commands
	help         	print this screen or help for specified command
```

