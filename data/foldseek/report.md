# foldseek CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| foldseek_cluster | PASS | clustered the 12 chains; identical chains and the serine proteases grouped together |
| foldseek_convertalis | PASS | converted the search result to a table with TM-score and LDDT columns; values match the search |
| foldseek_createdb | PASS | 5 RCSB serine protease PDB files gave a 12-chain database with sequence, 3Di, C-alpha and header files |
| foldseek_createindex | PASS | built the k-mer index files for the 5-structure database; the index is about 900 MB because of the fixed k-mer table |
| foldseek_createtsv | PASS | cluster database written as a table, with and without the optional target database |
| foldseek_easy-cluster | PASS | serine proteases clustered together; directory input allowed |
| foldseek_easy-multimercluster | PASS | 5PTP and 2PTN clustered together; directory input allowed |
| foldseek_easy-multimersearch | PASS | same five RCSB structures; added the missing output positional and directory targets |
| foldseek_easy-rbh | PASS | same five RCSB structures; added the missing output positional and directory targets |
| foldseek_easy-search | PASS | searched RCSB serine protease structures against each other; self hits and homologs found; added the missing output positional and directory targets |
| foldseek_rbh | PASS | 2 query structures against 5PTP; the reciprocal best hit 1HNE_E to 5PTP found |
| foldseek_result2msa | PASS | built an aligned FASTA database from the search result; serine protease sequences aligned |
| foldseek_search | PASS | searched the 5-structure database against itself; self hits and trypsin/chymotrypsin homologs found (5PTP and 2PTN at 99.5 percent identity) |
| foldseek_structurealign | PASS | aligned the pairs listed in a search result database; scores match the search |
| foldseek_tmalign | PASS | TM-aligned the pairs listed in a search result database; self TM-score 1.0 and trypsin pairs high |

## foldseek_easy-search

### Tool Description
By Martin Steinegger <martin.steinegger@snu.ac.kr>

### Metadata
- **Docker Image**: quay.io/biocontainers/foldseek:10.941cd33--h5021889_1
- **Homepage**: https://github.com/steineggerlab/foldseek
- **Package**: https://anaconda.org/channels/bioconda/packages/foldseek/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/foldseek/overview
- **Total Downloads**: 377.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/steineggerlab/foldseek
- **Stars**: N/A
### Original Help Text
```text
usage: foldseek easy-search <i:PDB|mmCIF[.gz]> ... <i:PDB|mmCIF[.gz]>|<i:stdin> <i:targetFastaFile[.gz]>|<i:targetDB> <o:alignmentFile> <tmpDir> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                     
 --comp-bias-corr INT            Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT    Correct for locally biased amino acid composition (range 0-1) [1.000]
 --seed-sub-mat TWIN             Substitution matrix file for k-mer generation [aa:3di.out,nucl:3di.out]
 -s FLOAT                        Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [9.500]
 -k INT                          k-mer length (0: automatically set to optimum) [6]
 --target-search-mode INT        target search mode (0: regular k-mer, 1: similar k-mer) [0]
 --k-score TWIN                  k-mer threshold for generating similar k-mer lists [seq:2147483647,prof:2147483647]
 --max-seqs INT                  Maximum results per query sequence allowed to pass the prefilter (affects sensitivity) [1000]
 --split INT                     Split input into N equally distributed chunks. 0: set the best split automatically [0]
 --split-mode INT                0: split target db; 1: split query db; 2: auto, depending on main memory [2]
 --split-memory-limit BYTE       Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
 --diag-score BOOL               Use ungapped diagonal scoring during prefilter [1]
 --exact-kmer-matching INT       Extract only exact k-mers for matching (range 0-1) [0]
 --mask INT                      Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [0]
 --mask-prob FLOAT               Mask sequences is probablity is above threshold [1.000]
 --mask-lower-case INT           Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [1]
 --mask-n-repeat INT             Repeat letters that occure > threshold in a rwo [6]
 --min-ungapped-score INT        Accept only matches with ungapped alignment score above threshold [30]
 --spaced-kmer-mode INT          0: use consecutive positions in k-mers; 1: use spaced k-mers [1]
 --spaced-kmer-pattern STR       User-specified spaced k-mer pattern []
 --local-tmp STR                 Path where some of the temporary files will be created []
 --exhaustive-search BOOL        Turns on an exhaustive all vs all search by by passing the prefilter step [0]
align:                         
 --min-seq-id FLOAT              List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 -c FLOAT                        List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --cov-mode INT                  0: coverage of query and target
                                 1: coverage of target
                                 2: coverage of query
                                 3: target seq. length has to be at least x% of query length
                                 4: query seq. length has to be at least x% of target length
                                 5: short seq. needs to be at least x% of the other seq. length [0]
 --max-rejected INT              Maximum rejected alignments before alignment calculation for a query is stopped [2147483647]
 --max-accept INT                Maximum accepted alignments before alignment calculation for a query is stopped [2147483647]
 -a BOOL                         Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --sort-by-structure-bits INT    sort by bits*sqrt(alnlddt*alntmscore) [1]
 --alignment-mode INT            How to compute the alignment:
                                 0: automatic
                                 1: only score and end_pos
                                 2: also start_pos and cov
                                 3: also seq.id [3]
 --alignment-output-mode INT     How to compute the alignment:
                                 0: automatic
                                 1: only score and end_pos
                                 2: also start_pos and cov
                                 3: also seq.id
                                 4: only ungapped alignment
                                 5: score only (output) cluster format [0]
 -e DOUBLE                       List matches below this E-value (range 0.0-inf) [1.000E+01]
 --min-aln-len INT               Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT               0: alignment length 1: shorter, 2: longer sequence [0]
 --alt-ali INT                   Show up to this many alternative alignments [0]
 --gap-open TWIN                 Gap open cost [aa:10,nucl:10]
 --gap-extend TWIN               Gap extension cost [aa:1,nucl:1]
profile:                       
 --num-iterations INT            Number of iterative profile search iterations [1]
misc:                          
 --tmscore-threshold FLOAT       accept alignments with a tmsore > thr [0.0,1.0] [0.000]
 --tmscore-threshold-mode INT    0: alignment, 1: query 2: target length [0]
 --tmalign-hit-order INT         order hits by 0: (qTM+tTM)/2, 1: qTM, 2: tTM, 3: min(qTM,tTM) 4: max(qTM,tTM) [0]
 --tmalign-fast INT              turn on fast search in TM-align [1]
 --lddt-threshold FLOAT          accept alignments with a lddt > thr [0.0,1.0] [0.000]
 --alignment-type INT            How to compute the alignment:
                                 0: 3di alignment
                                 1: TM alignment
                                 2: 3Di+AA [2]
 --exact-tmscore INT             turn on fast exact TMscore (slow), default is approximate [0]
 --prefilter-mode INT            prefilter mode: 0: kmer/ungapped 1: ungapped, 2: nofilter, 3: ungapped&gapped [0]
 --cluster-search INT            first find representative then align all cluster members [0]
 --db-extraction-mode INT        createdb extraction mode: 0: chain 1: interface [0]
 --distance-threshold FLOAT      Residues with C-beta below this threshold will be part of interface [8.000]
 --mask-bfactor-threshold FLOAT  mask residues for seeding if b-factor < thr [0,100] [0.000]
 --input-format INT              Format of input structures:
                                 0: Auto-detect by extension
                                 1: PDB
                                 2: mmCIF
                                 3: mmJSON
                                 4: ChemComp
                                 5: Foldcomp [0]
 --file-include STR              Include file names based on this regex [.*]
 --file-exclude STR              Exclude file names based on this regex [^$]
 --format-mode INT               Output format:
                                 0: BLAST-TAB
                                 1: SAM
                                 2: BLAST-TAB + query/db length
                                 3: Pretty HTML
                                 4: BLAST-TAB + column headers
                                 5: Calpha only PDB super-posed to query
                                 BLAST-TAB (0) and BLAST-TAB + column headers (4)support custom output formats (--format-output)
                                 (5) Superposed PDB files (Calpha only) [0]
 --format-output STR             Choose comma separated list of output columns from: query,target,evalue,gapopen,pident,fident,nident,qstart,qend,qlen
                                 tstart,tend,tlen,alnlen,raw,bits,cigar,qseq,tseq,qheader,theader,qaln,taln,mismatch,qcov,tcov
                                 qset,qsetid,tset,tsetid,taxid,taxname,taxlineage,
                                 lddt,lddtfull,qca,tca,t,u,qtmscore,ttmscore,alntmscore,rmsd,prob
                                 complexqtmscore,complexttmscore,complexu,complext,complexassignid
                                  [query,target,fident,alnlen,mismatch,gapopen,qstart,qend,tstart,tend,evalue,bits]
 --report-mode INT               Taxonomy report mode 0: Kraken 1: Krona 2: Skip taxonomy report [2]
 --greedy-best-hits BOOL         Choose the best hits greedily to cover the query [0]
common:                        
 --db-load-mode INT              Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                   Number of CPU-cores used (all by default) [20]
 -v INT                          Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --sub-mat TWIN                  Substitution matrix file [aa:3di.out,nucl:3di.out]
 --max-seq-len INT               Maximum sequence length [65535]
 --compressed INT                Write compressed output [0]
 --gpu INT                       Use GPU (CUDA) if possible [0]
 --gpu-server INT                Use GPU server [0]
 --gpu-server-wait-timeout INT   Wait for GPU server for 0: don't wait -1: no wait limit: >0 this many seconds [600]
 --remove-tmp-files BOOL         Delete temporary files [1]
 --mpi-runner STR                Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42") []
 --force-reuse BOOL              Reuse tmp filse in tmp/latest folder ignoring parameters and version changes [0]
 --prostt5-model STR             Path to ProstT5 model []
expert:                        
 --zdrop INT                     Maximal allowed difference between score values before alignment is truncated  (nucleotide alignment only) [40]
 --taxon-list STR                Taxonomy ID, possibly multiple values separated by ',' []
 --chain-name-mode INT           Add chain to name:
                                 0: auto
                                 1: always add
                                  [0]
 --write-mapping INT             write _mapping file containing mapping from internal id to taxonomic identifier [0]
 --coord-store-mode INT          Coordinate storage mode: 
                                 1: C-alpha as float
                                 2: C-alpha as difference (uint16_t) [2]
 --write-lookup INT              write .lookup file containing mapping from internal id, fasta id and file number [1]
 --db-output BOOL                Return a result DB instead of a text file [0]

examples:
 # Search a single/multiple PDB file against a set of PDB files
 foldseek easy-search examples/d1asha_ examples/ result.m8 tmp
 # Format output differently
 foldseek easy-search examples/d1asha_ examples/ result.m8 tmp --format-output query,target,qstart,tstart,cigar
 # Align with TMalign (global)
 foldseek easy-search examples/d1asha_ examples/ result.m8 tmp --alignment-type 1
 # Skip prefilter and perform an exhaustive alignment (slower but more sensitive)
 foldseek easy-search examples/d1asha_ examples/ result.m8 tmp --exhaustive-search 1
 
 
references:
 - van Kempen, M., Kim, S.S., Tumescheit, C., Mirdita, M., Lee, J., Gilchrist, C.L.M., Söding, J., and Steinegger, M. Fast and accurate protein structure search with Foldseek. Nature Biotechnology, doi:10.1038/s41587-023-01773-0 (2023)
```


## foldseek_easy-cluster

### Tool Description
By Martin Steinegger <martin.steinegger@snu.ac.kr>

