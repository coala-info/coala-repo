cwlVersion: v1.2
class: CommandLineTool
baseCommand: combineMUMs
label: mummer4_combineMUMs
doc: "Combines MUMs in the gaps file by extending matches off ends and between MUMs.\n\nTool homepage: https://mummer4.github.io/"
inputs:
  - id: differences_only
    type:
      - 'null'
      - boolean
    doc: Only output to stdout the difference positions and characters
    inputBinding:
      position: 10
      prefix: -D
  - id: nucleotides_only
    type:
      - 'null'
      - boolean
    doc: "Allow matches only between nucleotides, i.e. ACGTs"
    inputBinding:
      position: 10
      prefix: -n
  - id: break_non_acgt
    type:
      - 'null'
      - int
    doc: Break matches at this number or more consecutive non-ACGTs
    inputBinding:
      position: 10
      prefix: -N
  - id: query_tag
    type:
      - 'null'
      - string
    doc: Tag used to label the query match
    inputBinding:
      position: 10
      prefix: -q
  - id: reference_tag
    type:
      - 'null'
      - string
    doc: Tag used to label the reference match
    inputBinding:
      position: 10
      prefix: -r
  - id: all_differences_strings
    type:
      - 'null'
      - boolean
    doc: Output all differences in strings
    inputBinding:
      position: 10
      prefix: -S
  - id: label_query_header
    type:
      - 'null'
      - boolean
    doc: Label query matches with the query FASTA header
    inputBinding:
      position: 10
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - int
    doc: Verbose level for extra output
    inputBinding:
      position: 10
      prefix: -v
  - id: witherrors_file
    type:
      - 'null'
      - string
    doc: Reset the default output file name witherrors.gaps
    inputBinding:
      position: 10
      prefix: -W
  - id: no_cover_files
    type:
      - 'null'
      - boolean
    doc: Do not output .cover files
    inputBinding:
      position: 10
      prefix: -x
  - id: error_rate
    type:
      - 'null'
      - float
    doc: Error-rate cutoff (for example 0.02 is two percent)
    inputBinding:
      position: 10
      prefix: -e
  - id: ref_sequence
    type: File
    doc: Reference sequence (FASTA)
    inputBinding:
      position: 201
  - id: match_sequences
    type: File
    doc: Multi-FASTA file of the sequences matched against the reference
    inputBinding:
      position: 202
  - id: gaps_file
    type: File
    doc: Gaps file (output of mgaps)
    inputBinding:
      position: 203
outputs:
  - id: combined
    type: stdout
    doc: Combined matches (standard output)
  - id: cover_files
    type:
      type: array
      items: File
    doc: Coverage files
    outputBinding:
      glob: "*.cover"
  - id: witherrors
    type:
      - 'null'
      - File
    doc: Gaps with errors file
    outputBinding:
      glob: "$(inputs.witherrors_file || \"witherrors.gaps\")"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
stdout: mummer4_combineMUMs.out
