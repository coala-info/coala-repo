# mmseqs2 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mmseqs2_addtaxonomy | PASS | 3 real proteins (SARS-CoV, human, E. coli) searched against an 11-protein taxonomy database made with createtaxdb; result gained taxon id, rank, name and lineage columns |
| mmseqs2_aggregatetax | PASS | 387 translated ORFs of the SARS-CoV-2 genome (4 hit an 11-protein taxonomy database) grouped as one set gave contig taxon SARS-CoV-2 (387 ORFs, 4 assigned, agreement 1.0) |
| mmseqs2_aliasdb | PASS | alias of a 100-protein database; the links resolve and give the same entries as the source |
| mmseqs2_align | PASS | 100 queries against 3000 UniProt proteins (MMseqs2 examples): prefilter hits aligned, 368 alignments with E-values |
| mmseqs2_alignall | PASS | 3000 proteins aligned inside their clusters: 7817 alignment rows |
| mmseqs2_alignbykmer | PASS | 100 queries against 3000 proteins gave 197 k-mer based alignments with CIGAR strings |
| mmseqs2_apply | PASS | wc -c run on each entry of a 100-sequence database; entry 0 gives 58 = sequence length 57 plus newline |
| mmseqs2_besthitperset | PASS | synthetic split of the real SARS-CoV-2 genome into contig sets (multihitdb, multihitsearch); output is byte-identical to the aggregate step of multihitsearch |
| mmseqs2_clust | PASS | 3000 proteins (self prefilter result) clustered into 1087 clusters that cover all 3000 members |
| mmseqs2_cluster | PASS | 20000 proteins gave 5763 clusters; createtsv lists all 20000 members |
| mmseqs2_clusterupdate | PASS | old clustering of 3000 proteins updated with a database that lost 20 and gained 10 sequences: 2990 members in 1972 clusters |
| mmseqs2_clusthash | PASS | 3000 proteins: 3000 self matches; 77 non-self matches at 99% identity or more |
| mmseqs2_combinepvalperset | Failed | tool bug: the usage line lists 4 paths but the tool asks for 5 and crashes (exit 139) with the documented arguments |
| mmseqs2_compress | PASS | compressed database is about half the size and gives the same entries as the source |
| mmseqs2_concatdbs | PASS | 100 + 3000 sequences joined into 3100 entries |
| mmseqs2_convert2fasta | PASS | 100 sequences written back with the same headers and sequences as the input FASTA (order differs because createdb shuffles) |
| mmseqs2_convertalis | PASS | alignment database converted to a BLAST-tab table with headers (694 hits); self hits at 100% identity |
| mmseqs2_convertca3m | Not completed | no cA3M test database: result2msa refuses to write cA3M for the test data (indexed target message) |
| mmseqs2_convertkb | PASS | 4 real UniProtKB entries (REST download) gave a database with 17 column databases; AC column lists the accessions |
| mmseqs2_convertmsa | PASS | real Pfam seed alignment PF00013 (Stockholm) gave a one-entry MSA database with the aligned sequences |
| mmseqs2_convertprofiledb | PASS | real HH-suite HHM database (nf-core test data, 2 entries; .ffdata and .ffindex renamed to data and .index) gave profile and header entries |
| mmseqs2_countkmer | PASS | 3-mer counts of 100 proteins: 8000 rows; counts sum to 44856, the total number of 3-mers |
| mmseqs2_cpdb | PASS | copy of a 3000-protein database is byte-identical to the source |
| mmseqs2_createbintaxonomy | PASS | 64-node taxdump gave a binary taxonomy file that createtaxdb and createdmptaxonomy can read |
| mmseqs2_createdb | PASS | 20000-protein UniProt FASTA gave a database with 20000 entries, headers and lookup file |
| mmseqs2_createdmptaxonomy | PASS | names.dmp identical to the source taxdump (64 names); node ids, parents and ranks identical |
| mmseqs2_createindex | PASS | built the k-mer index (db.idx) for the 20000-protein database; a search on it gives the same hits as without index; index is about 970 MB |
| mmseqs2_createlinindex | PASS | built the linsearch index (tdb.linidx); easy-linsearch on it gives 21 hits, all also found by normal search |
| mmseqs2_createseqfiledb | PASS | 559 clusters with 2 or more members, the same count as in the cluster table |
| mmseqs2_createsubdb | PASS | keys 0,1,2,5,10 gave 5 entries with headers; subsetting by the keys of a result database also works (ancillary links are copied by the wrapper) |
| mmseqs2_createtaxdb | PASS | tiny taxonomy set (11 real UniProt proteins, 64-node taxdump): mapping and taxonomy files written; taxonomy search labels SARS-CoV-2, human and E. coli correctly |
| mmseqs2_createtsv | PASS | cluster database written as a table; give the target database to get sequence names instead of numeric keys |
| mmseqs2_databases | PASS | Resfinder downloaded and converted: 101298 sequences with headers |
| mmseqs2_db2tar | Failed | tool bug: an output named .tar.gz is written as a plain uncompressed tar (the tar itself lists the 100 entries) |
| mmseqs2_decompress | PASS | decompressed copy of a compressed database gives the same entries as the original |
| mmseqs2_diffseqdbs | PASS | old 3000 vs new 2990 sequences: 20 removed, 2980 kept, 10 new, as planted |
| mmseqs2_easy-cluster | PASS | 20000 proteins clustered into 5760 clusters; cluster table, all-sequence and representative FASTA files all agree |
| mmseqs2_easy-linclust | PASS | 20000 proteins clustered into 15119 clusters by linear-time clustering; table and FASTA files agree |
| mmseqs2_easy-linsearch | Failed | tool bug: with a FASTA target it returns no hits even for identical sequences; only a precomputed linidx database gives hits (21) |
| mmseqs2_easy-rbh | PASS | 100 queries against 3000 proteins gave 69 reciprocal best hits; 67 of the 69 pairs are also in a normal search |
| mmseqs2_easy-search | PASS | 30 real UniProt queries against 20000 UniProt proteins (MMseqs2 examples) gave 694 hits in 28 queries; the same pairs as search plus convertalis; self hits at 100% identity |
| mmseqs2_easy-taxonomy | PASS | synthetic data: tiny taxonomy database (11 real UniProt proteins, 64-node taxdump) made with createtaxdb; SARS-CoV spike, human ACE2 and E. coli HslV got the right taxa |
| mmseqs2_expand2profile | PASS | 100 profiles (one per query) built from a search result expanded with target self alignments |
| mmseqs2_expandaln | PASS | 559 expanded alignments, more than the 477 of the input search |
| mmseqs2_extractdomains | PASS | self alignments plus FASTA MSA database: 4 non-empty entries with domain rows (needs -e 10; default thresholds give empty entries) |
| mmseqs2_extractframes | PASS | SARS-CoV-2 genome (30 kb) gave 6 translated frames |
| mmseqs2_extractorfs | PASS | SARS-CoV-2 genome (nf-core sarscov2, 30 kb) gave 387 ORFs, same as a direct mmseqs run |
| mmseqs2_filterdb | PASS | protein alignment database filtered to the top hit per query: 51 alignments became 30, one per query |
| mmseqs2_filterresult | PASS | re-filter of 51 alignments with max_seq_id 0.5 kept 13 hits, none above 50% identity |
| mmseqs2_filtertaxdb | PASS | synthetic data: tiny taxonomy database (11 real UniProt proteins); taxon list 9606 kept only the human hit |
| mmseqs2_filtertaxseqdb | PASS | synthetic data: tiny taxonomy database (11 real UniProt proteins); taxon list 2697049 kept the 3 SARS-CoV-2 proteins |
| mmseqs2_fwbw | PASS | 30 real UniProt queries against 500 proteins: forward-backward realignment gave 51 alignments, same pairs as align; self hits at 100% identity |
| mmseqs2_gappedprefilter | PASS | 30 real UniProt queries against 500 proteins gave 68 candidate pairs, all 30 self hits found |
| mmseqs2_gff2db | PASS | 12 CDS features of the SARS-CoV-2 GFF3 extracted from the genome as 12 sequences (first one 13203 nt, starts with ATG) |
| mmseqs2_kmermatcher | PASS | 500 real UniProt proteins gave a k-mer match database with 519 pairs |
| mmseqs2_kmersearch | PASS | 30 real UniProt queries against a k-mer index of 500 proteins (made with createlinindex) gave 33 target entries; needs kmer_per_seq above 0 and a matching seed_sub_mat |
| mmseqs2_lca | PASS | synthetic data: tiny taxonomy database (11 real UniProt proteins); SARS-CoV-2, E. coli K12 and human queries got the right taxa with lineages |
| mmseqs2_lcaalign | PASS | synthetic data: tiny taxonomy database; the 3 queries gave gapped alignments at 98%, 94% and 98% identity |
| mmseqs2_linclust | PASS | 20000 proteins gave 15118 clusters at 90% identity; createtsv lists all 20000 members |
| mmseqs2_linsearch | Failed | tool bug: gives empty results even for identical sequences (30 empty entries); easy-linsearch gives the same, the internal filterdb step removes every candidate |
| mmseqs2_lndb | PASS | 30-protein database linked to a new name; the wrapper turns the links into real files and the data equals the source |
| mmseqs2_majoritylca | PASS | synthetic data: tiny taxonomy database; SARS-CoV-2, E. coli K12 and human queries got the same taxa as lca |
| mmseqs2_map | PASS | 30 real UniProt queries against 500 proteins gave 34 hits in 30 queries, all 30 self hits at 100% identity |
| mmseqs2_maskbygff | Failed | tool bug: stops with "GFF entry not found in input database" for accessions that are in the database lookup (gff2db finds them in the same files) |
| mmseqs2_masksequence | PASS | 30 real proteins: 232 residues in 5 sequences soft-masked (lower case), the sequences are otherwise unchanged |
| mmseqs2_mergeclusters | PASS | cascaded linclust and cluster steps on 500 proteins merged into 463 clusters covering all 500 members |
| mmseqs2_mergedbs | PASS | 500-entry sequence database merged with its header database: each entry is sequence plus header |
| mmseqs2_mergeresultsbyset | PASS | ORF alignments of the SARS-CoV-2 genome (387 ORF entries) merged by set into 1 contig entry holding the best hit |
| mmseqs2_msa2profile | PASS | 30 MSAs (from result2msa) converted to 30 profiles; same data as a direct mmseqs run |
| mmseqs2_msa2result | PASS | 30 MSAs converted to a sequence database (81 entries) and a profile database (30 entries) |
| mmseqs2_multihitdb | PASS | SARS-CoV-2 genome gave a set database with 387 ORFs in 1 set and the helper databases |
| mmseqs2_multihitsearch | PASS | set database of the SARS-CoV-2 genome searched against itself gave 1 result entry with hits and p-values |
| mmseqs2_mvdb | PASS | 30-protein database moved to a new name; data equals the source |
| mmseqs2_nrtotaxmapping | PASS | synthetic data: 11 UniProt accessions mapped to taxon ids with a 4-column accession2taxid file; the tool reads names.dmp, nodes.dmp and merged.dmp from the working directory (now inputs) |
| mmseqs2_offsetalignment | PASS | ORF alignment of the SARS-CoV-2 genome moved to contig coordinates (positions 27886-28245 of the 29829 nt contig); same as a direct mmseqs run |
| mmseqs2_orftocontig | PASS | 387 ORFs mapped to contig coordinates, e.g. ORF 0 at 23866-24030 of the 29829 nt contig |
| mmseqs2_pickconsensusrep | PASS | 500 proteins in 493 linclust clusters got 492 consensus-based representatives |
| mmseqs2_prefilter | PASS | 30 real UniProt queries against 500 proteins gave 63 candidate pairs, same as a direct mmseqs run; all 30 self hits found |
| mmseqs2_prefixid | PASS | 30-protein database got the prefix Q_ added to every entry |
| mmseqs2_profile2consensus | PASS | 30 profiles gave 30 consensus sequences (first starts MDNKRTSIFIAG, the query sequence) |
| mmseqs2_profile2neff | PASS | 30 profiles gave one line of Neff scores each (1.0 per position for single-sequence profiles) |
| mmseqs2_profile2pssm | PASS | 30 profiles written as a position-specific scoring matrix table (13741 lines, 20 amino acid columns) |
| mmseqs2_profile2repseq | PASS | 30 profiles gave 30 representative sequences with headers |
| mmseqs2_proteinaln2nucl | PASS | 10 translated sequence alignments of SARS-CoV-2 genome pieces became nucleotide alignments (3000M, 100% identity, nucleotide coordinates) |
| mmseqs2_rbh | PASS | 30 proteins against the 20000-protein database gave 30 reciprocal-best-hit entries with expected hits and E-values |
| mmseqs2_renamedbkeys | PASS | 30-entry sequence database written with keys renamed 0..29 to 1000..1029 and the sequences unchanged |
| mmseqs2_rescorediagonal | PASS | prefilter hits of 30 proteins rescored into a 30-entry result database with scores and diagonals |
| mmseqs2_result2dnamsa | PASS | 10 nucleotide pieces of the SARS-CoV-2 genome gave a 10-entry DNA MSA database with FASTA-format alignments |
| mmseqs2_result2flat | PASS | cluster sequence file (from createseqfiledb) written as FASTA with 20000 members under 5763 cluster headers |
| mmseqs2_result2msa | PASS | 30 protein search results gave a 30-entry MSA database in aligned FASTA format |
| mmseqs2_result2profile | PASS | 30-entry profile database; profile2pssm shows consensus residues equal to the query sequences |
| mmseqs2_result2rbh | PASS | merged best-hit result of the rbh workflow gave 30 reciprocal best hit entries, equal to the rbh workflow output |
| mmseqs2_result2repseq | PASS | cluster result of 20000 proteins gave 5763 representative sequences |
| mmseqs2_result2stats | PASS | mean statistic written for 30 entries of a result database |
| mmseqs2_reverseseq | PASS | 30 protein sequences reversed; the output is the input read backwards |
| mmseqs2_rmdb | PASS | sequence database files removed from a copy of the directory; only the separate header database files stay |
| mmseqs2_search | PASS | 30 queries against the 20000-protein database gave an alignment database with 30 entries |
| mmseqs2_sequence2profile | Not completed | profile database written, but profile2pssm shows the best residue at only about 5% of positions equal to the query and a search with it finds almost no hits, so the output could not be confirmed |
| mmseqs2_setextendeddbtype | PASS | database type file changed from 0 to extended type 2 in a copy of the database; sequences unchanged |
| mmseqs2_sortresult | PASS | 30-entry alignment result database sorted, hits listed by decreasing score |
| mmseqs2_splitdb | PASS | 20000 proteins split into 3 databases of 6666, 6666 and 6668 entries |
| mmseqs2_splitsequence | PASS | 29903-base SARS-CoV-2 genome split into 10 sequences of at most 3000 bases |
| mmseqs2_subtractdbs | PASS | alignment result minus its 10-query subset gave a 30-entry database with those 10 entries now empty |
| mmseqs2_suffixid | PASS | every line of the 10 result entries has its entry key appended as last column |
| mmseqs2_summarizealis | PASS | 30 alignment entries summarized to one row each (coverage, mean identity) |
| mmseqs2_summarizeheaders | Not completed | cluster header summaries came out with empty Representative and Members fields for UniProt and UniRef style headers; could not confirm the output |
| mmseqs2_summarizeresult | PASS | 30 search results with backtraces summarized into a 30-entry alignment database; note: the tool crashes (double free) on a plain align-module result database |
| mmseqs2_summarizetabs | PASS | BLAST-tab hits of 30 proteins grouped per query gave a summarized domain database with expected lines |
| mmseqs2_swapdb | PASS | 30-query alignment database transposed into 544 target-keyed entries |
| mmseqs2_swapresults | PASS | 30-query alignment database swapped into 20000 target entries |
| mmseqs2_tar2db | PASS | tar archive of 3 FASTA files became a 3-entry database holding the SARS-CoV, SARS-CoV-2 and human sequences |
| mmseqs2_taxonomy | PASS | synthetic data: tiny taxonomy database (11 real UniProt proteins, 64-node taxdump); SARS-CoV-2, human and E. coli K12 queries got the right taxa |
| mmseqs2_taxonomyreport | PASS | synthetic data: tiny taxonomy database; Kraken report from the taxonomy result lists the three correct lineages |
| mmseqs2_transitivealign | PASS | 30-protein self-alignment result transferred into a 30-entry alignment database |
| mmseqs2_translateaa | PASS | 30 proteins converted into 30 nucleotide codon sequences of the right length |
| mmseqs2_translatenucs | PASS | 10 SARS-CoV-2 genome pieces translated to 10 protein sequences with stop marks |
| mmseqs2_tsv2db | PASS | cluster table of 20000 proteins became a 5763-entry database, one entry per cluster |
| mmseqs2_ungappedprefilter | PASS | 30 proteins against the 20000-protein database gave a 30-entry prefilter result with ungapped scores |
| mmseqs2_unpackdb | PASS | 30-entry sequence database unpacked into 30 files named by accession, each holding one sequence |
| mmseqs2_view | PASS | entries 0, 1 and 2 of the 30-protein database printed to standard output as sequences |

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

## mmseqs2_proteinaln2nucl

