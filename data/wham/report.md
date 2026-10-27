# wham CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| wham | PASS | rewritten: the command is 'wham' with short options (WHAM-BAM is not on PATH); ran on the nf-core yeast paired-end BAM and genome and gave valid VCF soft-clip calls |
| wham_whamg | Not completed | new CWL runs and gives a valid VCF header, but the small real BAMs (nf-core yeast, human chr21) contain no SV calls, so output cannot be confirmed |

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

## wham_whamg

### Tool Description
WHAM-GRAPHENING: structural variant caller.

### Metadata
- **Docker Image**: quay.io/biocontainers/wham:1.8.0.1.2017.05.03--hd28b015_0
- **Homepage**: https://github.com/zeeev/wham
- **Package**: https://anaconda.org/channels/bioconda/packages/wham/overview
- **Validation**: PASS

### Original Help Text
```text
FATAL: no reference fasta provided.

 Basic usage:  
       whamg -f my.bam -a my.fasta \ 
             -e M,GL000207.1 2> wham.err > wham.vcf

 Required:  
          -f  <STRING>  Comma separated list of bam files or a file with    
                        one bam (full path) per line.                       
          -a  <STRING>  The reference genome (indexed fasta).               

 Optional:  Recommended flags are noted with : *                            
          -s  <FLAG>    Exits the program after the stats are               
                        gathered. [false]                                   
          -g  <STRING>  File to write graph to (very large output). [false] 
  *|-c    -e  <STRING>  Comma sep. list of seqids to skip [false].          
  *|-e    -c  <STRING>  Comma sep. list of seqids to keep [false].          
          -r  <STRING>  Region in format: seqid:start-end [whole genome]    
  *       -x  <INT>     Number of CPUs to use [1 CPU].                      
          -m  <INT>     Mapping quality filter [20].                        
          -i  <STRING>  non standard split read tag [SA]                    
          -z  <FLAG>    Sample reads until success. [false]                 
          -d  <INT>     Minimum number of matching bases (both reads).[100] 

 Output:  
        STDERR: Run statistics and bam stats                                
        STOUT : SV calls in VCF                                             

 Details:  
        -z  <FLAG>    WHAM-GRAPHENING can fail if does not sample           
                      enough reads. This flag prevents whamg                
                      from exiting. If your bam header has seqids not in    
                      the bam (e.g. split by region) use -z.                
        -i  <STRING>  WHAM-GRAPHENING uses the optional bwa-mem SA tag.     
                      Older version of bwa-mem used XP.                     
     -e|-c  <STRING>  A list of seqids to include or exclude while          
                      sampling insert and depth.  For humans you should     
                      use the standard chromosomes 1,2,3...X,Y.             

Version: v1.7.0-311-g4e8c-dirty
Contact: zev.kronenberg [at] gmail.com 
Notes  : -If you find a bug, please open a report on github!
```

