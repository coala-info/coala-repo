# hhsuite CWL Generation Report

## hhsuite_hhblits

### Tool Description
HMM-HMM-based lightning-fast iterative sequence search
HHblits is a sensitive, general-purpose, iterative sequence search tool that represents
both query and database sequences by HMMs. You can search HHblits databases starting
with a single query sequence, a multiple sequence alignment (MSA), or an HMM. HHblits
prints out a ranked list of database HMMs/MSAs and can also generate an MSA by merging
the significant database HMMs/MSAs onto the query MSA.

### Metadata
- **Docker Image**: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
- **Homepage**: https://github.com/soedinglab/hh-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/hhsuite/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hhsuite/overview
- **Total Downloads**: 428.7K
- **Last updated**: 2025-05-28
- **GitHub**: https://github.com/soedinglab/hh-suite
- **Stars**: N/A
### Original Help Text
```text
HHblits 3.3.0:
HMM-HMM-based lightning-fast iterative sequence search
HHblits is a sensitive, general-purpose, iterative sequence search tool that represents
both query and database sequences by HMMs. You can search HHblits databases starting
with a single query sequence, a multiple sequence alignment (MSA), or an HMM. HHblits
prints out a ranked list of database HMMs/MSAs and can also generate an MSA by merging
the significant database HMMs/MSAs onto the query MSA.

Steinegger M, Meier M, Mirdita M, Vöhringer H, Haunsberger S J, and Söding J (2019)
HH-suite3 for fast remote homology detection and deep protein annotation.
BMC Bioinformatics, doi:10.1186/s12859-019-3019-7
(c) The HH-suite development team

Usage: hhblits -i query [options] 
 -i <file>      input/query: single sequence or multiple sequence alignment (MSA)
                in a3m, a2m, or FASTA format, or HMM in hhm format

<file> may be 'stdin' or 'stdout' throughout.

Options:                                                                        
 -d <name>      database name (e.g. uniprot20_29Feb2012)                        
                Multiple databases may be specified with '-d <db1> -d <db2> ...'
 -n     [1,8]   number of iterations (default=2)                               
 -e     [0,1]   E-value cutoff for inclusion in result alignment (def=0.001)       

Input alignment format:                                                       
 -M a2m         use A2M/A3M (default): upper case = Match; lower case = Insert;
               ' -' = Delete; '.' = gaps aligned to inserts (may be omitted)   
 -M first       use FASTA: columns with residue in 1st sequence are match states
 -M [0,100]     use FASTA: columns with fewer than X% gaps are match states   
 -tags/-notags  do NOT / do neutralize His-, C-myc-, FLAG-tags, and trypsin 
                recognition sequence to background distribution (def=-notags)  

Output options: 
 -o <file>      write results in standard format to file (default=<infile.hhr>)
 -oa3m <file>   write result MSA with significant matches in a3m format
 -opsi <file>   write result MSA of significant matches in PSI-BLAST format
 -ohhm <file>   write HHM file for result MSA of significant matches
 -oalis <name>  write MSAs in A3M format after each iteration
 -blasttab <name> write result in tabular BLAST format (compatible to -m 8 or -outfmt 6 output)
                  1      2      3           4         5        6      8    9      10   11   12
                  'query target #match/tLen #mismatch #gapOpen qstart qend tstart tend eval score'
 -add_cons      generate consensus sequence as master sequence of query MSA (default=don't)
 -hide_cons     don't show consensus sequence in alignments (default=show)     
 -hide_pred     don't show predicted 2ndary structure in alignments (default=show)
 -hide_dssp     don't show DSSP 2ndary structure in alignments (default=show)  
 -show_ssconf   show confidences for predicted 2ndary structure in alignments
 -Ofas <file>   write pairwise alignments in FASTA xor A2M (-Oa2m) xor A3M (-Oa3m) format   
 -seq <int>     max. number of query/template sequences displayed (default=1)  
 -aliw <int>    number of columns per line in alignment list (default=80)       
 -p [0,100]     minimum probability in summary and alignment list (default=20)  
 -E [0,inf[     maximum E-value in summary and alignment list (default=1E+06)      
 -Z <int>       maximum number of lines in summary hit list (default=500)        
 -z <int>       minimum number of lines in summary hit list (default=10)        
 -B <int>       maximum number of alignments in alignment list (default=500)     
 -b <int>       minimum number of alignments in alignment list (default=10)     

Prefilter options                                                               
 -noprefilt                disable all filter steps                                        
 -noaddfilter              disable all filter steps (except for fast prefiltering)         
 -maxfilt                  max number of hits allowed to pass 2nd prefilter (default=20000)   
 -min_prefilter_hits       min number of hits to pass prefilter (default=100)               
 -prepre_smax_thresh       min score threshold of ungapped prefilter (default=10)               
 -pre_evalue_thresh        max E-value threshold of Smith-Waterman prefilter score (default=1000.0)
 -pre_bitfactor            prefilter scores are in units of 1 bit / pre_bitfactor (default=4)
 -pre_gap_open             gap open penalty in prefilter Smith-Waterman alignment (default=20)
 -pre_gap_extend           gap extend penalty in prefilter Smith-Waterman alignment (default=4)
 -pre_score_offset         offset on sequence profile scores in prefilter S-W alignment (default=50)

Filter options applied to query MSA, database MSAs, and result MSA              
 -all           show all sequences in result MSA; do not filter result MSA      
 -interim_filter NONE|FULL  
                filter sequences of query MSA during merging to avoid early stop (default: FULL)
                  NONE: disables the intermediate filter 
                  FULL: if an early stop occurs compare filter seqs in an all vs. all comparison
 -id   [0,100]  maximum pairwise sequence identity (def=90)
 -diff [0,inf[  filter MSAs by selecting most diverse set of sequences, keeping 
                at least this many seqs in each MSA block of length 50 
                Zero and non-numerical values turn off the filtering. (def=1000) 
 -cov  [0,100]  minimum coverage with master sequence (%) (def=0)             
 -qid  [0,100]  minimum sequence identity with master sequence (%) (def=0)    
 -qsc  [0,100]  minimum score per column with master sequence (default=-20.0)    
 -neff [1,inf]  target diversity of multiple sequence alignment (default=off)   
 -mark          do not filter out sequences marked by ">@"in their name line  

HMM-HMM alignment options:                                                       
 -norealign           do NOT realign displayed hits with MAC algorithm (def=realign)   
 -realign_old_hits    realign hits from previous iterations                          
 -mact [0,1[          posterior prob threshold for MAC realignment controlling greedi- 
                      ness at alignment ends: 0:global >0.1:local (default=0.35)       
 -glob/-loc           use global/local alignment mode for searching/ranking (def=local)
 -realign             realign displayed hits with max. accuracy (MAC) algorithm 
 -realign_max <int>   realign max. <int> hits (default=500)                        
 -ovlp <int>          banded alignment: forbid <ovlp> largest diagonals |i-j| of DP matrix (def=0)
 -alt <int>           show up to this many alternative alignments with raw score > smin(def=4)  
 -premerge <int> merge <int> hits to query MSA before aligning remaining hits (def=3)
 -smin <float>        minimum raw score for alternative alignments (def=20.0)  
 -shift [-1,1]        profile-profile score offset (def=-0.03)                         
 -corr [0,1]          weight of term for pair correlations (def=0.10)                
 -sc   <int>          amino acid score         (tja: template HMM at column j) (def=1)
              0       = log2 Sum(tja*qia/pa)   (pa: aa background frequencies)    
              1       = log2 Sum(tja*qia/pqa)  (pqa = 1/2*(pa+ta) )               
              2       = log2 Sum(tja*qia/ta)   (ta: av. aa freqs in template)     
              3       = log2 Sum(tja*qia/qa)   (qa: av. aa freqs in query)        
              5       local amino acid composition correction                     
 -ssm {0,..,4}        0:   no ss scoring                                             
                      1,2: ss scoring after or during alignment  [default=2]         
                      3,4: ss scoring after or during alignment, predicted vs. predicted
 -ssw [0,1]           weight of ss score  (def=0.11)                                  
 -ssa [0,1]           ss confusion matrix = (1-ssa)*I + ssa*psipred-confusion-matrix [def=1.00)
 -wg                  use global sequence weighting for realignment!                   

Gap cost options:                                                                
 -gapb [0,inf[  Transition pseudocount admixture (def=1.00)                     
 -gapd [0,inf[  Transition pseudocount admixture for open gap (default=0.15)    
 -gape [0,1.5]  Transition pseudocount admixture for extend gap (def=1.00)      
 -gapf ]0,inf]  factor to increase/reduce gap open penalty for deletes (def=0.60) 
 -gapg ]0,inf]  factor to increase/reduce gap open penalty for inserts (def=0.60) 
 -gaph ]0,inf]  factor to increase/reduce gap extend penalty for deletes(def=0.60)
 -gapi ]0,inf]  factor to increase/reduce gap extend penalty for inserts(def=0.60)
 -egq  [0,inf[  penalty (bits) for end gaps aligned to query residues (def=0.00) 
 -egt  [0,inf[  penalty (bits) for end gaps aligned to template residues (def=0.00)

Pseudocount (pc) options:                                                        
 Context specific hhm pseudocounts:
  -pc_hhm_contxt_mode {0,..,3}   position dependence of pc admixture 'tau' (pc mode, default=2) 
               0: no pseudo counts:    tau = 0                                  
               1: constant             tau = a                                  
               2: diversity-dependent: tau = a/(1+((Neff[i]-1)/b)^c)            
               3: CSBlast admixture:   tau = a(1+b)/(Neff[i]+b)                 
               (Neff[i]: number of effective seqs in local MSA around column i) 
  -pc_hhm_contxt_a  [0,1]        overall pseudocount admixture (def=0.9)                        
  -pc_hhm_contxt_b  [1,inf[      Neff threshold value for mode 2 (def=4.0)                      
  -pc_hhm_contxt_c  [0,3]        extinction exponent c for mode 2 (def=1.0)                     

 Context independent hhm pseudocounts (used for templates; used for query if contxt file is not available):
  -pc_hhm_nocontxt_mode {0,..,3}   position dependence of pc admixture 'tau' (pc mode, default=2) 
               0: no pseudo counts:    tau = 0                                  
               1: constant             tau = a                                  
               2: diversity-dependent: tau = a/(1+((Neff[i]-1)/b)^c)            
               (Neff[i]: number of effective seqs in local MSA around column i) 
  -pc_hhm_nocontxt_a  [0,1]        overall pseudocount admixture (def=1.0)                        
  -pc_hhm_nocontxt_b  [1,inf[      Neff threshold value for mode 2 (def=1.5)                      
  -pc_hhm_nocontxt_c  [0,3]        extinction exponent c for mode 2 (def=1.0)                     

 Context specific prefilter pseudocounts:
  -pc_prefilter_contxt_mode {0,..,3}   position dependence of pc admixture 'tau' (pc mode, default=3) 
               0: no pseudo counts:    tau = 0                                  
               1: constant             tau = a                                  
               2: diversity-dependent: tau = a/(1+((Neff[i]-1)/b)^c)            
               3: CSBlast admixture:   tau = a(1+b)/(Neff[i]+b)                 
               (Neff[i]: number of effective seqs in local MSA around column i) 
  -pc_prefilter_contxt_a  [0,1]        overall pseudocount admixture (def=0.8)                        
  -pc_prefilter_contxt_b  [1,inf[      Neff threshold value for mode 2 (def=2.0)                      
  -pc_prefilter_contxt_c  [0,3]        extinction exponent c for mode 2 (def=1.0)                     

 Context independent prefilter pseudocounts (used if context file is not available):
  -pc_prefilter_nocontxt_mode {0,..,3}   position dependence of pc admixture 'tau' (pc mode, default=2) 
               0: no pseudo counts:    tau = 0                                  
               1: constant             tau = a                                  
               2: diversity-dependent: tau = a/(1+((Neff[i]-1)/b)^c)            
               (Neff[i]: number of effective seqs in local MSA around column i) 
  -pc_prefilter_nocontxt_a  [0,1]        overall pseudocount admixture (def=1.0)                        
  -pc_prefilter_nocontxt_b  [1,inf[      Neff threshold value for mode 2 (def=1.5)                      
  -pc_prefilter_nocontxt_c  [0,3]        extinction exponent c for mode 2 (def=1.0)                     

 Context-specific pseudo-counts:                                                  
  -nocontxt      use substitution-matrix instead of context-specific pseudocounts 
  -contxt <file> context file for computing context-specific pseudocounts (default=)
  -csw  [0,inf]  weight of central position in cs pseudocount mode (def=1.6)
  -csb  [0,1]    weight decay parameter for positions in cs pc mode (def=0.9)

Other options:                                                                   
 -v <int>       verbose mode: 0:no screen output  1:only warings  2: verbose (def=2)
 -neffmax ]1,20] skip further search iterations when diversity Neff of query MSA 
                becomes larger than neffmax (default=20.0)
 -cpu <int>     number of CPUs to use (for shared memory SMPs) (default=2)      
 -scores <file> write scores for all pairwise comparisons to file               
 -filter_matrices filter matrices for similarity to output at most 100 matrices
 -atab   <file> write all alignments in tabular layout to file                   
 -maxseq <int>  max number of input rows (def=65535)
 -maxres <int>  max number of HMM columns (def=20001)
 -maxmem [1,inf[ limit memory for realignment (in GB) (def=3.0)          

Examples:
hhblits -i query.fas -o query.hhr -d ./uniclust30

hhblits -i query.fas -o query.hhr -oa3m query.a3m -n 1 -d ./uniclust30

Download databases from <http://wwwuser.gwdg.de/~compbiol/data/hhsuite/databases/hhsuite_dbs/>.
```


