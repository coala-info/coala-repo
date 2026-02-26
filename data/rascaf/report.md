# rascaf CWL Generation Report

## rascaf

### Tool Description
RASCaf: a tool for scaffolding genome assemblies using BAM alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/rascaf:20180710--h5ca1c30_1
- **Homepage**: https://github.com/mourisl/Rascaf
- **Package**: https://anaconda.org/channels/bioconda/packages/rascaf/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rascaf/overview
- **Total Downloads**: 8.1K
- **Last updated**: 2025-09-10
- **GitHub**: https://github.com/mourisl/Rascaf
- **Stars**: N/A
### Original Help Text
```text
usage: rascaf [options]
options:
	-b STRING (required): the path to the coordinate-sorted alignment BAM file
	-f STRING (recommended): the paths to the raw assembly fasta file(default: not used)
	-o STRING : prefix of the output file (default: rascaf)
	-bc STRING: the path to the alignment BAM file allowing clipping from non-spliced aligner (default: not used)
	-ms INT: minimum support for connecting two contigs(default: 2)
	-ml INT: minimum exonic length(default: 200)
	-breakN INT: the least number of Ns to break a scaffold in the raw assembly (default: 1)
	-k INT: the size of a kmer(<=32; <=0 if you do not want to use kmer. default: 23)
	-cs : output the genomic sequence involved in connections in file $prefix_cs.fa (default: not used)
	-v : verbose mode (default: false)
```

