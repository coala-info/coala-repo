cwlVersion: v1.2
class: CommandLineTool
baseCommand: minimap2
label: ptgaul_minimap2
doc: "A versatile pairwise aligner for genomic and transcribed nucleotide sequences\n\
  \nTool homepage: https://github.com/Bean061/ptgaul"
inputs:
  - id: target
    type: File
    doc: Target sequence file (.fa) or index (.idx)
    inputBinding:
      position: 1
  - id: query
    type:
      - 'null'
      - type: array
        items: File
    doc: Query sequence file(s)
    inputBinding:
      position: 2
  - id: chaining_bandwidth
    type:
      - 'null'
      - string
    doc: chaining/alignment bandwidth and long-join bandwidth
    default: 500,20000
    inputBinding:
      position: 103
      prefix: -r
  - id: filter_repetitive
    type:
      - 'null'
      - float
    doc: filter out top FLOAT fraction of repetitive minimizers
    default: 0.0002
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
  - id: homopolymer_compressed
    type:
      - 'null'
      - boolean
    doc: use homopolymer-compressed k-mer (preferrable for PacBio)
    inputBinding:
      position: 103
      prefix: -H
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size (no larger than 28)
    default: 15
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
    default: 2
    inputBinding:
      position: 103
      prefix: -A
  - id: max_fragment_length
    type:
      - 'null'
      - int
    doc: max fragment length (effective with -xsr or in the fragment mode)
    default: 800
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
  - id: max_secondary_alignments
    type:
      - 'null'
      - int
    doc: retain at most INT secondary alignments
    default: 5
    inputBinding:
      position: 103
      prefix: -N
  - id: min_chaining_score
    type:
      - 'null'
      - int
    doc: minimal chaining score (matching bases minus log gap penalty)
    default: 40
    inputBinding:
      position: 103
      prefix: -m
  - id: min_minimizers
    type:
      - 'null'
      - int
    doc: minimal number of minimizers on a chain
    default: 3
    inputBinding:
      position: 103
      prefix: -n
  - id: min_peak_dp_score
    type:
      - 'null'
      - int
    doc: minimal peak DP alignment score
    default: 80
    inputBinding:
      position: 103
      prefix: -s
  - id: min_secondary_score_ratio
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
    default: 500M
    inputBinding:
      position: 103
      prefix: -K
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: mismatch penalty (larger value for lower divergence)
    default: 4
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
    doc: preset (always applied before other options; e.g., map-pb, map-ont, 
      asm5, sr, etc.)
    inputBinding:
      position: 103
      prefix: -x
  - id: read_group
    type:
      - 'null'
      - string
    doc: SAM read group line in a format like '@RG\tID:foo\tSM:bar'
    inputBinding:
      position: 103
      prefix: -R
  - id: skip_self_dual
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
  - id: splice_mode
    type:
      - 'null'
      - int
    doc: 'splice mode. 0: original minimap2 model; 1: miniprot model'
    default: 1
    inputBinding:
      position: 103
      prefix: -J
  - id: splice_strand_finding
    type:
      - 'null'
      - string
    doc: how to find GT-AG. f:transcript strand, b:both strands, n:don't match 
      GT-AG
    default: n
    inputBinding:
      position: 103
      prefix: -u
  - id: split_index
    type:
      - 'null'
      - string
    doc: split index for every ~NUM input bases
    default: 8G
    inputBinding:
      position: 103
      prefix: -I
  - id: stop_chain_elongation
    type:
      - 'null'
      - int
    doc: stop chain enlongation if there are no minimizers in INT-bp
    default: 5000
    inputBinding:
      position: 103
      prefix: -g
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 3
    inputBinding:
      position: 103
      prefix: -t
  - id: use_eqx
    type:
      - 'null'
      - boolean
    doc: write =/X CIGAR operators
    inputBinding:
      position: 103
      prefix: --eqx
  - id: window_size
    type:
      - 'null'
      - int
    doc: minimizer window size
    default: 10
    inputBinding:
      position: 103
      prefix: -w
  - id: z_drop_score
    type:
      - 'null'
      - string
    doc: Z-drop score and inversion Z-drop score
    default: 400,200
    inputBinding:
      position: 103
      prefix: -z
outputs:
  - id: dump_index
    type:
      - 'null'
      - File
    doc: dump index to FILE
    outputBinding:
      glob: $(inputs.dump_index)
  - id: output_file
    type:
      - 'null'
      - File
    doc: output alignments to FILE
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