## hhsuite_hhsearch

### Tool Description
Search a database of HMMs with a query alignment or query HMM

### Metadata
- **Docker Image**: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
- **Homepage**: https://github.com/soedinglab/hh-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/hhsuite/overview
- **Validation**: PASS

### Original Help Text
```text
HHsearch 3.3.0
Search a database of HMMs with a query alignment or query HMM
(c) The HH-suite development team
Steinegger M, Meier M, Mirdita M, Vöhringer H, Haunsberger S J, and Söding J (2019)
HH-suite3 for fast remote homology detection and deep protein annotation.
BMC Bioinformatics, doi:10.1186/s12859-019-3019-7

Usage: hhsearch -i query -d database [options]                       
 -i <file>      input/query multiple sequence alignment (a2m, a3m, FASTA) or HMM

<file> may be 'stdin' or 'stdout' throughout.
Options:                                                                        
 -d <name>      database name (e.g. uniprot20_29Feb2012)                        
                Multiple databases may be specified with '-d <db1> -d <db2> ...'
 -e     [0,1]   E-value cutoff for inclusion in result alignment (def=0.001)       

Input alignment format:                                                       
 -M a2m         use A2M/A3M (default): upper case = Match; lower case = Insert;
               '-' = Delete; '.' = gaps aligned to inserts (may be omitted)   
 -M first       use FASTA: columns with residue in 1st sequence are match states
 -M [0,100]     use FASTA: columns with fewer than X% gaps are match states   
 -tags/-notags  do NOT / do neutralize His-, C-myc-, FLAG-tags, and trypsin 
                recognition sequence to background distribution (def=-notags)  

Output options: 
 -o <file>      write results in standard format to file (default=<infile.hhr>)
 -oa3m <file>   write result MSA with significant matches in a3m format
 -blasttab <name> write result in tabular BLAST format (compatible to -m 8 or -outfmt 6 output)
                  1     2      3           4      5         6        7      8    9      10   11   12
                  query target #match/tLen alnLen #mismatch #gapOpen qstart qend tstart tend eval score
 -opsi <file>   write result MSA of significant matches in PSI-BLAST format
 -ohhm <file>   write HHM file for result MSA of significant matches
 -add_cons      generate consensus sequence as master sequence of query MSA (default=don't)
 -hide_cons     don't show consensus sequence in alignments (default=show)     
 -hide_pred     don't show predicted 2ndary structure in alignments (default=show)
 -hide_dssp     don't show DSSP 2ndary structure in alignments (default=show)  
 -show_ssconf   show confidences for predicted 2ndary structure in alignments
 -Ofas <file>   write pairwise alignments in FASTA xor A2M (-Oa2m) xor A3M (-Oa3m) format   
 -seq <int>     max. number of query/template sequences displayed (default=1)  
 -aliw <int>    number of columns per line in alignment list (default=80)       
 -p [0,100]     minimum probability in summary and alignment list (default=20)  
 -E [0,inf[     maximum E-value in summary and alignment list (default=1E+06)      
 -Z <int>       maximum number of lines in summary hit list (default=500)        
 -z <int>       minimum number of lines in summary hit list (default=10)        
 -B <int>       maximum number of alignments in alignment list (default=500)     
 -b <int>       minimum number of alignments in alignment list (default=10)     

Filter options applied to query MSA, database MSAs, and result MSA              
 -all           show all sequences in result MSA; do not filter result MSA      
 -id   [0,100]  maximum pairwise sequence identity (def=90)
 -diff [0,inf[  filter MSAs by selecting most diverse set of sequences, keeping 
                at least this many seqs in each MSA block of length 50 
                Zero and non-numerical values turn off the filtering. (def=100) 
 -cov  [0,100]  minimum coverage with master sequence (%) (def=0)             
 -qid  [0,100]  minimum sequence identity with master sequence (%) (def=0)    
 -qsc  [0,100]  minimum score per column with master sequence (default=-20.0)    
 -neff [1,inf]  target diversity of multiple sequence alignment (default=off)   
 -mark          do not filter out sequences marked by ">@"in their name line  

HMM-HMM alignment options:                                                       
 -norealign          do NOT realign displayed hits with MAC algorithm (def=realign)   
 -ovlp <int>         banded alignment: forbid <ovlp> largest diagonals |i-j| of DP matrix (def=0)
 -mact [0,1[         posterior prob threshold for MAC realignment controlling greedi- 
                     ness at alignment ends: 0:global >0.1:local (default=0.35)       
 -glob/-loc          use global/local alignment mode for searching/ranking (def=local)
 -realign            realign displayed hits with max. accuracy (MAC) algorithm 
 -excl <range>       exclude query positions from the alignment, e.g. '1-33,97-168' 
 -realign_max <int>  realign max. <int> hits (default=500)                        
 -alt <int>          show up to this many alternative alignments with raw score > smin(def=4)  
 -smin <float>       minimum raw score for alternative alignments (def=20.0)  
 -shift [-1,1]       profile-profile score offset (def=-0.03)                         
 -corr [0,1]         weight of term for pair correlations (def=0.10)                
 -sc   <int>         amino acid score         (tja: template HMM at column j) (def=1)
        0       = log2 Sum(tja*qia/pa)   (pa: aa background frequencies)    
        1       = log2 Sum(tja*qia/pqa)  (pqa = 1/2*(pa+ta) )               
        2       = log2 Sum(tja*qia/ta)   (ta: av. aa freqs in template)     
        3       = log2 Sum(tja*qia/qa)   (qa: av. aa freqs in query)        
        5       local amino acid composition correction                     
 -ssm {0,..,4}    0:   no ss scoring                                             
                1,2: ss scoring after or during alignment  [default=2]         
                3,4: ss scoring after or during alignment, predicted vs. predicted
 -ssw [0,1]          weight of ss score  (def=0.11)                                  
 -ssa [0,1]          SS substitution matrix = (1-ssa)*I + ssa*full-SS-substition-matrix [def=1.00)
 -wg                 use global sequence weighting for realignment!                   

Gap cost options:                                                                
 -gapb [0,inf[  Transition pseudocount admixture (def=1.00)                     
 -gapd [0,inf[  Transition pseudocount admixture for open gap (default=0.15)    
 -gape [0,1.5]  Transition pseudocount admixture for extend gap (def=1.00)      
 -gapf ]0,inf]  factor to increase/reduce gap open penalty for deletes (def=0.60) 
 -gapg ]0,inf]  factor to increase/reduce gap open penalty for inserts (def=0.60) 
 -gaph ]0,inf]  factor to increase/reduce gap extend penalty for deletes(def=0.60)
 -gapi ]0,inf]  factor to increase/reduce gap extend penalty for inserts(def=0.60)
 -egq  [0,inf[  penalty (bits) for end gaps aligned to query residues (def=0.00) 
 -egt  [0,inf[  penalty (bits) for end gaps aligned to template residues (def=0.00)

Pseudocount (pc) options:                                                        
 Context specific hhm pseudocounts:
  -pc_hhm_contxt_mode {0,..,3}   position dependence of pc admixture 'tau' (pc mode, default=2) 
               0: no pseudo counts:    tau = 0                                  
               1: constant             tau = a                                  
               2: diversity-dependent: tau = a/(1+((Neff[i]-1)/b)^c)            
               3: CSBlast admixture:   tau = a(1+b)/(Neff[i]+b)                 
               (Neff[i]: number of effective seqs in local MSA around column i) 
  -pc_hhm_contxt_a  [0,1]        overall pseudocount admixture (def=0.9)                        
  -pc_hhm_contxt_b  [1,inf[      Neff threshold value for mode 2 (def=4.0)                      
  -pc_hhm_contxt_c  [0,3]        extinction exponent c for mode 2 (def=1.0)                     

 Context independent hhm pseudocounts (used for templates; used for query if contxt file is not available):
  -pc_hhm_nocontxt_mode {0,..,3}   position dependence of pc admixture 'tau' (pc mode, default=2) 
               0: no pseudo counts:    tau = 0                                  
               1: constant             tau = a                                  
               2: diversity-dependent: tau = a/(1+((Neff[i]-1)/b)^c)            
               (Neff[i]: number of effective seqs in local MSA around column i) 
  -pc_hhm_nocontxt_a  [0,1]        overall pseudocount admixture (def=1.0)                        
  -pc_hhm_nocontxt_b  [1,inf[      Neff threshold value for mode 2 (def=1.5)                      
  -pc_hhm_nocontxt_c  [0,3]        extinction exponent c for mode 2 (def=1.0)                     

 Context-specific pseudo-counts:                                                  
  -nocontxt      use substitution-matrix instead of context-specific pseudocounts 
  -contxt <file> context file for computing context-specific pseudocounts (default=)
  -csw  [0,inf]  weight of central position in cs pseudocount mode (def=1.6)
  -csb  [0,1]    weight decay parameter for positions in cs pc mode (def=0.9)

Other options:                                                                   
 -v <int>       verbose mode: 0:no screen output  1:only warnings  2: verbose (def=2)
 -cpu <int>     number of CPUs to use (for shared memory SMPs) (default=2)      
 -scores <file> write scores for all pairwise comparisons to file               
 -atab   <file> write all alignments in tabular layout to file                   
 -maxseq <int>  max number of input rows (def=65535)
 -maxres <int>  max number of HMM columns (def=20001)
 -maxmem [1,inf[ limit memory for realignment (in GB) (def=3.0)          

Example: hhsearch -i a.1.1.1.a3m -d scop70_1.71

Download databases from <http://wwwuser.gwdg.de/~compbiol/data/hhsuite/databases/hhsuite_dbs/>.
```


