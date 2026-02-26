# virdig CWL Generation Report

## virdig

### Tool Description
virdig is a tool for viral genome assembly.

### Metadata
- **Docker Image**: quay.io/biocontainers/virdig:1.0.0--h5ca1c30_0
- **Homepage**: https://github.com/Limh616/VirDiG
- **Package**: https://anaconda.org/channels/bioconda/packages/virdig/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/virdig/overview
- **Total Downloads**: 512
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Limh616/VirDiG
- **Stars**: N/A
### Original Help Text
```text
===============================================================================
Usage 
===============================================================================
 ** Options: **
  -k <int>: length of kmer, default 31. 
  -o <string>: output directory. 
  -h : help information. 
  Pair end reads: 
  -l <string>: left reads file name (.fasta). 
  -r <string>: right reads file name (.fasta). 
  -d <int>: pair-end reads directions can be defined, 1: opposite directions  2: same direction. default: 1. 
  -t <int>: number of threads, default 6. 
  --ref_genome_len <int>: approximate length of the viral reference genome, default 30000. 
  --non_canonical <int>: whether to generate non-standard transcripts, 1 : true, 0 : false, default 0. 
  --map_weight <float>: paired-end reads are assigned paired node weights, recommended to be in the range of 0 to 1, default 0.6. 
===============================================================================
```

