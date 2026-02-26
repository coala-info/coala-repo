# bio-eagle CWL Generation Report

## bio-eagle

### Tool Description
Eagle v2.4.1

### Metadata
- **Docker Image**: biocontainers/bio-eagle:v2.4.1-1-deb_cv1
- **Homepage**: https://github.com/ialbert/bio
- **Package**: https://anaconda.org/channels/bioconda/packages/bio/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bio-eagle/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/ialbert/bio
- **Stars**: N/A
### Original Help Text
```text
+-----------------------------+
                      |                             |
                      |   Eagle v2.4.1              |
                      |   November 18, 2018         |
                      |   Po-Ru Loh                 |
                      |                             |
                      +-----------------------------+

Copyright (C) 2015-2018 Harvard University.
Distributed under the GNU GPLv3+ open source license.

Command line options:

bio-eagle \
    --help 


Options:

  --geneticMapFile arg             HapMap genetic map provided with download: 
                                   tables/genetic_map_hg##.txt.gz
  --outPrefix arg                  prefix for output files
  --numThreads arg (=1)            number of computational threads

Input options for phasing without a reference:
  --bfile arg                      prefix of PLINK .fam, .bim, .bed files
  --bfilegz arg                    prefix of PLINK .fam.gz, .bim.gz, .bed.gz 
                                   files
  --fam arg                        PLINK .fam file (note: file names ending in 
                                   .gz are auto-decompressed)
  --bim arg                        PLINK .bim file
  --bed arg                        PLINK .bed file
  --vcf arg                        [compressed] VCF/BCF file containing input 
                                   genotypes
  --remove arg                     file(s) listing individuals to ignore (no 
                                   header; FID IID must be first two columns)
  --exclude arg                    file(s) listing SNPs to ignore (no header; 
                                   SNP ID must be first column)
  --maxMissingPerSnp arg (=0.1)    QC filter: max missing rate per SNP
  --maxMissingPerIndiv arg (=0.1)  QC filter: max missing rate per person

Input/output options for phasing using a reference panel:
  --vcfRef arg                     tabix-indexed [compressed] VCF/BCF file for 
                                   reference haplotypes
  --vcfTarget arg                  tabix-indexed [compressed] VCF/BCF file for 
                                   target genotypes
  --vcfOutFormat arg (=.)          b|u|z|v: compressed BCF (b), uncomp BCF (u),
                                   compressed VCF (z), uncomp VCF (v)
  --noImpMissing                   disable imputation of missing target 
                                   genotypes (. or ./.)
  --allowRefAltSwap                allow swapping of REF/ALT in target vs. ref 
                                   VCF
  --outputUnphased                 output unphased sites (target-only, 
                                   multi-allelic, etc.)
  --keepMissingPloidyX             assume missing genotypes have correct ploidy
                                   (.=haploid, ./.=diploid)
  --vcfExclude arg                 tabix-indexed [compressed] VCF/BCF file 
                                   containing variants to exclude from phasing

Region selection options:
  --chrom arg (=0)                 chromosome to analyze (if input has many)
  --bpStart arg (=0)               minimum base pair position to analyze
  --bpEnd arg (=1e9)               maximum base pair position to analyze
  --bpFlanking arg (=0)            (ref-mode only) flanking region to use 
                                   during phasing but discard in output

Algorithm options:
  --Kpbwt arg (=10000)             number of conditioning haplotypes
  --pbwtIters arg (=0)             number of PBWT phasing iterations (0=auto)
  --expectIBDcM arg (=2.0)         expected length of haplotype copying (cM)
  --histFactor arg (=0)            history length multiplier (0=auto)
  --genoErrProb arg (=0.003)       estimated genotype error probability
  --pbwtOnly                       in non-ref mode, use only PBWT iters 
                                   (automatic for sequence data)
  --v1                             use Eagle1 phasing algorithm (instead of 
                                   default Eagle2 algorithm)
```