## hhsuite_hhmake

### Tool Description
Build an HMM from an input alignment in A2M, A3M, or FASTA format, or convert between HMMER format (.hmm) and HHsearch format (.hhm).

### Metadata
- **Docker Image**: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
- **Homepage**: https://github.com/soedinglab/hh-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/hhsuite/overview
- **Validation**: PASS

### Original Help Text
```text
HHmake 3.3.0
Build an HMM from an input alignment in A2M, A3M, or FASTA format,
or convert between HMMER format (.hmm) and HHsearch format (.hhm).
Steinegger M, Meier M, Mirdita M, Vöhringer H, Haunsberger S J, and Söding J (2019)
HH-suite3 for fast remote homology detection and deep protein annotation.
BMC Bioinformatics, doi:10.1186/s12859-019-3019-7
(c) The HH-suite development team

Usage: hhmake -i <file> -o <file> [options]
 -i <file>     query alignment (A2M, A3M, or FASTA), or query HMM         

<file> may be 'stdin' or 'stdout' throughout.

Output options:                                                           
 -o <file>     HMM file to be written to  (default=<infile.hhm>)          
 -a <file>     HMM file to be appended to                                 
 -v <int>      verbose mode: 0:no screen output  1:only warings  2: verbose
 -seq <int>    max. number of query/template sequences displayed (def=10)  
               Beware of overflows! All these sequences are stored in memory.
 -add_cons     make consensus sequence master sequence of query MSA 
 -name <name>  use this name for HMM (default: use name of first sequence)   

Filter query multiple sequence alignment                                     
 -id   [0,100]  maximum pairwise sequence identity (%) (def=90)   
 -diff [0,inf[  filter MSA by selecting most diverse set of sequences, keeping 
                at least this many seqs in each MSA block of length 50 (def=100) 
 -cov  [0,100]  minimum coverage with query (%) (def=0) 
 -qid  [0,100]  minimum sequence identity with query (%) (def=0) 
 -qsc  [0,100]  minimum score per column with query  (def=-20.0)
 -neff [1,inf]  target diversity of alignment (default=off)

Input alignment format:                                                    
 -M a2m        use A2M/A3M (default): upper case = Match; lower case = Insert;
               '-' = Delete; '.' = gaps aligned to inserts (may be omitted)   
 -M first      use FASTA: columns with residue in 1st sequence are match states
 -M [0,100]    use FASTA: columns with fewer than X% gaps are match states   

Pseudocount (pc) options:                                                        
 Context specific hhm pseudocounts:
  -pc_hhm_contxt_mode {0,..,3}   position dependence of pc admixture 'tau' (pc mode, default=0) 
               0: no pseudo counts:    tau = 0                                  
               1: constant             tau = a                                  
               2: diversity-dependent: tau = a/(1+((Neff[i]-1)/b)^c)            
               3: CSBlast admixture:   tau = a(1+b)/(Neff[i]+b)                 
               (Neff[i]: number of effective seqs in local MSA around column i) 
  -pc_hhm_contxt_a  [0,1]        overall pseudocount admixture (def=0.9)                        
  -pc_hhm_contxt_b  [1,inf[      Neff threshold value for mode 2 (def=4.0)                      
  -pc_hhm_contxt_c  [0,3]        extinction exponent c for mode 2 (def=1.0)                     

 Context independent hhm pseudocounts (used for templates; used for query if contxt file is not available):
  -pc_hhm_nocontxt_mode {0,..,3}   position dependence of pc admixture 'tau' (pc mode, default=2) 
               0: no pseudo counts:    tau = 0                                  
               1: constant             tau = a                                  
               2: diversity-dependent: tau = a/(1+((Neff[i]-1)/b)^c)            
               (Neff[i]: number of effective seqs in local MSA around column i) 
  -pc_hhm_nocontxt_a  [0,1]        overall pseudocount admixture (def=1.0)                        
  -pc_hhm_nocontxt_b  [1,inf[      Neff threshold value for mode 2 (def=1.5)                      
  -pc_hhm_nocontxt_c  [0,3]        extinction exponent c for mode 2 (def=1.0)                     

 Context-specific pseudo-counts:                                                  
  -nocontxt      use substitution-matrix instead of context-specific pseudocounts 
  -contxt <file> context file for computing context-specific pseudocounts (default=)

Other options:
 -maxseq <int>  max number of input rows (def=65535)
 -maxres <int>  max number of HMM columns (def=20001)

Example: hhmake -i test.a3m -o stdout
```