### Metadata
- **Docker Image**: quay.io/biocontainers/foldseek:10.941cd33--h5021889_1
- **Homepage**: https://github.com/steineggerlab/foldseek
- **Package**: https://anaconda.org/channels/bioconda/packages/foldseek/overview
- **Validation**: PASS

### Original Help Text
```text
usage: foldseek easy-cluster <i:PDB|mmCIF[.gz]> ... <i:PDB|mmCIF[.gz]> <o:clusterPrefix> <tmpDir> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                      
 --seed-sub-mat TWIN              Substitution matrix file for k-mer generation [aa:3di.out,nucl:3di.out]
 -s FLOAT                         Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [4.000]
 -k INT                           k-mer length (0: automatically set to optimum) [0]
 --target-search-mode INT         target search mode (0: regular k-mer, 1: similar k-mer) [0]
 --k-score TWIN                   k-mer threshold for generating similar k-mer lists [seq:2147483647,prof:2147483647]
 --max-seqs INT                   Maximum results per query sequence allowed to pass the prefilter (affects sensitivity) [300]
 --split INT                      Split input into N equally distributed chunks. 0: set the best split automatically [0]
 --split-mode INT                 0: split target db; 1: split query db; 2: auto, depending on main memory [2]
 --split-memory-limit BYTE        Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
 --comp-bias-corr INT             Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT     Correct for locally biased amino acid composition (range 0-1) [1.000]
 --diag-score BOOL                Use ungapped diagonal scoring during prefilter [1]
 --exact-kmer-matching INT        Extract only exact k-mers for matching (range 0-1) [0]
 --mask INT                       Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [0]
 --mask-prob FLOAT                Mask sequences is probablity is above threshold [1.000]
 --mask-lower-case INT            Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [1]
 --mask-n-repeat INT              Repeat letters that occure > threshold in a rwo [6]
 --min-ungapped-score INT         Accept only matches with ungapped alignment score above threshold [30]
 --spaced-kmer-mode INT           0: use consecutive positions in k-mers; 1: use spaced k-mers [1]
 --spaced-kmer-pattern STR        User-specified spaced k-mer pattern []
 --local-tmp STR                  Path where some of the temporary files will be created []
align:                          
 -c FLOAT                         List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --cov-mode INT                   0: coverage of query and target
                                  1: coverage of target
                                  2: coverage of query
                                  3: target seq. length has to be at least x% of query length
                                  4: query seq. length has to be at least x% of target length
                                  5: short seq. needs to be at least x% of the other seq. length [0]
 --sort-by-structure-bits INT     sort by bits*sqrt(alnlddt*alntmscore) [1]
 -a BOOL                          Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --alignment-mode INT             How to compute the alignment:
                                  0: automatic
                                  1: only score and end_pos
                                  2: also start_pos and cov
                                  3: also seq.id [0]
 --alignment-output-mode INT      How to compute the alignment:
                                  0: automatic
                                  1: only score and end_pos
                                  2: also start_pos and cov
                                  3: also seq.id
                                  4: only ungapped alignment
                                  5: score only (output) cluster format [0]
 -e DOUBLE                        List matches below this E-value (range 0.0-inf) [1.000E+01]
 --min-seq-id FLOAT               List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 --min-aln-len INT                Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT                0: alignment length 1: shorter, 2: longer sequence [0]
 --alt-ali INT                    Show up to this many alternative alignments [0]
 --max-rejected INT               Maximum rejected alignments before alignment calculation for a query is stopped [2147483647]
 --max-accept INT                 Maximum accepted alignments before alignment calculation for a query is stopped [2147483647]
 --gap-open TWIN                  Gap open cost [aa:10,nucl:10]
 --gap-extend TWIN                Gap extension cost [aa:1,nucl:1]
clust:                          
 --cluster-mode INT               0: Set-Cover (greedy)
                                  1: Connected component (BLASTclust)
                                  2,3: Greedy clustering by sequence length (CDHIT) [0]
 --max-iterations INT             Maximum depth of breadth first search in connected component clustering [1000]
 --similarity-type INT            Type of score used for clustering. 1: alignment score 2: sequence identity [2]
 --single-step-clustering BOOL    Switch from cascaded to simple clustering workflow [0]
 --cluster-steps INT              Cascaded clustering steps from 1 to -s [3]
 --cluster-reassign BOOL          Cascaded clustering can cluster sequence that do not fulfill the clustering criteria.
                                  Cluster reassignment corrects these errors [0]
kmermatcher:                    
 --weights STR                    Weights used for cluster priorization []
 --cluster-weight-threshold FLOAT Weight threshold used for cluster priorization [0.900]
 --kmer-per-seq INT               k-mers per sequence [21]
 --kmer-per-seq-scale TWIN        Scale k-mer per sequence based on sequence length as kmer-per-seq val + scale x seqlen [aa:0.000,nucl:0.200]
 --adjust-kmer-len BOOL           Adjust k-mer length based on specificity (only for nucleotides) [0]
 --hash-shift INT                 Shift k-mer hash initialization [67]
 --include-only-extendable BOOL   Include only extendable [0]
 --ignore-multi-kmer BOOL         Skip k-mers occurring multiple times (>=2) [0]
misc:                           
 --tmscore-threshold FLOAT        accept alignments with a tmsore > thr [0.0,1.0] [0.000]
 --tmscore-threshold-mode INT     0: alignment, 1: query 2: target length [0]
 --lddt-threshold FLOAT           accept alignments with a lddt > thr [0.0,1.0] [0.000]
 --alignment-type INT             How to compute the alignment:
                                  0: 3di alignment
                                  1: TM alignment
                                  2: 3Di+AA [2]
 --exact-tmscore INT              turn on fast exact TMscore (slow), default is approximate [0]
 --tmalign-hit-order INT          order hits by 0: (qTM+tTM)/2, 1: qTM, 2: tTM, 3: min(qTM,tTM) 4: max(qTM,tTM) [0]
 --tmalign-fast INT               turn on fast search in TM-align [1]
 --rescore-mode INT               Rescore diagonals with:
                                  0: Hamming distance
                                  1: local alignment (score only)
                                  2: local alignment
                                  3: global alignment
                                  4: longest alignment fulfilling window quality criterion [0]
 --db-extraction-mode INT         createdb extraction mode: 0: chain 1: interface [0]
 --distance-threshold FLOAT       Residues with C-beta below this threshold will be part of interface [8.000]
 --mask-bfactor-threshold FLOAT   mask residues for seeding if b-factor < thr [0,100] [0.000]
 --input-format INT               Format of input structures:
                                  0: Auto-detect by extension
                                  1: PDB
                                  2: mmCIF
                                  3: mmJSON
                                  4: ChemComp
                                  5: Foldcomp [0]
 --file-include STR               Include file names based on this regex [.*]
 --file-exclude STR               Exclude file names based on this regex [^$]
common:                         
 --sub-mat TWIN                   Substitution matrix file [aa:3di.out,nucl:3di.out]
 --max-seq-len INT                Maximum sequence length [65535]
 --db-load-mode INT               Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                    Number of CPU-cores used (all by default) [20]
 --compressed INT                 Write compressed output [0]
 -v INT                           Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --remove-tmp-files BOOL          Delete temporary files [1]
 --force-reuse BOOL               Reuse tmp filse in tmp/latest folder ignoring parameters and version changes [0]
 --mpi-runner STR                 Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42") []
 --gpu INT                        Use GPU (CUDA) if possible [0]
 --prostt5-model STR              Path to ProstT5 model []
expert:                         
 --taxon-list STR                 Taxonomy ID, possibly multiple values separated by ',' []
 --zdrop INT                      Maximal allowed difference between score values before alignment is truncated  (nucleotide alignment only) [40]
 --filter-hits BOOL               Filter hits by seq.id. and coverage [0]
 --sort-results INT               Sort results: 0: no sorting, 1: sort by E-value (Alignment) or seq.id. (Hamming) [0]
 --chain-name-mode INT            Add chain to name:
                                  0: auto
                                  1: always add
                                   [0]
 --write-mapping INT              write _mapping file containing mapping from internal id to taxonomic identifier [0]
 --coord-store-mode INT           Coordinate storage mode: 
                                  1: C-alpha as float
                                  2: C-alpha as difference (uint16_t) [2]
 --write-lookup INT               write .lookup file containing mapping from internal id, fasta id and file number [1]

examples:
 foldseek easy-cluster examples/ result tmp
 # Cluster output
 #  - result_rep_seq.fasta: Representatives
 #  - result_all_seq.fasta: FASTA-like per cluster
 #  - result_cluster.tsv:   Adjacency list
 
 # Important parameter: --min-seq-id, --cov-mode and -c 
 #                  --cov-mode 
 #                  0    1    2
 # Q: MAVGTACRPA  60%  IGN  60%
 # T: -AVGTAC---  60% 100%  IGN
 #        -c 0.7    -    +    -
 #        -c 0.6    +    +    +
 
 
references:
 - van Kempen, M., Kim, S.S., Tumescheit, C., Mirdita, M., Lee, J., Gilchrist, C.L.M., Söding, J., and Steinegger, M. Fast and accurate protein structure search with Foldseek. Nature Biotechnology, doi:10.1038/s41587-023-01773-0 (2023)
```


## foldseek_easy-rbh

### Tool Description
By Eli Levy Karin & Martin Steinegger <martin.steinegger@snu.ac.kr>

### Metadata
- **Docker Image**: quay.io/biocontainers/foldseek:10.941cd33--h5021889_1
- **Homepage**: https://github.com/steineggerlab/foldseek
- **Package**: https://anaconda.org/channels/bioconda/packages/foldseek/overview
- **Validation**: PASS