### Tool Description
Transform protein alignments into nucleotide alignments, using the nucleotide and protein databases of the same sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs proteinaln2nucl <i:nuclQueryDB> <i:nuclTargetDB> <i:aaQueryDB> <i:aaTargetDB> <i:alnDB> <o:alnDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr> 
options: align:            
 --gap-open TWIN    Gap open cost [aa:11,nucl:5]
 --gap-extend TWIN  Gap extension cost [aa:1,nucl:2]
common:           
 --sub-mat TWIN     Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --threads INT      Number of CPU-cores used (all by default) [20]
 --compressed INT   Write compressed output [0]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_rbh

### Tool Description
Reciprocal best hit search of a query database against a target database; the result is an alignment database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs rbh <i:queryDB> <i:targetDB> <o:alignmentDB> <tmpDir> [options]
 By Eli Levy Karin
options: prefilter:                      
 --comp-bias-corr INT             Correct for locally biased amino acid composition (range 0-1) [0]
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
 --mask INT                       Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [0]
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
 --min-length INT                 Minimum codon number in open reading frames [10]
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

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_renamedbkeys

### Tool Description
Create a new database with the keys of the entries renamed according to an ID map file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs renamedbkeys <i:idMapFile|stdin> <i:DB> <o:DB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: misc:             
 --subdb-mode INT   Subdb mode 0: copy data 1: soft link data and write index [0]
common:           
 --threads INT      Number of CPU-cores used (all by default) [20]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_rescorediagonal

### Tool Description
Compute sequence identity for the diagonals found by a prefilter, giving an alignment database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs rescorediagonal <i:queryDB> <i:targetDB> <i:prefilterDB> <o:resultDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:              
 --add-self-matches BOOL  Artificially add entries of queries with themselves (for clustering) [0]
align:                  
 --wrapped-scoring BOOL   Double the (nucleotide) query sequence during the scoring process to allow wrapped diagonal scoring around end and start [0]
 -e DOUBLE                List matches below this E-value (range 0.0-inf) [1.000E-03]
 -c FLOAT                 List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 -a BOOL                  Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --cov-mode INT           0: coverage of query and target
                          1: coverage of target
                          2: coverage of query
                          3: target seq. length has to be at least x% of query length
                          4: query seq. length has to be at least x% of target length
                          5: short seq. needs to be at least x% of the other seq. length [0]
 --min-seq-id FLOAT       List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 --min-aln-len INT        Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT        0: alignment length 1: shorter, 2: longer sequence [0]
misc:                   
 --rescore-mode INT       Rescore diagonals with:
                          0: Hamming distance
                          1: local alignment (score only)
                          2: local alignment
                          3: global alignment
                          4: longest alignment fulfilling window quality criterion [0]
common:                 
 --sub-mat TWIN           Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --db-load-mode INT       Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT            Number of CPU-cores used (all by default) [20]
 --compressed INT         Write compressed output [0]
 -v INT                   Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
expert:                 
 --filter-hits BOOL       Filter hits by seq.id. and coverage [0]
 --sort-results INT       Sort results: 0: no sorting, 1: sort by E-value (Alignment) or seq.id. (Hamming) [0]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_result2dnamsa

### Tool Description
Compute a multiple sequence alignment database without insertions in the query, for nucleotide sequences, from a result database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs result2dnamsa <i:queryDB> <i:targetDB> <i:resultDB> <o:msaDB> [options]
 By Martin Steinegger (martin.steinegger@snu.ac.kr)
options: common:           
 --threads INT      Number of CPU-cores used (all by default) [20]
 --compressed INT   Write compressed output [0]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
expert:           
 --skip-query BOOL  Skip the query sequence [0]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_result2msa

### Tool Description
Compute a multiple sequence alignment database from a result database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs result2msa <i:queryDB> <i:targetDB> <i:resultDB> <o:msaDB> [options]
 By Martin Steinegger (martin.steinegger@snu.ac.kr) & Milot Mirdita <milot@mirdita.de> & Clovis Galiez
options: prefilter:                  
 --comp-bias-corr INT         Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT Correct for locally biased amino acid composition (range 0-1) [1.000]
align:                      
 --gap-open TWIN              Gap open cost [aa:11,nucl:5]
 --gap-extend TWIN            Gap extension cost [aa:1,nucl:2]
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
 --sub-mat TWIN               Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
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

## mmseqs2_result2profile

### Tool Description
Compute a profile database from a result database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs result2profile <i:queryDB> <i:targetDB> <i:resultDB> <o:profileDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                  
 --comp-bias-corr INT         Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT Correct for locally biased amino acid composition (range 0-1) [1.000]
align:                      
 -e DOUBLE                    List matches below this E-value (range 0.0-inf) [1.000E-03]
 --gap-open TWIN              Gap open cost [aa:11,nucl:5]
 --gap-extend TWIN            Gap extension cost [aa:1,nucl:2]
profile:                    
 --mask-profile INT           Mask query sequence of profile using tantan [0,1] [1]
 --e-profile DOUBLE           Include sequences matches with < E-value thr. into the profile (>=0.0) [1.000E-03]
 --wg BOOL                    Use global sequence weighting for profile calculation [0]
 --filter-msa INT             Filter msa: 0: do not filter, 1: filter [1]
 --filter-min-enable INT      Only filter MSAs with more than N sequences, 0 always filters [0]
 --max-seq-id FLOAT           Reduce redundancy of output MSA using max. pairwise sequence identity [0.0,1.0] [0.900]
 --qid STR                    Reduce diversity of output MSAs using min.seq. identity with query sequences [0.0,1.0]
                              Alternatively, can be a list of multiple thresholds:
                              E.g.: 0.15,0.30,0.50 to defines filter buckets of ]0.15-0.30] and ]0.30-0.50] [0.0]
 --qsc FLOAT                  Reduce diversity of output MSAs using min. score per aligned residue with query sequences [-50.0,100.0] [-20.000]
 --cov FLOAT                  Filter output MSAs using min. fraction of query residues covered by matched sequences [0.0,1.0] [0.000]
 --diff INT                   Filter MSAs by selecting most diverse set of sequences, keeping at least this many seqs in each MSA block of length 50 [1000]
 --pseudo-cnt-mode INT        use 0: substitution-matrix or 1: context-specific pseudocounts [0]
 --pca                        Pseudo count admixture strength []
 --pcb                        Pseudo counts: Neff at half of maximum admixture (range 0.0-inf) []
 --profile-output-mode INT    Profile output mode: 0: binary log-odds 1: human-readable frequencies [0]
misc:                       
 --allow-deletion BOOL        Allow deletions in a MSA [0]
common:                     
 --sub-mat TWIN               Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --db-load-mode INT           Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                Number of CPU-cores used (all by default) [20]
 --compressed INT             Write compressed output [0]
 -v INT                       Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_result2rbh

### Tool Description
Filter a merged result database to retain only reciprocal best hits.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs result2rbh <i:resultDB> <o:resultDB> [options]
 By Eli Levy Karin
options: common:           
 --threads INT      Number of CPU-cores used (all by default) [20]
 --compressed INT   Write compressed output [0]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_result2repseq

### Tool Description
Get the representative sequences of a result (for example a cluster) database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs result2repseq <i:sequenceDB> <i:resultDB> <o:sequenceDb> [options]
 By Milot Mirdita <milot@mirdita.de> & Martin Steinegger <martin.steinegger@snu.ac.kr>
options: common:             
 --db-load-mode INT   Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --compressed INT     Write compressed output [0]
 --threads INT        Number of CPU-cores used (all by default) [20]
 -v INT               Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_result2stats

### Tool Description
Compute statistics for each entry of a result database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs result2stats <i:queryDB> <i:targetDB> <i:resultDB> <o:statsDB> [options]
 By Clovis Galiez & Martin Steinegger <martin.steinegger@snu.ac.kr>
options: misc:             
 --stat STR         One of: linecount, mean, min, max, doolittle, charges, seqlen, firstline []
 --tsv BOOL         Return output in TSV format [0]
common:           
 --compressed INT   Write compressed output [0]
 --threads INT      Number of CPU-cores used (all by default) [20]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_reverseseq

### Tool Description
Reverse the sequences of a sequence database (without complementing them).

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs reverseseq <i:sequenceDB> <o:revSequenceDB> [options]
 By Eli Levy Karin <eli.levy.karin@gmail.com> 
options: common:           
 --threads INT      Number of CPU-cores used (all by default) [20]
 --compressed INT   Write compressed output [0]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_rmdb

### Tool Description
Remove a database (all its files). The copy of the input directory is returned without the removed database files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs rmdb <i:DB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: common: 
 -v INT   Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_setextendeddbtype

### Tool Description
Write an extended database type into a database (.dbtype file).

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs setextendeddbtype <i:DB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: misc:                  
 --extended-dbtype INT   Set extended dbtype 1: compressed, 2: need src, 4: context pseudoe cnts [0]
common:                
 -v INT                  Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

examples:
 # Print entries with keys 1, 2 and 3 from a sequence DB to stdout
 mmseqs setextendedbtype db --extended-dbtype 2
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_sequence2profile

### Tool Description
Turn each sequence into a profile by adding context-specific pseudo counts.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs sequence2profile <i:sequenceDB> <o:profileDB> [options]
 By Martin Steinegger <martin.steinegger@mpibpc.mpg.de>
options: profile:          
 --pca              Pseudo count admixture strength []
 --pcb              Pseudo counts: Neff at half of maximum admixture (range 0.0-inf) []
 --neff FLOAT       Neff included into context state profile (1.0,20.0) [1.000]
 --tau FLOAT        Tau: context state pseudo count mixture (0.0,1.0) [0.900]
common:           
 --threads INT      Number of CPU-cores used (all by default) [20]
 --sub-mat TWIN     Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --compressed INT   Write compressed output [0]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Mirdita M, Steinegger M, Soding J: MMseqs2 desktop and local web server app for fast, interactive sequence searches. Bioinformatics, 35(16), 2856-2858 (2019)
```

## mmseqs2_sortresult

### Tool Description
Sort a result database in the same order as the prefilter or align module.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs sortresult <i:resultbDB> <o:resultDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: common:           
 --compressed INT   Write compressed output [0]
 --threads INT      Number of CPU-cores used (all by default) [20]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_splitdb

### Tool Description
Split a database into subsets of equal size.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs splitdb <i:DB> <o:DB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: common:           
 --split INT        Split input into N equally distributed chunks [0]
 --split-aa BOOL    Try to find the best split boundaries by entry lengths [0]
 --compressed INT   Write compressed output [0]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_splitsequence

### Tool Description
Split sequences of a sequence database by length.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs splitsequence <i:sequenceDB> <o:sequenceDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: misc:                      
 --sequence-overlap INT      Overlap between sequences [300]
 --sequence-split-mode INT   Sequence split mode 0: copy data, 1: soft link data and write new index, [1]
 --headers-split-mode INT    Header split mode: 0: split position, 1: original header [0]
common:                    
 --max-seq-len INT           Maximum sequence length [10000]
 --threads INT               Number of CPU-cores used (all by default) [20]
 --compressed INT            Write compressed output [0]
 -v INT                      Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
expert:                    
 --create-lookup INT         Create database lookup file (can be very large) [0]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_subtractdbs

### Tool Description
Remove all entries of the first result database that occur in the second one by key.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs subtractdbs <i:resultDBLeft> <i:resultDBRight> <o:resultDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: align:            
 -e DOUBLE          List matches below this E-value (range 0.0-inf) [1.000E-03]
profile:          
 --e-profile DOUBLE Include sequences matches with < E-value thr. into the profile (>=0.0) [1.000E-03]
common:           
 --threads INT      Number of CPU-cores used (all by default) [20]
 --compressed INT   Write compressed output [0]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_suffixid

### Tool Description
For each entry of a database, append the entry key to the entry itself.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs suffixid <i:resultDB> <o:resultDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: misc:               
 --prefix STR         Use this prefix for all entries []
 --mapping-file STR   Specify a file that translates the keys of a DB to new keys, TSV format []
 --tsv BOOL           Return output in TSV format [0]
common:             
 --threads INT        Number of CPU-cores used (all by default) [20]
 --compressed INT     Write compressed output [0]
 -v INT               Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_summarizealis

### Tool Description
Summarize an alignment result to one row per query (unique coverage, coverage, average sequence identity).

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs summarizealis <i:alignmentDB> <o:summerizedDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: common:           
 --threads INT      Number of CPU-cores used (all by default) [20]
 --compressed INT   Write compressed output [0]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Mirdita M, von den Driesch L, Galiez C, Martin M, Soding J, Steinegger M: Uniclust databases of clustered and deeply annotated protein sequences and alignments. Nucleic Acids Research 45(D1), D170-D176 (2017)
```

## mmseqs2_summarizeheaders

### Tool Description
Summarize the FASTA headers of a result database (for example the members of each cluster).

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs summarizeheaders <i:queryDB> <i:targetDB> <i:resultDb> <o:headerDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: misc:                 
 --header-type INT      Header Type: 1: Uniclust, 2: Metaclust [1]
common:               
 --threads INT          Number of CPU-cores used (all by default) [20]
 --compressed INT       Write compressed output [0]
 -v INT                 Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
expert:               
 --summary-prefix STR   Set the cluster summary prefix [cl]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Mirdita M, von den Driesch L, Galiez C, Martin M, Soding J, Steinegger M: Uniclust databases of clustered and deeply annotated protein sequences and alignments. Nucleic Acids Research 45(D1), D170-D176 (2017)
```

## mmseqs2_summarizeresult

### Tool Description
Extract annotations from an alignment database, merging overlapping regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs summarizeresult <i:alignmentDB> <o:alignmentDB> [options]
 By Milot Mirdita <milot@mirdita.de> & Martin Steinegger <martin.steinegger@snu.ac.kr>
options: align:            
 -a BOOL            Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 -c FLOAT           List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
misc:             
 --overlap FLOAT    Maximum overlap of covered regions [0.000]
common:           
 --threads INT      Number of CPU-cores used (all by default) [20]
 --compressed INT   Write compressed output [0]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Mirdita M, von den Driesch L, Galiez C, Martin M, Soding J, Steinegger M: Uniclust databases of clustered and deeply annotated protein sequences and alignments. Nucleic Acids Research 45(D1), D170-D176 (2017)
```

## mmseqs2_summarizetabs

### Tool Description
Extract annotations from BLAST-tab formatted results (for example from HHblits).

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs summarizetabs <i:blastTabDB> <i:lengthFile> <o:summarizedBlastTabDB> [options]
 By Milot Mirdita <milot@mirdita.de> & Martin Steinegger <martin.steinegger@snu.ac.kr>
options: align:            
 -e DOUBLE          List matches below this E-value (range 0.0-inf) [1.000E-03]
 -c FLOAT           List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
misc:             
 --overlap FLOAT    Maximum overlap of covered regions [0.000]
common:           
 --threads INT      Number of CPU-cores used (all by default) [20]
 --compressed INT   Write compressed output [0]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Mirdita M, von den Driesch L, Galiez C, Martin M, Soding J, Steinegger M: Uniclust databases of clustered and deeply annotated protein sequences and alignments. Nucleic Acids Research 45(D1), D170-D176 (2017)
