cwlVersion: v1.2
class: CommandLineTool
baseCommand: mm2plus
label: mm2plus
doc: "Launch executable \"/usr/local/bin/mm2plus.avx2\"\n\nTool homepage: https://github.com/at-cg/mm2-plus"
inputs:
  - id: target_file
    type: File
    doc: Target FASTA file or index
    inputBinding:
      position: 1
  - id: query_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Query FASTA file(s)
    inputBinding:
      position: 2
  - id: chain_elongation_stop
    type:
      - 'null'
      - string
    doc: stop chain enlongation if there are no minimizers in INT-bp
    inputBinding:
      position: 103
      prefix: -g
  - id: chaining_bandwidth
    type:
      - 'null'
      - string
    doc: chaining/alignment bandwidth and long-join bandwidth
    inputBinding:
      position: 103
      prefix: -r
  - id: copy_fasta_comments
    type:
      - 'null'
      - boolean
    doc: copy FASTA/Q comments to output SAM
    inputBinding:
      position: 103
      prefix: -y
  - id: dump_index_file
    type:
      - 'null'
      - File
    doc: dump index to FILE
    inputBinding:
      position: 103
      prefix: -d
  - id: filter_repetitive_minimizers
    type:
      - 'null'
      - float
    doc: filter out top FLOAT fraction of repetitive minimizers
    inputBinding:
      position: 103
      prefix: -f
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
  - id: gtag_ag_finding
    type:
      - 'null'
      - string
    doc: how to find GT-AG. f:transcript strand, b:both strands, n:don't match 
      GT-AG
    inputBinding:
      position: 103
      prefix: -u
  - id: homopolymer_compressed
    type:
      - 'null'
      - boolean
    doc: use homopolymer-compressed k-mer (preferrable for PacBio)
    inputBinding:
      position: 103
      prefix: -H
  - id: index_split_size
    type:
      - 'null'
      - string
    doc: split index for every ~NUM input bases
    inputBinding:
      position: 103
      prefix: -I
  - id: junctions_bed_file
    type:
      - 'null'
      - File
    doc: junctions in BED12 to extend *short* RNA-seq alignment
    inputBinding:
      position: 103
      prefix: -j
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size (no larger than 28)
    inputBinding:
      position: 103
      prefix: -k
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
      - string
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
  - id: max_secondary_alignments
    type:
      - 'null'
      - int
    doc: retain at most INT secondary alignments
    inputBinding:
      position: 103
      prefix: -N
  - id: min_chain_minimizers
    type:
      - 'null'
      - int
    doc: minimal number of minimizers on a chain
    inputBinding:
      position: 103
      prefix: -n
  - id: min_chaining_score
    type:
      - 'null'
      - int
    doc: minimal chaining score (matching bases minus log gap penalty)
    inputBinding:
      position: 103
      prefix: -m
  - id: min_peak_dp_alignment_score
    type:
      - 'null'
      - int
    doc: minimal peak DP alignment score
    inputBinding:
      position: 103
      prefix: -s
  - id: min_secondary_to_primary_score_ratio
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
    doc: output the cs tag; STR is 'short' (if absent) or 'long' [none]
    inputBinding:
      position: 103
      prefix: --cs
  - id: output_ds_tag
    type:
      - 'null'
      - boolean
    doc: output the ds tag, which is an extension to cs
    inputBinding:
      position: 103
      prefix: --ds
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
    doc: preset (always applied before other options; see minimap2.1 for 
      details)
    inputBinding:
      position: 103
      prefix: -x
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
  - id: splice_mode
    type:
      - 'null'
      - int
    doc: 'splice mode. 0: original minimap2 model; 1: miniprot model'
    inputBinding:
      position: 103
      prefix: -J
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
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
    inputBinding:
      position: 103
      prefix: -w
  - id: write_eqx_cigar
    type:
      - 'null'
      - boolean
    doc: write =/X CIGAR operators
    inputBinding:
      position: 103
      prefix: --eqx
  - id: write_long_cigar
    type:
      - 'null'
      - boolean
    doc: write CIGAR with >65535 ops at the CG tag
    inputBinding:
      position: 103
      prefix: -L
  - id: zdrop_score
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
    doc: output alignments to FILE [stdout]
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mm2plus:1.2--h9ee0642_0
