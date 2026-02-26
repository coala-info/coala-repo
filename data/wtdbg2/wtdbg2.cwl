cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtdbg2
label: wtdbg2
doc: "De novo assembler for long noisy sequences\n\nTool homepage: https://github.com/ruanjue/wtdbg2"
inputs:
  - id: aln_bestn
    type:
      - 'null'
      - int
    doc: 'Use best n hits for each read in build graph, 0: keep all, default: 500'
    default: 500
    inputBinding:
      position: 101
      prefix: --aln-bestn
  - id: aln_dovetail
    type:
      - 'null'
      - int
    doc: 'Retain dovetail overlaps only, the max overhang size is <--aln-dovetail>,
      -1 to disable filtering, default: 256'
    default: 256
    inputBinding:
      position: 101
      prefix: --aln-dovetail
  - id: aln_kmer_sampling
    type:
      - 'null'
      - int
    doc: 'Select no more than n seeds in a query bin, default: 256'
    inputBinding:
      position: 101
      prefix: --aln-kmer-sampling
  - id: aln_max_var
    type:
      - 'null'
      - float
    doc: See -s 0.2
    inputBinding:
      position: 101
      prefix: --aln-max-var
  - id: aln_maxhit
    type:
      - 'null'
      - int
    doc: 'Max n hits for each read in build graph, default: 1000'
    default: 1000
    inputBinding:
      position: 101
      prefix: --aln-maxhit
  - id: aln_min_match
    type:
      - 'null'
      - int
    doc: See -m 200. Here the num of matches counting basepair of the matched 
      kmer's regions
    inputBinding:
      position: 101
      prefix: --aln-min-match
  - id: aln_strand
    type:
      - 'null'
      - int
    doc: "1: forward, 2: reverse, 3: both. Please don't change the deault vaule 3,
      unless you exactly know what you are doing"
    default: 3
    inputBinding:
      position: 101
      prefix: --aln-strand
  - id: bin_complexity_cutoff
    type:
      - 'null'
      - int
    doc: Used in filtering BINs. If a BIN has less indexed valid kmers than 
      <--bin-complexity-cutoff 2>, masks it.
    default: 2
    inputBinding:
      position: 101
      prefix: --bin-complexity-cutoff
  - id: bubble_step
    type:
      - 'null'
      - int
    doc: 'Max step to search a bubble, meaning the max step from the starting node
      to the ending node. Default: 40'
    default: 40
    inputBinding:
      position: 101
      prefix: --bubble-step
  - id: cpu
    type:
      - 'null'
      - int
    doc: 'See -t 0, default: all cores'
    inputBinding:
      position: 101
      prefix: --cpu
  - id: ctg_min_length
    type:
      - 'null'
      - int
    doc: Min length of contigs to be output, 5000
    default: 5000
    inputBinding:
      position: 101
      prefix: --ctg-min-length
  - id: ctg_min_nodes
    type:
      - 'null'
      - int
    doc: Min num of nodes in a contig to be ouput, 3
    default: 3
    inputBinding:
      position: 101
      prefix: --ctg-min-nodes
  - id: dp_max_gap
    type:
      - 'null'
      - int
    doc: See -X 4
    inputBinding:
      position: 101
      prefix: --dp-max-gap
  - id: dp_max_var
    type:
      - 'null'
      - int
    doc: See -Y 4
    inputBinding:
      position: 101
      prefix: --dp-max-var
  - id: dp_penalty_gap
    type:
      - 'null'
      - int
    doc: See -x -7
    inputBinding:
      position: 101
      prefix: --dp-penalty-gap
  - id: dp_penalty_var
    type:
      - 'null'
      - int
    doc: See -y -21
    inputBinding:
      position: 101
      prefix: --dp-penalty-var
  - id: drop_low_cov_edges
    type:
      - 'null'
      - boolean
    doc: Don't attempt to rescue low coverage edges
    inputBinding:
      position: 101
      prefix: --drop-low-cov-edges
  - id: dump_kbm
    type:
      - 'null'
      - string
    doc: Dump kbm index into file for loaded by `kbm` or `wtdbg`
    inputBinding:
      position: 101
      prefix: --dump-kbm
  - id: err_free_nodes
    type:
      - 'null'
      - boolean
    doc: Select nodes from error-free-sequences only. E.g. you have contigs 
      assembled from NGS-WGS reads, and long noisy reads. You can type 
      '--err-free-seq your_ctg.fa --input your_long_reads.fa --err-free-nodes' 
      to perform assembly somehow act as long-reads scaffolding
    inputBinding:
      position: 101
      prefix: --err-free-nodes
  - id: err_free_seq
    type:
      - 'null'
      - type: array
        items: string
    doc: See -I. Error-free sequences will be firstly token for nodes, if 
      --err-free-nodes is specified, only select nodes from those sequences
    inputBinding:
      position: 101
      prefix: --err-free-seq
  - id: error_free_sequences_file
    type:
      - 'null'
      - type: array
        items: string
    doc: Error-free sequences file (can be multiple)
    inputBinding:
      position: 101
      prefix: -I
  - id: filter_high_freq_kmers
    type:
      - 'null'
      - float
    doc: Filter high frequency kmers, maybe repetitive
    default: 1000
    inputBinding:
      position: 101
      prefix: --kmer-depth-max
  - id: filter_low_freq_kmers
    type:
      - 'null'
      - boolean
    doc: Filter low frequency kmers by a 4G-bytes array (max_occ=3 2-bits). 
      Here, -E must greater than 1
    inputBinding:
      position: 101
      prefix: --kmer-depth-min-filter
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Force to overwrite output files
    inputBinding:
      position: 101
      prefix: --force
  - id: input
    type:
      - 'null'
      - type: array
        items: string
    doc: See -i
    inputBinding:
      position: 101
      prefix: --input
  - id: keep_contained_reads
    type:
      - 'null'
      - boolean
    doc: Keep contained reads during alignment
    inputBinding:
      position: 101
      prefix: --aln-noskip
  - id: keep_isolated_nodes
    type:
      - 'null'
      - boolean
    doc: In graph clean, `wtdbg` normally masks isolated (orphaned) nodes
    inputBinding:
      position: 101
      prefix: --keep-isolated-nodes
  - id: kmer_depth_min_filter
    type:
      - 'null'
      - boolean
    doc: See -F
    inputBinding:
      position: 101
      prefix: --kmer-depth-min-filter
  - id: kmer_fsize
    type:
      - 'null'
      - int
    doc: Kmer fsize, 0 <= k <= 25
    default: 0
    inputBinding:
      position: 101
      prefix: --kmer-fsize
  - id: kmer_psize
    type:
      - 'null'
      - int
    doc: Kmer psize, 0 <= p <= 25
    default: 21
    inputBinding:
      position: 101
      prefix: --kmer-psize
  - id: kmer_subsampling
    type:
      - 'null'
      - int
    doc: See -S 1
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
      prefix: --limit-input
  - id: load_alignments
    type:
      - 'null'
      - type: array
        items: string
    doc: "`wtdbg` output reads' alignments into <--prefix>.alignments, program can
      load them to fastly build assembly graph. Or you can offer other source of alignments
      to `wtdbg`. When --load-alignment, will only reading long sequences but skip
      building kbm index. You can type --load-alignments <file> more than once to
      load alignments from many files"
    inputBinding:
      position: 101
      prefix: --load-alignments
  - id: load_clips
    type:
      - 'null'
      - string
    doc: Combined with --load-nodes. Load reads clips. You can find it in 
      `wtdbg`'s <--prefix>.clps
    inputBinding:
      position: 101
      prefix: --load-clips
  - id: load_kbm
    type:
      - 'null'
      - string
    doc: Instead of reading sequences and building kbm index, which is 
      time-consumed, loading kbm-index from already dumped file. Please note 
      that, once kbm-index is mmaped by kbm -R <kbm-index> start, will just get 
      the shared memory in minute time. See `kbm` -R <your_seqs.kbmidx> [start |
      stop]
    inputBinding:
      position: 101
      prefix: --load-kbm
  - id: load_nodes
    type:
      - 'null'
      - string
    doc: Load dumped nodes from previous execution for fast construct the 
      assembly graph, should be combined with --load-clips. You can find it in 
      `wtdbg`'s <--prefix>.1.nodes
    inputBinding:
      position: 101
      prefix: --load-nodes
  - id: long_reads_file
    type:
      type: array
      items: string
    doc: Long reads sequences file (REQUIRED; can be multiple)
    inputBinding:
      position: 101
      prefix: -i
  - id: max_bin_in_deviation
    type:
      - 'null'
      - int
    doc: Max number of bin(256bp) in one deviation
    default: 4
    inputBinding:
      position: 101
      prefix: --dp-max-var
  - id: max_bin_in_gap
    type:
      - 'null'
      - int
    doc: Max number of bin(256bp) in one gap
    default: 4
    inputBinding:
      position: 101
      prefix: --dp-max-gap
  - id: max_length_variation
    type:
      - 'null'
      - float
    doc: Max length variation of two aligned fragments
    default: 0.2
    inputBinding:
      position: 101
      prefix: --aln-max-var
  - id: min_alignment_length
    type:
      - 'null'
      - float
    doc: Min length of alignment
    default: 2048
    inputBinding:
      position: 101
      prefix: --aln-min-length
  - id: min_kmer_frequency
    type:
      - 'null'
      - int
    doc: Min kmer frequency
    default: 2
    inputBinding:
      position: 101
      prefix: --kmer-depth-min
  - id: min_matched_length
    type:
      - 'null'
      - float
    doc: Min matched, counting basepair of the matched kmer's regions
    default: 200
    inputBinding:
      position: 101
      prefix: --aln-min-match
  - id: min_read_depth_edge
    type:
      - 'null'
      - int
    doc: Min read depth of a valid edge
    default: 3
    inputBinding:
      position: 101
      prefix: --edge-min
  - id: min_subread_length
    type:
      - 'null'
      - int
    doc: Choose the longest subread and drop reads shorter than <int> (5000 
      recommended for PacBio)
    default: 0
    inputBinding:
      position: 101
      prefix: --tidy-reads
  - id: minimal_output
    type:
      - 'null'
      - boolean
    doc: Will generate as less output files (<--prefix>.*) as it can
    inputBinding:
      position: 101
      prefix: --minimal-output
  - id: no_chainning_clip
    type:
      - 'null'
      - boolean
    doc: Defaultly, performs alignments chainning in read clipping
    inputBinding:
      position: 101
      prefix: --no-chainning-clip
  - id: no_local_graph_analysis
    type:
      - 'null'
      - boolean
    doc: Before building edges, for each node, local-graph-analysis reads all 
      related reads and according nodes, and builds a local graph to judge 
      whether to mask it. The analysis aims to find repetitive nodes
    inputBinding:
      position: 101
      prefix: --no-local-graph-analysis
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
      prefix: --no-read-clip
  - id: no_read_length_sort
    type:
      - 'null'
      - boolean
    doc: Defaultly, `wtdbg` sorts input sequences by length DSC. The order of 
      reads affects the generating of nodes in selecting important intervals
    inputBinding:
      position: 101
      prefix: --no-read-length-sort
  - id: node_len
    type:
      - 'null'
      - int
    doc: 'The default value is 1024, which is times of KBM_BIN_SIZE(always equals
      256 bp). It specifies the length of intervals (or call nodes after selecting).
      kbm indexs sequences into BINs of 256 bp in size, so that many parameter should
      be times of 256 bp. There are: --node-len, --node-ovl, --aln-min-length, --aln-dovetail
      . Other parameters are counted in BINs, --dp-max-gap, --dp-max-var'
    default: 1024
    inputBinding:
      position: 101
      prefix: --node-len
  - id: node_matched_bins
    type:
      - 'null'
      - int
    doc: Min matched bins in a node, default:1
    default: 1
    inputBinding:
      position: 101
      prefix: --node-matched-bins
  - id: node_max
    type:
      - 'null'
      - int
    doc: 'Nodes with too high depth will be regarded as repetitive, and be masked.
      Default: 200, more than 200 reads contain this node'
    default: 200
    inputBinding:
      position: 101
      prefix: --node-max
  - id: node_min
    type:
      - 'null'
      - int
    doc: Min depth of a intreval to be selected as valid node. Defaultly, this 
      value is automaticly the same with --edge-min.
    inputBinding:
      position: 101
      prefix: --node-min
  - id: node_ovl
    type:
      - 'null'
      - int
    doc: 'Default: 256. Max overlap size between two adjacent intervals in any read.
      It is used in selecting best nodes representing reads in graph'
    default: 256
    inputBinding:
      position: 101
      prefix: --node-ovl
  - id: output_prefix
    type: string
    doc: Prefix of output files (REQUIRED)
    inputBinding:
      position: 101
      prefix: -o
  - id: penalty_bin_deviation
    type:
      - 'null'
      - int
    doc: Penalty for BIN deviation
    default: -21
    inputBinding:
      position: 101
      prefix: --dp-penalty-var
  - id: penalty_bin_gap
    type:
      - 'null'
      - int
    doc: Penalty for BIN gap
    default: -7
    inputBinding:
      position: 101
      prefix: --dp-penalty-gap
  - id: prefix
    type:
      - 'null'
      - string
    doc: See -o
    inputBinding:
      position: 101
      prefix: --prefix
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet
    inputBinding:
      position: 101
      prefix: --quiet
  - id: subsampling_kmers
    type:
      - 'null'
      - int
    doc: Subsampling kmers, 1/(<-S>) kmers are indexed
    default: 4
    inputBinding:
      position: 101
      prefix: --kmer-subsampling
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads, 0 for all cores
    default: 0
    inputBinding:
      position: 101
      prefix: -t
  - id: tip_step
    type:
      - 'null'
      - int
    doc: Max step to search a tip, 10
    default: 10
    inputBinding:
      position: 101
      prefix: --tip-step
  - id: ttr_cutoff_depth
    type:
      - 'null'
      - int
    doc: 'Tiny Tandom Repeat. A node located inside ttr will bring noisy in graph,
      should be masked. The pattern of such nodes is: depth >= <--ttr-cutoff-depth>,
      and none of their edges have depth greater than depth * <--ttr-cutoff-ratio
      0.5>. set --ttr-cutoff-depth 0 to disable ttr masking'
    default: 0
    inputBinding:
      position: 101
      prefix: --ttr-cutoff-depth
  - id: ttr_cutoff_ratio
    type:
      - 'null'
      - float
    doc: 'Tiny Tandom Repeat. A node located inside ttr will bring noisy in graph,
      should be masked. The pattern of such nodes is: depth >= <--ttr-cutoff-depth>,
      and none of their edges have depth greater than depth * <--ttr-cutoff-ratio
      0.5>. set --ttr-cutoff-depth 0 to disable ttr masking'
    default: 0.5
    inputBinding:
      position: 101
      prefix: --ttr-cutoff-ratio
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
    dockerPull: quay.io/biocontainers/wtdbg2:2.0--h470a237_0
stdout: wtdbg2.out
