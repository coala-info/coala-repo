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
  - id: output_path
    type:
      - 'null'
      - string
    doc: Name of the output file without extension (the tool adds .tsv). Default is
      the input file name plus _stfi
    inputBinding:
      position: 105
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Table with the added formula, mass and first isotopologue intensities
    outputBinding:
      glob: "$(inputs.output_path ? inputs.output_path + '.tsv' : inputs.input_file_name.nameroot + '_stfi.tsv')"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq-to-first-iso:1.1.0--py_0
