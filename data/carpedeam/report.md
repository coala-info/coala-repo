# carpedeam CWL Generation Report

## carpedeam_ancient_assemble

### Tool Description
By Louis Kraft <lokraf@dtu.dk>

### Metadata
- **Docker Image**: quay.io/biocontainers/carpedeam:1.0.1--hd6d6fdc_0
- **Homepage**: https://github.com/LouisPwr/CarpeDeam
- **Package**: https://anaconda.org/channels/bioconda/packages/carpedeam/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/carpedeam/overview
- **Total Downloads**: 1.6K
- **Last updated**: 2025-10-06
- **GitHub**: https://github.com/LouisPwr/CarpeDeam
- **Stars**: N/A
### Original Help Text
```text
usage: carpedeam ancient_assemble <i:fast(a|q)File[.gz]> | <i:fastqFile1_1[.gz] <i:fastqFile1_2[.gz] ... <i:fastqFileN_1[.gz] <i:fastqFileN_2[.gz]> <o:fastaFile> <tmpDir> [options]
 By Louis Kraft <lokraf@dtu.dk>
options: prefilter:                        
 --alph-size TWIN                   Alphabet size (range 2-21) [nucl:5,aa:13]
 --spaced-kmer-mode INT             0: use consecutive positions in k-mers; 1: use spaced k-mers [0]
 --spaced-kmer-pattern STR          User-specified spaced k-mer pattern []
 --mask INT                         Mask sequences in k-mer stage: 0: w/o low complexity masking, 1: with low complexity masking [0]
 --mask-lower-case INT              Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
 --split-memory-limit BYTE          Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
 --add-self-matches BOOL            Artificially add entries of queries with themselves (for clustering) [0]
align:                            
 --cov-mode INT                     0: coverage of query and target
                                    1: coverage of target
                                    2: coverage of query
                                    3: target seq. length has to be at least x% of query length
                                    4: query seq. length has to be at least x% of target length
                                    5: short seq. needs to be at least x% of the other seq. length [1]
 -e DOUBLE                          Extend sequences if the E-value is below (range 0.0-inf) [1.000E-03]
 -a BOOL                            Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --seq-id-mode INT                  0: alignment length 1: shorter, 2: longer sequence [0]
 --gap-open TWIN                    Gap open cost (only for clustering [5]
 --gap-extend TWIN                  Gap extend cost (only for clustering) [2]
 --zdrop INT                        Maximal allowed difference between score values before alignment is truncated (only for clustering) [200]
 --min-seq-id TWIN                  Overlap sequence identity threshold (range 0.0-1.0) [nucl:0.900,aa:0.970]
 --min-aln-len TWIN                 Minimum alignment length (range 0-INT_MAX) [0]
clust:                            
 --cluster-mode INT                 0: Set-Cover (greedy)
                                    1: Connected component (BLASTclust)
                                    2,3: Greedy clustering by sequence length (CDHIT) [2]
 --clust-min-seq-id FLOAT           Seq. id. threshold passed to linclust algorithm to reduce redundancy in assembly (range 0.0-1.0) [0.970]
 --clust-min-cov FLOAT              Coverage threshold passed to linclust algorithm to reduce redundancy in assembly (range 0.0-1.0) [0.990]
kmermatcher:                      
 --kmer-per-seq INT                 k-mers per sequence [200]
 --kmer-per-seq-scale TWIN          Scale k-mer per sequence based on sequence length as kmer-per-seq val + scale x seqlen [0.200]
 --adjust-kmer-len BOOL             Adjust k-mer length based on specificity (only for nucleotides) [0]
 --hash-shift INT                   Shift k-mer hash initialization [67]
 --include-only-extendable BOOL     Include only extendable [1]
 --ignore-multi-kmer BOOL           Skip k-mers occurring multiple times (>=2) [1]
 -k TWIN                            k-mer length (0: automatically set to optimum) [nucl:20,aa:14]
misc:                             
 --min-length INT                   Minimum codon number in open reading frames [45]
 --max-length INT                   Maximum codon number in open reading frames [32734]
 --forward-frames STR               Comma-separated list of frames on the forward strand to be extracted [1,2,3]
 --reverse-frames STR               Comma-separated list of frames on the reverse strand to be extracted [1,2,3]
 --translation-table INT            1) CANONICAL, 2) VERT_MITOCHONDRIAL, 3) YEAST_MITOCHONDRIAL, 4) MOLD_MITOCHONDRIAL, 5) INVERT_MITOCHONDRIAL, 6) CILIATE
                                    9) FLATWORM_MITOCHONDRIAL, 10) EUPLOTID, 11) PROKARYOTE, 12) ALT_YEAST, 13) ASCIDIAN_MITOCHONDRIAL, 14) ALT_FLATWORM_MITOCHONDRIAL
                                    15) BLEPHARISMA, 16) CHLOROPHYCEAN_MITOCHONDRIAL, 21) TREMATODE_MITOCHONDRIAL, 22) SCENEDESMUS_MITOCHONDRIAL
                                    23) THRAUSTOCHYTRIUM_MITOCHONDRIAL, 24) PTEROBRANCHIA_MITOCHONDRIAL, 25) GRACILIBACTERIA, 26) PACHYSOLEN, 27) KARYORELICT, 28) CONDYLOSTOMA
                                     29) MESODINIUM, 30) PERTRICH, 31) BLASTOCRITHIDIA [1]
 --translate INT                    Translate ORF to amino acid [0]
 --use-all-table-starts BOOL        Use all alternatives for a start codon in the genetic table, if false - only ATG (AUG) [0]
 --id-offset INT                    Numeric ids in index file are offset by this value [0]
 --keep-target BOOL                 Keep target sequences [1]
 --rescore-mode INT                 Rescore diagonals with:
                                    0: Hamming distance
                                    1: local alignment (score only)
                                    2: local alignment
                                    3: global alignment
                                    4: longest alignment fulfilling window quality criterion [3]
 --dbtype INT                       Database type 0: auto, 1: amino acid 2: nucleotides [0]
 --shuffle BOOL                     Shuffle input database [1]
 --createdb-mode INT                Createdb mode 0: copy data, 1: soft link data and write new index (works only with single line fasta/q) [0]
 --chop-cycle BOOL                  Remove superfluous part of circular fragments (see --cycle-check) [1]
 --cycle-check BOOL                 Check for circular sequences (avoid over extension of circular or long repeated regions)  [1]
 --min-contig-len INT               Minimum length of assembled contig to output [500]
 --contig-output-mode INT           Type of contigs:
                                    0: all
                                    1: only extended [1]
 --num-iter-reads-only INT          Raw reads only: Number of assembly iterations performed on nucleotide level (ancient) [5]
 --num-iterations TWIN              Number of assembly total iterations performed on nucleotide level (ignore protein level for ancient) (range 1-inf) [nucl:10,aa:1]
common:                           
 --threads INT                      Number of CPU-cores used (all by default) [20]
 --compressed INT                   Write compressed output [0]
 -v INT                             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --max-seq-len INT                  Maximum sequence length [200000]
 --sub-mat TWIN                     Substitution matrix file [nucl:nucleotide.out,aa:blosum62.out]
 --db-load-mode INT                 Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --remove-tmp-files BOOL            Delete temporary files [0]
 --delete-tmp-inc INT               Delete temporary files incremental [0,1] [1]
 --mpi-runner STR                   Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42") []
expert:                           
 --create-lookup INT                Create database lookup file (can be very large) [0]
 --write-lookup INT                 write .lookup file containing mapping from internal id, fasta id and file number [1]
 --filter-hits BOOL                 Filter hits by seq.id. and coverage [0]
 --sort-results INT                 Sort results: 0: no sorting, 1: sort by E-value (Alignment) or seq.id. (Hamming) [0]
 --ext-random-align FLOAT           Use either: 0.8 or 0.9 (ancient) [0.850]
 --excess-penalty FLOAT             Use float: 0.25 to 0.5 (ancient) [0.062]
 --min-ryseq-id-corr-reads FLOAT    Min. RY-mer space seq. ident in correction phase. Range 0-1 (ancient) [0.990]
 --min-seqid-corr-reads FLOAT       Min. seq. ident. in correction phase. Range 0-1 (ancient) [0.900]
 --likelihood-ratio-threshold FLOAT  Min. odds ratio to accept read extension. Range 0-1 (ancient) [0.500]
 --min-merge-seq-id FLOAT           Min. seq. ident. of contig overlaps (ancient) (range 0.0-1.0) [0.990]
 --min-seqid-corr-contigs FLOAT     Min. seq. ident. for contig correction (ancient) (range 0.0-1.0) [0.900]
 --ancient-damage STR               Path to damage matrix (ancient) []
 --unsafe BOOL                      Maximize the contig length, but higher misassembly rate (ancient)  [0]
 --min-cov-safe INT                 Minimum coverage of extending region (ancient) [5]
 --db-mode BOOL                     Input is database [0]
 --min-ryseq-id FLOAT               List matches above this sequence identity in RY-mer space (ancient) (range 0.0-1.0) [0.990]
 --k-ancient-reads INT              k-mer length read step (ancient) [20]
 --k-ancient-contigs INT            k-mer length contig step (ancient) [22]

references:
 - Kraft, L., Söding, J., Steinegger, M., Jochheim, A., Sackett, P. W., Fernandez-Guerra, A., & Renaud, G. (2024). CarpeDeam: A De Novo Metagenome Assembler for Heavily Damaged Ancient Datasets. Cold Spring Harbor Laboratory.
```


