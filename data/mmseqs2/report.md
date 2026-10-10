# mmseqs2 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mmseqs2_cluster | PASS | 20000 proteins gave 5763 clusters; createtsv lists all 20000 members |
| mmseqs2_convertalis | PASS | alignment database converted to a BLAST-tab table with headers (694 hits); self hits at 100% identity |
| mmseqs2_createdb | PASS | 20000-protein UniProt FASTA gave a database with 20000 entries, headers and lookup file |
| mmseqs2_createindex | PASS | built the k-mer index (db.idx) for the 20000-protein database; a search on it gives the same hits as without index; index is about 970 MB |
| mmseqs2_createtsv | PASS | cluster database written as a table; give the target database to get sequence names instead of numeric keys |
| mmseqs2_easy-cluster | PASS | 20000 proteins clustered into 5760 clusters; cluster table, all-sequence and representative FASTA files all agree |
| mmseqs2_easy-linclust | PASS | 20000 proteins clustered into 15119 clusters by linear-time clustering; table and FASTA files agree |
| mmseqs2_easy-search | PASS | 30 real UniProt queries against 20000 UniProt proteins (MMseqs2 examples) gave 694 hits in 28 queries; the same pairs as search plus convertalis; self hits at 100% identity |
| mmseqs2_easy-taxonomy | PASS | synthetic data: tiny taxonomy database (11 real UniProt proteins, 64-node taxdump) made with createtaxdb; SARS-CoV spike, human ACE2 and E. coli HslV got the right taxa |
| mmseqs2_linclust | PASS | 20000 proteins gave 15118 clusters at 90% identity; createtsv lists all 20000 members |
| mmseqs2_result2flat | PASS | cluster sequence file (from createseqfiledb) written as FASTA with 20000 members under 5763 cluster headers |
| mmseqs2_search | PASS | 30 queries against the 20000-protein database gave an alignment database with 30 entries |

## mmseqs2_easy-search

### Tool Description
Sensitive homology search

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs easy-search <i:queryFastaFile1[.gz|.bz2]> ... <i:queryFastaFileN[.gz|.bz2]>|<i:stdin> <i:targetFastaFile[.gz]>|<i:targetDB> <o:alignmentFile> <tmpDir> [options]
 By Milot Mirdita <milot@mirdita.de> & Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                      
 --comp-bias-corr INT             Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT     Correct for locally biased amino acid composition (range 0-1) [1.000]
 --add-self-matches BOOL          Artificially add entries of queries with themselves (for clustering) [0]
 --seed-sub-mat TWIN              Substitution matrix file for k-mer generation [aa:VTML80.out,nucl:nucleotide.out]
 -s FLOAT                         Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [5.700]
 -k INT                           k-mer length (0: automatically set to optimum) [0]
 --target-search-mode INT         target search mode (0: regular k-mer, 1: similar k-mer) [0]
 --k-score TWIN                   k-mer threshold for generating similar k-mer lists [seq:2147483647,prof:2147483647]
 --alph-size TWIN                 Alphabet size (range 2-21) [aa:21,nucl:5]
 --max-seqs INT                   Maximum results per query sequence allowed to pass the prefilter (affects sensitivity) [300]
 --split INT                      Split input into N equally distributed chunks. 0: set the best split automatically [0]
 --split-mode INT                 0: split target db; 1: split query db; 2: auto, depending on main memory [2]
 --split-memory-limit BYTE        Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
 --diag-score BOOL                Use ungapped diagonal scoring during prefilter [1]
 --exact-kmer-matching INT        Extract only exact k-mers for matching (range 0-1) [0]
 --mask INT                       Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [1]
 --mask-prob FLOAT                Mask sequences is probablity is above threshold [0.900]
 --mask-lower-case INT            Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
 --mask-n-repeat INT              Repeat letters that occure > threshold in a rwo [0]
 --min-ungapped-score INT         Accept only matches with ungapped alignment score above threshold [15]
 --spaced-kmer-mode INT           0: use consecutive positions in k-mers; 1: use spaced k-mers [1]
 --spaced-kmer-pattern STR        User-specified spaced k-mer pattern []
 --local-tmp STR                  Path where some of the temporary files will be created []
 --disk-space-limit BYTE          Set max disk space to use for reverse profile searches. E.g. 800B, 5K, 10M, 1G. Default (0) to all available disk space in the temp folder [0]
align:                          
 -a BOOL                          Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --alignment-mode INT             How to compute the alignment:
                                  0: automatic
                                  1: only score and end_pos
                                  2: also start_pos and cov
                                  3: also seq.id
                                  4: only ungapped alignment [3]
 --alignment-output-mode INT      How to compute the alignment:
                                  0: automatic
                                  1: only score and end_pos
                                  2: also start_pos and cov
                                  3: also seq.id
                                  4: only ungapped alignment
                                  5: score only (output) cluster format [0]
 --wrapped-scoring BOOL           Double the (nucleotide) query sequence during the scoring process to allow wrapped diagonal scoring around end and start [0]
 -e DOUBLE                        List matches below this E-value (range 0.0-inf) [1.000E-03]
 --min-seq-id FLOAT               List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 --min-aln-len INT                Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT                0: alignment length 1: shorter, 2: longer sequence [0]
 --alt-ali INT                    Show up to this many alternative alignments [0]
 -c FLOAT                         List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --cov-mode INT                   0: coverage of query and target
                                  1: coverage of target
                                  2: coverage of query
                                  3: target seq. length has to be at least x% of query length
                                  4: query seq. length has to be at least x% of target length
                                  5: short seq. needs to be at least x% of the other seq. length [0]
 --max-rejected INT               Maximum rejected alignments before alignment calculation for a query is stopped [2147483647]
 --max-accept INT                 Maximum accepted alignments before alignment calculation for a query is stopped [2147483647]
 --score-bias FLOAT               Score bias when computing SW alignment (in bits) [0.000]
 --realign BOOL                   Compute more conservative, shorter alignments (scores and E-values not changed) [0]
 --realign-score-bias FLOAT       Additional bias when computing realignment [-0.200]
 --realign-max-seqs INT           Maximum number of results to return in realignment [2147483647]
 --corr-score-weight FLOAT        Weight of backtrace correlation score that is added to the alignment score [0.000]
 --gap-open TWIN                  Gap open cost [aa:11,nucl:5]
 --gap-extend TWIN                Gap extension cost [aa:1,nucl:2]
 --zdrop INT                      Maximal allowed difference between score values before alignment is truncated  (nucleotide alignment only) [40]
 --exhaustive-search-filter INT   Filter result during search: 0: do not filter, 1: filter [0]
profile:                        
 --pca                            Pseudo count admixture strength []
 --pcb                            Pseudo counts: Neff at half of maximum admixture (range 0.0-inf) []
 --mask-profile INT               Mask query sequence of profile using tantan [0,1] [1]
 --e-profile DOUBLE               Include sequences matches with < E-value thr. into the profile (>=0.0) [1.000E-03]
 --wg BOOL                        Use global sequence weighting for profile calculation [0]
 --filter-msa INT                 Filter msa: 0: do not filter, 1: filter [1]
 --filter-min-enable INT          Only filter MSAs with more than N sequences, 0 always filters [0]
 --max-seq-id FLOAT               Reduce redundancy of output MSA using max. pairwise sequence identity [0.0,1.0] [0.900]
 --qid STR                        Reduce diversity of output MSAs using min.seq. identity with query sequences [0.0,1.0]
                                  Alternatively, can be a list of multiple thresholds:
                                  E.g.: 0.15,0.30,0.50 to defines filter buckets of ]0.15-0.30] and ]0.30-0.50] [0.0]
 --qsc FLOAT                      Reduce diversity of output MSAs using min. score per aligned residue with query sequences [-50.0,100.0] [-20.000]
 --cov FLOAT                      Filter output MSAs using min. fraction of query residues covered by matched sequences [0.0,1.0] [0.000]
 --diff INT                       Filter MSAs by selecting most diverse set of sequences, keeping at least this many seqs in each MSA block of length 50 [1000]
 --pseudo-cnt-mode INT            use 0: substitution-matrix or 1: context-specific pseudocounts [0]
 --profile-output-mode INT        Profile output mode: 0: binary log-odds 1: human-readable frequencies [0]
 --num-iterations INT             Number of iterative profile search iterations [1]
 --exhaustive-search BOOL         For bigger profile DB, run iteratively the search by greedily swapping the search results [0]
 --lca-search BOOL                Efficient search for LCA candidates [0]
