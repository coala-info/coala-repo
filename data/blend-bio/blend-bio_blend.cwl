cwlVersion: v1.2
class: CommandLineTool
baseCommand: blend
label: blend-bio_blend
doc: "A fast and accurate tool for mapping and overlapping long and short reads using
  strobemers and minimizers.\n\nTool homepage: https://github.com/CMU-SAFARI/BLEND"
inputs:
  - id: target
    type: File
    doc: Target fasta file or index file
    inputBinding:
      position: 1
  - id: query
    type:
      - 'null'
      - type: array
        items: File
    doc: Query fasta file(s)
    inputBinding:
      position: 2
  - id: chaining_bandwidth
    type:
      - 'null'
      - string
    doc: chaining/alignment bandwidth and long-join bandwidth
    inputBinding:
      position: 103
      prefix: -r
  - id: dump_index
    type:
      - 'null'
      - File
    doc: dump index to FILE
    inputBinding:
      position: 103
      prefix: -d
  - id: filter_repetitive
    type:
      - 'null'
      - float
    doc: filter out top FLOAT fraction of repetitive minimizers
    inputBinding:
      position: 103
      prefix: -f
  - id: fixed_bits
    type:
      - 'null'
      - int
    doc: BLEND uses INT number of bits when generating hash values of seeds rather
      than using 2*k number of bits. Useful when collision rate needs to be decreased
      than 2*k bits. Setting this option to 0 uses 2*k bits for hash values.
    inputBinding:
      position: 103
      prefix: --fixed-bits
  - id: gap_extension_penalty
    type:
      - 'null'
      - string
    doc: gap extension penalty; a k-long gap costs min{O1+k*E1,O2+k*E2}
    inputBinding:
      position: 103
      prefix: -E
  - id: gap_open_penalty
    type:
      - 'null'
      - string
    doc: gap open penalty
    inputBinding:
      position: 103
      prefix: -O
  - id: homopolymer_compressed
    type:
      - 'null'
      - boolean
    doc: use homopolymer-compressed k-mer (preferrable for PacBio)
    inputBinding:
      position: 103
      prefix: -H
  - id: immediate
    type:
      - 'null'
      - boolean
    doc: use the hash values of consecutive k-mers to generate the hash values of
      seeds (defualt behavior).
    inputBinding:
      position: 103
      prefix: --immediate
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size (no larger than 28)
    inputBinding:
      position: 103
      prefix: -k
  - id: long_cigar
    type:
      - 'null'
      - boolean
    doc: write CIGAR with >65535 ops at the CG tag
    inputBinding:
      position: 103
      prefix: -L
  - id: matching_score
    type:
      - 'null'
      - int
    doc: matching score
    inputBinding:
      position: 103
      prefix: -A
  - id: max_fragment_length
    type:
      - 'null'
      - int
    doc: max fragment length (effective with -xsr or in the fragment mode)
    inputBinding:
      position: 103
      prefix: -F
  - id: max_intron_length
    type:
      - 'null'
      - string
    doc: max intron length (effective with -xsplice; changing -r)
    inputBinding:
      position: 103
      prefix: -G
  - id: min_chaining_score
    type:
      - 'null'
      - int
    doc: minimal chaining score (matching bases minus log gap penalty)
    inputBinding:
      position: 103
      prefix: -m
  - id: min_minimizers_on_chain
    type:
      - 'null'
      - int
    doc: minimal number of minimizers on a chain
    inputBinding:
      position: 103
      prefix: -n
  - id: min_peak_dp_score
    type:
      - 'null'
      - int
    doc: minimal peak DP alignment score
    inputBinding:
      position: 103
      prefix: -s
  - id: min_secondary_primary_ratio
    type:
      - 'null'
      - float
    doc: min secondary-to-primary score ratio
    inputBinding:
      position: 103
      prefix: -p
  - id: minibatch_size
    type:
      - 'null'
      - string
    doc: minibatch size for mapping
    inputBinding:
      position: 103
      prefix: -K
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: mismatch penalty (larger value for lower divergence)
    inputBinding:
      position: 103
      prefix: -B
  - id: neighbors
    type:
      - 'null'
      - int
    doc: Combines INT amount of k-mers to generate a seed.
    inputBinding:
      position: 103
      prefix: --neighbors
  - id: output_cigar_paf
    type:
      - 'null'
      - boolean
    doc: output CIGAR in PAF
    inputBinding:
      position: 103
      prefix: -c
  - id: output_cs_tag
    type:
      - 'null'
      - string
    doc: output the cs tag; STR is 'short' (if absent) or 'long'
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
    doc: 'preset (always applied before other options: map-pb/map-ont, map-hifi, ava-pb/ava-ont/ava-hifi,
      sr)'
    inputBinding:
      position: 103
      prefix: -x
  - id: retain_secondary_alignments
    type:
      - 'null'
      - int
    doc: retain at most INT secondary alignments
    inputBinding:
      position: 103
      prefix: -N
  - id: sam_read_group
    type:
      - 'null'
      - string
    doc: SAM read group line in a format like '@RG\tID:foo\tSM:bar'
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
  - id: soft_clipping
    type:
      - 'null'
      - boolean
    doc: use soft clipping for supplementary alignments
    inputBinding:
      position: 103
      prefix: -Y
  - id: splice_strand_mode
    type:
      - 'null'
      - string
    doc: how to find GT-AG. f:transcript strand, b:both strands, n:don't match GT-AG
    inputBinding:
      position: 103
      prefix: -u
  - id: split_index
    type:
      - 'null'
      - string
    doc: split index for every ~NUM input bases
    inputBinding:
      position: 103
      prefix: -I
  - id: stop_chain_elongation
    type:
      - 'null'
      - int
    doc: stop chain enlongation if there are no minimizers in INT-bp
    inputBinding:
      position: 103
      prefix: -g
  - id: strobemers
    type:
      - 'null'
      - boolean
    doc: link minimizers rather than the preceding k-mers of a single minimizer. (Number
      of minimizers to link is defined by --neighbors.)
    inputBinding:
      position: 103
      prefix: --strobemers
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 103
      prefix: -t
  - id: window_size
    type:
      - 'null'
      - int
    doc: minimizer window size
    inputBinding:
      position: 103
      prefix: -w
  - id: write_eqx
    type:
      - 'null'
      - boolean
    doc: write =/X CIGAR operators
    inputBinding:
      position: 103
      prefix: --eqx
  - id: z_drop_score
    type:
      - 'null'
      - string
    doc: Z-drop score and inversion Z-drop score
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
    dockerPull: quay.io/biocontainers/blend-bio:1.0.0--h577a1d6_3
