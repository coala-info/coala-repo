cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtdbg2
label: wtdbg_wtdbg2
doc: "De novo assembler for long noisy sequences\n\nTool homepage: https://github.com/ruanjue/wtdbg-1.2.8"
inputs:
  - id: aln_bestn
    type:
      - 'null'
      - int
    doc: 'Use best n hits for each read in build graph, 0: keep all'
    inputBinding:
      position: 101
      prefix: --aln-bestn
  - id: aln_dovetail
    type:
      - 'null'
      - int
    doc: Retain dovetail overlaps only, the max overhang size is 
      <--aln-dovetail>, the value should be times of 256, -1 to disable 
      filtering
    inputBinding:
      position: 101
      prefix: --aln-dovetail
  - id: aln_max_var
    type:
      - 'null'
      - float
    doc: Max length variation of two aligned fragments
    inputBinding:
      position: 101
      prefix: --aln-max-var
  - id: aln_maxhit
    type:
      - 'null'
      - int
    doc: Max n hits for each read in build graph
    inputBinding:
      position: 101
      prefix: --aln-maxhit
  - id: aln_min_length
    type:
      - 'null'
      - int
    doc: Min length of alignment
    inputBinding:
      position: 101
      prefix: --aln-min-length
  - id: aln_min_match
    type:
      - 'null'
      - int
    doc: Min matched length by kmer matching
    inputBinding:
      position: 101
      prefix: --aln-min-match
  - id: aln_min_similarity
    type:
      - 'null'
      - float
    doc: Min similarity, calculated by kmer matched length / aligned length
    inputBinding:
      position: 101
      prefix: --aln-min-similarity
  - id: aln_noskip
    type:
      - 'null'
      - boolean
    doc: Keep contained reads during alignment
    inputBinding:
      position: 101
      prefix: --aln-noskip
  - id: aln_strand
    type:
      - 'null'
      - int
    doc: "1: forward, 2: reverse, 3: both. Please don't change the deault vaule 3,
      unless you exactly know what you are doing"
    inputBinding:
      position: 101
      prefix: --aln-strand
  - id: bin_complexity_cutoff
    type:
      - 'null'
      - int
    doc: Used in filtering BINs. If a BIN has less indexed valid kmers than 
      <--bin-complexity-cutoff 2>, masks it.
    inputBinding:
      position: 101
  - id: bubble_step
    type:
      - 'null'
      - int
    doc: 'Max step to search a bubble, meaning the max step from the starting node
      to the ending node. Default: 40'
    inputBinding:
      position: 101
  - id: ctg_min_length
    type:
      - 'null'
      - int
    doc: Min length of contigs to be output, 5000
    inputBinding:
      position: 101
  - id: ctg_min_nodes
    type:
      - 'null'
      - int
    doc: Min num of nodes in a contig to be ouput, 3
    inputBinding:
      position: 101
  - id: drop_low_cov_edges
    type:
      - 'null'
      - boolean
    doc: Don't attempt to rescue low coverage edges
    inputBinding:
      position: 101
  - id: dump_kbm
    type:
      - 'null'
      - string
    doc: Dump kbm index into file for loaded by `kbm` or `wtdbg`
    inputBinding:
      position: 101
  - id: dump_seqs
    type:
      - 'null'
      - string
    doc: Dump kbm index (only sequences, no k-mer index) into file for loaded by
      `kbm` or `wtdbg`
    inputBinding:
      position: 101
  - id: edge_max_span
    type:
      - 'null'
      - int
    doc: Program will build edges of length no large than 1024
    inputBinding:
      position: 101
  - id: edge_min
    type:
      - 'null'
      - int
    doc: Min read depth of a valid edge
    inputBinding:
      position: 101
      prefix: --edge-min
  - id: err_free_nodes
    type:
      - 'null'
      - boolean
    doc: Select nodes from error-free-sequences only.
    inputBinding:
      position: 101
  - id: err_free_seq
    type:
      - 'null'
      - File
    doc: Select nodes from error-free-sequences only. E.g. you have contigs 
      assembled from NGS-WGS reads, and long noisy reads. You can type 
      '--err-free-seq your_ctg.fa --input your_long_reads.fa --err-free-nodes' 
      to perform assembly somehow act as long-reads scaffolding
    inputBinding:
      position: 101
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Force to overwrite output files
    inputBinding:
      position: 101
      prefix: --force
  - id: genome_size
    type:
      - 'null'
      - string
    doc: Approximate genome size (k/m/g suffix allowed)
    inputBinding:
      position: 101
      prefix: --genome-size
  - id: input_reads
    type:
      type: array
      items: File
    doc: Long reads sequences file (REQUIRED; can be multiple)
    inputBinding:
      position: 101
      prefix: --input
  - id: keep_isolated_nodes
    type:
      - 'null'
      - boolean
    doc: In graph clean, `wtdbg` normally masks isolated (orphaned) nodes
    inputBinding:
      position: 101
  - id: keep_multiple_alignment_parts
    type:
      - 'null'
      - boolean
    doc: By default, wtdbg will keep only the best alignment between two reads 
      after chainning. This option will disable it, and keep multiple
    inputBinding:
      position: 101
  - id: kmer_depth_max
    type:
      - 'null'
      - float
    doc: Filter high frequency kmers, maybe repetitive
    inputBinding:
      position: 101
      prefix: --kmer-depth-max
  - id: kmer_depth_min
    type:
      - 'null'
      - int
    doc: Min kmer frequency
    inputBinding:
      position: 101
      prefix: --kmer-depth-min
  - id: kmer_fsize
    type:
      - 'null'
      - int
    doc: Kmer fsize, 0 <= k <= 23
    inputBinding:
      position: 101
      prefix: --kmer-fsize
  - id: kmer_psize
    type:
      - 'null'
      - int
    doc: Kmer psize, 0 <= p <= 23
    inputBinding:
      position: 101
      prefix: --kmer-psize
  - id: kmer_subsampling
    type:
      - 'null'
      - float
    doc: Subsampling kmers, 1/(<-S>) kmers are indexed
    inputBinding:
      position: 101
      prefix: --kmer-subsampling
  - id: limit_input
    type:
      - 'null'
      - int
    doc: Limit the input sequences to at most <int> M bp. Usually for test
    inputBinding:
      position: 101
  - id: load_alignments
    type:
      - 'null'
      - type: array
        items: File
    doc: "`wtdbg` output reads' alignments into <--prefix>.alignments, program can
      load them to fastly build assembly graph. Or you can offer other source of alignments
      to `wtdbg`. When --load-alignment, will only reading long sequences but skip
      building kbm index"
    inputBinding:
      position: 101
  - id: load_clips
    type:
      - 'null'
      - string
    doc: Combined with --load-nodes. Load reads clips. You can find it in 
      `wtdbg`'s <--prefix>.clps
    inputBinding:
      position: 101
  - id: load_kbm
    type:
      - 'null'
      - string
    doc: Instead of reading sequences and building kbm index, which is 
      time-consumed, loading kbm-index from already dumped file.
    inputBinding:
      position: 101
  - id: load_nodes
    type:
      - 'null'
      - string
    doc: Load dumped nodes from previous execution for fast construct the 
      assembly graph, should be combined with --load-clips. You can find it in 
      `wtdbg`'s <--prefix>.1.nodes
    inputBinding:
      position: 101
  - id: load_seqs
    type:
      - 'null'
      - string
    doc: Similar with --load-kbm, but only use the sequences in kbmidx, and 
      rebuild index in process's RAM.
    inputBinding:
      position: 101
  - id: minimal_output
    type:
      - 'null'
      - boolean
    doc: Will generate as less output files (<--prefix>.*) as it can
    inputBinding:
      position: 101
  - id: no_chainning_clip
    type:
      - 'null'
      - boolean
    doc: Defaultly, performs alignments chainning in read clipping
    inputBinding:
      position: 101
  - id: no_local_graph_analysis
    type:
      - 'null'
      - boolean
    doc: Before building edges, for each node, local-graph-analysis reads all 
      related reads and according nodes, and builds a local graph to judge 
      whether to mask it. The analysis aims to find repetitive nodes
    inputBinding:
      position: 101
  - id: no_read_clip
    type:
      - 'null'
      - boolean
    doc: Defaultly, `wtdbg` clips a input sequence by analyzing its overlaps to 
      remove high error endings, rolling-circle repeats (see PacBio CCS), and 
      chimera. When building edges, clipped region won't contribute. However, 
      `wtdbg` will use them in the final linking of unitigs
    inputBinding:
      position: 101
  - id: no_read_length_sort
    type:
      - 'null'
      - boolean
    doc: Defaultly, `wtdbg` sorts input sequences by length DSC. The order of 
      reads affects the generating of nodes in selecting important intervals
    inputBinding:
      position: 101
  - id: node_drop
    type:
      - 'null'
      - float
    doc: Will discard an node when has more this ratio intervals are conflicted 
      with previous generated node
    inputBinding:
      position: 101
  - id: node_len
    type:
      - 'null'
      - int
    doc: The default value is 1024, which is times of KBM_BIN_SIZE(always equals
      256 bp). It specifies the length of intervals (or call nodes after 
      selecting).
    inputBinding:
      position: 101
  - id: node_matched_bins
    type:
      - 'null'
      - int
    doc: Min matched bins in a node, default:1
    inputBinding:
      position: 101
  - id: node_max
    type:
      - 'null'
      - int
    doc: 'Nodes with too high depth will be regarded as repetitive, and be masked.
      Default: 200, more than 200 reads contain this node'
    inputBinding:
      position: 101
  - id: node_min
    type:
      - 'null'
      - int
    doc: Min depth of an interval to be selected as valid node. Defaultly, this 
      value is automaticly the same with --edge-min.
    inputBinding:
      position: 101
  - id: node_ovl
    type:
      - 'null'
      - int
    doc: Max overlap size between two adjacent intervals in any read. It is used
      in selecting best nodes representing reads in graph
    inputBinding:
      position: 101
  - id: output_prefix
    type: string
    doc: Prefix of output files (REQUIRED)
    inputBinding:
      position: 101
      prefix: --prefix
  - id: presets
    type:
      - 'null'
      - string
    doc: Presets, comma delimited
    inputBinding:
      position: 101
      prefix: --preset
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet
    inputBinding:
      position: 101
      prefix: --quiet
  - id: rdcov_filter
    type:
      - 'null'
      - int
    doc: 'Strategy 0: retaining longest reads. Strategy 1: retaining medain length
      reads.'
    inputBinding:
      position: 101
  - id: rdname_filter
    type:
      - 'null'
      - File
    doc: A file contains lines of reads name to be discarded in loading. If you 
      want to filter reads by yourself, please also set -X 0
    inputBinding:
      position: 101
  - id: rdname_includeonly
    type:
      - 'null'
      - File
    doc: Reverse manner with --rdname-filter
    inputBinding:
      position: 101
  - id: read_depth_cutoff
    type:
      - 'null'
      - float
    doc: Choose the best <float> depth from input reads(effective with -g)
    inputBinding:
      position: 101
      prefix: --rdcov-cutoff
  - id: realign
    type:
      - 'null'
      - boolean
    doc: Enable realignment mode
    inputBinding:
      position: 101
      prefix: --realign
  - id: realn_kmer_psize
    type:
      - 'null'
      - int
    doc: Set kmer-psize in realignment
    inputBinding:
      position: 101
      prefix: --realn-kmer-psize
  - id: realn_kmer_subsampling
    type:
      - 'null'
      - int
    doc: Set kmer-subsampling in realignment
    inputBinding:
      position: 101
      prefix: --realn-kmer-subsampling
  - id: realn_max_var
    type:
      - 'null'
      - float
    doc: Set aln-max-var in realignment
    inputBinding:
      position: 101
      prefix: --realn-max-var
  - id: realn_min_length
    type:
      - 'null'
      - int
    doc: Set aln-min-length in realignment
    inputBinding:
      position: 101
      prefix: --realn-min-length
  - id: realn_min_match
    type:
      - 'null'
      - int
    doc: Set aln-min-match in realignment
    inputBinding:
      position: 101
      prefix: --realn-min-match
  - id: realn_min_similarity
    type:
      - 'null'
      - float
    doc: Set aln-min-similarity in realignment
    inputBinding:
      position: 101
      prefix: --realn-min-similarity
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads, 0 for all cores
    inputBinding:
      position: 101
      prefix: --cpu
  - id: tidy_name
    type:
      - 'null'
      - boolean
    doc: Rename reads into 'S%010d' format. The first read is named as 
      S0000000001
    inputBinding:
      position: 101
  - id: tidy_reads
    type:
      - 'null'
      - int
    doc: Choose the longest subread and drop reads shorter than <int> (5000 
      recommended for PacBio)
    inputBinding:
      position: 101
      prefix: --tidy-reads
  - id: tip_step
    type:
      - 'null'
      - int
    doc: Max step to search a tip, 10
    inputBinding:
      position: 101
  - id: ttr_cutoff_depth
    type:
      - 'null'
      - int
    doc: 'Tiny Tandom Repeat. A node located inside ttr will bring noisy in graph,
      should be masked. The pattern of such nodes is: depth >= <--ttr-cutoff-depth>,
      and none of their edges have depth greater than depth * <--ttr-cutoff-ratio
      0.5>. set --ttr-cutoff-depth 0 to disable ttr masking'
    inputBinding:
      position: 101
  - id: ttr_cutoff_ratio
    type:
      - 'null'
      - float
    doc: 'Tiny Tandom Repeat. A node located inside ttr will bring noisy in graph,
      should be masked. The pattern of such nodes is: depth >= <--ttr-cutoff-depth>,
      and none of their edges have depth greater than depth * <--ttr-cutoff-ratio
      0.5>. set --ttr-cutoff-depth 0 to disable ttr masking'
    inputBinding:
      position: 101
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Verbose (can be multiple)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wtdbg:2.5--h5b5514e_2
stdout: wtdbg_wtdbg2.out
