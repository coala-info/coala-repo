# finemap CWL Generation Report

## finemap_cond

### Tool Description
Welcome to FINEMAP v1.4.2

### Metadata
- **Docker Image**: quay.io/biocontainers/finemap:1.4.2--hb192632_1
- **Homepage**: http://www.christianbenner.com
- **Package**: https://anaconda.org/channels/bioconda/packages/finemap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/finemap/overview
- **Total Downloads**: 3.1K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
|--------------------------------------|
| Welcome to FINEMAP v1.4.2            |
|                                      |
| (c) 2015-2022 University of Helsinki |
|                                      |
| Help :                               |
| - ./finemap --help                   |
| - www.finemap.me                     |
| - www.christianbenner.com            |
|                                      |
| Contact :                            |
| - finemap@christianbenner.com        |
| - matti.pirinen@helsinki.fi          |
|--------------------------------------|

-----------------------
COMMAND-LINE PARAMETERS
-----------------------

--collinear-tol     Option to set the tolerance for collinearity in stepwise  Default is 0.95. With --cond
                    conditional search between already selected SNPs and the  
                    tested SNP                                                
--cond              Fine-mapping with stepwise conditional search             Subprogram
--cond-pvalue       Option to set the p-value threshold for declaring genome- Default is 5 x 10 ^ -8
                    wide significance                                         
--config            Evaluate a single causal configuration without perform-   Subprogram
                    ing shotgun stochastic search                             
--corr-config       Option to set the posterior probability of a causal con-  Default is 0.95
                    figuration to zero if it includes a pair of SNPs with     
                    absolute correlation above this threshold                 
--dataset           Option to specify a delimiter-separated list of datasets  All by default
                    for fine-mapping as given in the master file              
                    (e.g. 1,2 or 1|2)                                         
--flip-beta         Option to read a column 'flip' in the Z file with binary  With --cond, --config
                    indicators specifying if the direction of the estimated   and --sss
                    SNP effect sizes needs to be flipped                      
--force-n-samples   Option to allow correlations in a BCOR file to be com-    With --cond, --config
                    puted on a set of samples with different size than GWAS   and --sss
                    sample size                                                      
--in-files          Option to specify a semicolon separated master file with  With --cond, --config
                    the following column names: 'z', 'ld', 'snp', 'config',   and --sss
                    'n_samples' and optionally 'k' and 'log'. Each line is a  
                    dataset with file extensions corresponding with column    
                    names. The column 'n_samples' represents the GWAS sample  
                    size                                                      
--log               Option to write output to log files specified in column   No log files are written by  
                    'log' in the master file                                  default
--n-causal-snps     Option to set the maximum number of allowed causal SNPs   Default is 5
--n-configs-top     Option to set the number of top causal configurations     Default is 50000
                    to be saved                                               
--n-conv-sss        Option to set the number of iterations that the added     Default is 1000
                    probability mass is required to be below the specified    
                    threshold (--prob-conv-sss-tol) before shotgun stochastic 
                    search is terminated                                             
--n-iter            Option to set the maximum number of iterations before     Default is 100000
                    shotgun stochastic search is terminated                   
