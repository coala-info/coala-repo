# shapeit5 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| shapeit5_ligate | PASS |  |
| shapeit5_phase_common | PASS |  |
| shapeit5_phase_rare | PASS |  |
| shapeit5_switch | PASS |  |

## shapeit5_phase_common

### Tool Description
Jointly phase multiple common markers (SHAPEIT5 phase_common).

### Metadata
- **Docker Image**: quay.io/biocontainers/shapeit5:5.1.1--h34261f4_2
- **Homepage**: https://odelaneau.github.io/shapeit5/
- **Package**: https://anaconda.org/channels/bioconda/packages/shapeit5/overview
- **Validation**: PASS

### Original Help Text
```text
[SHAPEIT5] phase_common (jointly phase multiple common markers)
  * Author        : Olivier DELANEAU, University of Lausanne
  * Contact       : olivier.delaneau@gmail.com
  * Version       : 5.1.1 / commit = 5.1.1 / release = 2025-02-19
  * Run date      : 22/10/2026 - 05:00:17

Basic options:
  --help                                Produce help message
  --seed arg (=15052011)                Seed of the random number generator
  -T [ --thread ] arg (=1)              Number of thread used
  --progress                            Verbose progress percentages on screen 
                                        for longer tasks

Input files:
  -I [ --input ] arg                    Genotypes to be phased in VCF/BCF 
                                        format
  -H [ --reference ] arg                Reference panel of haplotypes in 
                                        VCF/BCF format
  -S [ --scaffold ] arg                 Scaffold of haplotypes in VCF/BCF 
                                        format
  -M [ --map ] arg                      Genetic map
  --pedigree arg                        Pedigree information (kid father 
                                        mother)
  --haploids arg                        List of haploid samples (e.g. chrX for 
                                        males). One sample ID per line.
  -R [ --region ] arg                   Target region

MCMC parameters:
  --mcmc-iterations arg (=5b,1p,1b,1p,1b,1p,5m)
                                        Iteration scheme of the MCMC
  --mcmc-prune arg (=0.999)             Pruning threshold for genotype graphs
  --mcmc-noinit                         Disable phasing initialization by PBWT 
                                        sweep

PBWT parameters:
  --pbwt-modulo arg (=0.10000000000000001)
                                        Storage frequency of PBWT indexes in cM
                                        (i.e. storage every 0.1cM by default)
  --pbwt-depth arg (=4)                 Depth of PBWT indexes to condition on 
                                        (default 4)
  --pbwt-mac arg (=5)                   Minimal Minor Allele Count at which 
                                        PBWT is evaluated (default 5)
  --pbwt-mdr arg (=0.10000000000000001) Maximal Missing Data Rate at which PBWT
                                        is evaluated (default 10%)
  --pbwt-window arg (=4)                Run PBWT selection in windows of this 
                                        size (default 4cM)

HMM parameters:
  --hmm-window arg (=4)                 Minimal size of the phasing window in 
                                        cM (default 4cM)
  --hmm-ne arg (=15000)                 Effective size of the population 
                                        (default 15,000)

FILTER parameters:
  --filter-snp                          Only consider SNPs
  --filter-maf arg (=0)                 Only retains variants with a MAF above 
                                        the specified value, requires AC/AN 
                                        tags

Output files:
  -O [ --output ] arg                   Phased haplotypes output file
  --output-format arg (=bcf)            Output file format
  --log arg                             Log file
```

## shapeit5_phase_rare

### Tool Description
Phase rare variants onto a haplotype scaffold (SHAPEIT5 phase_rare).

### Metadata
- **Docker Image**: quay.io/biocontainers/shapeit5:5.1.1--h34261f4_2
- **Homepage**: https://odelaneau.github.io/shapeit5/
- **Package**: https://anaconda.org/channels/bioconda/packages/shapeit5/overview
- **Validation**: PASS

