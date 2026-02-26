# crossfilt CWL Generation Report

## crossfilt_crossfilt-lift

### Tool Description
Converts genome coordinates and nucleotide sequence for othologous segments in a BAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/crossfilt:0.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/kennethabarr/CrossFilt
- **Package**: https://anaconda.org/channels/bioconda/packages/crossfilt/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crossfilt/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-07-16
- **GitHub**: https://github.com/kennethabarr/CrossFilt
- **Stars**: N/A
### Original Help Text
```text
usage: crossfilt-lift [-h] -i INPUT -o OUTPUT -c CHAIN -t TARGET_FASTA -q
                      QUERY_FASTA [-p] [-b] [--version]

Converts genome coordinates and nucleotide sequence for othologous segments in
a BAM file

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        The input BAM file to convert
  -o OUTPUT, --output OUTPUT
                        Name prefix for the output file
  -c CHAIN, --chain CHAIN
                        The UCSC chain file
  -t TARGET_FASTA, --target-fasta TARGET_FASTA
                        The genomic sequence of the target (the species we are
                        converting from)
  -q QUERY_FASTA, --query-fasta QUERY_FASTA
                        The genomic sequence of the query (the species we are
                        converting to)
  -p, --paired          Add this flag if the reads are paired
  -b, --best            Only attempt to lift using the best chain
  --version             show program's version number and exit
```


## crossfilt_crossfilt-split

### Tool Description
Splits a bam file into equal sized chunks, keeping paired reads together. This may return fewer files than expected if many reads are missing a pair.

### Metadata
- **Docker Image**: quay.io/biocontainers/crossfilt:0.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/kennethabarr/CrossFilt
- **Package**: https://anaconda.org/channels/bioconda/packages/crossfilt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: crossfilt-split [-h] -i INPUT -o OUTPUT [-n NCPU] [-p]
                       (-f NFILES | -s FILE_SIZE) [--version]

Splits a bam file into equal sized chunks, keeping paired reads together. This
may return fewer files than expected if many reads are missing a pair.

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        The input BAM file to split
  -o OUTPUT, --output OUTPUT
                        Prefix for the output files
  -n NCPU, --ncpu NCPU  The number of CPU cores to use
  -p, --paired          Add this flag if the reads are paired
  -f NFILES, --nfiles NFILES
                        The number of files to split this into
  -s FILE_SIZE, --file-size FILE_SIZE
                        The number of reads per file
  --version             show program's version number and exit
```


## crossfilt_crossfilt-filter

### Tool Description
Outputs reads from bam1 that that have identical contig, position, CIGAR string, and tag values (optional) in bam2

### Metadata
- **Docker Image**: quay.io/biocontainers/crossfilt:0.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/kennethabarr/CrossFilt
- **Package**: https://anaconda.org/channels/bioconda/packages/crossfilt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: crossfilt-filter [-h] [-t TAG] [-x] [-@ THREADS] [--version] bam1 bam2

Outputs reads from bam1 that that have identical contig, position, CIGAR
string, and tag values (optional) in bam2

positional arguments:
  bam1                  Input bam file 1.
  bam2                  Input bam file 2.

options:
  -h, --help            show this help message and exit
  -t TAG, --tag TAG     Tag values to compare. Can be specified multiple times
                        to compare multiple tags.
  -x, --xf              Compare the XF tag. Equivalent to --tag XF
  -@ THREADS, --threads THREADS
                        Number of compression/decrpression threads when
                        reading/writing bam files.
  --version             show program's version number and exit
```

