# referee CWL Generation Report

## referee_referee.py

### Tool Description
Reference genome quality score calculator.
       Pseudo assembly by iterative mapping.

### Metadata
- **Docker Image**: quay.io/biocontainers/referee:1.2--hdfd78af_0
- **Homepage**: https://github.com/gwct/referee
- **Package**: https://anaconda.org/channels/bioconda/packages/referee/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/referee/overview
- **Total Downloads**: 1.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/gwct/referee
- **Stars**: N/A
### Original Help Text
```text
#
# =================================================
                   __                    
         _ __ ___ / _| ___ _ __ ___  ___ 
        | '__/ _ \ |_ / _ \ '__/ _ \/ _ \
        | | |  __/  _|  __/ | |  __/  __/
        |_|  \___|_|  \___|_|  \___|\___|
    Reference genome quality score calculator.

       Pseudo assembly by iterative mapping.

usage: referee.py [-h] [-ref REF_FILE] [-gl GL_FILE] [-d OUTDIR]
                  [-prefix PREFIX] [--overwrite] [-p PROCESSES]
                  [-l LINES_PER_PROC] [--pileup] [--fastq] [--bed] [--haploid]
                  [--correct] [--mapped] [--mapq] [--raw] [--quiet]
                  [--version]

Referee: Reference genome quality scoring.

options:
  -h, --help         show this help message and exit
  -ref REF_FILE      The FASTA assembly to which you have mapped your reads.
  -gl GL_FILE        The file containing the genotype likelihood calculations
                     or a pileup file (be sure to set --pileup!).
  -d OUTDIR          An output directory for all files associated with this
                     run. Will be created if it doesn't exist. Default:
                     referee-[date]-[time]
  -prefix PREFIX     A prefix for all files associated with this run. Default:
                     referee-[date]-[time]
  --overwrite        Set this option to explicitly overwrite files within a
                     previous output directory.
  -p PROCESSES       The number of processes Referee should use. Default: 1.
  -l LINES_PER_PROC  The number of lines to be read per process. Decreasing
                     may reduce memory usage at the cost of slightly higher
                     run times. Default: 100000.
  --pileup           Set this option if your input file(s) are in pileup
                     format and Referee will calculate genotype likelihoods
                     for you.
  --fastq            Set this option to output in FASTQ format in addition to
                     the default tab delimited format.
  --bed              Set this option to output in BED format in addition to
                     the default tab delimited format. BED files can be viewed
                     as tracks in genome browsers.
  --haploid          Set this option if your input data are from a haploid
                     species. Referee will limit its likelihood calculations
                     to the four haploid genotypes. Can only be used with
                     --pileup.
  --correct          Set this option to allow Referee to suggest alternate
                     reference bases for sites that score 0.
  --mapped           Set this to calculate scores only for positions that have
                     reads mapped to them.
  --mapq             Set with --pileup to indicate whether to consider mapping
                     quality scores in the final score calculation. These
                     should be in the seventh column of the pileup file.
  --raw              Set this flag to output the raw score as the fourth
                     column in the tabbed output.
  --quiet            Set this flag to prevent Referee from reporting detailed
                     information about each step.
  --version          Simply print the version and exit. Can also be called as
                     '-version', '-v', or '--v'
```

