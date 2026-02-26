# theseus CWL Generation Report

## theseus

### Tool Description
Maximum likelihood multiple superpositioning

### Metadata
- **Docker Image**: biocontainers/theseus:v3.3.0-8-deb_cv1
- **Homepage**: https://github.com/theseus-os/Theseus
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/theseus/overview
- **Total Downloads**: 14.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/theseus-os/Theseus
- **Stars**: N/A
### Original Help Text
```text
-> No pdb files specified. <- 


                            [1;31m< BEGIN THESEUS 3.3.0 >[0m 
I===-===-===-===-===-===-===-===-===-===-===-===-===-===-===-===-===-===-===-=I
I                [1;36mTHESEUS[0m: Maximum likelihood multiple superpositioning        I
I=-===-===-===-===-===-===-===-===-===-===-===-===-===-===-===-===-===-===-===I
  Usage:                                                                        
    theseus [options] <pdb files>                                               

  Algorithm options:                                                            
    -a  atoms to include in superposition                                       
          [1;32m0[0m = alpha carbons and phosphorous atoms                           
          1 = backbone                                                          
          2 = all                                                               
          3 = alpha and beta carbons                                            
          4 = all heavy atoms (all but hydrogens)                               
            or                                                                  
        a colon-delimited string specifying the atom-types PDB-style            
        e.g., -a ' CA  : N  '                                                   
        selects the alpha carbons and backone nitrogens                         
    -f  only read the first model of a multi-model PDB file                     
    -i  maximum iterations {[1;32m200[0m}                                            
    -l  superimpose with conventional least squares method                      
    -s  residues to select (e.g. -s15-45:50-55) {[1;32mall[0m}                       
    -S  residues to exclude (e.g. -S15-45:50-55) {[1;32mnone[0m}                     
    -[1;32mv[0m  use ML variance weighting (no correlations)                         

 Input/output options: 
    --amber  for reading AMBER8 formatted PDB files                             
    -A  sequence alignment file to use as a guide (CLUSTAL or A2M format)       
    -E  print expert options                                                    
    -F  print FASTA files of the sequences in PDB files and quit                
    -h  help/usage                                                              
    -I  just calculate statistics for input file (don't superposition)          
    -M  file that maps sequences in the alignment file to PDB files             
    -r  root name for output files {[1;32mtheseus[0m}                                
    -V  version                                                                 

 Principal components analysis: 
    -C  use covariance matrix for PCA (correlation matrix is default)           
    -P  # of principal components to calculate {[1;32m0[0m}                          

 Morphometrics: 
    -d  calculate scale factors (for morphometrics)                             
    -q  read and write Rohlf TPS morphometric landmark files                    

 Citations: 
   Douglas L. Theobald and Phillip A. Steindel (2012) 
   "Optimal simultaneous superpositioning of multiple structures with missing
   data."
   Bioinformatics 28(15):1972-1979

   Douglas L. Theobald and Deborah S. Wuttke (2008) 
   "Accurate structural correlations from maximum likelihood superpositions."
   PLOS Computational Biology, 4(2):e43

   http://www.theseus3d.org/
   Compiled with GSL version 2.5
I===-===-===-===-===-===-===-===-===-===-===-===-===-===-===-===-===-===-===-==I
                            [1;31m<  END THESEUS 3.3.0  >[0m
```