### Original Help Text
```text
[SHAPEIT5] Phase_rare (phase rare variants onto a haplotype scaffold)
  * Authors       : Simone RUBINACCI & Olivier DELANEAU, University of Lausanne
  * Contact       : simone.rubinacci@unil.ch & olivier.delaneau@gmail.com
  * Version       : 5.1.1 / commit = 5.1.1 / release = 2025-02-19
  * Run date      : 22/10/2026 - 05:00:20

Basic options:
  --help                                Produce help message
  --seed arg (=15052011)                Seed of the random number generator
  --thread arg (=1)                     Number of thread used
  --progress                            Verbose progress percentages on screen 
                                        for longer tasks

Input files:
  --input arg                           Genotypes to be phased
  --input-region arg                    Region to be considered in --input
  --scaffold arg                        Scaffold of haplotypes
  --scaffold-region arg                 Region to be considered in --scaffold
  --map arg                             Genetic map
  --pedigree arg                        Pedigree file (kid father mother
  --haploids arg                        List of haploid samples (e.g. chrX for 
                                        males). One sample ID per line.

PBWT parameters:
  --pbwt-modulo arg (=0.10000000000000001)
                                        Storage frequency of PBWT indexes in cM
  --pbwt-depth-common arg (=2)          Depth of PBWT indexes at common sites 
                                        to condition on
  --pbwt-depth-rare arg (=2)            Depth of PBWT indexes at rare hets to 
                                        condition on
  --pbwt-mac arg (=2)                   Minimal Minor Allele Count at which 
                                        PBWT is evaluated
  --pbwt-mdr arg (=0.10000000000000001) Maximal Missing Data Rate at which PBWT
                                        is evaluated

HMM parameters:
  --effective-size arg (=15000)         Effective size of the population

Output files:
  --output arg                          Phased haplotypes (at common AND rare 
                                        variants)
  --score-singletons                    Score singleton phasing between 0.5 and
                                        1.0 (experimental)
```

## shapeit5_switch

### Tool Description
Compute switch error rates and calibration of a phased dataset against a validation dataset (SHAPEIT5 switch).

### Metadata
- **Docker Image**: quay.io/biocontainers/shapeit5:5.1.1--h34261f4_2
- **Homepage**: https://odelaneau.github.io/shapeit5/
- **Package**: https://anaconda.org/channels/bioconda/packages/shapeit5/overview
- **Validation**: PASS

### Original Help Text
```text
Basic options:
  --help                    Produce help message
  -T [ --thread ] arg (=1)  Number of thread used

Input files:
  -V [ --validation ] arg   Validation dataset in VCF/BCF format
  -E [ --estimation ] arg   Phased dataset in VCF/BCF format
  -F [ --frequency ] arg    Variant frequency in VCF/BCF format
  -P [ --pedigree ] arg     Pedigree file in PED format
  -R [ --region ] arg       Target region
  --nbins arg (=20)         Number of bins used for calibration
  --min-pp arg (=0)         Minimal PP value for entering computations
  --singleton               Trick to phase singleton
  --dupid                   Duplicate ID for UKB matching IDs

Output files:
  -O [ --output ] arg       Prefix for all report files
  --log arg                 Log file
```

## Metadata
- **Skill**: generated

## shapeit5_ligate

### Tool Description
Ligate multiple phased chunks (VCF/BCF) into a single chromosome-length file.

### Metadata
- **Docker Image**: quay.io/biocontainers/shapeit5:5.1.1--h34261f4_2
- **Homepage**: https://odelaneau.github.io/shapeit5/
- **Package**: https://anaconda.org/channels/bioconda/packages/shapeit5/overview
- **Validation**: PASS
### Original Help Text
```text
[SHAPEIT5] Ligate (ligate multiple output files into chromosome-wide files)
  * Authors       : Simone RUBINACCI & Olivier DELANEAU, University of Lausanne
  * Contact       : simone.rubinacci@unil.ch & olivier.delaneau@gmail.com
  * Version       : 5.1.1 / commit = 5.1.1 / release = 2025-02-19
  * Run date      : 22/10/2026 - 04:56:08

Basic options:
  --help                  Produce help message
  --seed arg (=15052011)  Seed of the random number generator
  --thread arg (=1)       Number of threads

Input files:
  --input arg             Text file containing all VCF/BCF to ligate
  --pedigree arg          Pedigree file (kid father mother

Output files:
  -O [ --output ] arg     Output ligated file in VCF/BCF format
  --log arg               Log file
```

