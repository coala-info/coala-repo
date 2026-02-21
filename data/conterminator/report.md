# conterminator CWL Generation Report

## conterminator_dna

### Tool Description
Searches for cross taxon contamination in DNA sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/conterminator:1.c74b5--h9cf7dee_0
- **Homepage**: https://github.com/martin-steinegger/conterminator
- **Package**: https://anaconda.org/channels/bioconda/packages/conterminator/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/conterminator/overview
- **Total Downloads**: 4.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/martin-steinegger/conterminator
- **Stars**: N/A
### Original Help Text
```text
Usage: conterminator dna <i:fasta/q> <i:mappingFile> <o:result> <tmpDir> [options]
 By Martin Steinegger <martin.steinegger@mpibpc.mpg.de>

Options: 
 Prefilter:                
   --comp-bias-corr INT         correct for locally biased amino acid composition (range 0-1) [0]
   --add-self-matches           artificially add entries of queries with themselves (for clustering)
   --seed-sub-mat MAT           amino acid substitution matrix for kmer generation file [nucl:nucleotide.out,aa:VTML80.out]
   -s FLOAT                     sensitivity: 1.0 faster; 4.0 fast default; 7.5 sensitive (range 1.0-7.5) [5.700]
   -k INT                       k-mer size in the range (0: set automatically to optimum) [15]
   --k-score INT                K-mer threshold for generating similar k-mer lists [2147483647]
   --alph-size INT              alphabet size (range 2-21) [21]
   --split INT                  Splits input sets into N equally distributed chunks. The default value sets the best split automatically. createindex can only be used with split 1. [0]
   --split-mode INT             0: split target db; 1: split query db;  2: auto, depending on main memory [2]
   --diag-score                 Use ungapped diagonal scoring during prefilter
   --exact-kmer-matching INT    only exact k-mer matching (range 0-1) [1]
   --mask INT                   mask sequences in k-mer stage 0: w/o low complexity masking, 1: with low complexity masking [0]
   --mask-lower-case INT        lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
   --min-ungapped-score INT     accept only matches with ungapped alignment score above this threshold [25]
   --spaced-kmer-mode INT       0: use consecutive positions a k-mers; 1: use spaced k-mers [1]
   --spaced-kmer-pattern STR    User-specified spaced k-mer pattern []
   --local-tmp STR              Path where some of the temporary files will be created []
   --disk-space-limit BYTE      Set max disk space to use for reverse profile searches. E.g. 800B, 5K, 10M, 1G. Defaults (0) to all available disk space in the temp folder. [0]

 Align:                    
   -a 0                         add backtrace string (convert to alignments with mmseqs convertalis utility) [1, set to 0 to disable]
   --alignment-mode INT         How to compute the alignment: 0: automatic; 1: only score and end_pos; 2: also start_pos and cov; 3: also seq.id; 4: only ungapped alignment [3]
   -e FLOAT                     list matches below this E-value (range 0.0-inf) [0.001]
   --min-seq-id FLOAT           list matches above this sequence identity (for clustering) (range 0.0-1.0) [0.900]
   --min-aln-len INT            minimum alignment length (range 0-INT_MAX) [100]
   --seq-id-mode INT            0: alignment length 1: shorter, 2: longer sequence [0]
   --alt-ali INT                Show up to this many alternative alignments [0]
   -c FLOAT                     list matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
   --cov-mode INT               0: coverage of query and target, 1: coverage of target, 2: coverage of query 3: target seq. length needs to be at least x% of query length, 4: query seq. length needs to be at least x% of target length 5: short seq. needs to be at least x% of the other seq. length [0]
   --realign                    compute more conservative, shorter alignments (scores and E-values not changed)
   --max-rejected INT           maximum rejected alignments before alignment calculation for a query is aborted [2147483647]
   --max-accept INT             maximum accepted alignments before alignment calculation for a query is stopped [2147483647]
   --score-bias FLOAT           Score bias when computing the SW alignment (in bits) [0.000]
   --gap-open INT               Gap open cost [5]
   --gap-extend INT             Gap extension cost [2]

 Profile:                  
   --pca FLOAT                  pseudo count admixture strength [1.000]
   --pcb FLOAT                  pseudo counts: Neff at half of maximum admixture (range 0.0-inf) [1.500]
   --mask-profile INT           mask query sequence of profile using tantan [0,1] [1]
   --e-profile FLOAT            includes sequences matches with < e-value thr. into the profile (>=0.0) [0.001]
   --wg                         use global sequence weighting for profile calculation
   --filter-msa INT             filter msa: 0: do not filter, 1: filter [1]
   --max-seq-id FLOAT           reduce redundancy of output MSA using max. pairwise sequence identity [0.0,1.0] [0.900]
   --qid FLOAT                  reduce diversity of output MSAs using min.seq. identity with query sequences [0.0,1.0] [0.000]
   --qsc FLOAT                  reduce diversity of output MSAs using min. score per aligned residue with query sequences [-50.0,100.0] [-20.000]
   --cov FLOAT                  filter output MSAs using min. fraction of query residues covered by matched sequences [0.0,1.0] [0.000]
   --diff INT                   filter MSAs by selecting most diverse set of sequences, keeping at least this many seqs in each MSA block of length 50 [1000]
   --num-iterations INT         Search iterations [1]
   --slice-search               For bigger profile DB, run iteratively the search by greedily swapping the search results.

 Misc:                     
   --wrapped-scoring            Double the (nucleotide) query sequence during the scoring process to allow wrapped diagonal scoring around end and start
   --rescore-mode INT           Rescore diagonal with: 0: Hamming distance, 1: local alignment (score only), 2: local alignment, 3: global alignment or 4: longest alignment fullfilling window quality criterion [2]
   --allow-deletion             allow deletions in a MSA
   --min-length INT             minimum codon number in open reading frames [30]
   --max-length INT             maximum codon number in open reading frames [32734]
   --max-gaps INT               maximum number of codons with gaps or unknown residues before an open reading frame is rejected [2147483647]
   --contig-start-mode INT      Contig start can be 0: incomplete, 1: complete, 2: both [2]
   --contig-end-mode INT        Contig end can be 0: incomplete, 1: complete, 2: both  [2]
   --orf-start-mode INT         Orf fragment can be 0: from start to stop, 1: from any to stop, 2: from last encountered start to stop (no start in the middle) [1]
   --forward-frames STR         comma-seperated list of ORF frames on the forward strand to be extracted [1]
   --reverse-frames STR         comma-seperated list of ORF frames on the reverse strand to be extracted [1]
   --translation-table INT      1) CANONICAL, 2) VERT_MITOCHONDRIAL, 3) YEAST_MITOCHONDRIAL, 4) MOLD_MITOCHONDRIAL, 5) INVERT_MITOCHONDRIAL, 6) CILIATE, 9) FLATWORM_MITOCHONDRIAL, 10) EUPLOTID, 11) PROKARYOTE, 12) ALT_YEAST, 13) ASCIDIAN_MITOCHONDRIAL, 14) ALT_FLATWORM_MITOCHONDRIAL, 15) BLEPHARISMA, 16) CHLOROPHYCEAN_MITOCHONDRIAL, 21) TREMATODE_MITOCHONDRIAL, 22) SCENEDESMUS_MITOCHONDRIAL, 23) THRAUSTOCHYTRIUM_MITOCHONDRIAL, 24) PTEROBRANCHIA_MITOCHONDRIAL, 25) GRACILIBACTERIA, 26) PACHYSOLEN, 27) KARYORELICT, 28) CONDYLOSTOMA, 29) MESODINIUM, 30) PERTRICH, 31) BLASTOCRITHIDIA [1]
   --translate INT              translate ORF to amino acid [0]
   --use-all-table-starts       use all alteratives for a start codon in the genetic table, if false - only ATG (AUG)
   --id-offset INT              numeric ids in index file are offset by this value  [0]
   --add-orf-stop               add * at complete start and end
   --search-type INT            search type 0: auto 1: amino acid, 2: translated, 3: nucleotide, 4: translated nucleotide alignment [0]
   --start-sens FLOAT           start sensitivity [4.000]
   --sens-steps INT             Search steps performed from --start-sense and -s. [1]
   --remove-tmp-files 0         Delete temporary files [1, set to 0 to disable]
   --dbtype INT                 Database type 0: auto, 1: amino acid 2: nucleotides [0]
   --shuffle 0                  Shuffle input database [1, set to 0 to disable]
   --createdb-mode INT          createdb mode 0: copy data, 1: soft link data and write new index (works only with single line fasta/q) [0]
   --ncbi-tax-dump STR          NCBI tax dump directory. The tax dump can be downloaded here "ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz" []
   --tax-mapping-file STR       File to map sequence identifer to taxonomical identifier []
   --blacklist STR              Comma separated list of ignored taxa in LCA computation [10239,12908,28384,81077,11632,340016,61964,48479,48510]
   --kingdoms STR                [(2||2157),4751,33208,33090,(2759&&!4751&&!33208&&!33090)]

 Common:                   
   --sub-mat MAT                amino acid substitution matrix file [nucl:nucleotide.out,aa:blosum62.out]
   --max-seq-len INT            maximum sequence length (range 1-32768]) [1000]
   --db-load-mode INT           Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
   --threads INT                number of cores used for the computation (uses all cores by default) [32]
   --compressed INT             write results in compressed format [0]
   -v INT                       verbosity level: 0=nothing, 1: +errors, 2: +warnings, 3: +info [3]
   --split-memory-limit BYTE    Set max memory per split. E.g. 800B, 5K, 10M, 1G. Defaults (0) to all available system memory. [0]
   --mpi-runner STR             Use MPI on compute grid with this MPI command (e.g. "mpirun -np 42") []
   --force-reuse                reuse tmp file in tmp/latest folder ignoring parameters and git version change

 Expert:                   
   --filter-hits                filter hits by seq.id. and coverage
   --sort-results INT           Sort results: 0: no sorting, 1: sort by evalue (Alignment) or seq.id. (Hamming) [0]
   --omit-consensus             Omit consensus sequence in alignment
   --create-lookup INT          Create database lookup file (can be very large) [0]
   --chain-alignments INT       Chain overlapping alignments [0]
   --merge-query INT            combine ORFs/split sequences to a single entry [1]
   --strand INT                 Strand selection only works for DNA/DNA search 0: reverse, 1: forward, 2: both [2]

References:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)

Examples:
 Searches for cross taxon contamination in DNA sequences
Unrecognized parameter -help
Did you mean "--add-self-matches"?
```