misc:                           
 --taxon-list STR                 Taxonomy ID, possibly multiple values separated by ',' []
 --prefilter-mode INT             prefilter mode: 0: kmer/ungapped 1: ungapped, 2: nofilter, 3: ungapped&gapped [0]
 --rescore-mode INT               Rescore diagonals with:
                                  0: Hamming distance
                                  1: local alignment (score only)
                                  2: local alignment
                                  3: global alignment
                                  4: longest alignment fulfilling window quality criterion [0]
 --allow-deletion BOOL            Allow deletions in a MSA [0]
 --min-length INT                 Minimum codon number in open reading frames [30]
 --max-length INT                 Maximum codon number in open reading frames [32734]
 --max-gaps INT                   Maximum number of codons with gaps or unknown residues before an open reading frame is rejected [2147483647]
 --contig-start-mode INT          Contig start can be 0: incomplete, 1: complete, 2: both [2]
 --contig-end-mode INT            Contig end can be 0: incomplete, 1: complete, 2: both [2]
 --orf-start-mode INT             Orf fragment can be 0: from start to stop, 1: from any to stop, 2: from last encountered start to stop (no start in the middle) [1]
 --forward-frames STR             Comma-separated list of frames on the forward strand to be extracted [1,2,3]
 --reverse-frames STR             Comma-separated list of frames on the reverse strand to be extracted [1,2,3]
 --translation-table INT          1) CANONICAL, 2) VERT_MITOCHONDRIAL, 3) YEAST_MITOCHONDRIAL, 4) MOLD_MITOCHONDRIAL, 5) INVERT_MITOCHONDRIAL, 6) CILIATE
                                  9) FLATWORM_MITOCHONDRIAL, 10) EUPLOTID, 11) PROKARYOTE, 12) ALT_YEAST, 13) ASCIDIAN_MITOCHONDRIAL, 14) ALT_FLATWORM_MITOCHONDRIAL
                                  15) BLEPHARISMA, 16) CHLOROPHYCEAN_MITOCHONDRIAL, 21) TREMATODE_MITOCHONDRIAL, 22) SCENEDESMUS_MITOCHONDRIAL
                                  23) THRAUSTOCHYTRIUM_MITOCHONDRIAL, 24) PTEROBRANCHIA_MITOCHONDRIAL, 25) GRACILIBACTERIA, 26) PACHYSOLEN, 27) KARYORELICT, 28) CONDYLOSTOMA
                                   29) MESODINIUM, 30) PERTRICH, 31) BLASTOCRITHIDIA [1]
 --translate INT                  Translate ORF to amino acid [0]
 --use-all-table-starts BOOL      Use all alternatives for a start codon in the genetic table, if false - only ATG (AUG) [0]
 --id-offset INT                  Numeric ids in index file are offset by this value [0]
 --sequence-overlap INT           Overlap between sequences [0]
 --sequence-split-mode INT        Sequence split mode 0: copy data, 1: soft link data and write new index, [1]
 --headers-split-mode INT         Header split mode: 0: split position, 1: original header [0]
 --search-type INT                Search type 0: auto 1: amino acid, 2: translated, 3: nucleotide, 4: translated nucleotide alignment [0]
 --start-sens FLOAT               Start sensitivity [4.000]
 --sens-steps INT                 Number of search steps performed from --start-sens to -s [1]
 --translation-mode INT           Translation AA seq from nucleotide by 0: ORFs, 1: full reading frames [0]
 --format-mode INT                Output format:
                                  0: BLAST-TAB
                                  1: SAM
                                  2: BLAST-TAB + query/db length
                                  3: Pretty HTML
                                  4: BLAST-TAB + column headers
                                  BLAST-TAB (0) and BLAST-TAB + column headers (4) support custom output formats (--format-output) [0]
 --format-output STR              Choose comma separated list of output columns from: query,target,evalue,gapopen,pident,fident,nident,qstart,qend,qlen
                                  tstart,tend,tlen,alnlen,raw,bits,cigar,qseq,tseq,qheader,theader,qaln,taln,qframe,tframe,mismatch,qcov,tcov
                                  qset,qsetid,tset,tsetid,taxid,taxname,taxlineage,qorfstart,qorfend,torfstart,torfend,ppos [query,target,fident,alnlen,mismatch,gapopen,qstart,qend,tstart,tend,evalue,bits]
 --overlap FLOAT                  Maximum overlap of covered regions [0.000]
 --dbtype INT                     Database type 0: auto, 1: amino acid 2: nucleotides [0]
 --shuffle BOOL                   Shuffle input database [1]
 --createdb-mode INT              Createdb mode 0: copy data, 1: soft link data and write new index (works only with single line fasta/q) 2: GPU compatible db [0]
 --greedy-best-hits BOOL          Choose the best hits greedily to cover the query [0]
common:                         
 --sub-mat TWIN                   Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT                Maximum sequence length [65535]
 --db-load-mode INT               Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                    Number of CPU-cores used (all by default) [20]
 --compressed INT                 Write compressed output [0]
 -v INT                           Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --gpu INT                        Use GPU (CUDA) if possible [0]
 --gpu-server INT                 Use GPU server [0]
 --gpu-server-wait-timeout INT    Wait for GPU server for 0: don't wait -1: no wait limit: >0 this many seconds [600]
 --mpi-runner STR                 Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42") []
 --force-reuse BOOL               Reuse tmp filse in tmp/latest folder ignoring parameters and version changes [0]
 --remove-tmp-files BOOL          Delete temporary files [1]
expert:                         
 --filter-hits BOOL               Filter hits by seq.id. and coverage [0]
 --sort-results INT               Sort results: 0: no sorting, 1: sort by E-value (Alignment) or seq.id. (Hamming) [0]
 --create-lookup INT              Create database lookup file (can be very large) [0]
 --chain-alignments INT           Chain overlapping alignments [0]
 --merge-query INT                Combine ORFs/split sequences to a single entry [1]
 --strand INT                     Strand selection only works for DNA/DNA search 0: reverse, 1: forward, 2: both [1]
 --db-output BOOL                 Return a result DB instead of a text file [0]
 --write-lookup INT               write .lookup file containing mapping from internal id, fasta id and file number [0]

examples:
 # Search multiple FASTA against FASTA (like BLASTP, TBLASTN, BLASTX, BLASTN --search-type 3, TBLASTX --search-type 2)
 mmseqs easy-search examples/QUERY.fasta examples/QUERY.fasta examples/DB.fasta result.m8 tmp
 
 # Iterative profile search from stdin (like PSI-BLAST)
 cat examples/QUERY.fasta | mmseqs easy-search stdin examples/DB.fasta result.m8 tmp --num-iterations 2
 
 # Profile search against small databases (e.g. PFAM, eggNOG)
 mmseqs databases PFAM pfam_db tmp
 mmseqs easy-search examples/QUERY.fasta pfam_db res.m8 tmp
 
 # Exhaustive search against sequences or profiles (works for large DBs)
 mmseqs easy-search examples/QUERY.fasta targetProfiles res.m8 tmp --exhaustive-search
 
 # Increasing sensitivity search (from 2 to 7 in 3 steps)
 mmseqs easy-search examples/QUERY.fasta examples/DB.fasta result.m8 tmp --start-sens 2 -s 7 --sens-steps 3
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Mirdita M, Steinegger M, Soding J: MMseqs2 desktop and local web server app for fast, interactive sequence searches. Bioinformatics, 35(16), 2856-2858 (2019)
 - Kallenborn F, Chacon A, Hundt C, Sirelkhatim H, Didi K, Dallago C, Mirdita M, Schmidt B, Steinegger M: GPU-accelerated homology search with MMseqs2. bioRxiv, 2024.11.13.623350 (2024)
```

## mmseqs2_easy-cluster

### Tool Description
Slower, sensitive clustering

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs easy-cluster <i:fastaFile1[.gz|.bz2]> ... <i:fastaFileN[.gz|.bz2]> <o:clusterPrefix> <tmpDir> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                      
 --seed-sub-mat TWIN              Substitution matrix file for k-mer generation [aa:VTML80.out,nucl:nucleotide.out]
 -s FLOAT                         Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [4.000]
 -k INT                           k-mer length (0: automatically set to optimum) [0]
 --target-search-mode INT         target search mode (0: regular k-mer, 1: similar k-mer) [0]
 --k-score TWIN                   k-mer threshold for generating similar k-mer lists [seq:2147483647,prof:2147483647]
 --alph-size TWIN                 Alphabet size (range 2-21) [aa:21,nucl:5]
 --max-seqs INT                   Maximum results per query sequence allowed to pass the prefilter (affects sensitivity) [20]
 --split INT                      Split input into N equally distributed chunks. 0: set the best split automatically [0]
 --split-mode INT                 0: split target db; 1: split query db; 2: auto, depending on main memory [2]
 --split-memory-limit BYTE        Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
 --comp-bias-corr INT             Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT     Correct for locally biased amino acid composition (range 0-1) [1.000]
 --diag-score BOOL                Use ungapped diagonal scoring during prefilter [1]
 --exact-kmer-matching INT        Extract only exact k-mers for matching (range 0-1) [0]
 --mask INT                       Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [1]
 --mask-prob FLOAT                Mask sequences is probablity is above threshold [0.900]
 --mask-lower-case INT            Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
 --mask-n-repeat INT              Repeat letters that occure > threshold in a rwo [0]
 --min-ungapped-score INT         Accept only matches with ungapped alignment score above threshold [15]
 --add-self-matches BOOL          Artificially add entries of queries with themselves (for clustering) [0]
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
 -a BOOL                          Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --alignment-mode INT             How to compute the alignment:
                                  0: automatic
                                  1: only score and end_pos
                                  2: also start_pos and cov
                                  3: also seq.id
                                  4: only ungapped alignment [3]
 --alignment-output-mode INT      How to compute the alignment:
                                  0: automatic
                                  1: only score and end_pos
                                  2: also start_pos and cov
                                  3: also seq.id
                                  4: only ungapped alignment
                                  5: score only (output) cluster format [0]
 --wrapped-scoring BOOL           Double the (nucleotide) query sequence during the scoring process to allow wrapped diagonal scoring around end and start [0]
 -e DOUBLE                        List matches below this E-value (range 0.0-inf) [1.000E-03]
 --min-seq-id FLOAT               List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 --min-aln-len INT                Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT                0: alignment length 1: shorter, 2: longer sequence [0]
 --alt-ali INT                    Show up to this many alternative alignments [0]
 --max-rejected INT               Maximum rejected alignments before alignment calculation for a query is stopped [2147483647]
 --max-accept INT                 Maximum accepted alignments before alignment calculation for a query is stopped [2147483647]
 --score-bias FLOAT               Score bias when computing SW alignment (in bits) [0.000]
 --realign BOOL                   Compute more conservative, shorter alignments (scores and E-values not changed) [0]
 --realign-score-bias FLOAT       Additional bias when computing realignment [-0.200]
 --realign-max-seqs INT           Maximum number of results to return in realignment [2147483647]
 --corr-score-weight FLOAT        Weight of backtrace correlation score that is added to the alignment score [0.000]
 --gap-open TWIN                  Gap open cost [aa:11,nucl:5]
 --gap-extend TWIN                Gap extension cost [aa:1,nucl:2]
 --zdrop INT                      Maximal allowed difference between score values before alignment is truncated  (nucleotide alignment only) [40]
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
profile:                        
 --pca                            Pseudo count admixture strength []
 --pcb                            Pseudo counts: Neff at half of maximum admixture (range 0.0-inf) []
misc:                           
 --taxon-list STR                 Taxonomy ID, possibly multiple values separated by ',' []
 --rescore-mode INT               Rescore diagonals with:
                                  0: Hamming distance
                                  1: local alignment (score only)
                                  2: local alignment
                                  3: global alignment
                                  4: longest alignment fulfilling window quality criterion [0]
 --dbtype INT                     Database type 0: auto, 1: amino acid 2: nucleotides [0]
 --shuffle BOOL                   Shuffle input database [1]
 --createdb-mode INT              Createdb mode 0: copy data, 1: soft link data and write new index (works only with single line fasta/q) 2: GPU compatible db [1]
 --id-offset INT                  Numeric ids in index file are offset by this value [0]
common:                         
 --sub-mat TWIN                   Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT                Maximum sequence length [65535]
 --db-load-mode INT               Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                    Number of CPU-cores used (all by default) [20]
 --compressed INT                 Write compressed output [0]
 -v INT                           Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --remove-tmp-files BOOL          Delete temporary files [1]
 --force-reuse BOOL               Reuse tmp filse in tmp/latest folder ignoring parameters and version changes [0]
 --mpi-runner STR                 Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42") []
 --gpu INT                        Use GPU (CUDA) if possible [0]
expert:                         
 --filter-hits BOOL               Filter hits by seq.id. and coverage [0]
 --sort-results INT               Sort results: 0: no sorting, 1: sort by E-value (Alignment) or seq.id. (Hamming) [0]
 --write-lookup INT               write .lookup file containing mapping from internal id, fasta id and file number [0]

examples:
 mmseqs easy-cluster examples/DB.fasta result tmp
 # Cluster output
 #  - result_rep_seq.fasta:  Representatives
 #  - result_all_seqs.fasta: FASTA-like per cluster
 #  - result_cluster.tsv:    Adjacency list
 
 # Important parameter: --min-seq-id, --cov-mode and -c 
 #                  --cov-mode 
 #                  0    1    2
 # Q: MAVGTACRPA  60%  IGN  60%
 # T: -AVGTAC---  60% 100%  IGN
 #        -c 0.7    -    +    -
 #        -c 0.6    +    +    +
 
 # Cascaded clustering with reassignment
 # - Corrects criteria-violations of cascaded merging
 # - Produces more clusters and is a bit slower
 mmseqs easy-cluster examples/DB.fasta result tmp --cluster-reassign
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Steinegger M, Soding J: Clustering huge protein sequence sets in linear time. Nature Communications, 9(1), 2542 (2018)
```

