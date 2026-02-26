# sv2 CWL Generation Report

## sv2

### Tool Description
Support Vector Structural Variation Genotyper

### Metadata
- **Docker Image**: quay.io/biocontainers/sv2:1.4.3.4--py27h3010b51_2
- **Homepage**: https://github.com/dantaki/SV2
- **Package**: https://anaconda.org/channels/bioconda/packages/sv2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sv2/overview
- **Total Downloads**: 8.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dantaki/SV2
- **Stars**: N/A
### Original Help Text
```text
usage:                 ____
  _____________   ___ |___ \
 /   _____/\   \ /   // ___/
 \_____  \  \   Y   //_____)
 /        \  \     /
/_________/   \___/

Support Vector Structural Variation Genotyper
Version 1.4.3.4    Author: Danny Antaki <dantaki at ucsd dot edu>    github.com/dantaki/SV2

  sv2 -i <bam ...> -v <vcf ...> -b <bed ...> -snv <snv vcf ...> -p <ped ...> [OPTIONS]

input arguments: github.com/dantaki/SV2/wiki/Options#input-arguments

  Note: input arguments can take multiple files, separated by space <-i BAM1 BAM2 ...>

  -i, -bam    ...     bam file(s)
  -v, -vcf    ...     vcf files(s) of SVs
  -b, -bed    ...     bed files(s) of SVs
  -snv        ...     snv vcf files(s), must be bgzipped and tabixed
  -p, -ped    ...     ped files(s)

genotype arguments: github.com/dantaki/SV2/wiki/Options#genotype-arguments

  -g, -genome         reference genome build <hg19, hg38, mm10> [default: hg19]
  -pcrfree            GC content normalization for pcr free sequences
  -M                  bwa mem -M compatibility, split-reads flagged as secondary instead of supplementary
  -merge              merge overlapping SV breakpoints after genotyping
  -min-ovr            minimum reciprocal overlap for merging [default: 0.8]
  -no-anno            genotype without annotating variants   

  -pre                preprocessing output directory, skips preprocessing
  -feats              feature extraction output directory, skips feature extraction

classifier arguments: github.com/dantaki/SV2/wiki/Options#classifier-arguments

  -load-clf           add custom classifiers (-load-clf <clf.json>)
  -clf                define classifier for genotyping [default:default]

config arguments: github.com/dantaki/SV2/wiki/Options#config-arguments

  -download           download required data files
  -hg19               hg19 fasta file
  -hg38               hg38 fasta file
  -mm10               mm10 fasta file
  -ini                configuration INI file [default: $SV2_INSTALL_PATH/config/sv2.ini]
  
optional arguments:
 
  -L, -log            log file for standard error messages [default: STDOUT]
  -T, -tmp-dir        directory for temporary files [default: working directory]
  -s, -seed           random seed for preprocessing shuffling [default: 42]
  -o, -out            output prefix [default: sv2_genotypes]
  -O, -odir           output path, location for sv2 output directories [default: working directory]

  -h, -help           show this message and exit
sv2: error: unrecognized arguments: --help
```

