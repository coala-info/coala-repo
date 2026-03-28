# binsanity CWL Generation Report

## binsanity_Binsanity-profile

### Tool Description
Binsanity-profile is used to generate coverage files for input to BinSanity. This uses Featurecounts to generate a a coverage profile and transforms data for input into Binsanity, Binsanity-refine, and Binsanity-wf

### Metadata
- **Docker Image**: quay.io/biocontainers/binsanity:0.5.4--pyh5e36f6f_0
- **Homepage**: https://github.com/edgraham/BinSanity
- **Package**: https://anaconda.org/channels/bioconda/packages/binsanity/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/binsanity/overview
- **Total Downloads**: 57.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/edgraham/BinSanity
- **Stars**: N/A
### Original Help Text
```text
usage: Binsanity-profile -i fasta_file -s {sam,bam}_file --id contig_ids.txt -c output_file

    ***********************************************************************
    ******************************BinSanity********************************
    **                                                                   **
    **  Binsanity-profile is used to generate coverage files for         **
    **  input to BinSanity. This uses Featurecounts to generate a        **
    **  a coverage profile and transforms data for input into Binsanity, **
    **  Binsanity-refine, and Binsanity-wf                               **
    **                                                                   **
    ***********************************************************************
    ***********************************************************************

optional arguments:
  -h, --help            show this help message and exit
  -i INPUTFASTA         Specify fasta file being profiled
  -s INPUTMAPLOC        
                            identify location of BAM files
                            BAM files should be indexed and sorted
  -c OUTCOV             
                            Identify name of output file for coverage information
  --transform TRANSFORM
                        
                            Indicate what type of data transformation you want in the final file [Default:log]:
                            scale --> Scaled by multiplying by 100 and log transforming
                            log --> Log transform
                            None --> Raw Coverage Values
                            X5 --> Multiplication by 5
                            X10 --> Multiplication by 10
                            X100 --> Multiplication by 100
                            SQR --> Square root
                            We recommend using a scaled log transformation for initial testing.
                            Other transformations can be useful on a case by case basis
  -T THREADS            Specify Number of Threads For Feature Counts [Default: 1]
  -o OUTDIRECTORY       Specify directory for output files to be deposited [Default: Working Directory]
  --version             show program's version number and exit
```


## binsanity_Binsanity-wf

### Tool Description
Binsanity-wf is a workflow script that runs Binsanity and Binsanity-refine sequentially.

### Metadata
- **Docker Image**: quay.io/biocontainers/binsanity:0.5.4--pyh5e36f6f_0
- **Homepage**: https://github.com/edgraham/BinSanity
- **Package**: https://anaconda.org/channels/bioconda/packages/binsanity/overview
- **Validation**: PASS

### Original Help Text
```text
usage: Binsanity-wf -f [/path/to/fasta] -l [FastaFile] -c [CoverageFile] -o [OutputDirectory]

    ************************************************************************************************
    **************************************BinSanity*************************************************
    **  Binsanity-wf is a workflow script that runs Binsanity and Binsanity-refine sequentially.  **
    **  The following is including in the workflow:                                               **
    **  STEP 1. Run Binsanity                                                                     **
    **  STEP 2: Run CheckM to estimate completeness for Refinement                                **
    **  STEP 3: Run Binsanity-refine                                                              **
    **  STEP 4: Create Final BinSanity Clusters                                                   **
    **                                                                                            **
    ************************************************************************************************
    

optional arguments:
  -h, --help            show this help message and exit
  -c INPUTCOVFILE       
                            Specify a Transformed Coverage File
                            e.g Log transformed
                            
  -f FastaLocation      Specify directory containing your contigs
  -p PREFERENCE         Specify a preference [Default: -3]
                            Note: decreasing the preference leads to more lumping,
                            increasing will lead to more splitting. If your range
                            of coverages are low you will want to decrease the
                            preference, if you have 10 or less replicates increasing
                            the preference could benefit you.
  -m MAXITER            
                            Specify a max number of iterations [Default: 4000]
  -v ConvergenceIteration
                        Specify the convergence iteration number [Default: 400]
                            e.g Number of iterations with no change in the number
                            of estimated clusters that stops the convergence.
  -d DampeningFactor    Specify a damping factor between 0.5 and 1, [Default: 0.95]
  -l FastaFile          Specify the fasta file containing contigs you want to cluster
  -x SizeThreshold      Specify the contig size cut-off [Default: 1000 bp]
  -o OutputDirectory    Give a name to the directory BinSanity results will be output in
                            [Default: 'BINSANITY-RESULTS']
  --threads THREADS     Indicate how many threads you want dedicated to the subprocess CheckM. [Default=1]
  --kmer KMER           Indicate a number for the kmer calculation, the [Default: 4]
  --Prefix PREFIX       Specify a prefix to append to the start of all files generated during Binsanity
  --refine-preference INPUTREFINEDPREF
                        Specify a preference for refinement. [Default: -25]
  --binPrefix BinPrefix
                        Sepcify what prefix you want appended to final Bins {optional}
  --version             show program's version number and exit
```


