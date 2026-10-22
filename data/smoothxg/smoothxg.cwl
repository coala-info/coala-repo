cwlVersion: v1.2
class: CommandLineTool
baseCommand: smoothxg
label: smoothxg
doc: "Linearize and smooth a variation graph using partial order alignment (POA).\n\nTool homepage: https://github.com/pangenome/smoothxg"
inputs:
  - id: gfa_in
    type:
      - 'null'
      - File
    doc: "Index the graph in this GFA file"
    inputBinding:
      position: 101
      prefix: --gfa-in
  - id: xg_in
    type:
      - 'null'
      - File
    doc: "Read the xg index from this file"
    inputBinding:
      position: 102
      prefix: --in
  - id: smoothed_in
    type:
      - 'null'
      - File
    doc: "Read GFA from this file"
    inputBinding:
      position: 103
      prefix: --smoothed-in
  - id: no_prep
    type:
      - 'null'
      - boolean
    doc: "Do not prepare the graph for processing (prep is equivalent to odgi chop followed by odgi sort -p sYgs, and is disabled when taking XG input)"
    inputBinding:
      position: 104
      prefix: --no-prep
  - id: base
    type:
      - 'null'
      - string
    default: '.'
    doc: "Use this basename for temporary files during build (default here: ., the working directory; smoothxg otherwise writes them beside the input GFA, which is read-only)"
    inputBinding:
      position: 105
      prefix: --base
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: "Keep temporary files"
    inputBinding:
      position: 106
      prefix: --keep-temp
  - id: chop_to
    type:
      - 'null'
      - int
    doc: "During prep, chop nodes to this length [default: 100]"
    inputBinding:
      position: 107
      prefix: --chop-to
  - id: path_sgd_term_updates
    type:
      - 'null'
      - float
    doc: "Path-guided SGD sort quality parameter (N * sum_path_length updates per iteration) for graph prep [default: 1]"
    inputBinding:
      position: 108
      prefix: --path-sgd-term-updates
  - id: n_haps
    type:
      - 'null'
      - int
    doc: "Number of haplotypes in the GFA"
    inputBinding:
      position: 109
      prefix: --n-haps
  - id: block_weight_max
    type:
      - 'null'
      - string
    doc: "Maximum seed sequence in block (1k = 1K = 1000, 1m = 1M = 10^6, 1g = 1G = 10^9) [default: poa-target-length*n-haps]"
    inputBinding:
      position: 110
      prefix: --block-weight-max
  - id: path_jump_max
    type:
      - 'null'
      - string
    doc: "Maximum path jump to include in block (1k = 1K = 1000, 1m = 1M = 10^6) [default: 100]"
    inputBinding:
      position: 111
      prefix: --path-jump-max
  - id: edge_jump_max
    type:
      - 'null'
      - string
    doc: "Maximum edge jump before breaking (1k = 1K = 1000, 1m = 1M = 10^6) [default: 0 / off]"
    inputBinding:
      position: 112
      prefix: --edge-jump-max
  - id: copy_length_min
    type:
      - 'null'
      - string
    doc: "Minimum repeat length to collapse (1k = 1K = 1000, 1m = 1M = 10^6) [default: 1000]"
    inputBinding:
      position: 113
      prefix: --copy-length-min
  - id: copy_length_max
    type:
      - 'null'
      - string
    doc: "Maximum repeat length to attempt to detect (1k = 1K = 1000, 1m = 1M = 10^6) [default: 20K]"
    inputBinding:
      position: 114
      prefix: --copy-length-max
  - id: block_id_min
    type:
      - 'null'
      - float
    doc: "Minimum edit-based identity to cluster sequences [default: 0.0]"
    inputBinding:
      position: 115
      prefix: --block-id-min
  - id: block_ratio_min
    type:
      - 'null'
      - float
    doc: "Minimum small / large length ratio to cluster in a block [default: 0.0]"
    inputBinding:
      position: 116
      prefix: --block-ratio-min
  - id: min_block_depth_split
    type:
      - 'null'
      - string
    doc: "Minimum (deduplicated) block depth for applying the block split (1k = 1K = 1000) [default: 0, disabled]"
    inputBinding:
      position: 117
      prefix: --min-block-depth-split
  - id: min_block_depth_mash
    type:
      - 'null'
      - string
    doc: "Minimum (deduplicated) block depth for applying the mash-based clustering [default: 12000, 0 to disable it]"
    inputBinding:
      position: 118
      prefix: --min-block-depth-mash
  - id: min_seq_len_mash
    type:
      - 'null'
      - string
    doc: "Minimum sequence length to cluster sequences using mash-distance [default: 200, 0 to disable it]"
    inputBinding:
      position: 119
      prefix: --min-seq-len-mash
  - id: block_est_id_max
    type:
      - 'null'
      - float
    doc: "Minimum mash-based estimated identity to cluster sequences [default: equals to block-id-min]"
    inputBinding:
      position: 120
      prefix: --block-est-id-max
  - id: kmer_size_mash_distance
    type:
      - 'null'
      - int
    doc: "Kmer size to compute the mash distance [default: 17]"
    inputBinding:
      position: 121
      prefix: --kmer-size-mash-distance
  - id: poa_params
    type:
      - 'null'
      - string
    doc: "Score parameters for partial order alignment: match,mismatch,gap1,ext1(,gap2,ext2); if 4 then gaps are affine, if 6 then gaps are convex [default: 1,4,6,2,26,1]"
    inputBinding:
      position: 122
      prefix: --poa-params
  - id: adaptive_poa_params
    type:
      - 'null'
      - boolean
    doc: "Set POA score parameters adaptively by estimating the pairwise similarity between the sequences in the blocks"
    inputBinding:
      position: 123
      prefix: --adaptive-poa-params
  - id: poa_length_targets
    type:
      - 'null'
      - string
    doc: "Target length(s) to put into POA, blocks are split when paths go over this length (1k = 1K = 1000); can be multiple, ',' delimited, for each length one smoothxg iteration is executed [default: 4000]"
    inputBinding:
      position: 124
      prefix: --poa-length-targets
  - id: poa_length_max
    type:
      - 'null'
      - string
    doc: "Maximum sequence length to put into POA, cut sequences over this length [default: 2*poa-length-target = 10k]"
    inputBinding:
      position: 125
      prefix: --poa-length-max
  - id: poa_padding_ratio
    type:
      - 'null'
      - float
    doc: "Flanking sequence length fraction (padding = average sequence length in the block * N) to pad each end of each sequence with during POA [default: 0.001]"
    inputBinding:
      position: 126
      prefix: --poa-padding-ratio
  - id: max_block_depth_adaptive_poa_padding
    type:
      - 'null'
      - string
    doc: "Maximum block depth beyond which a (small) fixed amount of flanking nucleotides is not added [default: 1000, 0 to disable it]"
    inputBinding:
      position: 127
      prefix: --max-block-depth-adaptive-poa-padding
  - id: abpoa
    type:
      - 'null'
      - boolean
    doc: "Run abPOA instead of SPOA for smoothing"
    inputBinding:
      position: 128
      prefix: --abpoa
  - id: change_alignment_mode
    type:
      - 'null'
      - boolean
    doc: "Change the alignment mode to global [default: local]"
    inputBinding:
      position: 129
      prefix: --change-alignment-mode
  - id: ref_paths
    type:
      - 'null'
      - File
    doc: "A file listing (one per line) sequences to preserve as paths in the consensus output graphs"
    inputBinding:
      position: 130
      prefix: --ref-paths
  - id: write_consensus_path_names_path
    type:
      - 'null'
      - string
    doc: "Write the consensus path names to this file"
    inputBinding:
      position: 131
      prefix: --write-consensus-path-names
  - id: consensus_from
    type:
      - 'null'
      - File
    doc: "Do not smooth, just generate the consensus, taking the consensus path names from this file"
    inputBinding:
      position: 132
      prefix: --consensus-from
  - id: consensus_spec
    type:
      - 'null'
      - string
    doc: "Consensus graph specification: write the consensus graph to BASENAME.cons_[spec].gfa; BASENAME[,min_len[:refs[:(y|n)[:min_cov[:max_len]]]]]*"
    inputBinding:
      position: 133
      prefix: --consensus-spec
  - id: consensus_prefix
    type:
      - 'null'
      - string
    doc: "Prepend the consensus path names with PREFIX [default: Consensus]"
    inputBinding:
      position: 134
      prefix: --consensus-prefix
  - id: vanish_consensus
    type:
      - 'null'
      - boolean
    doc: "Remove the consensus paths from the emitted graph"
    inputBinding:
      position: 135
      prefix: --vanish-consensus
  - id: write_maf
    type:
      - 'null'
      - string
    doc: "Write the multiple sequence alignments (MSAs) in MAF format in this file"
    inputBinding:
      position: 136
      prefix: --write-msa-in-maf-format
  - id: merge_blocks
    type:
      - 'null'
      - boolean
    doc: "Merge contiguous MAF blocks in the MAF output and consensus sequences in the smoothed graph"
    inputBinding:
      position: 137
      prefix: --merge-blocks
  - id: preserve_unmerged_consensus
    type:
      - 'null'
      - boolean
    doc: "Do not delete original consensus sequences in the merged MAF blocks and in the smoothed graph"
    inputBinding:
      position: 138
      prefix: --preserve-unmerged-consensus
  - id: contiguous_path_jaccard
    type:
      - 'null'
      - float
    doc: "Minimum fraction of paths that have to be contiguous for merging MAF blocks and consensus sequences [default: 1.0]"
    inputBinding:
      position: 139
      prefix: --contiguous-path-jaccard
  - id: max_block_groups_in_memory
    type:
      - 'null'
      - int
    doc: "Increasing this value, many more blocks that are not immediately contiguous along the graph will be merged [default: 50]"
    inputBinding:
      position: 140
      prefix: --max-block-groups-in-memory
  - id: threads
    type:
      - 'null'
      - int
    doc: "Use this many threads during parallel steps"
    inputBinding:
      position: 141
      prefix: --threads
  - id: poa_threads
    type:
      - 'null'
      - int
    doc: "Use this many POA threads (can be used to reduce memory requirements with large --poa-length-target settings) [default: --threads]"
    inputBinding:
      position: 142
      prefix: --poa-threads
  - id: smoothed_out_path
    type:
      - 'null'
      - string
    doc: "Write GFA to this file (not /dev/stdout if consensus graph is made)"
    inputBinding:
      position: 143
      prefix: --smoothed-out
outputs:
  - id: smoothed_gfa
    type:
      - 'null'
      - File
    doc: Smoothed graph in GFA format
    outputBinding:
      glob: $(inputs.smoothed_out_path)
  - id: maf
    type:
      - 'null'
      - File
    doc: Multiple sequence alignments in MAF format
    outputBinding:
      glob: $(inputs.write_maf)
  - id: consensus_path_names
    type:
      - 'null'
      - File
    doc: Consensus path names
    outputBinding:
      glob: $(inputs.write_consensus_path_names_path)
  - id: consensus_graphs
    type:
      type: array
      items: File
    doc: Consensus graphs (BASENAME.cons_[spec].gfa)
    outputBinding:
      glob: '*.cons_*.gfa'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smoothxg:0.8.2--h2fa790d_1