## mmseqs2_easy-linclust

### Tool Description
Fast linear time cluster, less sensitive clustering

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs easy-linclust <i:fastaFile1[.gz|.bz2]> ... <i:fastaFileN[.gz|.bz2]> <o:clusterPrefix> <tmpDir> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                      
 --comp-bias-corr INT             Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT     Correct for locally biased amino acid composition (range 0-1) [1.000]
 --add-self-matches BOOL          Artificially add entries of queries with themselves (for clustering) [0]
 --alph-size TWIN                 Alphabet size (range 2-21) [aa:21,nucl:5]
 --spaced-kmer-mode INT           0: use consecutive positions in k-mers; 1: use spaced k-mers [0]
 --spaced-kmer-pattern STR        User-specified spaced k-mer pattern []
 --mask INT                       Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [1]
 --mask-prob FLOAT                Mask sequences is probablity is above threshold [0.900]
 --mask-lower-case INT            Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
 --mask-n-repeat INT              Repeat letters that occure > threshold in a rwo [0]
 -k INT                           k-mer length (0: automatically set to optimum) [0]
 --split-memory-limit BYTE        Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
align:                          
 -a BOOL                          Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --alignment-mode INT             How to compute the alignment:
                                  0: automatic
                                  1: only score and end_pos
                                  2: also start_pos and cov
                                  3: also seq.id
                                  4: only ungapped alignment [0]
 --alignment-output-mode INT      How to compute the alignment:
                                  0: automatic
                                  1: only score and end_pos
                                  2: also start_pos and cov
                                  3: also seq.id
                                  4: only ungapped alignment
                                  5: score only (output) cluster format [0]
 --wrapped-scoring BOOL           Double the (nucleotide) query sequence during the scoring process to allow wrapped diagonal scoring around end and start [0]
 -e DOUBLE                        List matches below this E-value (range 0.0-inf) [1.000E-03]
 --min-seq-id FLOAT               List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 --min-aln-len INT                Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT                0: alignment length 1: shorter, 2: longer sequence [0]
 --alt-ali INT                    Show up to this many alternative alignments [0]
 -c FLOAT                         List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.800]
 --cov-mode INT                   0: coverage of query and target
                                  1: coverage of target
                                  2: coverage of query
                                  3: target seq. length has to be at least x% of query length
                                  4: query seq. length has to be at least x% of target length
                                  5: short seq. needs to be at least x% of the other seq. length [0]
 --max-rejected INT               Maximum rejected alignments before alignment calculation for a query is stopped [2147483647]
 --max-accept INT                 Maximum accepted alignments before alignment calculation for a query is stopped [2147483647]
 --score-bias FLOAT               Score bias when computing SW alignment (in bits) [0.000]
 --realign BOOL                   Compute more conservative, shorter alignments (scores and E-values not changed) [0]
 --realign-score-bias FLOAT       Additional bias when computing realignment [-0.200]
 --realign-max-seqs INT           Maximum number of results to return in realignment [2147483647]
 --corr-score-weight FLOAT        Weight of backtrace correlation score that is added to the alignment score [0.000]
 --gap-open TWIN                  Gap open cost [aa:11,nucl:5]
 --gap-extend TWIN                Gap extension cost [aa:1,nucl:2]
 --zdrop INT                      Maximal allowed difference between score values before alignment is truncated  (nucleotide alignment only) [40]
clust:                          
 --cluster-mode INT               0: Set-Cover (greedy)
                                  1: Connected component (BLASTclust)
                                  2,3: Greedy clustering by sequence length (CDHIT) [0]
 --max-iterations INT             Maximum depth of breadth first search in connected component clustering [1000]
 --similarity-type INT            Type of score used for clustering. 1: alignment score 2: sequence identity [2]
kmermatcher:                    
 --weights STR                    Weights used for cluster priorization []
 --cluster-weight-threshold FLOAT Weight threshold used for cluster priorization [0.900]
 --kmer-per-seq INT               k-mers per sequence [21]
 --kmer-per-seq-scale TWIN        Scale k-mer per sequence based on sequence length as kmer-per-seq val + scale x seqlen [aa:0.000,nucl:0.200]
 --adjust-kmer-len BOOL           Adjust k-mer length based on specificity (only for nucleotides) [0]
 --hash-shift INT                 Shift k-mer hash initialization [67]
 --include-only-extendable BOOL   Include only extendable [0]
 --ignore-multi-kmer BOOL         Skip k-mers occurring multiple times (>=2) [0]
profile:                        
 --pca                            Pseudo count admixture strength []
 --pcb                            Pseudo counts: Neff at half of maximum admixture (range 0.0-inf) []
misc:                           
 --rescore-mode INT               Rescore diagonals with:
                                  0: Hamming distance
                                  1: local alignment (score only)
                                  2: local alignment
                                  3: global alignment
                                  4: longest alignment fulfilling window quality criterion [0]
 --dbtype INT                     Database type 0: auto, 1: amino acid 2: nucleotides [0]
 --shuffle BOOL                   Shuffle input database [1]
 --createdb-mode INT              Createdb mode 0: copy data, 1: soft link data and write new index (works only with single line fasta/q) 2: GPU compatible db [1]
 --id-offset INT                  Numeric ids in index file are offset by this value [0]
common:                         
 --threads INT                    Number of CPU-cores used (all by default) [20]
 --compressed INT                 Write compressed output [0]
 -v INT                           Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --sub-mat TWIN                   Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT                Maximum sequence length [65535]
 --db-load-mode INT               Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --remove-tmp-files BOOL          Delete temporary files [1]
 --force-reuse BOOL               Reuse tmp filse in tmp/latest folder ignoring parameters and version changes [0]
 --mpi-runner STR                 Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42") []
 --gpu INT                        Use GPU (CUDA) if possible [0]
expert:                         
 --filter-hits BOOL               Filter hits by seq.id. and coverage [0]
 --sort-results INT               Sort results: 0: no sorting, 1: sort by E-value (Alignment) or seq.id. (Hamming) [0]
 --write-lookup INT               write .lookup file containing mapping from internal id, fasta id and file number [0]