### Original Help Text
```text
usage: foldseek easy-rbh <i:queryFastaFile1[.gz|.bz2]> <i:targetFastaFile[.gz|.bz2]>|<i:targetDB> <o:alignmentFile> <tmpDir> [options]
 By Eli Levy Karin & Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                     
 --comp-bias-corr INT            Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT    Correct for locally biased amino acid composition (range 0-1) [1.000]
 --seed-sub-mat TWIN             Substitution matrix file for k-mer generation [aa:3di.out,nucl:3di.out]
 -s FLOAT                        Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [4.000]
 -k INT                          k-mer length (0: automatically set to optimum) [0]
 --target-search-mode INT        target search mode (0: regular k-mer, 1: similar k-mer) [0]
 --k-score TWIN                  k-mer threshold for generating similar k-mer lists [seq:2147483647,prof:2147483647]
 --max-seqs INT                  Maximum results per query sequence allowed to pass the prefilter (affects sensitivity) [300]
 --split INT                     Split input into N equally distributed chunks. 0: set the best split automatically [0]
 --split-mode INT                0: split target db; 1: split query db; 2: auto, depending on main memory [2]
 --split-memory-limit BYTE       Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
 --diag-score BOOL               Use ungapped diagonal scoring during prefilter [1]
 --exact-kmer-matching INT       Extract only exact k-mers for matching (range 0-1) [0]
 --mask INT                      Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [0]
 --mask-prob FLOAT               Mask sequences is probablity is above threshold [1.000]
 --mask-lower-case INT           Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [1]
 --mask-n-repeat INT             Repeat letters that occure > threshold in a rwo [6]
 --min-ungapped-score INT        Accept only matches with ungapped alignment score above threshold [30]
 --spaced-kmer-mode INT          0: use consecutive positions in k-mers; 1: use spaced k-mers [1]
 --spaced-kmer-pattern STR       User-specified spaced k-mer pattern []
 --local-tmp STR                 Path where some of the temporary files will be created []
 --exhaustive-search BOOL        Turns on an exhaustive all vs all search by by passing the prefilter step [0]
align:                         
 --min-seq-id FLOAT              List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 -c FLOAT                        List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --cov-mode INT                  0: coverage of query and target
                                 1: coverage of target
                                 2: coverage of query
                                 3: target seq. length has to be at least x% of query length
                                 4: query seq. length has to be at least x% of target length
                                 5: short seq. needs to be at least x% of the other seq. length [0]
 --max-rejected INT              Maximum rejected alignments before alignment calculation for a query is stopped [2147483647]
 --max-accept INT                Maximum accepted alignments before alignment calculation for a query is stopped [2147483647]
 -a BOOL                         Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --sort-by-structure-bits INT    sort by bits*sqrt(alnlddt*alntmscore) [1]
 --alignment-mode INT            How to compute the alignment:
                                 0: automatic
                                 1: only score and end_pos
                                 2: also start_pos and cov
                                 3: also seq.id [3]
 --alignment-output-mode INT     How to compute the alignment:
                                 0: automatic
                                 1: only score and end_pos
                                 2: also start_pos and cov
                                 3: also seq.id
                                 4: only ungapped alignment
                                 5: score only (output) cluster format [0]
 -e DOUBLE                       List matches below this E-value (range 0.0-inf) [1.000E+01]
 --min-aln-len INT               Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT               0: alignment length 1: shorter, 2: longer sequence [0]
 --alt-ali INT                   Show up to this many alternative alignments [0]
 --gap-open TWIN                 Gap open cost [aa:10,nucl:10]
 --gap-extend TWIN               Gap extension cost [aa:1,nucl:1]
profile:                       
 --num-iterations INT            Number of iterative profile search iterations [1]
misc:                          
 --tmscore-threshold FLOAT       accept alignments with a tmsore > thr [0.0,1.0] [0.000]
 --tmscore-threshold-mode INT    0: alignment, 1: query 2: target length [0]
 --tmalign-hit-order INT         order hits by 0: (qTM+tTM)/2, 1: qTM, 2: tTM, 3: min(qTM,tTM) 4: max(qTM,tTM) [0]
 --tmalign-fast INT              turn on fast search in TM-align [1]
 --lddt-threshold FLOAT          accept alignments with a lddt > thr [0.0,1.0] [0.000]
 --alignment-type INT            How to compute the alignment:
                                 0: 3di alignment
                                 1: TM alignment
                                 2: 3Di+AA [2]
 --exact-tmscore INT             turn on fast exact TMscore (slow), default is approximate [0]
 --prefilter-mode INT            prefilter mode: 0: kmer/ungapped 1: ungapped, 2: nofilter, 3: ungapped&gapped [0]
 --cluster-search INT            first find representative then align all cluster members [0]
 --db-extraction-mode INT        createdb extraction mode: 0: chain 1: interface [0]
 --distance-threshold FLOAT      Residues with C-beta below this threshold will be part of interface [8.000]
 --mask-bfactor-threshold FLOAT  mask residues for seeding if b-factor < thr [0,100] [0.000]
 --input-format INT              Format of input structures:
                                 0: Auto-detect by extension
                                 1: PDB
                                 2: mmCIF
                                 3: mmJSON
                                 4: ChemComp
                                 5: Foldcomp [0]
 --file-include STR              Include file names based on this regex [.*]
 --file-exclude STR              Exclude file names based on this regex [^$]
 --format-mode INT               Output format:
                                 0: BLAST-TAB
                                 1: SAM
                                 2: BLAST-TAB + query/db length
                                 3: Pretty HTML
                                 4: BLAST-TAB + column headers
                                 5: Calpha only PDB super-posed to query
                                 BLAST-TAB (0) and BLAST-TAB + column headers (4)support custom output formats (--format-output)
                                 (5) Superposed PDB files (Calpha only) [0]
 --format-output STR             Choose comma separated list of output columns from: query,target,evalue,gapopen,pident,fident,nident,qstart,qend,qlen
                                 tstart,tend,tlen,alnlen,raw,bits,cigar,qseq,tseq,qheader,theader,qaln,taln,mismatch,qcov,tcov
                                 qset,qsetid,tset,tsetid,taxid,taxname,taxlineage,
                                 lddt,lddtfull,qca,tca,t,u,qtmscore,ttmscore,alntmscore,rmsd,prob
                                 complexqtmscore,complexttmscore,complexu,complext,complexassignid
                                  [query,target,fident,alnlen,mismatch,gapopen,qstart,qend,tstart,tend,evalue,bits]
 --report-mode INT               Taxonomy report mode 0: Kraken 1: Krona [0]
 --greedy-best-hits BOOL         Choose the best hits greedily to cover the query [0]
common:                        
 --db-load-mode INT              Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                   Number of CPU-cores used (all by default) [20]
 -v INT                          Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --sub-mat TWIN                  Substitution matrix file [aa:3di.out,nucl:3di.out]
 --max-seq-len INT               Maximum sequence length [65535]
 --compressed INT                Write compressed output [0]
 --gpu INT                       Use GPU (CUDA) if possible [0]
 --gpu-server INT                Use GPU server [0]
 --gpu-server-wait-timeout INT   Wait for GPU server for 0: don't wait -1: no wait limit: >0 this many seconds [600]
 --remove-tmp-files BOOL         Delete temporary files [1]
 --mpi-runner STR                Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42") []
 --force-reuse BOOL              Reuse tmp filse in tmp/latest folder ignoring parameters and version changes [0]
 --prostt5-model STR             Path to ProstT5 model []
expert:                        
 --pca                           Pseudo count admixture strength []
 --pcb                           Pseudo counts: Neff at half of maximum admixture (range 0.0-inf) []
 --zdrop INT                     Maximal allowed difference between score values before alignment is truncated  (nucleotide alignment only) [40]
 --taxon-list STR                Taxonomy ID, possibly multiple values separated by ',' []
 --chain-name-mode INT           Add chain to name:
                                 0: auto
                                 1: always add
                                  [0]
 --write-mapping INT             write _mapping file containing mapping from internal id to taxonomic identifier [0]
 --coord-store-mode INT          Coordinate storage mode: 
                                 1: C-alpha as float
                                 2: C-alpha as difference (uint16_t) [2]
 --write-lookup INT              write .lookup file containing mapping from internal id, fasta id and file number [0]
 --translation-table INT         1) CANONICAL, 2) VERT_MITOCHONDRIAL, 3) YEAST_MITOCHONDRIAL, 4) MOLD_MITOCHONDRIAL, 5) INVERT_MITOCHONDRIAL, 6) CILIATE
                                 9) FLATWORM_MITOCHONDRIAL, 10) EUPLOTID, 11) PROKARYOTE, 12) ALT_YEAST, 13) ASCIDIAN_MITOCHONDRIAL, 14) ALT_FLATWORM_MITOCHONDRIAL
                                 15) BLEPHARISMA, 16) CHLOROPHYCEAN_MITOCHONDRIAL, 21) TREMATODE_MITOCHONDRIAL, 22) SCENEDESMUS_MITOCHONDRIAL
                                 23) THRAUSTOCHYTRIUM_MITOCHONDRIAL, 24) PTEROBRANCHIA_MITOCHONDRIAL, 25) GRACILIBACTERIA, 26) PACHYSOLEN, 27) KARYORELICT, 28) CONDYLOSTOMA
                                  29) MESODINIUM, 30) PERTRICH, 31) BLASTOCRITHIDIA [1]
 --db-output BOOL                Return a result DB instead of a text file [0]

examples:
 # Assign reciprocal best hit
 mmseqs easy-rbh examples/QUERY.fasta examples/DB.fasta result tmp
 
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```


## foldseek_easy-multimercluster

### Tool Description
By Seongeun Kim <seamustard52@gmail.com> & Sooyoung Cha <ellen2g77@gmail.com>

### Metadata
- **Docker Image**: quay.io/biocontainers/foldseek:10.941cd33--h5021889_1
- **Homepage**: https://github.com/steineggerlab/foldseek
- **Package**: https://anaconda.org/channels/bioconda/packages/foldseek/overview
- **Validation**: PASS

