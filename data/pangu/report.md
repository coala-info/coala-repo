# pangu CWL Generation Report

## pangu

### Tool Description
Call CYP2D6 star alleles from HiFi WGS data

### Metadata
- **Docker Image**: quay.io/biocontainers/pangu:0.2.8--pyhdfd78af_0
- **Homepage**: https://github.com/PacificBiosciences/pangu
- **Package**: https://anaconda.org/channels/bioconda/packages/pangu/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pangu/overview
- **Total Downloads**: 9.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PacificBiosciences/pangu
- **Stars**: N/A
### Original Help Text
```text
usage: pangu [-h] [-V] [--vcf VCF] [--bamFofn BAMFOFN] [--vcfFofn VCFFOFN]
             [--config CONFIG_YAML] [-p PREFIX]
             [-m {wgs,amplicon,capture,consensus}] [-s SEED] [-x] [-g] [-v]
             [--logFile LOGFILE]
             [--logLevel {CRITICAL,ERROR,WARNING,INFO,DEBUG,NOTSET}]
             [inBam ...]

Call CYP2D6 star alleles from HiFi WGS data

positional arguments:
  inBam                 Aligned BAM file(s) of HiFi WGS reads

options:
  -h, --help            show this help message and exit
  -V, --version         show program's version number and exit

Input Options:
  --vcf VCF             Vcf file name for single bam input. Default None
  --bamFofn BAMFOFN     Text file of bam file names. Default None
  --vcfFofn VCFFOFN     Text file of vcf file names in same order as bamFofn.
                        Default None
  --config CONFIG_YAML  Override installed configuration yaml file
  -p PREFIX, --prefix PREFIX
                        Prefix for output files. Default cwd
  -m {wgs,amplicon,capture,consensus}, --mode {wgs,amplicon,capture,consensus}
                        Calling mode by HiFi input type. Default wgs
  -s SEED, --seed SEED  Seed for random generator. Default 42

Output Options:
  -x, --exportLabeledReads
                        Write labeled reads to output prefix
  -g, --grayscale       Use grayscale to annotate haplotypes in export bam.
                        Default use color
  -v, --verbose         Print logging info to stdout
  --logFile LOGFILE     Log file. Default {prefix}[_/]caller.log
  --logLevel {CRITICAL,ERROR,WARNING,INFO,DEBUG,NOTSET}
                        Logging level. Default INFO
```


## Metadata
- **Skill**: generated