examples:
 mmseqs easy-linclust examples/DB.fasta result tmp
 
 # Linclust output
 #  - result_rep_seq.fasta:  Representatives
 #  - result_all_seqs.fasta: FASTA-like per cluster
 #  - result_cluster.tsv:    Adjecency list
 
 # Important parameter: --min-seq-id, --cov-mode and -c 
 #                  --cov-mode 
 #                  0    1    2
 # Q: MAVGTACRPA  60%  IGN  60%
 # T: -AVGTAC---  60% 100%  IGN
 #        -c 0.7    -    +    -
 #        -c 0.6    +    +    +
 
 # Cluster nucleotide sequences 
 mmseqs easy-linclust examples/DB.fasta result tmp --kmer-per-seq-scale 0.3
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Steinegger M, Soding J: Clustering huge protein sequence sets in linear time. Nature Communications, 9(1), 2542 (2018)
```

## mmseqs2_easy-taxonomy

### Tool Description
Taxonomic classification

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs easy-taxonomy <i:fastaFile1[.gz|.bz2]> ... <i:fastaFileN[.gz|.bz2]> <i:targetDB> <o:taxReports> <tmpDir> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                      
 --comp-bias-corr INT             Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT     Correct for locally biased amino acid composition (range 0-1) [1.000]
 --add-self-matches BOOL          Artificially add entries of queries with themselves (for clustering) [0]
 --seed-sub-mat TWIN              Substitution matrix file for k-mer generation [aa:VTML80.out,nucl:nucleotide.out]
 -s FLOAT                         Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [4.000]
 -k INT                           k-mer length (0: automatically set to optimum) [0]
 --target-search-mode INT         target search mode (0: regular k-mer, 1: similar k-mer) [0]
 --k-score TWIN                   k-mer threshold for generating similar k-mer lists [seq:2147483647,prof:2147483647]
 --alph-size TWIN                 Alphabet size (range 2-21) [aa:21,nucl:5]
 --max-seqs INT                   Maximum results per query sequence allowed to pass the prefilter (affects sensitivity) [300]
 --split INT                      Split input into N equally distributed chunks. 0: set the best split automatically [0]
 --split-mode INT                 0: split target db; 1: split query db; 2: auto, depending on main memory [2]
 --split-memory-limit BYTE        Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
 --diag-score BOOL                Use ungapped diagonal scoring during prefilter [1]
 --exact-kmer-matching INT        Extract only exact k-mers for matching (range 0-1) [0]
 --mask INT                       Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [1]
 --mask-prob FLOAT                Mask sequences is probablity is above threshold [0.900]
 --mask-lower-case INT            Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
 --mask-n-repeat INT              Repeat letters that occure > threshold in a rwo [0]
 --min-ungapped-score INT         Accept only matches with ungapped alignment score above threshold [15]
 --spaced-kmer-mode INT           0: use consecutive positions in k-mers; 1: use spaced k-mers [1]
 --spaced-kmer-pattern STR        User-specified spaced k-mer pattern []
 --local-tmp STR                  Path where some of the temporary files will be created []
 --disk-space-limit BYTE          Set max disk space to use for reverse profile searches. E.g. 800B, 5K, 10M, 1G. Default (0) to all available disk space in the temp folder [0]
align:                          
 -a BOOL                          Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --alignment-mode INT             How to compute the alignment:
                                  0: automatic
                                  1: only score and end_pos
                                  2: also start_pos and cov
                                  3: also seq.id
                                  4: only ungapped alignment [0]
 --alignment-output-mode INT      How to compute the alignment:
                                  0: automatic
                                  1: only score and end_pos
                                  2: also start_pos and cov
                                  3: also seq.id
                                  4: only ungapped alignment
                                  5: score only (output) cluster format [0]
 --wrapped-scoring BOOL           Double the (nucleotide) query sequence during the scoring process to allow wrapped diagonal scoring around end and start [0]
 -e DOUBLE                        List matches below this E-value (range 0.0-inf) [1.000E-03]
 --min-seq-id FLOAT               List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 --min-aln-len INT                Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT                0: alignment length 1: shorter, 2: longer sequence [0]
 --alt-ali INT                    Show up to this many alternative alignments [0]
 -c FLOAT                         List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --cov-mode INT                   0: coverage of query and target
                                  1: coverage of target
                                  2: coverage of query
                                  3: target seq. length has to be at least x% of query length
                                  4: query seq. length has to be at least x% of target length
                                  5: short seq. needs to be at least x% of the other seq. length [0]
 --max-rejected INT               Maximum rejected alignments before alignment calculation for a query is stopped [2147483647]
 --max-accept INT                 Maximum accepted alignments before alignment calculation for a query is stopped [2147483647]
 --score-bias FLOAT               Score bias when computing SW alignment (in bits) [0.000]
 --realign BOOL                   Compute more conservative, shorter alignments (scores and E-values not changed) [0]
 --realign-score-bias FLOAT       Additional bias when computing realignment [-0.200]
 --realign-max-seqs INT           Maximum number of results to return in realignment [2147483647]
 --corr-score-weight FLOAT        Weight of backtrace correlation score that is added to the alignment score [0.000]
 --gap-open TWIN                  Gap open cost [aa:11,nucl:5]
 --gap-extend TWIN                Gap extension cost [aa:1,nucl:2]
 --zdrop INT                      Maximal allowed difference between score values before alignment is truncated  (nucleotide alignment only) [40]
 --exhaustive-search-filter INT   Filter result during search: 0: do not filter, 1: filter [0]
profile:                        
 --pca                            Pseudo count admixture strength []
 --pcb                            Pseudo counts: Neff at half of maximum admixture (range 0.0-inf) []
 --mask-profile INT               Mask query sequence of profile using tantan [0,1] [1]
 --e-profile DOUBLE               Include sequences matches with < E-value thr. into the profile (>=0.0) [1.000E-03]
 --wg BOOL                        Use global sequence weighting for profile calculation [0]
 --filter-msa INT                 Filter msa: 0: do not filter, 1: filter [1]
 --filter-min-enable INT          Only filter MSAs with more than N sequences, 0 always filters [0]
 --max-seq-id FLOAT               Reduce redundancy of output MSA using max. pairwise sequence identity [0.0,1.0] [0.900]
 --qid STR                        Reduce diversity of output MSAs using min.seq. identity with query sequences [0.0,1.0]
                                  Alternatively, can be a list of multiple thresholds:
                                  E.g.: 0.15,0.30,0.50 to defines filter buckets of ]0.15-0.30] and ]0.30-0.50] [0.0]
 --qsc FLOAT                      Reduce diversity of output MSAs using min. score per aligned residue with query sequences [-50.0,100.0] [-20.000]
 --cov FLOAT                      Filter output MSAs using min. fraction of query residues covered by matched sequences [0.0,1.0] [0.000]
 --diff INT                       Filter MSAs by selecting most diverse set of sequences, keeping at least this many seqs in each MSA block of length 50 [1000]
 --pseudo-cnt-mode INT            use 0: substitution-matrix or 1: context-specific pseudocounts [0]
 --profile-output-mode INT        Profile output mode: 0: binary log-odds 1: human-readable frequencies [0]
 --exhaustive-search BOOL         For bigger profile DB, run iteratively the search by greedily swapping the search results [0]
 --lca-search BOOL                Efficient search for LCA candidates [0]
misc:                           
 --orf-filter INT                 Prefilter query ORFs with non-selective search
                                  Only used during nucleotide-vs-protein classification
                                  NOTE: Consider disabling when classifying short reads [0]
 --orf-filter-e DOUBLE            E-value threshold used for query ORF prefiltering [1.000E+02]
 --orf-filter-s FLOAT             Sensitivity used for query ORF prefiltering [2.000]
 --lca-mode INT                   LCA Mode 1: single search LCA , 2/3: approximate 2bLCA, 4: top hit [3]
 --majority FLOAT                 minimal fraction of agreement among taxonomically assigned sequences of a set [0.500]
 --vote-mode INT                  Mode of assigning weights to compute majority. 0: uniform, 1: minus log E-value, 2: score [1]
 --lca-ranks STR                  Add column with specified ranks (',' separated) []
 --tax-lineage INT                0: don't show, 1: add all lineage names, 2: add all lineage taxids [0]
 --blacklist STR                  Comma separated list of ignored taxa in LCA computation [12908:unclassified sequences,28384:other sequences]
 --taxon-list STR                 Taxonomy ID, possibly multiple values separated by ',' []
 --prefilter-mode INT             prefilter mode: 0: kmer/ungapped 1: ungapped, 2: nofilter, 3: ungapped&gapped [0]
 --rescore-mode INT               Rescore diagonals with:
                                  0: Hamming distance
                                  1: local alignment (score only)
                                  2: local alignment
                                  3: global alignment
                                  4: longest alignment fulfilling window quality criterion [0]
 --allow-deletion BOOL            Allow deletions in a MSA [0]
 --min-length INT                 Minimum codon number in open reading frames [30]
 --max-length INT                 Maximum codon number in open reading frames [32734]
 --max-gaps INT                   Maximum number of codons with gaps or unknown residues before an open reading frame is rejected [2147483647]
 --contig-start-mode INT          Contig start can be 0: incomplete, 1: complete, 2: both [2]
 --contig-end-mode INT            Contig end can be 0: incomplete, 1: complete, 2: both [2]
 --orf-start-mode INT             Orf fragment can be 0: from start to stop, 1: from any to stop, 2: from last encountered start to stop (no start in the middle) [1]
 --forward-frames STR             Comma-separated list of frames on the forward strand to be extracted [1,2,3]
 --reverse-frames STR             Comma-separated list of frames on the reverse strand to be extracted [1,2,3]
 --translation-table INT          1) CANONICAL, 2) VERT_MITOCHONDRIAL, 3) YEAST_MITOCHONDRIAL, 4) MOLD_MITOCHONDRIAL, 5) INVERT_MITOCHONDRIAL, 6) CILIATE
                                  9) FLATWORM_MITOCHONDRIAL, 10) EUPLOTID, 11) PROKARYOTE, 12) ALT_YEAST, 13) ASCIDIAN_MITOCHONDRIAL, 14) ALT_FLATWORM_MITOCHONDRIAL
                                  15) BLEPHARISMA, 16) CHLOROPHYCEAN_MITOCHONDRIAL, 21) TREMATODE_MITOCHONDRIAL, 22) SCENEDESMUS_MITOCHONDRIAL
                                  23) THRAUSTOCHYTRIUM_MITOCHONDRIAL, 24) PTEROBRANCHIA_MITOCHONDRIAL, 25) GRACILIBACTERIA, 26) PACHYSOLEN, 27) KARYORELICT, 28) CONDYLOSTOMA
                                   29) MESODINIUM, 30) PERTRICH, 31) BLASTOCRITHIDIA [1]
 --translate INT                  Translate ORF to amino acid [0]
 --use-all-table-starts BOOL      Use all alternatives for a start codon in the genetic table, if false - only ATG (AUG) [0]
 --id-offset INT                  Numeric ids in index file are offset by this value [0]
 --sequence-overlap INT           Overlap between sequences [0]
 --sequence-split-mode INT        Sequence split mode 0: copy data, 1: soft link data and write new index, [1]
 --headers-split-mode INT         Header split mode: 0: split position, 1: original header [0]
 --search-type INT                Search type 0: auto 1: amino acid, 2: translated, 3: nucleotide, 4: translated nucleotide alignment [0]
 --translation-mode INT           Translation AA seq from nucleotide by 0: ORFs, 1: full reading frames [0]
 --report-mode INT                Taxonomy report mode
                                  0: Kraken
                                  1: Krona
                                  2: do not create a report (for workflows only)
                                  3: Kraken per query database [0]
 --format-mode INT                Output format:
                                  0: BLAST-TAB
                                  1: SAM
                                  2: BLAST-TAB + query/db length
                                  3: Pretty HTML
                                  4: BLAST-TAB + column headers
                                  BLAST-TAB (0) and BLAST-TAB + column headers (4) support custom output formats (--format-output) [0]
 --format-output STR              Choose comma separated list of output columns from: query,target,evalue,gapopen,pident,fident,nident,qstart,qend,qlen
                                  tstart,tend,tlen,alnlen,raw,bits,cigar,qseq,tseq,qheader,theader,qaln,taln,qframe,tframe,mismatch,qcov,tcov
                                  qset,qsetid,tset,tsetid,taxid,taxname,taxlineage,qorfstart,qorfend,torfstart,torfend,ppos [query,target,fident,alnlen,mismatch,gapopen,qstart,qend,tstart,tend,evalue,bits]
 --first-seq-as-repr BOOL         Use the first sequence of the clustering result as representative sequence [0]
 --target-column INT              Select a target column (default 1), 0 if no target id exists [1]
 --full-header BOOL               Replace DB ID by its corresponding Full Header [0]
 --idx-seq-src INT                0: auto, 1: split/translated sequences, 2: input sequences [0]
 --dbtype INT                     Database type 0: auto, 1: amino acid 2: nucleotides [0]
 --shuffle BOOL                   Shuffle input database [1]
 --createdb-mode INT              Createdb mode 0: copy data, 1: soft link data and write new index (works only with single line fasta/q) 2: GPU compatible db [1]
common:                         
 --compressed INT                 Write compressed output [0]
 --threads INT                    Number of CPU-cores used (all by default) [20]
 -v INT                           Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --sub-mat TWIN                   Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT                Maximum sequence length [65535]
 --db-load-mode INT               Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --gpu INT                        Use GPU (CUDA) if possible [0]
 --gpu-server INT                 Use GPU server [0]
 --gpu-server-wait-timeout INT    Wait for GPU server for 0: don't wait -1: no wait limit: >0 this many seconds [600]
 --mpi-runner STR                 Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42") []
 --force-reuse BOOL               Reuse tmp filse in tmp/latest folder ignoring parameters and version changes [0]
 --remove-tmp-files BOOL          Delete temporary files [1]
expert:                         
 --filter-hits BOOL               Filter hits by seq.id. and coverage [0]
 --sort-results INT               Sort results: 0: no sorting, 1: sort by E-value (Alignment) or seq.id. (Hamming) [0]
 --create-lookup INT              Create database lookup file (can be very large) [0]
 --chain-alignments INT           Chain overlapping alignments [0]
 --merge-query INT                Combine ORFs/split sequences to a single entry [1]
 --strand INT                     Strand selection only works for DNA/DNA search 0: reverse, 1: forward, 2: both [1]
 --db-output BOOL                 Return a result DB instead of a text file [0]
 --write-lookup INT               write .lookup file containing mapping from internal id, fasta id and file number [0]

examples:
 # Assign taxonomic labels to FASTA sequences
   - result_tophit_aln: top hits
   - result_tophit_report: coverage profiles per database entry
   - result_report: kraken style report
 # Download a sequence database with taxonomy information
 mmseqs databases UniProtKB/Swiss-Prot swissprotDB tmp
 
 # Assign taxonomy based on 2bLCA hit
 mmseqs easy-taxonomy examples/DB.fasta swissprotDB result tmp
 
 # Assign taxonomy based on top hit
 mmseqs easy-taxonomy examples/DB.fasta swissprotDB result tmp --lca-mode 4
 
 # Assign taxonomy without ORF prefilter
 # Classifies higher percentage for short nucleotide input (e.g. short reads) at the cost of speed
 mmseqs easy-taxonomy queryNuclDB swissprotDB result tmp --orf-filter 0
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Mirdita M, Steinegger M, Breitwieser F, Soding J, Levy Karin E: Fast and sensitive taxonomic assignment to metagenomic contigs. Bioinformatics, btab184 (2021)
```

