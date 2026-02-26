# abruijn CWL Generation Report

## abruijn

### Tool Description
ABruijn: assembly of long and error-prone reads

### Metadata
- **Docker Image**: quay.io/biocontainers/abruijn:2.1b--py27_0
- **Homepage**: https://github.com/fenderglass/ABruijn/
- **Package**: https://anaconda.org/channels/bioconda/packages/abruijn/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/abruijn/overview
- **Total Downloads**: 5.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/fenderglass/ABruijn
- **Stars**: N/A
### Original Help Text
```text
usage: abruijn [-h] [--debug] [--resume] [-t THREADS] [-i NUM_ITERS]
               [-p {pacbio,nano,pacbio_hi_err}] [-k KMER_SIZE]
               [-o MIN_OVERLAP] [-m MIN_KMER_COUNT] [-x MAX_KMER_COUNT]
               [--version]
               reads out_dir coverage integer

ABruijn: assembly of long and error-prone reads

positional arguments:
  reads                 path to reads file (FASTA format)
  out_dir               output directory
  coverage (integer)    estimated assembly coverage

optional arguments:
  -h, --help            show this help message and exit
  --debug               enable debug output
  --resume              try to resume previous assembly
  -t THREADS, --threads THREADS
                        number of parallel threads (default: 1)
  -i NUM_ITERS, --iterations NUM_ITERS
                        number of polishing iterations (default: 1)
  -p {pacbio,nano,pacbio_hi_err}, --platform {pacbio,nano,pacbio_hi_err}
                        sequencing platform (default: pacbio)
  -k KMER_SIZE, --kmer-size KMER_SIZE
                        kmer size (default: auto)
  -o MIN_OVERLAP, --min-overlap MIN_OVERLAP
                        minimum overlap between reads (default: 5000)
  -m MIN_KMER_COUNT, --min-coverage MIN_KMER_COUNT
                        minimum kmer coverage (default: auto)
  -x MAX_KMER_COUNT, --max-coverage MAX_KMER_COUNT
                        maximum kmer coverage (default: auto)
  --version             show program's version number and exit
```