### Original Help Text
```text
usage: foldseek easy-multimercluster <i:PDB|mmCIF[.gz]> ... <i:PDB|mmCIF[.gz]> <o:clusterPrefix> <tmpDir> [options]
 By Seongeun  Kim <seamustard52@gmail.com> & Sooyoung Cha <ellen2g77@gmail.com>
options: prefilter:                       
 --comp-bias-corr INT              Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT      Correct for locally biased amino acid composition (range 0-1) [1.000]
 --seed-sub-mat TWIN               Substitution matrix file for k-mer generation [aa:3di.out,nucl:3di.out]
 -s FLOAT                          Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [4.000]
 -k INT                            k-mer length (0: automatically set to optimum) [0]
 --target-search-mode INT          target search mode (0: regular k-mer, 1: similar k-mer) [0]
 --k-score TWIN                    k-mer threshold for generating similar k-mer lists [seq:2147483647,prof:2147483647]
 --max-seqs INT                    Maximum results per query sequence allowed to pass the prefilter (affects sensitivity) [300]
 --split INT                       Split input into N equally distributed chunks. 0: set the best split automatically [0]
 --split-mode INT                  0: split target db; 1: split query db; 2: auto, depending on main memory [2]
 --split-memory-limit BYTE         Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
 --diag-score BOOL                 Use ungapped diagonal scoring during prefilter [1]
 --exact-kmer-matching INT         Extract only exact k-mers for matching (range 0-1) [0]
 --mask INT                        Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [0]
 --mask-prob FLOAT                 Mask sequences is probablity is above threshold [1.000]
 --mask-lower-case INT             Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [1]
 --mask-n-repeat INT               Repeat letters that occure > threshold in a rwo [6]
 --min-ungapped-score INT          Accept only matches with ungapped alignment score above threshold [30]
 --spaced-kmer-mode INT            0: use consecutive positions in k-mers; 1: use spaced k-mers [1]
 --spaced-kmer-pattern STR         User-specified spaced k-mer pattern []
 --local-tmp STR                   Path where some of the temporary files will be created []
 --exhaustive-search BOOL          Turns on an exhaustive all vs all search by by passing the prefilter step [0]
align:                           
 --min-seq-id FLOAT                List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 -c FLOAT                          List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --cov-mode INT                    0: coverage of query and target
                                   1: coverage of target
                                   2: coverage of query
                                   3: target seq. length has to be at least x% of query length
                                   4: query seq. length has to be at least x% of target length
                                   5: short seq. needs to be at least x% of the other seq. length [0]
 --max-rejected INT                Maximum rejected alignments before alignment calculation for a query is stopped [2147483647]
 --max-accept INT                  Maximum accepted alignments before alignment calculation for a query is stopped [2147483647]
 -a BOOL                           Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --sort-by-structure-bits INT      sort by bits*sqrt(alnlddt*alntmscore) [1]
 --alignment-mode INT              How to compute the alignment:
                                   0: automatic
                                   1: only score and end_pos
                                   2: also start_pos and cov
                                   3: also seq.id [0]
 --alignment-output-mode INT       How to compute the alignment:
                                   0: automatic
                                   1: only score and end_pos
                                   2: also start_pos and cov
                                   3: also seq.id
                                   4: only ungapped alignment
                                   5: score only (output) cluster format [0]
 -e DOUBLE                         List matches below this E-value (range 0.0-inf) [1.000E+01]
 --min-aln-len INT                 Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT                 0: alignment length 1: shorter, 2: longer sequence [0]
 --alt-ali INT                     Show up to this many alternative alignments [0]
 --gap-open TWIN                   Gap open cost [aa:10,nucl:10]
 --gap-extend TWIN                 Gap extension cost [aa:1,nucl:1]
 --min-assigned-chains-ratio FLOAT Minimum ratio of assigned chains out of all query chains > thr [0.0,1.0] [0.000]
 --monomer-include-mode INT        Monomer Complex Inclusion 0: include monomers, 1: NOT include monomers [0]
 --expand-multimer-evalue DOUBLE   E-value threshold for multimer chain expansion (range 0.0-inf) [1.000E+04]
clust:                           
 --cluster-mode INT                0: Set-Cover (greedy)
                                   1: Connected component (BLASTclust)
                                   2,3: Greedy clustering by sequence length (CDHIT) [0]
 --max-iterations INT              Maximum depth of breadth first search in connected component clustering [1000]
 --similarity-type INT             Type of score used for clustering. 1: alignment score 2: sequence identity [2]
kmermatcher:                     
 --weights STR                     Weights used for cluster priorization []
 --cluster-weight-threshold FLOAT  Weight threshold used for cluster priorization [0.900]
profile:                         
 --num-iterations INT              Number of iterative profile search iterations [1]
misc:                            
 --db-extraction-mode INT          createdb extraction mode: 0: chain 1: interface [0]
 --distance-threshold FLOAT        Residues with C-beta below this threshold will be part of interface [8.000]
 --mask-bfactor-threshold FLOAT    mask residues for seeding if b-factor < thr [0,100] [0.000]
 --input-format INT                Format of input structures:
                                   0: Auto-detect by extension
                                   1: PDB
                                   2: mmCIF
                                   3: mmJSON
                                   4: ChemComp
                                   5: Foldcomp [0]
 --file-include STR                Include file names based on this regex [.*]
 --file-exclude STR                Exclude file names based on this regex [^$]
 --tmscore-threshold FLOAT         accept alignments with a tmsore > thr [0.0,1.0] [0.000]
 --tmscore-threshold-mode INT      0: alignment, 1: query 2: target length [0]
 --tmalign-hit-order INT           order hits by 0: (qTM+tTM)/2, 1: qTM, 2: tTM, 3: min(qTM,tTM) 4: max(qTM,tTM) [0]
 --tmalign-fast INT                turn on fast search in TM-align [1]
 --lddt-threshold FLOAT            accept alignments with a lddt > thr [0.0,1.0] [0.000]
 --alignment-type INT              How to compute the alignment:
                                   0: 3di alignment
                                   1: TM alignment
                                   2: 3Di+AA [2]
 --exact-tmscore INT               turn on fast exact TMscore (slow), default is approximate [0]
 --prefilter-mode INT              prefilter mode: 0: kmer/ungapped 1: ungapped, 2: nofilter, 3: ungapped&gapped [0]
 --cluster-search INT              first find representative then align all cluster members [0]
 --multimer-tm-threshold FLOAT     accept alignments with a tmsore > thr [0.0,1.0] [0.000]
 --chain-tm-threshold FLOAT        accept alignments with a tmsore > thr [0.0,1.0] [0.000]
 --interface-lddt-threshold FLOAT  accept alignments with a lddt > thr [0.0,1.0] [0.000]
common:                          
 --gpu INT                         Use GPU (CUDA) if possible [0]
 --prostt5-model STR               Path to ProstT5 model []
 --threads INT                     Number of CPU-cores used (all by default) [20]
 -v INT                            Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --db-load-mode INT                Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --sub-mat TWIN                    Substitution matrix file [aa:3di.out,nucl:3di.out]
 --max-seq-len INT                 Maximum sequence length [65535]
 --compressed INT                  Write compressed output [0]
 --gpu-server INT                  Use GPU server [0]
 --gpu-server-wait-timeout INT     Wait for GPU server for 0: don't wait -1: no wait limit: >0 this many seconds [600]
 --remove-tmp-files BOOL           Delete temporary files [1]
 --mpi-runner STR                  Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42") []
 --force-reuse BOOL                Reuse tmp filse in tmp/latest folder ignoring parameters and version changes [0]
expert:                          
 --chain-name-mode INT             Add chain to name:
                                   0: auto
                                   1: always add
                                    [0]
 --write-mapping INT               write _mapping file containing mapping from internal id to taxonomic identifier [0]
 --coord-store-mode INT            Coordinate storage mode: 
                                   1: C-alpha as float
                                   2: C-alpha as difference (uint16_t) [2]
 --write-lookup INT                write .lookup file containing mapping from internal id, fasta id and file number [1]
 --zdrop INT                       Maximal allowed difference between score values before alignment is truncated  (nucleotide alignment only) [40]
 --taxon-list STR                  Taxonomy ID, possibly multiple values separated by ',' []
 --multimer-report-mode INT        Complex report mode:
                                   0: No report
                                   1: Write complex report [1]

examples:
 #Clustering of PDB files
 foldseek easy-multimercluster examples/ result tmp
 # Cluster output
 #  - result_rep_seq.fasta: Representatives
 #  - result_cluster.tsv:   Adjacency list
 
 # Important parameter: --cov-mode and -c 
 #                  --cov-mode 
 #                  0    1    2
 # Q: MAVGTACRPA  60%  IGN  60%
 # T: -AVGTAC---  60% 100%  IGN
 #        -c 0.7    -    +    -
 #        -c 0.6    +    +    +
 
 
references:
 - Kim, W., Mirdita, M., Levy Karin, E., Gilchrist, C.L.M., Schweke, H., Söding, J., Levy, E., and Steinegger, M. Rapid and Sensitive Protein Complex Alignment with Foldseek-Multimer. bioRxiv, doi:10.1101/2024.04.14.589414 (2024)
```


## foldseek_easy-multimersearch

### Tool Description
By Woosub Kim <woosubgo@snu.ac.kr>

### Metadata
- **Docker Image**: quay.io/biocontainers/foldseek:10.941cd33--h5021889_1
- **Homepage**: https://github.com/steineggerlab/foldseek
- **Package**: https://anaconda.org/channels/bioconda/packages/foldseek/overview
- **Validation**: PASS

### Original Help Text
```text
usage: foldseek easy-multimersearch <i:PDB|mmCIF[.gz]> ... <i:PDB|mmCIF[.gz]>|<i:stdin> <i:targetFastaFile[.gz]>|<i:targetDB> <o:outputFileName> <tmpDir> [options]
 By Woosub Kim <woosubgo@snu.ac.kr>
options: prefilter:                       
 --comp-bias-corr INT              Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT      Correct for locally biased amino acid composition (range 0-1) [1.000]
 --seed-sub-mat TWIN               Substitution matrix file for k-mer generation [aa:3di.out,nucl:3di.out]
 -s FLOAT                          Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [4.000]
 -k INT                            k-mer length (0: automatically set to optimum) [0]
 --target-search-mode INT          target search mode (0: regular k-mer, 1: similar k-mer) [0]
 --k-score TWIN                    k-mer threshold for generating similar k-mer lists [seq:2147483647,prof:2147483647]
 --max-seqs INT                    Maximum results per query sequence allowed to pass the prefilter (affects sensitivity) [300]
 --split INT                       Split input into N equally distributed chunks. 0: set the best split automatically [0]
 --split-mode INT                  0: split target db; 1: split query db; 2: auto, depending on main memory [2]
 --split-memory-limit BYTE         Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
 --diag-score BOOL                 Use ungapped diagonal scoring during prefilter [1]
 --exact-kmer-matching INT         Extract only exact k-mers for matching (range 0-1) [0]
 --mask INT                        Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [0]
 --mask-prob FLOAT                 Mask sequences is probablity is above threshold [1.000]
 --mask-lower-case INT             Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [1]
 --mask-n-repeat INT               Repeat letters that occure > threshold in a rwo [6]
 --min-ungapped-score INT          Accept only matches with ungapped alignment score above threshold [30]
 --spaced-kmer-mode INT            0: use consecutive positions in k-mers; 1: use spaced k-mers [1]
 --spaced-kmer-pattern STR         User-specified spaced k-mer pattern []
 --local-tmp STR                   Path where some of the temporary files will be created []
 --exhaustive-search BOOL          Turns on an exhaustive all vs all search by by passing the prefilter step [0]
align:                           
 --min-seq-id FLOAT                List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 -c FLOAT                          List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --cov-mode INT                    0: coverage of query and target
                                   1: coverage of target
                                   2: coverage of query
                                   3: target seq. length has to be at least x% of query length
                                   4: query seq. length has to be at least x% of target length
                                   5: short seq. needs to be at least x% of the other seq. length [0]
 --max-rejected INT                Maximum rejected alignments before alignment calculation for a query is stopped [2147483647]
 --max-accept INT                  Maximum accepted alignments before alignment calculation for a query is stopped [2147483647]
 -a BOOL                           Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --sort-by-structure-bits INT      sort by bits*sqrt(alnlddt*alntmscore) [1]
 --alignment-mode INT              How to compute the alignment:
                                   0: automatic
                                   1: only score and end_pos
                                   2: also start_pos and cov
                                   3: also seq.id [0]
 --alignment-output-mode INT       How to compute the alignment:
                                   0: automatic
                                   1: only score and end_pos
                                   2: also start_pos and cov
                                   3: also seq.id
                                   4: only ungapped alignment
                                   5: score only (output) cluster format [0]
 -e DOUBLE                         List matches below this E-value (range 0.0-inf) [1.000E+01]
 --min-aln-len INT                 Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT                 0: alignment length 1: shorter, 2: longer sequence [0]
 --alt-ali INT                     Show up to this many alternative alignments [0]
 --gap-open TWIN                   Gap open cost [aa:10,nucl:10]
 --gap-extend TWIN                 Gap extension cost [aa:1,nucl:1]
 --min-assigned-chains-ratio FLOAT Minimum ratio of assigned chains out of all query chains > thr [0.0,1.0] [0.000]
 --monomer-include-mode INT        Monomer Complex Inclusion 0: include monomers, 1: NOT include monomers [0]
 --expand-multimer-evalue DOUBLE   E-value threshold for multimer chain expansion (range 0.0-inf) [1.000E+04]
profile:                         
 --num-iterations INT              Number of iterative profile search iterations [1]
misc:                            
 --db-extraction-mode INT          createdb extraction mode: 0: chain 1: interface [0]
 --distance-threshold FLOAT        Residues with C-beta below this threshold will be part of interface [8.000]
 --mask-bfactor-threshold FLOAT    mask residues for seeding if b-factor < thr [0,100] [0.000]
 --input-format INT                Format of input structures:
                                   0: Auto-detect by extension
                                   1: PDB
                                   2: mmCIF
                                   3: mmJSON
                                   4: ChemComp
                                   5: Foldcomp [0]
 --file-include STR                Include file names based on this regex [.*]
 --file-exclude STR                Exclude file names based on this regex [^$]
 --tmscore-threshold FLOAT         accept alignments with a tmsore > thr [0.0,1.0] [0.000]
 --tmscore-threshold-mode INT      0: alignment, 1: query 2: target length [0]
 --tmalign-hit-order INT           order hits by 0: (qTM+tTM)/2, 1: qTM, 2: tTM, 3: min(qTM,tTM) 4: max(qTM,tTM) [0]
 --tmalign-fast INT                turn on fast search in TM-align [1]
 --lddt-threshold FLOAT            accept alignments with a lddt > thr [0.0,1.0] [0.000]
 --alignment-type INT              How to compute the alignment:
                                   0: 3di alignment
                                   1: TM alignment
                                   2: 3Di+AA [2]
 --exact-tmscore INT               turn on fast exact TMscore (slow), default is approximate [0]
 --prefilter-mode INT              prefilter mode: 0: kmer/ungapped 1: ungapped, 2: nofilter, 3: ungapped&gapped [0]
 --cluster-search INT              first find representative then align all cluster members [0]
 --format-mode INT                 Output format:
                                   0: BLAST-TAB
                                   1: SAM
                                   2: BLAST-TAB + query/db length
                                   3: Pretty HTML
                                   4: BLAST-TAB + column headers
                                   5: Calpha only PDB super-posed to query
                                   BLAST-TAB (0) and BLAST-TAB + column headers (4)support custom output formats (--format-output)
                                   (5) Superposed PDB files (Calpha only) [0]
 --format-output STR               Choose comma separated list of output columns from: query,target,evalue,gapopen,pident,fident,nident,qstart,qend,qlen
                                   tstart,tend,tlen,alnlen,raw,bits,cigar,qseq,tseq,qheader,theader,qaln,taln,mismatch,qcov,tcov
                                   qset,qsetid,tset,tsetid,taxid,taxname,taxlineage,
                                   lddt,lddtfull,qca,tca,t,u,qtmscore,ttmscore,alntmscore,rmsd,prob
                                   complexqtmscore,complexttmscore,complexu,complext,complexassignid
                                    [query,target,fident,alnlen,mismatch,gapopen,qstart,qend,tstart,tend,evalue,bits]
common:                          
 --gpu INT                         Use GPU (CUDA) if possible [0]
 --threads INT                     Number of CPU-cores used (all by default) [20]
 -v INT                            Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --db-load-mode INT                Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --sub-mat TWIN                    Substitution matrix file [aa:3di.out,nucl:3di.out]
 --max-seq-len INT                 Maximum sequence length [65535]
 --compressed INT                  Write compressed output [0]
 --gpu-server INT                  Use GPU server [0]
 --gpu-server-wait-timeout INT     Wait for GPU server for 0: don't wait -1: no wait limit: >0 this many seconds [600]
 --remove-tmp-files BOOL           Delete temporary files [0]
 --mpi-runner STR                  Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42") []
 --force-reuse BOOL                Reuse tmp filse in tmp/latest folder ignoring parameters and version changes [0]
expert:                          
 --chain-name-mode INT             Add chain to name:
                                   0: auto
                                   1: always add
                                    [0]
 --write-mapping INT               write _mapping file containing mapping from internal id to taxonomic identifier [0]
 --coord-store-mode INT            Coordinate storage mode: 
                                   1: C-alpha as float
                                   2: C-alpha as difference (uint16_t) [2]
 --write-lookup INT                write .lookup file containing mapping from internal id, fasta id and file number [1]
 --zdrop INT                       Maximal allowed difference between score values before alignment is truncated  (nucleotide alignment only) [40]
 --taxon-list STR                  Taxonomy ID, possibly multiple values separated by ',' []
 --multimer-report-mode INT        Complex report mode:
                                   0: No report
                                   1: Write complex report [1]
 --db-output BOOL                  Return a result DB instead of a text file [0]

examples:
 # Search a single/multiple PDB file against a set of PDB files and get multimer level alignments
 foldseek easy-multimersearch example/1tim.pdb.gz example/8tim.pdb.gz result tmp
 # Format output differently
 foldseek easy-multimersearch example/1tim.pdb.gz example/8tim.pdb.gz result tmp --format-output query,target,qstart,tstart,cigar
 # Align with TMalign (global)
 foldseek easy-multimersearch example/1tim.pdb.gz example/8tim.pdb.gz result tmp --alignment-type 1
 # Skip prefilter and perform an exhaustive alignment (slower but more sensitive)
 foldseek easy-multimersearch example/1tim.pdb.gz example/8tim.pdb.gz result tmp --exhaustive-search 1
 
 
references:
 - Kim, W., Mirdita, M., Levy Karin, E., Gilchrist, C.L.M., Schweke, H., Söding, J., Levy, E., and Steinegger, M. Rapid and Sensitive Protein Complex Alignment with Foldseek-Multimer. bioRxiv, doi:10.1101/2024.04.14.589414 (2024)
```