```

## mmseqs2_swapdb

### Tool Description
Transpose a database with integer values in the first column.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs swapdb <i:resultDB> <o:resultDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>, Clovis Galiez & Eli Levy Karin
options: prefilter:                
 --split-memory-limit BYTE  Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
common:                   
 --threads INT              Number of CPU-cores used (all by default) [20]
 --compressed INT           Write compressed output [0]
 -v INT                     Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_swapresults

### Tool Description
Transpose a prefilter or alignment database (swap query and target).

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs swapresults <i:queryDB> <i:targetDB> <i:resultDB> <o:resultDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>, Clovis Galiez & Eli Levy Karin
options: prefilter:                
 --split-memory-limit BYTE  Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
align:                    
 -e DOUBLE                  List matches below this E-value (range 0.0-inf) [1.000E-03]
 --gap-open TWIN            Gap open cost [aa:11,nucl:5]
 --gap-extend TWIN          Gap extension cost [aa:1,nucl:2]
common:                   
 --sub-mat TWIN             Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --threads INT              Number of CPU-cores used (all by default) [20]
 --compressed INT           Write compressed output [0]
 --db-load-mode INT         Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 -v INT                     Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_tar2db

### Tool Description
Convert the content of tar archives into a database, one entry per file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs tar2db <i:tar[.gz]> ... <i:tar[.gz]> <o:resultDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: misc:                
 --output-dbtype INT   Set database type for resulting database: Amino acid sequences 0, Nucl. seq. 1, Profiles 2, Alignment result 5, Clustering result 6, Prefiltering result 7, Taxonomy result 8, Indexed database 9, cA3M MSAs 10, FASTA or A3M MSAs 11, Generic database 12, Omit dbtype file 13, Bi-directional prefiltering result 14, Offsetted headers 15 [12]
 --tar-include STR     Include file names based on this regex [.*]
 --tar-exclude STR     Exclude file names based on this regex [^$]
common:              
 --compressed INT      Write compressed output [0]
 --threads INT         Number of CPU-cores used (all by default) [20]
 -v INT                Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

examples:
 # Assuming tar archive containing three aligned FASTA files:
 #  * folder/msa1.fa.gz  * folder/msa2.fa  * folder/msa3.fa
 # Create a msaDB with three DB entries each containing a separate MSA
 mmseqs tar2db archive.tar.gz msaDB --output-dbtype 11
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_taxonomy

### Tool Description
Assign taxonomic labels to the sequences of a query database by searching a database that carries taxonomy (made, for example, with createtaxdb).

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs taxonomy <i:queryDB> <i:targetDB> <o:taxaDB> <tmpDir> [options]
 By Milot Mirdita <milot@mirdita.de> & Martin Steinegger <martin.steinegger@snu.ac.kr> & Eli Levy Karin <eli.levy.karin@gmail.com>
options: prefilter:                      
 --comp-bias-corr INT             Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT     Correct for locally biased amino acid composition (range 0-1) [1.000]
 --add-self-matches BOOL          Artificially add entries of queries with themselves (for clustering) [0]
 --seed-sub-mat TWIN              Substitution matrix file for k-mer generation [aa:VTML80.out,nucl:nucleotide.out]
 -s FLOAT                         Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [2.000]
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
                                  4: only ungapped alignment [1]
 --alignment-output-mode INT      How to compute the alignment:
                                  0: automatic
                                  1: only score and end_pos
                                  2: also start_pos and cov
                                  3: also seq.id
                                  4: only ungapped alignment
                                  5: score only (output) cluster format [0]
 --wrapped-scoring BOOL           Double the (nucleotide) query sequence during the scoring process to allow wrapped diagonal scoring around end and start [0]
 -e DOUBLE                        List matches below this E-value (range 0.0-inf) [1.000E+00]
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
 --max-rejected INT               Maximum rejected alignments before alignment calculation for a query is stopped [5]
 --max-accept INT                 Maximum accepted alignments before alignment calculation for a query is stopped [30]
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
                                  NOTE: Consider disabling when classifying short reads [1]
 --orf-filter-e DOUBLE            E-value threshold used for query ORF prefiltering [1.000E+02]
 --orf-filter-s FLOAT             Sensitivity used for query ORF prefiltering [2.000]
 --lca-mode INT                   LCA Mode 1: single search LCA , 2/3: approximate 2bLCA, 4: top hit [3]
 --tax-output-mode INT            0: output LCA, 1: output alignment 2: output both [0]
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
 --remove-tmp-files BOOL          Delete temporary files [0]
expert:                         
 --filter-hits BOOL               Filter hits by seq.id. and coverage [0]
 --sort-results INT               Sort results: 0: no sorting, 1: sort by E-value (Alignment) or seq.id. (Hamming) [0]
 --create-lookup INT              Create database lookup file (can be very large) [0]
 --chain-alignments INT           Chain overlapping alignments [0]
 --merge-query INT                Combine ORFs/split sequences to a single entry [1]
 --strand INT                     Strand selection only works for DNA/DNA search 0: reverse, 1: forward, 2: both [1]

examples:
 # Download a sequence database with taxonomy information
 mmseqs databases UniProtKB/Swiss-Prot swissprotDB tmp
 
 # Assign taxonomy based on 2bLCA
 mmseqs taxonomy queryDB swissprotDB result tmp
 
 # Assign taxonomy based on top hit
 mmseqs taxonomy queryDB swissprotDB result tmp --lca-mode 4
 
 # Assign taxonomy without ORF prefilter
 # Classifies higher percentage for short nucleotide input (e.g. short reads) at the cost of speed
 mmseqs taxonomy queryNuclDB swissprotDB result tmp --orf-filter 0
 
 # Create a Krona report
 mmseqs taxonomyreport swissprotDB result report.html --report-mode 1
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Mirdita M, Steinegger M, Breitwieser F, Soding J, Levy Karin E: Fast and sensitive taxonomic assignment to metagenomic contigs. Bioinformatics, btab184 (2021)
```

## mmseqs2_taxonomyreport

### Tool Description
Create a taxonomy report in Kraken or Krona format from a taxonomy result database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs taxonomyreport <i:seqTaxDB> <i:taxResultDB/resultDB/sequenceDB> <o:taxonomyReport|krakenDB> [options]
 By Milot Mirdita <milot@mirdita.de> & Florian Breitwieser <florian.bw@gmail.com>
options: misc:              
 --report-mode INT   Taxonomy report mode
                     0: Kraken
                     1: Krona
                     2: do not create a report (for workflows only)
                     3: Kraken per query database [0]
common:            
 --threads INT       Number of CPU-cores used (all by default) [20]
 -v INT              Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Mirdita M, Steinegger M, Breitwieser F, Soding J, Levy Karin E: Fast and sensitive taxonomic assignment to metagenomic contigs. Bioinformatics, btab184 (2021)
```

## mmseqs2_transitivealign

### Tool Description
Transfer alignments by transitivity: align members of a result database to each other through the shared sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs transitivealign <i:sequenceDB> <i:alignmentDB> <o:alignmentDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                   
 --comp-bias-corr INT          Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT  Correct for locally biased amino acid composition (range 0-1) [1.000]
 --add-self-matches BOOL       Artificially add entries of queries with themselves (for clustering) [0]
align:                       
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
 --min-seq-id FLOAT            List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 --min-aln-len INT             Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT             0: alignment length 1: shorter, 2: longer sequence [0]
 --alt-ali INT                 Show up to this many alternative alignments [0]
 -c FLOAT                      List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --cov-mode INT                0: coverage of query and target
                               1: coverage of target
                               2: coverage of query
                               3: target seq. length has to be at least x% of query length
                               4: query seq. length has to be at least x% of target length
                               5: short seq. needs to be at least x% of the other seq. length [0]
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
common:                      
 --sub-mat TWIN                Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT             Maximum sequence length [65535]
 --db-load-mode INT            Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                 Number of CPU-cores used (all by default) [20]
 --compressed INT              Write compressed output [0]
 -v INT                        Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_translateaa

### Tool Description
Translate proteins to the lexicographically lowest codons.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs translateaa <i:sequenceDB> <o:sequenceDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: common:           
 --threads INT      Number of CPU-cores used (all by default) [20]
 --compressed INT   Write compressed output [0]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_translatenucs

### Tool Description
Translate nucleotides to proteins.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs translatenucs <i:sequenceDB> <o:sequenceDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: misc:                    
 --translation-table INT   1) CANONICAL, 2) VERT_MITOCHONDRIAL, 3) YEAST_MITOCHONDRIAL, 4) MOLD_MITOCHONDRIAL, 5) INVERT_MITOCHONDRIAL, 6) CILIATE
                           9) FLATWORM_MITOCHONDRIAL, 10) EUPLOTID, 11) PROKARYOTE, 12) ALT_YEAST, 13) ASCIDIAN_MITOCHONDRIAL, 14) ALT_FLATWORM_MITOCHONDRIAL
                           15) BLEPHARISMA, 16) CHLOROPHYCEAN_MITOCHONDRIAL, 21) TREMATODE_MITOCHONDRIAL, 22) SCENEDESMUS_MITOCHONDRIAL
                           23) THRAUSTOCHYTRIUM_MITOCHONDRIAL, 24) PTEROBRANCHIA_MITOCHONDRIAL, 25) GRACILIBACTERIA, 26) PACHYSOLEN, 27) KARYORELICT, 28) CONDYLOSTOMA
                            29) MESODINIUM, 30) PERTRICH, 31) BLASTOCRITHIDIA [1]
 --add-orf-stop BOOL       Add stop codon '*' at complete start and end [0]
common:                  
 -v INT                    Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --compressed INT          Write compressed output [0]
 --threads INT             Number of CPU-cores used (all by default) [20]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_tsv2db

### Tool Description
Convert a tab-separated file into a database of any type.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs tsv2db <i:tsvFile> <o:resultDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: prefilter:              
 --add-self-matches BOOL  Artificially add entries of queries with themselves (for clustering) [0]
misc:                   
 --output-dbtype INT      Set database type for resulting database: Amino acid sequences 0, Nucl. seq. 1, Profiles 2, Alignment result 5, Clustering result 6, Prefiltering result 7, Taxonomy result 8, Indexed database 9, cA3M MSAs 10, FASTA or A3M MSAs 11, Generic database 12, Omit dbtype file 13, Bi-directional prefiltering result 14, Offsetted headers 15 [12]
common:                 
 --compressed INT         Write compressed output [0]
 -v INT                   Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_ungappedprefilter

### Tool Description
Find matches by an optimal ungapped diagonal score search; the result is a prefilter database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs ungappedprefilter <i:queryDB> <i:targetDB> <o:prefilterDB> [options]
 By Milot Mirdita <milot@mirdita.de> & Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                     
 --comp-bias-corr INT            Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT    Correct for locally biased amino acid composition (range 0-1) [1.000]
 --min-ungapped-score INT        Accept only matches with ungapped alignment score above threshold [15]
 --max-seqs INT                  Maximum results per query sequence allowed to pass the prefilter (affects sensitivity) [300]
align:                         
 -c FLOAT                        List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 -e DOUBLE                       List matches below this E-value (range 0.0-inf) [1.000E-03]
 --cov-mode INT                  0: coverage of query and target
                                 1: coverage of target
                                 2: coverage of query
                                 3: target seq. length has to be at least x% of query length
                                 4: query seq. length has to be at least x% of target length
                                 5: short seq. needs to be at least x% of the other seq. length [0]
misc:                          
 --taxon-list STR                Taxonomy ID, possibly multiple values separated by ',' []
 --prefilter-mode INT            prefilter mode: 0: kmer/ungapped 1: ungapped, 2: nofilter, 3: ungapped&gapped [0]
common:                        
 --sub-mat TWIN                  Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --db-load-mode INT              Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --gpu INT                       Use GPU (CUDA) if possible [0]
 --gpu-server INT                Use GPU server [0]
 --gpu-server-wait-timeout INT   Wait for GPU server for 0: don't wait -1: no wait limit: >0 this many seconds [600]
 --threads INT                   Number of CPU-cores used (all by default) [20]
 --compressed INT                Write compressed output [0]
 -v INT                          Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Kallenborn F, Chacon A, Hundt C, Sirelkhatim H, Didi K, Dallago C, Mirdita M, Schmidt B, Steinegger M: GPU-accelerated homology search with MMseqs2. bioRxiv, 2024.11.13.623350 (2024)
```

## mmseqs2_unpackdb

### Tool Description
Unpack a database into separate files, one per entry.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs unpackdb <i:DB> <o:outDir> [options]
 By Milot Mirdita <milot@mirdita.de>
options: misc:                   
 --unpack-name-mode INT   Name unpacked files by 0: DB key, 1: accession (through .lookup) [1]
 --unpack-suffix STR      File suffix for unpacked files.
                          Add .gz suffix to write compressed files. []
common:                 
 --threads INT            Number of CPU-cores used (all by default) [20]
 -v INT                   Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_view

### Tool Description
Print database entries given in --id-list to the standard output.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs view <i:DB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: misc:                 
 --id-list STR          Entries to be printed separated by ',' []
 --id-mode INT          Select DB entries based on 0: database keys, 1: FASTA identifiers (.lookup) [0]
 --idx-entry-type INT   0: sequence, 1: src sequence, 2: header, 3: src header [0]
common:               
 -v INT                 Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

examples:
 # Print entries with keys 1, 2 and 3 from a sequence DB to stdout
 mmseqs view sequenecDB --id-list 1,2,3
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_extractorfs

### Tool Description
Six-frame extraction of open reading frames.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs extractorfs <i:sequenceDB> <o:sequenceDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: misc:                       
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
common:                     
 --threads INT                Number of CPU-cores used (all by default) [20]
 --compressed INT             Write compressed output [0]
 -v INT                       Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
expert:                     
 --create-lookup INT          Create database lookup file (can be very large) [0]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_filterdb

### Tool Description
DB filtering by given conditions.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs filterdb <i:resultDB> <o:resultDB> [options]
 By Clovis Galiez & Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                 
 --add-self-matches BOOL     Artificially add entries of queries with themselves (for clustering) [0]
misc:                      
 --filter-expression STR     Specify a mathematical expression to filter lines []
 --filter-column INT         column [1]
 --column-to-take INT        column to take in join mode. If -1, the whole line is taken [-1]
 --filter-regex STR          Regex to select column (example float: [0-9]*(.[0-9]+)? int:[1-9]{1}[0-9]) [^.*$]
 --positive-filter BOOL      Used in conjunction with --filter-file. If true, out  = in \intersect filter ; if false, out = in - filter [1]
 --filter-file STR           Specify a file that contains the filtering elements []
 --beats-first BOOL          Filter by comparing each entry to the first entry [0]
 --mapping-file STR          Specify a file that translates the keys of a DB to new keys, TSV format []
 --weights STR               Weights used for cluster priorization []
 --trim-to-one-column BOOL   Output only the column specified by --filter-column [0]
 --extract-lines INT         Extract n lines of each entry [0]
 --comparison-operator STR   Filter by comparing each entry row numerically by using the le) less-than-equal, ge) greater-than-equal or e) equal operator []
 --comparison-value DOUBLE   Filter by comparing each entry to this value [0.000E+00]
 --sort-entries INT          Sort column set by --filter-column, by 0: no sorting, 1: increasing, 2: decreasing, 3: random shuffle, 4: priority [0]
 --join-db STR               Join another database entry with respect to the database identifier in the chosen column []
common:                    
 --threads INT               Number of CPU-cores used (all by default) [20]
 --compressed INT            Write compressed output [0]
 -v INT                      Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

examples:
 # Retain top alignment for each query (alignment DBs are sorted by E-value)
 mmseqs filterdb alignmentDB topHitAlignmentDB --extract-lines 1
 
 # Extract alignments with Seq.id. greater than 90%
 mmseqs filterdb alignmentDB scoreGreater35AlignmentDB --comparison-operator ge --comparison-value 0.9 --filter-column 2
 
 # Retain all hits matching a regular expression
 mmseqs filterdb alignmentDB regexFilteredDB --filter-regex '^[1-9].$' --filter-column 2
 
 # Remove all hits to target keys contained in file db.index
 mmseqs filterdb --filter-file db.index --positive-filter false
 
 # Retain all hits matching any boolean expression
 mmseqs filterdb --filter-expression '$1 * $2 >= 200'
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_filterresult

### Tool Description
Pairwise alignment result filter.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs filterresult <i:queryDB> <i:targetDB> <i:resultDB> <o:resultDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: prefilter:                  
 --comp-bias-corr INT         Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT Correct for locally biased amino acid composition (range 0-1) [1.000]
 --add-self-matches BOOL      keep the query (representative) sequence [0]
align:                      
 --gap-open TWIN              Gap open cost [aa:11,nucl:5]
 --gap-extend TWIN            Gap extension cost [aa:1,nucl:2]
profile:                    
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
common:                     
 --sub-mat TWIN               Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --db-load-mode INT           Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                Number of CPU-cores used (all by default) [20]
 --compressed INT             Write compressed output [0]
 -v INT                       Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_filtertaxdb

### Tool Description
Filter taxonomy result database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs filtertaxdb <i:targetDB> <i:taxDB> <o:taxDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: misc:             
 --taxon-list STR   Taxonomy ID, possibly multiple values separated by ',' []
common:           
 --compressed INT   Write compressed output [0]
 --threads INT      Number of CPU-cores used (all by default) [20]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

examples:
 # Download a sequence database with taxonomy information
 mmseqs databases UniProtKB/Swiss-Prot swissprotDB tmp
 # Annotate a queryDB with taxonomy information
 mmseqs taxonomy queryDB swissprotDB taxDB tmp
 
 # Retain all unclassified hits
 mmseqs filtertaxdb swissprotDB taxDB filteredTaxDB --taxon-list 0
 mmseqs createsubdb <(awk '$3 == 1' filteredTaxDB.index) queryDB queryUnclassifiedDB
 
 # Retain all eukaryotic hits except fungi
 mmseqs filtertaxdb swissprotDB taxDB filteredTaxDB --taxon-list '2759&&!4751'
 
 # Retain all human and chlamydia hits
 mmseqs filtertaxdb swissprotDB taxDB filteredTaxDB --taxon-list '9606||810'
 
references:
 - Mirdita M, Steinegger M, Breitwieser F, Soding J, Levy Karin E: Fast and sensitive taxonomic assignment to metagenomic contigs. Bioinformatics, btab184 (2021)
```

## mmseqs2_filtertaxseqdb

### Tool Description
Filter taxonomy sequence database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs filtertaxseqdb <i:taxSeqDB> <o:taxSeqDB> [options]
 By Eli Levy Karin <eli.levy.karin@gmail.com> & Martin Steinegger <martin.steinegger@snu.ac.kr>
options: misc:             
 --taxon-list STR   Taxonomy ID, possibly multiple values separated by ',' []
 --subdb-mode INT   Subdb mode 0: copy data 1: soft link data and write index [0]
common:           
 --compressed INT   Write compressed output [0]
 --threads INT      Number of CPU-cores used (all by default) [20]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

examples:
 # Download a sequence database with taxonomy information
 mmseqs databases UniProtKB/Swiss-Prot swissprotDB tmp
 
 # Retain all bacterial sequences
 mmseqs filtertaxseqdb swissprotDB swissprotDB_only_bac --taxon-list 2
 
 # Retain all eukaryotic sequences except fungi
 mmseqs filtertaxseqdb swissprotDB swissprotDB_euk_wo_fungi --taxon-list '2759&&!4751'
 
 # Retain all human and chlamydia sequences
 mmseqs filtertaxseqdb swissprotDB swissprotDB_human_and_chlamydia --taxon-list '9606||810'
 
 
references:
 - Mirdita M, Steinegger M, Breitwieser F, Soding J, Levy Karin E: Fast and sensitive taxonomic assignment to metagenomic contigs. Bioinformatics, btab184 (2021)
```