## mmseqs2_createdb

### Tool Description
Convert FASTA/Q file(s) to a sequence DB

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs createdb <i:fastaFile1[.gz|.bz2]> ... <i:fastaFileN[.gz|.bz2]>|<i:stdin> <o:sequenceDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:             
 --mask INT              Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [1]
 --mask-prob FLOAT       Mask sequences is probablity is above threshold [0.900]
 --mask-lower-case INT   Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
 --mask-n-repeat INT     Repeat letters that occure > threshold in a rwo [0]
misc:                  
 --dbtype INT            Database type 0: auto, 1: amino acid 2: nucleotides [0]
 --shuffle BOOL          Shuffle input database [1]
 --createdb-mode INT     Createdb mode 0: copy data, 1: soft link data and write new index (works only with single line fasta/q) 2: GPU compatible db [0]
 --id-offset INT         Numeric ids in index file are offset by this value [0]
common:                
 --threads INT           Number of CPU-cores used (all by default) [20]
 --compressed INT        Write compressed output [0]
 --gpu INT               Use GPU (CUDA) if possible [0]
 -v INT                  Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
expert:                
 --write-lookup INT      write .lookup file containing mapping from internal id, fasta id and file number [1]

examples:
 # Create a sequence database from multiple FASTA files
 mmseqs createdb file1.fa file2.fa.gz file3.fa sequenceDB
 
 # Create a seqDB from stdin
 cat seq.fasta | mmseqs createdb stdin sequenceDB
 
 # Create a seqDB by indexing existing FASTA/Q (for single line fasta entries only)
 mmseqs createdb seq.fasta sequenceDB --createdb-mode 1
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_createindex

### Tool Description
Store precomputed index on disk to reduce search overhead

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs createindex <i:sequenceDB> <tmpDir> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                  
 --seed-sub-mat TWIN          Substitution matrix file for k-mer generation [aa:VTML80.out,nucl:nucleotide.out]
 -k INT                       k-mer length (0: automatically set to optimum) [0]
 --alph-size TWIN             Alphabet size (range 2-21) [aa:21,nucl:5]
 --comp-bias-corr INT         Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT Correct for locally biased amino acid composition (range 0-1) [1.000]
 --max-seqs INT               Maximum results per query sequence allowed to pass the prefilter (affects sensitivity) [300]
 --mask INT                   Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [1]
 --mask-prob FLOAT            Mask sequences is probablity is above threshold [0.900]
 --mask-lower-case INT        Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
 --mask-n-repeat INT          Repeat letters that occure > threshold in a rwo [0]
 --spaced-kmer-mode INT       0: use consecutive positions in k-mers; 1: use spaced k-mers [1]
 --spaced-kmer-pattern STR    User-specified spaced k-mer pattern []
 -s FLOAT                     Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [7.500]
 --k-score TWIN               k-mer threshold for generating similar k-mer lists [seq:0,prof:0]
 --split INT                  Split input into N equally distributed chunks. 0: set the best split automatically [0]
 --split-memory-limit BYTE    Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
misc:                       
 --check-compatible INT       0: Always recreate index, 1: Check if recreating index is needed, 2: Fail if index is incompatible [0]
 --search-type INT            Search type 0: auto 1: amino acid, 2: translated, 3: nucleotide, 4: translated nucleotide alignment [0]
 --min-length INT             Minimum codon number in open reading frames [30]
 --max-length INT             Maximum codon number in open reading frames [32734]
 --max-gaps INT               Maximum number of codons with gaps or unknown residues before an open reading frame is rejected [2147483647]
 --contig-start-mode INT      Contig start can be 0: incomplete, 1: complete, 2: both [2]
 --contig-end-mode INT        Contig end can be 0: incomplete, 1: complete, 2: both [2]
 --orf-start-mode INT         Orf fragment can be 0: from start to stop, 1: from any to stop, 2: from last encountered start to stop (no start in the middle) [1]
 --forward-frames STR         Comma-separated list of frames on the forward strand to be extracted [1,2,3]
 --reverse-frames STR         Comma-separated list of frames on the reverse strand to be extracted [1,2,3]
 --translation-table INT      1) CANONICAL, 2) VERT_MITOCHONDRIAL, 3) YEAST_MITOCHONDRIAL, 4) MOLD_MITOCHONDRIAL, 5) INVERT_MITOCHONDRIAL, 6) CILIATE
                              9) FLATWORM_MITOCHONDRIAL, 10) EUPLOTID, 11) PROKARYOTE, 12) ALT_YEAST, 13) ASCIDIAN_MITOCHONDRIAL, 14) ALT_FLATWORM_MITOCHONDRIAL
                              15) BLEPHARISMA, 16) CHLOROPHYCEAN_MITOCHONDRIAL, 21) TREMATODE_MITOCHONDRIAL, 22) SCENEDESMUS_MITOCHONDRIAL
                              23) THRAUSTOCHYTRIUM_MITOCHONDRIAL, 24) PTEROBRANCHIA_MITOCHONDRIAL, 25) GRACILIBACTERIA, 26) PACHYSOLEN, 27) KARYORELICT, 28) CONDYLOSTOMA
                               29) MESODINIUM, 30) PERTRICH, 31) BLASTOCRITHIDIA [1]
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
 --remove-tmp-files BOOL      Delete temporary files [0]
