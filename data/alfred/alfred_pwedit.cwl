cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alfred
  - pwedit
label: alfred_pwedit
doc: "Pairwise sequence alignment and editing tool\n\nTool homepage: https://github.com/tobiasrausch/alfred"
inputs:
  - id: target_fasta
    type: File
    doc: Target FASTA file
    inputBinding:
      position: 1
  - id: query_fasta
    type: File
    doc: Query FASTA file
    inputBinding:
      position: 2
  - id: format
    type:
      - 'null'
      - string
    doc: output format [v|h]
    inputBinding:
      position: 103
      prefix: --format
  - id: mode
    type:
      - 'null'
      - string
    doc: alignment mode [global|prefix|infix]
    inputBinding:
      position: 103
      prefix: --mode
  - id: revcomp
    type:
      - 'null'
      - boolean
    doc: reverse complement query
    inputBinding:
      position: 103
      prefix: --revcomp
outputs:
  - id: alignment
    type:
      - 'null'
      - File
    doc: vertical/horizontal alignment
    outputBinding:
      glob: $(inputs.alignment)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
