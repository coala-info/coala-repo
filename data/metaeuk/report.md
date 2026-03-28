# metaeuk CWL Generation Report

## metaeuk_predictexons

### Tool Description
By Eli Levy Karin <eli.levy.karin@gmail.com>

### Metadata
- **Docker Image**: quay.io/biocontainers/metaeuk:7.bba0d80--pl5321hd6d6fdc_2
- **Homepage**: https://github.com/soedinglab/metaeuk
- **Package**: https://anaconda.org/channels/bioconda/packages/metaeuk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metaeuk/overview
- **Total Downloads**: 100.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/soedinglab/metaeuk
- **Stars**: N/A
### Original Help Text
```text
usage: metaeuk predictexons <i:contigsDB> <i:targetsDB> <o:calledExonsDB> <tmpDir> [options]
 By Eli Levy Karin <eli.levy.karin@gmail.com>
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
 --mask INT                       Mask sequences in k-mer stage: 0: w/o low complexity masking, 1: with low complexity masking [1]
 --mask-prob FLOAT                Mask sequences is probablity is above threshold [0.900]
 --mask-lower-case INT            Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
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
 -e DOUBLE                        List matches below this E-value (range 0.0-inf) [1.000E+02]
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
 --min-length INT                 Minimum codon number in open reading frames [15]
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
 --prefilter-mode INT             prefilter mode: 0: kmer/ungapped 1: ungapped, 2: nofilter [0]
 --metaeuk-eval FLOAT             maximal combined evalue of an optimal set [0.0, inf] [0.001]
 --metaeuk-tcov FLOAT             minimal length ratio of combined set to target [0.0, 1.0] [0.500]
 --max-intron INT                 Maximal allowed intron length [10000]
 --min-intron INT                 Minimal allowed intron length [15]
 --min-exon-aa INT                Minimal allowed exon length in amino acids [11]
 --max-overlap INT                Maximal allowed overlap of consecutive exons in amino acids [10]
 --max-exon-sets INT              Maximal number of exons sets that match a given target. If >1 suboptimal solutions will be reported [1]
 --set-gap-open INT               Gap open penalty (negative) for missed target amino acids between exons [-1]
 --set-gap-extend INT             Gap extend penalty (negative) for missed target amino acids between exons [-1]
 --reverse-fragments INT          reverse AA fragments to compute under null [0,1] [0]
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

examples:
 An analog of 6-frame translation to produce putative protein fragments. Search against protein DB. Compatible exon set identified with respect to each target.

references:
 - Levy Karin E, Mirdita M, Soeding J: MetaEuk – sensitive, high-throughput gene discovery and annotation for large-scale eukaryotic metagenomics. biorxiv, 851964 (2019).
```


## metaeuk_easy-predict

### Tool Description
Combines the following MetaEuk modules into a single step: predictexons, reduceredundancy and unitesetstofasta

### Metadata
- **Docker Image**: quay.io/biocontainers/metaeuk:7.bba0d80--pl5321hd6d6fdc_2
- **Homepage**: https://github.com/soedinglab/metaeuk
- **Package**: https://anaconda.org/channels/bioconda/packages/metaeuk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metaeuk easy-predict <i:contigs> <i:targets> <o:predictionsFasta> <tmpDir> [options]
 By Eli Levy Karin <eli.levy.karin@gmail.com>
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
 --mask INT                       Mask sequences in k-mer stage: 0: w/o low complexity masking, 1: with low complexity masking [1]
 --mask-prob FLOAT                Mask sequences is probablity is above threshold [0.900]
 --mask-lower-case INT            Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
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
 -e DOUBLE                        List matches below this E-value (range 0.0-inf) [1.000E+02]
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
 --min-length INT                 Minimum codon number in open reading frames [15]
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
 --prefilter-mode INT             prefilter mode: 0: kmer/ungapped 1: ungapped, 2: nofilter [0]
 --metaeuk-eval FLOAT             maximal combined evalue of an optimal set [0.0, inf] [0.001]
 --metaeuk-tcov FLOAT             minimal length ratio of combined set to target [0.0, 1.0] [0.500]
 --max-intron INT                 Maximal allowed intron length [10000]
 --min-intron INT                 Minimal allowed intron length [15]
 --min-exon-aa INT                Minimal allowed exon length in amino acids [11]
 --max-overlap INT                Maximal allowed overlap of consecutive exons in amino acids [10]
 --max-exon-sets INT              Maximal number of exons sets that match a given target. If >1 suboptimal solutions will be reported [1]
 --set-gap-open INT               Gap open penalty (negative) for missed target amino acids between exons [-1]
 --set-gap-extend INT             Gap extend penalty (negative) for missed target amino acids between exons [-1]
 --reverse-fragments INT          reverse AA fragments to compute under null [0,1] [0]
 --overlap INT                    allow predictions to overlap another on the same strand. when not allowed (default), only the prediction with better E-value will be retained [0,1] [0]
 --protein INT                    translate the joint exons coding sequence to amino acids [0,1] [0]
 --target-key INT                 write the target key (internal DB identifier) instead of its accession. By default (0) target accession will be written [0,1] [0]
 --write-frag-coords INT          write the contig coords of the stop-to-stop fragment in which putative exon lies. By default (0) only putative exon coords will be written [0,1] [0]
 --len-scan-for-start INT         length to scan for a start codon before the first exon and in the same frame. By default (0) no scan [0]
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

