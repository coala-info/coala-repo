# gargammel-slim CWL Generation Report

## gargammel-slim_fragSim

### Tool Description
This program takes a fasta file representing a chromosome and generates
aDNA fragments according to a certain distribution

### Metadata
- **Docker Image**: quay.io/biocontainers/gargammel-slim:1.1.2--hf107e4d_6
- **Homepage**: https://github.com/grenaud/gargammel
- **Package**: https://anaconda.org/channels/bioconda/packages/gargammel-slim/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gargammel-slim/overview
- **Total Downloads**: 5.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/grenaud/gargammel
- **Stars**: N/A
### Original Help Text
```text
This program takes a fasta file representing a chromosome and generates
 aDNA fragments according to a certain distribution

 fragSim [options]  [chromosome fasta] 

		-n	[number]			Generate [number] fragments (default: 10)

		--comp	[file]				Base composition for the fragments (default none)
		--dist	[file]				Distance from ends to consider  (default: 1)
							if this is not specified, the base composition
							will only reflect the chromosome file used
		--norev					Do not reverse complement (default: rev. comp half of seqs.)
		--case					Do not set the sequence to upper-case (default: uppercase the seqs.)

	Output options
		-b	[bam out]			Write output as a BAM file (default: fasta in stdout)
		-o	[fasta out]			Write output as a zipped fasta (default: fasta in stdout)
		-u					Produce uncompressed BAM (good for unix pipe)
		-tag	[tag]				Append this string to deflines or BAM tags (Default:  not on/not used)
		-tmp	[tmp dir]			Use this directory as the temporary dir for zipped files (default:  /tmp/)
		-uniq					Make sure that the fragment names are unique by appending a suffix (default:  not on/not used)
							note: this might not be practical for large datasets

	Fragment size: 
		-m	[length]			Minimum fragments length < (default: 0)
		-M	[length]			Maximum fragments length > (default: 1000)

	Fragment size distribution: specify either one of the 4 possible options
		-l	[length]			Generate fragments of fixed length  (default: 20)
		-s	[file]				Open file with size distribution (one fragment length per line)
		-f	[file]				Open file with size frequency in the following format:
								length[TAB]freq	ex:
								40	0.0525
								41	0.0491
								...

		Length options:
			--loc	[file]			Location for lognormal distribution (default none)
			--scale	[file]			Scale for lognormal distribution      (default none)

		GC bias options:
		-gc	[gc bias]			Use GC bias factor  (default: 0)
```


## gargammel-slim_deamSim

### Tool Description
Reads a fasta (default) or BAM file containing aDNA fragments and adds deamination according to a certain model file. Some model files are found in the models/ directory. If the input is fasta, the output will be fasta as well.

### Metadata
- **Docker Image**: quay.io/biocontainers/gargammel-slim:1.1.2--hf107e4d_6
- **Homepage**: https://github.com/grenaud/gargammel
- **Package**: https://anaconda.org/channels/bioconda/packages/gargammel-slim/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:

	deamSim [options]  [fasta or BAM file]

 This program reads a fasta (default) or BAM file containing aDNA fragments and
 adds deamination according to a certain model file
 some model files are found the models/ directory
 if the input is fasta, the output will be fasta as well

 I/O Options:
		-b	[BAM out]			Read BAM and write output as a BAM (default: fasta)
		-u					Produce uncompressed BAM (good for unix pipe)
		-o	[fasta out]			Write fasta output as a zipped fasta
		-name					Put a tag in the read name with deam bases (default not on/not used)
		-v					verbose mode
		-last					If matfile is used, do not use the substitution rates of the
							last row over the rest of the molecule (default: no data = use last row)

 Mandatory deamination options:
	Specify either:
		-mapdamage  [mis.txt] [protocol]	Read the miscorporation file [mis.txt]
		                               		produced by mapDamage
		                               		[protocol] can be either "single" or "double" (without quotes)
		                               		Single strand will have C->T damage on both ends
		                               		Double strand will have and C->T at the 5' end and G->A damage at the 3' end

		-matfile  [matrix file prefix]		Read the matrix file of substitutions instead of the default
		                               		Provide the prefix only, both files must end with
		                               		5.dat and 3.dat

		-matfilenonmeth  [matrix file prefix]	Read the matrix file of substitutions for non-methylated Cs
		                               		Provide the prefix only, both files must end with
		                               		5.dat and 3.dat

		-matfilemeth  [matrix file prefix]	Read the matrix file of substitutions for methylated Cs
		                               		Provide the prefix only, both files must end with
		                               		5.dat and 3.dat

		-mat      [ancient DNA matrix]		For default matrices, use either "single" or "double" (without quotes)
		                               		Single strand will have C->T damage on both ends
		                               		Double strand will have and C->T at the 5p end and G->A damage at the 3p end
		-damage     [v,l,d,s]			For the Briggs et al. 2007 model
		                               		The parameters must be comma-separated e.g.: -damage 0.03,0.4,0.01,0.7
		                               			v: nick frequency
		                               			l: length of overhanging ends (geometric parameter)
		                               			d: prob. of deamination of Cs in double-stranded parts
		                               			s: prob. of deamination of Cs in single-stranded parts
```


## gargammel-slim_adptSim

### Tool Description
This program reads a fasta file containing aDNA fragments and splits them into two records, one containing the forward read and the second containing the reverse read (-fr,-rr) or into a single for single-end mode (-fr)

### Metadata
- **Docker Image**: quay.io/biocontainers/gargammel-slim:1.1.2--hf107e4d_6
- **Homepage**: https://github.com/grenaud/gargammel
- **Package**: https://anaconda.org/channels/bioconda/packages/gargammel-slim/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:

	adptSim [options]  [BAM/fasta file]

 This program reads a fasta file containing aDNA fragments and
 splits them into two records, one containing the forward read
 and the second containing the reverse read (-fr,-rr)
 or into a single for single-end mode (-fr)
	Options:

		I/O options:
		-arts	[out]		Output single-end reads as ART (unzipped fasta) (Default: /dev/null)
		-artp	[out]		Output reads as ART (unzipped fasta) (Default: /dev/null)
					with wrap-around for paired-end mode
		-fr	[out fwdr]	Output forward read as zipped fasta (Default: )
		-rr	[out rwdr]	Output reverse read as zipped fasta (Default: /dev/null)
		-bs	[BAM out]	Read BAM and write output as a single-end BAM (Default: fasta)
		-bp	[BAM out]	Read BAM and write output as a single-end BAM (Default: fasta)
		-u			Produce uncompressed BAM (good for unix pipe)

	-f	[seq]			Adapter that is observed after the forward read (Default:  AGATCGGAAG...)
	-s	[seq]			Adapter that is observed after the reverse read (Default:  AGATCGGAAG...)
	-l	[length]		Desired read length  (Default:  100)
	-name				Append BAM tags or to deflines if adapters are added (Default:  not on/not used)
	-tag	[tag]			Append this string to deflines or BAM tags (Default:  not on/not used)
```


## Metadata
- **Skill**: generated