## mmseqs2_fwbw

### Tool Description
Forward Backward Alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs fwbw <i:queryDB> <i:targetDB> <i:alignmentDB> <o:alignmentDB> [options]
 By Gyuri Kim <gyuribio@snu.ac.kr> & Soohyun Kim <sd20163818@snu.ac.kr>
options: align:                     
 -e DOUBLE                   List matches below this E-value (range 0.0-inf) [1.000E-03]
 --min-seq-id FLOAT          List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 --min-aln-len INT           Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT           0: alignment length 1: shorter, 2: longer sequence [0]
 -c FLOAT                    List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --cov-mode INT              0: coverage of query and target
                             1: coverage of target
                             2: coverage of query
                             3: target seq. length has to be at least x% of query length
                             4: query seq. length has to be at least x% of target length
                             5: short seq. needs to be at least x% of the other seq. length [0]
common:                    
 --sub-mat TWIN              Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --threads INT               Number of CPU-cores used (all by default) [20]
 --compressed INT            Write compressed output [0]
 -v INT                      Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
expert:                    
 --mact FLOAT                Maximum accuracy threshold [0.035]
 --fwbw-gapopen FLOAT        Gap open penalty for fwbw [10.000]
 --fwbw-gapextend FLOAT      Gap extension penalty for fwbw [2.000]
 --temperature FLOAT         Temperature for forward-backward [1.000]
 --blocklen INT              Block length for forward-backward [16]
 --fwbw-backtrace-mode INT   Backtrace mode 0: no backtrace, 1: local [1]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_gappedprefilter

### Tool Description
Optimal Smith-Waterman-based prefiltering (slow).

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs gappedprefilter <i:queryDB> <i:targetDB> <o:prefilterDB> [options]
 By Milot Mirdita <milot@mirdita.de> & Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                  
 --comp-bias-corr INT         Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT Correct for locally biased amino acid composition (range 0-1) [1.000]
 --min-ungapped-score INT     Accept only matches with ungapped alignment score above threshold [15]
 --max-seqs INT               Maximum results per query sequence allowed to pass the prefilter (affects sensitivity) [300]
align:                      
 --gap-open TWIN              Gap open cost [aa:11,nucl:5]
 --gap-extend TWIN            Gap extension cost [aa:1,nucl:2]
 -e DOUBLE                    List matches below this E-value (range 0.0-inf) [1.000E-03]
 -c FLOAT                     List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --cov-mode INT               0: coverage of query and target
                              1: coverage of target
                              2: coverage of query
                              3: target seq. length has to be at least x% of query length
                              4: query seq. length has to be at least x% of target length
                              5: short seq. needs to be at least x% of the other seq. length [0]
misc:                       
 --taxon-list STR             Taxonomy ID, possibly multiple values separated by ',' []
common:                     
 --sub-mat TWIN               Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --db-load-mode INT           Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                Number of CPU-cores used (all by default) [20]
 --compressed INT             Write compressed output [0]
 -v INT                       Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Kallenborn F, Chacon A, Hundt C, Sirelkhatim H, Didi K, Dallago C, Mirdita M, Schmidt B, Steinegger M: GPU-accelerated homology search with MMseqs2. bioRxiv, 2024.11.13.623350 (2024)
```

## mmseqs2_gff2db

### Tool Description
Extract regions from a sequence database based on a GFF3 file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs gff2db <i:gff3File1> ... <i:gff3FileN> <i:sequenceDB> <o:sequenceDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: misc:            
 --gff-type STR    Comma separated list of feature types in the GFF file to select []
 --id-offset INT   Numeric ids in index file are offset by this value [0]
common:          
 --threads INT     Number of CPU-cores used (all by default) [20]
 -v INT            Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_kmermatcher

### Tool Description
Find bottom-m-hashed k-mer matches within sequence DB.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs kmermatcher <i:sequenceDB> <o:prefilterDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                      
 --alph-size TWIN                 Alphabet size (range 2-21) [aa:13,nucl:5]
 --spaced-kmer-mode INT           0: use consecutive positions in k-mers; 1: use spaced k-mers [0]
 --spaced-kmer-pattern STR        User-specified spaced k-mer pattern []
 --mask INT                       Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [0]
 --mask-prob FLOAT                Mask sequences is probablity is above threshold [0.900]
 --mask-lower-case INT            Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
 --mask-n-repeat INT              Repeat letters that occure > threshold in a rwo [0]
 -k INT                           k-mer length (0: automatically set to optimum) [0]
 --split-memory-limit BYTE        Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
align:                          
 --min-seq-id FLOAT               List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 --cov-mode INT                   0: coverage of query and target
                                  1: coverage of target
                                  2: coverage of query
                                  3: target seq. length has to be at least x% of query length
                                  4: query seq. length has to be at least x% of target length
                                  5: short seq. needs to be at least x% of the other seq. length [0]
 -c FLOAT                         List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.800]
kmermatcher:                    
 --kmer-per-seq INT               k-mers per sequence [0]
 --kmer-per-seq-scale TWIN        Scale k-mer per sequence based on sequence length as kmer-per-seq val + scale x seqlen [aa:0.000,nucl:0.200]
 --adjust-kmer-len BOOL           Adjust k-mer length based on specificity (only for nucleotides) [0]
 --hash-shift INT                 Shift k-mer hash initialization [67]
 --include-only-extendable BOOL   Include only extendable [0]
 --ignore-multi-kmer BOOL         Skip k-mers occurring multiple times (>=2) [0]
 --weights STR                    Weights used for cluster priorization []
 --cluster-weight-threshold FLOAT Weight threshold used for cluster priorization [0.900]
common:                         
 --sub-mat TWIN                   Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT                Maximum sequence length [65535]
 --threads INT                    Number of CPU-cores used (all by default) [20]
 --compressed INT                 Write compressed output [0]
 -v INT                           Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_kmersearch

### Tool Description
Find bottom-m-hashed k-mer matches between target and query DB.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs kmersearch <i:queryDB> <i:kmerIndexDB> <o:prefilterDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                
 --seed-sub-mat TWIN        Substitution matrix file for k-mer generation [aa:VTML80.out,nucl:nucleotide.out]
 --mask INT                 Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [0]
 --mask-prob FLOAT          Mask sequences is probablity is above threshold [0.900]
 --mask-lower-case INT      Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
 --mask-n-repeat INT        Repeat letters that occure > threshold in a rwo [0]
 --split-memory-limit BYTE  Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
align:                    
 --cov-mode INT             0: coverage of query and target
                            1: coverage of target
                            2: coverage of query
                            3: target seq. length has to be at least x% of query length
                            4: query seq. length has to be at least x% of target length
                            5: short seq. needs to be at least x% of the other seq. length [0]
 -c FLOAT                   List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.800]
kmermatcher:              
 --kmer-per-seq INT         k-mers per sequence [0]
 --kmer-per-seq-scale TWIN  Scale k-mer per sequence based on sequence length as kmer-per-seq val + scale x seqlen [aa:0.000,nucl:0.200]
 --pick-n-sim-kmer INT      Add N similar k-mers to search [1]
 --result-direction INT     result is 0: query, 1: target centric [1]
common:                   
 --max-seq-len INT          Maximum sequence length [65535]
 --threads INT              Number of CPU-cores used (all by default) [20]
 --compressed INT           Write compressed output [0]
 -v INT                     Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_lca

### Tool Description
Compute the lowest common ancestor.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs lca <i:targetDB> <i:resultDB> <o:taxaDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: misc:              
 --lca-ranks STR     Add column with specified ranks (',' separated) []
 --blacklist STR     Comma separated list of ignored taxa in LCA computation [12908:unclassified sequences,28384:other sequences]
 --tax-lineage INT   0: don't show, 1: add all lineage names, 2: add all lineage taxids [0]
common:            
 --compressed INT    Write compressed output [0]
 --threads INT       Number of CPU-cores used (all by default) [20]
 -v INT              Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Mirdita M, Steinegger M, Breitwieser F, Soding J, Levy Karin E: Fast and sensitive taxonomic assignment to metagenomic contigs. Bioinformatics, btab184 (2021)
```

## mmseqs2_lcaalign

### Tool Description
Efficient gapped alignment for lca computation.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs lcaalign <i:queryDB> <i:targetDB> <i:resultDB> <o:alignmentDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: prefilter:                   
 --comp-bias-corr INT          Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT  Correct for locally biased amino acid composition (range 0-1) [1.000]
 --add-self-matches BOOL       Artificially add entries of queries with themselves (for clustering) [0]
align:                       
 -a BOOL                       Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --alignment-mode INT          How to compute the alignment:
                               0: automatic
                               1: only score and end_pos
                               2: also start_pos and cov
                               3: also seq.id [0]
 --alignment-output-mode INT   How to compute the alignment:
                               0: automatic
                               1: only score and end_pos
                               2: also start_pos and cov
                               3: also seq.id
                               4: only ungapped alignment
                               5: score only (output) cluster format [0]
 --wrapped-scoring BOOL        Double the (nucleotide) query sequence during the scoring process to allow wrapped diagonal scoring around end and start [0]
 -e DOUBLE                     List matches below this E-value (range 0.0-inf) [1.000E-03]
 --min-seq-id FLOAT            List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 --min-aln-len INT             Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT             0: alignment length 1: shorter, 2: longer sequence [0]
 --alt-ali INT                 Show up to this many alternative alignments [0]
 -c FLOAT                      List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --cov-mode INT                0: coverage of query and target
                               1: coverage of target
                               2: coverage of query
                               3: target seq. length has to be at least x% of query length
                               4: query seq. length has to be at least x% of target length
                               5: short seq. needs to be at least x% of the other seq. length [0]
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
common:                      
 --sub-mat TWIN                Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT             Maximum sequence length [65535]
 --db-load-mode INT            Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                 Number of CPU-cores used (all by default) [20]
 --compressed INT              Write compressed output [0]
 -v INT                        Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Mirdita M, Steinegger M, Breitwieser F, Soding J, Levy Karin E: Fast and sensitive taxonomic assignment to metagenomic contigs. Bioinformatics, btab184 (2021)
```

## mmseqs2_linsearch

### Tool Description
Fast, less sensitive homology search.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs linsearch <i:queryDB> <i:targetDB> <o:alignmentDB> <tmpDir> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                   
 --comp-bias-corr INT          Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT  Correct for locally biased amino acid composition (range 0-1) [1.000]
 --add-self-matches BOOL       Artificially add entries of queries with themselves (for clustering) [0]
 --seed-sub-mat TWIN           Substitution matrix file for k-mer generation [aa:blosum62.out,nucl:nucleotide.out]
 --mask INT                    Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [0]
 --mask-prob FLOAT             Mask sequences is probablity is above threshold [0.900]
 --mask-lower-case INT         Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
 --mask-n-repeat INT           Repeat letters that occure > threshold in a rwo [0]
 --split-memory-limit BYTE     Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
align:                       
 -a BOOL                       Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --alignment-mode INT          How to compute the alignment:
                               0: automatic
                               1: only score and end_pos
                               2: also start_pos and cov
                               3: also seq.id
                               4: only ungapped alignment [2]
 --alignment-output-mode INT   How to compute the alignment:
                               0: automatic
                               1: only score and end_pos
                               2: also start_pos and cov
                               3: also seq.id
                               4: only ungapped alignment
                               5: score only (output) cluster format [0]
 --wrapped-scoring BOOL        Double the (nucleotide) query sequence during the scoring process to allow wrapped diagonal scoring around end and start [0]
 -e DOUBLE                     List matches below this E-value (range 0.0-inf) [1.000E-03]
 --min-seq-id FLOAT            List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 --min-aln-len INT             Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT             0: alignment length 1: shorter, 2: longer sequence [0]
 --alt-ali INT                 Show up to this many alternative alignments [0]
 -c FLOAT                      List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --cov-mode INT                0: coverage of query and target
                               1: coverage of target
                               2: coverage of query
                               3: target seq. length has to be at least x% of query length
                               4: query seq. length has to be at least x% of target length
                               5: short seq. needs to be at least x% of the other seq. length [0]
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
kmermatcher:                 
 --kmer-per-seq INT            k-mers per sequence [21]
 --kmer-per-seq-scale TWIN     Scale k-mer per sequence based on sequence length as kmer-per-seq val + scale x seqlen [aa:0.000,nucl:0.200]
 --pick-n-sim-kmer INT         Add N similar k-mers to search [1]
 --result-direction INT        result is 0: query, 1: target centric [1]
profile:                     
 --pca                         Pseudo count admixture strength []
 --pcb                         Pseudo counts: Neff at half of maximum admixture (range 0.0-inf) []
misc:                        
 --min-length INT              Minimum codon number in open reading frames [30]
 --max-length INT              Maximum codon number in open reading frames [32734]
 --max-gaps INT                Maximum number of codons with gaps or unknown residues before an open reading frame is rejected [2147483647]
 --contig-start-mode INT       Contig start can be 0: incomplete, 1: complete, 2: both [2]
 --contig-end-mode INT         Contig end can be 0: incomplete, 1: complete, 2: both [2]
 --orf-start-mode INT          Orf fragment can be 0: from start to stop, 1: from any to stop, 2: from last encountered start to stop (no start in the middle) [1]
 --forward-frames STR          Comma-separated list of frames on the forward strand to be extracted [1,2,3]
 --reverse-frames STR          Comma-separated list of frames on the reverse strand to be extracted [1,2,3]
 --translation-table INT       1) CANONICAL, 2) VERT_MITOCHONDRIAL, 3) YEAST_MITOCHONDRIAL, 4) MOLD_MITOCHONDRIAL, 5) INVERT_MITOCHONDRIAL, 6) CILIATE
                               9) FLATWORM_MITOCHONDRIAL, 10) EUPLOTID, 11) PROKARYOTE, 12) ALT_YEAST, 13) ASCIDIAN_MITOCHONDRIAL, 14) ALT_FLATWORM_MITOCHONDRIAL
                               15) BLEPHARISMA, 16) CHLOROPHYCEAN_MITOCHONDRIAL, 21) TREMATODE_MITOCHONDRIAL, 22) SCENEDESMUS_MITOCHONDRIAL
                               23) THRAUSTOCHYTRIUM_MITOCHONDRIAL, 24) PTEROBRANCHIA_MITOCHONDRIAL, 25) GRACILIBACTERIA, 26) PACHYSOLEN, 27) KARYORELICT, 28) CONDYLOSTOMA
                                29) MESODINIUM, 30) PERTRICH, 31) BLASTOCRITHIDIA [1]
 --translate INT               Translate ORF to amino acid [0]
 --use-all-table-starts BOOL   Use all alternatives for a start codon in the genetic table, if false - only ATG (AUG) [0]
 --id-offset INT               Numeric ids in index file are offset by this value [0]
 --search-type INT             Search type 0: auto 1: amino acid, 2: translated, 3: nucleotide, 4: translated nucleotide alignment [0]
common:                      
 --sub-mat TWIN                Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT             Maximum sequence length [65535]
 --db-load-mode INT            Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                 Number of CPU-cores used (all by default) [20]
 --compressed INT              Write compressed output [0]
 -v INT                        Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --mpi-runner STR              Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42") []
 --force-reuse BOOL            Reuse tmp filse in tmp/latest folder ignoring parameters and version changes [0]
 --remove-tmp-files BOOL       Delete temporary files [0]
expert:                      
 --create-lookup INT           Create database lookup file (can be very large) [0]
 --chain-alignments INT        Chain overlapping alignments [0]
 --merge-query INT             Combine ORFs/split sequences to a single entry [1]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_lndb

### Tool Description
Symlink a DB.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs lndb <i:srcDB> <o:dstDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: common: 
 -v INT   Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_majoritylca

### Tool Description
Compute the lowest common ancestor using majority voting.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs majoritylca <i:targetDB> <i:resultDB> <o:taxaDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: misc:              
 --majority FLOAT    minimal fraction of agreement among taxonomically assigned sequences of a set [0.500]
 --vote-mode INT     Mode of assigning weights to compute majority. 0: uniform, 1: minus log E-value, 2: score [1]
 --lca-ranks STR     Add column with specified ranks (',' separated) []
 --blacklist STR     Comma separated list of ignored taxa in LCA computation [12908:unclassified sequences,28384:other sequences]
 --tax-lineage INT   0: don't show, 1: add all lineage names, 2: add all lineage taxids [0]
common:            
 --compressed INT    Write compressed output [0]
 --threads INT       Number of CPU-cores used (all by default) [20]
 -v INT              Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Mirdita M, Steinegger M, Breitwieser F, Soding J, Levy Karin E: Fast and sensitive taxonomic assignment to metagenomic contigs. Bioinformatics, btab184 (2021)
```

## mmseqs2_map

