cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - run-mummer1
label: mummer_run-mummer1
doc: "Run the (antiquated) MUMmer 1 suite: find MUMs, determine gaps and align the gaps.\n\nTool homepage: https://github.com/mummer4/mummer"
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
    doc: "Fasta query"
    inputBinding:
      position: 101
  - id: prefix
    type: string
    doc: "Prefix of the output files"
    inputBinding:
      position: 102
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: "Reverse complement the query sequence; coordinates of the reverse matches will be relative to the reversed sequence"
    inputBinding:
      position: 103
      prefix: "-r"
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
    doc: "Gaps between the matches"
    outputBinding:
      glob: "$(inputs.prefix).gaps"
  - id: align_out
    type:
      - 'null'
      - File
    doc: "Alignments of the gaps"
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
stderr: mummer_run-mummer1.log
