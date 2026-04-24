cwlVersion: v1.2
class: CommandLineTool
baseCommand: minimap2
label: fec_minimap2
doc: "Minimap2 is a versatile tool for sequence alignment. It is particularly well-suited
  for aligning long reads (e.g., PacBio CLR, HiFi, Nanopore) to reference genomes,
  but can also be used for short read alignment, assembly-to-reference mapping, and
  read overlap detection.\n\nTool homepage: https://github.com/zhangjuncsu/Fec"
inputs:
  - id: target_file
    type: File
    doc: Target sequence file (FASTA or index)
    inputBinding:
      position: 1
  - id: query_file
    type:
      - 'null'
      - File
    doc: Query sequence file (FASTA)
    inputBinding:
      position: 2
  - id: query_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional query sequence files (FASTA)
    inputBinding:
      position: 3
  - id: chaining_bandwidth
    type:
      - 'null'
      - string
    doc: Chaining/alignment bandwidth and long-join bandwidth
    inputBinding:
      position: 104
      prefix: -r
  - id: dump_index_file
    type:
      - 'null'
      - File
    doc: Dump index to FILE
    inputBinding:
      position: 104
      prefix: -d
  - id: filter_repetitive_minimizers
    type:
      - 'null'
      - float
    doc: Filter out top FLOAT fraction of repetitive minimizers
    inputBinding:
      position: 104
      prefix: -f
  - id: gap_extension_penalty
    type:
      - 'null'
      - string
    doc: Gap extension penalty; a k-long gap costs min{O1+k*E1,O2+k*E2}
    inputBinding:
      position: 104
      prefix: -E
  - id: gap_open_penalty
    type:
      - 'null'
      - string
    doc: Gap open penalty
    inputBinding:
      position: 104
      prefix: -O
  - id: gtag_ag_finding
    type:
      - 'null'
      - string
    doc: How to find GT-AG. f:transcript strand, b:both strands, n:don't match 
      GT-AG
    inputBinding:
      position: 104
      prefix: -u
  - id: homopolymer_compressed_kmer
    type:
      - 'null'
      - boolean
    doc: Use homopolymer-compressed k-mer (preferable for PacBio)
    inputBinding:
      position: 104
      prefix: -H
  - id: index_split_size
    type:
      - 'null'
      - string
    doc: Split index for every ~NUM input bases
    inputBinding:
      position: 104
      prefix: -I
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
    doc: Matching score
    inputBinding:
      position: 104
      prefix: -A
  - id: max_fragment_length
    type:
      - 'null'
      - string
    doc: Max fragment length (effective with -xsr or in the fragment mode)
    inputBinding:
      position: 104
      prefix: -F
  - id: max_intron_length
    type:
      - 'null'
      - string
    doc: Max intron length (effective with -xsplice; changing -r)
    inputBinding:
      position: 104
      prefix: -G
  - id: max_secondary_alignments
    type:
      - 'null'
      - int
    doc: Retain at most INT secondary alignments
    inputBinding:
      position: 104
      prefix: -N
  - id: min_chain_minimizers
    type:
      - 'null'
      - int
    doc: Minimal number of minimizers on a chain
    inputBinding:
      position: 104
      prefix: -n
  - id: min_chaining_score
    type:
      - 'null'
      - int
    doc: Minimal chaining score (matching bases minus log gap penalty)
    inputBinding:
      position: 104
      prefix: -m
  - id: min_peak_dp_alignment_score
    type:
      - 'null'
      - int
    doc: Minimal peak DP alignment score
    inputBinding:
      position: 104
      prefix: -s
  - id: min_secondary_to_primary_score_ratio
    type:
      - 'null'
      - float
    doc: Min secondary-to-primary score ratio
    inputBinding:
      position: 104
      prefix: -p
  - id: minibatch_size
    type:
      - 'null'
      - string
    doc: Minibatch size for mapping
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
    doc: Mismatch penalty (larger value for lower divergence)
    inputBinding:
      position: 104
      prefix: -B
  - id: output_cs_tag
    type:
      - 'null'
      - string
    doc: Output the cs tag; STR is 'short' (if absent) or 'long'
    inputBinding:
      position: 104
      prefix: --cs
  - id: output_ds_tag
    type:
      - 'null'
      - boolean
    doc: Output the ds tag, which is an extension to cs
    inputBinding:
      position: 104
      prefix: --ds
  - id: output_md_tag
    type:
      - 'null'
      - boolean
    doc: Output the MD tag
    inputBinding:
      position: 104
      prefix: --MD
  - id: output_paf_cigar
    type:
      - 'null'
      - boolean
    doc: Output CIGAR in PAF
    inputBinding:
      position: 104
      prefix: -c
  - id: output_sam
    type:
      - 'null'
      - boolean
    doc: Output in the SAM format (PAF by default)
    inputBinding:
      position: 104
      prefix: -a
  - id: preset
    type:
      - 'null'
      - string
    doc: Preset (always applied before other options; see minimap2.1 for 
      details)
    inputBinding:
      position: 104
      prefix: -x
  - id: sam_read_group
    type:
      - 'null'
      - string
    doc: SAM read group line in a format like '@RG\tID:foo\tSM:bar'
    inputBinding:
      position: 104
      prefix: -R
  - id: skip_self_dual_mappings
    type:
      - 'null'
      - boolean
    doc: Skip self and dual mappings (for the all-vs-all mode)
    inputBinding:
      position: 104
      prefix: -X
  - id: splice_mode
    type:
      - 'null'
      - int
    doc: 'Splice mode. 0: original minimap2 model; 1: miniprot model'
    inputBinding:
      position: 104
      prefix: -J
  - id: stop_chain_elongation_gap
    type:
      - 'null'
      - int
    doc: Stop chain elongation if there are no minimizers in INT-bp
    inputBinding:
      position: 104
      prefix: -g
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 104
      prefix: -t
  - id: use_soft_clipping_for_supplementary
    type:
      - 'null'
      - boolean
    doc: Use soft clipping for supplementary alignments
    inputBinding:
      position: 104
      prefix: -Y
  - id: write_cigar_large_ops
    type:
      - 'null'
      - boolean
    doc: Write CIGAR with >65535 ops at the CG tag
    inputBinding:
      position: 104
      prefix: -L
  - id: write_eqx_cigar_operators
    type:
      - 'null'
      - boolean
    doc: Write =/X CIGAR operators
    inputBinding:
      position: 104
      prefix: --eqx
  - id: zdrop_score
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
    doc: Output alignments to FILE [stdout]
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fec:1.0.1--he70b90d_2
