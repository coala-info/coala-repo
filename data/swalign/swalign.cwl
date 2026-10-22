cwlVersion: v1.2
class: CommandLineTool
baseCommand: swalign
label: swalign
doc: 'Simple Smith-Waterman aligner


  Tool homepage: https://github.com/mbreese/swalign/'
inputs:
  - id: ref
    type:
      - string
      - File
    doc: Reference sequence or FASTA file
    inputBinding:
      position: 101
  - id: query
    type:
      - string
      - File
    doc: Query sequence or FASTA file
    inputBinding:
      position: 102
  - id: full_query
    type:
      - 'null'
      - boolean
    doc: Align the full query sequence (mix of local/global)
    inputBinding:
      position: 1
      prefix: -query
  - id: gap_decay
    type:
      - 'null'
      - float
    doc: Decay the gap extension penalty
    inputBinding:
      position: 1
      prefix: -gapdecay
  - id: gap_extension_penalty
    type:
      - 'null'
      - int
    doc: Gap extension penalty
    inputBinding:
      position: 1
      prefix: -gapext
  - id: gap_penalty
    type:
      - 'null'
      - int
    doc: Gap penalty
    inputBinding:
      position: 1
      prefix: -gap
  - id: global_alignment
    type:
      - 'null'
      - boolean
    doc: Perform a global alignment (experimental)
    inputBinding:
      position: 1
      prefix: -global
  - id: match_score
    type:
      - 'null'
      - int
    doc: Match score
    inputBinding:
      position: 1
      prefix: -m
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: Mismatch penalty
    inputBinding:
      position: 1
      prefix: -mm
  - id: summary_file
    type:
      - 'null'
      - string
    doc: Write a summary files of match locations (tab-delimited)
    inputBinding:
      position: 1
      prefix: -summary
  - id: use_regions
    type:
      - 'null'
      - boolean
    doc: Use regions for coordinates if included in FASTA ref
    inputBinding:
      position: 1
      prefix: -useregion
  - id: wrap
    type:
      - 'null'
      - int
    doc: Wrap alignments when they are longer than N bases
    inputBinding:
      position: 1
      prefix: -wrap
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_summary_file
    type:
      - 'null'
      - File
    doc: Summary of match locations (tab-delimited)
    outputBinding:
      glob: $(inputs.summary_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/swalign:0.3.7--pyhdfd78af_0
stdout: swalign.out
