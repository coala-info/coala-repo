cwlVersion: v1.2
class: CommandLineTool
baseCommand: trim_matrix.py
label: phyloaln_trim_matrix.py
doc: "Trims a multiple sequence alignment matrix based on specified criteria for columns
  and rows.\n\nTool homepage: https://github.com/huangyh45/PhyloAln"
inputs:
  - id: input_dir
    type: Directory
    doc: Directory containing the input alignment files.
    inputBinding:
      position: 1
  - id: unknown_symbol
    type:
      - 'null'
      - string
    doc: Symbol representing unknown characters.
    default: X
    inputBinding:
      position: 102
  - id: known_number_or_percent_for_columns
    type:
      - 'null'
      - float
    doc: 'Threshold for columns: either a number of known sites (>=1) or a percentage
      (<1) to keep.'
    default: 0.5
    inputBinding:
      position: 102
  - id: known_number_or_percent_for_rows
    type:
      - 'null'
      - float
    doc: 'Threshold for rows: either a number of known sites (>=1) or a percentage
      (<1) to keep.'
    default: 0
    inputBinding:
      position: 102
  - id: fasta_suffix
    type:
      - 'null'
      - string
    doc: Suffix for FASTA files.
    default: .fa
    inputBinding:
      position: 102
outputs:
  - id: output_dir
    type: Directory
    doc: Directory to save the trimmed alignment files.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
