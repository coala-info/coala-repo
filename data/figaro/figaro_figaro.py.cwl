cwlVersion: v1.2
class: CommandLineTool
baseCommand: figaro_figaro.py
label: figaro_figaro.py
doc: "Figaro is a tool for analyzing amplicon sequencing data.\n\nTool homepage: https://github.com/Zymo-Research/figaro"
inputs:
  - id: amplicon_length
    type: int
    doc: Length of the amplicon
    inputBinding:
      position: 101
  - id: forward_primer_length
    type: int
    doc: Length of the forward primer
    inputBinding:
      position: 101
  - id: input_directory
    type: Directory
    doc: Directory containing input files
    inputBinding:
      position: 101
  - id: reverse_primer_length
    type: int
    doc: Length of the reverse primer
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/figaro:1.1.2--hdfd78af_0
stdout: figaro_figaro.py.out