## carpedeam_nuclassemble

### Tool Description
By Louis Kraft <lokraf@dtu.dk> and Annika Jochheim <annika.jochheim@mpinat.mpg.de>

### Metadata
- **Docker Image**: quay.io/biocontainers/carpedeam:1.0.1--hd6d6fdc_0
- **Homepage**: https://github.com/LouisPwr/CarpeDeam
- **Package**: https://anaconda.org/channels/bioconda/packages/carpedeam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: carpedeam nuclassemble <i:fast(a|q)File[.gz]> | <i:fastqFile1_1[.gz] <i:fastqFile1_2[.gz] ... <i:fastqFileN_1[.gz] <i:fastqFileN_2[.gz]> <o:fastaFile> <tmpDir> [options]
 By Louis Kraft <lokraf@dtu.dk> and Annika Jochheim <annika.jochheim@mpinat.mpg.de>
options: prefilter:                        
 --alph-size TWIN                   Alphabet size (range 2-21) [5]
 --spaced-kmer-mode INT             0: use consecutive positions in k-mers; 1: use spaced k-mers [0]
 --spaced-kmer-pattern STR          User-specified spaced k-mer pattern []
 --mask INT                         Mask sequences in k-mer stage: 0: w/o low complexity masking, 1: with low complexity masking [0]
 --mask-lower-case INT              Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
 -k INT                             k-mer length (0: automatically set to optimum) [22]
 --split-memory-limit BYTE          Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
 --add-self-matches BOOL            Artificially add entries of queries with themselves (for clustering) [0]
