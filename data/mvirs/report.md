# mvirs CWL Generation Report

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


## mvirs_mvirs

### Tool Description
Localisation of inducible prophages using NGS data

### Metadata
- **Docker Image**: quay.io/biocontainers/mvirs:1.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/SushiLab/mVIRs
- **Package**: https://anaconda.org/channels/bioconda/packages/mvirs/overview
- **Validation**: PASS

### Original Help Text
```text
Unrecognized command
        
Program: mVIRs - Localisation of inducible prophages using NGS data
Version: 1.1.1
Reference: Zünd, Ruscheweyh, et al. 
High throughput sequencing provides exact genomic locations of inducible 
prophages and accurate phage-to-host ratios in gut microbial strains. 
Microbiome (2021). doi:10.1186/s40168-021-01033-w    

Usage: mvirs <command> [options]
Command:

    index   create index files for reference used in the 
            mvirs oprs routine
            
    oprs    align reads against reference and used clipped
            alignment positions and OPRs to extract potential
            prophages
            
    test    run mVIRs for a public dataset
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


## mvirs_alignment

### Tool Description
Localisation of inducible prophages using NGS data

### Metadata
- **Docker Image**: quay.io/biocontainers/mvirs:1.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/SushiLab/mVIRs
- **Package**: https://anaconda.org/channels/bioconda/packages/mvirs/overview
- **Validation**: PASS

### Original Help Text
```text
Unrecognized command
        
Program: mVIRs - Localisation of inducible prophages using NGS data
Version: 1.1.1
Reference: Zünd, Ruscheweyh, et al. 
High throughput sequencing provides exact genomic locations of inducible 
prophages and accurate phage-to-host ratios in gut microbial strains. 
Microbiome (2021). doi:10.1186/s40168-021-01033-w    

Usage: mvirs <command> [options]
Command:

    index   create index files for reference used in the 
            mvirs oprs routine
            
    oprs    align reads against reference and used clipped
            alignment positions and OPRs to extract potential
            prophages
            
    test    run mVIRs for a public dataset
```


## mvirs_prophages

### Tool Description
Localisation of inducible prophages using NGS data

### Metadata
- **Docker Image**: quay.io/biocontainers/mvirs:1.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/SushiLab/mVIRs
- **Package**: https://anaconda.org/channels/bioconda/packages/mvirs/overview
- **Validation**: PASS

### Original Help Text
```text
Unrecognized command
        
Program: mVIRs - Localisation of inducible prophages using NGS data
Version: 1.1.1
Reference: Zünd, Ruscheweyh, et al. 
High throughput sequencing provides exact genomic locations of inducible 
prophages and accurate phage-to-host ratios in gut microbial strains. 
Microbiome (2021). doi:10.1186/s40168-021-01033-w    

Usage: mvirs <command> [options]
Command:

    index   create index files for reference used in the 
            mvirs oprs routine
            
    oprs    align reads against reference and used clipped
            alignment positions and OPRs to extract potential
            prophages
            
    test    run mVIRs for a public dataset
```


## mvirs_test

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/mvirs:1.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/SushiLab/mVIRs
- **Package**: https://anaconda.org/channels/bioconda/packages/mvirs/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
2026-02-26 19:08:55,867 INFO: Starting mVIRs
Program: mVIRs - Localisation of inducible prophages using NGS data
Version: 1.1.1
Reference: Zünd, Ruscheweyh, et al. 
High throughput sequencing provides exact genomic locations of inducible 
prophages and accurate phage-to-host ratios in gut microbial strains. 
Microbiome (2021). doi:10.1186/s40168-021-01033-w    
Usage: mvirs test [options]

    Input:
        -o  PATH   Output folder [Required]
    
mvirs: error: the following arguments are required: -o
2026-02-26 19:08:55,868 INFO: Finishing mVIRs
```


## Metadata
- **Skill**: generated
