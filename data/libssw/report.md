# libssw CWL Generation Report

## libssw_ssw_test

### Tool Description
Performs Smith-Waterman alignment on target and query sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/libssw:1.2.5--h5ca1c30_0
- **Homepage**: https://github.com/mengyao/Complete-Striped-Smith-Waterman-Library
- **Package**: https://anaconda.org/channels/bioconda/packages/libssw/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/libssw/overview
- **Total Downloads**: 6.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mengyao/Complete-Striped-Smith-Waterman-Library
- **Stars**: N/A
### Original Help Text
```text
Usage: ssw_test [options] ... <target.fasta> <query.fasta>(or <query.fastq>)
Options:
	-m N	N is a positive integer for weight match in genome sequence alignment. [default: 2]
	-x N	N is a positive integer. -N will be used as weight mismatch in genome sequence alignment. [default: 2]
	-o N	N is a positive integer. -N will be used as the weight for the gap opening. [default: 3]
	-e N	N is a positive integer. -N will be used as the weight for the gap extension. [default: 1]
	-p	Do protein sequence alignment. Without this option, the ssw_test will do genome sequence alignment.
	-a FILE	FILE is either the Blosum or Pam weight matrix. [default: Blosum50]
	-c	Return the alignment path.
	-f N	N is a positive integer. Only output the alignments with the Smith-Waterman score >= N.
	-r	The best alignment will be picked between the original read alignment and the reverse complement read alignment.
	-s	Output in SAM format. [default: no header]
	-h	If -s is used, include header in SAM output.
```

