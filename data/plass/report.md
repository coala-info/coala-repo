# plass CWL Generation Report

## plass_assemble

### Tool Description
Protein-level assembly of metagenomic samples

### Metadata
- **Docker Image**: quay.io/biocontainers/plass:5.cf8933--hd6d6fdc_3
- **Homepage**: https://github.com/soedinglab/plass
- **Package**: https://anaconda.org/channels/bioconda/packages/plass/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/plass/overview
- **Total Downloads**: 19.0K
- **Last updated**: 2025-07-27
- **GitHub**: https://github.com/soedinglab/plass
- **Stars**: N/A
### Original Help Text
```text
usage: plass assemble <i:fast(a|q)File[.gz]> | <i:fastqFile1_1[.gz] <i:fastqFile1_2[.gz] ... <i:fastqFileN_1[.gz] <i:fastqFileN_2[.gz]> <o:fastaFile> <tmpDir> [options]
 By Martin Steinegger <martin.steinegger@mpibpc.mpg.de> 
options: prefilter:                      
 --alph-size TWIN                 Alphabet size (range 2-21) [13]
 --spaced-kmer-mode INT           0: use consecutive positions in k-mers; 1: use spaced k-mers [0]
 --spaced-kmer-pattern STR        User-specified spaced k-mer pattern []
 --mask INT                       Mask sequences in k-mer stage: 0: w/o low complexity masking, 1: with low complexity masking [0]
 --mask-lower-case INT            Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]
 -k INT                           k-mer length (0: automatically set to optimum) [14]
 --split-memory-limit BYTE        Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]
 --add-self-matches BOOL          Artificially add entries of queries with themselves (for clustering) [0]
align:                          
 --min-seq-id FLOAT               Overlap sequence identity threshold [0.0, 1.0] [0.900]
 --cov-mode INT                   0: coverage of query and target
                                  1: coverage of target
                                  2: coverage of query
                                  3: target seq. length has to be at least x% of query length
                                  4: query seq. length has to be at least x% of target length
                                  5: short seq. needs to be at least x% of the other seq. length [0]
 -c FLOAT                         List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]
 --wrapped-scoring BOOL           Double the (nucleotide) query sequence during the scoring process to allow wrapped diagonal scoring around end and start [0]
 -e DOUBLE                        Extend sequences if the E-value is below [0.0, inf] [1.000E-05]
 -a BOOL                          Add backtrace string (convert to alignments with mmseqs convertalis module) [0]
 --min-aln-len INT                Minimum alignment length (range 0-INT_MAX) [0]
 --seq-id-mode INT                0: alignment length 1: shorter, 2: longer sequence [0]
kmermatcher:                    
 --kmer-per-seq INT               k-mers per sequence [60]
 --kmer-per-seq-scale TWIN        Scale k-mer per sequence based on sequence length as kmer-per-seq val + scale x seqlen [nucl:0.200,aa:0.000]
 --adjust-kmer-len BOOL           Adjust k-mer length based on specificity (only for nucleotides) [0]
 --hash-shift INT                 Shift k-mer hash initialization [67]
 --include-only-extendable BOOL   Include only extendable [1]
 --ignore-multi-kmer BOOL         Skip k-mers occurring multiple times (>=2) [1]
profile:                        
 --num-iterations INT             Number of assembly iterations [1, inf] [12]
misc:                           
 --dbtype INT                     Database type 0: auto, 1: amino acid 2: nucleotides [0]
 --shuffle BOOL                   Shuffle input database [1]
 --createdb-mode INT              Createdb mode 0: copy data, 1: soft link data and write new index (works only with single line fasta/q) [0]
 --id-offset INT                  Numeric ids in index file are offset by this value [0]
 --rescore-mode INT               Rescore diagonals with:
                                  0: Hamming distance
                                  1: local alignment (score only)
                                  2: local alignment
                                  3: global alignment
                                  4: longest alignment fulfilling window quality criterion [3]
 --min-length INT                 Minimum codon number in open reading frames [45]
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
 --keep-target BOOL               Keep target sequences [1]
 --protein-filter-threshold FLOAT filter proteins lower than threshold [0.0,1.0] [0.200]
 --filter-proteins INT            filter proteins by a neural network [0,1] [1]
common:                         
 --compressed INT                 Write compressed output [0]
 -v INT                           Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --sub-mat TWIN                   Substitution matrix file [nucl:nucleotide.out,aa:blosum62.out]
 --max-seq-len INT                Maximum sequence length [65535]
 --threads INT                    Number of CPU-cores used (all by default) [40]
 --db-load-mode INT               Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --delete-tmp-inc INT             Delete temporary files incremental [0,1] [1]
 --remove-tmp-files BOOL          Delete temporary files [0]
 --mpi-runner STR                 Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42") []
expert:                         
 --write-lookup INT               write .lookup file containing mapping from internal id, fasta id and file number [1]
 --filter-hits BOOL               Filter hits by seq.id. and coverage [0]
 --sort-results INT               Sort results: 0: no sorting, 1: sort by E-value (Alignment) or seq.id. (Hamming) [0]
 --create-lookup INT              Create database lookup file (can be very large) [0]

references:
 - Steinegger M, Mirdita M, Soding J: Protein-level assembly increases protein sequence recovery from metagenomic samples manyfold. Nature Methods, 16(7), 603-606 (2019)
```


## Metadata
- **Skill**: generated

## plass_penguin

### Tool Description
protein-guided nucleotide assembler. Assemble nucleotide sequences by iterative greedy overlap assembly using protein and nucleotide information.

### Metadata
- **Docker Image**: quay.io/biocontainers/plass:5.cf8933--hd6d6fdc_3
- **Homepage**: https://github.com/soedinglab/plass
- **Package**: https://anaconda.org/channels/bioconda/packages/plass/overview
- **Validation**: PASS
### Original Help Text
```text
protein-guided nucleotide assembler.

PenguiN Version: 5.cf8933
© Annika Jochheim (annika.jochheim@mpinat.mpg.de)

usage: penguin <command> [<args>]

Main workflows for database input/output
  guided_nuclassemble	Assemble nucleotide sequences by iterative greedy overlap assembly using protein and nucleotide information
  nuclassemble      	Assemble nucleotide sequences by iterative greedy overlap assembly using nucleotide information only


Invalid Command: -help
Did you mean "/usr/local/bin/penguin easy-search"?
```

