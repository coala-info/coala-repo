cwlVersion: v1.2
class: CommandLineTool
baseCommand: smof wc
label: smof_wc
doc: "Outputs the total number of entries and the total sequence length (TAB\n delimited).\n\
  \nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: input fasta sequence (default = stdin)
    inputBinding:
      position: 1
  - id: chars
    type:
      - 'null'
      - boolean
    doc: writes the summed length of all sequences
    inputBinding:
      position: 102
      prefix: --chars
  - id: lines
    type:
      - 'null'
      - boolean
    doc: writes the total number of sequences
    inputBinding:
      position: 102
      prefix: --lines
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_wc.out
