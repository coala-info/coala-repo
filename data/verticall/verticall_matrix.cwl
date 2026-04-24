cwlVersion: v1.2
class: CommandLineTool
baseCommand: verticall_matrix
label: verticall_matrix
doc: "produce a PHYLIP distance matrix\n\nTool homepage: https://github.com/rrwick/Verticall"
inputs:
  - id: asymmetrical
    type:
      - 'null'
      - boolean
    doc: Do not average pairs to make symmetrical matrices
    inputBinding:
      position: 101
      prefix: --asymmetrical
  - id: distance_type
    type:
      - 'null'
      - string
    doc: Which distance to use in matrix
    inputBinding:
      position: 101
      prefix: --distance_type
  - id: exclude_names
    type:
      - 'null'
      - string
    doc: Samples names to exclude from matrix (comma-delimited)
    inputBinding:
      position: 101
      prefix: --exclude_names
  - id: in_file
    type: File
    doc: Filename of TSV created by vertical pairwise
    inputBinding:
      position: 101
      prefix: --in_file
  - id: include_names
    type:
      - 'null'
      - string
    doc: Samples names to include in matrix (comma-delimited)
    inputBinding:
      position: 101
      prefix: --include_names
  - id: multi
    type:
      - 'null'
      - string
    doc: Behaviour when there are multiple results for a sample pair
    inputBinding:
      position: 101
      prefix: --multi
  - id: no_jukes_cantor
    type:
      - 'null'
      - boolean
    doc: Do not apply Jukes-Cantor correction
    inputBinding:
      position: 101
      prefix: --no_jukes_cantor
outputs:
  - id: out_file
    type: File
    doc: Filename of PHYLIP matrix output
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/verticall:0.4.3--pyhdfd78af_0
