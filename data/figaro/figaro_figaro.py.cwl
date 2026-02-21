cwlVersion: v1.2
class: CommandLineTool
baseCommand: figaro_figaro.py
label: figaro_figaro.py
doc: "Figaro is a tool designed to determine the optimal truncation parameters for
  DADA2 processing of Illumina amplicon sequences.\n\nTool homepage: https://github.com/Zymo-Research/figaro"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/figaro:1.1.2--hdfd78af_0
stdout: figaro_figaro.py.out
