# ac CWL Generation Report

## ac_AC

### Tool Description
Compression of amino acid sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/ac:1.1--h503566f_6
- **Homepage**: https://github.com/cobilab/ac
- **Package**: https://anaconda.org/channels/bioconda/packages/ac/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ac/overview
- **Total Downloads**: 5.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cobilab/ac
- **Stars**: 4
### Original Help Text
```text
INFO:    Using cached SIF image
Usage: AC [OPTION]... -r [FILE]  [FILE]:[...]                          
Compression of amino acid sequences.                                   
                                                                       
Non-mandatory arguments:                                               
                                                                       
  -h                     give this help,                               
  -s                     show AC compression levels,                   
  -v                     verbose mode (more information),              
  -V                     display version number,                       
  -f                     force overwrite of output,                    
  -l <level>             level of compression [1;7] (lazy -tm setup),  
  -t <threshold>         threshold frequency to discard from alphabet,
  -e                     it creates a file with the extension ".iae" 
                         with the respective information content.      
                                                                       
  -rm <c>:<d>:<g>/<m>:<e>:<a>  reference model (-rm 1:10:0.9/0:0:0),   
  -rm <c>:<d>:<g>/<m>:<e>:<a>  reference model (-rm 5:90:0.9/1:50:0.8),
  ...                                                                  
  -tm <c>:<d>:<g>/<m>:<e>:<a>  target model (-tm 1:1:0.8/0:0:0),       
  -tm <c>:<d>:<g>/<m>:<e>:<a>  target model (-tm 7:100:0.9/2:10:0.85), 
  ...                                                                  
                         target and reference templates use <c> for    
                         context-order size, <d> for alpha (1/<d>), <g>
                         for gamma (decayment forgetting factor) [0;1),
                         <m> to the maximum sets the allowed mutations,
                         on the context without being discarded (for   
                         deep contexts), under the estimator <e>, using
                         <a> for gamma (decayment forgetting factor)   
                         [0;1) (tolerant model),                       
                                                                       
  -r <FILE>              reference file ("-rm" are loaded here),     
                                                                       
Mandatory arguments:                                                   
                                                                       
  <FILE>:<...>:<...>     file to compress (last argument). For more    
                         files use splitting ":" characters.         
                                                                       
Example:                                                               
                                                                       
  [Compress]   ./AC -v -tm 1:1:0.8/0:0:0 -tm 5:20:0.9/3:20:0.9 seq.txt 
  [Decompress] ./AD -v seq.txt.co                                      
                                                                       
Report bugs to <{pratas,seyedmorteza,ap}@ua.pt>.
```


## Metadata
- **Skill**: generated