expert:                     
 --index-subset INT           Create specialized index with subset of entries
                              0: normal index
                              1: index without headers
                              2: index without prefiltering data
                              4: index without aln (for cluster db)
                              Flags can be combined bit wise [0]
 --create-lookup INT          Create database lookup file (can be very large) [0]
 --strand INT                 Strand selection only works for DNA/DNA search 0: reverse, 1: forward, 2: both [1]

examples:
 # Create protein sequence index
 mmseqs createindex sequenceDB tmp
 
 # Create TBLASTX/N index from nucleotide sequences
 mmseqs createindex sequenceDB tmp --search-type 2
 
 # Create BLASTN index from nucleotide sequences
 mmseqs createindex sequenceDB tmp --search-type 3
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Mirdita M, Steinegger M, Soding J: MMseqs2 desktop and local web server app for fast, interactive sequence searches. Bioinformatics, 35(16), 2856-2858 (2019)
```

## mmseqs2_search

### Tool Description
Sensitive homology search

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs search <i:queryDB> <i:targetDB> <o:alignmentDB> <tmpDir> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                      
 --comp-bias-corr INT             Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT     Correct for locally biased amino acid composition (range 0-1) [1.000]
 --add-self-matches BOOL          Artificially add entries of queries with themselves (for clustering) [0]
 --seed-sub-mat TWIN              Substitution matrix file for k-mer generation [aa:VTML80.out,nucl:nucleotide.out]
 -s FLOAT                         Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [5.700]
 -k INT                           k-mer length (0: automatically set to optimum) [0]
 --target-search-mode INT         target search mode (0: regular k-mer, 1: similar k-mer) [0]
 --k-score TWIN                   k-mer threshold for generating similar k-mer lists [seq:2147483647,prof:2147483647]
 --alph-size TWIN                 Alphabet size (range 2-21) [aa:21,nucl:5]
 --max-seqs INT                   Maximum results per query sequence allowed to pass the prefilter (affects sensitivity) [300]
 --split INT                      Split input into N equally distributed chunks. 0: set the best split automatically [0]
 --split-mode INT                 0: split target db; 1: split query db; 2: auto, depending on main memory [2]
 --split-memory-limit BYTE        Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
 --diag-score BOOL                Use ungapped diagonal scoring during prefilter [1]
 --exact-kmer-matching INT        Extract only exact k-mers for matching (range 0-1) [0]
 --mask INT                       Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [1]
 --mask-prob FLOAT                Mask sequences is probablity is above threshold [0.900]
 --mask-lower-case INT            Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
 --mask-n-repeat INT              Repeat letters that occure > threshold in a rwo [0]
 --min-ungapped-score INT         Accept only matches with ungapped alignment score above threshold [15]
 --spaced-kmer-mode INT           0: use consecutive positions in k-mers; 1: use spaced k-mers [1]
 --spaced-kmer-pattern STR        User-specified spaced k-mer pattern []
 --local-tmp STR                  Path where some of the temporary files will be created []
 --disk-space-limit BYTE          Set max disk space to use for reverse profile searches. E.g. 800B, 5K, 10M, 1G. Default (0) to all available disk space in the temp folder [0]
align:                          
 -a BOOL                          Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --alignment-mode INT             How to compute the alignment:
                                  0: automatic
                                  1: only score and end_pos
                                  2: also start_pos and cov
                                  3: also seq.id
                                  4: only ungapped alignment [2]
 --alignment-output-mode INT      How to compute the alignment:
                                  0: automatic
                                  1: only score and end_pos
                                  2: also start_pos and cov
                                  3: also seq.id
                                  4: only ungapped alignment
                                  5: score only (output) cluster format [0]
 --wrapped-scoring BOOL           Double the (nucleotide) query sequence during the scoring process to allow wrapped diagonal scoring around end and start [0]
 -e DOUBLE                        List matches below this E-value (range 0.0-inf) [1.000E-03]
 --min-seq-id FLOAT               List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 --min-aln-len INT                Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT                0: alignment length 1: shorter, 2: longer sequence [0]
 --alt-ali INT                    Show up to this many alternative alignments [0]
 -c FLOAT                         List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --cov-mode INT                   0: coverage of query and target
                                  1: coverage of target
                                  2: coverage of query
                                  3: target seq. length has to be at least x% of query length
                                  4: query seq. length has to be at least x% of target length
                                  5: short seq. needs to be at least x% of the other seq. length [0]
 --max-rejected INT               Maximum rejected alignments before alignment calculation for a query is stopped [2147483647]
 --max-accept INT                 Maximum accepted alignments before alignment calculation for a query is stopped [2147483647]
 --score-bias FLOAT               Score bias when computing SW alignment (in bits) [0.000]
 --realign BOOL                   Compute more conservative, shorter alignments (scores and E-values not changed) [0]
 --realign-score-bias FLOAT       Additional bias when computing realignment [-0.200]
 --realign-max-seqs INT           Maximum number of results to return in realignment [2147483647]
 --corr-score-weight FLOAT        Weight of backtrace correlation score that is added to the alignment score [0.000]
 --gap-open TWIN                  Gap open cost [aa:11,nucl:5]
 --gap-extend TWIN                Gap extension cost [aa:1,nucl:2]
 --zdrop INT                      Maximal allowed difference between score values before alignment is truncated  (nucleotide alignment only) [40]
 --exhaustive-search-filter INT   Filter result during search: 0: do not filter, 1: filter [0]
profile:                        
 --pca                            Pseudo count admixture strength []
 --pcb                            Pseudo counts: Neff at half of maximum admixture (range 0.0-inf) []
 --mask-profile INT               Mask query sequence of profile using tantan [0,1] [1]
 --e-profile DOUBLE               Include sequences matches with < E-value thr. into the profile (>=0.0) [1.000E-01]
 --wg BOOL                        Use global sequence weighting for profile calculation [0]
 --filter-msa INT                 Filter msa: 0: do not filter, 1: filter [1]
 --filter-min-enable INT          Only filter MSAs with more than N sequences, 0 always filters [0]
 --max-seq-id FLOAT               Reduce redundancy of output MSA using max. pairwise sequence identity [0.0,1.0] [0.900]
 --qid STR                        Reduce diversity of output MSAs using min.seq. identity with query sequences [0.0,1.0]
                                  Alternatively, can be a list of multiple thresholds:
                                  E.g.: 0.15,0.30,0.50 to defines filter buckets of ]0.15-0.30] and ]0.30-0.50] [0.0]
 --qsc FLOAT                      Reduce diversity of output MSAs using min. score per aligned residue with query sequences [-50.0,100.0] [-20.000]
 --cov FLOAT                      Filter output MSAs using min. fraction of query residues covered by matched sequences [0.0,1.0] [0.000]
 --diff INT                       Filter MSAs by selecting most diverse set of sequences, keeping at least this many seqs in each MSA block of length 50 [1000]
 --pseudo-cnt-mode INT            use 0: substitution-matrix or 1: context-specific pseudocounts [0]
 --profile-output-mode INT        Profile output mode: 0: binary log-odds 1: human-readable frequencies [0]
 --num-iterations INT             Number of iterative profile search iterations [1]
 --exhaustive-search BOOL         For bigger profile DB, run iteratively the search by greedily swapping the search results [0]
 --lca-search BOOL                Efficient search for LCA candidates [0]
misc:                           
 --taxon-list STR                 Taxonomy ID, possibly multiple values separated by ',' []
 --prefilter-mode INT             prefilter mode: 0: kmer/ungapped 1: ungapped, 2: nofilter, 3: ungapped&gapped [0]
 --rescore-mode INT               Rescore diagonals with:
                                  0: Hamming distance
                                  1: local alignment (score only)
                                  2: local alignment
                                  3: global alignment
                                  4: longest alignment fulfilling window quality criterion [0]
 --allow-deletion BOOL            Allow deletions in a MSA [0]
 --min-length INT                 Minimum codon number in open reading frames [30]
 --max-length INT                 Maximum codon number in open reading frames [32734]
 --max-gaps INT                   Maximum number of codons with gaps or unknown residues before an open reading frame is rejected [2147483647]
 --contig-start-mode INT          Contig start can be 0: incomplete, 1: complete, 2: both [2]
 --contig-end-mode INT            Contig end can be 0: incomplete, 1: complete, 2: both [2]
 --orf-start-mode INT             Orf fragment can be 0: from start to stop, 1: from any to stop, 2: from last encountered start to stop (no start in the middle) [1]
 --forward-frames STR             Comma-separated list of frames on the forward strand to be extracted [1,2,3]
 --reverse-frames STR             Comma-separated list of frames on the reverse strand to be extracted [1,2,3]
 --translation-table INT          1) CANONICAL, 2) VERT_MITOCHONDRIAL, 3) YEAST_MITOCHONDRIAL, 4) MOLD_MITOCHONDRIAL, 5) INVERT_MITOCHONDRIAL, 6) CILIATE
                                  9) FLATWORM_MITOCHONDRIAL, 10) EUPLOTID, 11) PROKARYOTE, 12) ALT_YEAST, 13) ASCIDIAN_MITOCHONDRIAL, 14) ALT_FLATWORM_MITOCHONDRIAL
                                  15) BLEPHARISMA, 16) CHLOROPHYCEAN_MITOCHONDRIAL, 21) TREMATODE_MITOCHONDRIAL, 22) SCENEDESMUS_MITOCHONDRIAL
                                  23) THRAUSTOCHYTRIUM_MITOCHONDRIAL, 24) PTEROBRANCHIA_MITOCHONDRIAL, 25) GRACILIBACTERIA, 26) PACHYSOLEN, 27) KARYORELICT, 28) CONDYLOSTOMA
                                   29) MESODINIUM, 30) PERTRICH, 31) BLASTOCRITHIDIA [1]
 --translate INT                  Translate ORF to amino acid [0]
 --use-all-table-starts BOOL      Use all alternatives for a start codon in the genetic table, if false - only ATG (AUG) [0]
 --id-offset INT                  Numeric ids in index file are offset by this value [0]
 --sequence-overlap INT           Overlap between sequences [0]
 --sequence-split-mode INT        Sequence split mode 0: copy data, 1: soft link data and write new index, [1]
 --headers-split-mode INT         Header split mode: 0: split position, 1: original header [0]
 --search-type INT                Search type 0: auto 1: amino acid, 2: translated, 3: nucleotide, 4: translated nucleotide alignment [0]
 --start-sens FLOAT               Start sensitivity [4.000]
 --sens-steps INT                 Number of search steps performed from --start-sens to -s [1]
 --translation-mode INT           Translation AA seq from nucleotide by 0: ORFs, 1: full reading frames [0]
common:                         
 --sub-mat TWIN                   Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT                Maximum sequence length [65535]
 --db-load-mode INT               Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                    Number of CPU-cores used (all by default) [20]
 --compressed INT                 Write compressed output [0]
 -v INT                           Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --gpu INT                        Use GPU (CUDA) if possible [0]
 --gpu-server INT                 Use GPU server [0]
 --gpu-server-wait-timeout INT    Wait for GPU server for 0: don't wait -1: no wait limit: >0 this many seconds [600]
 --mpi-runner STR                 Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42") []
 --force-reuse BOOL               Reuse tmp filse in tmp/latest folder ignoring parameters and version changes [0]
 --remove-tmp-files BOOL          Delete temporary files [0]
expert:                         
 --filter-hits BOOL               Filter hits by seq.id. and coverage [0]
 --sort-results INT               Sort results: 0: no sorting, 1: sort by E-value (Alignment) or seq.id. (Hamming) [0]
 --create-lookup INT              Create database lookup file (can be very large) [0]
 --chain-alignments INT           Chain overlapping alignments [0]
 --merge-query INT                Combine ORFs/split sequences to a single entry [1]
 --strand INT                     Strand selection only works for DNA/DNA search 0: reverse, 1: forward, 2: both [1]

examples:
 # Search multiple FASTA against FASTA (like BLASTP, TBLASTN, BLASTX, BLASTN --search-type 3, TBLASTX --search-type 2)
 mmseqs search queryDB targetDB resultDB tmp
 mmseqs convertalis queryDB targetDB resultDB result.m8
 
 # Iterative profile search (like PSI-BLAST)
 mmseqs search queryDB targetDB resultDB tmp --num-iterations 2
 
 # Profile search against small databases (e.g. PFAM, eggNOG)
 mmseqs databases PFAM pfam_db tmp
 mmseqs search queryDB pfam_db resultDB tmp
 
 # Exhaustive search against sequences or profiles (works for large DBs)
 mmseqs search queryDB targetDB resultDB tmp --exhaustive-search
 
 # Increasing sensitivity search (from 2 to 7 in 3 steps)
 mmseqs search queryDB targetDB resultDB --start-sens 2 -s 7 --sens-steps 3
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Kallenborn F, Chacon A, Hundt C, Sirelkhatim H, Didi K, Dallago C, Mirdita M, Schmidt B, Steinegger M: GPU-accelerated homology search with MMseqs2. bioRxiv, 2024.11.13.623350 (2024)
```

