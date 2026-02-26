# siann CWL Generation Report

## siann_siann.py

### Tool Description
Please contact git@signaturescience.com with questions about this tool (C) 2020, Signature Science, LLC

### Metadata
- **Docker Image**: quay.io/biocontainers/siann:1.3--hdfd78af_0
- **Homepage**: https://github.com/signaturescience/siann/wiki
- **Package**: https://anaconda.org/channels/bioconda/packages/siann/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/siann/overview
- **Total Downloads**: 11.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/signaturescience/siann
- **Stars**: N/A
### Original Help Text
```text
usage: siann.py [-h] [-d DB] [-t THREADS] [-p PAIRED] [--report] [--reads_out]
                [--keep_sam] -r READS --out OUT [-v]

usage: %prog [options] input output

optional arguments:
  -h, --help            show this help message and exit
  -d DB, --db DB        database of reference genomes to use
  -t THREADS, --threads THREADS
                        number of threads to use for alignment (all by
                        default)
  -p PAIRED, --paired PAIRED
                        second set of reads in pair (if any)
  --report              turn off the generation of a report
  --reads_out           turn on the output of species- and strain-specific
                        reads
  --keep_sam            retain the aligned reads in SAM format
  -r READS, --reads READS
                        Set of reads (FASTQ/FASTA) to be processed
  --out OUT             Prefix for output files
  -v, --version         print version

Please contact git@signaturescience.com with questions about this tool (C)
2020, Signature Science, LLC
```

