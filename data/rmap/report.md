# rmap CWL Generation Report

## rmap

### Tool Description
Map fastq reads to a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/rmap:2.1--0
- **Homepage**: https://github.com/juruen/rmapi
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rmap/overview
- **Total Downloads**: 6.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/juruen/rmapi
- **Stars**: N/A
### Original Help Text
```text
Usage: rmap [OPTIONS] <fastq-reads-file>

Options:
  -o, -output     output file name 
  -c, -chrom      chromosomes in FASTA file or dir 
  -T, -start      index of first read to map 
  -N, -number     number of reads to map 
  -s, -suffix     suffix of chrom files (assumes dir provided) 
  -m, -mismatch   maximum allowed mismatches 
  -a, -ambiguous  file to write names of ambiguously mapped reads 
  -M, -max-map    maximum allowed mappings for a read 
  -C, -clip       clip the specified adaptor 
  -v, -verbose    print more run info 

Help options:
  -?, -help       print this help message 
      -about      print about message
```