### Tool Description
Map nearly identical sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs map <i:queryDB> <i:targetDB> <o:alignmentDB> <tmpDir> [options]
 By Milot Mirdita <milot@mirdita.de> & Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                  
 --seed-sub-mat TWIN          Substitution matrix file for k-mer generation [aa:VTML80.out,nucl:nucleotide.out]
 -s FLOAT                     Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [2.000]
 -k INT                       k-mer length (0: automatically set to optimum) [0]
 --target-search-mode INT     target search mode (0: regular k-mer, 1: similar k-mer) [0]
 --k-score TWIN               k-mer threshold for generating similar k-mer lists [seq:2147483647,prof:2147483647]
 --alph-size TWIN             Alphabet size (range 2-21) [aa:21,nucl:5]
 --max-seqs INT               Maximum results per query sequence allowed to pass the prefilter (affects sensitivity) [300]
 --split INT                  Split input into N equally distributed chunks. 0: set the best split automatically [0]
 --split-mode INT             0: split target db; 1: split query db; 2: auto, depending on main memory [2]
 --split-memory-limit BYTE    Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
 --comp-bias-corr INT         Correct for locally biased amino acid composition (range 0-1) [0]
 --comp-bias-corr-scale FLOAT Correct for locally biased amino acid composition (range 0-1) [1.000]
 --diag-score BOOL            Use ungapped diagonal scoring during prefilter [1]
 --exact-kmer-matching INT    Extract only exact k-mers for matching (range 0-1) [0]
 --mask INT                   Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [0]
 --mask-prob FLOAT            Mask sequences is probablity is above threshold [0.900]
 --mask-lower-case INT        Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
 --mask-n-repeat INT          Repeat letters that occure > threshold in a rwo [0]
 --min-ungapped-score INT     Accept only matches with ungapped alignment score above threshold [15]
 --add-self-matches BOOL      Artificially add entries of queries with themselves (for clustering) [0]
 --spaced-kmer-mode INT       0: use consecutive positions in k-mers; 1: use spaced k-mers [1]
 --spaced-kmer-pattern STR    User-specified spaced k-mer pattern []
 --local-tmp STR              Path where some of the temporary files will be created []
align:                      
 -c FLOAT                     List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.950]
 --cov-mode INT               0: coverage of query and target
                              1: coverage of target
                              2: coverage of query
                              3: target seq. length has to be at least x% of query length
                              4: query seq. length has to be at least x% of target length
                              5: short seq. needs to be at least x% of the other seq. length [2]
 --wrapped-scoring BOOL       Double the (nucleotide) query sequence during the scoring process to allow wrapped diagonal scoring around end and start [0]
 -e DOUBLE                    List matches below this E-value (range 0.0-inf) [1.000E-03]
 -a BOOL                      Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --min-seq-id FLOAT           List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.900]
 --min-aln-len INT            Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT            0: alignment length 1: shorter, 2: longer sequence [0]
profile:                    
 --pca                        Pseudo count admixture strength []
 --pcb                        Pseudo counts: Neff at half of maximum admixture (range 0.0-inf) []
misc:                       
 --taxon-list STR             Taxonomy ID, possibly multiple values separated by ',' []
 --rescore-mode INT           Rescore diagonals with:
                              0: Hamming distance
                              1: local alignment (score only)
                              2: local alignment
                              3: global alignment
                              4: longest alignment fulfilling window quality criterion [2]
 --min-length INT             Minimum codon number in open reading frames [10]
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
 --start-sens FLOAT           Start sensitivity [4.000]
 --sens-steps INT             Number of search steps performed from --start-sens to -s [1]
common:                     
 --sub-mat TWIN               Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT            Maximum sequence length [65535]
 --db-load-mode INT           Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                Number of CPU-cores used (all by default) [20]
 --compressed INT             Write compressed output [0]
 -v INT                       Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --mpi-runner STR             Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42") []
 --force-reuse BOOL           Reuse tmp filse in tmp/latest folder ignoring parameters and version changes [0]
 --remove-tmp-files BOOL      Delete temporary files [0]
expert:                     
 --filter-hits BOOL           Filter hits by seq.id. and coverage [0]
 --sort-results INT           Sort results: 0: no sorting, 1: sort by E-value (Alignment) or seq.id. (Hamming) [1]
 --create-lookup INT          Create database lookup file (can be very large) [0]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Steinegger M, Mirdita M, Soding J: Protein-level assembly increases protein sequence recovery from metagenomic samples manyfold. Nature Methods, 16(7), 603-606 (2019)
```

## mmseqs2_maskbygff

### Tool Description
Mask out sequence regions in a sequence DB by features selected from a GFF3 file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs maskbygff <i:gff3File> <i:sequenceDB> <o:sequenceDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: misc:            
 --gff-type STR    Comma separated list of feature types in the GFF file to select []
 --id-offset INT   Numeric ids in index file are offset by this value [0]
common:          
 --threads INT     Number of CPU-cores used (all by default) [20]
 -v INT            Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_masksequence

### Tool Description
Soft mask sequence DB using tantan.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs masksequence <i:sequenceDB> <o:sequenceDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:             
 --mask INT              Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [1]
 --mask-prob FLOAT       Mask sequences is probablity is above threshold [0.900]
 --mask-lower-case INT   Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
 --mask-n-repeat INT     Repeat letters that occure > threshold in a rwo [0]
common:                
 --threads INT           Number of CPU-cores used (all by default) [20]
 --compressed INT        Write compressed output [0]
 -v INT                  Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_mergeclusters

### Tool Description
Merge multiple cascaded clustering steps.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs mergeclusters <i:sequenceDB> <o:clusterDB> <i:clusterDB1> ... <i:clusterDBn> [options]
 By Maria Hauser & Martin Steinegger <martin.steinegger@snu.ac.kr>
options: common:           
 --threads INT      Number of CPU-cores used (all by default) [20]
 --compressed INT   Write compressed output [0]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_mergedbs

### Tool Description
Merge entries from multiple DBs.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs mergedbs <i:DB> <o:DB> <i:DB1> ... <i:DBn> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: common:                 
 --compressed INT         Write compressed output [0]
 -v INT                   Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
expert:                 
 --prefixes STR           Comma separated list of prefixes for each entry []
 --merge-stop-empty BOOL  Don't continue merging entries after an empty entry [0]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_mergeresultsbyset

### Tool Description
Merge results from multiple ORFs back to their respective contig.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs mergeresultsbyset <i:setDB> <i:DB> <o:DB> [options]
 By Ruoshi Zhang, Clovis Norroy & Milot Mirdita <milot@mirdita.de>
options: common:             
 --db-load-mode INT   Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT        Number of CPU-cores used (all by default) [20]
 --compressed INT     Write compressed output [0]
 -v INT               Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_msa2profile

### Tool Description
Convert a MSA DB to a profile DB
Convert a MSA DB to a profile DB.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs msa2profile <i:msaDB> <o:profileDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: prefilter:                  
 --comp-bias-corr INT         Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT Correct for locally biased amino acid composition (range 0-1) [1.000]
align:                      
 --gap-open TWIN              Gap open cost [aa:11,nucl:5]
 --gap-extend TWIN            Gap extension cost [aa:1,nucl:2]
profile:                    
 --match-mode INT             0: Columns that have a residue in the first sequence are kept, 1: columns that have a residue in --match-ratio of all sequences are kept [0]
 --match-ratio FLOAT          Columns that have a residue in this ratio of all sequences are kept [0.500]
 --pseudo-cnt-mode INT        use 0: substitution-matrix or 1: context-specific pseudocounts [0]
 --pca                        Pseudo count admixture strength []
 --pcb                        Pseudo counts: Neff at half of maximum admixture (range 0.0-inf) []
 --wg BOOL                    Use global sequence weighting for profile calculation [0]
 --filter-msa INT             Filter msa: 0: do not filter, 1: filter [1]
 --filter-min-enable INT      Only filter MSAs with more than N sequences, 0 always filters [0]
 --cov FLOAT                  Filter output MSAs using min. fraction of query residues covered by matched sequences [0.0,1.0] [0.000]
 --qid STR                    Reduce diversity of output MSAs using min.seq. identity with query sequences [0.0,1.0]
                              Alternatively, can be a list of multiple thresholds:
                              E.g.: 0.15,0.30,0.50 to defines filter buckets of ]0.15-0.30] and ]0.30-0.50] [0.0]
 --qsc FLOAT                  Reduce diversity of output MSAs using min. score per aligned residue with query sequences [-50.0,100.0] [-20.000]
 --max-seq-id FLOAT           Reduce redundancy of output MSA using max. pairwise sequence identity [0.0,1.0] [0.900]
 --diff INT                   Filter MSAs by selecting most diverse set of sequences, keeping at least this many seqs in each MSA block of length 50 [1000]
misc:                       
 --msa-type INT               MSA Type: 0: cA3M, 1: A3M, 2: FASTA [2]
common:                     
 --sub-mat TWIN               Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --threads INT                Number of CPU-cores used (all by default) [20]
 --compressed INT             Write compressed output [0]
 -v INT                       Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
expert:                     
 --skip-query BOOL            Skip the query sequence [0]

examples:
 # Convert globally aligned MSAs to profiles
 # Defines columns as match columns if more than 50% of residues are not gaps
 # Non-match columns are discarded
 mmseqs msa2profile msaDB profileDB --match-mode 1 --match-ratio 0.5
 
 # Assign match-columns through the first sequence
 # Gaps in query sequence define non-match columns and are discarded
 mmseqs msa2profile msaDB profileDB --match-mode 0
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Mirdita M, Steinegger M, Soding J: MMseqs2 desktop and local web server app for fast, interactive sequence searches. Bioinformatics, 35(16), 2856-2858 (2019)
```

## mmseqs2_msa2result

### Tool Description
Convert a MSA DB to a profile DB.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs msa2result <i:msaDB> <o:seqDB> <o:profileDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: prefilter:                  
 --comp-bias-corr INT         Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT Correct for locally biased amino acid composition (range 0-1) [1.000]
align:                      
 --gap-open TWIN              Gap open cost [aa:11,nucl:5]
 --gap-extend TWIN            Gap extension cost [aa:1,nucl:2]
profile:                    
 --match-mode INT             0: Columns that have a residue in the first sequence are kept, 1: columns that have a residue in --match-ratio of all sequences are kept [0]
 --match-ratio FLOAT          Columns that have a residue in this ratio of all sequences are kept [0.500]
 --pseudo-cnt-mode INT        use 0: substitution-matrix or 1: context-specific pseudocounts [0]
 --pca                        Pseudo count admixture strength []
 --pcb                        Pseudo counts: Neff at half of maximum admixture (range 0.0-inf) []
 --wg BOOL                    Use global sequence weighting for profile calculation [0]
 --filter-msa INT             Filter msa: 0: do not filter, 1: filter [1]
 --filter-min-enable INT      Only filter MSAs with more than N sequences, 0 always filters [0]
 --cov FLOAT                  Filter output MSAs using min. fraction of query residues covered by matched sequences [0.0,1.0] [0.000]
 --qid STR                    Reduce diversity of output MSAs using min.seq. identity with query sequences [0.0,1.0]
                              Alternatively, can be a list of multiple thresholds:
                              E.g.: 0.15,0.30,0.50 to defines filter buckets of ]0.15-0.30] and ]0.30-0.50] [0.0]
 --qsc FLOAT                  Reduce diversity of output MSAs using min. score per aligned residue with query sequences [-50.0,100.0] [-20.000]
 --max-seq-id FLOAT           Reduce redundancy of output MSA using max. pairwise sequence identity [0.0,1.0] [0.900]
 --diff INT                   Filter MSAs by selecting most diverse set of sequences, keeping at least this many seqs in each MSA block of length 50 [1000]
misc:                       
 --msa-type INT               MSA Type: 0: cA3M, 1: A3M, 2: FASTA [2]
common:                     
 --sub-mat TWIN               Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --threads INT                Number of CPU-cores used (all by default) [20]
 --compressed INT             Write compressed output [0]
 -v INT                       Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
expert:                     
 --skip-query BOOL            Skip the query sequence [0]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Mirdita M, Steinegger M, Soding J: MMseqs2 desktop and local web server app for fast, interactive sequence searches. Bioinformatics, 35(16), 2856-2858 (2019)
```

## mmseqs2_multihitdb

### Tool Description
Create sequence DB for multi hit searches.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs multihitdb <i:fastaFile1[.gz|bz2]> ... <i:fastaFileN[.gz|bz2]> <o:setDB> <tmpDir> [options]
 By Ruoshi Zhang, Clovis Norroy & Milot Mirdita <milot@mirdita.de>
options: prefilter:                  
 --mask INT                   Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [1]
 --mask-prob FLOAT            Mask sequences is probablity is above threshold [0.900]
 --mask-lower-case INT        Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
 --mask-n-repeat INT          Repeat letters that occure > threshold in a rwo [0]
misc:                       
 --dbtype INT                 Database type 0: auto, 1: amino acid 2: nucleotides [0]
 --shuffle BOOL               Shuffle input database [1]
 --createdb-mode INT          Createdb mode 0: copy data, 1: soft link data and write new index (works only with single line fasta/q) 2: GPU compatible db [0]
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
 --stat STR                   One of: linecount, mean, min, max, doolittle, charges, seqlen, firstline []
 --tsv BOOL                   Return output in TSV format [0]
common:                     
 --threads INT                Number of CPU-cores used (all by default) [20]
 --compressed INT             Write compressed output [0]
 --gpu INT                    Use GPU (CUDA) if possible [0]
 -v INT                       Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
expert:                     
 --write-lookup INT           write .lookup file containing mapping from internal id, fasta id and file number [1]
 --create-lookup INT          Create database lookup file (can be very large) [0]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_multihitsearch

### Tool Description
Search with a grouped set of sequences against another grouped set.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs multihitsearch <i:querySetDB> <i:targetSetDB> <o:resultDB> <tmpDir> [options]
 By Ruoshi Zhang, Clovis Norroy & Milot Mirdita <milot@mirdita.de>
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
 --simple-best-hit BOOL           Update the p-value by a single best hit, or by best and second best hits [1]
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

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_mvdb

### Tool Description
Move a DB.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs mvdb <i:srcDB> <o:dstDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: common: 
 -v INT   Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_nrtotaxmapping

### Tool Description
Create taxonomy mapping for NR database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs nrtotaxmapping <i:accession2taxid1> ... <i:accession2taxidN> <i:seqDB> <o:tsvFile> [options]
 By Milot Mirdita <milot@mirdita.de>
options: common:        
 --threads INT   Number of CPU-cores used (all by default) [20]
 -v INT          Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Mirdita M, Steinegger M, Breitwieser F, Soding J, Levy Karin E: Fast and sensitive taxonomic assignment to metagenomic contigs. Bioinformatics, btab184 (2021)
```

## mmseqs2_offsetalignment

### Tool Description
Offset alignment by ORF start position.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs offsetalignment <i:queryDB> <i:queryOrfDB> <i:targetDB> <i:targetOrfDB> <i:alnDB> <o:alnDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: misc:                   
 --search-type INT        Search type 0: auto 1: amino acid, 2: translated, 3: nucleotide, 4: translated nucleotide alignment [0]
common:                 
 --threads INT            Number of CPU-cores used (all by default) [20]
 --compressed INT         Write compressed output [0]
 --db-load-mode INT       Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 -v INT                   Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
expert:                 
 --chain-alignments INT   Chain overlapping alignments [0]
 --merge-query INT        Combine ORFs/split sequences to a single entry [1]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_orftocontig

### Tool Description
Write ORF locations in alignment format.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs orftocontig <i:contigsSequenceDB> <i:extractedOrfsHeadersDB> <o:orfsAlignedToContigDB> [options]
 By Eli Levy Karin <eli.levy.karin@gmail.com> 
options: common:           
 --threads INT      Number of CPU-cores used (all by default) [20]
 --compressed INT   Write compressed output [0]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_pickconsensusrep

### Tool Description
Select new representatives for each cluster based on consensus.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs pickconsensusrep <i:seqDb> <i:clusterDB> <o:clusterDB> <tmpDir> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr> & Maria Hauser
options: common:           
 --compressed INT   Write compressed output [0]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_prefilter

### Tool Description
Double consecutive diagonal k-mer search.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs prefilter <i:queryDB> <i:targetDB> <o:prefilterDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr> & Maria Hauser
options: prefilter:                  
 --seed-sub-mat TWIN          Substitution matrix file for k-mer generation [aa:VTML80.out,nucl:nucleotide.out]
 -s FLOAT                     Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [4.000]
 -k INT                       k-mer length (0: automatically set to optimum) [0]
 --target-search-mode INT     target search mode (0: regular k-mer, 1: similar k-mer) [0]
 --k-score TWIN               k-mer threshold for generating similar k-mer lists [seq:2147483647,prof:2147483647]
 --alph-size TWIN             Alphabet size (range 2-21) [aa:21,nucl:5]
 --max-seqs INT               Maximum results per query sequence allowed to pass the prefilter (affects sensitivity) [300]
 --split INT                  Split input into N equally distributed chunks. 0: set the best split automatically [0]
 --split-mode INT             0: split target db; 1: split query db; 2: auto, depending on main memory [2]
 --split-memory-limit BYTE    Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
 --comp-bias-corr INT         Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT Correct for locally biased amino acid composition (range 0-1) [1.000]
 --diag-score BOOL            Use ungapped diagonal scoring during prefilter [1]
 --exact-kmer-matching INT    Extract only exact k-mers for matching (range 0-1) [0]
 --mask INT                   Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [1]
 --mask-prob FLOAT            Mask sequences is probablity is above threshold [0.900]
 --mask-lower-case INT        Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
 --mask-n-repeat INT          Repeat letters that occure > threshold in a rwo [0]
 --min-ungapped-score INT     Accept only matches with ungapped alignment score above threshold [15]
 --add-self-matches BOOL      Artificially add entries of queries with themselves (for clustering) [0]
 --spaced-kmer-mode INT       0: use consecutive positions in k-mers; 1: use spaced k-mers [1]
 --spaced-kmer-pattern STR    User-specified spaced k-mer pattern []
 --local-tmp STR              Path where some of the temporary files will be created []
