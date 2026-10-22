cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smof
  - wc
label: smof_wc
doc: "Output the total number of entries and the total sequence length (TAB delimited).\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: chars
    type:
      - 'null'
      - boolean
    doc: "Write the summed length of all sequences"
    inputBinding:
      position: 100
      prefix: --chars
  - id: lines
    type:
      - 'null'
      - boolean
    doc: "Write the total number of sequences"
    inputBinding:
      position: 101
      prefix: --lines
  - id: input_file
    type: File
    doc: "Input FASTA file (smof reads standard input by default)"
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_wc.out
