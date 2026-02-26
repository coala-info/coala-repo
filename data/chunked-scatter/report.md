# chunked-scatter CWL Generation Report

## chunked-scatter

### Tool Description
Given a sequence dict, fasta index or a bed file, scatter over the defined contigs/regions. Each contig/region will be split into multiple overlapping regions, which will be written to a new bed file. Each contig will be placed in a new file, unless the length of the contigs/regions doesn't exceed a given number.

### Metadata
- **Docker Image**: quay.io/biocontainers/chunked-scatter:1.0.0--py_0
- **Homepage**: https://github.com/biowdl/chunked-scatter
- **Package**: https://anaconda.org/channels/bioconda/packages/chunked-scatter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chunked-scatter/overview
- **Total Downloads**: 8.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biowdl/chunked-scatter
- **Stars**: N/A
### Original Help Text
```text
usage: chunked-scatter [-h] [-p PREFIX] [-S] [-P] [-c SIZE]
                       [-m MINIMUM_BP_PER_FILE] [-o OVERLAP]
                       INPUT

Given a sequence dict, fasta index or a bed file, scatter over the defined
contigs/regions. Each contig/region will be split into multiple overlapping
regions, which will be written to a new bed file. Each contig will be placed
in a new file, unless the length of the contigs/regions doesn't exceed a given
number.

positional arguments:
  INPUT                 The input file. The format is detected by the
                        extension. Supported extensions are: '.bed', '.dict',
                        '.fai', '.vcf', '.vcf.gz', '.bcf'.

optional arguments:
  -h, --help            show this help message and exit
  -p PREFIX, --prefix PREFIX
                        The prefix of the ouput files. Output will be named
                        like: <PREFIX><N>.bed, in which N is an incrementing
                        number. Default 'scatter-'.
  -S, --split-contigs   If set, contigs are allowed to be split up over
                        multiple files.
  -P, --print-paths     If set prints paths of the output files to STDOUT.
                        This makes the program usable in scripts and
                        worfklows.
  -c SIZE, --chunk-size SIZE
                        The size of the chunks. The first chunk in a region or
                        contig will be exactly length SIZE, subsequent chunks
                        will SIZE + OVERLAP and the final chunk may be
                        anywhere from 0.5 to 1.5 times SIZE plus overlap. If a
                        region (or contig) is smaller than SIZE the original
                        regions will be returned. Defaults to 1e6
  -m MINIMUM_BP_PER_FILE, --minimum-bp-per-file MINIMUM_BP_PER_FILE
                        The minimum number of bases represented within a
                        single output bed file. If an input contig or region
                        is smaller than this MINIMUM_BP_PER_FILE, then the
                        next contigs/regions will be placed in the same file
                        untill this minimum is met. Defaults to 45e6.
  -o OVERLAP, --overlap OVERLAP
                        The number of bases which each chunk should overlap
                        with the preceding one. Defaults to 150.
```