## hhsuite_hhalign

### Tool Description
Align a query alignment/HMM to a template alignment/HMM by HMM-HMM alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
- **Homepage**: https://github.com/soedinglab/hh-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/hhsuite/overview
- **Validation**: PASS

### Original Help Text
```text
HHalign 3.3.0
Align a query alignment/HMM to a template alignment/HMM by HMM-HMM alignment
If only one alignment/HMM is given it is compared to itself and the best
off-diagonal alignment plus all further non-overlapping alignments above 
significance threshold are shown.
Steinegger M, Meier M, Mirdita M, Vöhringer H, Haunsberger S J, and Söding J (2019)
HH-suite3 for fast remote homology detection and deep protein annotation.
BMC Bioinformatics, doi:10.1186/s12859-019-3019-7
(c) The HH-suite development team

Usage: hhalign -i query -t template [options]  
 -i <file>      input/query: single sequence or multiple sequence alignment (MSA)
                in a3m, a2m, or FASTA format, or HMM in hhm format
 -t <file>      input/template: single sequence or multiple sequence alignment (MSA)
                in a3m, a2m, or FASTA format, or HMM in hhm format

Input alignment format:                                                       
 -M a2m         use A2M/A3M (default): upper case = Match; lower case = Insert;
               '-' = Delete; '.' = gaps aligned to inserts (may be omitted)   
 -M first       use FASTA: columns with residue in 1st sequence are match states
 -M [0,100]     use FASTA: columns with fewer than X% gaps are match states   
 -tags/-notags  do NOT / do neutralize His-, C-myc-, FLAG-tags, and trypsin 
                recognition sequence to background distribution (def=-notags)  

Output options: 
 -o <file>      write results in standard format to file (default=<infile.hhr>)
 -oa3m <file>   write query alignment in a3m or PSI-BLAST format (-opsi) to file (default=none)
 -aa3m <file>   append query alignment in a3m (-aa3m) or PSI-BLAST format (-apsi )to file (default=none)
 -Ofas <file>   write pairwise alignments in FASTA xor A2M (-Oa2m) xor A3M (-Oa3m) format   
 -add_cons      generate consensus sequence as master sequence of query MSA (default=don't)
 -hide_cons     don't show consensus sequence in alignments (default=show)     
 -hide_pred     don't show predicted 2ndary structure in alignments (default=show)
 -hide_dssp     don't show DSSP 2ndary structure in alignments (default=show)  
 -show_ssconf   show confidences for predicted 2ndary structure in alignments

Filter options applied to query MSA, template MSA, and result MSA              
 -id   [0,100]  maximum pairwise sequence identity (def=90)
 -diff [0,inf[  filter MSAs by selecting most diverse set of sequences, keeping 
                at least this many seqs in each MSA block of length 50 
                Zero and non-numerical values turn off the filtering. (def=100) 
 -cov  [0,100]  minimum coverage with master sequence (%) (def=0)             
 -qid  [0,100]  minimum sequence identity with master sequence (%) (def=0)    
 -qsc  [0,100]  minimum score per column with master sequence (default=-20.0)    
 -mark          do not filter out sequences marked by ">@"in their name line  

HMM-HMM alignment options:                                                       
 -norealign     do NOT realign displayed hits with MAC algorithm (def=realign)   
 -mact [0,1[    posterior prob threshold for MAC realignment controlling greedi- 
                ness at alignment ends: 0:global >0.1:local (default=0.35)       
 -glob/-loc     use global/local alignment mode for searching/ranking (def=local)

Other options:                                                                   
 -v <int>       verbose mode: 0:no screen output  1:only warings  2: verbose (def=2)

An extended list of options can be obtained by calling 'hhalign -h all'
Example: hhalign -i T0187.a3m -t d1hz4a_.hhm -o result.hhr
```


