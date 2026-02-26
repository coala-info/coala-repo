# referenceseeker CWL Generation Report

## referenceseeker

### Tool Description
Rapid determination of appropriate reference genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/referenceseeker:1.8.0--pyhdfd78af_0
- **Homepage**: https://github.com/oschwengers/referenceseeker
- **Package**: https://anaconda.org/channels/bioconda/packages/referenceseeker/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/referenceseeker/overview
- **Total Downloads**: 34.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/oschwengers/referenceseeker
- **Stars**: N/A
### Original Help Text
```text
usage: referenceseeker [--crg CRG] [--ani ANI] [--conserved-dna CONSERVED_DNA]
                       [--sliding-window [100-1000]] [--unfiltered]
                       [--bidirectional] [--help] [--version] [--verbose]
                       [--threads THREADS]
                       <database> <genome>

Rapid determination of appropriate reference genomes.

positional arguments:
  <database>            ReferenceSeeker database path
  <genome>              target draft genome in fasta format

Filter options / thresholds:
  These options control the filtering and alignment workflow.

  --crg CRG, -r CRG     Max number of candidate reference genomes to pass kmer
                        prefilter (default = 100)
  --ani ANI, -a ANI     ANI threshold (default = 0.95)
  --conserved-dna CONSERVED_DNA, -c CONSERVED_DNA
                        Conserved DNA threshold (default = 0.69)
  --sliding-window [100-1000], -w [100-1000]
                        Sliding window - the lower the more accurate but also
                        slower (default = 400)
  --unfiltered, -u      Set kmer prefilter to extremely conservative values
                        and skip species level ANI cutoffs (ANI >= 0.95 and
                        conserved DNA >= 0.69
  --bidirectional, -b   Compute bidirectional ANI/conserved DNA values
                        (default = False)

Runtime & auxiliary options:
  --help, -h            Show this help message and exit
  --version, -V         show program's version number and exit
  --verbose, -v         Print verbose information
  --threads THREADS, -t THREADS
                        Number of used threads (default = number of available
                        CPU cores)

Citation:
Schwengers et al., (2020)
ReferenceSeeker: rapid determination of appropriate reference genomes.
Journal of Open Source Software, 5(46), 1994, https://doi.org/10.21105/joss.01994

GitHub:
https://github.com/oschwengers/referenceseeker
```

