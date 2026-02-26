# bacgwasim CWL Generation Report

## bacgwasim_BacGWASim

### Tool Description
Description

### Metadata
- **Docker Image**: quay.io/biocontainers/bacgwasim:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/Morteza-M-Saber/BacGWASim
- **Package**: https://anaconda.org/channels/bioconda/packages/bacgwasim/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bacgwasim/overview
- **Total Downloads**: 6.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Morteza-M-Saber/BacGWASim
- **Stars**: N/A
### Original Help Text
```text
usage: BacGWASim [-h] [--version] [--config FILE] [--output-dir DIR]
                 [--num-species INT] [--genome-length INT]
                 [--mutation-rate]0-1 [--recomb-rate]0-1 [--maf]0-1 [--num-var INT]
                 [--random-seed INT] [--phen-type {cc,quant}]
                 [--num-causal-var INT]
                 [--causal-maf-min]0-1 [--causal-maf-max]0-1 [--causal-ld-max [0-1]]
                 [--effect-size-odr LIST] [--phen-replication INT]
                 [--heritability [0-1]]
                 [--disease-prevalence]0-1 [--case CASE] [--control CONTROL]
                 [--simvis-dpi SIMVIS_DPI] [--plot-ld BOOL] [--snp-limit INT]
                 [--ld-maf]0-1 [--cores INT] [--latency-wait INT]

Description

optional arguments:
  -h, --help                  show this help message and exit
  --version                   show program's version number and exit
  --config FILE               Path to a config file
  --output-dir DIR            Path to the output directory

Genome simulation parameters:
  --num-species INT           Number of samples in the simulated population
  --genome-length INT         Length of the genome (bp)
  --mutation-rate ]0-1[       Mutation rate
  --recomb-rate ]0-1[         Recombination rate
  --maf ]0-1[                 Minor allele frequency threshold of rare alleles
                              to be discarded
  --num-var INT               Number of simulated variants. If '-1', variant
                              number will be solely a function of mutation
                              rate
  --random-seed INT           Random seed for reproducibility of results

Phenotype simulation parameters:
  --phen-type {cc,quant}      Type of simulated phenotype. 'cc':binary case-
                              control, 'quant': quantitative
  --num-causal-var INT        Number of causal markers
  --causal-maf-min ]0-1[      Minimum Minor Allele Frequency (MAF) of causal
                              markers
  --causal-maf-max ]0-1[      Maximum Minor Allele Frequency (MAF) of causal
                              markers
  --causal-ld-max [0-1]       Maximum permitted R2 score between pairs of
                              causal markers in window size of 1000 candidate
                              causal markers meeting --causal-maf-min and
                              --causal-maf-max thresholds
  --effect-size-odr LIST      Effect sizes of causal markers (.odds ratios)
                              (comma separated, must be a multiple of --num-
                              causal-var)
  --phen-replication INT      Number of phenotype replication sets
  --heritability [0-1]        Heritability of phenotype
  --disease-prevalence ]0-1[  Prevalence of phenotype
  --case CASE                 In case of case-control binary phenotype
                              simulation, number of case and control samples
                              must be defined by 'case' and 'control'
                              parameters
  --control CONTROL           In case of case-control binary phenotype
                              simulation, number of case and control samples
                              must be defined by 'case' and 'control'
                              parameters
  --simvis-dpi SIMVIS_DPI     Set the DPI for the simVis plot

Linkage Disequilibrium plotting:
  --plot-ld BOOL              Generate the LD plot
  --snp-limit INT             Number of SNPs randomly selected for plotting
                              linkage map (Increasing this number will
                              significantly increase computation time)
  --ld-maf ]0-1[              Minimum Minor Allele Frequency of markers for LD
                              plotting (Lower this values, it is more
                              difficult to estimate accurate r2 values between
                              pairs of markers leading to more noisy plot)

Runtime parameters:
  --cores INT                 Number of cores available for computations
  --latency-wait INT          Time to wait (in sec) after a job to ensure that
                              all files are present
```

