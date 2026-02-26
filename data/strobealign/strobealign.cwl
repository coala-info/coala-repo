cwlVersion: v1.2
class: CommandLineTool
baseCommand: strobealign
label: strobealign
doc: "strobealign 0.17.0\n\nTool homepage: https://github.com/ksahlin/StrobeAlign"
inputs:
  - id: reference
    type: File
    doc: Reference in FASTA format
    inputBinding:
      position: 1
  - id: reads1
    type:
      - 'null'
      - File
    doc: Reads 1 in FASTA or FASTQ format, optionally gzip compressed
    inputBinding:
      position: 2
  - id: reads2
    type:
      - 'null'
      - File
    doc: Reads 2 in FASTA or FASTQ format, optionally gzip compressed
    inputBinding:
      position: 3
  - id: aemb
    type:
      - 'null'
      - boolean
    doc: 'Output the estimated abundance value of contigs, the format of output file
      is: contig_id abundance_value'
    inputBinding:
      position: 104
      prefix: --aemb
  - id: append_fastq_comment
    type:
      - 'null'
      - boolean
    doc: Append FASTQ comment to SAM record
    inputBinding:
      position: 104
      prefix: -C
  - id: aux_len_bits
    type:
      - 'null'
      - int
    doc: No. of bits to use from secondary strobe hash
    default: 17
    inputBinding:
      position: 104
      prefix: --aux-len
  - id: bitcount_length
    type:
      - 'null'
      - int
    doc: Bitcount length between 2 and 63.
    default: 8
    inputBinding:
      position: 104
      prefix: -c
  - id: collinear_chaining_best_chain_score_threshold
    type:
      - 'null'
      - float
    doc: Collinear chaining best chain score threshold
    default: 0.7
    inputBinding:
      position: 104
      prefix: --vp
  - id: collinear_chaining_diagonal_gap_cost
    type:
      - 'null'
      - float
    doc: Collinear chaining diagonal gap cost
    default: 0.1
    inputBinding:
      position: 104
      prefix: --gd
  - id: collinear_chaining_gap_length_cost
    type:
      - 'null'
      - float
    doc: Collinear chaining gap length cost
    default: 0.05
    inputBinding:
      position: 104
      prefix: --gl
  - id: collinear_chaining_look_back
    type:
      - 'null'
      - int
    doc: Collinear chaining look back heuristic
    default: 50
    inputBinding:
      position: 104
      prefix: -H
  - id: collinear_chaining_skip_distance
    type:
      - 'null'
      - int
    doc: Collinear chaining skip distance, how far on the reference do we allow 
      anchors to chain
    default: 10000
    inputBinding:
      position: 104
      prefix: --sg
  - id: collinear_chaining_weight_anchors
    type:
      - 'null'
      - float
    doc: Weight given to the number of anchors for the final score of chains
    default: 0.01
    inputBinding:
      position: 104
      prefix: --mw
  - id: create_index
    type:
      - 'null'
      - boolean
    doc: Do not map reads; only generate the strobemer index and write it to 
      disk. If read files are provided, they are used to estimate read length
    inputBinding:
      position: 104
      prefix: --create-index
  - id: details
    type:
      - 'null'
      - boolean
    doc: Add debugging details to SAM records
    inputBinding:
      position: 104
      prefix: --details
  - id: eqx
    type:
      - 'null'
      - boolean
    doc: Emit =/X instead of M CIGAR operations
    inputBinding:
      position: 104
      prefix: --eqx
  - id: gap_extension_penalty
    type:
      - 'null'
      - int
    doc: Gap extension penalty
    default: 1
    inputBinding:
      position: 104
      prefix: -E
  - id: gap_open_penalty
    type:
      - 'null'
      - int
    doc: Gap open penalty
    default: 12
    inputBinding:
      position: 104
      prefix: -O
  - id: index_statistics
    type:
      - 'null'
      - File
    doc: Print statistics of indexing to PATH
    inputBinding:
      position: 104
      prefix: --index-statistics
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: Interleaved input
    inputBinding:
      position: 104
      prefix: --interleaved
  - id: matching_score
    type:
      - 'null'
      - int
    doc: Matching score
    default: 2
    inputBinding:
      position: 104
      prefix: -A
  - id: max_filtered_seed_span
    type:
      - 'null'
      - int
    doc: Maximum distance (in nucleotides) that filtered seeds may span. The 
      lower the value, the more seeds are rescued. Use 0 to disable rescue.
    default: 100
    inputBinding:
      position: 104
      prefix: -R
  - id: max_mapping_sites
    type:
      - 'null'
      - int
    doc: Maximum number of mapping sites to try
    default: 20
    inputBinding:
      position: 104
      prefix: -M
  - id: max_second_syncmer_distance
    type:
      - 'null'
      - int
    doc: End of sampling window for second syncmer (i.e., second syncmer must be
      at most u syncmers downstream).
    default: 11
    inputBinding:
      position: 104
      prefix: -u
  - id: max_seed_length
    type:
      - 'null'
      - int
    doc: Maximum seed length. Defaults to r - 50. For reasonable values on -l 
      and -u, the seed length distribution is usually determined by parameters l
      and u. Then, this parameter is only active in regions where syncmers are 
      very sparse.
    inputBinding:
      position: 104
      prefix: -m
  - id: mean_read_length
    type:
      - 'null'
      - int
    doc: Mean read length. This parameter is estimated from the first 500 
      records in each read file. No need to set this explicitly unless you have 
      a reason.
    inputBinding:
      position: 104
      prefix: -r
  - id: min_mapping_score_ratio
    type:
      - 'null'
      - float
    doc: Try candidate sites with mapping score at least S of maximum mapping 
      score
    default: 0.5
    inputBinding:
      position: 104
      prefix: -S
  - id: min_second_syncmer_distance
    type:
      - 'null'
      - int
    doc: Start of sampling window for second syncmer (i.e., second syncmer must 
      be at least l syncmers downstream).
    default: 5
    inputBinding:
      position: 104
      prefix: -l
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: Mismatch penalty
    default: 8
    inputBinding:
      position: 104
      prefix: -B
  - id: multi_context_seeds
    type:
      - 'null'
      - string
    doc: "How multi-context seeds are used. Allowed: 'always' (default), 'rescue',
      'off', 'first-strobe'"
    default: always
    inputBinding:
      position: 104
      prefix: --mcs
  - id: no_PG
    type:
      - 'null'
      - boolean
    doc: Do not output PG header
    inputBinding:
      position: 104
      prefix: --no-PG
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: Disable progress report (enabled by default if output is a terminal)
    inputBinding:
      position: 104
      prefix: --no-progress
  - id: only_map
    type:
      - 'null'
      - boolean
    doc: Only map reads, no base level alignment (produces PAF file)
    inputBinding:
      position: 104
      prefix: -x
  - id: retain_secondary_alignments
    type:
      - 'null'
      - int
    doc: Retain at most INT secondary alignments (is upper bounded by -M and 
      depends on -S)
    default: 0
    inputBinding:
      position: 104
      prefix: -N
  - id: rg
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Add read group metadata to SAM header (can be specified multiple times).
      Example: SM:samplename'
    inputBinding:
      position: 104
      prefix: --rg
  - id: rg_id
    type:
      - 'null'
      - string
    doc: Read group ID
    inputBinding:
      position: 104
      prefix: --rg-id
  - id: soft_clipping_penalty
    type:
      - 'null'
      - int
    doc: Soft clipping penalty
    default: 10
    inputBinding:
      position: 104
      prefix: -L
  - id: submer_size
    type:
      - 'null'
      - int
    doc: Submer size used for creating syncmers [k-4]. Only even numbers on k-s 
      allowed. A value of s=k-4 roughly represents w=10 as minimizer window 
      [k-4]. It is recommended not to change this parameter unless you have a 
      good understanding of syncmers as it will drastically change the memory 
      usage and results with non default values.
    inputBinding:
      position: 104
      prefix: -s
  - id: syncmer_length
    type:
      - 'null'
      - int
    doc: Syncmer (strobe) length, has to be below 32.
    default: 20
    inputBinding:
      position: 104
      prefix: -k
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 104
      prefix: --threads
  - id: top_bits_for_bucket_indices
    type:
      - 'null'
      - int
    doc: No. of top bits of hash to use as bucket indices (8-31)[determined from
      reference size]
    inputBinding:
      position: 104
      prefix: -b
  - id: top_fraction_repetitive_strobemers
    type:
      - 'null'
      - float
    doc: Top fraction of repetitive strobemers to filter out from sampling
    default: 0.0002
    inputBinding:
      position: 104
      prefix: -f
  - id: unmapped_single_end
    type:
      - 'null'
      - boolean
    doc: Do not output unmapped single-end reads. Do not output pairs where both
      reads are unmapped
    inputBinding:
      position: 104
      prefix: -U
  - id: use_index
    type:
      - 'null'
      - boolean
    doc: Use a pre-generated index previously written with --create-index.
    inputBinding:
      position: 104
      prefix: --use-index
  - id: use_nams
    type:
      - 'null'
      - boolean
    doc: Use NAMs instead of collinear chaining for alignments
    inputBinding:
      position: 104
      prefix: --nams
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: redirect output to file [stdout]
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strobealign:0.17.0--h5ca1c30_0
