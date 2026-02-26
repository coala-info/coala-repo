# mmannot CWL Generation Report

## mmannot

### Tool Description
Compulsory options:
	-a file: annotation file in GTF format
	-r file1 [file2 ...]: reads in BAM/SAM format

### Metadata
- **Docker Image**: quay.io/biocontainers/mmannot:1.1--hd03093a_0
- **Homepage**: https://github.com/mzytnicki/mmannot
- **Package**: https://anaconda.org/channels/bioconda/packages/mmannot/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mmannot/overview
- **Total Downloads**: 4.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mzytnicki/mmannot
- **Stars**: N/A
### Original Help Text
```text
Error: wrong parameter '--help'.
Exiting.
Usage: mmannot [options]
	Compulsory options:
		-a file: annotation file in GTF format
		-r file1 [file2 ...]: reads in BAM/SAM format
	Main options:
		-o output: output file (default: stdout)
		-c config_file: configuration file (default: config.txt)
		-n name1 name2...: short name for each of the reads files
		-s strand: string (U, F, R, FR, RF, FF, defaut: F) (use several strand types if the library strategies differ)
		-f format (SAM or BAM): format of the read files (default: guess from file extension)
		-l integer: overlap type (<0: read is included, <1: % overlap, otherwise: # nt, default: -1)
		-d integer: upstream region size (default: 1000)
		-D integer: downstream region size (default: 1000)
		-y string: quantification strategy, valid values are: default, unique, random, ratio (default: default)
		-e integer: attribute a read to a feature if at least N% of the hits map to the feature (default: 100%)
	Output options:
		-p: print progress
		-m file: print mapping statistics for each read (slow, only work with 1 input file)
		-M file: print mapping statistics for each interval (slow, only work with 1 input file)
		-t integer: # threads (default: 1)
		-h: this help
```

