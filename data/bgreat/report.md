# bgreat CWL Generation Report

## bgreat

### Tool Description
BGreat is a tool for de novo assembly of DNA sequencing reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/bgreat:2.0.0--hdb21b49_8
- **Homepage**: https://github.com/Malfoy/BGREAT2
- **Package**: https://anaconda.org/channels/bioconda/packages/bgreat/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bgreat/overview
- **Total Downloads**: 6.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Malfoy/BGREAT2
- **Stars**: N/A
### Original Help Text
```text
Mandatory arguments
-u read file (unpaired)
-x read file (paired)
-k k value used for graph 
-g unitig file (unitig.fa)

Regular options
-f output file (paths)
-q if  read file are FASTQ
-O to keep order of the reads
-a anchors length (31)
-m number of missmatch allowed (5)
-t number of threads used (1)
-c to output corrected reads
-z to compress output file
-i anchor fraction to be indexed (default 1=all, 5 for one out of 5)

Advanced options
-C to output compressed reads
-p to more precise output
-P to print the alignments
-A to output all possible mapping
-B to output all possible optimal mapping
-o maximal occurence of an anchor (1)
-e effort put in mapping (1000)
-F to output any optimal mapping
```

