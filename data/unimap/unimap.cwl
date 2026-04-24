cwlVersion: v1.2
class: CommandLineTool
baseCommand: unimap
label: unimap
doc: "Unimap is a tool for mapping long sequences.\n\nTool homepage: https://github.com/lh3/unimap"
inputs:
  - id: target_file
    type: File
    doc: Target FASTA file or index file
    inputBinding:
      position: 1
  - id: query_file
    type:
      - 'null'
      - File
    doc: Query FASTA file
    inputBinding:
      position: 2
  - id: query_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional query FASTA files
    inputBinding:
      position: 3
  - id: bloom_filter_bits
    type:
      - 'null'
      - int
    doc: number of bits for bloom filter
    inputBinding:
      position: 104
      prefix: -b
  - id: chaining_bandwidth
    type:
      - 'null'
      - int
    doc: bandwidth used in chaining and DP-based alignment
    inputBinding:
      position: 104
      prefix: -r
  - id: dump_index_file
    type:
      - 'null'
      - File
    doc: dump index to FILE
    inputBinding:
      position: 104
      prefix: -d
  - id: gap_extension_penalty
    type:
      - 'null'
      - string
    doc: gap extension penalty; a k-long gap costs min{O1+k*E1,O2+k*E2}
    inputBinding:
      position: 104
      prefix: -E
  - id: gap_open_penalty
    type:
      - 'null'
      - string
    doc: gap open penalty
    inputBinding:
      position: 104
      prefix: -O
  - id: gt_ag_match_mode
    type:
      - 'null'
      - string
    doc: how to find GT-AG. f:transcript strand, b:both strands, n:don't match 
      GT-AG
    inputBinding:
      position: 104
      prefix: -u
  - id: high_kmer_occurrence_threshold
    type:
      - 'null'
      - int
    doc: high k-mer occurrence threshold when indexing
    inputBinding:
      position: 104
      prefix: -F
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size (no larger than 28)
    inputBinding:
      position: 104
      prefix: -k
  - id: matching_score
    type:
      - 'null'
      - int
    doc: matching score
    inputBinding:
      position: 104
      prefix: -A
  - id: max_intron_length
    type:
      - 'null'
      - string
    doc: max intron length (effective with -xsplice; changing -r)
    inputBinding:
      position: 104
      prefix: -G
  - id: max_minimizer_occurrence
    type:
      - 'null'
      - int
    doc: max minimizer occurrence
    inputBinding:
      position: 104
      prefix: -f
  - id: min_chaining_score
    type:
      - 'null'
      - int
    doc: minimal chaining score (matching bases minus log gap penalty)
    inputBinding:
      position: 104
      prefix: -m
  - id: min_minimizers_on_chain
    type:
      - 'null'
      - int
    doc: minimal number of minimizers on a chain
    inputBinding:
      position: 104
      prefix: -n
  - id: min_peak_dp_alignment_score
    type:
      - 'null'
      - int
    doc: minimal peak DP alignment score
    inputBinding:
      position: 104
      prefix: -s
  - id: min_secondary_to_primary_score_ratio
    type:
      - 'null'
      - float
    doc: min secondary-to-primary score ratio
    inputBinding:
      position: 104
      prefix: -p
  - id: minibatch_size
    type:
      - 'null'
      - string
    doc: minibatch size for mapping
    inputBinding:
      position: 104
      prefix: -K
  - id: minimizer_window_size
    type:
      - 'null'
      - int
    doc: minimizer window size
    inputBinding:
      position: 104
      prefix: -w
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: mismatch penalty
    inputBinding:
      position: 104
      prefix: -B
  - id: output_cigar_paf
    type:
      - 'null'
      - boolean
    doc: perform base-alignment and output CIGAR in the PAF format
    inputBinding:
      position: 104
      prefix: -c
  - id: output_cs_tag
    type:
      - 'null'
      - string
    doc: output the cs tag; STR is 'short' (if absent) or 'long'
    inputBinding:
      position: 104
      prefix: --cs
  - id: output_md_tag
    type:
      - 'null'
      - boolean
    doc: output the MD tag
    inputBinding:
      position: 104
      prefix: --MD
  - id: output_sam
    type:
      - 'null'
      - boolean
    doc: perform base-alignment and output in SAM (PAF by default)
    inputBinding:
      position: 104
      prefix: -a
  - id: preset
    type:
      - 'null'
      - string
    doc: preset (always applied before other options; see unimap.1 for details)
    inputBinding:
      position: 104
      prefix: -x
  - id: retain_secondary_alignments
    type:
      - 'null'
      - string
    doc: retain at most INT secondary alignments
    inputBinding:
      position: 104
      prefix: -N
  - id: sam_read_group
    type:
      - 'null'
      - string
    doc: SAM read group line in a format like '@RG\tID:foo\tSM:bar'
    inputBinding:
      position: 104
      prefix: -R
  - id: stop_chain_elongation_bp
    type:
      - 'null'
      - int
    doc: stop chain enlongation if there are no minimizers in INT-bp
    inputBinding:
      position: 104
      prefix: -g
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 104
      prefix: -t
  - id: use_soft_clipping_for_supplementary
    type:
      - 'null'
      - boolean
    doc: use soft clipping for supplementary alignments
    inputBinding:
      position: 104
      prefix: -Y
  - id: zdrop_scores
    type:
      - 'null'
      - string
    doc: Z-drop score and inversion Z-drop score
    inputBinding:
      position: 104
      prefix: -z
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output alignments to FILE
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unimap:0.1--h577a1d6_7
