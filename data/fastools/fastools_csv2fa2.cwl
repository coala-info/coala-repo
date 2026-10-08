cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastools
  - csv2fa2
label: fastools_csv2fa2
doc: "Convert a CSV file to two FASTA files.\n\nTool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 1
  - id: output_1
    type: string
    doc: first output FASTA file (second CSV column)
    inputBinding:
      position: 2
  - id: output_2
    type: string
    doc: second output FASTA file (third CSV column)
    inputBinding:
      position: 3
  - id: skip_first_line
    type:
      - 'null'
      - boolean
    doc: skip the first line of the CSV file
    inputBinding:
      position: 4
      prefix: -s
outputs:
  - id: out_output_1
    type:
      - 'null'
      - File
    doc: First FASTA file.
    outputBinding:
      glob: $(inputs.output_1)
  - id: out_output_2
    type:
      - 'null'
      - File
    doc: Second FASTA file.
    outputBinding:
      glob: $(inputs.output_2)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