align:                      
 -c FLOAT                     List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --cov-mode INT               0: coverage of query and target
                              1: coverage of target
                              2: coverage of query
                              3: target seq. length has to be at least x% of query length
                              4: query seq. length has to be at least x% of target length
                              5: short seq. needs to be at least x% of the other seq. length [0]
profile:                    
 --pca                        Pseudo count admixture strength []
 --pcb                        Pseudo counts: Neff at half of maximum admixture (range 0.0-inf) []
misc:                       
 --taxon-list STR             Taxonomy ID, possibly multiple values separated by ',' []
common:                     
 --sub-mat TWIN               Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT            Maximum sequence length [65535]
 --db-load-mode INT           Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                Number of CPU-cores used (all by default) [20]
 --compressed INT             Write compressed output [0]
 -v INT                       Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_prefixid

### Tool Description
For each entry in a DB prepend the entry key to the entry itself.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs prefixid <i:DB> <o:DB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: misc:               
 --prefix STR         Use this prefix for all entries []
 --mapping-file STR   Specify a file that translates the keys of a DB to new keys, TSV format []
 --tsv BOOL           Return output in TSV format [0]
common:             
 --threads INT        Number of CPU-cores used (all by default) [20]
 --compressed INT     Write compressed output [0]
 -v INT               Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_profile2consensus

### Tool Description
Extract consensus sequence DB from a profile DB.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs profile2consensus <i:profileDB> <o:sequenceDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: common:            
 --sub-mat TWIN      Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT   Maximum sequence length [65535]
 --threads INT       Number of CPU-cores used (all by default) [20]
 --compressed INT    Write compressed output [0]
 -v INT              Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_profile2neff

### Tool Description
Convert a profile DB to a tab-separated list of Neff scores.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs profile2neff <I:profileDB> <o:neffFile>
 By Johannes Spies <johannes.spies@tum.de>
options: 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_profile2pssm

### Tool Description
Convert a profile DB to a tab-separated PSSM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs profile2pssm <i:profileDB> <o:pssmFile> [options]
 By Milot Mirdita <milot@mirdita.de>
options: prefilter:                  
 --comp-bias-corr INT         Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT Correct for locally biased amino acid composition (range 0-1) [1.000]
common:                     
 --sub-mat TWIN               Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT            Maximum sequence length [65535]
 --threads INT                Number of CPU-cores used (all by default) [20]
 --compressed INT             Write compressed output [0]
 -v INT                       Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
expert:                     
 --db-output BOOL             Return a result DB instead of a text file [0]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_profile2repseq

### Tool Description
Extract representative sequence DB from a profile DB.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs profile2repseq <i:profileDB> <o:sequenceDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: common:            
 --sub-mat TWIN      Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT   Maximum sequence length [65535]
 --threads INT       Number of CPU-cores used (all by default) [20]
 --compressed INT    Write compressed output [0]
 -v INT              Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_addtaxonomy

### Tool Description
Add taxonomic labels (from the target database) to a result database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs addtaxonomy <i:targetDB> <i:resultDB> <o:resultDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: misc:               
 --tax-lineage INT    0: don't show, 1: add all lineage names, 2: add all lineage taxids [0]
 --lca-ranks STR      Add column with specified ranks (',' separated) []
 --pick-id-from INT   Query 1, Target 2 [2]
common:             
 --compressed INT     Write compressed output [0]
 --threads INT        Number of CPU-cores used (all by default) [20]
 -v INT               Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Mirdita M, Steinegger M, Breitwieser F, Soding J, Levy Karin E: Fast and sensitive taxonomic assignment to metagenomic contigs. Bioinformatics, btab184 (2021)
```

## mmseqs2_aggregatetax

### Tool Description
Aggregate multiple taxon labels per sequence to a single label per set (for example per contig).

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs aggregatetax <i:taxSeqDB> <i:setToSeqMap> <i:taxResPerSeqDB> <o:taxResPerSetDB> [options]
 By Eli Levy Karin <eli.levy.karin@gmail.com>
options: misc:              
 --lca-ranks STR     Add column with specified ranks (',' separated) []
 --tax-lineage INT   0: don't show, 1: add all lineage names, 2: add all lineage taxids [0]
common:            
 --compressed INT    Write compressed output [0]
 --threads INT       Number of CPU-cores used (all by default) [20]
 -v INT              Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

examples:
 # Download a sequence database with taxonomy information
 mmseqs databases UniProtKB/Swiss-Prot swissprotDB tmp
 
 # Create a nucleotide sequence database from FASTA
 mmseqs createdb contigs.fasta contigsDb
 
 # Extract all orfs from each contig and translate them
 mmseqs extractorfs contigsDb orfsAaDb --translate
 
 # Assign taxonomy to each orf
 mmseqs taxonomy orfsAaDb swissprotDB taxPerOrf tmp
 
 # Aggregate taxonomic assignments on each contig
 mmseqs aggregatetax swissprotDB orfsAaDb_h taxPerOrf taxPerContig --majority 0.5
 
 
references:
 - Mirdita M, Steinegger M, Breitwieser F, Soding J, Levy Karin E: Fast and sensitive taxonomic assignment to metagenomic contigs. Bioinformatics, btab184 (2021)
```

## mmseqs2_aliasdb

### Tool Description
Create a relative symbolic link of a database under another name in the same folder.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs aliasdb <i:srcDB> <o:dstDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: common: 
 -v INT   Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_align

### Tool Description
Optimal gapped local alignment of the prefilter hits of a query database against a target database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs align <i:queryDB> <i:targetDB> <i:resultDB> <o:alignmentDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr> & Maria Hauser
options: prefilter:                   
 --comp-bias-corr INT          Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT  Correct for locally biased amino acid composition (range 0-1) [1.000]
 --add-self-matches BOOL       Artificially add entries of queries with themselves (for clustering) [0]
align:                       
 -a BOOL                       Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --alignment-mode INT          How to compute the alignment:
                               0: automatic
                               1: only score and end_pos
                               2: also start_pos and cov
                               3: also seq.id [0]
 --alignment-output-mode INT   How to compute the alignment:
                               0: automatic
                               1: only score and end_pos
                               2: also start_pos and cov
                               3: also seq.id
                               4: only ungapped alignment
                               5: score only (output) cluster format [0]
 --wrapped-scoring BOOL        Double the (nucleotide) query sequence during the scoring process to allow wrapped diagonal scoring around end and start [0]
 -e DOUBLE                     List matches below this E-value (range 0.0-inf) [1.000E-03]
 --min-seq-id FLOAT            List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 --min-aln-len INT             Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT             0: alignment length 1: shorter, 2: longer sequence [0]
 --alt-ali INT                 Show up to this many alternative alignments [0]
 -c FLOAT                      List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --cov-mode INT                0: coverage of query and target
                               1: coverage of target
                               2: coverage of query
                               3: target seq. length has to be at least x% of query length
                               4: query seq. length has to be at least x% of target length
                               5: short seq. needs to be at least x% of the other seq. length [0]
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
common:                      
 --sub-mat TWIN                Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT             Maximum sequence length [65535]
 --db-load-mode INT            Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                 Number of CPU-cores used (all by default) [20]
 --compressed INT              Write compressed output [0]
 -v INT                        Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_alignall

### Tool Description
All-versus-all gapped local alignment inside each entry of a result database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs alignall <i:sequenceDB> <i:resultDB> <o:alignmentDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                  
 --comp-bias-corr INT         Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT Correct for locally biased amino acid composition (range 0-1) [1.000]
 --add-self-matches BOOL      Artificially add entries of queries with themselves (for clustering) [0]
align:                      
 -a BOOL                      Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --alignment-mode INT         How to compute the alignment:
                              0: automatic
                              1: only score and end_pos
                              2: also start_pos and cov
                              3: also seq.id [0]
 -e DOUBLE                    List matches below this E-value (range 0.0-inf) [1.000E-03]
 --min-seq-id FLOAT           List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 --min-aln-len INT            Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT            0: alignment length 1: shorter, 2: longer sequence [0]
 -c FLOAT                     List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --cov-mode INT               0: coverage of query and target
                              1: coverage of target
                              2: coverage of query
                              3: target seq. length has to be at least x% of query length
                              4: query seq. length has to be at least x% of target length
                              5: short seq. needs to be at least x% of the other seq. length [0]
 --score-bias FLOAT           Score bias when computing SW alignment (in bits) [0.000]
 --gap-open TWIN              Gap open cost [aa:11,nucl:5]
 --gap-extend TWIN            Gap extension cost [aa:1,nucl:2]
 --zdrop INT                  Maximal allowed difference between score values before alignment is truncated  (nucleotide alignment only) [40]
profile:                    
 --pca                        Pseudo count admixture strength []
 --pcb                        Pseudo counts: Neff at half of maximum admixture (range 0.0-inf) []
common:                     
 --sub-mat TWIN               Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT            Maximum sequence length [65535]
 --db-load-mode INT           Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                Number of CPU-cores used (all by default) [20]
 --compressed INT             Write compressed output [0]
 -v INT                       Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_alignbykmer

### Tool Description
Heuristic gapped local alignment based on k-mer matches (rescores diagonals).

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
Rescore diagonals.
usage: mmseqs alignbykmer <i:queryDB> <i:targetDB> <i:resultDB> <o:resultDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                 
 -k INT                      k-mer length (0: automatically set to optimum) [0]
 --spaced-kmer-mode INT      0: use consecutive positions in k-mers; 1: use spaced k-mers [1]
 --spaced-kmer-pattern STR   User-specified spaced k-mer pattern []
 --alph-size TWIN            Alphabet size (range 2-21) [aa:21,nucl:5]
 --add-self-matches BOOL     Artificially add entries of queries with themselves (for clustering) [0]
align:                     
 -c FLOAT                    List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 -e DOUBLE                   List matches below this E-value (range 0.0-inf) [1.000E-03]
 --cov-mode INT              0: coverage of query and target
                             1: coverage of target
                             2: coverage of query
                             3: target seq. length has to be at least x% of query length
                             4: query seq. length has to be at least x% of target length
                             5: short seq. needs to be at least x% of the other seq. length [0]
 --min-seq-id FLOAT          List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 --min-aln-len INT           Minimum alignment length (range 0-INT_MAX) [0]
 --gap-open TWIN             Gap open cost [aa:11,nucl:5]
 --gap-extend TWIN           Gap extension cost [aa:1,nucl:2]
common:                    
 --sub-mat TWIN              Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --threads INT               Number of CPU-cores used (all by default) [20]
 --compressed INT            Write compressed output [0]
 -v INT                      Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
expert:                    
 --filter-hits BOOL          Filter hits by seq.id. and coverage [0]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_apply

### Tool Description
Run a program on each entry of a database; the standard output of each call becomes the new entry.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs apply <i:DB> <o:DB> -- program [args...] [options]
 By Milot Mirdita <milot@mirdita.de>
options: common:           
 --threads INT      Number of CPU-cores used (all by default) [20]
 --compressed INT   Write compressed output [0]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

examples:
 # Gather all sequences from a cluster DB
 mmseqs createseqfiledb sequenceDB clusterDB unalignedDB --min-sequences 2
 # Build MSAs with Clustal-Omega
 mmseqs apply unalignedDB msaDB -- clustalo -i - -o stdout --threads=1
 
 # Count lines in each DB entry inefficiently (result2stats is way faster)
 mmseqs apply DB wcDB -- awk '{ counter++; } END { print counter; }'
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_besthitperset

### Tool Description
For each set of sequences, find the best element and update the p-value.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs besthitperset  <i:targetSetDB> <i:resultDB> <o:resultDB> [options]
 By Ruoshi Zhang, Clovis Norroy & Milot Mirdita <milot@mirdita.de>
options: misc:                  
 --simple-best-hit BOOL  Update the p-value by a single best hit, or by best and second best hits [1]
common:                
 --threads INT           Number of CPU-cores used (all by default) [20]
 --compressed INT        Write compressed output [0]
 -v INT                  Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_clust

### Tool Description
Cluster a result database (prefilter or alignment) with Set-Cover, Connected-Component or Greedy-Incremental clustering.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs clust <i:sequenceDB> <i:resultDB> <o:clusterDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr> & Lars von den Driesch & Maria Hauser
options: clust:                          
 --cluster-mode INT               0: Set-Cover (greedy)
                                  1: Connected component (BLASTclust)
                                  2,3: Greedy clustering by sequence length (CDHIT) [0]
 --max-iterations INT             Maximum depth of breadth first search in connected component clustering [1000]
 --similarity-type INT            Type of score used for clustering. 1: alignment score 2: sequence identity [2]
kmermatcher:                    
 --weights STR                    Weights used for cluster priorization []
 --cluster-weight-threshold FLOAT Weight threshold used for cluster priorization [0.900]
common:                         
 --threads INT                    Number of CPU-cores used (all by default) [20]
 --compressed INT                 Write compressed output [0]
 -v INT                           Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Hauser M, Steinegger M, Soding J: MMseqs software suite for fast and deep clustering and searching of large protein sequence sets. Bioinformatics, 32(9), 1323-1330 (2016)
```

## mmseqs2_clusterupdate

### Tool Description
Update a previous clustering with the sequences of a new database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs clusterupdate <i:oldSequenceDB> <i:newSequenceDB> <i:oldClustResultDB> <o:newMappedSequenceDB> <o:newClustResultDB> <tmpDir> [options]
 By Clovis Galiez & Martin Steinegger <martin.steinegger@snu.ac.kr>
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
 # Update clustering workflow 
 # Perform initial clustering of 5000 sequences
 mmseqs createdb <(head -n 10000 examples/DB.fasta) sequenceDB
 mmseqs cluster sequenceDB clusterDB tmp
 
 # Use-case 1: Update by only adding sequences
 mmseqs createdb examples/QUERY.fasta addedSequenceDB
 mmseqs concatdbs sequenceDB addedSequenceDB allSequenceDB
 mmseqs concatdbs sequenceDB_h addedSequenceDB_h allSequenceDB_h
 mmseqs clusterupdate sequenceDB allSequenceDB clusterDB newSequenceDB newClusterDB tmp
 
 # Use-case 2: Update clustering with deletions)
 # Create a FASTA file missing 500 of the original sequences and 2500 new ones
 mmseqs createdb <(tail -n +1001 examples/DB.fasta | head -n 15000) updateSequenceDB
 mmseqs clusterupdate sequenceDB updateSequenceDB clusterDB newSequenceDB newClusterDB tmp
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Hauser M, Steinegger M, Soding J: MMseqs software suite for fast and deep clustering and searching of large protein sequence sets. Bioinformatics, 32(9), 1323-1330 (2016)
```

## mmseqs2_clusthash

### Tool Description
Hash-based clustering of equal-length sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs clusthash <i:sequenceDB> <o:alignmentDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr> 
options: prefilter:          
 --alph-size TWIN     Alphabet size (range 2-21) [aa:3,nucl:5]
align:              
 --min-seq-id FLOAT   List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.990]
common:             
 --sub-mat TWIN       Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT    Maximum sequence length [65535]
 --db-load-mode INT   Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT        Number of CPU-cores used (all by default) [20]
 --compressed INT     Write compressed output [0]
 -v INT               Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_combinepvalperset

### Tool Description
For each set of sequences, compute the combined p-value.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs combinepvalperset <i:querySetDB> <i:targetSetDB> <i:resultDB> <o:pvalDB> [options]
 By Ruoshi Zhang, Clovis Norroy & Milot Mirdita <milot@mirdita.de>
options: misc:                   
 --alpha FLOAT            Set alpha for combining p-values during aggregation [1.000]
 --aggregation-mode INT   Combined P-values computed from 0: multi-hit, 1: minimum of all P-values, 2: product-of-P-values, 3: truncated product [0]
common:                 
 --threads INT            Number of CPU-cores used (all by default) [20]
 --compressed INT         Write compressed output [0]
 -v INT                   Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_compress

### Tool Description
Compress the entries of a database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs compress <i:DB> <o:DB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: common:        
 --threads INT   Number of CPU-cores used (all by default) [20]
 -v INT          Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_concatdbs

### Tool Description
Concatenate two databases, giving new keys to the entries of the second one.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs concatdbs <i:DB> <i:DB> <o:DB> [options]
 By Clovis Galiez, Eli Levy Karin & Martin Steinegger (martin.steinegger@snu.ac.kr)
options: misc:                    
 --preserve-keys BOOL      The keys of the two DB should be distinct, and they will be preserved in the concatenation [0]
 --take-larger-entry BOOL  Only keep the larger entry (dataSize >) in the concatenation, both databases need the same keys in the index [0]
common:                  
 --compressed INT          Write compressed output [0]
 --threads INT             Number of CPU-cores used (all by default) [1]
 -v INT                    Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