examples:
 Combines the following MetaEuk modules into a single step: predictexons, reduceredundancy and unitesetstofasta

references:
 - Levy Karin E, Mirdita M, Soeding J: MetaEuk – sensitive, high-throughput gene discovery and annotation for large-scale eukaryotic metagenomics. biorxiv, 851964 (2019).
```


## metaeuk_taxtocontig

### Tool Description
By Eli Levy Karin <eli.levy.karin@gmail.com>

### Metadata
- **Docker Image**: quay.io/biocontainers/metaeuk:7.bba0d80--pl5321hd6d6fdc_2
- **Homepage**: https://github.com/soedinglab/metaeuk
- **Package**: https://anaconda.org/channels/bioconda/packages/metaeuk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metaeuk taxtocontig <i:contigsDB> <i:predictionsFasta> <i:predictionsFasta.headersMap.tsv> <i:taxAnnotTargetDb> <o:taxResult> <tmpDir> [options]
 By Eli Levy Karin <eli.levy.karin@gmail.com>
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
 --mask INT                       Mask sequences in k-mer stage: 0: w/o low complexity masking, 1: with low complexity masking [1]
 --mask-prob FLOAT                Mask sequences is probablity is above threshold [0.900]
 --mask-lower-case INT            Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
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
 --exhaustive-search BOOL         For bigger profile DB, run iteratively the search by greedily swapping the search results [0]
 --lca-search BOOL                Efficient search for LCA candidates [0]
misc:                           
 --orf-filter INT                 Prefilter query ORFs with non-selective search
                                  Only used during nucleotide-vs-protein classification
                                  NOTE: Consider disabling when classifying short reads [0]
 --orf-filter-e DOUBLE            E-value threshold used for query ORF prefiltering [1.000E+02]
 --orf-filter-s FLOAT             Sensitivity used for query ORF prefiltering [2.000]
 --lca-mode INT                   LCA Mode 1: single search LCA , 2/3: approximate 2bLCA, 4: top hit [3]
 --tax-output-mode INT            0: output LCA, 1: output alignment 2: output both [2]
 --majority FLOAT                 minimal fraction of agreement among taxonomically assigned sequences of a set [0.500]
 --vote-mode INT                  Mode of assigning weights to compute majority. 0: uniform, 1: minus log E-value, 2: score [1]
 --lca-ranks STR                  Add column with specified ranks (',' separated) []
 --tax-lineage INT                0: don't show, 1: add all lineage names, 2: add all lineage taxids [0]
 --blacklist STR                  Comma separated list of ignored taxa in LCA computation [12908:unclassified sequences,28384:other sequences]
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
 --prefilter-mode INT             prefilter mode: 0: kmer/ungapped 1: ungapped, 2: nofilter [0]
common:                         
 --compressed INT                 Write compressed output [0]
 --threads INT                    Number of CPU-cores used (all by default) [20]
 -v INT                           Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --sub-mat TWIN                   Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT                Maximum sequence length [65535]
 --db-load-mode INT               Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
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
 The LCA of a majority of predictions will be assigned to their contig

references:
 - Levy Karin E, Mirdita M, Soeding J: MetaEuk – sensitive, high-throughput gene discovery and annotation for large-scale eukaryotic metagenomics. biorxiv, 851964 (2019).
```


## metaeuk_reduceredundancy

### Tool Description
By Eli Levy Karin <eli.levy.karin@gmail.com>

### Metadata
- **Docker Image**: quay.io/biocontainers/metaeuk:7.bba0d80--pl5321hd6d6fdc_2
- **Homepage**: https://github.com/soedinglab/metaeuk
- **Package**: https://anaconda.org/channels/bioconda/packages/metaeuk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metaeuk reduceredundancy <i:calledExonsDB> <o:predictionsExonsDB> <o:predToCall> [options]
 By Eli Levy Karin <eli.levy.karin@gmail.com>
