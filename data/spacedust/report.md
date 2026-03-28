# spacedust CWL Generation Report

## spacedust_createsetdb

### Tool Description
Creates a database for spacedust.

### Metadata
- **Docker Image**: quay.io/biocontainers/spacedust:2.e56c505--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/spacedust
- **Package**: https://anaconda.org/channels/bioconda/packages/spacedust/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/spacedust/overview
- **Total Downloads**: 620
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/soedinglab/spacedust
- **Stars**: N/A
### Original Help Text
```text
usage: spacedust createsetdb <i:fastaFile1[.gz|bz2]> ... <i:fastaFileN[.gz|bz2]>|<directory>|<listOfFastaFiles.tsv> <o:setDB> <tmpDir> [options]
 By Ruoshi Zhang <ruoshi.zhang@mpinat.mpg.de> & Milot Mirdita <milot@mirdita.de>
options: misc:                       
 --dbtype INT                 Database type 0: auto, 1: amino acid 2: nucleotides [0]
 --shuffle BOOL               Shuffle input database [0]
 --createdb-mode INT          Createdb mode 0: copy data, 1: soft link data and write new index (works only with single line fasta/q) [0]
 --id-offset INT              Numeric ids in index file are offset by this value [0]
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
 --add-orf-stop BOOL          Add stop codon '*' at complete start and end [0]
 --gff-type STR               Comma separated list of feature types in the GFF file to select []
 --stat STR                   One of: linecount, mean, min, max, doolittle, charges, seqlen, firstline []
 --tsv BOOL                   Return output in TSV format [0]
 --file-include STR           Include file names based on this regex [.*]
 --file-exclude STR           Exclude file names based on this regex [^$]
 --gff-dir STR                Path to gff dir file []
common:                     
 --compressed INT             Write compressed output [0]
 -v INT                       Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --threads INT                Number of CPU-cores used (all by default) [20]
expert:                     
 --write-lookup INT           write .lookup file containing mapping from internal id, fasta id and file number [1]
 --create-lookup INT          Create database lookup file (can be very large) [0]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```


## spacedust_aa2foldseek

### Tool Description
By Ruoshi Zhang <ruoshi.zhang@mpinat.mpg.de> & Milot Mirdita <milot@mirdita.de>

### Metadata
- **Docker Image**: quay.io/biocontainers/spacedust:2.e56c505--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/spacedust
- **Package**: https://anaconda.org/channels/bioconda/packages/spacedust/overview
- **Validation**: PASS

