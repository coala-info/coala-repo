cwlVersion: v1.2
class: CommandLineTool
baseCommand: winnowmap
label: winnowmap
doc: "winnowmap is built on top of minimap2, while modifying its minimizer sampling
  and indexing procedures\n\nTool homepage: https://github.com/marbl/Winnowmap"
inputs:
  - id: target_file
    type: File
    doc: Target FASTA file or index
    inputBinding:
      position: 1
  - id: query_file
    type:
      - 'null'
      - File
    doc: Query FASTA file
    inputBinding:
      position: 2
  - id: chain_elongation_stop
    type:
      - 'null'
      - string
    doc: stop chain enlongation if there are no minimizers in INT-bp
    default: '5000'
    inputBinding:
      position: 103
      prefix: -g
  - id: chaining_bandwidth
    type:
      - 'null'
      - int
    doc: bandwidth used in chaining and DP-based alignment
    default: 500
    inputBinding:
      position: 103
      prefix: -r
  - id: dump_index_file
    type:
      - 'null'
      - File
    doc: dump index to FILE
    default: '[]'
    inputBinding:
      position: 103
      prefix: -d
  - id: filter_repetitive_minimizers
    type:
      - 'null'
      - float
    doc: filter out top FLOAT (<1) fraction of repetitive minimizers
    default: 0.0
    inputBinding:
      position: 103
      prefix: -f
  - id: gap_extension_penalty
    type:
      - 'null'
      - string
    doc: gap extension penalty; a k-long gap costs min{O1+k*E1,O2+k*E2}
    default: 2,1
    inputBinding:
      position: 103
      prefix: -E
  - id: gap_open_penalty
    type:
      - 'null'
      - string
    doc: gap open penalty
    default: 4,24
    inputBinding:
      position: 103
      prefix: -O
  - id: gtag_ag_finding
    type:
      - 'null'
      - string
    doc: how to find GT-AG. f:transcript strand, b:both strands, n:don't match 
      GT-AG
    default: n
    inputBinding:
      position: 103
      prefix: -u
  - id: high_freq_kmers_file
    type:
      - 'null'
      - File
    doc: input file containing list of high freq. k-mers
    default: '[]'
    inputBinding:
      position: 103
      prefix: -W
  - id: homopolymer_compressed
    type:
      - 'null'
      - boolean
    doc: use homopolymer-compressed k-mer
    inputBinding:
      position: 103
      prefix: -H
  - id: index_split_size
    type:
      - 'null'
      - string
    doc: split index for every ~NUM input bases
    default: 4G
    inputBinding:
      position: 103
      prefix: -I
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size (no larger than 28)
    default: 15
    inputBinding:
      position: 103
      prefix: -k
  - id: matching_score
    type:
      - 'null'
      - int
    doc: matching score
    default: 2
    inputBinding:
      position: 103
      prefix: -A
  - id: max_fragment_length
    type:
      - 'null'
      - string
    doc: max fragment length (effective with -xsr or in the fragment mode)
    default: '800'
    inputBinding:
      position: 103
      prefix: -F
  - id: max_intron_length
    type:
      - 'null'
      - string
    doc: max intron length (effective with -xsplice; changing -r)
    default: 200k
    inputBinding:
      position: 103
      prefix: -G
  - id: min_chaining_score
    type:
      - 'null'
      - int
    doc: minimal chaining score (matching bases minus log gap penalty)
    default: 40
    inputBinding:
      position: 103
      prefix: -m
  - id: min_minimizers_on_chain
    type:
      - 'null'
      - int
    doc: minimal number of minimizers on a chain
    default: 3
    inputBinding:
      position: 103
      prefix: -n
  - id: min_peak_dp_alignment_score
    type:
      - 'null'
      - int
    doc: minimal peak DP alignment score
    default: 80
    inputBinding:
      position: 103
      prefix: -s
  - id: min_secondary_to_primary_score_ratio
    type:
      - 'null'
      - float
    doc: min secondary-to-primary score ratio
    default: 0.8
    inputBinding:
      position: 103
      prefix: -p
  - id: minibatch_size
    type:
      - 'null'
      - string
    doc: minibatch size for mapping
    default: 1000M
    inputBinding:
      position: 103
      prefix: -K
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: mismatch penalty
    default: 4
    inputBinding:
      position: 103
      prefix: -B
  - id: output_cs_tag
    type:
      - 'null'
      - string
    doc: output the cs tag; STR is 'short' (if absent) or 'long'
    default: none
    inputBinding:
      position: 103
      prefix: --cs
  - id: output_md_tag
    type:
      - 'null'
      - boolean
    doc: output the MD tag
    inputBinding:
      position: 103
      prefix: --MD
  - id: output_paf_cigar
    type:
      - 'null'
      - boolean
    doc: output CIGAR in PAF
    inputBinding:
      position: 103
      prefix: -c
  - id: output_sam
    type:
      - 'null'
      - boolean
    doc: output in the SAM format (PAF by default)
    inputBinding:
      position: 103
      prefix: -a
  - id: preset
    type:
      - 'null'
      - string
    doc: preset (always applied before other options)
    default: '[]'
    inputBinding:
      position: 103
      prefix: -x
  - id: sam_read_group
    type:
      - 'null'
      - string
    doc: SAM read group line in a format like '@RG\tID:foo\tSM:bar'
    default: '[]'
    inputBinding:
      position: 103
      prefix: -R
  - id: skip_self_dual_mappings
    type:
      - 'null'
      - boolean
    doc: skip self and dual mappings (for the all-vs-all mode)
    inputBinding:
      position: 103
      prefix: -X
  - id: sv_aware_mode_off
    type:
      - 'null'
      - boolean
    doc: turn off SV-aware mode
    inputBinding:
      position: 103
      prefix: --sv-off
  - id: threads
    type:
      - 'null'
      - int
    doc: manually set pthread count rather than automatically
    inputBinding:
      position: 103
      prefix: -t
  - id: use_soft_clipping
    type:
      - 'null'
      - boolean
    doc: use soft clipping for supplementary alignments
    inputBinding:
      position: 103
      prefix: -Y
  - id: window_size
    type:
      - 'null'
      - int
    doc: minimizer window size
    default: 50
    inputBinding:
      position: 103
      prefix: -w
  - id: write_cigar_long
    type:
      - 'null'
      - boolean
    doc: write CIGAR with >65535 ops at the CG tag
    inputBinding:
      position: 103
      prefix: -L
  - id: write_eqx_cigar
    type:
      - 'null'
      - boolean
    doc: write =/X CIGAR operators
    inputBinding:
      position: 103
      prefix: --eqx
  - id: zdrop_score
    type:
      - 'null'
      - string
    doc: Z-drop score and inversion Z-drop score
    default: 400,200
    inputBinding:
      position: 103
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
    dockerPull: quay.io/biocontainers/winnowmap:2.03--h5ca1c30_4
