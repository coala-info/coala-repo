# psiclass CWL Generation Report

## psiclass

### Tool Description
A tool for transcriptome assembly and consensus transcript voting across multiple samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/psiclass:1.0.3--h5ca1c30_6
- **Homepage**: https://github.com/splicebox/PsiCLASS
- **Package**: https://anaconda.org/channels/bioconda/packages/psiclass/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/psiclass/overview
- **Total Downloads**: 9.1K
- **Last updated**: 2025-09-26
- **GitHub**: https://github.com/splicebox/PsiCLASS
- **Stars**: N/A
### Original Help Text
```text
Usage: ./psiclass [OPTIONS]
Required:
	-b STRING: paths to the alignment BAM files. Use comma to separate multiple BAM files
		or
	--lb STRING: path to the file listing the alignments BAM files
Optional:
	-s STRING: path to the trusted splice file (default: not used)
	-o STRING: prefix of output files (default: ./psiclass)
	-p INT: number of processes/threads (default: 1)
	-c FLOAT: only use the subexons with classifier score <= than the given number (default: 0.05)
	--sa FLOAT: the minimum average number of supported read for retained introns (default: 0.5)
	--vd FLOAT : the minimum average coverage depth of a transcript to be reported (defaults: 1.0)
	--stranded STRING: un/rf/fr for library unstranded/fr-firstand/fr-secondstrand (default: not used)
	--maxDpConstraintSize: the number of subexons a constraint can cover in DP. (default: 7. -1 for inf)
	--bamGroup STRING: path to the file listing the group id of BAMs in the --lb file (default: not used)
	--primaryParalog: use primary alignment to retain paralog genes (default: use unique alignments)
	--tssTesQuantile FLOAT: the quantile for transcription start/end sites in subexon graph (default: 0.5)
	--version: print version and exit
	--stage INT:  (default: 0)
		0-start from beginning - building splice sites for each sample
		1-start from building subexon files for each sample
		2-start from combining subexon files across samples
		3-start from assembling the transcripts for each sample
		4-start from voting the consensus transcripts across samples
```