## binsanity_Binsanity-lc

### Tool Description
Binsanity-lc is a workflow script that will subset assemblies larger than 100,000 contigs using coverage prior to running Binsanity and Binsanity-refine sequentially.

### Metadata
- **Docker Image**: quay.io/biocontainers/binsanity:0.5.4--pyh5e36f6f_0
- **Homepage**: https://github.com/edgraham/BinSanity
- **Package**: https://anaconda.org/channels/bioconda/packages/binsanity/overview
- **Validation**: PASS

### Original Help Text
```text
usage: Binsanity-lc -f [/path/to/fasta] -l [fastafile] -c [coverage file] -o [output directory]

    ************************************************************************************************
    **************************************BinSanity*************************************************
    **    Binsanity-lc is a workflow script that will subset assemblies larger than 100,000       ** 
    **    contigs using coverage prior to running Binsanity and Binsanity-refine sequentially.    **
    **    The following is including in the workflow:                                             **
    **       Step 1: Use Coverage to Subsample contigs with K-mean Clustering                     **
    **       STEP 2: Run Binsanity                                                                **
    **       STEP 3: Run CheckM to estimate completeness for Refinement                           **
    **       STEP 4: Run Binsanity-refine                                                         **
    **       STEP 5: Creat Final BinSanity Clusters                                               **
    **                                                                                            **
    ************************************************************************************************
    

optional arguments:
  -h, --help            show this help message and exit
  -c CoverageFile       Specify a Coverage File
                            
  -f FastaLocation      Specify directory containing Fasta File to be clustered
                            
  -p Preference         Specify a preference [Default: -3]
                            Note: decreasing the preference leads to more lumping, 
                            increasing will lead to more splitting. If your range
                            of coverages are low you will want to decrease the
                            preference, if you have 10 or less replicates increasing
                            the preference could benefit you.
                            
  -m MaximumIterations  Specify a max number of iterations [Default: 4000]
                            
  -v ConvergenceIterations
                        Specify the convergence iteration number [Default:400]
                            e.g Number of iterations with no change in the number 
                            of estimated clusters that stops the convergence.
                            
  -d DampeningFactor    Specify a damping factor between 0.5 and 1 [Default: 0.95]
                            
  -l FastaFile Name     Specify the fasta file containing contigs you want to cluster
                            
  -x SizeCutOff         Specify the contig size cut-off [Default:1000 bp]
                            
  -o Output Directory   Give a name to the directory BinSanity results will be output in 
                            [Default:'BINSANITY-RESULTS']
                            
  --checkm_threads Threads
                        Indicate how many threads you want dedicated to the subprocess CheckM [Default: 1]
                            
  --kmer Kmer           Indicate a number for the kmer calculation [Default: 4]
                            
  --refine-preference   Specify a preference for refinement [Default: -25]
                            
  -C ClusterNumber      Indicate a number of initial clusters for kmean [Default:100]
                            
  --Prefix Prefix       Specify a prefix to append to the start of all directories generated during Binsanity
                            
  --version             show program's version number and exit
```


## binsanity_Binsanity2-beta

### Tool Description
Binsanity2 is a workflow script that will subset assemblies using kmeans and subsequently binning the resultant clusters of contigs using coverage and affinity propagation (AP) followed by a compositional based refinement.

### Metadata
- **Docker Image**: quay.io/biocontainers/binsanity:0.5.4--pyh5e36f6f_0
- **Homepage**: https://github.com/edgraham/BinSanity
- **Package**: https://anaconda.org/channels/bioconda/packages/binsanity/overview
- **Validation**: PASS