## foldseek_createdb

### Tool Description
Convert PDB or mmCIF structures into a foldseek database (amino acid, 3Di, C-alpha and header sub-databases).

### Metadata
- **Docker Image**: quay.io/biocontainers/foldseek:10.941cd33--h5021889_1
- **Homepage**: https://github.com/steineggerlab/foldseek
- **Package**: https://anaconda.org/channels/bioconda/packages/foldseek/overview
- **Validation**: PASS

### Original Help Text
```text
usage: foldseek createdb <i:directory|.tsv>|<i:PDB|mmCIF[.gz]|tar[.gz]|DB> ... <i:PDB|mmCIF[.gz]|tar|DB> <o:sequenceDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: misc:                         
 --db-extraction-mode INT       createdb extraction mode: 0: chain 1: interface [0]
 --distance-threshold FLOAT     Residues with C-beta below this threshold will be part of interface [8.000]
 --mask-bfactor-threshold FLOAT mask residues for seeding if b-factor < thr [0,100] [0.000]
 --input-format INT             Format of input structures:
                                0: Auto-detect by extension
                                1: PDB
                                2: mmCIF
                                3: mmJSON
                                4: ChemComp
                                5: Foldcomp [0]
 --file-include STR             Include file names based on this regex [.*]
 --file-exclude STR             Exclude file names based on this regex [^$]
common:                       
 --gpu INT                      Use GPU (CUDA) if possible [0]
 --prostt5-model STR            Path to ProstT5 model []
 --threads INT                  Number of CPU-cores used (all by default) [20]
 -v INT                         Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
expert:                       
 --chain-name-mode INT          Add chain to name:
                                0: auto
                                1: always add
                                 [0]
 --write-mapping INT            write _mapping file containing mapping from internal id to taxonomic identifier [0]
 --coord-store-mode INT         Coordinate storage mode: 
                                1: C-alpha as float
                                2: C-alpha as difference (uint16_t) [2]
 --write-lookup INT             write .lookup file containing mapping from internal id, fasta id and file number [1]

examples:
 # Process multiple files
 foldseek createdb examples/1tim.pdb.gz examples/8tim.pdb.gz DB
 # Process a directory containing PDB|mmCIF[.gz]|tar[.gz]|DB recursively, only one directory can be given
 foldseek createdb examples/ DB
 # Process a TSV file with a list of PDB|mmCIF[.gz]|tar[.gz]|DB, only one TSV can be given
 foldseek createdb examples.tsv DB
 # Process a directory or tar file and filter based on file name
 # Note: --file-include and --file-exclude only apply to directory or tar input
 foldseek createdb examples/ DB --file-include "pdb.gz$"
 # Predict 3Di sequences from an amino acid FASTA file using ProstT5
 foldseek databases ProstT5 weights tmp
 foldseek createdb QUERY.fasta DB --prostt5-model weights
 
 
references:
 - van Kempen, M., Kim, S.S., Tumescheit, C., Mirdita, M., Lee, J., Gilchrist, C.L.M., Söding, J., and Steinegger, M. Fast and accurate protein structure search with Foldseek. Nature Biotechnology, doi:10.1038/s41587-023-01773-0 (2023)
 - Heinzinger, M., Weissenow, K., Gomez Sanchez, J., Henkel, A., Mirdita, M., Steinegger, M., and Burkhard, R. Bilingual Language Model for Protein Sequence and Structure. NAR Genomics and Bioinformatics, doi:10.1093/nargab/lqae150 (2024)
```

## foldseek_createindex

### Tool Description
Create a k-mer index for a structure database to speed up searches.

### Metadata
- **Docker Image**: quay.io/biocontainers/foldseek:10.941cd33--h5021889_1
- **Homepage**: https://github.com/steineggerlab/foldseek
- **Package**: https://anaconda.org/channels/bioconda/packages/foldseek/overview
- **Validation**: PASS

### Original Help Text
```text
usage: foldseek createindex <i:sequenceDB> <tmpDir> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                  
 --seed-sub-mat TWIN          Substitution matrix file for k-mer generation [aa:3di.out,nucl:3di.out]
 -k INT                       k-mer length (0: automatically set to optimum) [0]
 --comp-bias-corr INT         Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT Correct for locally biased amino acid composition (range 0-1) [1.000]
 --max-seqs INT               Maximum results per query sequence allowed to pass the prefilter (affects sensitivity) [1000]
 --mask INT                   Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [0]
 --mask-prob FLOAT            Mask sequences is probablity is above threshold [1.000]
 --mask-lower-case INT        Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [1]
 --mask-n-repeat INT          Repeat letters that occure > threshold in a rwo [6]
 --spaced-kmer-mode INT       0: use consecutive positions in k-mers; 1: use spaced k-mers [1]
 --spaced-kmer-pattern STR    User-specified spaced k-mer pattern []
 -s FLOAT                     Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [9.500]
 --k-score TWIN               k-mer threshold for generating similar k-mer lists [seq:2147483647,prof:2147483647]
 --split INT                  Split input into N equally distributed chunks. 0: set the best split automatically [0]
 --split-memory-limit BYTE    Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
misc:                       
 --check-compatible INT       0: Always recreate index, 1: Check if recreating index is needed, 2: Fail if index is incompatible [0]
 --min-length INT             Minimum codon number in open reading frames [30]
 --max-length INT             Maximum codon number in open reading frames [32734]
 --max-gaps INT               Maximum number of codons with gaps or unknown residues before an open reading frame is rejected [2147483647]
 --contig-start-mode INT      Contig start can be 0: incomplete, 1: complete, 2: both [2]
 --contig-end-mode INT        Contig end can be 0: incomplete, 1: complete, 2: both [2]
 --orf-start-mode INT         Orf fragment can be 0: from start to stop, 1: from any to stop, 2: from last encountered start to stop (no start in the middle) [1]
 --forward-frames STR         Comma-separated list of frames on the forward strand to be extracted [1,2,3]
 --reverse-frames STR         Comma-separated list of frames on the reverse strand to be extracted [1,2,3]
 --translate INT              Translate ORF to amino acid [0]
 --use-all-table-starts BOOL  Use all alternatives for a start codon in the genetic table, if false - only ATG (AUG) [0]
 --id-offset INT              Numeric ids in index file are offset by this value [0]
 --sequence-overlap INT       Overlap between sequences [0]
 --sequence-split-mode INT    Sequence split mode 0: copy data, 1: soft link data and write new index, [1]
 --headers-split-mode INT     Header split mode: 0: split position, 1: original header [0]
 --translation-mode INT       Translation AA seq from nucleotide by 0: ORFs, 1: full reading frames [0]
common:                     
 --max-seq-len INT            Maximum sequence length [65535]
 -v INT                       Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --threads INT                Number of CPU-cores used (all by default) [20]
 --compressed INT             Write compressed output [0]
 --remove-tmp-files BOOL      Delete temporary files [1]
expert:                     
 --index-subset INT           Create specialized index with subset of entries
                              0: normal index
                              1: index without headers
                              2: index without prefiltering data
                              4: index without aln (for cluster db)
                              Flags can be combined bit wise [0]
 --translation-table INT      1) CANONICAL, 2) VERT_MITOCHONDRIAL, 3) YEAST_MITOCHONDRIAL, 4) MOLD_MITOCHONDRIAL, 5) INVERT_MITOCHONDRIAL, 6) CILIATE
                              9) FLATWORM_MITOCHONDRIAL, 10) EUPLOTID, 11) PROKARYOTE, 12) ALT_YEAST, 13) ASCIDIAN_MITOCHONDRIAL, 14) ALT_FLATWORM_MITOCHONDRIAL
                              15) BLEPHARISMA, 16) CHLOROPHYCEAN_MITOCHONDRIAL, 21) TREMATODE_MITOCHONDRIAL, 22) SCENEDESMUS_MITOCHONDRIAL
                              23) THRAUSTOCHYTRIUM_MITOCHONDRIAL, 24) PTEROBRANCHIA_MITOCHONDRIAL, 25) GRACILIBACTERIA, 26) PACHYSOLEN, 27) KARYORELICT, 28) CONDYLOSTOMA
                               29) MESODINIUM, 30) PERTRICH, 31) BLASTOCRITHIDIA [1]
 --create-lookup INT          Create database lookup file (can be very large) [0]
 --strand INT                 Strand selection only works for DNA/DNA search 0: reverse, 1: forward, 2: both [1]
 --index-exclude INT          Exclude parts of the index:
                              0: Full index
                              1: Exclude k-mer index (for use with --prefilter-mode 1)
                              2: Exclude C-alpha coordinates (for use with --sort-by-structure-bits 0)
                              Flags can be combined bit wise [0]

examples:
 # Create protein sequence index
 mmseqs createindex sequenceDB tmp
 
references:
 - Mirdita M, Steinegger M, Soding J: MMseqs2 desktop and local web server app for fast, interactive sequence searches. Bioinformatics, 35(16), 2856-2858 (2019)
 - van Kempen, M., Kim, S.S., Tumescheit, C., Mirdita, M., Lee, J., Gilchrist, C.L.M., Söding, J., and Steinegger, M. Fast and accurate protein structure search with Foldseek. Nature Biotechnology, doi:10.1038/s41587-023-01773-0 (2023)
```