## hhsuite_hhfilter

### Tool Description
Filter an alignment by maximum pairwise sequence identity, minimum coverage, minimum sequence identity, or score per column to the first (seed) sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
- **Homepage**: https://github.com/soedinglab/hh-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/hhsuite/overview
- **Validation**: PASS

### Original Help Text
```text
HHfilter 3.3.0
Filter an alignment by maximum pairwise sequence identity, minimum coverage,
minimum sequence identity, or score per column to the first (seed) sequence.n(c) The HH-suite development team
Steinegger M, Meier M, Mirdita M, Vöhringer H, Haunsberger S J, and Söding J (2019)
HH-suite3 for fast remote homology detection and deep protein annotation.
BMC Bioinformatics, doi:10.1186/s12859-019-3019-7

Usage: hhfilter -i infile -o outfile [options]
 -i <file>      read input file in A3M/A2M or FASTA format                 
 -o <file>      write to output file in A3M format                         
 -a <file>      append to output file in A3M format                        

Options:                                                                  
 -v <int>       verbose mode: 0:no screen output  1:only warings  2: verbose
 -id   [0,100]  maximum pairwise sequence identity (%) (def=90)   
 -diff [0,inf[  filter MSA by selecting most diverse set of sequences, keeping 
                at least this many seqs in each MSA block of length 50 (def=0) 
 -cov  [0,100]  minimum coverage with query (%) (def=0) 
 -qid  [0,100]  minimum sequence identity with query (%) (def=0) 
 -qsc  [0,100]  minimum score per column with query  (def=-20.0)
 -neff [1,inf]  target diversity of alignment (default=off)

Input alignment format:                                                    
 -M a2m         use A2M/A3M (default): upper case = Match; lower case = Insert;
                '-' = Delete; '.' = gaps aligned to inserts (may be omitted)   
 -M first       use FASTA: columns with residue in 1st sequence are match states
 -M [0,100]     use FASTA: columns with fewer than X% gaps are match states   
                                                                          
Other options:
 -maxseq <int>  max number of input rows (def=65535)
 -maxres <int>  max number of HMM columns (def=20001)
Example: hhfilter -id 50 -i d1mvfd_.a2m -o d1mvfd_.fil.a2m
```