examples:
 # Download two sequences databases and concat them
 mmseqs databases PDB pdbDB tmp
 mmseqs databases UniProtKB/Swiss-Prot swissprotDB tmp
 # Works only single threaded since seq. and header DB need the same ordering
 mmseqs concatdbs pdbDB swissprotDB pdbAndSwissprotDB --threads 1
 mmseqs concatdbs pdbDB_h swissprotDB_h pdbAndSwissprotDB_h --threads 1
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_convert2fasta

### Tool Description
Convert a sequence database to FASTA format.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs convert2fasta <i:sequenceDB> <o:fastaFile> [options]
 By Milot Mirdita <milot@mirdita.de>
options: misc:                  
 --use-header-file BOOL  use the sequence header DB instead of the body to map the entry keys [0]
common:                
 -v INT                  Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_convertca3m

### Tool Description
Convert a cA3M database to a result database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs convertca3m <i:ca3mDB> <o:resultDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: common:           
 --threads INT      Number of CPU-cores used (all by default) [20]
 --compressed INT   Write compressed output [0]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_convertkb

### Tool Description
Convert UniProtKB flat files (.dat) to a database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs convertkb <i:uniprotkb.dat[.gz]> ... <i:uniprotkb.dat[.gz]> <o:uniprotkbDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: misc:               
 --mapping-file STR   Specify a file that translates the keys of a DB to new keys, TSV format []
 --kb-columns STR     list of indices of UniprotKB columns to be extracted [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
common:             
 --compressed INT     Write compressed output [0]
 -v INT               Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_convertmsa

### Tool Description
Convert a Stockholm or Pfam multiple sequence alignment file to an MSA database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs convertmsa <i:msaFile.sto[.gz]> <o:msaDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: common:                 
 --identifier-field INT   Field from STOCKHOLM comments for choosing the MSA identifier: 0: ID, 1: AC. If the respective comment does not exist, the name of the first sequence will become the identifier [1]
 --compressed INT         Write compressed output [0]
 -v INT                   Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Mirdita M, Steinegger M, Soding J: MMseqs2 desktop and local web server app for fast, interactive sequence searches. Bioinformatics, 35(16), 2856-2858 (2019)
```

## mmseqs2_convertprofiledb

### Tool Description
Convert an HH-suite HHM database to a profile database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs convertprofiledb <i:hhsuiteHHMDB> <o:profileDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: common:           
 --sub-mat TWIN     Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --threads INT      Number of CPU-cores used (all by default) [20]
 --compressed INT   Write compressed output [0]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_countkmer

### Tool Description
Count the k-mers of a sequence database; one line per k-mer (index, k-mer, count) goes to standard output.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs countkmer <i:sequenceDB>  [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                 
 -k INT                      k-mer length (0: automatically set to optimum) [5]
 --spaced-kmer-mode INT      0: use consecutive positions in k-mers; 1: use spaced k-mers [0]
 --spaced-kmer-pattern STR   User-specified spaced k-mer pattern []
common:                    
 --threads INT               Number of CPU-cores used (all by default) [20]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_cpdb

### Tool Description
Copy a database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs cpdb <i:srcDB> <o:dstDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: common: 
 -v INT   Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_createbintaxonomy

### Tool Description
Create a binary taxonomy file from the NCBI names.dmp, nodes.dmp and merged.dmp files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs createbintaxonomy <i:names.dmp> <i:nodes.dmp> <i:merged.dmp> <o:taxonomyFile> [options]
 By Milot Mirdita <milot@mirdita.de>
options: common: 
 -v INT   Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Mirdita M, Steinegger M, Breitwieser F, Soding J, Levy Karin E: Fast and sensitive taxonomic assignment to metagenomic contigs. Bioinformatics, btab184 (2021)
```

## mmseqs2_createdmptaxonomy

### Tool Description
Write NCBI-style names.dmp and nodes.dmp files from the binary taxonomy that belongs to a database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs createdmptaxonomy <i:taxonomyFile> <i:dmpBase> [options]
 By Milot Mirdita <milot@mirdita.de>
options: common: 
 -v INT   Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Mirdita M, Steinegger M, Breitwieser F, Soding J, Levy Karin E: Fast and sensitive taxonomic assignment to metagenomic contigs. Bioinformatics, btab184 (2021)
```

## mmseqs2_createlinindex

### Tool Description
Create the index used by linsearch (a k-mer index with one entry per sequence).

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs createlinindex <i:sequenceDB> <tmpDir> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                  
 --seed-sub-mat TWIN          Substitution matrix file for k-mer generation [aa:blosum62.out,nucl:nucleotide.out]
 -k INT                       k-mer length (0: automatically set to optimum) [0]
 --split-memory-limit BYTE    Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
 --alph-size TWIN             Alphabet size (range 2-21) [aa:21,nucl:5]
 --mask INT                   Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [0]
 --mask-prob FLOAT            Mask sequences is probablity is above threshold [0.900]
 --mask-lower-case INT        Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
 --mask-n-repeat INT          Repeat letters that occure > threshold in a rwo [0]
 --spaced-kmer-mode INT       0: use consecutive positions in k-mers; 1: use spaced k-mers [0]
 --spaced-kmer-pattern STR    User-specified spaced k-mer pattern []
align:                      
 --min-seq-id FLOAT           List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
kmermatcher:                
 --hash-shift INT             Shift k-mer hash initialization [67]
 --kmer-per-seq INT           k-mers per sequence [21]
 --kmer-per-seq-scale TWIN    Scale k-mer per sequence based on sequence length as kmer-per-seq val + scale x seqlen [aa:0.000,nucl:0.200]
 --adjust-kmer-len BOOL       Adjust k-mer length based on specificity (only for nucleotides) [0]
 --ignore-multi-kmer BOOL     Skip k-mers occurring multiple times (>=2) [0]
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
common:                     
 --max-seq-len INT            Maximum sequence length [65535]
 -v INT                       Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --threads INT                Number of CPU-cores used (all by default) [20]
 --compressed INT             Write compressed output [0]
 --remove-tmp-files BOOL      Delete temporary files [0]
expert:                     
 --create-lookup INT          Create database lookup file (can be very large) [0]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Mirdita M, Steinegger M, Soding J: MMseqs2 desktop and local web server app for fast, interactive sequence searches. Bioinformatics, 35(16), 2856-2858 (2019)
```

## mmseqs2_createseqfiledb

### Tool Description
Create a database of unaligned FASTA entries, one per cluster, from a sequence database and a cluster database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs createseqfiledb <i:sequenceDB> <i:resultDB> <o:fastaDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: misc:                
 --min-sequences INT   Minimum number of sequences a cluster may contain [1]
 --max-sequences INT   Maximum number of sequences a cluster may contain [2147483647]
 --hh-format BOOL      Format entries to use with hhsuite (for singleton clusters) [0]
common:              
 --db-load-mode INT    Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT         Number of CPU-cores used (all by default) [20]
 --compressed INT      Write compressed output [0]
 -v INT                Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

examples:
 # Gather all sequences from a cluster DB
 mmseqs createseqfiledb sequenceDB clusterDB unalignedDB --min-sequences 2
 # Build MSAs with Clustal-Omega
 mmseqs apply unalignedDB msaDB -- clustalo -i - -o stdout --threads=1
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_createsubdb

### Tool Description
Create a subset of a database from a list of keys or from the keys of another database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs createsubdb <i:subsetFile|DB> <i:DB> <o:DB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: misc:             
 --subdb-mode INT   Subdb mode 0: copy data 1: soft link data and write index [0]
 --id-mode INT      Select DB entries based on 0: database keys, 1: FASTA identifiers (.lookup) [0]
common:           
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

examples:
 # Create a new sequenceDB from sequenceDB entries with keys 1, 2 and 3
 mmseqs createsubdb <(printf '1
 2
 3
 ') sequenceDB oneTwoThreeDB
 
 # Create a new sequence database with representatives of clusterDB
 mmseqs cluster sequenceDB clusterDB tmp
 mmseqs createsubdb clusterDB sequenceDB representativesDB
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_createtaxdb

### Tool Description
Add taxonomic labels to a sequence database (writes <db>_taxonomy, <db>_mapping and related files beside it).

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs createtaxdb <i:sequenceDB> <tmpDir> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: misc:                   
 --ncbi-tax-dump STR      NCBI tax dump directory. The tax dump can be downloaded here "ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdump.tar.gz" []
 --tax-mapping-file STR   File to map sequence identifier to taxonomical identifier []
 --tax-mapping-mode INT   Map taxonomy based on sequence database 0: .lookup file 1: .source file [0]
 --tax-db-mode INT        Create taxonomy database as: 0: .dmp flat files (human readable) 1: binary dump (faster readin) [1]
common:                 
 --threads INT            Number of CPU-cores used (all by default) [20]
 -v INT                   Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Mirdita M, Steinegger M, Breitwieser F, Soding J, Levy Karin E: Fast and sensitive taxonomic assignment to metagenomic contigs. Bioinformatics, btab184 (2021)
```

## mmseqs2_databases

### Tool Description
List or download a public database (for example UniRef90, Pfam-A.seed, Resfinder) and convert it to an MMseqs2 database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs databases <name> <o:sequenceDB> <tmpDir> [options]
 By Milot Mirdita <milot@mirdita.de>

  Name                	Type      	Taxonomy	Url                                                           
- UniRef100           	Aminoacid 	     yes	https://www.uniprot.org/help/uniref
  The UniProt Reference Clusters provide clustered sets of sequences from the UniProt Knowledgebase.
  Cite: Suzek et al: UniRef: comprehensive and non-redundant UniProt reference clusters. Bioinformatics 23(10), 1282–1288 (2007)

- UniRef90            	Aminoacid 	     yes	https://www.uniprot.org/help/uniref
  The UniProt Reference Clusters provide clustered sets of sequences from the UniProt Knowledgebase.
  Cite: Suzek et al: UniRef: comprehensive and non-redundant UniProt reference clusters. Bioinformatics 23(10), 1282–1288 (2007)

- UniRef50            	Aminoacid 	     yes	https://www.uniprot.org/help/uniref
  The UniProt Reference Clusters provide clustered sets of sequences from the UniProt Knowledgebase.
  Cite: Suzek et al: UniRef: comprehensive and non-redundant UniProt reference clusters. Bioinformatics 23(10), 1282–1288 (2007)

- UniProtKB           	Aminoacid 	     yes	https://www.uniprot.org/help/uniprotkb
  The UniProt Knowledgebase is the central hub for the collection of functional information on proteins, with accurate, consistent and rich annotation.
  Cite: The UniProt Consortium: UniProt: a worldwide hub of protein knowledge. Nucleic Acids Res 47(D1), D506-515 (2019)

- UniProtKB/TrEMBL    	Aminoacid 	     yes	https://www.uniprot.org/help/uniprotkb
  UniProtKB/TrEMBL (unreviewed) contains protein sequences associated with computationally generated annotation and large-scale functional characterization.
  Cite: The UniProt Consortium: UniProt: a worldwide hub of protein knowledge. Nucleic Acids Res 47(D1), D506-515 (2019)

- UniProtKB/Swiss-Prot	Aminoacid 	     yes	https://uniprot.org
  UniProtKB/Swiss-Prot (reviewed) is a high quality manually annotated and non-redundant protein sequence database, which brings together experimental results, computed features and scientific conclusions.
  Cite: The UniProt Consortium: UniProt: a worldwide hub of protein knowledge. Nucleic Acids Res 47(D1), D506-515 (2019)

- NR                  	Aminoacid 	     yes	https://ftp.ncbi.nlm.nih.gov/blast/db/FASTA
  Non-redundant protein sequences from GenPept, Swissprot, PIR, PDF, PDB, and NCBI RefSeq.
  Cite: NCBI Resource Coordinators: Database resources of the National Center for Biotechnology Information. Nucleic Acids Res 46(D1), D8-D13 (2018)

- NT                  	Nucleotide	       -	https://ftp.ncbi.nlm.nih.gov/blast/db/FASTA
  Partially non-redundant nucleotide sequences from all traditional divisions of GenBank, EMBL, and DDBJ excluding GSS, STS, PAT, EST, HTG, and WGS.
  Cite: NCBI Resource Coordinators: Database resources of the National Center for Biotechnology Information. Nucleic Acids Res 46(D1), D8-D13 (2018)

- GTDB                	Aminoacid 	     yes	https://gtdb.ecogenomic.org
  Genome Taxonomy Database is a phylogenetically consistent, genome-based taxonomy that provides rank-normalized classifications for ~150,000 bacterial and archaeal genomes from domain to genus.
  Cite: Parks et al: A complete domain-to-species taxonomy for Bacteria and Archaea. Nat Biotechnol 38(9), 1079–1086 (2020)

- PDB                 	Aminoacid 	       -	https://www.rcsb.org
  The Protein Data Bank is the single worldwide archive of structural data of biological macromolecules.
  Cite: Berman et al: The Protein Data Bank. Nucleic Acids Res 28(1), 235-242 (2000)

- PDB70               	Profile   	       -	https://github.com/soedinglab/hh-suite
  PDB clustered to 70% sequence identity and enriched using HHblits with Uniclust sequences.
  Cite: Steinegger et al: HH-suite3 for fast remote homology detection and deep protein annotation. BMC Bioinform 20(1), 473 (2019)

- Pfam-A.full         	Profile   	       -	https://pfam.xfam.org
  The Pfam database is a large collection of protein families, each represented by multiple sequence alignments and hidden Markov models.
  Cite: El-Gebali and Mistry et al: The Pfam protein families database in 2019. Nucleic Acids Res 47(D1), D427-D432 (2019)

- Pfam-A.seed         	Profile   	       -	https://pfam.xfam.org
  The Pfam database is a large collection of protein families, each represented by multiple sequence alignments and hidden Markov models.
  Cite: El-Gebali and Mistry et al: The Pfam protein families database in 2019. Nucleic Acids Res 47(D1), D427-D432 (2019)

- Pfam-B              	Profile   	       -	https://xfam.wordpress.com/2020/06/30/a-new-pfam-b-is-released
  Pfam-B is a large automatically generated supplement to the Pfam database.
  Cite: Sonnhammer et al: A new Pfam-B is released. Xfam Blog (2020)

- CDD                 	Profile   	       -	https://www.ncbi.nlm.nih.gov/Structure/cdd/cdd.shtml
  Conserved Domain Database is a protein annotation resource consisting of well-annotated MSAs for ancient domains and full-length proteins.
  Cite: Lu et al: CDD/SPARCLE: the conserved domain database in 2020. Nucleic Acids Res 48(D1), D265–D268 (2020)

- eggNOG              	Profile   	       -	http://eggnog5.embl.de
  eggNOG is a hierarchical, functionally and phylogenetically annotated orthology resource
  Cite: Huerta-Cepas et al: eggNOG 5.0: a hierarchical, functionally and phylogenetically annotated orthology resource based on 5090 organisms and 2502 viruses. Nucleic Acids Res 47(D1), D309–D314 (2019)

- VOGDB               	Profile   	       -	https://vogdb.org
  VOGDB is a continuously updated resource of Virus Orthologous Groups
  Cite: Marz et al: Challenges in RNA virus bioinformatics. Bioinformatics 30, 1793–9 (2014)

- dbCAN2              	Profile   	       -	http://bcb.unl.edu/dbCAN2
  dbCAN2 is a database of carbohydrate-active enzymes.
  Cite: Zhang et al: dbCAN2: a meta server for automated carbohydrate-active enzyme annotation. Nucleic Acids Res 46(W1), W95-W101 (2018)

- SILVA               	Nucleotide	     yes	https://www.arb-silva.de
  SILVA provides datasets of aligned small and large subunit ribosomal RNA sequences for all three domains of life.
  Cite: Yilmaz et al: The SILVA and "All-species Living Tree Project (LTP)" taxonomic frameworks. Nucleic Acids Res 42(D1), D643-D648 (2014)

- Resfinder           	Nucleotide	       -	https://cge.cbs.dtu.dk/services/ResFinder
  ResFinder is a database that captures antimicrobial resistance genes from whole-genome data sets.
  Cite: Zankari et al: Identification of acquired antimicrobial resistance genes. J Antimicrob Chemother 67(11), 2640-2644 (2012)

- Kalamari            	Nucleotide	     yes	https://github.com/lskatz/Kalamari
  Kalamari contains over 250 genomes chosen to be representative of agents tracked by genome-based foodborne disease surveillance, common contaminants, and diverse phyla and bacterial genera.
  Cite: Katz et al: Kraken with Kalamari: Contamination Detection. ASM Poster, 270 (2018)

options:                         
 --tsv BOOL               Return output in TSV format [0]
                        
 --force-reuse BOOL       Reuse tmp filse in tmp/latest folder ignoring parameters and version changes [0]
 --remove-tmp-files BOOL  Delete temporary files [0]
 --compressed INT         Write compressed output [0]
 --threads INT            Number of CPU-cores used (all by default) [20]
 -v INT                   Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Mirdita M, Steinegger M, Breitwieser F, Soding J, Levy Karin E: Fast and sensitive taxonomic assignment to metagenomic contigs. Bioinformatics, btab184 (2021)
```

## mmseqs2_db2tar

### Tool Description
Archive the files of a database into a tar file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs db2tar <i:DB> <o:tar[.gz]> [options]
 By Milot Mirdita <milot@mirdita.de>
options: common: 
 -v INT   Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

examples:
 # Create a tar from a MSA DB
 mmseqs db2tar msaDB archive.tar.gz
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_decompress

### Tool Description
Decompress the entries of a database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs decompress <i:DB> <o:DB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: common:        
 --threads INT   Number of CPU-cores used (all by default) [20]
 -v INT          Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_diffseqdbs

### Tool Description
Compute the difference of two sequence databases: removed, kept and new sequence keys.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs diffseqdbs <i:oldSequenceDB> <i:newSequenceDB> <o:rmSeqKeysFile> <o:keptSeqKeysFile> <o:newSeqKeysFile> [options]
 By Clovis Galiez & Martin Steinegger <martin.steinegger@snu.ac.kr>
options: misc:             
 --use-seq-id BOOL  Sequence ID (Uniprot, GenBank, ...) is used for identifying matches between the old and the new DB [0]
common:           
 --threads INT      Number of CPU-cores used (all by default) [20]
 --compressed INT   Write compressed output [0]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_easy-linsearch

### Tool Description
Fast, less sensitive homology search of FASTA queries against a FASTA file or database, with a text alignment table as output.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs easy-linsearch <i:queryFastaFile1[.gz|.bz2]> ... <i:queryFastaFileN[.gz|.bz2]> <i:targetFastaFile[.gz|.bz2]>|<i:targetDB> <o:alignmentFile> <tmpDir> [options]
 By Milot Mirdita <milot@mirdita.de> & Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                   
 --comp-bias-corr INT          Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT  Correct for locally biased amino acid composition (range 0-1) [1.000]
 --add-self-matches BOOL       Artificially add entries of queries with themselves (for clustering) [0]
 --seed-sub-mat TWIN           Substitution matrix file for k-mer generation [aa:VTML80.out,nucl:nucleotide.out]
 --mask INT                    Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [1]
 --mask-prob FLOAT             Mask sequences is probablity is above threshold [0.900]
 --mask-lower-case INT         Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
 --mask-n-repeat INT           Repeat letters that occure > threshold in a rwo [0]
 --split-memory-limit BYTE     Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
align:                       
 -a BOOL                       Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --alignment-mode INT          How to compute the alignment:
                               0: automatic
                               1: only score and end_pos
                               2: also start_pos and cov
                               3: also seq.id
                               4: only ungapped alignment [3]
 --alignment-output-mode INT   How to compute the alignment:
                               0: automatic
                               1: only score and end_pos
                               2: also start_pos and cov
                               3: also seq.id
                               4: only ungapped alignment
                               5: score only (output) cluster format [0]
 --wrapped-scoring BOOL        Double the (nucleotide) query sequence during the scoring process to allow wrapped diagonal scoring around end and start [0]
 -e DOUBLE                     List matches below this E-value (range 0.0-inf) [1.000E-03]
 --min-seq-id FLOAT            List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 --min-aln-len INT             Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT             0: alignment length 1: shorter, 2: longer sequence [0]
 --alt-ali INT                 Show up to this many alternative alignments [0]
 -c FLOAT                      List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --cov-mode INT                0: coverage of query and target
                               1: coverage of target
                               2: coverage of query
                               3: target seq. length has to be at least x% of query length
                               4: query seq. length has to be at least x% of target length
                               5: short seq. needs to be at least x% of the other seq. length [0]
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
kmermatcher:                 
 --kmer-per-seq INT            k-mers per sequence [21]
 --kmer-per-seq-scale TWIN     Scale k-mer per sequence based on sequence length as kmer-per-seq val + scale x seqlen [aa:0.000,nucl:0.200]
 --pick-n-sim-kmer INT         Add N similar k-mers to search [1]
 --result-direction INT        result is 0: query, 1: target centric [1]
profile:                     
 --pca                         Pseudo count admixture strength []
 --pcb                         Pseudo counts: Neff at half of maximum admixture (range 0.0-inf) []
misc:                        
 --min-length INT              Minimum codon number in open reading frames [30]
 --max-length INT              Maximum codon number in open reading frames [32734]
 --max-gaps INT                Maximum number of codons with gaps or unknown residues before an open reading frame is rejected [2147483647]
 --contig-start-mode INT       Contig start can be 0: incomplete, 1: complete, 2: both [2]
 --contig-end-mode INT         Contig end can be 0: incomplete, 1: complete, 2: both [2]
 --orf-start-mode INT          Orf fragment can be 0: from start to stop, 1: from any to stop, 2: from last encountered start to stop (no start in the middle) [1]
 --forward-frames STR          Comma-separated list of frames on the forward strand to be extracted [1,2,3]
 --reverse-frames STR          Comma-separated list of frames on the reverse strand to be extracted [1,2,3]
 --translation-table INT       1) CANONICAL, 2) VERT_MITOCHONDRIAL, 3) YEAST_MITOCHONDRIAL, 4) MOLD_MITOCHONDRIAL, 5) INVERT_MITOCHONDRIAL, 6) CILIATE
                               9) FLATWORM_MITOCHONDRIAL, 10) EUPLOTID, 11) PROKARYOTE, 12) ALT_YEAST, 13) ASCIDIAN_MITOCHONDRIAL, 14) ALT_FLATWORM_MITOCHONDRIAL
                               15) BLEPHARISMA, 16) CHLOROPHYCEAN_MITOCHONDRIAL, 21) TREMATODE_MITOCHONDRIAL, 22) SCENEDESMUS_MITOCHONDRIAL
                               23) THRAUSTOCHYTRIUM_MITOCHONDRIAL, 24) PTEROBRANCHIA_MITOCHONDRIAL, 25) GRACILIBACTERIA, 26) PACHYSOLEN, 27) KARYORELICT, 28) CONDYLOSTOMA
                                29) MESODINIUM, 30) PERTRICH, 31) BLASTOCRITHIDIA [1]
 --translate INT               Translate ORF to amino acid [0]
 --use-all-table-starts BOOL   Use all alternatives for a start codon in the genetic table, if false - only ATG (AUG) [0]
 --id-offset INT               Numeric ids in index file are offset by this value [0]
 --search-type INT             Search type 0: auto 1: amino acid, 2: translated, 3: nucleotide, 4: translated nucleotide alignment [0]
 --format-mode INT             Output format:
                               0: BLAST-TAB
                               1: SAM
                               2: BLAST-TAB + query/db length
                               3: Pretty HTML
                               4: BLAST-TAB + column headers
                               BLAST-TAB (0) and BLAST-TAB + column headers (4) support custom output formats (--format-output) [0]
 --format-output STR           Choose comma separated list of output columns from: query,target,evalue,gapopen,pident,fident,nident,qstart,qend,qlen
                               tstart,tend,tlen,alnlen,raw,bits,cigar,qseq,tseq,qheader,theader,qaln,taln,qframe,tframe,mismatch,qcov,tcov
                               qset,qsetid,tset,tsetid,taxid,taxname,taxlineage,qorfstart,qorfend,torfstart,torfend,ppos [query,target,fident,alnlen,mismatch,gapopen,qstart,qend,tstart,tend,evalue,bits]
