# circminer CWL Generation Report

## circminer

### Tool Description
CircRNA detection and analysis tool

### Metadata
- **Docker Image**: quay.io/biocontainers/circminer:0.4.2--h5ca1c30_6
- **Homepage**: https://github.com/vpc-ccg/circminer
- **Package**: https://anaconda.org/channels/bioconda/packages/circminer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/circminer/overview
- **Total Downloads**: 6.5K
- **Last updated**: 2025-11-14
- **GitHub**: https://github.com/vpc-ccg/circminer
- **Stars**: N/A
### Original Help Text
```text
SYNOPSIS
	circminer --index -r FILE [options]
	circminer -r FILE -g FILE -s FILE [options]
	circminer -r FILE -g FILE -1 FILE -2 FILE [options]

Indexing options:
	-i, --index:		Indicates the indexing stage.
	-m, --compact-index:	Use this option only while building the index to enable compact version of the index.
	-k, --kmer:		Kmer size [14..22] (default = 20).

General options:
	-r, --reference:	Reference file.
	-g, --gtf:		Gene model file.
	-s, --seq:		Single-end sequence file.
	-1, --seq1:		1st paired-end sequence file.
	-2, --seq2:		2nd paired-end sequence file.

Advanced options:
	-l, --rlen:		Max read length (default = 300).
	-e, --max-ed:		Max allowed edit distance on each mate (default = 4).
	-c, --max-sc:		Max allowed soft clipping on each mate (default = 7).
	-w, --band:		Band width for banded alignment (default = 3).
	-S, --seed-lim:		Skip seeds that have more than INT occurrences (default = 500).
	-T, --max-tlen:		Maximum template length of concordant mapping. Paired-end mode only (default = 500).
	-I, --max-intron:	Maximum length of an intron (default = 2000000).
	-C, --max-chain-list:	Maximum number of chained candidates to be processed (default = 30).
	-o, --output:		Prefix of output files (default = output).
	-t, --thread:		Number of threads (default = 1).
	-A, --sam:		Enables SAM output for aligned reads. Cannot be set along with --pam.
	-P, --pam:		Enables custom pam output for aligned reads. Cannot be set along with --sam.
	-d, --verbosity:	Verbosity mode: 0 or 1. Higher values output more information (default = 0).
	-a, --scan-lev:		Transcriptome/Genome scan level: 0 to 2. (default = 0)
				0: Report the first mapping.
				1: Continue processing the read unless it is perfectly mapped to cDNA.
				2: Report the best mapping.

Other options:
	-h, --help:	Shows help message.
	-v, --version:	Current version.

Examples:
	Indexing the reference genome:
	$ ./circminer --index -r ref.fa -k 20
	circRNA detection of single-end RNA-Seq reads:
	$ ./circminer -r ref.fa -g gene_model.gtf -s reads.fastq -o output 
	circRNA detection of paired-end RNA-Seq reads:
	$ ./circminer -r ref.fa -g gene_model.gtf -1 reads_1.fastq -2 reads_2.fastq -o output
```

