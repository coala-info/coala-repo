# recur CWL Generation Report

## recur

### Tool Description
Run full RECUR analysis on a protein or codon alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/recur:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/OrthoFinder/RECUR
- **Package**: https://anaconda.org/channels/bioconda/packages/recur/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/recur/overview
- **Total Downloads**: 283
- **Last updated**: 2025-05-02
- **GitHub**: https://github.com/OrthoFinder/RECUR
- **Stars**: N/A
### Original Help Text
```text
Unrecognised argument: -help

NoneType: None


SIMPLE USAGE:
Run full RECUR analysis on a protein or codon alignment <dir/file>
recur  -f <dir/file> --outgroups <dir/file/str> -st <AA|CODON>

OPTIONS:
 -f <dir/file>                 Protein or codon alignment in FASTA format       
                               [Required]                                       
 -st <str>                     <AA|CODON> [Required][Default: AA]               
 --outgroups <dir/file/str>    List of outgroup sequences [Required]            
 --num-alignments <int>        Number of simulated alignments for p-value       
                               estimation [Default: 1000]                       
 -te <dir/file>                Complete constraint tree [Default: estimated     
                               from alignment]                                  
 -m <str>                      Model of sequence evolution [Default: estimated  
                               from alignment]                                  
 -nt <int>                     Number of threads provided to IQ-TREE [Default:  
                               1 (without alrt); 5 (with alrt)]                 
 -t <int>                      Number of threads used for RECUR internal        
                               processing [Default: 20]                         
 --seed <int>                  Random starting see number [Default: 8]          
 -o <txt>                      Results directory [Default: same directory as    
                               MSA files]                                       
 -uc <int>                     Update cycle used in progress bar [Default: no   
                               progress bar]                                    
 -bs <int>                     Batch size used in subsitution analysis of the   
                               Monte Carlo Simulated sequences [Default: no     
                               batch processing]                                
 -iv <str>                     IQ-TREE version. [Default: iqtree2]              
 -blfix                        Fix branch lengths of tree. [Default: False]     


LICENSE:
 Distributed under the GNU General Public License (GPLv3). See License.md

CITATION:
When publishing work that uses RECUR please cite:

Robbins EHJ, Liu Y, Kelly S. 2025. RECUR: Identifying recurrent amino acid 
substitutions from multiple sequence alignments 

RECUR run completed

*** RECUR finished in 0.01 seconds ***
```