## foldseek_search

### Tool Description
Search query structures against a target structure database.

### Metadata
- **Docker Image**: quay.io/biocontainers/foldseek:10.941cd33--h5021889_1
- **Homepage**: https://github.com/steineggerlab/foldseek
- **Package**: https://anaconda.org/channels/bioconda/packages/foldseek/overview
- **Validation**: PASS

### Original Help Text
```text
usage: foldseek search <i:queryDB> <i:targetDB> <o:alignmentDB> <tmpDir> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                     
 --comp-bias-corr INT            Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT    Correct for locally biased amino acid composition (range 0-1) [1.000]
 --seed-sub-mat TWIN             Substitution matrix file for k-mer generation [aa:3di.out,nucl:3di.out]
 -s FLOAT                        Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [9.500]
 -k INT                          k-mer length (0: automatically set to optimum) [0]
 --target-search-mode INT        target search mode (0: regular k-mer, 1: similar k-mer) [0]
 --k-score TWIN                  k-mer threshold for generating similar k-mer lists [seq:2147483647,prof:2147483647]
 --max-seqs INT                  Maximum results per query sequence allowed to pass the prefilter (affects sensitivity) [1000]
 --split INT                     Split input into N equally distributed chunks. 0: set the best split automatically [0]
 --split-mode INT                0: split target db; 1: split query db; 2: auto, depending on main memory [2]
 --split-memory-limit BYTE       Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
 --diag-score BOOL               Use ungapped diagonal scoring during prefilter [1]
 --exact-kmer-matching INT       Extract only exact k-mers for matching (range 0-1) [0]
 --mask INT                      Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [0]
 --mask-prob FLOAT               Mask sequences is probablity is above threshold [1.000]
 --mask-lower-case INT           Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [1]
 --mask-n-repeat INT             Repeat letters that occure > threshold in a rwo [6]
 --min-ungapped-score INT        Accept only matches with ungapped alignment score above threshold [30]
 --spaced-kmer-mode INT          0: use consecutive positions in k-mers; 1: use spaced k-mers [1]
 --spaced-kmer-pattern STR       User-specified spaced k-mer pattern []
 --local-tmp STR                 Path where some of the temporary files will be created []
 --exhaustive-search BOOL        Turns on an exhaustive all vs all search by by passing the prefilter step [0]
align:                         
 --min-seq-id FLOAT              List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 -c FLOAT                        List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --cov-mode INT                  0: coverage of query and target
                                 1: coverage of target
                                 2: coverage of query
                                 3: target seq. length has to be at least x% of query length
                                 4: query seq. length has to be at least x% of target length
                                 5: short seq. needs to be at least x% of the other seq. length [0]
 --max-rejected INT              Maximum rejected alignments before alignment calculation for a query is stopped [2147483647]
 --max-accept INT                Maximum accepted alignments before alignment calculation for a query is stopped [2147483647]
 -a BOOL                         Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --sort-by-structure-bits INT    sort by bits*sqrt(alnlddt*alntmscore) [1]
 --alignment-mode INT            How to compute the alignment:
                                 0: automatic
                                 1: only score and end_pos
                                 2: also start_pos and cov
                                 3: also seq.id [3]
 --alignment-output-mode INT     How to compute the alignment:
                                 0: automatic
                                 1: only score and end_pos
                                 2: also start_pos and cov
                                 3: also seq.id
                                 4: only ungapped alignment
                                 5: score only (output) cluster format [0]
 -e DOUBLE                       List matches below this E-value (range 0.0-inf) [1.000E+01]
 --min-aln-len INT               Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT               0: alignment length 1: shorter, 2: longer sequence [0]
 --alt-ali INT                   Show up to this many alternative alignments [0]
 --gap-open TWIN                 Gap open cost [aa:10,nucl:10]
 --gap-extend TWIN               Gap extension cost [aa:1,nucl:1]
profile:                       
 --num-iterations INT            Number of iterative profile search iterations [1]
misc:                          
 --tmscore-threshold FLOAT       accept alignments with a tmsore > thr [0.0,1.0] [0.000]
 --tmscore-threshold-mode INT    0: alignment, 1: query 2: target length [0]
 --tmalign-hit-order INT         order hits by 0: (qTM+tTM)/2, 1: qTM, 2: tTM, 3: min(qTM,tTM) 4: max(qTM,tTM) [0]
 --tmalign-fast INT              turn on fast search in TM-align [1]
 --lddt-threshold FLOAT          accept alignments with a lddt > thr [0.0,1.0] [0.000]
 --alignment-type INT            How to compute the alignment:
                                 0: 3di alignment
                                 1: TM alignment
                                 2: 3Di+AA [2]
 --exact-tmscore INT             turn on fast exact TMscore (slow), default is approximate [0]
 --prefilter-mode INT            prefilter mode: 0: kmer/ungapped 1: ungapped, 2: nofilter, 3: ungapped&gapped [0]
 --cluster-search INT            first find representative then align all cluster members [0]
common:                        
 --db-load-mode INT              Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                   Number of CPU-cores used (all by default) [20]
 -v INT                          Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --sub-mat TWIN                  Substitution matrix file [aa:3di.out,nucl:3di.out]
 --max-seq-len INT               Maximum sequence length [65535]
 --compressed INT                Write compressed output [0]
 --gpu INT                       Use GPU (CUDA) if possible [0]
 --gpu-server INT                Use GPU server [0]
 --gpu-server-wait-timeout INT   Wait for GPU server for 0: don't wait -1: no wait limit: >0 this many seconds [600]
 --remove-tmp-files BOOL         Delete temporary files [1]
 --mpi-runner STR                Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42") []
 --force-reuse BOOL              Reuse tmp filse in tmp/latest folder ignoring parameters and version changes [0]
expert:                        
 --taxon-list STR                Taxonomy ID, possibly multiple values separated by ',' []

examples:
 # Search multiple structures (mmCIF,PDB,tar) against structures.
 foldseek search queryDB targetDB resultDB tmp
 foldseek convertalis queryDB targetDB resultDB result.m8
 
 
references:
 - van Kempen, M., Kim, S.S., Tumescheit, C., Mirdita, M., Lee, J., Gilchrist, C.L.M., Söding, J., and Steinegger, M. Fast and accurate protein structure search with Foldseek. Nature Biotechnology, doi:10.1038/s41587-023-01773-0 (2023)
```

## foldseek_convertalis

### Tool Description
Convert an alignment database into a text file (BLAST tab, SAM, HTML or superposed PDB).

### Metadata
- **Docker Image**: quay.io/biocontainers/foldseek:10.941cd33--h5021889_1
- **Homepage**: https://github.com/steineggerlab/foldseek
- **Package**: https://anaconda.org/channels/bioconda/packages/foldseek/overview
- **Validation**: PASS

### Original Help Text
```text
usage: foldseek convertalis <i:queryDb> <i:targetDb> <i:alignmentDB> <o:alignmentFile> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: align:               
 --gap-open TWIN       Gap open cost [aa:10,nucl:10]
 --gap-extend TWIN     Gap extension cost [aa:1,nucl:1]
misc:                
 --format-mode INT     Output format:
                       0: BLAST-TAB
                       1: SAM
                       2: BLAST-TAB + query/db length
                       3: Pretty HTML
                       4: BLAST-TAB + column headers
                       5: Calpha only PDB super-posed to query
                       BLAST-TAB (0) and BLAST-TAB + column headers (4)support custom output formats (--format-output)
                       (5) Superposed PDB files (Calpha only) [0]
 --format-output STR   Choose comma separated list of output columns from: query,target,evalue,gapopen,pident,fident,nident,qstart,qend,qlen
                       tstart,tend,tlen,alnlen,raw,bits,cigar,qseq,tseq,qheader,theader,qaln,taln,mismatch,qcov,tcov
                       qset,qsetid,tset,tsetid,taxid,taxname,taxlineage,
                       lddt,lddtfull,qca,tca,t,u,qtmscore,ttmscore,alntmscore,rmsd,prob
                       complexqtmscore,complexttmscore,complexu,complext,complexassignid
                        [query,target,fident,alnlen,mismatch,gapopen,qstart,qend,tstart,tend,evalue,bits]
 --exact-tmscore INT   turn on fast exact TMscore (slow), default is approximate [0]
common:              
 --sub-mat TWIN        Substitution matrix file [aa:3di.out,nucl:3di.out]
 --db-load-mode INT    Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT         Number of CPU-cores used (all by default) [20]
 --compressed INT      Write compressed output [0]
 -v INT                Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
expert:              
 --db-output BOOL      Return a result DB instead of a text file [0]

examples:
 # Create output in BLAST M8 format (12 columns):
 #  (1,2) identifiers for query and target sequences/profiles,
 #  (3) sequence identity, (4) alignment length, (5) number of mismatches,
 #  (6) number of gap openings, (7-8, 9-10) alignment start and end-position in query and in target,
 #  (11) E-value, and (12) bit score
 foldseek convertalis queryDB targetDB result.m8
 
 # Create a TSV containing pairwise alignments
 foldseek convertalis queryDB targetDB result.tsv --format-output query,target,qaln,taln
 
 # Annotate a alignment result with taxonomy information from targetDB
 foldseek convertalis queryDB targetDB result.tsv --format-output query,target,taxid,taxname,taxlineage
 
  Create SAM output
 foldseek convertalis queryDB targetDB result.sam --format-mode 1
 
 # Create a TSV containing which query file a result comes from
 foldseek createdb euk_queries.fasta bac_queries.fasta queryDB
 foldseek convertalis queryDB targetDB result.tsv --format-output qset,query,target
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## foldseek_cluster

### Tool Description
Cluster the structures of a database.

### Metadata
- **Docker Image**: quay.io/biocontainers/foldseek:10.941cd33--h5021889_1
- **Homepage**: https://github.com/steineggerlab/foldseek
- **Package**: https://anaconda.org/channels/bioconda/packages/foldseek/overview
- **Validation**: PASS

### Original Help Text
```text
usage: foldseek cluster <i:sequenceDB> <o:clusterDB> <tmpDir> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr> & Lars von den Driesch
options: prefilter:                      
 --seed-sub-mat TWIN              Substitution matrix file for k-mer generation [aa:3di.out,nucl:3di.out]
 -s FLOAT                         Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [4.000]
 -k INT                           k-mer length (0: automatically set to optimum) [0]
 --target-search-mode INT         target search mode (0: regular k-mer, 1: similar k-mer) [0]
 --k-score TWIN                   k-mer threshold for generating similar k-mer lists [seq:2147483647,prof:2147483647]
 --max-seqs INT                   Maximum results per query sequence allowed to pass the prefilter (affects sensitivity) [1000]
 --split INT                      Split input into N equally distributed chunks. 0: set the best split automatically [0]
 --split-mode INT                 0: split target db; 1: split query db; 2: auto, depending on main memory [2]
 --split-memory-limit BYTE        Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
 --comp-bias-corr INT             Correct for locally biased amino acid composition (range 0-1) [0]
 --comp-bias-corr-scale FLOAT     Correct for locally biased amino acid composition (range 0-1) [1.000]
 --diag-score BOOL                Use ungapped diagonal scoring during prefilter [1]
 --exact-kmer-matching INT        Extract only exact k-mers for matching (range 0-1) [0]
 --mask INT                       Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [0]
 --mask-prob FLOAT                Mask sequences is probablity is above threshold [1.000]
 --mask-lower-case INT            Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [1]
 --mask-n-repeat INT              Repeat letters that occure > threshold in a rwo [6]
 --min-ungapped-score INT         Accept only matches with ungapped alignment score above threshold [30]
 --spaced-kmer-mode INT           0: use consecutive positions in k-mers; 1: use spaced k-mers [1]
 --spaced-kmer-pattern STR        User-specified spaced k-mer pattern []
 --local-tmp STR                  Path where some of the temporary files will be created []
