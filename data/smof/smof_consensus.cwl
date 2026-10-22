cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smof
  - consensus
label: smof_consensus
doc: "Find the most common character in each column of an aligned FASTA file; ties are resolved alphabetically.\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: table
    type:
      - 'null'
      - boolean
    doc: "Print count table instead of consensus"
    inputBinding:
      position: 100
      prefix: --table
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
stdout: smof_consensus.out