### Original Help Text
```text
usage: spacedust aa2foldseek <i:inputDB> <i:targetDB> <tmpDir> [options]
 By Ruoshi Zhang <ruoshi.zhang@mpinat.mpg.de> & Milot Mirdita <milot@mirdita.de>
options: prefilter:                   
 --seed-sub-mat TWIN           Substitution matrix file for k-mer generation [aa:VTML80.out,nucl:nucleotide.out]
 -s FLOAT                      Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [4.000]
 -k INT                        k-mer length (0: automatically set to optimum) [0]
 --k-score TWIN                k-mer threshold for generating similar k-mer lists [seq:2147483647,prof:2147483647]
 --alph-size TWIN              Alphabet size (range 2-21) [aa:21,nucl:5]
 --max-seqs INT                Maximum results per query sequence allowed to pass the prefilter (affects sensitivity) [10]
 --split INT                   Split input into N equally distributed chunks. 0: set the best split automatically [0]
 --split-mode INT              0: split target db; 1: split query db; 2: auto, depending on main memory [2]
 --split-memory-limit BYTE     Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
 --comp-bias-corr INT          Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT  Correct for locally biased amino acid composition (range 0-1) [1.000]
 --diag-score BOOL             Use ungapped diagonal scoring during prefilter [1]
 --exact-kmer-matching INT     Extract only exact k-mers for matching (range 0-1) [1]
 --mask INT                    Mask sequences in k-mer stage: 0: w/o low complexity masking, 1: with low complexity masking [1]
 --mask-prob FLOAT             Mask sequences is probablity is above threshold [0.900]
 --mask-lower-case INT         Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
 --min-ungapped-score INT      Accept only matches with ungapped alignment score above threshold [15]
 --add-self-matches BOOL       Artificially add entries of queries with themselves (for clustering) [0]
 --spaced-kmer-mode INT        0: use consecutive positions in k-mers; 1: use spaced k-mers [1]
 --spaced-kmer-pattern STR     User-specified spaced k-mer pattern []
 --local-tmp STR               Path where some of the temporary files will be created []
align:                       
 -c FLOAT                      List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.900]
 --cov-mode INT                0: coverage of query and target
                               1: coverage of target
                               2: coverage of query
                               3: target seq. length has to be at least x% of query length
                               4: query seq. length has to be at least x% of target length
                               5: short seq. needs to be at least x% of the other seq. length [0]
 -a BOOL                       Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --alignment-mode INT          How to compute the alignment:
                               0: automatic
                               1: only score and end_pos
                               2: also start_pos and cov
                               3: also seq.id
                               4: only ungapped alignment [0]
 --alignment-output-mode INT   How to compute the alignment:
                               0: automatic
                               1: only score and end_pos
                               2: also start_pos and cov
                               3: also seq.id
                               4: only ungapped alignment
                               5: score only (output) cluster format [0]
 --wrapped-scoring BOOL        Double the (nucleotide) query sequence during the scoring process to allow wrapped diagonal scoring around end and start [0]
 -e DOUBLE                     List matches below this E-value (range 0.0-inf) [1.000E-03]
 --min-seq-id FLOAT            List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.900]
 --min-aln-len INT             Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT             0: alignment length 1: shorter, 2: longer sequence [0]
 --alt-ali INT                 Show up to this many alternative alignments [0]
 --max-rejected INT            Maximum rejected alignments before alignment calculation for a query is stopped [2147483647]
 --max-accept INT              Maximum accepted alignments before alignment calculation for a query is stopped [2147483647]
 --score-bias FLOAT            Score bias when computing SW alignment (in bits) [0.000]
 --realign BOOL                Compute more conservative, shorter alignments (scores and E-values not changed) [0]
 --realign-score-bias FLOAT    Additional bias when computing realignment [-0.200]
 --realign-max-seqs INT        Maximum number of results to return in realignment [2147483647]
 --corr-score-weight FLOAT     Weight of backtrace correlation score that is added to the alignment score [0.000]
 --gap-open TWIN               Gap open cost [aa:11,nucl:5]
 --gap-extend TWIN             Gap extension cost [aa:1,nucl:2]
 --zdrop INT                   Maximal allowed difference between score values before alignment is truncated  (nucleotide alignment only) [40]
profile:                     
 --pca                         Pseudo count admixture strength []
 --pcb                         Pseudo counts: Neff at half of maximum admixture (range 0.0-inf) []
misc:                        
 --taxon-list STR              Taxonomy ID, possibly multiple values separated by ',' []
 --stat STR                    One of: linecount, mean, min, max, doolittle, charges, seqlen, firstline []
 --tsv BOOL                    Return output in TSV format [0]
common:                      
 --sub-mat TWIN                Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT             Maximum sequence length [65535]
 --db-load-mode INT            Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                 Number of CPU-cores used (all by default) [20]
 --compressed INT              Write compressed output [0]
 -v INT                        Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --remove-tmp-files BOOL       Delete temporary files [0]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```


## spacedust_clusterdb

### Tool Description
By Ruoshi Zhang <ruoshi.zhang@mpinat.mpg.de> & Milot Mirdita <milot@mirdita.de>

### Metadata
- **Docker Image**: quay.io/biocontainers/spacedust:2.e56c505--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/spacedust
- **Package**: https://anaconda.org/channels/bioconda/packages/spacedust/overview
- **Validation**: PASS