## mmseqs2_cluster

### Tool Description
Slower, sensitive clustering

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs cluster <i:sequenceDB> <o:clusterDB> <tmpDir> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr> & Lars von den Driesch
options: prefilter:                      
 --seed-sub-mat TWIN              Substitution matrix file for k-mer generation [aa:VTML80.out,nucl:nucleotide.out]
 -s FLOAT                         Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [4.000]
 -k INT                           k-mer length (0: automatically set to optimum) [0]
 --target-search-mode INT         target search mode (0: regular k-mer, 1: similar k-mer) [0]
 --k-score TWIN                   k-mer threshold for generating similar k-mer lists [seq:2147483647,prof:2147483647]
 --alph-size TWIN                 Alphabet size (range 2-21) [aa:21,nucl:5]
 --max-seqs INT                   Maximum results per query sequence allowed to pass the prefilter (affects sensitivity) [20]
 --split INT                      Split input into N equally distributed chunks. 0: set the best split automatically [0]
 --split-mode INT                 0: split target db; 1: split query db; 2: auto, depending on main memory [2]
 --split-memory-limit BYTE        Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
 --comp-bias-corr INT             Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT     Correct for locally biased amino acid composition (range 0-1) [1.000]
 --diag-score BOOL                Use ungapped diagonal scoring during prefilter [1]
 --exact-kmer-matching INT        Extract only exact k-mers for matching (range 0-1) [0]
 --mask INT                       Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [1]
 --mask-prob FLOAT                Mask sequences is probablity is above threshold [0.900]
 --mask-lower-case INT            Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
 --mask-n-repeat INT              Repeat letters that occure > threshold in a rwo [0]
 --min-ungapped-score INT         Accept only matches with ungapped alignment score above threshold [15]
 --add-self-matches BOOL          Artificially add entries of queries with themselves (for clustering) [0]
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
 -a BOOL                          Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --alignment-mode INT             How to compute the alignment:
                                  0: automatic
                                  1: only score and end_pos
                                  2: also start_pos and cov
                                  3: also seq.id
                                  4: only ungapped alignment [3]
 --alignment-output-mode INT      How to compute the alignment:
                                  0: automatic
                                  1: only score and end_pos
                                  2: also start_pos and cov
                                  3: also seq.id
                                  4: only ungapped alignment
                                  5: score only (output) cluster format [0]
 --wrapped-scoring BOOL           Double the (nucleotide) query sequence during the scoring process to allow wrapped diagonal scoring around end and start [0]
 -e DOUBLE                        List matches below this E-value (range 0.0-inf) [1.000E-03]
 --min-seq-id FLOAT               List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 --min-aln-len INT                Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT                0: alignment length 1: shorter, 2: longer sequence [0]
 --alt-ali INT                    Show up to this many alternative alignments [0]
 --max-rejected INT               Maximum rejected alignments before alignment calculation for a query is stopped [2147483647]
 --max-accept INT                 Maximum accepted alignments before alignment calculation for a query is stopped [2147483647]
 --score-bias FLOAT               Score bias when computing SW alignment (in bits) [0.000]
 --realign BOOL                   Compute more conservative, shorter alignments (scores and E-values not changed) [0]
 --realign-score-bias FLOAT       Additional bias when computing realignment [-0.200]
 --realign-max-seqs INT           Maximum number of results to return in realignment [2147483647]
 --corr-score-weight FLOAT        Weight of backtrace correlation score that is added to the alignment score [0.000]
 --gap-open TWIN                  Gap open cost [aa:11,nucl:5]
 --gap-extend TWIN                Gap extension cost [aa:1,nucl:2]
 --zdrop INT                      Maximal allowed difference between score values before alignment is truncated  (nucleotide alignment only) [40]
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
profile:                        
 --pca                            Pseudo count admixture strength []
 --pcb                            Pseudo counts: Neff at half of maximum admixture (range 0.0-inf) []
misc:                           
 --taxon-list STR                 Taxonomy ID, possibly multiple values separated by ',' []
 --rescore-mode INT               Rescore diagonals with:
                                  0: Hamming distance
                                  1: local alignment (score only)
                                  2: local alignment
                                  3: global alignment
                                  4: longest alignment fulfilling window quality criterion [0]
common:                         
 --sub-mat TWIN                   Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT                Maximum sequence length [65535]
 --db-load-mode INT               Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                    Number of CPU-cores used (all by default) [20]
 --compressed INT                 Write compressed output [0]
 -v INT                           Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --remove-tmp-files BOOL          Delete temporary files [0]
 --force-reuse BOOL               Reuse tmp filse in tmp/latest folder ignoring parameters and version changes [0]
 --mpi-runner STR                 Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42") []
expert:                         
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
 # - Corrects criteria-violations of cascaded merging
 # - Produces more clusters and is a bit slower
 mmseqs cluster sequenceDB clusterDB tmp --cluster-reassign
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Hauser M, Steinegger M, Soding J: MMseqs software suite for fast and deep clustering and searching of large protein sequence sets. Bioinformatics, 32(9), 1323-1330 (2016)
 - Steinegger M, Soding J: Clustering huge protein sequence sets in linear time. Nature Communications, 9(1), 2542 (2018)