align:                          
 -c FLOAT                         List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.800]
 --cov-mode INT                   0: coverage of query and target
                                  1: coverage of target
                                  2: coverage of query
                                  3: target seq. length has to be at least x% of query length
                                  4: query seq. length has to be at least x% of target length
                                  5: short seq. needs to be at least x% of the other seq. length [0]
 --sort-by-structure-bits INT     sort by bits*sqrt(alnlddt*alntmscore) [0]
 -a BOOL                          Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --alignment-mode INT             How to compute the alignment:
                                  0: automatic
                                  1: only score and end_pos
                                  2: also start_pos and cov
                                  3: also seq.id [3]
 --alignment-output-mode INT      How to compute the alignment:
                                  0: automatic
                                  1: only score and end_pos
                                  2: also start_pos and cov
                                  3: also seq.id
                                  4: only ungapped alignment
                                  5: score only (output) cluster format [0]
 -e DOUBLE                        List matches below this E-value (range 0.0-inf) [1.000E-02]
 --min-seq-id FLOAT               List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 --min-aln-len INT                Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT                0: alignment length 1: shorter, 2: longer sequence [0]
 --alt-ali INT                    Show up to this many alternative alignments [0]
 --max-rejected INT               Maximum rejected alignments before alignment calculation for a query is stopped [2147483647]
 --max-accept INT                 Maximum accepted alignments before alignment calculation for a query is stopped [2147483647]
 --gap-open TWIN                  Gap open cost [aa:10,nucl:10]
 --gap-extend TWIN                Gap extension cost [aa:1,nucl:1]
clust:                          
 --cluster-mode INT               0: Set-Cover (greedy)
                                  1: Connected component (BLASTclust)
                                  2,3: Greedy clustering by sequence length (CDHIT) [0]
 --max-iterations INT             Maximum depth of breadth first search in connected component clustering [1000]
 --similarity-type INT            Type of score used for clustering. 1: alignment score 2: sequence identity [2]
 --single-step-clustering BOOL    Switch from cascaded to simple clustering workflow [0]
 --cluster-steps INT              Cascaded clustering steps from 1 to -s [3]
 --cluster-reassign BOOL          Cascaded clustering can cluster sequence that do not fulfill the clustering criteria.
                                  Cluster reassignment corrects these errors [0]
kmermatcher:                    
 --weights STR                    Weights used for cluster priorization []
 --cluster-weight-threshold FLOAT Weight threshold used for cluster priorization [0.900]
 --kmer-per-seq INT               k-mers per sequence [300]
 --kmer-per-seq-scale TWIN        Scale k-mer per sequence based on sequence length as kmer-per-seq val + scale x seqlen [aa:0.000,nucl:0.200]
 --adjust-kmer-len BOOL           Adjust k-mer length based on specificity (only for nucleotides) [0]
 --hash-shift INT                 Shift k-mer hash initialization [67]
 --include-only-extendable BOOL   Include only extendable [0]
 --ignore-multi-kmer BOOL         Skip k-mers occurring multiple times (>=2) [0]
misc:                           
 --tmscore-threshold FLOAT        accept alignments with a tmsore > thr [0.0,1.0] [0.000]
 --tmscore-threshold-mode INT     0: alignment, 1: query 2: target length [0]
 --lddt-threshold FLOAT           accept alignments with a lddt > thr [0.0,1.0] [0.000]
 --alignment-type INT             How to compute the alignment:
                                  0: 3di alignment
                                  1: TM alignment
                                  2: 3Di+AA [2]
 --exact-tmscore INT              turn on fast exact TMscore (slow), default is approximate [0]
 --tmalign-hit-order INT          order hits by 0: (qTM+tTM)/2, 1: qTM, 2: tTM, 3: min(qTM,tTM) 4: max(qTM,tTM) [0]
 --tmalign-fast INT               turn on fast search in TM-align [1]
 --rescore-mode INT               Rescore diagonals with:
                                  0: Hamming distance
                                  1: local alignment (score only)
                                  2: local alignment
                                  3: global alignment
                                  4: longest alignment fulfilling window quality criterion [0]
common:                         
 --sub-mat TWIN                   Substitution matrix file [aa:3di.out,nucl:3di.out]
 --max-seq-len INT                Maximum sequence length [65535]
 --db-load-mode INT               Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                    Number of CPU-cores used (all by default) [20]
 --compressed INT                 Write compressed output [0]
 -v INT                           Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --remove-tmp-files BOOL          Delete temporary files [0]
 --force-reuse BOOL               Reuse tmp filse in tmp/latest folder ignoring parameters and version changes [0]
 --mpi-runner STR                 Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42") []
expert:                         
 --taxon-list STR                 Taxonomy ID, possibly multiple values separated by ',' []
 --zdrop INT                      Maximal allowed difference between score values before alignment is truncated  (nucleotide alignment only) [40]
 --filter-hits BOOL               Filter hits by seq.id. and coverage [0]
 --sort-results INT               Sort results: 0: no sorting, 1: sort by E-value (Alignment) or seq.id. (Hamming) [0]

examples:
 # Cascaded clustering of FASTA file
 mmseqs cluster sequenceDB clusterDB tmp
 
 #                  --cov-mode 
 # Sequence         0    1    2
 # Q: MAVGTACRPA  60%  IGN  60%
 # T: -AVGTAC---  60% 100%  IGN
 # Cutoff -c 0.7    -    +    -
 #        -c 0.6    +    +    +
 
 # Cascaded clustering with reassignment
 # - Corrects criteria-violoations of cascaded merging
 # - Produces more clusters and is a bit slower
 mmseqs cluster sequenceDB clusterDB tmp --cluster-reassign
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - van Kempen, M., Kim, S.S., Tumescheit, C., Mirdita, M., Lee, J., Gilchrist, C.L.M., Söding, J., and Steinegger, M. Fast and accurate protein structure search with Foldseek. Nature Biotechnology, doi:10.1038/s41587-023-01773-0 (2023)
```

## foldseek_createtsv

### Tool Description
Convert a result database (for example a clustering) into a tab-separated file.

### Metadata
- **Docker Image**: quay.io/biocontainers/foldseek:10.941cd33--h5021889_1
- **Homepage**: https://github.com/steineggerlab/foldseek
- **Package**: https://anaconda.org/channels/bioconda/packages/foldseek/overview
- **Validation**: PASS

### Original Help Text
```text
usage: foldseek createtsv <i:queryDB> [<i:targetDB>] <i:resultDB> <o:tsvFile> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: misc:                    
 --first-seq-as-repr BOOL  Use the first sequence of the clustering result as representative sequence [0]
 --target-column INT       Select a target column (default 1), 0 if no target id exists [1]
 --full-header BOOL        Replace DB ID by its corresponding Full Header [0]
 --idx-seq-src INT         0: auto, 1: split/translated sequences, 2: input sequences [0]
common:                  
 --threads INT             Number of CPU-cores used (all by default) [20]
 --compressed INT          Write compressed output [0]
 -v INT                    Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
expert:                  
 --db-output BOOL          Return a result DB instead of a text file [0]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## foldseek_rbh

### Tool Description
Find reciprocal best hits between a query and a target structure database.

### Metadata
- **Docker Image**: quay.io/biocontainers/foldseek:10.941cd33--h5021889_1
- **Homepage**: https://github.com/steineggerlab/foldseek
- **Package**: https://anaconda.org/channels/bioconda/packages/foldseek/overview
- **Validation**: PASS