### Original Help Text
```text
usage: spacedust clusterdb <i:inputDB> <tmpDir> [options]
 By Ruoshi Zhang <ruoshi.zhang@mpinat.mpg.de> & Milot Mirdita <milot@mirdita.de>
options: prefilter:                      
 --seed-sub-mat TWIN              Substitution matrix file for k-mer generation [aa:VTML80.out,nucl:nucleotide.out]
 -s FLOAT                         Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [4.000]
 -k INT                           k-mer length (0: automatically set to optimum) [0]
 --k-score TWIN                   k-mer threshold for generating similar k-mer lists [seq:2147483647,prof:2147483647]
 --alph-size TWIN                 Alphabet size (range 2-21) [aa:21,nucl:5]
 --max-seqs INT                   Maximum results per query sequence allowed to pass the prefilter (affects sensitivity) [300]
 --split INT                      Split input into N equally distributed chunks. 0: set the best split automatically [0]
 --split-mode INT                 0: split target db; 1: split query db; 2: auto, depending on main memory [2]
 --split-memory-limit BYTE        Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
 --comp-bias-corr INT             Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT     Correct for locally biased amino acid composition (range 0-1) [1.000]
 --diag-score BOOL                Use ungapped diagonal scoring during prefilter [1]
 --exact-kmer-matching INT        Extract only exact k-mers for matching (range 0-1) [0]
 --mask INT                       Mask sequences in k-mer stage: 0: w/o low complexity masking, 1: with low complexity masking [1]
 --mask-prob FLOAT                Mask sequences is probablity is above threshold [0.900]
 --mask-lower-case INT            Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
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
 --min-seq-id FLOAT               List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.700]
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
 --search-mode INT                0: sequence search with MMseqs2, 1: structure comparison with Foldseek, 2: Foldseek + ProstT5 [0]
 --foldseek-path STR              Path to Foldseek binary [/usr/local/bin/foldseek]
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

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```


## spacedust_clustersearch

### Tool Description
By Ruoshi Zhang <ruoshi.zhang@mpinat.mpg.de> & Milot Mirdita <milot@mirdita.de>

### Metadata
- **Docker Image**: quay.io/biocontainers/spacedust:2.e56c505--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/spacedust
- **Package**: https://anaconda.org/channels/bioconda/packages/spacedust/overview
- **Validation**: PASS