```

## mmseqs2_linclust

### Tool Description
Fast, linear time clustering, less sensitive

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs linclust <i:sequenceDB> <o:clusterDB> <tmpDir> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                      
 --comp-bias-corr INT             Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT     Correct for locally biased amino acid composition (range 0-1) [1.000]
 --add-self-matches BOOL          Artificially add entries of queries with themselves (for clustering) [0]
 --alph-size TWIN                 Alphabet size (range 2-21) [aa:21,nucl:5]
 --spaced-kmer-mode INT           0: use consecutive positions in k-mers; 1: use spaced k-mers [0]
 --spaced-kmer-pattern STR        User-specified spaced k-mer pattern []
 --mask INT                       Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [0]
 --mask-prob FLOAT                Mask sequences is probablity is above threshold [0.900]
 --mask-lower-case INT            Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
 --mask-n-repeat INT              Repeat letters that occure > threshold in a rwo [0]
 -k INT                           k-mer length (0: automatically set to optimum) [0]
 --split-memory-limit BYTE        Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
align:                          
 -a BOOL                          Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --alignment-mode INT             How to compute the alignment:
                                  0: automatic
                                  1: only score and end_pos
                                  2: also start_pos and cov
                                  3: also seq.id
                                  4: only ungapped alignment [2]
 --alignment-output-mode INT      How to compute the alignment:
                                  0: automatic
                                  1: only score and end_pos
                                  2: also start_pos and cov
                                  3: also seq.id
                                  4: only ungapped alignment
                                  5: score only (output) cluster format [0]
 --wrapped-scoring BOOL           Double the (nucleotide) query sequence during the scoring process to allow wrapped diagonal scoring around end and start [0]
 -e DOUBLE                        List matches below this E-value (range 0.0-inf) [1.000E-03]
 --min-seq-id FLOAT               List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.900]
 --min-aln-len INT                Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT                0: alignment length 1: shorter, 2: longer sequence [0]
 --alt-ali INT                    Show up to this many alternative alignments [0]
 -c FLOAT                         List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.800]
 --cov-mode INT                   0: coverage of query and target
                                  1: coverage of target
                                  2: coverage of query
                                  3: target seq. length has to be at least x% of query length
                                  4: query seq. length has to be at least x% of target length
                                  5: short seq. needs to be at least x% of the other seq. length [0]
 --max-rejected INT               Maximum rejected alignments before alignment calculation for a query is stopped [2147483647]
 --max-accept INT                 Maximum accepted alignments before alignment calculation for a query is stopped [2147483647]
 --score-bias FLOAT               Score bias when computing SW alignment (in bits) [0.000]
 --realign BOOL                   Compute more conservative, shorter alignments (scores and E-values not changed) [0]
 --realign-score-bias FLOAT       Additional bias when computing realignment [-0.200]
 --realign-max-seqs INT           Maximum number of results to return in realignment [2147483647]
 --corr-score-weight FLOAT        Weight of backtrace correlation score that is added to the alignment score [0.000]
 --gap-open TWIN                  Gap open cost [aa:11,nucl:5]
 --gap-extend TWIN                Gap extension cost [aa:1,nucl:2]
 --zdrop INT                      Maximal allowed difference between score values before alignment is truncated  (nucleotide alignment only) [40]
clust:                          
 --cluster-mode INT               0: Set-Cover (greedy)
                                  1: Connected component (BLASTclust)
                                  2,3: Greedy clustering by sequence length (CDHIT) [0]
 --max-iterations INT             Maximum depth of breadth first search in connected component clustering [1000]
 --similarity-type INT            Type of score used for clustering. 1: alignment score 2: sequence identity [2]
kmermatcher:                    
 --weights STR                    Weights used for cluster priorization []
 --cluster-weight-threshold FLOAT Weight threshold used for cluster priorization [0.900]
 --kmer-per-seq INT               k-mers per sequence [21]
 --kmer-per-seq-scale TWIN        Scale k-mer per sequence based on sequence length as kmer-per-seq val + scale x seqlen [aa:0.000,nucl:0.200]
 --adjust-kmer-len BOOL           Adjust k-mer length based on specificity (only for nucleotides) [0]
 --hash-shift INT                 Shift k-mer hash initialization [67]
 --include-only-extendable BOOL   Include only extendable [0]
 --ignore-multi-kmer BOOL         Skip k-mers occurring multiple times (>=2) [0]
profile:                        
 --pca                            Pseudo count admixture strength []
 --pcb                            Pseudo counts: Neff at half of maximum admixture (range 0.0-inf) []
misc:                           
 --rescore-mode INT               Rescore diagonals with:
                                  0: Hamming distance
                                  1: local alignment (score only)
                                  2: local alignment
                                  3: global alignment
                                  4: longest alignment fulfilling window quality criterion [0]
common:                         
 --threads INT                    Number of CPU-cores used (all by default) [20]
 --compressed INT                 Write compressed output [0]
 -v INT                           Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --sub-mat TWIN                   Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT                Maximum sequence length [65535]
 --db-load-mode INT               Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --remove-tmp-files BOOL          Delete temporary files [0]
 --force-reuse BOOL               Reuse tmp filse in tmp/latest folder ignoring parameters and version changes [0]
 --mpi-runner STR                 Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42") []
expert:                         
 --filter-hits BOOL               Filter hits by seq.id. and coverage [0]
 --sort-results INT               Sort results: 0: no sorting, 1: sort by E-value (Alignment) or seq.id. (Hamming) [0]

examples:
 # Linear-time clustering of FASTA file
 mmseqs linclust sequenceDB clusterDB tmp
 
                    --cov-mode 
 # Sequence         0    1    2
 # Q: MAVGTACRPA  60%  IGN  60%
 # T: -AVGTAC---  60% 100%  IGN
 # Cutoff -c 0.7    -    +    -
 #        -c 0.6    +    +    +
 
 # Cluster nucleotide sequences 
 mmseqs easy-linclust nucl.fasta result tmp --kmer-per-seq-scale 0.3
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Steinegger M, Soding J: Clustering huge protein sequence sets in linear time. Nature Communications, 9(1), 2542 (2018)
```

## mmseqs2_convertalis

### Tool Description
Convert alignment DB to BLAST-tab, SAM or custom format

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs convertalis <i:queryDb> <i:targetDb> <i:alignmentDB> <o:alignmentFile> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: align:                   
 --gap-open TWIN           Gap open cost [aa:11,nucl:5]
 --gap-extend TWIN         Gap extension cost [aa:1,nucl:2]
misc:                    
 --format-mode INT         Output format:
                           0: BLAST-TAB
                           1: SAM
                           2: BLAST-TAB + query/db length
                           3: Pretty HTML
                           4: BLAST-TAB + column headers
                           BLAST-TAB (0) and BLAST-TAB + column headers (4) support custom output formats (--format-output) [0]
 --format-output STR       Choose comma separated list of output columns from: query,target,evalue,gapopen,pident,fident,nident,qstart,qend,qlen
                           tstart,tend,tlen,alnlen,raw,bits,cigar,qseq,tseq,qheader,theader,qaln,taln,qframe,tframe,mismatch,qcov,tcov
                           qset,qsetid,tset,tsetid,taxid,taxname,taxlineage,qorfstart,qorfend,torfstart,torfend,ppos [query,target,fident,alnlen,mismatch,gapopen,qstart,qend,tstart,tend,evalue,bits]
 --translation-table INT   1) CANONICAL, 2) VERT_MITOCHONDRIAL, 3) YEAST_MITOCHONDRIAL, 4) MOLD_MITOCHONDRIAL, 5) INVERT_MITOCHONDRIAL, 6) CILIATE
                           9) FLATWORM_MITOCHONDRIAL, 10) EUPLOTID, 11) PROKARYOTE, 12) ALT_YEAST, 13) ASCIDIAN_MITOCHONDRIAL, 14) ALT_FLATWORM_MITOCHONDRIAL
                           15) BLEPHARISMA, 16) CHLOROPHYCEAN_MITOCHONDRIAL, 21) TREMATODE_MITOCHONDRIAL, 22) SCENEDESMUS_MITOCHONDRIAL
                           23) THRAUSTOCHYTRIUM_MITOCHONDRIAL, 24) PTEROBRANCHIA_MITOCHONDRIAL, 25) GRACILIBACTERIA, 26) PACHYSOLEN, 27) KARYORELICT, 28) CONDYLOSTOMA
                            29) MESODINIUM, 30) PERTRICH, 31) BLASTOCRITHIDIA [1]
 --search-type INT         Search type 0: auto 1: amino acid, 2: translated, 3: nucleotide, 4: translated nucleotide alignment [0]
common:                  
 --sub-mat TWIN            Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --db-load-mode INT        Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT             Number of CPU-cores used (all by default) [20]
 --compressed INT          Write compressed output [0]
 -v INT                    Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
expert:                  
 --db-output BOOL          Return a result DB instead of a text file [0]

examples:
 # Create output in BLAST M8 format (12 columns):
 #  (1,2) identifiers for query and target sequences/profiles,
 #  (3) sequence identity, (4) alignment length, (5) number of mismatches,
 #  (6) number of gap openings, (7-8, 9-10) alignment start and end-position in query and in target,
 #  (11) E-value, and (12) bit score
 mmseqs convertalis queryDB targetDB result.m8
 
 # Create a TSV containing pairwise alignments
 mmseqs convertalis queryDB targetDB result.tsv --format-output query,target,qaln,taln
 
 # Annotate a alignment result with taxonomy information from targetDB
 mmseqs convertalis queryDB targetDB result.tsv --format-output query,target,taxid,taxname,taxlineage
 
  Create SAM output
 mmseqs convertalis queryDB targetDB result.sam --format-mode 1
 
 # Create a TSV containing which query file a result comes from
 mmseqs createdb euk_queries.fasta bac_queries.fasta queryDB
 mmseqs convertalis queryDB targetDB result.tsv --format-output qset,query,target
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_createtsv

### Tool Description
Convert result DB to tab-separated flat file

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs createtsv <i:queryDB> [<i:targetDB>] <i:resultDB> <o:tsvFile> [options]
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

## mmseqs2_result2flat

### Tool Description
Create a FASTA-like flat file from prefilter DB

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs result2flat <i:queryDB> <i:targetDB> <i:resultDB> <o:fastaDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: misc:                   
 --use-fasta-header BOOL  Use the id parsed from the fasta header as the index key instead of using incrementing numeric identifiers [0]
common:                 
 -v INT                   Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```