align:                            
 --min-seq-id FLOAT                 Overlap sequence identity threshold (range 0.0-1.0) [0.900]
 --cov-mode INT                     0: coverage of query and target
                                    1: coverage of target
                                    2: coverage of query
                                    3: target seq. length has to be at least x% of query length
                                    4: query seq. length has to be at least x% of target length
                                    5: short seq. needs to be at least x% of the other seq. length [0]
 -c FLOAT                           List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --wrapped-scoring BOOL             Double the (nucleotide) query sequence during the scoring process to allow wrapped diagonal scoring around end and start [0]
 -e DOUBLE                          Extend sequences if the E-value is below (range 0.0-inf) [1.000E-03]
 -a BOOL                            Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --min-aln-len INT                  Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT                  0: alignment length 1: shorter, 2: longer sequence [0]
kmermatcher:                      
 --kmer-per-seq INT                 k-mers per sequence [200]
 --kmer-per-seq-scale TWIN          Scale k-mer per sequence based on sequence length as kmer-per-seq val + scale x seqlen [0.200]
 --adjust-kmer-len BOOL             Adjust k-mer length based on specificity (only for nucleotides) [0]
 --hash-shift INT                   Shift k-mer hash initialization [67]
 --include-only-extendable BOOL     Include only extendable [0]
 --ignore-multi-kmer BOOL           Skip k-mers occurring multiple times (>=2) [1]
profile:                          
 --num-iterations INT               Number of assembly iterations (range 1-inf) [10]
misc:                             
 --dbtype INT                       Database type 0: auto, 1: amino acid 2: nucleotides [0]
 --shuffle BOOL                     Shuffle input database [1]
 --createdb-mode INT                Createdb mode 0: copy data, 1: soft link data and write new index (works only with single line fasta/q) [0]
 --id-offset INT                    Numeric ids in index file are offset by this value [0]
 --rescore-mode INT                 Rescore diagonals with:
                                    0: Hamming distance
                                    1: local alignment (score only)
                                    2: local alignment
                                    3: global alignment
                                    4: longest alignment fulfilling window quality criterion [3]
 --keep-target BOOL                 Keep target sequences [1]
 --chop-cycle BOOL                  Remove superfluous part of circular fragments (see --cycle-check) [1]
 --cycle-check BOOL                 Check for circular sequences (avoid over extension of circular or long repeated regions)  [1]
 --min-contig-len INT               Minimum length of assembled contig to output [500]
 --contig-output-mode INT           Type of contigs:
                                    0: all
                                    1: only extended [1]
 --num-iter-reads-only INT          Raw reads only: Number of assembly iterations performed on nucleotide level (ancient) [4]
common:                           
 --compressed INT                   Write compressed output [0]
 -v INT                             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --sub-mat TWIN                     Substitution matrix file [nucl:nucleotide.out,aa:blosum62.out]
 --max-seq-len INT                  Maximum sequence length [300000]
 --threads INT                      Number of CPU-cores used (all by default) [20]
 --db-load-mode INT                 Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --remove-tmp-files BOOL            Delete temporary files [0]
 --delete-tmp-inc INT               Delete temporary files incremental [0,1] [1]
 --mpi-runner STR                   Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42") []