### Original Help Text
```text
usage: spacedust clustersearch <i:querySetDB> <i:targetSetDB> <o:output[.tsv]> <tmpDir> [options]
 By Ruoshi Zhang <ruoshi.zhang@mpinat.mpg.de> & Milot Mirdita <milot@mirdita.de>
options: prefilter:                      
 --comp-bias-corr INT             Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT     Correct for locally biased amino acid composition (range 0-1) [1.000]
 --add-self-matches BOOL          Artificially add entries of queries with themselves (for clustering) [0]
 --seed-sub-mat TWIN              Substitution matrix file for k-mer generation [aa:VTML80.out,nucl:nucleotide.out]
 -s FLOAT                         Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [5.700]
 -k INT                           k-mer length (0: automatically set to optimum) [0]
 --k-score TWIN                   k-mer threshold for generating similar k-mer lists [seq:2147483647,prof:2147483647]
 --alph-size TWIN                 Alphabet size (range 2-21) [aa:21,nucl:5]
 --max-seqs INT                   Maximum results per query sequence allowed to pass the prefilter (affects sensitivity) [300]
 --split INT                      Split input into N equally distributed chunks. 0: set the best split automatically [0]
 --split-mode INT                 0: split target db; 1: split query db; 2: auto, depending on main memory [2]
 --split-memory-limit BYTE        Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
 --diag-score BOOL                Use ungapped diagonal scoring during prefilter [1]
 --exact-kmer-matching INT        Extract only exact k-mers for matching (range 0-1) [0]
 --mask INT                       Mask sequences in k-mer stage: 0: w/o low complexity masking, 1: with low complexity masking [1]
 --mask-prob FLOAT                Mask sequences is probablity is above threshold [0.900]
 --mask-lower-case INT            Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
 --min-ungapped-score INT         Accept only matches with ungapped alignment score above threshold [15]
 --spaced-kmer-mode INT           0: use consecutive positions in k-mers; 1: use spaced k-mers [1]
 --spaced-kmer-pattern STR        User-specified spaced k-mer pattern []
 --local-tmp STR                  Path where some of the temporary files will be created []
 --disk-space-limit BYTE          Set max disk space to use for reverse profile searches. E.g. 800B, 5K, 10M, 1G. Default (0) to all available disk space in the temp folder [0]
align:                          
 -a BOOL                          Add backtrace string (convert to alignments with mmseqs convertalis module) [1]
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
 -e DOUBLE                        List matches below this E-value (range 0.0-inf) [1.000E+01]
 --min-seq-id FLOAT               List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 --min-aln-len INT                Minimum alignment length (range 0-INT_MAX) [30]
 --seq-id-mode INT                0: alignment length 1: shorter, 2: longer sequence [0]
 --alt-ali INT                    Show up to this many alternative alignments [0]
 -c FLOAT                         List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.800]
 --cov-mode INT                   0: coverage of query and target
                                  1: coverage of target
                                  2: coverage of query
                                  3: target seq. length has to be at least x% of query length
                                  4: query seq. length has to be at least x% of target length
                                  5: short seq. needs to be at least x% of the other seq. length [2]
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
 --gap-pc INT                     Pseudo count for calculating position-specific gap opening penalties [10]
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
 --num-iterations INT             Number of iterative profile search iterations [1]
 --exhaustive-search BOOL         For bigger profile DB, run iteratively the search by greedily swapping the search results [0]
 --lca-search BOOL                Efficient search for LCA candidates [0]
misc:                           
 --taxon-list STR                 Taxonomy ID, possibly multiple values separated by ',' []
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
 --add-orf-stop BOOL              Add stop codon '*' at complete start and end [0]
 --sequence-overlap INT           Overlap between sequences [0]
 --sequence-split-mode INT        Sequence split mode 0: copy data, 1: soft link data and write new index, [1]
 --headers-split-mode INT         Header split mode: 0: split position, 1: original header [0]
 --search-type INT                Search type 0: auto 1: amino acid, 2: translated, 3: nucleotide, 4: translated nucleotide alignment [0]
 --start-sens FLOAT               Start sensitivity [4.000]
 --sens-steps INT                 Number of search steps performed from --start-sens to -s [1]
 --simple-best-hit BOOL           Update the p-value by a single best hit, or by best and second best hits [1]
 --suboptimal-hits INT            Include sub-optimal hits of query sequence up to a factor of its E-value. 0: only include one best hit [0]
 --alpha FLOAT                    Set alpha for combining p-values during aggregation [1.000]
 --aggregation-mode INT           Combined P-values computed from 0: multi-hit, 1: minimum of all P-values, 2: product-of-P-values, 3: truncated product [0]
 --filter-self-match BOOL         Remove hits between the same set. 0: do not filter, 1: filter [0]
 --multihit-pval FLOAT            Multihit P-value threshold for cluster match output [0.010]
 --cluster-pval FLOAT             Clustering and Ordering P-value threshold for cluster match output [0.010]
 --max-gene-gap INT               Maximum number of genes allowed between two clusters to merge [3]
 --cluster-size INT               Minimum number of genes to define cluster [2]
 --cluster-use-weight BOOL        Use weighting factor to calculate cluster match score [0]
 --profile-cluster-search BOOL    Perform profile(target)-sequence searches in clustersearch [0]
 --search-mode INT                0: sequence search with MMseqs2, 1: structure comparison with Foldseek, 2: Foldseek + ProstT5 [0]
 --foldseek-path STR              Path to Foldseek binary [/usr/local/bin/foldseek]
common:                         
 --sub-mat TWIN                   Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT                Maximum sequence length [65535]
 --db-load-mode INT               Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                    Number of CPU-cores used (all by default) [20]
 --compressed INT                 Write compressed output [0]
 -v INT                           Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
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
 --db-output BOOL                 Return a result DB instead of a text file [1]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```


## Metadata
- **Skill**: generated
