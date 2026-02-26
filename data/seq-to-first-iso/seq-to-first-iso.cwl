cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq-to-first-iso
label: seq-to-first-iso
doc: "Read a tsv file with sequences and charges and compute intensity of first isotopologues\n\
  \nTool homepage: https://github.com/pierrepo/seq-to-first-iso"
inputs:
  - id: input_file_name
    type: File
    doc: file to parse in .tsv format
    inputBinding:
      position: 1
  - id: sequence_col_name
    type: string
    doc: column name with sequences
    inputBinding:
      position: 2
  - id: charge_col_name
    type: string
    doc: column name with charges
    inputBinding:
      position: 3
  - id: unlabelled_aa
    type:
      - 'null'
      - string
    doc: amino acids with default abundance
    inputBinding:
      position: 104
      prefix: --unlabelled-aa
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: name of output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq-to-first-iso:1.1.0--py_0
