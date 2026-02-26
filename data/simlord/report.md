# simlord CWL Generation Report

## simlord

### Tool Description
SimLoRD is a read simulator for long reads from third generation sequencing and is currently focused on the Pacific Biosciences SMRT error model.

### Metadata
- **Docker Image**: quay.io/biocontainers/simlord:1.0.4--py39hbcbf7aa_5
- **Homepage**: https://bitbucket.org/genomeinformatics/simlord/
- **Package**: https://anaconda.org/channels/bioconda/packages/simlord/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/simlord/overview
- **Total Downloads**: 34.1K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: simlord [-h] [--version]
               (--read-reference PATH | --generate-reference GC LENGTH)
               [--save-reference PATH] [--num-reads INT | --coverage FLOAT]
               [--chi2-params-s PAR PAR PAR PAR PAR]
               [--chi2-params-n PAR PAR PAR] [--max-passes INT]
               [--sqrt-params PAR PAR] [--norm-params PAR PAR]
               [--probability-threshold FLOAT] [--prob-ins FLOAT]
               [--prob-del FLOAT] [--prob-sub FLOAT] [--min-readlength INT]
               [--lognorm-readlength [PARAMETER ...] | --fixed-readlength INT
               | --sample-readlength-from-fastq PATH [PATH ...] |
               --sample-readlength-from-text PATH] [--sam-output SAM_OUTPUT]
               [--no-sam] [--gzip] [--without-ns]
               [--uniform-chromosome-probability] [--old-read-names]
               OUTPUT_PREFIX

SimLoRD v1.0.4 -- SimLoRD is a read simulator for long reads from third
generation sequencing and is currently focused on the Pacific Biosciences SMRT
error model.

positional arguments:
  OUTPUT_PREFIX         Save the simulated reads as a fastq-file at
                        OUTPUT_PREFIX.fastq

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --read-reference PATH, -rr PATH
                        Read a reference from PATH to sample reads from
  --generate-reference GC LENGTH, -gr GC LENGTH
                        Generate a random reference with given GC-content and
                        given length
  --save-reference PATH, -sr PATH
                        Save the random reference as fasta-file at given PATH.
                        By default, save at output path with
                        '_reference.fasta' appended.
  --num-reads INT, -n INT
                        Number of reads to simulate (1000).
  --coverage FLOAT, -c FLOAT
                        Desired read coverage.
  --chi2-params-s PAR PAR PAR PAR PAR, -xs PAR PAR PAR PAR PAR
                        Parameters for the curve determining the parameter
                        scale for the chi^2 distribution: m,b, z, c, a for
                        'm*x + b' if x <= z and 'c * x^-a' if x > z (default=
                        (0.01214, -5.12, 675, 48303.0732881,
                        1.4691051212330266))
  --chi2-params-n PAR PAR PAR, -xn PAR PAR PAR
                        Parameters for the function determining the parameter
                        n for the chi^2 distribution: m, b, z for 'm*x + b' if
                        x < z and 'm*z + b' for x >=z (default=
                        (0.00189237136, 2.5394497, 5500)).
  --max-passes INT, -mp INT
                        Maximal number of passes for one molecule (default=
                        40).
  --sqrt-params PAR PAR, -sq PAR PAR
                        Parameters for the sqare root function for the quality
                        increase: a, b for 'sqrt(x+a) - b' (default= (0.5,
                        0.2247))
  --norm-params PAR PAR, -nd PAR PAR
                        Parameters for normal distributed noise added to
                        quality increase sqare root function (default= (0,
                        0.2))
  --probability-threshold FLOAT, -t FLOAT
                        Upper bound for the modified total error probability
                        (default= 0.2)
  --prob-ins FLOAT, -pi FLOAT
                        Probability for insertions for reads with one pass.
                        (default= 0.11)
  --prob-del FLOAT, -pd FLOAT
                        Probability for deletions for reads with one pass.
                        (default= 0.04)
  --prob-sub FLOAT, -ps FLOAT
                        Probability for substitutions for reads with one pass.
                        (default= 0.01)
  --min-readlength INT, -mr INT
                        Minium read length (default= 50) for lognormal
                        distribution
  --lognorm-readlength [PARAMETER ...], -ln [PARAMETER ...]
                        Parameters for lognormal read length distribution:
                        (sigma, loc, scale), empty for defaults
  --fixed-readlength INT, -fl INT
                        Fixed read length for all reads.
  --sample-readlength-from-fastq PATH [PATH ...], -sf PATH [PATH ...]
                        Sample read length from a fastq-file at PATH
                        containing reads.
  --sample-readlength-from-text PATH, -st PATH
                        Sample read length from a text file (one length per
                        line).
  --sam-output SAM_OUTPUT, -so SAM_OUTPUT
                        Save the alignments in a sam-file at SAM_OUTPUT. By
                        default, use OUTPUT_PREFIX.sam.
  --no-sam              Do not calculate the alignment and write a sam file.
  --gzip                Compress the simulated reads using gzip and save them
                        at OUTPUT_PREFIX.fastq.gz
  --without-ns          Skip regions containing Ns and sample reads only from
                        parts completly without Ns.
  --uniform-chromosome-probability
                        Sample chromosomes for reads equally distributed
                        instead of weighted by their length. (Was default
                        behaviour up to version 1.0.1)
  --old-read-names      Use old long read names where all information is
                        encoded in one large string. New format is according
                        to PacBio convention m\{\}/\{\}/CCS with read
                        information following after a whitespace.
```