### Original Help Text
```text
usage: Binsanity-lc -f [/path/to/fasta] -l [fastafile] -c [coverage file] -o [output directory]

    ************************************************************************************************
    **************************************BinSanity2************************************************
    **    Binsanity2 is a workflow script that will subset assemblies using kmeans                ** 
    **    and subsequently binning the resultant clusters of contigs using coverage and affinity  **
    **    propagation (AP) followed by a compositional based refinement.                           **
    **                                                                                            **
    **    Binsanity2 is designed to replace both BinsanityWF and BinsanityLC. It is a currently   **
    **    in *active developlment* and the current release is a BETA version. Despite being a     **
    **    BETA version the script itself is fully functional and has been sanity checked to       **
    **    ensure results are of a high quality. An official release with new example data and     **
    **    a new snakemake workflow is anticipated in summer 2021.                                 **
    **                                                                                            **
    **    The following is including in the workflow:                                             **
    **       STEP 1: Use Coverage to Subsample contigs with K-mean Clustering (C=25 default)      **
    **       STEP 2: Run Binsanity                                                                **
    **       STEP 3: Run CheckM to estimate completeness for Refinement                           **
    **       STEP 4: Run Binsanity-refine                                                         **
    **       STEP 5: Creat Final BinSanity Clusters                                               **
    **                                                                                            **
    **       ******NOTE IF YOU WANT TO SKIP KMEANS CLUSTERING AND ONLY USE AP USE THE******       **
    **       ******                 FLAG '--skip-kmeans'                             ******       **
    ************************************************************************************************
    

optional arguments:
  -h, --help            show this help message and exit
  -c CoverageFile       
                            Specify a Coverage File
                            
  -f FastaLocation      
                            Specify directory containing Fasta File to be clustered
                            
  -p Preference         
                            Specify a preference [Default: -3]
                            Note: decreasing the preference leads to more lumping, 
                            increasing will lead to more splitting. If your range
                            of coverages are low you will want to decrease the
                            preference, if you have 10 or less replicates increasing
                            the preference could benefit you.
                            
                            
  -m MaximumIterations  
                            Specify a max number of iterations [Default: 4000]
                            
  -v ConvergenceIterations
                        
                            Specify the convergence iteration number [Default:400]
                            e.g Number of iterations with no change in the number 
                            of estimated clusters that stops the convergence.
                            
  -d DampeningFactor    
                            Specify a damping factor between 0.5 and 1 [Default: 0.95]
                            
  -l FastaFile Name     
                            Specify the fasta file containing contigs you want to cluster
                            
  -x SizeCutOff         
                            Specify the contig size cut-off [Default:1000 bp]
                            
  -o Output Directory   
                            Give a name to the directory BinSanity results will be output in 
                            [Default:'BINSANITY-RESULTS']
                            
  --checkm_threads Threads
                        
                            Indicate how many threads you want dedicated to the subprocess CheckM [Default: 1]
                            
  --kmer Kmer           
                            Indicate a number for the kmer calculation [Default: 4]
                            
  --refine-preference   
                            Specify a preference for refinement [Default: -25]
                            
  -C ClusterNumber      
                            Indicate a number of initial clusters for kmean [Default:25]
                            
  --skip-kmeans         
                            If you want to bypass kmeans clustering and ONLY us affinity propagation set this flag. 
                            This will replicated the BinsanityWF functionality. The default action without this flag
                            is to implement an initial kmeans clustering. The kmeans clustering step decreases the overall
                            memory requirments for the script so skipping kmeans will lead to greater memory allocation. 
                            It is recommended that users only implement this flag if they are working with small assemblies
                            that are < 25,000 contigs or if the user knows they have ample memory. For reference using this
                            flag with an assembly ~100,000 contigs used >600GB of RAM on our lab server.
                            
                            
  --Prefix Prefix       
                            Specify a prefix to append to the start of all directories generated during Binsanity
                            
  --version             show program's version number and exit
```


## binsanity_Binsanity-refine

### Tool Description
Binsanity-refine uses combined coverage and composition (in the form of tetramer frequencies and GC%) to cluster contigs. The published workflow uses this to refine bins initially clustered soley on coverage. Binsanity-refine can be used as a stand alone script if you don't have more than 2 sample replicates

### Metadata
- **Docker Image**: quay.io/biocontainers/binsanity:0.5.4--pyh5e36f6f_0
- **Homepage**: https://github.com/edgraham/BinSanity
- **Package**: https://anaconda.org/channels/bioconda/packages/binsanity/overview
- **Validation**: PASS

