# cobra-meta CWL Generation Report

## cobra-meta

### Tool Description
This script is used to get higher quality (including circular) virus genomes by joining assembled contigs based on their end overlaps.

### Metadata
- **Docker Image**: quay.io/biocontainers/cobra-meta:1.2.3--pyhdfd78af_0
- **Homepage**: https://github.com/linxingchen/cobra
- **Package**: https://anaconda.org/channels/bioconda/packages/cobra-meta/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cobra-meta/overview
- **Total Downloads**: 2.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/linxingchen/cobra
- **Stars**: N/A
### Original Help Text
```text
usage: cobra-meta [-h] -q QUERY -f FASTA -a {idba,megahit,metaspades} -mink
                  MINK -maxk MAXK -m MAPPING -c COVERAGE
                  [-lm LINKAGE_MISMATCH] [-o OUTPUT] [-t THREADS] [-v]

This script is used to get higher quality (including circular) virus genomes
by joining assembled contigs based on their end overlaps.

options:
  -h, --help            show this help message and exit
  -lm LINKAGE_MISMATCH, --linkage_mismatch LINKAGE_MISMATCH
                        the max read mapping mismatches for determining if two
                        contigs are spanned by paired reads. [2]
  -o OUTPUT, --output OUTPUT
                        the name of output folder (default = '<query>_COBRA').
  -t THREADS, --threads THREADS
                        the number of threads for blastn. [16]
  -v, --version         show program's version number and exit

required named arguments:
  -q QUERY, --query QUERY
                        the query contigs file (fasta format), or the query
                        name list (text file, one column).
  -f FASTA, --fasta FASTA
                        the whole set of assembled contigs (fasta format).
  -a {idba,megahit,metaspades}, --assembler {idba,megahit,metaspades}
                        de novo assembler used, COBRA not tested for others.
  -mink MINK, --mink MINK
                        the min kmer size used in de novo assembly.
  -maxk MAXK, --maxk MAXK
                        the max kmer size used in de novo assembly.
  -m MAPPING, --mapping MAPPING
                        the reads mapping file in sam or bam format.
  -c COVERAGE, --coverage COVERAGE
                        the contig coverage file (two columns divided by tab).
```