### Original Help Text
```text
usage: foldseek rbh <i:queryDB> <i:targetDB> <o:alignmentDB> <tmpDir> [options]
 By Eli Levy Karin & Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                     
 --comp-bias-corr INT            Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT    Correct for locally biased amino acid composition (range 0-1) [1.000]
 --seed-sub-mat TWIN             Substitution matrix file for k-mer generation [aa:3di.out,nucl:3di.out]
 -s FLOAT                        Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [9.500]
 -k INT                          k-mer length (0: automatically set to optimum) [0]
 --target-search-mode INT        target search mode (0: regular k-mer, 1: similar k-mer) [0]
 --k-score TWIN                  k-mer threshold for generating similar k-mer lists [seq:2147483647,prof:2147483647]
 --max-seqs INT                  Maximum results per query sequence allowed to pass the prefilter (affects sensitivity) [1000]
 --split INT                     Split input into N equally distributed chunks. 0: set the best split automatically [0]
 --split-mode INT                0: split target db; 1: split query db; 2: auto, depending on main memory [2]
 --split-memory-limit BYTE       Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
 --diag-score BOOL               Use ungapped diagonal scoring during prefilter [1]
 --exact-kmer-matching INT       Extract only exact k-mers for matching (range 0-1) [0]
 --mask INT                      Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [0]
 --mask-prob FLOAT               Mask sequences is probablity is above threshold [1.000]
 --mask-lower-case INT           Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [1]
 --mask-n-repeat INT             Repeat letters that occure > threshold in a rwo [6]
 --min-ungapped-score INT        Accept only matches with ungapped alignment score above threshold [30]
 --spaced-kmer-mode INT          0: use consecutive positions in k-mers; 1: use spaced k-mers [1]
 --spaced-kmer-pattern STR       User-specified spaced k-mer pattern []
 --local-tmp STR                 Path where some of the temporary files will be created []
 --exhaustive-search BOOL        Turns on an exhaustive all vs all search by by passing the prefilter step [0]
align:                         
 --min-seq-id FLOAT              List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 -c FLOAT                        List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --cov-mode INT                  0: coverage of query and target
                                 1: coverage of target
                                 2: coverage of query
                                 3: target seq. length has to be at least x% of query length
                                 4: query seq. length has to be at least x% of target length
                                 5: short seq. needs to be at least x% of the other seq. length [0]
 --max-rejected INT              Maximum rejected alignments before alignment calculation for a query is stopped [2147483647]
 --max-accept INT                Maximum accepted alignments before alignment calculation for a query is stopped [2147483647]
 -a BOOL                         Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --sort-by-structure-bits INT    sort by bits*sqrt(alnlddt*alntmscore) [0]
 --alignment-mode INT            How to compute the alignment:
                                 0: automatic
                                 1: only score and end_pos
                                 2: also start_pos and cov
                                 3: also seq.id [3]
 --alignment-output-mode INT     How to compute the alignment:
                                 0: automatic
                                 1: only score and end_pos
                                 2: also start_pos and cov
                                 3: also seq.id
                                 4: only ungapped alignment
                                 5: score only (output) cluster format [0]
 -e DOUBLE                       List matches below this E-value (range 0.0-inf) [1.000E+01]
 --min-aln-len INT               Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT               0: alignment length 1: shorter, 2: longer sequence [0]
 --alt-ali INT                   Show up to this many alternative alignments [0]
 --gap-open TWIN                 Gap open cost [aa:10,nucl:10]
 --gap-extend TWIN               Gap extension cost [aa:1,nucl:1]
profile:                       
 --num-iterations INT            Number of iterative profile search iterations [1]
misc:                          
 --tmscore-threshold FLOAT       accept alignments with a tmsore > thr [0.0,1.0] [0.000]
 --tmscore-threshold-mode INT    0: alignment, 1: query 2: target length [0]
 --tmalign-hit-order INT         order hits by 0: (qTM+tTM)/2, 1: qTM, 2: tTM, 3: min(qTM,tTM) 4: max(qTM,tTM) [0]
 --tmalign-fast INT              turn on fast search in TM-align [1]
 --lddt-threshold FLOAT          accept alignments with a lddt > thr [0.0,1.0] [0.000]
 --alignment-type INT            How to compute the alignment:
                                 0: 3di alignment
                                 1: TM alignment
                                 2: 3Di+AA [2]
 --exact-tmscore INT             turn on fast exact TMscore (slow), default is approximate [0]
 --prefilter-mode INT            prefilter mode: 0: kmer/ungapped 1: ungapped, 2: nofilter, 3: ungapped&gapped [0]
 --cluster-search INT            first find representative then align all cluster members [0]
common:                        
 --db-load-mode INT              Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                   Number of CPU-cores used (all by default) [20]
 -v INT                          Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --sub-mat TWIN                  Substitution matrix file [aa:3di.out,nucl:3di.out]
 --max-seq-len INT               Maximum sequence length [65535]
 --compressed INT                Write compressed output [0]
 --gpu INT                       Use GPU (CUDA) if possible [0]
 --gpu-server INT                Use GPU server [0]
 --gpu-server-wait-timeout INT   Wait for GPU server for 0: don't wait -1: no wait limit: >0 this many seconds [600]
 --remove-tmp-files BOOL         Delete temporary files [1]
 --mpi-runner STR                Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42") []
 --force-reuse BOOL              Reuse tmp filse in tmp/latest folder ignoring parameters and version changes [0]
expert:                        
 --taxon-list STR                Taxonomy ID, possibly multiple values separated by ',' []

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## foldseek_structurealign

### Tool Description
Compute structure alignments for the pairs of a prefilter result database.

### Metadata
- **Docker Image**: quay.io/biocontainers/foldseek:10.941cd33--h5021889_1
- **Homepage**: https://github.com/steineggerlab/foldseek
- **Package**: https://anaconda.org/channels/bioconda/packages/foldseek/overview
- **Validation**: PASS

### Original Help Text
```text
usage: foldseek structurealign <i:queryDB> <i:targetDB> <i:prefilterDB> <o:resultDB> [options]
 By Charlotte Tumescheit <ch.tumescheit@gmail.com> & Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                    
 --comp-bias-corr INT           Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT   Correct for locally biased amino acid composition (range 0-1) [0.500]
align:                        
 --sort-by-structure-bits INT   sort by bits*sqrt(alnlddt*alntmscore) [1]
 -a BOOL                        Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --alignment-mode INT           How to compute the alignment:
                                0: automatic
                                1: only score and end_pos
                                2: also start_pos and cov
                                3: also seq.id [0]
 --alignment-output-mode INT    How to compute the alignment:
                                0: automatic
                                1: only score and end_pos
                                2: also start_pos and cov
                                3: also seq.id
                                4: only ungapped alignment
                                5: score only (output) cluster format [0]
 -e DOUBLE                      List matches below this E-value (range 0.0-inf) [1.000E+01]
 --min-seq-id FLOAT             List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 --min-aln-len INT              Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT              0: alignment length 1: shorter, 2: longer sequence [0]
 --alt-ali INT                  Show up to this many alternative alignments [0]
 -c FLOAT                       List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --cov-mode INT                 0: coverage of query and target
                                1: coverage of target
                                2: coverage of query
                                3: target seq. length has to be at least x% of query length
                                4: query seq. length has to be at least x% of target length
                                5: short seq. needs to be at least x% of the other seq. length [0]
 --max-rejected INT             Maximum rejected alignments before alignment calculation for a query is stopped [2147483647]
 --max-accept INT               Maximum accepted alignments before alignment calculation for a query is stopped [2147483647]
 --gap-open TWIN                Gap open cost [aa:10,nucl:10]
 --gap-extend TWIN              Gap extension cost [aa:1,nucl:1]
misc:                         
 --tmscore-threshold FLOAT      accept alignments with a tmsore > thr [0.0,1.0] [0.000]
 --tmscore-threshold-mode INT   0: alignment, 1: query 2: target length [0]
 --lddt-threshold FLOAT         accept alignments with a lddt > thr [0.0,1.0] [0.000]
 --alignment-type INT           How to compute the alignment:
                                0: 3di alignment
                                1: TM alignment
                                2: 3Di+AA [2]
 --exact-tmscore INT            turn on fast exact TMscore (slow), default is approximate [0]
common:                       
 --sub-mat TWIN                 Substitution matrix file [aa:3di.out,nucl:3di.out]
 --max-seq-len INT              Maximum sequence length [65535]
 --db-load-mode INT             Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                  Number of CPU-cores used (all by default) [20]
 --compressed INT               Write compressed output [0]
 -v INT                         Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - van Kempen, M., Kim, S.S., Tumescheit, C., Mirdita, M., Lee, J., Gilchrist, C.L.M., Söding, J., and Steinegger, M. Fast and accurate protein structure search with Foldseek. Nature Biotechnology, doi:10.1038/s41587-023-01773-0 (2023)
```

## foldseek_tmalign

### Tool Description
Compute TM-align alignments for the pairs of a prefilter result database.

### Metadata
- **Docker Image**: quay.io/biocontainers/foldseek:10.941cd33--h5021889_1
- **Homepage**: https://github.com/steineggerlab/foldseek
- **Package**: https://anaconda.org/channels/bioconda/packages/foldseek/overview
- **Validation**: PASS

### Original Help Text
```text
usage: foldseek tmalign <i:queryDB> <i:targetDB> <i:prefilterDB> <o:resultDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: align:                        
 --min-seq-id FLOAT             List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 -c FLOAT                       List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --cov-mode INT                 0: coverage of query and target
                                1: coverage of target
                                2: coverage of query
                                3: target seq. length has to be at least x% of query length
                                4: query seq. length has to be at least x% of target length
                                5: short seq. needs to be at least x% of the other seq. length [0]
 --max-rejected INT             Maximum rejected alignments before alignment calculation for a query is stopped [2147483647]
 --max-accept INT               Maximum accepted alignments before alignment calculation for a query is stopped [2147483647]
 -a BOOL                        Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
misc:                         
 --tmscore-threshold FLOAT      accept alignments with a tmsore > thr [0.0,1.0] [0.000]
 --tmscore-threshold-mode INT   0: alignment, 1: query 2: target length [0]
 --tmalign-hit-order INT        order hits by 0: (qTM+tTM)/2, 1: qTM, 2: tTM, 3: min(qTM,tTM) 4: max(qTM,tTM) [0]
 --tmalign-fast INT             turn on fast search in TM-align [1]
common:                       
 --db-load-mode INT             Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                  Number of CPU-cores used (all by default) [20]
 -v INT                         Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - van Kempen, M., Kim, S.S., Tumescheit, C., Mirdita, M., Lee, J., Gilchrist, C.L.M., Söding, J., and Steinegger, M. Fast and accurate protein structure search with Foldseek. Nature Biotechnology, doi:10.1038/s41587-023-01773-0 (2023)
```

## foldseek_result2msa

### Tool Description
Build multiple sequence alignments from a result database (one MSA per query).

### Metadata
- **Docker Image**: quay.io/biocontainers/foldseek:10.941cd33--h5021889_1
- **Homepage**: https://github.com/steineggerlab/foldseek
- **Package**: https://anaconda.org/channels/bioconda/packages/foldseek/overview
- **Validation**: PASS

### Original Help Text
```text
usage: foldseek result2msa <i:queryDB> <i:targetDB> <i:resultDB> <o:msaDB> [options]
 By Martin Steinegger (martin.steinegger@snu.ac.kr) & Milot Mirdita <milot@mirdita.de> & Clovis Galiez
options: prefilter:                  
 --comp-bias-corr INT         Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT Correct for locally biased amino acid composition (range 0-1) [1.000]
align:                      
 --gap-open TWIN              Gap open cost [aa:10,nucl:10]
 --gap-extend TWIN            Gap extension cost [aa:1,nucl:1]
profile:                    
 --filter-msa INT             Filter msa: 0: do not filter, 1: filter [0]
 --filter-min-enable INT      Only filter MSAs with more than N sequences, 0 always filters [0]
 --max-seq-id FLOAT           Reduce redundancy of output MSA using max. pairwise sequence identity [0.0,1.0] [0.900]
 --qid STR                    Reduce diversity of output MSAs using min.seq. identity with query sequences [0.0,1.0]
                              Alternatively, can be a list of multiple thresholds:
                              E.g.: 0.15,0.30,0.50 to defines filter buckets of ]0.15-0.30] and ]0.30-0.50] [0.0]
 --qsc FLOAT                  Reduce diversity of output MSAs using min. score per aligned residue with query sequences [-50.0,100.0] [-20.000]
 --cov FLOAT                  Filter output MSAs using min. fraction of query residues covered by matched sequences [0.0,1.0] [0.000]
 --diff INT                   Filter MSAs by selecting most diverse set of sequences, keeping at least this many seqs in each MSA block of length 50 [1000]
misc:                       
 --allow-deletion BOOL        Allow deletions in a MSA [0]
 --msa-format-mode INT        Format MSA as: 0: binary cA3M DB
                              1: binary ca3m w. consensus DB
                              2: aligned FASTA DB
                              3: aligned FASTA w. header summary
                              4: STOCKHOLM flat file
                              5: A3M format
                              6: A3M format w. alignment info [2]
common:                     
 --sub-mat TWIN               Substitution matrix file [aa:3di.out,nucl:3di.out]
 --db-load-mode INT           Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                Number of CPU-cores used (all by default) [20]
 --compressed INT             Write compressed output [0]
 -v INT                       Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
expert:                     
 --summary-prefix STR         Set the cluster summary prefix [cl]
 --skip-query BOOL            Skip the query sequence [0]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## Metadata
- **Skill**: generated
