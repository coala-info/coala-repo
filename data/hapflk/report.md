# hapflk CWL Generation Report

## hapflk

### Tool Description
hapflk

### Metadata
- **Docker Image**: quay.io/biocontainers/hapflk:1.3.0--py27_0
- **Homepage**: https://github.com/BertrandServin/hapflk
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hapflk/overview
- **Total Downloads**: 7.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/BertrandServin/hapflk
- **Stars**: N/A
### Original Help Text
```text
usage: hapflk [-h] [--ped FILE] [--map FILE] [--file PREFIX] [--bfile PREFIX]
              [--miss_geno C] [--miss_pheno C] [--miss_parent C]
              [--miss_sex C] [--chr C] [--from x] [--to x] [--other_map]
              [-p PREFIX] [--ncpu N] [--eigen] [--kinship FILE]
              [--reynolds-snps L] [--outgroup POP] [--keep-outgroup] [-K K]
              [--nfit NFIT] [--phased] [--no-kfrq]

optional arguments:
  -h, --help            show this help message and exit
  -p PREFIX, --prefix PREFIX
                        prefix for output files (default: hapflk)
  --ncpu N              Use N processors when possible (default: 1)
  --eigen               Perform eigen decomposition of tests (default: False)

Input Files:
  Available formats

  --ped FILE            PED file (default: None)
  --map FILE            MAP file (default: None)
  --file PREFIX         PLINK file prefix (ped,map) (default: None)
  --bfile PREFIX        PLINK bfile prefix (bim,fam,bed) (default: None)

Data format options:

  --miss_geno C         Missing Genotype Code (default: 0)
  --miss_pheno C        Missing Phenotype Code (default: -9)
  --miss_parent C       Missing Parent Code (default: 0)
  --miss_sex C          Missing Sex Code (default: 0)

SNP selection:
  Filter SNP by genome position

  --chr C               Select chromosome C (default: None)
  --from x              Select SNPs with position > x (in bp/cM) Warning :
                        does not work with BED files (default: 0)
  --to x                Select SNPs with position < x (in bp/cM) Warning :
                        does not work with BED files (default: inf)
  --other_map           Use alternative map (genetic/RH) (default: False)

Population kinship :
  Set parameters for getting the population kinship matrix

  --kinship FILE        Read population kinship from file (if None, kinship is
                        estimated) (default: None)
  --reynolds-snps L     Number of SNPs to use to estimate Reynolds distances
                        (default: 10000)
  --outgroup POP        Use population POP as outgroup for tree rooting (if
                        None, use midpoint rooting) (default: None)
  --keep-outgroup       Keep outgroup in population set (default: False)

hapFLK and LD model:
  Switch on hapFLK calculations and set parameters of the LD model

  -K K                  Set the number of clusters to K. hapFLK calculations
                        switched off if K<0 (default: -1)
  --nfit NFIT           Set the number of model fit to use (default: 20)
  --phased, --inbred    Haplotype data provided (default: False)
  --no-kfrq             Do not write Cluster frequencies (default: False)
```

