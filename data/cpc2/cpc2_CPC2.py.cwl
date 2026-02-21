cwlVersion: v1.2
class: CommandLineTool
baseCommand: CPC2.py
label: cpc2_CPC2.py
doc: "CPC2 (Coding Potential Calculator 2) is a fast and accurate tool to assess the
  coding potential of RNA sequences.\n\nTool homepage: https://github.com/gao-lab/CPC2_standalone"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpc2:1.0.1--hdfd78af_0
stdout: cpc2_CPC2.py.out
