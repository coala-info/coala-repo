# fec CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fec_Fec | PASS | nf-core sarscov2 nanopore reads with minimap2 overlaps: 2558 corrected reads, identity to the reference rose from 93.9% to 99.2%; the PAF is staged writable |

## fec_Fec

### Tool Description
Error correction of long reads (PacBio, Nanopore) with two rounds of overlapping and caching

### Metadata
- **Docker Image**: quay.io/biocontainers/fec:1.0.1--he70b90d_2
- **Homepage**: https://github.com/zhangjuncsu/Fec
- **Package**: https://anaconda.org/channels/bioconda/packages/fec/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE:
Fec [options] input reads output

OPTIONS:
-x <0/1>	data type: 0 = PacBio, 1 = Nanopore
-t <Integer>	number of threads (CPUs)
-p <Integer>	batch size that the reads will be partitioned
-r <Real>	minimum mapping ratio
-a <Integer>	minimum overlap size
-c <Integer>	minimum coverage under consideration
-l <Integer>	minimum length of corrected sequence
-k <Integer>	number of partition files to open at one time (if < 0, then it will be set to system limit value)
-e <Integer>	use cache or not: 0 = not use, 1 = use
-s <Integer>	perform second-round overlapping or not: 0 = not perform, 1 = perform
-m <String>	filter out top fraction repetitive minimizers of the second-round overlapping
-f <String>	minimum overlap ratio used for the second-round overlapping filtering
-K <Integer>	k-mer size or the second-round overlapping
-w <Integer>	minimizer window size for the second-round overlapping
-H		use homopolymer-compressed k-mer for the second-round overlapping
-R		resuse long indel
-F		full consensus
-h		print usage info.

Default Options:
-t 1 -p 100000 -r 0.6 -a 1000 -c 4 -l 2000 -k 100 -e 1 -s 1 -m 0.0002 -f 0.6 -K 15 -w 5 -H
```

