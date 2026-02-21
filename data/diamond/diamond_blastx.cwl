cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - diamond
  - blastx
label: diamond_blastx
doc: "DIAMOND is a sequence aligner for protein and translated DNA searches. The blastx
  command aligns translated DNA queries against a protein reference database.\n\n\
  Tool homepage: https://github.com/bbuchfink/diamond"
inputs:
  - id: alfmt
    type:
      - 'null'
      - string
    doc: format of aligned query file (fasta/fastq)
    inputBinding:
      position: 101
      prefix: --alfmt
  - id: algo
    type:
      - 'null'
      - string
    doc: Seed search algorithm 
      (0=double-indexed/1=query-indexed/ctg=contiguous-seed)
    inputBinding:
      position: 101
      prefix: --algo
  - id: anchored_swipe
    type:
      - 'null'
      - boolean
    doc: Enable anchored SWIPE extension
    inputBinding:
      position: 101
      prefix: --anchored-swipe
  - id: approx_id
    type:
      - 'null'
      - float
    doc: minimum approx. identity% to report an alignment/to cluster sequences
    inputBinding:
      position: 101
      prefix: --approx-id
  - id: band
    type:
      - 'null'
      - int
    doc: band for dynamic programming computation
    inputBinding:
      position: 101
      prefix: --band
  - id: bin
    type:
      - 'null'
      - int
    doc: number of query bins for seed search
    inputBinding:
      position: 101
      prefix: --bin
  - id: block_size
    type:
      - 'null'
      - float
    doc: sequence block size in billions of letters
    default: 2.0
    inputBinding:
      position: 101
      prefix: --block-size
  - id: cbs_angle
    type:
      - 'null'
      - float
    doc: Matrix adjust threshold
    inputBinding:
      position: 101
      prefix: --cbs-angle
  - id: comp_based_stats
    type:
      - 'null'
      - int
    doc: composition based statistics mode (0-4)
    inputBinding:
      position: 101
      prefix: --comp-based-stats
  - id: compress
    type:
      - 'null'
      - int
    doc: compression for output files (0=none, 1=gzip, zstd)
    inputBinding:
      position: 101
      prefix: --compress
  - id: culling_overlap
    type:
      - 'null'
      - string
    doc: minimum range overlap with higher scoring hit to delete a hit
    default: 50%
    inputBinding:
      position: 101
      prefix: --culling-overlap
  - id: custom_matrix
    type:
      - 'null'
      - File
    doc: file containing custom scoring matrix
    inputBinding:
      position: 101
      prefix: --custom-matrix
  - id: daa
    type:
      - 'null'
      - File
    doc: DIAMOND alignment archive (DAA) file
    inputBinding:
      position: 101
      prefix: --daa
  - id: db
    type:
      - 'null'
      - File
    doc: database file
    inputBinding:
      position: 101
      prefix: --db
  - id: dbsize
    type:
      - 'null'
      - int
    doc: effective database size (in letters)
    inputBinding:
      position: 101
      prefix: --dbsize
  - id: evalue
    type:
      - 'null'
      - float
    doc: maximum e-value to report alignments
    default: 0.001
    inputBinding:
      position: 101
      prefix: --evalue
  - id: ext
    type:
      - 'null'
      - string
    doc: Extension mode (banded-fast/banded-slow/full)
    inputBinding:
      position: 101
      prefix: --ext
  - id: ext_chunk_size
    type:
      - 'null'
      - string
    doc: chunk size for adaptive ranking (default=auto)
    inputBinding:
      position: 101
      prefix: --ext-chunk-size
  - id: fast
    type:
      - 'null'
      - boolean
    doc: enable fast mode
    inputBinding:
      position: 101
      prefix: --fast
  - id: faster
    type:
      - 'null'
      - boolean
    doc: enable faster mode
    inputBinding:
      position: 101
      prefix: --faster
  - id: file_buffer_size
    type:
      - 'null'
      - int
    doc: file buffer size in bytes
    default: 67108864
    inputBinding:
      position: 101
      prefix: --file-buffer-size
  - id: frameshift
    type:
      - 'null'
      - float
    doc: frame shift penalty (default=disabled)
    inputBinding:
      position: 101
      prefix: --frameshift
  - id: freq_masking
    type:
      - 'null'
      - boolean
    doc: mask seeds based on frequency
    inputBinding:
      position: 101
      prefix: --freq-masking
  - id: freq_sd
    type:
      - 'null'
      - float
    doc: number of standard deviations for ignoring frequent seeds
    inputBinding:
      position: 101
      prefix: --freq-sd
  - id: gapextend
    type:
      - 'null'
      - int
    doc: gap extension penalty
    inputBinding:
      position: 101
      prefix: --gapextend
  - id: gapopen
    type:
      - 'null'
      - int
    doc: gap open penalty
    inputBinding:
      position: 101
      prefix: --gapopen
  - id: gapped_filter_evalue
    type:
      - 'null'
      - string
    doc: E-value threshold for gapped filter (auto)
    inputBinding:
      position: 101
      prefix: --gapped-filter-evalue
  - id: gapped_xdrop
    type:
      - 'null'
      - float
    doc: xdrop for gapped alignment in bits
    inputBinding:
      position: 101
      prefix: --gapped-xdrop
  - id: global_ranking
    type:
      - 'null'
      - int
    doc: number of targets for global ranking
    inputBinding:
      position: 101
      prefix: --global-ranking
  - id: header
    type:
      - 'null'
      - string
    doc: Use header lines in tabular output format (0/simple/verbose).
    inputBinding:
      position: 101
      prefix: --header
  - id: hit_band
    type:
      - 'null'
      - int
    doc: band for hit verification
    inputBinding:
      position: 101
      prefix: --hit-band
  - id: hit_membuf
    type:
      - 'null'
      - int
    doc: Buffer intermediate hits in memory (0=default/1)
    inputBinding:
      position: 101
      prefix: --hit-membuf
  - id: hit_score
    type:
      - 'null'
      - int
    doc: minimum score to keep a tentative alignment
    inputBinding:
      position: 101
      prefix: --hit-score
  - id: id
    type:
      - 'null'
      - float
    doc: minimum identity% to report an alignment
    inputBinding:
      position: 101
      prefix: --id
  - id: id2
    type:
      - 'null'
      - int
    doc: minimum number of identities for stage 1 hit
    inputBinding:
      position: 101
      prefix: --id2
  - id: ignore_warnings
    type:
      - 'null'
      - boolean
    doc: Ignore warnings
    inputBinding:
      position: 101
      prefix: --ignore-warnings
  - id: include_lineage
    type:
      - 'null'
      - boolean
    doc: Include lineage in the taxonomic classification format
    inputBinding:
      position: 101
      prefix: --include-lineage
  - id: index_chunks
    type:
      - 'null'
      - int
    doc: number of chunks for index processing
    default: 4
    inputBinding:
      position: 101
      prefix: --index-chunks
  - id: iterate
    type:
      - 'null'
      - boolean
    doc: iterated search with increasing sensitivity
    inputBinding:
      position: 101
      prefix: --iterate
  - id: k_parameter
    type:
      - 'null'
      - float
    doc: K parameter for custom matrix
    inputBinding:
      position: 101
      prefix: -K
  - id: lambda
    type:
      - 'null'
      - float
    doc: lambda parameter for custom matrix
    inputBinding:
      position: 101
      prefix: --lambda
  - id: length_ratio_threshold
    type:
      - 'null'
      - float
    doc: Matrix adjust threshold
    inputBinding:
      position: 101
      prefix: --length-ratio-threshold
  - id: lin_stage1
    type:
      - 'null'
      - boolean
    doc: only consider seed hits against longest query for identical seeds
    inputBinding:
      position: 101
      prefix: --lin-stage1
  - id: linclust_20
    type:
      - 'null'
      - boolean
    doc: enable mode for linear search at 20% identity
    inputBinding:
      position: 101
      prefix: --linclust-20
  - id: linclust_banded_ext
    type:
      - 'null'
      - boolean
    doc: Use banded instead of full matrix DP for linear searches
    inputBinding:
      position: 101
      prefix: --linclust-banded-ext
  - id: linsearch
    type:
      - 'null'
      - boolean
    doc: only consider seed hits against longest target for identical seeds
    inputBinding:
      position: 101
      prefix: --linsearch
  - id: load_threads
    type:
      - 'null'
      - int
    doc: number of CPU threads for file I/O
    inputBinding:
      position: 101
      prefix: --load-threads
  - id: log
    type:
      - 'null'
      - boolean
    doc: enable debug log
    inputBinding:
      position: 101
      prefix: --log
  - id: long_reads
    type:
      - 'null'
      - boolean
    doc: short for --range-culling --top 10 -F 15
    inputBinding:
      position: 101
      prefix: --long-reads
  - id: masking
    type:
      - 'null'
      - string
    doc: masking algorithm (none, seg, tantan=default)
    inputBinding:
      position: 101
      prefix: --masking
  - id: matrix
    type:
      - 'null'
      - string
    doc: score matrix for protein alignment
    default: BLOSUM62
    inputBinding:
      position: 101
      prefix: --matrix
  - id: max_hsps
    type:
      - 'null'
      - int
    doc: maximum number of HSPs per target sequence to report for each query
    default: 1
    inputBinding:
      position: 101
      prefix: --max-hsps
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: maximum number of target sequences to report alignments for
    default: 25
    inputBinding:
      position: 101
      prefix: --max-target-seqs
  - id: mid_sensitive
    type:
      - 'null'
      - boolean
    doc: enable mid-sensitive mode
    inputBinding:
      position: 101
      prefix: --mid-sensitive
  - id: min_orf
    type:
      - 'null'
      - int
    doc: ignore translated sequences without an open reading frame of at least 
      this length
    inputBinding:
      position: 101
      prefix: --min-orf
  - id: min_query_len
    type:
      - 'null'
      - int
    doc: filter query sequences shorter than this length
    inputBinding:
      position: 101
      prefix: --min-query-len
  - id: min_score
    type:
      - 'null'
      - float
    doc: minimum bit score to report alignments (overrides e-value setting)
    inputBinding:
      position: 101
      prefix: --min-score
  - id: minichunk
    type:
      - 'null'
      - int
    doc: Mini chunk size for file I/O
    inputBinding:
      position: 101
      prefix: --minichunk
  - id: more_sensitive
    type:
      - 'null'
      - boolean
    doc: enable more sensitive mode
    inputBinding:
      position: 101
      prefix: --more-sensitive
  - id: motif_masking
    type:
      - 'null'
      - int
    doc: softmask abundant motifs (0/1)
    inputBinding:
      position: 101
      prefix: --motif-masking
  - id: mp_init
    type:
      - 'null'
      - boolean
    doc: initialize multiprocessing run
    inputBinding:
      position: 101
      prefix: --mp-init
  - id: mp_query_chunk
    type:
      - 'null'
      - int
    doc: process only a single query chunk as specified
    inputBinding:
      position: 101
      prefix: --mp-query-chunk
  - id: mp_recover
    type:
      - 'null'
      - boolean
    doc: enable continuation of interrupted multiprocessing run
    inputBinding:
      position: 101
      prefix: --mp-recover
  - id: multiprocessing
    type:
      - 'null'
      - boolean
    doc: enable distributed-memory parallel processing
    inputBinding:
      position: 101
      prefix: --multiprocessing
  - id: no_auto_append
    type:
      - 'null'
      - boolean
    doc: disable auto appending of DAA and DMND file extensions
    inputBinding:
      position: 101
      prefix: --no-auto-append
  - id: no_parse_seqids
    type:
      - 'null'
      - boolean
    doc: Print raw seqids without parsing
    inputBinding:
      position: 101
      prefix: --no-parse-seqids
  - id: no_ranking
    type:
      - 'null'
      - boolean
    doc: disable ranking heuristic
    inputBinding:
      position: 101
      prefix: --no-ranking
  - id: no_self_hits
    type:
      - 'null'
      - boolean
    doc: suppress reporting of identical self hits
    inputBinding:
      position: 101
      prefix: --no-self-hits
  - id: no_unlink
    type:
      - 'null'
      - boolean
    doc: Do not unlink temporary files.
    inputBinding:
      position: 101
      prefix: --no-unlink
  - id: oid_output
    type:
      - 'null'
      - boolean
    doc: Output OIDs instead of accessions (clustering)
    inputBinding:
      position: 101
      prefix: --oid-output
  - id: outfmt
    type:
      - 'null'
      - type: array
        items: string
    doc: output format and optional space-separated list of keywords
    inputBinding:
      position: 101
      prefix: --outfmt
  - id: parallel_tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files used by multiprocessing
    inputBinding:
      position: 101
      prefix: --parallel-tmpdir
  - id: query
    type:
      - 'null'
      - File
    doc: input query file
    inputBinding:
      position: 101
      prefix: --query
  - id: query_cover
    type:
      - 'null'
      - float
    doc: minimum query cover% to report an alignment
    inputBinding:
      position: 101
      prefix: --query-cover
  - id: query_gencode
    type:
      - 'null'
      - int
    doc: genetic code to use to translate query
    inputBinding:
      position: 101
      prefix: --query-gencode
  - id: query_match_distance_threshold
    type:
      - 'null'
      - float
    doc: Matrix adjust threshold
    inputBinding:
      position: 101
      prefix: --query-match-distance-threshold
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: disable console output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: range_cover
    type:
      - 'null'
      - string
    doc: percentage of query range to be covered for range culling
    default: 50%
    inputBinding:
      position: 101
      prefix: --range-cover
  - id: range_culling
    type:
      - 'null'
      - boolean
    doc: restrict hit culling to overlapping query ranges
    inputBinding:
      position: 101
      prefix: --range-culling
  - id: rank_ratio
    type:
      - 'null'
      - float
    doc: include subjects within this ratio of last hit
    inputBinding:
      position: 101
      prefix: --rank-ratio
  - id: rank_ratio2
    type:
      - 'null'
      - float
    doc: include subjects within this ratio of last hit (stage 2)
    inputBinding:
      position: 101
      prefix: --rank-ratio2
  - id: sallseqid
    type:
      - 'null'
      - boolean
    doc: include all subject ids in DAA file
    inputBinding:
      position: 101
      prefix: --sallseqid
  - id: salltitles
    type:
      - 'null'
      - boolean
    doc: include full subject titles in DAA file
    inputBinding:
      position: 101
      prefix: --salltitles
  - id: sam_query_len
    type:
      - 'null'
      - boolean
    doc: add the query length to the SAM format (tag ZQ)
    inputBinding:
      position: 101
      prefix: --sam-query-len
  - id: seed_cut
    type:
      - 'null'
      - float
    doc: cutoff for seed complexity
    inputBinding:
      position: 101
      prefix: --seed-cut
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: enable sensitive mode
    inputBinding:
      position: 101
      prefix: --sensitive
  - id: seqidlist
    type:
      - 'null'
      - File
    doc: filter the database by list of accessions
    inputBinding:
      position: 101
      prefix: --seqidlist
  - id: shape_mask
    type:
      - 'null'
      - string
    doc: seed shapes
    inputBinding:
      position: 101
      prefix: --shape-mask
  - id: shapes
    type:
      - 'null'
      - int
    doc: number of seed shapes (default=all available)
    inputBinding:
      position: 101
      prefix: --shapes
  - id: shapes_30x10
    type:
      - 'null'
      - boolean
    doc: enable mode using 30 seed shapes of weight 10
    inputBinding:
      position: 101
      prefix: --shapes-30x10
  - id: shapes_6x10
    type:
      - 'null'
      - boolean
    doc: enable mode using 30 seed shapes of weight 10
    inputBinding:
      position: 101
      prefix: --shapes-6x10
  - id: short_query_ungapped_bitscore
    type:
      - 'null'
      - float
    doc: Bit score threshold for ungapped alignments for short queries
    inputBinding:
      position: 101
      prefix: --short-query-ungapped-bitscore
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: Subsample seeds based on minimizer sketch of the given size
    inputBinding:
      position: 101
      prefix: --sketch-size
  - id: skip_missing_seqids
    type:
      - 'null'
      - boolean
    doc: ignore accessions missing in the database
    inputBinding:
      position: 101
      prefix: --skip-missing-seqids
  - id: soft_masking
    type:
      - 'null'
      - string
    doc: soft masking (none=default, seg, tantan)
    inputBinding:
      position: 101
      prefix: --soft-masking
  - id: stop_match_score
    type:
      - 'null'
      - int
    doc: Set the match score of stop codons against each other.
    inputBinding:
      position: 101
      prefix: --stop-match-score
  - id: strand
    type:
      - 'null'
      - string
    doc: query strands to search (both/minus/plus)
    inputBinding:
      position: 101
      prefix: --strand
  - id: subject_cover
    type:
      - 'null'
      - float
    doc: minimum subject cover% to report an alignment
    inputBinding:
      position: 101
      prefix: --subject-cover
  - id: swipe
    type:
      - 'null'
      - boolean
    doc: exhaustive alignment against all database sequences
    inputBinding:
      position: 101
      prefix: --swipe
  - id: swipe_task_size
    type:
      - 'null'
      - int
    doc: task size for DP parallelism
    default: 100000000
    inputBinding:
      position: 101
      prefix: --swipe-task-size
  - id: tantan_minMaskProb
    type:
      - 'null'
      - float
    doc: minimum repeat probability for masking
    default: 0.9
    inputBinding:
      position: 101
      prefix: --tantan-minMaskProb
  - id: target_indexed
    type:
      - 'null'
      - boolean
    doc: Enable target-indexed mode
    inputBinding:
      position: 101
      prefix: --target-indexed
  - id: taxon_exclude
    type:
      - 'null'
      - string
    doc: exclude list of taxon ids (comma-separated)
    inputBinding:
      position: 101
      prefix: --taxon-exclude
  - id: taxon_k
    type:
      - 'null'
      - int
    doc: maximum number of targets to report per species
    inputBinding:
      position: 101
      prefix: --taxon-k
  - id: taxonlist
    type:
      - 'null'
      - string
    doc: restrict search to list of taxon ids (comma-separated)
    inputBinding:
      position: 101
      prefix: --taxonlist
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPU threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: tile_size
    type:
      - 'null'
      - int
    doc: Loop tiling size
    default: 1024
    inputBinding:
      position: 101
      prefix: --tile-size
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: top
    type:
      - 'null'
      - float
    doc: report alignments within this percentage range of top alignment score 
      (overrides --max-target-seqs)
    inputBinding:
      position: 101
      prefix: --top
  - id: ultra_sensitive
    type:
      - 'null'
      - boolean
    doc: enable ultra sensitive mode
    inputBinding:
      position: 101
      prefix: --ultra-sensitive
  - id: unal
    type:
      - 'null'
      - int
    doc: report unaligned queries (0=no, 1=yes)
    inputBinding:
      position: 101
      prefix: --unal
  - id: unfmt
    type:
      - 'null'
      - string
    doc: format of unaligned query file (fasta/fastq)
    inputBinding:
      position: 101
      prefix: --unfmt
  - id: ungapped_evalue
    type:
      - 'null'
      - string
    doc: E-value threshold for ungapped filter (auto)
    inputBinding:
      position: 101
      prefix: --ungapped-evalue
  - id: ungapped_evalue_short
    type:
      - 'null'
      - string
    doc: E-value threshold for ungapped filter (short reads) (auto)
    inputBinding:
      position: 101
      prefix: --ungapped-evalue-short
  - id: ungapped_score
    type:
      - 'null'
      - int
    doc: minimum alignment score to continue local extension
    inputBinding:
      position: 101
      prefix: --ungapped-score
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose console output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: very_sensitive
    type:
      - 'null'
      - boolean
    doc: enable very sensitive mode
    inputBinding:
      position: 101
      prefix: --very-sensitive
  - id: window
    type:
      - 'null'
      - int
    doc: window size for local hit search
    inputBinding:
      position: 101
      prefix: --window
  - id: xdrop
    type:
      - 'null'
      - int
    doc: xdrop for ungapped alignment
    inputBinding:
      position: 101
      prefix: --xdrop
  - id: xml_blord_format
    type:
      - 'null'
      - boolean
    doc: Use gnl|BL_ORD_ID| style format in XML output
    inputBinding:
      position: 101
      prefix: --xml-blord-format
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.out)
  - id: un
    type:
      - 'null'
      - File
    doc: file for unaligned queries
    outputBinding:
      glob: $(inputs.un)
  - id: al
    type:
      - 'null'
      - File
    doc: file or aligned queries
    outputBinding:
      glob: $(inputs.al)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
