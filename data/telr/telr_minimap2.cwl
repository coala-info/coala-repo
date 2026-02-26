cwlVersion: v1.2
class: CommandLineTool
baseCommand: minimap2
label: telr_minimap2
doc: "Minimap2 is a versatile tool for sequence alignment. It can be used for various
  tasks including indexing reference genomes, mapping long reads (PacBio, Nanopore),
  short reads, and performing overlap detection for assembly.\n\nTool homepage: https://github.com/bergmanlab/telr"
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
  - id: chaining_bandwidth
    type:
      - 'null'
      - string
    doc: chaining/alignment bandwidth and long-join bandwidth
    default: 500,20000
    inputBinding:
      position: 104
      prefix: -r
  - id: cs_tag
    type:
      - 'null'
      - string
    doc: output the cs tag; STR is 'short' (if absent) or 'long' [none]
    inputBinding:
      position: 104
      prefix: --cs
  - id: dump_index_file
    type:
      - 'null'
      - File
    doc: dump index to FILE []
    inputBinding:
      position: 104
      prefix: -d
  - id: filter_repetitive_minimizers
    type:
      - 'null'
      - float
    doc: filter out top FLOAT fraction of repetitive minimizers
    default: 0.0002
    inputBinding:
      position: 104
      prefix: -f
  - id: gap_extension_penalty
    type:
      - 'null'
      - string
    doc: gap extension penalty; a k-long gap costs min{O1+k*E1,O2+k*E2}
    default: 2,1
    inputBinding:
      position: 104
      prefix: -E
  - id: gap_open_penalty
    type:
      - 'null'
      - string
    doc: gap open penalty
    default: 4,24
    inputBinding:
      position: 104
      prefix: -O
  - id: gt_ag_handling
    type:
      - 'null'
      - string
    doc: how to find GT-AG. f:transcript strand, b:both strands, n:don't match 
      GT-AG
    default: n
    inputBinding:
      position: 104
      prefix: -u
  - id: homopolymer_compressed_kmer
    type:
      - 'null'
      - boolean
    doc: use homopolymer-compressed k-mer (preferrable for PacBio)
    inputBinding:
      position: 104
      prefix: -H
  - id: index_split_size
    type:
      - 'null'
      - string
    doc: split index for every ~NUM input bases [8G]
    inputBinding:
      position: 104
      prefix: -I
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size (no larger than 28)
    default: 15
    inputBinding:
      position: 104
      prefix: -k
  - id: matching_score
    type:
      - 'null'
      - int
    doc: matching score
    default: 2
    inputBinding:
      position: 104
      prefix: -A
  - id: max_chain_gap_bp
    type:
      - 'null'
      - int
    doc: stop chain enlongation if there are no minimizers in INT-bp
    default: 5000
    inputBinding:
      position: 104
      prefix: -g
  - id: max_fragment_length
    type:
      - 'null'
      - string
    doc: max fragment length (effective with -xsr or in the fragment mode)
    default: '800'
    inputBinding:
      position: 104
      prefix: -F
  - id: max_intron_length
    type:
      - 'null'
      - string
    doc: max intron length (effective with -xsplice; changing -r)
    default: 200k
    inputBinding:
      position: 104
      prefix: -G
  - id: max_secondary_alignments
    type:
      - 'null'
      - int
    doc: retain at most INT secondary alignments
    default: 5
    inputBinding:
      position: 104
      prefix: -N
  - id: min_chaining_score
    type:
      - 'null'
      - int
    doc: minimal chaining score (matching bases minus log gap penalty)
    default: 40
    inputBinding:
      position: 104
      prefix: -m
  - id: min_minimizers_on_chain
    type:
      - 'null'
      - int
    doc: minimal number of minimizers on a chain
    default: 3
    inputBinding:
      position: 104
      prefix: -n
  - id: min_peak_dp_alignment_score
    type:
      - 'null'
      - int
    doc: minimal peak DP alignment score
    default: 80
    inputBinding:
      position: 104
      prefix: -s
  - id: min_secondary_to_primary_score_ratio
    type:
      - 'null'
      - float
    doc: min secondary-to-primary score ratio
    default: 0.8
    inputBinding:
      position: 104
      prefix: -p
  - id: minibatch_size
    type:
      - 'null'
      - string
    doc: minibatch size for mapping
    default: 500M
    inputBinding:
      position: 104
      prefix: -K
  - id: minimizer_window_size
    type:
      - 'null'
      - int
    doc: minimizer window size
    default: 10
    inputBinding:
      position: 104
      prefix: -w
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: mismatch penalty (larger value for lower divergence)
    default: 4
    inputBinding:
      position: 104
      prefix: -B
  - id: output_eqx
    type:
      - 'null'
      - boolean
    doc: write =/X CIGAR operators
    inputBinding:
      position: 104
      prefix: --eqx
  - id: output_md_tag
    type:
      - 'null'
      - boolean
    doc: output the MD tag
    inputBinding:
      position: 104
      prefix: --MD
  - id: output_paf_cigar
    type:
      - 'null'
      - boolean
    doc: output CIGAR in PAF
    inputBinding:
      position: 104
      prefix: -c
  - id: output_sam
    type:
      - 'null'
      - boolean
    doc: output in the SAM format (PAF by default)
    inputBinding:
      position: 104
      prefix: -a
  - id: preset
    type:
      - 'null'
      - string
    doc: preset (always applied before other options; see minimap2.1 for 
      details)
    default: ''
    inputBinding:
      position: 104
      prefix: -x
  - id: sam_read_group
    type:
      - 'null'
      - string
    doc: SAM read group line in a format like '@RG\tID:foo\tSM:bar' []
    inputBinding:
      position: 104
      prefix: -R
  - id: skip_self_dual_mappings
    type:
      - 'null'
      - boolean
    doc: skip self and dual mappings (for the all-vs-all mode)
    inputBinding:
      position: 104
      prefix: -X
  - id: splice_mode
    type:
      - 'null'
      - int
    doc: 'splice mode. 0: original minimap2 model; 1: miniprot model'
    default: 1
    inputBinding:
      position: 104
      prefix: -J
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 3
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
  - id: write_long_cigar
    type:
      - 'null'
      - boolean
    doc: write CIGAR with >65535 ops at the CG tag
    inputBinding:
      position: 104
      prefix: -L
  - id: zdrop_score
    type:
      - 'null'
      - string
    doc: Z-drop score and inversion Z-drop score
    default: 400,200
    inputBinding:
      position: 104
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
    dockerPull: quay.io/biocontainers/telr:1.1--pyhdfd78af_0
