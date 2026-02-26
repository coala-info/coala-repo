cwlVersion: v1.2
class: CommandLineTool
baseCommand: dagchainer
label: dagchainer
doc: "Find chains of homologous blocks between two genomes.\n\nTool homepage: https://github.com/kullrich/dagchainer"
inputs:
  - id: filename
    type: File
    doc: Input filename
    inputBinding:
      position: 1
  - id: gap_extension_penalty
    type: float
    doc: gap extension penalty
    inputBinding:
      position: 102
      prefix: -E
  - id: gap_open_penalty
    type: float
    doc: gap open penalty
    inputBinding:
      position: 102
      prefix: -O
  - id: max_distance_between_matches
    type: int
    doc: max distance between matches
    inputBinding:
      position: 102
      prefix: -D
  - id: min_alignment_score
    type: int
    doc: min alignment score
    inputBinding:
      position: 102
      prefix: -S
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: reverse 2nd coordinate list
    inputBinding:
      position: 102
      prefix: -r
  - id: single_gap_length_in_bp
    type: int
    doc: single gap length in bp
    inputBinding:
      position: 102
      prefix: -G
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dagchainer:r120920--h9948957_5
stdout: dagchainer.out
