# mmquant CWL Generation Report

## mmquant

### Tool Description
Quantify reads against an annotation file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmquant:1.0.9--hdcf5f25_0
- **Homepage**: https://bitbucket.org/mzytnicki/multi-mapping-counter/
- **Package**: https://anaconda.org/channels/bioconda/packages/mmquant/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mmquant/overview
- **Total Downloads**: 9.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Error: wrong parameter '--help'.
Exiting.
Usage: mmquant [options]
	Compulsory options:
		-a file: annotation file in GTF format
		-r file1 [file2 ...]: reads in BAM/SAM format
	Main options:
		-o output: output file (default: stdout)
		-n name1 name2...: short name for each of the reads files
		-s strand: string (U, F, R, FR, RF, FF, defaut: U) (use several strand types if the library strategies differ)
		-e sorted: string (Y if reads are position-sorted, N otherwise, defaut: Y) (use several times if reads are not consistently (un)sorted)
		-f format (SAM or BAM): format of the read files (default: guess from file extension)
		-l integer: overlap type (<0: read is included, <1: % overlap, otherwise: # nt, default: -1)
	Ambiguous reads options:
		-c integer: count threshold (default: 0)
		-m float: merge threshold (default: 0)
		-d integer: number of overlapping bp between the best matches and the other matches (default: 30)
		-D float: ratio of overlapping bp between the best matches and the other matches (default: 2)
	Output options:
		-g: print gene name instead of gene ID in the output file
		-O file_name: print statistics to a file instead of stderr
		-F: use featureCounts output style
		-G string: provide the first column name in the output file (default: Gene)
		-p: print progress
		-t integer: # threads (default: 1)
		-v: version
		-h: this help
```

