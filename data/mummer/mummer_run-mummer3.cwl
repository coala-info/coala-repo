cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - run-mummer3
label: mummer_run-mummer3
doc: "Run the basic MUMmer 3 suite (mummer, mgaps and combineMUMs); nucmer should be used instead when possible.\n\nTool homepage: https://github.com/mummer4/mummer"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: reference
    type: File
    doc: "Fasta reference"
    inputBinding:
      position: 100
  - id: query
    type: File
    doc: "Multi-fasta query"
    inputBinding:
      position: 101
  - id: prefix
    type: string
    doc: "Prefix of the output files"
    inputBinding:
      position: 102
outputs:
  - id: out_out
    type:
      - 'null'
      - File
    doc: "MUM matches"
    outputBinding:
      glob: "$(inputs.prefix).out"
  - id: gaps_out
    type:
      - 'null'
      - File
    doc: "MUM clusters"
    outputBinding:
      glob: "$(inputs.prefix).gaps"
  - id: align_out
    type:
      - 'null'
      - File
    doc: "Alignments"
    outputBinding:
      glob: "$(inputs.prefix).align"
  - id: errorsgaps_out
    type:
      - 'null'
      - File
    doc: "Gaps with errors"
    outputBinding:
      glob: "$(inputs.prefix).errorsgaps"
  - id: log
    type: stderr
    doc: "Progress messages"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
stderr: mummer_run-mummer3.log
