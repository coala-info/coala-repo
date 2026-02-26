# beagle CWL Generation Report

## beagle

### Tool Description
BEAGLE 5.5 is a software package that performs genotype imputation and phasing.

### Metadata
- **Docker Image**: quay.io/biocontainers/beagle:5.5_27Feb25.75f--hdfd78af_0
- **Homepage**: https://github.com/yampelo/beagle
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/beagle/overview
- **Total Downloads**: 41.9K
- **Last updated**: 2025-09-18
- **GitHub**: https://github.com/yampelo/beagle
- **Stars**: N/A
### Original Help Text
```text
beagle.27Feb25.75f.jar (version 5.5)
Copyright (C) 2014-2024 Brian L. Browning
Usage: java -jar beagle.27Feb25.75f.jar [arguments]

data parameters ...
  gt=<VCF file with GT FORMAT field>                 (required)
  ref=<bref3 or VCF file with phased genotypes>      (optional)
  out=<output file prefix>                           (required)
  map=<PLINK map file with cM units>                 (optional)
  chrom=<[chrom] or [chrom]:[start]-[end]>           (optional)
  excludesamples=<file with 1 sample ID per line>    (optional)
  excludemarkers=<file with 1 marker ID per line>    (optional)

phasing parameters ...
  burnin=<max burnin iterations>                     (default=3)
  iterations=<phasing iterations>                    (default=12)
  phase-states=<model states for phasing>            (default=280)

imputation parameters ...
  impute=<impute ungenotyped markers (true/false)>   (default=true)
  imp-states=<model states for imputation>           (default=1600)
  cluster=<max cM in a marker cluster>               (default=0.005)
  ap=<print posterior allele probabilities>          (default=false)
  gp=<print posterior genotype probabilities>        (default=false)

general parameters ...
  ne=<effective population size>                     (default=100000)
  err=<allele mismatch probability>                  (default: data dependent)
  em=<estimate ne and err parameters (true/false)>   (default=true)
  window=<window length in cM>                       (default=40.0)
  window-markers=<maximum markers per window>        (default=4000000)
  overlap=<window overlap in cM>                     (default=2.0)
  seed=<random seed>                                 (default=-99999)
  nthreads=<number of threads>                       (default: machine dependent)
```