## conterminator_protein

### Tool Description
Searches for cross taxon contamination in protein sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/conterminator:1.c74b5--h9cf7dee_0
- **Homepage**: https://github.com/martin-steinegger/conterminator
- **Package**: https://anaconda.org/channels/bioconda/packages/conterminator/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: conterminator protein <i:fasta/q> <i:mappingFile> <o:result> <tmpDir> [options]
 By Martin Steinegger <martin.steinegger@mpibpc.mpg.de>

Options: 
 Prefilter:                
   --comp-bias-corr INT         correct for locally biased amino acid composition (range 0-1) [1]
   --add-self-matches           artificially add entries of queries with themselves (for clustering)
   --seed-sub-mat MAT           amino acid substitution matrix for kmer generation file [nucl:nucleotide.out,aa:VTML80.out]
   -s FLOAT                     sensitivity: 1.0 faster; 4.0 fast default; 7.5 sensitive (range 1.0-7.5) [4.000]
   -k INT                       k-mer size in the range (0: set automatically to optimum) [0]
   --k-score INT                K-mer threshold for generating similar k-mer lists [2147483647]
   --alph-size INT              alphabet size (range 2-21) [21]
   --split INT                  Splits input sets into N equally distributed chunks. The default value sets the best split automatically. createindex can only be used with split 1. [0]
   --split-mode INT             0: split target db; 1: split query db;  2: auto, depending on main memory [2]
   --diag-score 0               Use ungapped diagonal scoring during prefilter [1, set to 0 to disable]
   --exact-kmer-matching INT    only exact k-mer matching (range 0-1) [0]
   --mask INT                   mask sequences in k-mer stage 0: w/o low complexity masking, 1: with low complexity masking [0]
   --mask-lower-case INT        lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
   --min-ungapped-score INT     accept only matches with ungapped alignment score above this threshold [15]
   --spaced-kmer-mode INT       0: use consecutive positions a k-mers; 1: use spaced k-mers [1]
   --spaced-kmer-pattern STR    User-specified spaced k-mer pattern []
   --local-tmp STR              Path where some of the temporary files will be created []
   --disk-space-limit BYTE      Set max disk space to use for reverse profile searches. E.g. 800B, 5K, 10M, 1G. Defaults (0) to all available disk space in the temp folder. [0]

 Align:                    
   -a                           add backtrace string (convert to alignments with mmseqs convertalis utility)
   --alignment-mode INT         How to compute the alignment: 0: automatic; 1: only score and end_pos; 2: also start_pos and cov; 3: also seq.id; 4: only ungapped alignment [3]
   -e FLOAT                     list matches below this E-value (range 0.0-inf) [0.001]
   --min-seq-id FLOAT           list matches above this sequence identity (for clustering) (range 0.0-1.0) [0.950]
   --min-aln-len INT            minimum alignment length (range 0-INT_MAX) [0]
   --seq-id-mode INT            0: alignment length 1: shorter, 2: longer sequence [0]
   --alt-ali INT                Show up to this many alternative alignments [0]
   -c FLOAT                     list matches above this fraction of aligned (covered) residues (see --cov-mode) [0.950]
   --cov-mode INT               0: coverage of query and target, 1: coverage of target, 2: coverage of query 3: target seq. length needs to be at least x% of query length, 4: query seq. length needs to be at least x% of target length 5: short seq. needs to be at least x% of the other seq. length [0]
   --realign                    compute more conservative, shorter alignments (scores and E-values not changed)
   --max-rejected INT           maximum rejected alignments before alignment calculation for a query is aborted [2147483647]
   --max-accept INT             maximum accepted alignments before alignment calculation for a query is stopped [2147483647]
   --score-bias FLOAT           Score bias when computing the SW alignment (in bits) [0.000]
   --gap-open INT               Gap open cost [11]
   --gap-extend INT             Gap extension cost [1]

 Profile:                  
   --pca FLOAT                  pseudo count admixture strength [1.000]
   --pcb FLOAT                  pseudo counts: Neff at half of maximum admixture (range 0.0-inf) [1.500]
   --mask-profile INT           mask query sequence of profile using tantan [0,1] [1]
   --e-profile FLOAT            includes sequences matches with < e-value thr. into the profile (>=0.0) [0.001]
   --wg                         use global sequence weighting for profile calculation
   --filter-msa INT             filter msa: 0: do not filter, 1: filter [1]
   --max-seq-id FLOAT           reduce redundancy of output MSA using max. pairwise sequence identity [0.0,1.0] [0.900]
   --qid FLOAT                  reduce diversity of output MSAs using min.seq. identity with query sequences [0.0,1.0] [0.000]
   --qsc FLOAT                  reduce diversity of output MSAs using min. score per aligned residue with query sequences [-50.0,100.0] [-20.000]
   --cov FLOAT                  filter output MSAs using min. fraction of query residues covered by matched sequences [0.0,1.0] [0.000]
   --diff INT                   filter MSAs by selecting most diverse set of sequences, keeping at least this many seqs in each MSA block of length 50 [1000]
   --num-iterations INT         Search iterations [1]
   --slice-search               For bigger profile DB, run iteratively the search by greedily swapping the search results.

 Misc:                     
   --wrapped-scoring            Double the (nucleotide) query sequence during the scoring process to allow wrapped diagonal scoring around end and start
   --rescore-mode INT           Rescore diagonal with: 0: Hamming distance, 1: local alignment (score only), 2: local alignment, 3: global alignment or 4: longest alignment fullfilling window quality criterion [0]
   --allow-deletion             allow deletions in a MSA
   --min-length INT             minimum codon number in open reading frames [30]
   --max-length INT             maximum codon number in open reading frames [32734]
   --max-gaps INT               maximum number of codons with gaps or unknown residues before an open reading frame is rejected [2147483647]
   --contig-start-mode INT      Contig start can be 0: incomplete, 1: complete, 2: both [2]
   --contig-end-mode INT        Contig end can be 0: incomplete, 1: complete, 2: both  [2]
   --orf-start-mode INT         Orf fragment can be 0: from start to stop, 1: from any to stop, 2: from last encountered start to stop (no start in the middle) [1]
   --forward-frames STR         comma-seperated list of ORF frames on the forward strand to be extracted [1,2,3]
   --reverse-frames STR         comma-seperated list of ORF frames on the reverse strand to be extracted [1,2,3]
   --translation-table INT      1) CANONICAL, 2) VERT_MITOCHONDRIAL, 3) YEAST_MITOCHONDRIAL, 4) MOLD_MITOCHONDRIAL, 5) INVERT_MITOCHONDRIAL, 6) CILIATE, 9) FLATWORM_MITOCHONDRIAL, 10) EUPLOTID, 11) PROKARYOTE, 12) ALT_YEAST, 13) ASCIDIAN_MITOCHONDRIAL, 14) ALT_FLATWORM_MITOCHONDRIAL, 15) BLEPHARISMA, 16) CHLOROPHYCEAN_MITOCHONDRIAL, 21) TREMATODE_MITOCHONDRIAL, 22) SCENEDESMUS_MITOCHONDRIAL, 23) THRAUSTOCHYTRIUM_MITOCHONDRIAL, 24) PTEROBRANCHIA_MITOCHONDRIAL, 25) GRACILIBACTERIA, 26) PACHYSOLEN, 27) KARYORELICT, 28) CONDYLOSTOMA, 29) MESODINIUM, 30) PERTRICH, 31) BLASTOCRITHIDIA [1]
   --translate INT              translate ORF to amino acid [0]
   --use-all-table-starts       use all alteratives for a start codon in the genetic table, if false - only ATG (AUG)
   --id-offset INT              numeric ids in index file are offset by this value  [0]
   --add-orf-stop               add * at complete start and end
   --search-type INT            search type 0: auto 1: amino acid, 2: translated, 3: nucleotide, 4: translated nucleotide alignment [0]
   --start-sens FLOAT           start sensitivity [4.000]
   --sens-steps INT             Search steps performed from --start-sense and -s. [1]
   --remove-tmp-files 0         Delete temporary files [1, set to 0 to disable]
   --dbtype INT                 Database type 0: auto, 1: amino acid 2: nucleotides [0]
   --shuffle 0                  Shuffle input database [1, set to 0 to disable]
   --createdb-mode INT          createdb mode 0: copy data, 1: soft link data and write new index (works only with single line fasta/q) [0]
   --ncbi-tax-dump STR          NCBI tax dump directory. The tax dump can be downloaded here "ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz" []
   --tax-mapping-file STR       File to map sequence identifer to taxonomical identifier []
   --blacklist STR              Comma separated list of ignored taxa in LCA computation [10239,12908,28384,81077,11632,340016,61964,48479,48510]
   --kingdoms STR                [(2||2157),4751,33208,33090,(2759&&!4751&&!33208&&!33090)]

 Common:                   
   --sub-mat MAT                amino acid substitution matrix file [nucl:nucleotide.out,aa:blosum62.out]
   --max-seq-len INT            maximum sequence length (range 1-32768]) [65535]
   --db-load-mode INT           Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
   --threads INT                number of cores used for the computation (uses all cores by default) [32]
   --compressed INT             write results in compressed format [0]
   -v INT                       verbosity level: 0=nothing, 1: +errors, 2: +warnings, 3: +info [3]
   --split-memory-limit BYTE    Set max memory per split. E.g. 800B, 5K, 10M, 1G. Defaults (0) to all available system memory. [0]
   --mpi-runner STR             Use MPI on compute grid with this MPI command (e.g. "mpirun -np 42") []
   --force-reuse                reuse tmp file in tmp/latest folder ignoring parameters and git version change

 Expert:                   
   --filter-hits                filter hits by seq.id. and coverage
   --sort-results INT           Sort results: 0: no sorting, 1: sort by evalue (Alignment) or seq.id. (Hamming) [0]
   --omit-consensus             Omit consensus sequence in alignment
   --create-lookup INT          Create database lookup file (can be very large) [0]
   --chain-alignments INT       Chain overlapping alignments [0]
   --merge-query INT            combine ORFs/split sequences to a single entry [1]
   --strand INT                 Strand selection only works for DNA/DNA search 0: reverse, 1: forward, 2: both [1]

References:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)

Examples:
 Searches for cross taxon contamination in protein sequences
Unrecognized parameter -help
Did you mean "--add-self-matches"?
```


## Metadata
- **Skill**: generated