### Original Help Text
```text
usage: Binsanity-refine -f [/path/to/fasta] -l [fastafile] -kmer [kmer type] -c [coverage file] -p [preference] -m [maxiter] -v [convergence iterations] -d [damping factor] -x [contig size] -o [output directory]

    ***********************************************************************
    *****************************BinSanity*********************************
    ** Binsanity-refine uses combined coverage and composition           **
    ** (in the form of tetramer frequencies and GC%) to cluster          **
    ** contigs. The published workflow uses this to refine bins          **
    ** initially clustered soley on coverage.                            **
    **                                                                   **
    ** Binsanity-refine can be used as a stand alone script if you       **
    ** don't have more than 2 sample replicates                          **
    **                                                                   **
    ***********************************************************************

optional arguments:
  -h, --help           show this help message and exit
  -c INPUTCOVFILE      
                           Specify a Coverage File
                           
  -f INPUTCONTIGFILES  
                           Specify directory containing your contigs
                           
  -p PREFERENCE        
                           Specify a preference (default is -25)
                           Note: decreasing the preference leads to more lumping,
                           increasing will lead to more splitting. If your range
                           of coverages are low you will want to decrease the
                           preference, if you have 10 or less replicates increasing
                           the preference could benefit you. For complex datasets
                           with low abundance organisms a preference
                           of -25 was found to be optimal
                           
  -m MAXITER           
                           Specify a max number of iterations (default is 4000)
                           
  -v CONVITER          
                           Specify the convergence iteration number (default is 200)
                           e.g Number of iterations with no change in the number
                           of estimated clusters that stops the convergence.
                           
  -kmer INPUTKMER      
                           Specify a number for kmer calculation. Default is 4.
                           Tetramer frequencies are recommended
                           
  -d DAMP              
                           Specify a damping factor between 0.5 and 1, default is 0.9
                           
  -l FASTAFILE         
                           Specify the fasta file containing contigs you want to cluster
                           
  -x CONTIGSIZE        
                           Specify the contig size cut-off (Default 1000 bp)
                           
  -o OUTPUTDIR         
                           Give a name to the directory BinSanity results will be output in
                           [Default is 'BINSANITY-REFINEMENT']
                           
  --log LOGFILE        
                           Specify an output name for the log file. [Default: binsanity-refine.log]
  --version            show program's version number and exit
  --outPrefix OUTNAME  
                           Sepcify what prefix you want appended to final Bins {optional}
usage: Binsanity-refine -f [/path/to/fasta] -l [fastafile] -kmer [kmer type] -c [coverage file] -p [preference] -m [maxiter] -v [convergence iterations] -d [damping factor] -x [contig size] -o [output directory]

    ***********************************************************************
    *****************************BinSanity*********************************
    ** Binsanity-refine uses combined coverage and composition           **
    ** (in the form of tetramer frequencies and GC%) to cluster          **
    ** contigs. The published workflow uses this to refine bins          **
    ** initially clustered soley on coverage.                            **
    **                                                                   **
    ** Binsanity-refine can be used as a stand alone script if you       **
    ** don't have more than 2 sample replicates                          **
    **                                                                   **
    ***********************************************************************

optional arguments:
  -h, --help           show this help message and exit
  -c INPUTCOVFILE      
                           Specify a Coverage File
                           
  -f INPUTCONTIGFILES  
                           Specify directory containing your contigs
                           
  -p PREFERENCE        
                           Specify a preference (default is -25)
                           Note: decreasing the preference leads to more lumping,
                           increasing will lead to more splitting. If your range
                           of coverages are low you will want to decrease the
                           preference, if you have 10 or less replicates increasing
                           the preference could benefit you. For complex datasets
                           with low abundance organisms a preference
                           of -25 was found to be optimal
                           
  -m MAXITER           
                           Specify a max number of iterations (default is 4000)
                           
  -v CONVITER          
                           Specify the convergence iteration number (default is 200)
                           e.g Number of iterations with no change in the number
                           of estimated clusters that stops the convergence.
                           
  -kmer INPUTKMER      
                           Specify a number for kmer calculation. Default is 4.
                           Tetramer frequencies are recommended
                           
  -d DAMP              
                           Specify a damping factor between 0.5 and 1, default is 0.9
                           
  -l FASTAFILE         
                           Specify the fasta file containing contigs you want to cluster
                           
  -x CONTIGSIZE        
                           Specify the contig size cut-off (Default 1000 bp)
                           
  -o OUTPUTDIR         
                           Give a name to the directory BinSanity results will be output in
                           [Default is 'BINSANITY-REFINEMENT']
                           
  --log LOGFILE        
                           Specify an output name for the log file. [Default: binsanity-refine.log]
  --version            show program's version number and exit
  --outPrefix OUTNAME  
                           Sepcify what prefix you want appended to final Bins {optional}
Please indicate -c coverage file
Please indicate -f directory containing your contigs
```


## Metadata
- **Skill**: generated
