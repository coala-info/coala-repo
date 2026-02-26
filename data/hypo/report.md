# hypo CWL Generation Report

## hypo

### Tool Description
Polishes draft genomes using short and/or long reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/hypo:1.0.3--h9a82719_1
- **Homepage**: https://github.com/kensung-lab/hypo
- **Package**: https://anaconda.org/channels/bioconda/packages/hypo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hypo/overview
- **Total Downloads**: 18.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/kensung-lab/hypo
- **Stars**: N/A
### Original Help Text
```text
Usage: hypo <args>

 ** Mandatory args:
	-r, --reads-short <str>
	Input file name containing reads (in fasta/fastq format; can be compressed). A list of files containing file names in each line can be passed with @ prefix.

	-d, --draft <str>
	Input file name containing the draft contigs (in fasta/fastq format; can be compressed). 

	-b, --bam-sr <str>
	Input file name containing the alignments of short reads against the draft (in bam/sam format; must have CIGAR information). 

	-c, --coverage-short <int>
	Approximate mean coverage of the short reads. 

	-s, --size-ref <str>
	Approximate size of the genome (a number; could be followed by units k/m/g; e.g. 10m, 2.3g). 


 ** Optional args:
	-B, --bam-lr <str>
	Input file name containing the alignments of long reads against the draft (in bam/sam format; must have CIGAR information). 
	[Only Short reads polishing will be performed if this argument is not given]

	-o, --output <str>
	Output file name. 
	[Default] hypo_<draft_file_name>.fasta in the working directory.

 	-t, --threads <int>
	Number of threads. 
	[Default] 1.

 	-p, --processing-size <int>
	Number of contigs to be processed in one batch. Lower value means less memory usage but slower speed. 
	[Default] All the contigs in the draft.

 	-k, --kind-sr <str>
	Kind of the short reads. 
	[Valid Values] 
		sr	(Corresponding to NGS reads like Illumina reads) 
		ccs	(Corresponding to HiFi reads like PacBio CCS reads) 
	[Default] sr.

 	-m, --match-sr <int>
	Score for matching bases for short reads. 
	[Default] 5.

 	-x, --mismatch-sr <int>
	Score for mismatching bases for short reads. 
	[Default] -4.

 	-g, --gap-sr <int>
	Gap penalty for short reads (must be negative). 
	[Default] -8.

 	-M, --match-lr <int>
	Score for matching bases for long reads. 
	[Default] 3.

 	-X, --mismatch-lr <int>
	Score for mismatching bases for long reads. 
	[Default] -5.

 	-G, --gap-lr <int>
	Gap penalty for long reads (must be negative). 
	[Default] -4.

 	-n, --ned-th <int>
	Threshold for Normalised Edit Distance of long arms allowed in a window (in %). Higher number means more arms allowed which may slow down the execution.
	[Default] 20.

 	-q, --qual-map-th <int>
	Threshold for mapping quality of reads. The reads with mapping quality below this threshold will not be taken into consideration. 
	[Default] 2.

 	-i, --intermed
	Store or use (if already exist) the intermediate files. 
	[Currently, only Solid kmers are stored as an intermediate file.].

 	-h, --help
	Print the usage.
```

