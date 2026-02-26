# jarvis CWL Generation Report

## jarvis_JARVIS

### Tool Description
extreme lossless compression of genomic sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/jarvis:1.1--h7b50bb2_6
- **Homepage**: https://github.com/cobilab/jarvis
- **Package**: https://anaconda.org/channels/bioconda/packages/jarvis/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/jarvis/overview
- **Total Downloads**: 5.3K
- **Last updated**: 2025-08-10
- **GitHub**: https://github.com/cobilab/jarvis
- **Stars**: N/A
### Original Help Text
```text
██╗ █████╗ ██████╗ ██╗   ██╗██╗███████╗                  
              ██║██╔══██╗██╔══██╗██║   ██║██║██╔════╝                  
              ██║███████║██████╔╝██║   ██║██║███████╗                  
         ██   ██║██╔══██║██╔══██╗╚██╗ ██╔╝██║╚════██║                  
         ╚█████╔╝██║  ██║██║  ██║ ╚████╔╝ ██║███████║                  
          ╚════╝ ╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚══════╝                  
                                                                       
NAME                                                                   
      JARVIS v1.1,                                                   
      extreme lossless compression of genomic sequences.               
                                                                       
AUTHORS                                                                
      Diogo Pratas        pratas@ua.pt                                 
      Morteza Hosseini    seyedmorteza@ua.pt                           
      Armando J. Pinho    ap@ua.pt                                     
                                                                       
SYNOPSIS                                                               
      ./JARVIS [OPTION]... [FILE]                                      
                                                                       
SAMPLE                                                                 
      Run Compression         :  ./JARVIS -v -l 4 sequence.txt         
      Run Decompression       :  ./JARVIS -v -d sequence.txt.jc        
                                                                       
DESCRIPTION                                                            
      Compress and decompress lossless genomic sequences for           
      storage and analysis purposes.                                   
      Measure an upper bound of the sequence entropy.                  
                                                                       
      -h,  --help                                                      
           usage guide (help menu).                                    
                                                                       
      -V,  --version                                                   
           Display program and version information.                    
                                                                       
      -F,  --force                                                     
           force mode. Overwrites old files.                           
                                                                       
      -v,  --verbose                                                   
           verbose mode (more information).                            
                                                                       
      -e,  --estimation                                                
           creates [sequence].info with complexity profile.            
                                                                       
      -s,  --show-levels                                               
           show pre-computed compression levels (configured).          
                                                                       
      -e,  --estimate                                                  
           it creates a file with the extension ".iae" with the      
           respective information content. If the file is FASTA or     
           FASTQ it will only use the "ACGT" (genomic) sequence.     
                                                                       
      -l [NUMBER],  --level [NUMBER]                                   
           Compression level (integer).                                
           Default level: 1.                                          
           It defines compressibility in balance with computational    
           resources (RAM & time). Use -s for levels perception.       
                                                                   
      -cm [NB_C]:[NB_D]:[NB_I]:[NB_G]/[NB_S]:[NB_E]:[NB_I]:[NB_A]  
      Template of a context model.                                 
      Parameters:                                                  
      [NB_C]: (integer [1;20]) order size of the regular context   
              model. Higher values use more RAM but, usually, are  
              related to a better compression score.               
      [NB_D]: (integer [1;5000]) denominator to build alpha, which 
              is a parameter estimator. Alpha is given by 1/[NB_D].
              Higher values are usually used with higher [NB_C],   
              and related to confiant bets. When [NB_D] is one,    
              the probabilities assume a Laplacian distribution.   
      [NB_I]: (integer {0,1}) number to define if a sub-program    
              which addresses the specific properties of DNA       
              sequences (Inverted repeats) is used or not. The     
              number 1 turns ON the sub-program using at the same  
              time the regular context model. The number 0 does    
              not contemple its use (Inverted repeats OFF). The    
              use of this sub-program increases the necessary time 
              to compress but it does not affect the RAM.          
      [NB_G]: (real [0;1)) real number to define gamma. This value 
              represents the decayment forgetting factor of the    
              regular context model in definition.                 
      [NB_S]: (integer [0;20]) maximum number of editions allowed  
              to use a substitutional tolerant model with the same 
              memory model of the regular context model with       
              order size equal to [NB_C]. The value 0 stands for   
              turning the tolerant context model off. When the     
              model is on, it pauses when the number of editions   
              is higher that [NB_C], while it is turned on when    
              a complete match of size [NB_C] is seen again. This  
              is probabilistic-algorithmic model very usefull to   
              handle the high substitutional nature of genomic     
              sequences. When [NB_S] > 0, the compressor used more 
              processing time, but uses the same RAM and, usually, 
              achieves a substantial higher compression ratio. The 
              impact of this model is usually only noticed for     
              [NB_C] >= 14.                                        
      [NB_R]: (integer {0,1}) number to define if a sub-program    
              which addresses the specific properties of DNA       
              sequences (Inverted repeats) is used or not. It is   
              similar to the [NR_I] but for tolerant models.       
      [NB_E]: (integer [1;5000]) denominator to build alpha for    
              substitutional tolerant context model. It is         
              analogous to [NB_D], however to be only used in the  
              probabilistic model for computing the statistics of  
              the substitutional tolerant context model.           
      [NB_A]: (real [0;1)) real number to define gamma. This value 
              represents the decayment forgetting factor of the    
              substitutional tolerant context model in definition. 
              Its definition and use is analogus to [NB_G].        
                                                                   
      ... (you may use several context models)                     
                                                                   
                                                                   
      -rm [NB_R]:[NB_C]:[NB_A]:[NB_B]:[NB_L]:[NB_G]:[NB_I]         
      Template of a repeat model.                                  
      Parameters:                                                  
      [NB_R]: (integer [1;10000] maximum number of repeat models   
              for the class. On very repetive sequences the RAM    
              increases along with this value, however it also     
              improves the compression capability.                 
      [NB_C]: (integer [1;20]) order size of the repeat context    
              model. Higher values use more RAM but, usually, are  
              related to a better compression score.               
      [NB_A]: (real (0;1]) alpha is a real value, which is a       
              parameter estimator. Higher values are usually used  
              in lower [NB_C]. When [NB_A] is one, the             
              probabilities assume a Laplacian distribution.       
      [NB_B]: (real (0;1]) beta is a real value, which is a        
              parameter for discarding or maintaining a certain    
              repeat model.                                        
      [NB_L]: (integer (1;20]) a limit threshold to play with      
              [NB_B]. It accepts or not a certain repeat model.    
      [NB_G]: (real [0;1)) real number to define gamma. This value 
              represents the decayment forgetting factor of the    
              regular context model in definition.                 
      [NB_I]: (integer {0,1}) number to define if a sub-program    
              which addresses the specific properties of DNA       
              sequences (Inverted repeats) is used or not. The     
              number 1 turns ON the sub-program using at the same  
              time the regular context model. The number 0 does    
              not contemple its use (Inverted repeats OFF). The    
              use of this sub-program increases the necessary time 
              to compress but it does not affect the RAM.          
                                                                   
      -z [NUMBER],  --selection [NUMBER]                               
           Size of the context selection model (integer).              
           Default context selection: 12.                              
                                                                       
      [FILE]                                                           
           Input sequence filename (to compress) -- MANDATORY.         
           File to compress is the last argument.                      
                                                                       
COPYRIGHT                                                              
      Copyright (C) 2014-2019, IEETA, University of Aveiro.            
      This is a Free software, under GPLv3. You may redistribute       
      copies of it under the terms of the GNU - General Public         
      License v3 <http://www.gnu.org/licenses/gpl.html>. There         
      is NOT ANY WARRANTY, to the extent permitted by law.
```

