# mvirs CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mvirs_index | PASS | Builds the bwa index for the Salmonella LT2 genome (NCBI NC_003197/NC_003277). |
| mvirs_oprs | PASS | 200k read pairs of ERR4552622 (the tool's own test run) against LT2 give one 43 kb prophage region with OPR and clipped-read support. |

## mvirs_index

### Tool Description
Localisation of inducible prophages using NGS data

### Metadata
- **Docker Image**: quay.io/biocontainers/mvirs:1.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/SushiLab/mVIRs
- **Package**: https://anaconda.org/channels/bioconda/packages/mvirs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mvirs/overview
- **Total Downloads**: 2.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/SushiLab/mVIRs
- **Stars**: N/A
### Original Help Text
```text
2026-02-26 19:07:14,235 INFO: Starting mVIRs
Program: mVIRs - Localisation of inducible prophages using NGS data
Version: 1.1.1
Reference: Zünd, Ruscheweyh, et al. 
High throughput sequencing provides exact genomic locations of inducible 
prophages and accurate phage-to-host ratios in gut microbial strains. 
Microbiome (2021). doi:10.1186/s40168-021-01033-w    

Usage: mvirs index [options]

    Input:
        -f  FILE   Reference FASTA file. Can be gzipped. [Required]
    
mvirs: error: the following arguments are required: -f
2026-02-26 19:07:14,236 INFO: Finishing mVIRs
```

## mvirs_oprs

### Tool Description
Localisation of inducible prophages using NGS data

### Metadata
- **Docker Image**: quay.io/biocontainers/mvirs:1.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/SushiLab/mVIRs
- **Package**: https://anaconda.org/channels/bioconda/packages/mvirs/overview
- **Validation**: PASS

### Original Help Text
```text
2026-02-26 19:07:53,342 INFO: Starting mVIRs
Program: mVIRs - Localisation of inducible prophages using NGS data
Version: 1.1.1
Reference: Zünd, Ruscheweyh, et al. 
High throughput sequencing provides exact genomic locations of inducible 
prophages and accurate phage-to-host ratios in gut microbial strains. 
Microbiome (2021). doi:10.1186/s40168-021-01033-w    

Usage: mvirs oprs [options]

    Input:
        -f  FILE   Forward reads file. FastA/Q. Can be gzipped. [Required]
        -r  FILE   Reverse reads file. FastA/Q. Can be gzipped. [Required]
        -db FILE   Reference database file (prefix) created by mvirs index. [Required]
    
    Output:
        -o  PATH   Prefix for output file. [Required]
    
    Options:
        -t  INT    Number of threads. [1]
        -ml INT    Minimum sequence length for extraction.. [4000]
        -ML INT    Maximum sequence length for extraction.. [800000]
        -m         Allow full contigs/scaffolds/chromosomes to be reported 
                   (When OPRs and clipped reads are found at the start and 
                   end of contigs/scaffolds/
    
mvirs: error: the following arguments are required: -f, -r, -db, -o
2026-02-26 19:07:53,344 INFO: Finishing mVIRs
```

## Metadata
- **Skill**: generated