## hhsuite_reformat.pl

### Tool Description
Read a multiple alignment in one format and write it in another format

### Metadata
- **Docker Image**: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
- **Homepage**: https://github.com/soedinglab/hh-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/hhsuite/overview
- **Validation**: PASS

### Original Help Text
```text
reformat.pl from HHsuite3
Read a multiple alignment in one format and write it in another format
Usage: reformat.pl [informat] [outformat] infile outfile [options] 
  or   reformat.pl [informat] [outformat] 'fileglob' .ext [options] 

Available input formats:
   fas:     aligned fasta; lower and upper case equivalent, '.' and '-' equivalent
   a2m:     aligned fasta; inserts: lower case, matches: upper case, deletes: '-',
            gaps aligned to inserts: '.'
   a3m:     like a2m, but gaps aligned to inserts MAY be omitted
   sto:     Stockholm format; sequences in several blocks with sequence name at 
            beginning of line (hmmer output)
   psi:     format as read by PSI-BLAST using the -B option (like sto with -M first -r)
   clu:     Clustal format; sequences in several blocks with sequence name at beginning 
            of line
Available output formats:
   fas:     aligned fasta; all gaps '-'
   a2m:     aligned fasta; inserts: lower case, matches: upper case, deletes: '-', gaps 
            aligned to inserts: '.'
   a3m:     like a2m, but gaps aligned to inserts are omitted
   sto:     Stockholm format; sequences in just one block, one line per sequence
   psi:     format as read by PSI-BLAST using the -B option 
   clu:     Clustal format
If no input or output format is given the file extension is interpreted as format 
specification ('aln' as 'clu')

Options:
  -v int    verbose mode (0:off, 1:on)
  -num      add number prefix to sequence names: 'name', '1:name' '2:name' etc
  -noss     remove secondary structure sequences (beginning with >ss_)
  -sa       do not remove solvent accessibility sequences (beginning with >sa_)
  -M first  make all columns with residue in first sequence match columns 
            (default for output format a2m or a3m)
  -M int    make all columns with less than X% gaps match columns 
            (for output format a2m or a3m)
  -r        remove all lower case residues (insert states) 
            (AFTER -M option has been processed)
  -r int    remove all lower case columns with more than X% gaps
  -g ''     suppress all gaps
  -g '-'    write all gaps as '-'
  -uc       write all residues in upper case (AFTER all other options have been processed)
  -lc       write all residues in lower case (AFTER all other options have been processed)
  -l        number of residues per line (for Clustal, FASTA, A2M, A3M formats) 
            (default=100)
  -d        maximum number of characers in nameline (default=1000)

Examples: reformat.pl 1hjra.a3m 1hjra.a2m  
          (same as reformat.pl a3m a2m 1hjra.a3m 1hjra.a2m)
          reformat.pl test.a3m test.fas -num -r 90
          reformat.pl fas sto '*.fasta' .stockholm
```