--n-threads         Option to specify the number of parallel threads          Default is 1
--prior-k           Option to use prior probabilities for the number of       SNPs are by default assumed  
                    causal SNPs from K files as specified in column 'k' in    to be causal with probability
                    the master file                                           1/(# of SNPs in the region)  
--prior-k0          Option to set the prior probability that there is no      Default is 0.0
                    causal SNP in the genomic region. Only used when com-     
                    puting posterior probabilities for the number of causal   
                    SNPs but not during fine-mapping itself                   
--prior-snps        Option to read a column 'prob' in the Z file with prior   
                    probabilities that a SNP is causal in order to define the 
                    prior probability for each causal configuration           
--prior-std         Option to specify a comma-separated list of prior stan-   Default is 0.05
                    dard deviations of effect sizes.                          
--prob-conv-sss-tol Option to set the tolerance at which the added probabil-  Default is 0.001
                    ity mass (over --n-conv-sss iterations) is considered     
                    small enough to terminate shotgun stochastic search       
--prob-cred-set     Option to set the probability at which the credible in-   Default is 0.95
                    terval includes a causal SNP                              
--pvalue-snps       Option to set a p-value threshold at which SNPs are in-   Default is 1.0
                    cluded                                                    
--rsids             Option to specify a comma-separated list of SNP identi-   Required with --config
                    fiers corresponding with the 'rsid' column in Z files as  
                    specified in column 'z' in the master file                
--sss               Fine-mapping with shotgun stochastic search               Subprogram
--std-effects       Option to print mean and standard deviation of the post-  Default is allele dosage
                    erior effect size distribution for standardized dosages   

--------------------
FINE-MAPPING EXAMPLE
--------------------
./finemap --sss  --in-files example/data
./finemap --cond --in-files example/data

----------------------------
CAUSAL CONFIGURATION EXAMPLE
----------------------------
./finemap --config --in-files example/data --rsids rs30,rs11
```


## finemap_config

### Tool Description
Welcome to FINEMAP v1.4.2

### Metadata
- **Docker Image**: quay.io/biocontainers/finemap:1.4.2--hb192632_1
- **Homepage**: http://www.christianbenner.com
- **Package**: https://anaconda.org/channels/bioconda/packages/finemap/overview
- **Validation**: PASS

### Original Help Text
```text
|--------------------------------------|
| Welcome to FINEMAP v1.4.2            |
|                                      |
| (c) 2015-2022 University of Helsinki |
|                                      |
| Help :                               |
| - ./finemap --help                   |
| - www.finemap.me                     |
| - www.christianbenner.com            |
|                                      |
| Contact :                            |
| - finemap@christianbenner.com        |
| - matti.pirinen@helsinki.fi          |
|--------------------------------------|

-----------------------
COMMAND-LINE PARAMETERS
-----------------------

--collinear-tol     Option to set the tolerance for collinearity in stepwise  Default is 0.95. With --cond
                    conditional search between already selected SNPs and the  
                    tested SNP                                                
--cond              Fine-mapping with stepwise conditional search             Subprogram
--cond-pvalue       Option to set the p-value threshold for declaring genome- Default is 5 x 10 ^ -8
                    wide significance                                         
--config            Evaluate a single causal configuration without perform-   Subprogram
                    ing shotgun stochastic search                             
--corr-config       Option to set the posterior probability of a causal con-  Default is 0.95
                    figuration to zero if it includes a pair of SNPs with     
                    absolute correlation above this threshold                 
--dataset           Option to specify a delimiter-separated list of datasets  All by default
                    for fine-mapping as given in the master file              
                    (e.g. 1,2 or 1|2)                                         
--flip-beta         Option to read a column 'flip' in the Z file with binary  With --cond, --config
                    indicators specifying if the direction of the estimated   and --sss
                    SNP effect sizes needs to be flipped                      
--force-n-samples   Option to allow correlations in a BCOR file to be com-    With --cond, --config
                    puted on a set of samples with different size than GWAS   and --sss
                    sample size                                                      
--in-files          Option to specify a semicolon separated master file with  With --cond, --config
                    the following column names: 'z', 'ld', 'snp', 'config',   and --sss
                    'n_samples' and optionally 'k' and 'log'. Each line is a  
                    dataset with file extensions corresponding with column    
                    names. The column 'n_samples' represents the GWAS sample  
                    size                                                      
--log               Option to write output to log files specified in column   No log files are written by  
                    'log' in the master file                                  default
--n-causal-snps     Option to set the maximum number of allowed causal SNPs   Default is 5
--n-configs-top     Option to set the number of top causal configurations     Default is 50000
                    to be saved                                               
--n-conv-sss        Option to set the number of iterations that the added     Default is 1000
                    probability mass is required to be below the specified    
                    threshold (--prob-conv-sss-tol) before shotgun stochastic 
                    search is terminated                                             
--n-iter            Option to set the maximum number of iterations before     Default is 100000
                    shotgun stochastic search is terminated                   
--n-threads         Option to specify the number of parallel threads          Default is 1
--prior-k           Option to use prior probabilities for the number of       SNPs are by default assumed  
                    causal SNPs from K files as specified in column 'k' in    to be causal with probability
                    the master file                                           1/(# of SNPs in the region)  
--prior-k0          Option to set the prior probability that there is no      Default is 0.0
                    causal SNP in the genomic region. Only used when com-     
                    puting posterior probabilities for the number of causal   
                    SNPs but not during fine-mapping itself                   
--prior-snps        Option to read a column 'prob' in the Z file with prior   
                    probabilities that a SNP is causal in order to define the 
                    prior probability for each causal configuration           
--prior-std         Option to specify a comma-separated list of prior stan-   Default is 0.05
                    dard deviations of effect sizes.                          
--prob-conv-sss-tol Option to set the tolerance at which the added probabil-  Default is 0.001
                    ity mass (over --n-conv-sss iterations) is considered     
                    small enough to terminate shotgun stochastic search       
--prob-cred-set     Option to set the probability at which the credible in-   Default is 0.95
                    terval includes a causal SNP                              
--pvalue-snps       Option to set a p-value threshold at which SNPs are in-   Default is 1.0
                    cluded                                                    
--rsids             Option to specify a comma-separated list of SNP identi-   Required with --config
                    fiers corresponding with the 'rsid' column in Z files as  
                    specified in column 'z' in the master file                
--sss               Fine-mapping with shotgun stochastic search               Subprogram
--std-effects       Option to print mean and standard deviation of the post-  Default is allele dosage
                    erior effect size distribution for standardized dosages   

--------------------
FINE-MAPPING EXAMPLE
--------------------
./finemap --sss  --in-files example/data
./finemap --cond --in-files example/data

----------------------------
CAUSAL CONFIGURATION EXAMPLE
----------------------------
./finemap --config --in-files example/data --rsids rs30,rs11
```


## Metadata
- **Skill**: generated