common:                      
 --sub-mat TWIN                Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT             Maximum sequence length [65535]
 --db-load-mode INT            Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT                 Number of CPU-cores used (all by default) [20]
 --compressed INT              Write compressed output [0]
 -v INT                        Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --mpi-runner STR              Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42") []
 --force-reuse BOOL            Reuse tmp filse in tmp/latest folder ignoring parameters and version changes [0]
 --remove-tmp-files BOOL       Delete temporary files [1]
expert:                      
 --create-lookup INT           Create database lookup file (can be very large) [0]
 --chain-alignments INT        Chain overlapping alignments [0]
 --merge-query INT             Combine ORFs/split sequences to a single entry [1]
 --db-output BOOL              Return a result DB instead of a text file [0]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Steinegger M, Soding J: Clustering huge protein sequence sets in linear time. Nature Communications, 9(1), 2542 (2018)
```

## mmseqs2_easy-rbh

### Tool Description
Find reciprocal best hits between a FASTA query file and a FASTA target file or database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs easy-rbh <i:queryFastaFile1[.gz|.bz2]> <i:targetFastaFile[.gz|.bz2]>|<i:targetDB> <o:alignmentFile> <tmpDir> [options]
 By Eli Levy Karin & Martin Steinegger <martin.steinegger@snu.ac.kr>
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
 --createdb-mode INT              Createdb mode 0: copy data, 1: soft link data and write new index (works only with single line fasta/q) 2: GPU compatible db [1]
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
 # Assign reciprocal best hit
 mmseqs easy-rbh examples/QUERY.fasta examples/DB.fasta result tmp
 
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_expand2profile

### Tool Description
Expand an alignment result with a second result (or cA3M) database and build a profile database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs expand2profile <i:queryDB> <i:targetDB> <i:resultDB> <i:resultDB|ca3mDB> <o:profileDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: prefilter:                    
 --comp-bias-corr INT           Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT   Correct for locally biased amino acid composition (range 0-1) [1.000]
align:                        
 --gap-open TWIN                Gap open cost [aa:11,nucl:5]
 --gap-extend TWIN              Gap extension cost [aa:1,nucl:2]
 --score-bias FLOAT             Score bias when computing SW alignment (in bits) [0.000]
 -c FLOAT                       List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --cov-mode INT                 0: coverage of query and target
                                1: coverage of target
                                2: coverage of query
                                3: target seq. length has to be at least x% of query length
                                4: query seq. length has to be at least x% of target length
                                5: short seq. needs to be at least x% of the other seq. length [0]
profile:                      
 --e-profile DOUBLE             Include sequences matches with < E-value thr. into the profile (>=0.0) [1.000E-03]
 --mask-profile INT             Mask query sequence of profile using tantan [0,1] [1]
 --wg BOOL                      Use global sequence weighting for profile calculation [0]
 --filter-msa INT               Filter msa: 0: do not filter, 1: filter [1]
 --filter-min-enable INT        Only filter MSAs with more than N sequences, 0 always filters [0]
 --max-seq-id FLOAT             Reduce redundancy of output MSA using max. pairwise sequence identity [0.0,1.0] [0.900]
 --qid STR                      Reduce diversity of output MSAs using min.seq. identity with query sequences [0.0,1.0]
                                Alternatively, can be a list of multiple thresholds:
                                E.g.: 0.15,0.30,0.50 to defines filter buckets of ]0.15-0.30] and ]0.30-0.50] [0.0]
 --qsc FLOAT                    Reduce diversity of output MSAs using min. score per aligned residue with query sequences [-50.0,100.0] [-20.000]
 --cov FLOAT                    Filter output MSAs using min. fraction of query residues covered by matched sequences [0.0,1.0] [0.000]
 --diff INT                     Filter MSAs by selecting most diverse set of sequences, keeping at least this many seqs in each MSA block of length 50 [1000]
 --pseudo-cnt-mode INT          use 0: substitution-matrix or 1: context-specific pseudocounts [0]
 --pca                          Pseudo count admixture strength []
 --pcb                          Pseudo counts: Neff at half of maximum admixture (range 0.0-inf) []
misc:                         
 --expansion-mode INT           Update score, E-value, and sequence identity by 0: input alignment 1: rescoring the inferred backtrace [0]
 --allow-deletion BOOL          Allow deletions in a MSA [0]
 --expand-filter-clusters INT   Filter each target cluster during expansion 0: no filter 1: filter [0]
common:                       
 --sub-mat TWIN                 Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT              Maximum sequence length [65535]
 --db-load-mode INT             Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --compressed INT               Write compressed output [0]
 --threads INT                  Number of CPU-cores used (all by default) [20]
 -v INT                         Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_expandaln

### Tool Description
Expand an alignment result with a second result (or cA3M) database and write a new alignment database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs expandaln <i:queryDB> <i:targetDB> <i:resultDB> <i:resultDB|ca3mDB> <o:alignmentDB> [options]
 By Milot Mirdita <milot@mirdita.de>
options: prefilter:                    
 --comp-bias-corr INT           Correct for locally biased amino acid composition (range 0-1) [1]
 --comp-bias-corr-scale FLOAT   Correct for locally biased amino acid composition (range 0-1) [1.000]
align:                        
 --gap-open TWIN                Gap open cost [aa:11,nucl:5]
 --gap-extend TWIN              Gap extension cost [aa:1,nucl:2]
 --score-bias FLOAT             Score bias when computing SW alignment (in bits) [0.000]
 -e DOUBLE                      List matches below this E-value (range 0.0-inf) [1.000E-03]
 --min-seq-id FLOAT             List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
 -c FLOAT                       List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --cov-mode INT                 0: coverage of query and target
                                1: coverage of target
                                2: coverage of query
                                3: target seq. length has to be at least x% of query length
                                4: query seq. length has to be at least x% of target length
                                5: short seq. needs to be at least x% of the other seq. length [0]
profile:                      
 --pseudo-cnt-mode INT          use 0: substitution-matrix or 1: context-specific pseudocounts [0]
 --pca                          Pseudo count admixture strength []
 --pcb                          Pseudo counts: Neff at half of maximum admixture (range 0.0-inf) []
 --filter-min-enable INT        Only filter MSAs with more than N sequences, 0 always filters [0]
 --max-seq-id FLOAT             Reduce redundancy of output MSA using max. pairwise sequence identity [0.0,1.0] [0.900]
 --qid STR                      Reduce diversity of output MSAs using min.seq. identity with query sequences [0.0,1.0]
                                Alternatively, can be a list of multiple thresholds:
                                E.g.: 0.15,0.30,0.50 to defines filter buckets of ]0.15-0.30] and ]0.30-0.50] [0.0]
 --qsc FLOAT                    Reduce diversity of output MSAs using min. score per aligned residue with query sequences [-50.0,100.0] [-20.000]
 --cov FLOAT                    Filter output MSAs using min. fraction of query residues covered by matched sequences [0.0,1.0] [0.000]
 --diff INT                     Filter MSAs by selecting most diverse set of sequences, keeping at least this many seqs in each MSA block of length 50 [1000]
misc:                         
 --expansion-mode INT           Update score, E-value, and sequence identity by 0: input alignment 1: rescoring the inferred backtrace [0]
 --expand-filter-clusters INT   Filter each target cluster during expansion 0: no filter 1: filter [0]
common:                       
 --sub-mat TWIN                 Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --max-seq-len INT              Maximum sequence length [65535]
 --db-load-mode INT             Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --compressed INT               Write compressed output [0]
 --threads INT                  Number of CPU-cores used (all by default) [20]
 -v INT                         Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

## mmseqs2_extractdomains

### Tool Description
Extract the highest scoring aligned region of each sequence from an alignment database and an MSA database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs extractdomains <i:alignmentDb> <i:msaDB> <o:domainDB> [options]
 By Milot Mirdita <milot@mirdita.de> & Martin Steinegger <martin.steinegger@snu.ac.kr>
options: align:            
 -e DOUBLE          List matches below this E-value (range 0.0-inf) [1.000E-03]
 -c FLOAT           List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
misc:             
 --msa-type INT     MSA Type: 0: cA3M, 1: A3M, 2: FASTA [2]
common:           
 --sub-mat TWIN     Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
 --threads INT      Number of CPU-cores used (all by default) [20]
 --compressed INT   Write compressed output [0]
 -v INT             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
 - Mirdita M, von den Driesch L, Galiez C, Martin M, Soding J, Steinegger M: Uniclust databases of clustered and deeply annotated protein sequences and alignments. Nucleic Acids Research 45(D1), D170-D176 (2017)
```

## mmseqs2_extractframes

### Tool Description
Extract the frames of a nucleotide sequence database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mmseqs extractframes <i:sequenceDB> <o:sequenceDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr> 
options: misc:                    
 --forward-frames STR      Comma-separated list of frames on the forward strand to be extracted [1,2,3]
 --reverse-frames STR      Comma-separated list of frames on the reverse strand to be extracted [1,2,3]
 --translation-table INT   1) CANONICAL, 2) VERT_MITOCHONDRIAL, 3) YEAST_MITOCHONDRIAL, 4) MOLD_MITOCHONDRIAL, 5) INVERT_MITOCHONDRIAL, 6) CILIATE
                           9) FLATWORM_MITOCHONDRIAL, 10) EUPLOTID, 11) PROKARYOTE, 12) ALT_YEAST, 13) ASCIDIAN_MITOCHONDRIAL, 14) ALT_FLATWORM_MITOCHONDRIAL
                           15) BLEPHARISMA, 16) CHLOROPHYCEAN_MITOCHONDRIAL, 21) TREMATODE_MITOCHONDRIAL, 22) SCENEDESMUS_MITOCHONDRIAL
                           23) THRAUSTOCHYTRIUM_MITOCHONDRIAL, 24) PTEROBRANCHIA_MITOCHONDRIAL, 25) GRACILIBACTERIA, 26) PACHYSOLEN, 27) KARYORELICT, 28) CONDYLOSTOMA
                            29) MESODINIUM, 30) PERTRICH, 31) BLASTOCRITHIDIA [1]
 --translate INT           Translate ORF to amino acid [0]
common:                  
 --threads INT             Number of CPU-cores used (all by default) [20]
 --compressed INT          Write compressed output [0]
 -v INT                    Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
expert:                  
 --create-lookup INT       Create database lookup file (can be very large) [0]

references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```