options: misc:             
 --overlap INT      allow predictions to overlap another on the same strand. when not allowed (default), only the prediction with better E-value will be retained [0,1] [0]
common:           
 --threads INT      Number of CPU-cores used (all by default) [20]
 --compressed INT   Write compressed output [0]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

examples:
 A greedy examination of calls according to their contig order, subordered by the number of exons. Calls in a cluster share an exon with the representative.

references:
 - Levy Karin E, Mirdita M, Soeding J: MetaEuk – sensitive, high-throughput gene discovery and annotation for large-scale eukaryotic metagenomics. biorxiv, 851964 (2019).
```


## metaeuk_unitesetstofasta

### Tool Description
By Eli Levy Karin <eli.levy.karin@gmail.com>

### Metadata
- **Docker Image**: quay.io/biocontainers/metaeuk:7.bba0d80--pl5321hd6d6fdc_2
- **Homepage**: https://github.com/soedinglab/metaeuk
- **Package**: https://anaconda.org/channels/bioconda/packages/metaeuk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metaeuk unitesetstofasta <i:contigsDB> <i:targetsDB> <i:exonsDB> <o:unitedExonsFasta> [options]
 By Eli Levy Karin <eli.levy.karin@gmail.com>
options: misc:                     
 --protein INT              translate the joint exons coding sequence to amino acids [0,1] [0]
 --translation-table INT    1) CANONICAL, 2) VERT_MITOCHONDRIAL, 3) YEAST_MITOCHONDRIAL, 4) MOLD_MITOCHONDRIAL, 5) INVERT_MITOCHONDRIAL, 6) CILIATE
                            9) FLATWORM_MITOCHONDRIAL, 10) EUPLOTID, 11) PROKARYOTE, 12) ALT_YEAST, 13) ASCIDIAN_MITOCHONDRIAL, 14) ALT_FLATWORM_MITOCHONDRIAL
                            15) BLEPHARISMA, 16) CHLOROPHYCEAN_MITOCHONDRIAL, 21) TREMATODE_MITOCHONDRIAL, 22) SCENEDESMUS_MITOCHONDRIAL
                            23) THRAUSTOCHYTRIUM_MITOCHONDRIAL, 24) PTEROBRANCHIA_MITOCHONDRIAL, 25) GRACILIBACTERIA, 26) PACHYSOLEN, 27) KARYORELICT, 28) CONDYLOSTOMA
                             29) MESODINIUM, 30) PERTRICH, 31) BLASTOCRITHIDIA [1]
 --target-key INT           write the target key (internal DB identifier) instead of its accession. By default (0) target accession will be written [0,1] [0]
 --write-frag-coords INT    write the contig coords of the stop-to-stop fragment in which putative exon lies. By default (0) only putative exon coords will be written [0,1] [0]
 --len-scan-for-start INT   length to scan for a start codon before the first exon and in the same frame. By default (0) no scan [0]
common:                   
 --max-seq-len INT          Maximum sequence length [65535]
 --threads INT              Number of CPU-cores used (all by default) [20]
 -v INT                     Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

examples:
 Each optimal set is joined to a single sequence of codons or amino-acids. In addition, a TSV map for each header to internal idenfiers.

references:
 - Levy Karin E, Mirdita M, Soeding J: MetaEuk – sensitive, high-throughput gene discovery and annotation for large-scale eukaryotic metagenomics. biorxiv, 851964 (2019).
```


## metaeuk_groupstoacc

### Tool Description
Replace the internal contig, target and strand identifiers with accessions from the headers

### Metadata
- **Docker Image**: quay.io/biocontainers/metaeuk:7.bba0d80--pl5321hd6d6fdc_2
- **Homepage**: https://github.com/soedinglab/metaeuk
- **Package**: https://anaconda.org/channels/bioconda/packages/metaeuk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metaeuk groupstoacc <i:contigsDB> <i:targetsDB> <i:predToCall> <o:predToCallInfoTSV> [options]
 By Eli Levy Karin <eli.levy.karin@gmail.com>
options: common:        
 --threads INT   Number of CPU-cores used (all by default) [20]
 -v INT          Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

examples:
 Replace the internal contig, target and strand identifiers with accessions from the headers

references:
 - Levy Karin E, Mirdita M, Soeding J: MetaEuk – sensitive, high-throughput gene discovery and annotation for large-scale eukaryotic metagenomics. biorxiv, 851964 (2019).
```


## Metadata
- **Skill**: generated
