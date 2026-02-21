# any2fasta CWL Generation Report

## any2fasta

### Tool Description
Convert various sequence formats into FASTA

### Metadata
- **Docker Image**: quay.io/biocontainers/any2fasta:0.8.1--hdfd78af_0
- **Homepage**: https://github.com/tseemann/any2fasta
- **Package**: https://anaconda.org/channels/bioconda/packages/any2fasta/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/any2fasta/overview
- **Total Downloads**: 62.5K
- **Last updated**: 2025-12-30
- **GitHub**: https://github.com/tseemann/any2fasta
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
/usr/local/bin/any2fasta version 0.8.1 calling Getopt::Std::getopts (version 1.12 [paranoid]),
running under Perl version 5.32.1.

Usage: any2fasta [-OPTIONS [-MORE_OPTIONS]] [--] [PROGRAM_ARG1 ...]

The following single-character options are accepted:
	Boolean (without arguments): -v -h -q -n -l -u -k -g -s

Options may be merged together.  -- stops processing of options.
  [Now continuing due to backward compatibility and excessive paranoia.
   See 'perldoc Getopt::Std' about $Getopt::Std::STANDARD_HELP_VERSION.]
NAME
  any2fasta 0.8.1
SYNOPSIS
  Convert various sequence formats into FASTA
USAGE
  any2fasta [opts] file.{gb,fa,fq,gff,gfa,clw,sth}[.gz,bz2,zip,zstd] > output.fasta
OPTIONS
  -h       Print this help
  -v       Print version and exit
  -q       No output while running, only errors
  -k       Skip, don't die, on bad input files
  -n       Replace non-[AGTC] with 'N'
  -l       Lowercase the sequence
  -u       Uppercase the sequence
  -g       Include VERSION (GENBANK,EMBL)
  -s       Strip sequence descriptions (FASTA,FASTQ)
HOMEPAGE
  https://github.com/tseemann/any2fasta
END
```


## Metadata
- **Skill**: generated
