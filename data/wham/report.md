# wham CWL Generation Report

## wham

### Tool Description
WHAM-BAM is a tool for detecting structural variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/wham:1.8.0.1.2017.05.03--hd28b015_0
- **Homepage**: https://github.com/zeeev/wham
- **Package**: https://anaconda.org/channels/bioconda/packages/wham/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/wham/overview
- **Total Downloads**: 36.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/zeeev/wham
- **Stars**: N/A
### Original Help Text
```text
FATAL: Failure to specify target and/or background bam files.
FATAL: Now exiting wham.
usage  : WHAM-BAM -f <STRING> -m <INT> -q <INT> -p <INT> -x <INT> -r <STRING> -e <STRING> -t <STRING> -b <STRING> 

example: WHAM-BAM if my.fasta -m 2 -q 15 -p 10 -x 20 -r chr1:0-10000 -e genes.bed -t a.bam,b.bam -b c.bam,d.bam

required   : t <STRING> -- comma separated list of target bam files          
required   : f <STRING> -- reference sequence reads were aligned to          
option     : b <STRING> -- comma separated list of background bam files      
option     : r <STRING> -- a genomic region in the format "seqid:start-end"
option     : x <INT>    -- set the number of threads, otherwise max [all]    
option     : e <STRING> -- a bedfile that defines regions to score  [none]   
option     : m <INT>    -- minimum number of soft-clips supporting           
                           START [3]                                         
option     : q <INT>    -- exclude soft-cliped sequences with average base   
                           quality below phred scaled value (0-41) [20]      
option     : p <INT>    -- exclude soft-clipped reads with mapping quality   
                           below value [15]                                  
option     : i          -- base quality is Illumina 1.3+ Phred+64            

Version: v1.7.0-311-g4e8c-dirty
Contact: zev.kronenberg [at] gmail.com 
Notes  : -If you find a bug, please open a report on github!
         -The options -m,-q, and -p, control the sensitivity and specificity
         -If you have exome data use the -e option for best performance
```

