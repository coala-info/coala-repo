# samstats CWL Generation Report

## samstats_SAMstats

### Tool Description
Compute SAM file mapping statistics for a SAM file sorted by read name

### Metadata
- **Docker Image**: quay.io/biocontainers/samstats:0.2.2--py_0
- **Homepage**: https://github.com/kundajelab/SAMstats
- **Package**: https://anaconda.org/channels/bioconda/packages/samstats/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/samstats/overview
- **Total Downloads**: 8.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/kundajelab/SAMstats
- **Stars**: N/A
### Original Help Text
```text
usage: SAMstats [-h] --sorted_sam_file SORTED_SAM_FILE [--outf OUTF]
                [--chunk_size CHUNK_SIZE]

Compute SAM file mapping statistics for a SAM file sorted by read name

optional arguments:
  -h, --help            show this help message and exit
  --sorted_sam_file SORTED_SAM_FILE
                        Input SAM file. Use '-' if input is being piped from
                        stdin. File must be sorted by read name.
  --outf OUTF           Output file name to store alignment statistics. The
                        statistics will be printed to stdout if no file is
                        provided
  --chunk_size CHUNK_SIZE
                        Number of lines to read a time from sortedSamFile
```


## samstats_SAMstatsParallel

### Tool Description
Compute SAM file mapping statistics for a SAM file sorted by read name

### Metadata
- **Docker Image**: quay.io/biocontainers/samstats:0.2.2--py_0
- **Homepage**: https://github.com/kundajelab/SAMstats
- **Package**: https://anaconda.org/channels/bioconda/packages/samstats/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SAMstatsParallel [-h] --sorted_sam_file SORTED_SAM_FILE [--outf OUTF]
                        [--chunk_size CHUNK_SIZE] [--threads THREADS]

Compute SAM file mapping statistics for a SAM file sorted by read name

optional arguments:
  -h, --help            show this help message and exit
  --sorted_sam_file SORTED_SAM_FILE
                        Input SAM file. Use '-' if input is being piped from
                        stdin. File must be sorted by read name.
  --outf OUTF           Output file name to store alignment statistics. The
                        statistics will be printed to stdout if no file is
                        provided
  --chunk_size CHUNK_SIZE
                        Number of lines to read a time from sortedSamFile
  --threads THREADS     number of threads to use. Note: the default is
```


## Metadata
- **Skill**: generated
