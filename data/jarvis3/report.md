# jarvis3 CWL Generation Report

## jarvis3_JARVIS3

### Tool Description
Lossless compression and decompression of genomic
      sequences for minimal storage and analysis purposes.
      Measure an upper bound of the sequence complexity.

### Metadata
- **Docker Image**: quay.io/biocontainers/jarvis3:3.7--h7b50bb2_3
- **Homepage**: https://github.com/cobilab/jarvis3
- **Package**: https://anaconda.org/channels/bioconda/packages/jarvis3/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/jarvis3/overview
- **Total Downloads**: 1.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cobilab/jarvis3
- **Stars**: N/A
### Original Help Text
```text
██ ███████ ███████ ██    ██ ██ ███████ ███████          
           ██ ██   ██ ██   ██ ██    ██ ██ ██           ██          
           ██ ███████ ██████  ██    ██ ██ ███████ ███████          
      ██   ██ ██   ██ ██  ███  ██  ██  ██      ██      ██          
      ███████ ██   ██ ██   ███  ████   ██ ███████ ███████          
                                                                   
NAME                                                               
      JARVIS3 v3.7,                                              
      Efficient lossless encoding of genomic sequences             
                                                                   
SYNOPSIS                                                           
      ./JARVIS3 [OPTION]... [FILE]                                 
                                                                   
SAMPLE                                                             
      Run Compression   -> ./JARVIS3 -v -l 13 sequence.txt         
      Run Decompression -> ./JARVIS3 -v -d sequence.txt.jc         
                                                                   
DESCRIPTION                                                        
      Lossless compression and decompression of genomic            
      sequences for minimal storage and analysis purposes.         
      Measure an upper bound of the sequence complexity.           
                                                                   
      -h,  --help                                                  
           Usage guide (help menu).                                
                                                                   
      -a,  --version                                               
           Display program and version information.                
                                                                   
      -x,  --explanation                                           
           Explanation of the context and repeat models.           
                                                                   
      -f,  --force                                                 
           Force mode. Overwrites old files.                       
                                                                   
      -v,  --verbose                                               
           Verbose mode (more information).                        
                                                                   
      -p,  --progress                                              
           Show progress bar.                                      
                                                                   
      -P,  --progress-extended                                     
           Show compression progress for each 5%.                 
                                                                   
      -d,  --decompress                                            
           Decompression mode.                                     
                                                                   
      -e,  --estimate                                              
           It creates a file with the extension ".iae" with the  
           respective information content. If the file is FASTA or 
           FASTQ it will only use the "ACGT" (genomic) sequence. 
                                                                   
      -s,  --show-levels                                           
           Show pre-computed compression levels (configured).      
                                                                   
      -l [NUMBER],  --level [NUMBER]                               
           Compression level (integer).                            
           Default level: 7.                                      
           It defines compressibility in balance with computational
           resources (RAM & time). Use -s for levels perception.   
                                                                   
      -sd [NUMBER],  --seed [NUMBER]                               
           Pseudo-random seed.                                     
           Default value: 0.                                      
                                                                   
      -hs [NUMBER],  --hidden-size [NUMBER]                        
           Hidden size of the neural network (integer).            
           Default value: 40.                                      
                                                                   
      -lr [DOUBLE],  --learning-rate [DOUBLE]                      
           Neural Network leaning rate (double).                   
           The 0 value turns the Neural Network off.               
           Default value: 0.03.                                   
                                                                   
      -o [FILENAME], --output [FILENAME]                           
           Compressed/decompressed output filename.                
                                                                   
      [FILENAME]                                                   
           Input sequence filename (to compress) -- MANDATORY.     
           File to compress is the last argument.                  
                                                                   
COPYRIGHT                                                          
      Copyright (C) 2014-2024.                                     
      This is a Free software, under GPLv3. You may redistribute   
      copies of it under the terms of the GNU - General Public     
      License v3 <http://www.gnu.org/licenses/gpl.html>.
```

