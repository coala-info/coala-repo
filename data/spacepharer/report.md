# spacepharer CWL Generation Report

## spacepharer_easy-predict

### Tool Description
By Ruoshi Zhang <ruoshi.zhang@mpibpc.mpg.de>

### Metadata
- **Docker Image**: quay.io/biocontainers/spacepharer:5.c2e680a--hd6d6fdc_7
- **Homepage**: https://github.com/soedinglab/spacepharer
- **Package**: https://anaconda.org/channels/bioconda/packages/spacepharer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/spacepharer/overview
- **Total Downloads**: 18.5K
- **Last updated**: 2025-07-27
- **GitHub**: https://github.com/soedinglab/spacepharer
- **Stars**: N/A
### Original Help Text
```text
usage: spacepharer easy-predict <i:spacerFile1[.txt]> ... <i:spacerFileN[.txt]> <i:targetDB> <o:output[.tsv]> <tmpDir> [options]
 By Ruoshi Zhang <ruoshi.zhang@mpibpc.mpg.de>
options: prefilter:                      
 --comp-bias-corr INT             Correct for locally biased amino acid composition (range 0-1) [1]
 --add-self-matches BOOL          Artificially add entries of queries with themselves (for clustering) [0]
 --seed-sub-mat TWIN              Substitution matrix file for k-mer generation [nucl:nucleotide.out,aa:VTML80.out]
 -s FLOAT                         Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [5.700]
 -k INT                           k-mer length (0: automatically set to optimum) [6]
 --k-score INT                    k-mer threshold for generating similar k-mer lists [2147483647]
 --alph-size TWIN                 Alphabet size (range 2-21) [nucl:5,aa:21]
 --max-seqs INT                   Maximum results per query sequence allowed to pass the prefilter (affects sensitivity) [0.000]
 --split INT                      Split input into N equally distributed chunks. 0: set the best split automatically [0]
 --split-mode INT                 0: split target db; 1: split query db; 2: auto, depending on main memory [2]
 --split-memory-limit BYTE        Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
 --diag-score BOOL                Use ungapped diagonal scoring during prefilter [1]
 --exact-kmer-matching INT        Extract only exact k-mers for matching (range 0-1) [0]
 --mask INT                       Mask sequences in k-mer stage: 0: w/o low complexity masking, 1: with low complexity masking [1]
 --mask-lower-case INT            Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
 --min-ungapped-score INT         Accept only matches with ungapped alignment score above threshold [15]
 --spaced-kmer-mode INT           0: use consecutive positions in k-mers; 1: use spaced k-mers [1]
 --spaced-kmer-pattern STR        User-specified spaced k-mer pattern [11011101]
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
 -e DOUBLE                        List matches below this E-value (range 0.0-inf) [2.000E+02]
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
 --gap-open TWIN                  Gap open cost [nucl:10,aa:16]
 --gap-extend TWIN                Gap extension cost [2]
 --zdrop INT                      Maximal allowed difference between score values before alignment is truncated  (nucleotide alignment only) [40]
 --exhaustive-search-filter INT   Filter result during search: 0: do not filter, 1: filter [0]
profile:                        
 --pca FLOAT                      Pseudo count admixture strength [1.000]
 --pcb FLOAT                      Pseudo counts: Neff at half of maximum admixture (range 0.0-inf) [1.500]
 --mask-profile INT               Mask query sequence of profile using tantan [0,1] [1]
 --e-profile DOUBLE               Include sequences matches with < E-value thr. into the profile (>=0.0) [1.000E-03]
 --wg BOOL                        Use global sequence weighting for profile calculation [0]
 --filter-msa INT                 Filter msa: 0: do not filter, 1: filter [1]
 --max-seq-id FLOAT               Reduce redundancy of output MSA using max. pairwise sequence identity [0.0,1.0] [0.900]
 --qid FLOAT                      Reduce diversity of output MSAs using min.seq. identity with query sequences [0.0,1.0] [0.000]
 --qsc FLOAT                      Reduce diversity of output MSAs using min. score per aligned residue with query sequences [-50.0,100.0] [-20.000]
 --cov FLOAT                      Filter output MSAs using min. fraction of query residues covered by matched sequences [0.0,1.0] [0.000]
 --diff INT                       Filter MSAs by selecting most diverse set of sequences, keeping at least this many seqs in each MSA block of length 50 [1000]
 --num-iterations INT             Number of iterative profile search iterations [1]
 --exhaustive-search BOOL         For bigger profile DB, run iteratively the search by greedily swapping the search results [0]
 --lca-search BOOL                Efficient search for LCA candidates [0]
misc:                           
 --tax-mapping-file STR           File to map sequence identifier to taxonomical identifier []
 --ncbi-tax-dump STR              NCBI tax dump directory. The tax dump can be downloaded here "ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz" []
 --rescore-mode INT               Rescore diagonals with:
                                  0: Hamming distance
                                  1: local alignment (score only)
                                  2: local alignment
                                  3: global alignment
                                  4: longest alignment fulfilling window quality criterion [0]
 --allow-deletion BOOL            Allow deletions in a MSA [0]
 --min-length INT                 Minimum codon number in open reading frames [9]
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
 --fdr FLOAT                      FDR cutoff for filtering matches [0.0, 1.0] [0.050]
 --fmt INT                        0: short (only matches)
                                  1: long (matches and hits)
                                  2: long with nucleotide alignment [1]
 --lca-ranks STR                  Add column with specified ranks (',' separated) [superkingdom,phylum,class,order,family,genus,species]
 --tax-lineage INT                0: don't show, 1: add all lineage names, 2: add all lineage taxids [0]
 --flanking-seq-len INT           Length of protospacer flanking sequence to extract for possible PAMs scanning [10]
 --tax-fdr FLOAT                  FDR cutoff for taxonomy report [0.0, 1.0] [0.020]
 --restrict-ranks-mode INT        0: disabled, 1: restrict taxonomic rank on target prediction by sequence identity [1]
 --rank-min-seq-ids STR           Comma-separated sequence identity thresholds to restrict ranks to:
                                  species, genus, family, order, class, phylum, kingdom, superkingdom [0.86,0.84,0.82,0.80,0.78,0.76,0.74,0.72]
 --report-pam INT                 Report protospacer adjacent motifs up and downstream of hits [1]
 --perform-nucl-aln INT           0: perform only 6-frame translated search, 1:perform additional nucl-nucl alignment to the hits reported in 6-frame translated search, and update the E-value [1]
common:                         
 --sub-mat TWIN                   Substitution matrix file [nucl:nucleotide.out,aa:VTML40.out]
 --max-seq-len INT                Maximum sequence length [0.000]
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
 --db-output BOOL                 Return a result DB instead of a text file [0]

references:
 - Zhang R, Mirdita M, Levy Karin E, Norroy C, Galiez C, and Soding J: SpacePHARER: Sensitive identification of phages from CRISPR spacers in prokaryotic hosts. (2020)
```

