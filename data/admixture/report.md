# admixture CWL Generation Report

## admixture

### Tool Description
ADMIXTURE is a software tool for maximum likelihood estimation of individual ancestries from multilocus SNP genotype datasets.

### Metadata
- **Docker Image**: quay.io/biocontainers/admixture:1.3.0--0
- **Homepage**: http://www.genetics.ucla.edu/software/admixture/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/admixture/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/admixture/overview
- **Total Downloads**: 22.9K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
****                   ADMIXTURE Version 1.3.0                  ****
****                    Copyright 2008-2015                     ****
****           David Alexander, Suyash Shringarpure,            ****
****                John  Novembre, Ken Lange                   ****
****                                                            ****
****                 Please cite our paper!                     ****
****   Information at www.genetics.ucla.edu/software/admixture  ****

                                                                              
  ADMIXTURE basic usage:  (see manual for complete reference)                 
    % admixture [options] inputFile K                                         
                                                                              
  where:                                                                      
    K is the number of populations; and                                       
    inputFile may be:                                                         
      - a PLINK .bed file                                                     
      - a PLINK "12" coded .ped file                                        
                                                                              
  Output will be in files inputBasename.K.Q, inputBasename.K.P                
                                                                              
  General options:                                                            
    -jX          : do computation on X threads                                
    --seed=X     : use random seed X for initialization                       
                                                                              
  Algorithm options:                                                          
     -m=                                                                      
    --method=[em|block]     : set method.  block is default                   
                                                                              
     -a=                                                                      
    --acceleration=none   |                                                   
                   sqs<X> |                                                   
                   qn<X>      : set acceleration                              
                                                                              
  Convergence criteria:                                                       
    -C=X : set major convergence criterion (for point estimation)             
    -c=x : set minor convergence criterion (for bootstrap and CV reestimates) 
                                                                              
  Bootstrap standard errors:                                                  
    -B[X]      : do bootstrapping [with X replicates]
```


## Metadata
- **Skill**: generated
