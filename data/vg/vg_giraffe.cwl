cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vg
  - giraffe
label: vg_giraffe
doc: "Fast haplotype-aware read mapper.\n\nTool homepage: https://github.com/vgteam/vg"
inputs:
  - id: add_graph_aln
    type:
      - 'null'
      - boolean
    doc: annotate linear formats with graph alignment in the GR tag as a 
      cs-style difference string
    inputBinding:
      position: 101
      prefix: --add-graph-aln
  - id: align_from_chains
    type:
      - 'null'
      - boolean
    doc: chain up extensions to create alignments, instead of doing each 
      separately
    inputBinding:
      position: 101
      prefix: --align-from-chains
  - id: batch_size
    type:
      - 'null'
      - int
    doc: complain after INT seconds working on a read or read pair
    default: 512
    inputBinding:
      position: 101
      prefix: --batch-size
  - id: chain_score_threshold
    type:
      - 'null'
      - float
    doc: only align chains if their score is within this many points of the best
      score
    default: 100
    inputBinding:
      position: 101
      prefix: --chain-score-threshold
  - id: cluster_coverage
    type:
      - 'null'
      - float
    doc: only extend clusters if they are within FLOAT of the best read coverage
    inputBinding:
      position: 101
      prefix: --cluster-coverage
  - id: cluster_score
    type:
      - 'null'
      - float
    doc: only extend clusters if they are within INT of the best score
    inputBinding:
      position: 101
      prefix: --cluster-score
  - id: comments_as_tags
    type:
      - 'null'
      - boolean
    doc: treat comments in name lines as SAM-style tags and annotate alignments 
      with them
    inputBinding:
      position: 101
      prefix: --comments-as-tags
  - id: discard
    type:
      - 'null'
      - boolean
    doc: discard all output alignments (for profiling)
    inputBinding:
      position: 101
      prefix: --discard
  - id: dist_name
    type:
      - 'null'
      - File
    doc: cluster using this distance index
    inputBinding:
      position: 101
      prefix: --dist-name
  - id: distance_limit
    type:
      - 'null'
      - int
    doc: cluster using this distance limit
    default: 200
    inputBinding:
      position: 101
      prefix: --distance-limit
  - id: downsample_window_count
    type:
      - 'null'
      - int
    doc: downsample minimizers with windows of length read_length/INT, 0 for no 
      downsampling
    default: 0
    inputBinding:
      position: 101
      prefix: --downsample-window-count
  - id: downsample_window_length
    type:
      - 'null'
      - int
    doc: maximum window length for downsampling
    default: 18446744073709551615
    inputBinding:
      position: 101
      prefix: --downsample-window-length
  - id: exclude_overlapping_min
    type:
      - 'null'
      - boolean
    doc: exclude overlapping minimizers
    inputBinding:
      position: 101
      prefix: --exclude-overlapping-min
  - id: explored_cap
    type:
      - 'null'
      - boolean
    doc: use explored minimizer layout cap on mapping quality
    inputBinding:
      position: 101
      prefix: --explored-cap
  - id: extension_score
    type:
      - 'null'
      - int
    doc: only align extensions if their score is within INT of the best score
    inputBinding:
      position: 101
      prefix: --extension-score
  - id: extension_set
    type:
      - 'null'
      - float
    doc: only align extension sets if their score is within INT of the best 
      score
    inputBinding:
      position: 101
      prefix: --extension-set
  - id: fastq_in
    type:
      - 'null'
      - type: array
        items: File
    doc: read and align these FASTQ/FASTA-format reads (two are allowed, one for
      each mate)
    inputBinding:
      position: 101
      prefix: --fastq-in
  - id: fragment_gap_scale
    type:
      - 'null'
      - float
    doc: scale for gap scores when fragmenting
    default: 1
    inputBinding:
      position: 101
      prefix: --fragment-gap-scale
  - id: fragment_max_graph_lookback_bases
    type:
      - 'null'
      - int
    doc: maximum distance to look back in the graph when making fragments
    default: 300
    inputBinding:
      position: 101
      prefix: --fragment-max-graph-lookback-bases
  - id: fragment_max_graph_lookback_bases_per_base
    type:
      - 'null'
      - float
    doc: maximum distance to look back in the graph when making fragments, per 
      base
    default: 0.03
    inputBinding:
      position: 101
      prefix: --fragment-max-graph-lookback-bases-per-base
  - id: fragment_max_indel_bases
    type:
      - 'null'
      - int
    doc: maximum indel length in a transition when making fragments
    default: 2000
    inputBinding:
      position: 101
      prefix: --fragment-max-indel-bases
  - id: fragment_max_indel_bases_per_base
    type:
      - 'null'
      - float
    doc: maximum indel length in a transition when making fragments, per read 
      base
    default: 0.2
    inputBinding:
      position: 101
      prefix: --fragment-max-indel-bases-per-base
  - id: fragment_max_min_score
    type:
      - 'null'
      - float
    doc: maximum for fragment score threshold based on the score of the best 
      fragment
    default: 1.79769e+308
    inputBinding:
      position: 101
      prefix: --fragment-max-min-score
  - id: fragment_max_read_lookback_bases
    type:
      - 'null'
      - int
    doc: maximum distance to look back in the read when making fragments
    default: 18446744073709551615
    inputBinding:
      position: 101
      prefix: --fragment-max-read-lookback-bases
  - id: fragment_max_read_lookback_bases_per_base
    type:
      - 'null'
      - float
    doc: maximum distance to look back in the read when making fragments, per 
      base
    default: 1
    inputBinding:
      position: 101
      prefix: --fragment-max-read-lookback-bases-per-base
  - id: fragment_mean
    type:
      - 'null'
      - float
    doc: force fragment length distribution to have this mean (requires 
      --fragment-stdev)
    inputBinding:
      position: 101
      prefix: --fragment-mean
  - id: fragment_min_score
    type:
      - 'null'
      - float
    doc: minimum score to retain a fragment
    default: 60
    inputBinding:
      position: 101
      prefix: --fragment-min-score
  - id: fragment_points_per_possible_match
    type:
      - 'null'
      - float
    doc: points to award non-indel connecting bases when fragmenting
    default: 0
    inputBinding:
      position: 101
      prefix: --fragment-points-per-possible-match
  - id: fragment_score_fraction
    type:
      - 'null'
      - float
    doc: minimum fraction of best fragment score to retain a fragment
    default: 0.1
    inputBinding:
      position: 101
      prefix: --fragment-score-fraction
  - id: fragment_set_score_threshold
    type:
      - 'null'
      - float
    doc: only chain fragments in a tree if their overall score is within this 
      many points of the best tree
    default: 0
    inputBinding:
      position: 101
      prefix: --fragment-set-score-threshold
  - id: fragment_stdev
    type:
      - 'null'
      - float
    doc: force fragment length distribution to have this standard deviation 
      (requires --fragment-mean)
    inputBinding:
      position: 101
      prefix: --fragment-stdev
  - id: full_l_bonus
    type:
      - 'null'
      - int
    doc: the full-length alignment bonus
    default: 5
    inputBinding:
      position: 101
      prefix: --full-l-bonus
  - id: gam_in
    type:
      - 'null'
      - File
    doc: read and realign these GAM-format reads
    inputBinding:
      position: 101
      prefix: --gam-in
  - id: gap_extend
    type:
      - 'null'
      - int
    doc: use this gap extension penalty
    default: 1
    inputBinding:
      position: 101
      prefix: --gap-extend
  - id: gap_open
    type:
      - 'null'
      - int
    doc: use this gap open penalty
    default: 6
    inputBinding:
      position: 101
      prefix: --gap-open
  - id: gap_scale
    type:
      - 'null'
      - float
    doc: scale for gap scores when chaining
    default: 1
    inputBinding:
      position: 101
      prefix: --gap-scale
  - id: gapless_extension_limit
    type:
      - 'null'
      - int
    doc: do gapless extension to seeds in a tree before fragmenting if the read 
      length is less than this
    default: 0
    inputBinding:
      position: 101
      prefix: --gapless-extension-limit
  - id: gbwt_name
    type:
      - 'null'
      - File
    doc: use this GBWT index (when mapping to -x / -g)
    inputBinding:
      position: 101
      prefix: --gbwt-name
  - id: gbz_name
    type: File
    doc: map to this GBZ graph
    inputBinding:
      position: 101
      prefix: --gbz-name
  - id: graph_name
    type:
      - 'null'
      - File
    doc: map to this GBWTGraph (if no -Z)
    inputBinding:
      position: 101
      prefix: --graph-name
  - id: haplotype_name
    type:
      - 'null'
      - File
    doc: sample from haplotype information in FILE
    inputBinding:
      position: 101
      prefix: --haplotype-name
  - id: hard_hit_cap
    type:
      - 'null'
      - int
    doc: ignore all minimizers with more than INT hits
    default: 500
    inputBinding:
      position: 101
      prefix: --hard-hit-cap
  - id: hit_cap
    type:
      - 'null'
      - int
    doc: use all minimizers with at most INT hits
    default: 10
    inputBinding:
      position: 101
      prefix: --hit-cap
  - id: index_basename
    type:
      - 'null'
      - string
    doc: 'name prefix for generated graph/index files (default: from graph name)'
    inputBinding:
      position: 101
      prefix: --index-basename
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: GAM/FASTQ/FASTA input is interleaved pairs, for paired-end alignment
    inputBinding:
      position: 101
      prefix: --interleaved
  - id: item_bonus
    type:
      - 'null'
      - int
    doc: bonus for taking each item when fragmenting or chaining
    default: 0
    inputBinding:
      position: 101
      prefix: --item-bonus
  - id: item_scale
    type:
      - 'null'
      - float
    doc: scale for items' scores when fragmenting or chaining
    default: 1
    inputBinding:
      position: 101
      prefix: --item-scale
  - id: kff_name
    type:
      - 'null'
      - File
    doc: sample according to kmer counts in FILE
    inputBinding:
      position: 101
      prefix: --kff-name
  - id: log_reads
    type:
      - 'null'
      - boolean
    doc: log each read being mapped
    inputBinding:
      position: 101
      prefix: --log-reads
  - id: mapq_score_scale
    type:
      - 'null'
      - float
    doc: scale scores for mapping quality
    default: 1
    inputBinding:
      position: 101
      prefix: --mapq-score-scale
  - id: mapq_score_window
    type:
      - 'null'
      - int
    doc: window to rescale score to for mapping quality, or 0 if not used
    default: 0
    inputBinding:
      position: 101
      prefix: --mapq-score-window
  - id: match
    type:
      - 'null'
      - int
    doc: use this match score
    default: 1
    inputBinding:
      position: 101
      prefix: --match
  - id: max_alignments
    type:
      - 'null'
      - int
    doc: align up to INT extensions
    default: 8
    inputBinding:
      position: 101
      prefix: --max-alignments
  - id: max_chain_connection
    type:
      - 'null'
      - int
    doc: maximum distance across which to connect seeds with WFAExtender when 
      aligning a chain
    default: 100
    inputBinding:
      position: 101
      prefix: --max-chain-connection
  - id: max_chaining_problems
    type:
      - 'null'
      - int
    doc: do no more than this many chaining problems
    default: 2147483647
    inputBinding:
      position: 101
      prefix: --max-chaining-problems
  - id: max_chains_per_tree
    type:
      - 'null'
      - int
    doc: align up to this many chains from each tree
    default: 1
    inputBinding:
      position: 101
      prefix: --max-chains-per-tree
  - id: max_direct_chain
    type:
      - 'null'
      - int
    doc: take up to this many fragments per zipcode tree and turn them into 
      chains instead of chaining. If this is 0, do chaining.
    default: 0
    inputBinding:
      position: 101
      prefix: --max-direct-chain
  - id: max_dp_cells
    type:
      - 'null'
      - int
    doc: maximum number of alignment cells to allow in a tail or BGA connection
    default: 18446744073709551615
    inputBinding:
      position: 101
      prefix: --max-dp-cells
  - id: max_extension_mismatches
    type:
      - 'null'
      - int
    doc: maximum number of mismatches to pass through in a gapless extension
    default: 4
    inputBinding:
      position: 101
      prefix: --max-extension-mismatches
  - id: max_extensions
    type:
      - 'null'
      - int
    doc: extend up to INT clusters
    default: 800
    inputBinding:
      position: 101
      prefix: --max-extensions
  - id: max_fragment_length
    type:
      - 'null'
      - int
    doc: assume that fragment lengths should be smaller than INT when estimating
      the fragment length distribution
    default: 2000
    inputBinding:
      position: 101
      prefix: --max-fragment-length
  - id: max_fragments
    type:
      - 'null'
      - int
    doc: how many fragments should we try to make when fragmenting something
    default: 18446744073709551615
    inputBinding:
      position: 101
      prefix: --max-fragments
  - id: max_graph_lookback_bases
    type:
      - 'null'
      - int
    doc: maximum distance to look back in the graph when chaining
    default: 3000
    inputBinding:
      position: 101
      prefix: --max-graph-lookback-bases
  - id: max_graph_lookback_bases_per_base
    type:
      - 'null'
      - float
    doc: maximum distance to look back in the graph when chaining, per read base
    default: 0.3
    inputBinding:
      position: 101
      prefix: --max-graph-lookback-bases-per-base
  - id: max_indel_bases
    type:
      - 'null'
      - int
    doc: maximum indel length in a transition when chaining
    default: 2000
    inputBinding:
      position: 101
      prefix: --max-indel-bases
  - id: max_indel_bases_per_base
    type:
      - 'null'
      - float
    doc: maximum indel length in a transition when chaining, per read base
    default: 0.2
    inputBinding:
      position: 101
      prefix: --max-indel-bases-per-base
  - id: max_middle_dp_length
    type:
      - 'null'
      - int
    doc: maximum number of bases in a middle connection to do DP for, before 
      making it a tail
    default: 2147483647
    inputBinding:
      position: 101
      prefix: --max-middle-dp-length
  - id: max_middle_gap
    type:
      - 'null'
      - int
    doc: maximum number of gap bases to allow in a middle connection
    default: 2147483647
    inputBinding:
      position: 101
      prefix: --max-middle-gap
  - id: max_min
    type:
      - 'null'
      - int
    doc: use at most INT minimizers, 0 for no limit
    default: 500
    inputBinding:
      position: 101
      prefix: --max-min
  - id: max_min_chain_score
    type:
      - 'null'
      - int
    doc: accept chains with this score or more regardless of read length
    default: 200
    inputBinding:
      position: 101
      prefix: --max-min-chain-score
  - id: max_multimaps
    type:
      - 'null'
      - int
    doc: produce up to INT alignments for each read
    default: 1
    inputBinding:
      position: 101
      prefix: --max-multimaps
  - id: max_read_lookback_bases
    type:
      - 'null'
      - int
    doc: maximum distance to look back in the read when chaining
    default: 18446744073709551615
    inputBinding:
      position: 101
      prefix: --max-read-lookback-bases
  - id: max_read_lookback_bases_per_base
    type:
      - 'null'
      - float
    doc: maximum distance to look back in the read when chaining, per read base
    default: 1
    inputBinding:
      position: 101
      prefix: --max-read-lookback-bases-per-base
  - id: max_skipped_bases
    type:
      - 'null'
      - int
    doc: when skipping seeds in a chain for alignment, allow a gap of at most 
      INT in the graph
    default: 0
    inputBinding:
      position: 101
      prefix: --max-skipped-bases
  - id: max_tail_dp_length
    type:
      - 'null'
      - int
    doc: maximum number of bases in a tail to do DP for, to avoid score overflow
    default: 30000
    inputBinding:
      position: 101
      prefix: --max-tail-dp-length
  - id: max_tail_gap
    type:
      - 'null'
      - int
    doc: maximum number of gap bases to allow in a Dozeu tail
    default: 18446744073709551615
    inputBinding:
      position: 101
      prefix: --max-tail-gap
  - id: max_tail_length
    type:
      - 'null'
      - int
    doc: maximum length of a tail to align with WFAExtender when aligning a 
      chain
    default: 100
    inputBinding:
      position: 101
      prefix: --max-tail-length
  - id: max_to_fragment
    type:
      - 'null'
      - int
    doc: maximum number of fragmenting problems to run
    default: 10
    inputBinding:
      position: 101
      prefix: --max-to-fragment
  - id: min_chain_score_per_base
    type:
      - 'null'
      - float
    doc: do not align chains with less than this score per read base
    default: 0.01
    inputBinding:
      position: 101
      prefix: --min-chain-score-per-base
  - id: min_chaining_problems
    type:
      - 'null'
      - int
    doc: ignore score threshold to get this many chaining problems
    default: 4
    inputBinding:
      position: 101
      prefix: --min-chaining-problems
  - id: min_chains
    type:
      - 'null'
      - int
    doc: ignore score threshold to get this many chains aligned
    default: 4
    inputBinding:
      position: 101
      prefix: --min-chains
  - id: min_coverage_flank
    type:
      - 'null'
      - int
    doc: when trying to cover the read with minimizers, count INT towards the 
      coverage of each minimizer on each side
    default: 250
    inputBinding:
      position: 101
      prefix: --min-coverage-flank
  - id: min_to_fragment
    type:
      - 'null'
      - int
    doc: minimum number of fragmenting problems to run
    default: 4
    inputBinding:
      position: 101
      prefix: --min-to-fragment
  - id: min_unique_node_fraction
    type:
      - 'null'
      - float
    doc: minimum fraction of an alignment that must be from distinct oriented 
      nodes for the alignment to be distinct
    default: 0
    inputBinding:
      position: 101
      prefix: --min-unique-node-fraction
  - id: mismatch
    type:
      - 'null'
      - int
    doc: use this mismatch penalty
    default: 4
    inputBinding:
      position: 101
      prefix: --mismatch
  - id: named_coordinates
    type:
      - 'null'
      - boolean
    doc: make GAM/GAF output in named-segment (GFA) space
    inputBinding:
      position: 101
      prefix: --named-coordinates
  - id: no_dp
    type:
      - 'null'
      - boolean
    doc: disable all gapped alignment
    inputBinding:
      position: 101
      prefix: --no-dp
  - id: num_bp_per_min
    type:
      - 'null'
      - int
    doc: use maximum of number minimizers calculated by READ_LENGTH / INT and 
      --max-min
    default: 1000
    inputBinding:
      position: 101
      prefix: --num-bp-per-min
  - id: output_basename
    type:
      - 'null'
      - string
    doc: write output to a GAM file with the given prefix for each setting 
      combination
    inputBinding:
      position: 101
      prefix: --output-basename
  - id: output_format
    type:
      - 'null'
      - string
    doc: output the alignments in NAME format
    default: gam
    inputBinding:
      position: 101
      prefix: --output-format
  - id: pad_cluster_score
    type:
      - 'null'
      - float
    doc: also extend clusters within INT of above threshold to get a second-best
      cluster
    inputBinding:
      position: 101
      prefix: --pad-cluster-score
  - id: pad_zipcode_tree_score_threshold
    type:
      - 'null'
      - float
    doc: also fragment trees within INT of above threshold to get a second-best 
      cluster
    inputBinding:
      position: 101
      prefix: --pad-zipcode-tree-score-threshold
  - id: paired_distance_limit
    type:
      - 'null'
      - float
    doc: cluster pairs of read using a distance limit FLOAT standard deviations 
      greater than the mean
    inputBinding:
      position: 101
      prefix: --paired-distance-limit
  - id: parameter_preset
    type:
      - 'null'
      - string
    doc: set computational parameters
    default: '[default]'
    inputBinding:
      position: 101
      prefix: --parameter-preset
  - id: points_per_possible_match
    type:
      - 'null'
      - float
    doc: points to award non-indel connecting bases when chaining
    default: 0
    inputBinding:
      position: 101
      prefix: --points-per-possible-match
  - id: progress
    type:
      - 'null'
      - boolean
    doc: show progress
    inputBinding:
      position: 101
      prefix: --progress
  - id: prune_low_cplx
    type:
      - 'null'
      - boolean
    doc: prune short and low complexity anchors during linear format realignment
    inputBinding:
      position: 101
      prefix: --prune-low-cplx
  - id: read_group
    type:
      - 'null'
      - string
    doc: add this read group
    inputBinding:
      position: 101
      prefix: --read-group
  - id: rec_mode
    type:
      - 'null'
      - boolean
    doc: activate giraffe recombination-aware mode
    inputBinding:
      position: 101
      prefix: --rec-mode
  - id: rec_penalty_chain
    type:
      - 'null'
      - int
    doc: penalty for a recombination when chaining, requires -E (ALPHA)
    default: 0
    inputBinding:
      position: 101
      prefix: --rec-penalty-chain
  - id: rec_penalty_fragment
    type:
      - 'null'
      - int
    doc: penalty for a recombination when fragmenting, requires -E (ALPHA)
    default: 0
    inputBinding:
      position: 101
      prefix: --rec-penalty-fragment
  - id: ref_name
    type:
      - 'null'
      - string
    doc: name of reference in the graph for HTSlib output
    inputBinding:
      position: 101
      prefix: --ref-name
  - id: ref_paths
    type:
      - 'null'
      - File
    doc: ordered list of paths in the graph, one per line or HTSlib .dict, for 
      HTSlib @SQ headers
    inputBinding:
      position: 101
      prefix: --ref-paths
  - id: report_name
    type:
      - 'null'
      - File
    doc: write a TSV of output file and mapping speed
    inputBinding:
      position: 101
      prefix: --report-name
  - id: rescue_algorithm
    type:
      - 'null'
      - string
    doc: use this rescue algorithm
    default: dozeu
    inputBinding:
      position: 101
      prefix: --rescue-algorithm
  - id: rescue_attempts
    type:
      - 'null'
      - int
    doc: attempt up to INT rescues per read in a pair
    default: 15
    inputBinding:
      position: 101
      prefix: --rescue-attempts
  - id: rescue_seed_limit
    type:
      - 'null'
      - int
    doc: attempt rescue with at most INT seeds
    default: 100
    inputBinding:
      position: 101
      prefix: --rescue-seed-limit
  - id: rescue_subgraph_size
    type:
      - 'null'
      - float
    doc: search for rescued alignments FLOAT standard deviations greater than 
      the mean
    inputBinding:
      position: 101
      prefix: --rescue-subgraph-size
  - id: sample_name
    type:
      - 'null'
      - string
    doc: add this sample name
    inputBinding:
      position: 101
      prefix: --sample
  - id: score_fraction
    type:
      - 'null'
      - float
    doc: select minimizers between hit caps until score is FLOAT of total
    default: 0.9
    inputBinding:
      position: 101
      prefix: --score-fraction
  - id: set_reference
    type:
      - 'null'
      - type: array
        items: string
    doc: include this sample as a reference in the personalized graph (may 
      repeat)
    inputBinding:
      position: 101
      prefix: --set-reference
  - id: set_refpos
    type:
      - 'null'
      - boolean
    doc: set refpos field on reads to reference path positions they visit
    inputBinding:
      position: 101
      prefix: --set-refpos
  - id: show_work
    type:
      - 'null'
      - boolean
    doc: log how the mapper comes to its conclusions about mapping locations 
      (use one read at a time)
    inputBinding:
      position: 101
      prefix: --show-work
  - id: softclip_penalty
    type:
      - 'null'
      - float
    doc: penalize candidate alignment scores this many points per softclipped 
      base
    default: 0
    inputBinding:
      position: 101
      prefix: --softclip-penalty
  - id: sort_by_chain_score
    type:
      - 'null'
      - boolean
    doc: order alignment candidates by chain score instead of base-level score
    inputBinding:
      position: 101
      prefix: --sort-by-chain-score
  - id: supplementary
    type:
      - 'null'
      - boolean
    doc: report supplementary alignments in HTSlib output
    inputBinding:
      position: 101
      prefix: --supplementary
  - id: threads
    type:
      - 'null'
      - int
    doc: number of mapping threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: track_correctness
    type:
      - 'null'
      - boolean
    doc: track if internal intermediate alignment candidates are correct 
      (implies --track-provenance)
    inputBinding:
      position: 101
      prefix: --track-correctness
  - id: track_position
    type:
      - 'null'
      - boolean
    doc: coarsely track linear reference positions of good intermediate 
      alignment candidates (implies --track-provenance)
    inputBinding:
      position: 101
      prefix: --track-position
  - id: track_provenance
    type:
      - 'null'
      - boolean
    doc: track how internal intermediate alignment candidates were arrived at
    inputBinding:
      position: 101
      prefix: --track-provenance
  - id: watchdog_timeout
    type:
      - 'null'
      - int
    doc: complain after INT seconds working on a read or read pair
    default: 10
    inputBinding:
      position: 101
      prefix: --watchdog-timeout
  - id: wfa_distance
    type:
      - 'null'
      - int
    doc: band distance to allow in the shortest WFA connection or tail
    default: 10
    inputBinding:
      position: 101
      prefix: --wfa-distance
  - id: wfa_distance_per_base
    type:
      - 'null'
      - float
    doc: band distance to allow per involved read base in WFA connections or 
      tails
    default: 0.1
    inputBinding:
      position: 101
      prefix: --wfa-distance-per-base
  - id: wfa_max_distance
    type:
      - 'null'
      - int
    doc: band distance to allow in the longest WFA connection or tail
    default: 200
    inputBinding:
      position: 101
      prefix: --wfa-max-distance
  - id: wfa_max_max_mismatches
    type:
      - 'null'
      - int
    doc: maximum mismatches (or equivalent-scoring gaps) to allow in the longest
      WFA connection or tail
    default: 20
    inputBinding:
      position: 101
      prefix: --wfa-max-max-mismatches
  - id: wfa_max_mismatches
    type:
      - 'null'
      - int
    doc: maximum mismatches (or equivalent-scoring gaps) to allow in the 
      shortest WFA connection or tail
    default: 2
    inputBinding:
      position: 101
      prefix: --wfa-max-mismatches
  - id: wfa_max_mismatches_per_base
    type:
      - 'null'
      - float
    doc: maximum additional mismatches (or equivalent-scoring gaps) to allow per
      involved read base in WFA connections or tails
    default: 0.1
    inputBinding:
      position: 101
      prefix: --wfa-max-mismatches-per-base
  - id: withzip_min_name
    type:
      - 'null'
      - File
    doc: use this minimizer index
    inputBinding:
      position: 101
      prefix: --minimizer-name
  - id: xg_name
    type:
      - 'null'
      - File
    doc: map to this graph (if no -Z / -g), or use this graph for HTSLib output
    inputBinding:
      position: 101
      prefix: --xg-name
  - id: zipcode_name
    type:
      - 'null'
      - File
    doc: use these additional distance hints
    inputBinding:
      position: 101
      prefix: --zipcode-name
  - id: zipcode_tree_coverage_threshold
    type:
      - 'null'
      - float
    doc: only fragment trees if they are within FLOAT of the best read coverage
    inputBinding:
      position: 101
      prefix: --zipcode-tree-coverage-threshold
  - id: zipcode_tree_scale
    type:
      - 'null'
      - float
    doc: at what fraction of the read length should zipcode trees be split up
    default: 2
    inputBinding:
      position: 101
      prefix: --zipcode-tree-scale
  - id: zipcode_tree_score_threshold
    type:
      - 'null'
      - float
    doc: only fragment trees if they are within INT of the best score
    default: 50
    inputBinding:
      position: 101
      prefix: --zipcode-tree-score-threshold
outputs:
  - id: output_gam
    type:
      - 'null'
      - File
    doc: output GAM file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vg:1.70.0--h9ee0642_0
