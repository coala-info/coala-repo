# breakdancer CWL Generation Report

## breakdancer_bam2cfg.pl

### Tool Description
Convert BAM files to configuration files for structural variant detection.

### Metadata
- **Docker Image**: quay.io/biocontainers/breakdancer:1.4.5--pl5321h264e753_11
- **Homepage**: https://github.com/genome/breakdancer
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/breakdancer/overview
- **Total Downloads**: 11.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/genome/breakdancer
- **Stars**: N/A
### Original Help Text
```text
/usr/local/bin/bam2cfg.pl version [unknown] calling Getopt::Std::getopts (version 1.12 [paranoid]),
running under Perl version 5.32.1.

Usage: bam2cfg.pl [-OPTIONS [-MORE_OPTIONS]] [--] [PROGRAM_ARG1 ...]

The following single-character options are accepted:
	With arguments: -q -n -c -b -p -s -f -v
	Boolean (without arguments): -h -m -g -C

Options may be merged together.  -- stops processing of options.
Space is not required between options and their arguments.
  [Now continuing due to backward compatibility and excessive paranoia.
   See 'perldoc Getopt::Std' about $Getopt::Std::STANDARD_HELP_VERSION.]

Usage:   bam2cfg.pl <bam files>
Options:
         -q INT    Minimum mapping quality [35]
         -m        Using mapping quality instead of alternative mapping quality
         -s        Minimal mean insert size [50]
         -C        Change default system from Illumina to SOLiD
         -c FLOAT  Cutoff in unit of standard deviation [4]
         -n INT    Number of observation required to estimate mean and s.d. insert size [10000]
         -v FLOAT  Cutoff on coefficients of variation [1]
         -f STRING A two column tab-delimited text file (RG, LIB) specify the RG=>LIB mapping, useful when BAM header is incomplete
	 -b INT	   Number of bins in the histogram [50] 
         -g        Output mapping flag distribution
         -h        Plot insert size histogram for each BAM library
```

