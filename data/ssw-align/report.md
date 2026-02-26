# ssw-align CWL Generation Report

## ssw-align

### Tool Description
Performs Smith-Waterman alignment on target and query sequences.

### Metadata
- **Docker Image**: biocontainers/ssw-align:v1.1-2-deb_cv1
- **Homepage**: https://github.com/kyu999/ssw_aligner
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ssw-align/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/kyu999/ssw_aligner
- **Stars**: N/A
### Original Help Text
```text
Usage: ssw-align [options] ... <target.fasta> <query.fasta>(or <query.fastq>)
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