expert:                           
 --write-lookup INT                 write .lookup file containing mapping from internal id, fasta id and file number [1]
 --filter-hits BOOL                 Filter hits by seq.id. and coverage [0]
 --sort-results INT                 Sort results: 0: no sorting, 1: sort by E-value (Alignment) or seq.id. (Hamming) [0]
 --ext-random-align FLOAT           Use either: 0.8 or 0.9 (ancient) [0.850]
 --excess-penalty FLOAT             Use float: 0.25 to 0.5 (ancient) [0.062]
 --min-ryseq-id-corr-reads FLOAT    Min. RY-mer space seq. ident in correction phase. Range 0-1 (ancient) [0.990]
 --min-seqid-corr-reads FLOAT       Min. seq. ident. in correction phase. Range 0-1 (ancient) [0.900]
 --likelihood-ratio-threshold FLOAT  Min. odds ratio to accept read extension. Range 0-1 (ancient) [0.500]
 --min-merge-seq-id FLOAT           Min. seq. ident. of contig overlaps (ancient) (range 0.0-1.0) [0.990]
 --min-seqid-corr-contigs FLOAT     Min. seq. ident. for contig correction (ancient) (range 0.0-1.0) [0.900]
 --ancient-damage STR               Path to damage matrix (ancient) []
 --unsafe BOOL                      Maximize the contig length, but higher misassembly rate (ancient)  [0]
 --min-cov-safe INT                 Minimum coverage of extending region (ancient) [5]
 --db-mode BOOL                     Input is database [0]
 --min-ryseq-id FLOAT               List matches above this sequence identity in RY-mer space (ancient) (range 0.0-1.0) [0.990]
 --k-ancient-reads INT              k-mer length read step (ancient) [20]
 --k-ancient-contigs INT            k-mer length contig step (ancient) [22]

references:
 - Steinegger M, Mirdita M, Soding J: Protein-level assembly increases protein sequence recovery from metagenomic samples manyfold. Nature Methods, 16(7), 603-606 (2019)
```


## carpedeam_ancient_correction

### Tool Description
By Louis Kraft <lokraf@dtu.dk>

### Metadata
- **Docker Image**: quay.io/biocontainers/carpedeam:1.0.1--hd6d6fdc_0
- **Homepage**: https://github.com/LouisPwr/CarpeDeam
- **Package**: https://anaconda.org/channels/bioconda/packages/carpedeam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: carpedeam ancient_correction <i:sequenceDB> <i:alnResult> <o:reprSeqDB> [options]
 By Louis Kraft <lokraf@dtu.dk>
options: align:                            
 --min-seq-id FLOAT                 List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]
misc:                             
 --keep-target BOOL                 Keep target sequences [1]
 --rescore-mode INT                 Rescore diagonals with:
                                    0: Hamming distance
                                    1: local alignment (score only)
                                    2: local alignment
                                    3: global alignment
                                    4: longest alignment fulfilling window quality criterion [0]
common:                           
 --max-seq-len INT                  Maximum sequence length [65535]
 --threads INT                      Number of CPU-cores used (all by default) [20]
 -v INT                             Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
expert:                           
 --ext-random-align FLOAT           Use either: 0.8 or 0.9 (ancient) [0.850]
 --excess-penalty FLOAT             Use float: 0.25 to 0.5 (ancient) [0.062]
 --min-ryseq-id-corr-reads FLOAT    Min. RY-mer space seq. ident in correction phase. Range 0-1 (ancient) [0.990]
 --min-seqid-corr-reads FLOAT       Min. seq. ident. in correction phase. Range 0-1 (ancient) [0.900]
 --likelihood-ratio-threshold FLOAT  Min. odds ratio to accept read extension. Range 0-1 (ancient) [0.500]
 --min-merge-seq-id FLOAT           Min. seq. ident. of contig overlaps (ancient) (range 0.0-1.0) [0.990]
 --min-seqid-corr-contigs FLOAT     Min. seq. ident. for contig correction (ancient) (range 0.0-1.0) [0.900]
 --ancient-damage STR               Path to damage matrix (ancient) []
 --unsafe BOOL                      Maximize the contig length, but higher misassembly rate (ancient)  [0]
 --min-cov-safe INT                 Minimum coverage of extending region (ancient) [5]

references:
 - Kraft, L., Söding, J., Steinegger, M., Jochheim, A., Sackett, P. W., Fernandez-Guerra, A., & Renaud, G. (2024). CarpeDeam: A De Novo Metagenome Assembler for Heavily Damaged Ancient Datasets. Cold Spring Harbor Laboratory.
```

