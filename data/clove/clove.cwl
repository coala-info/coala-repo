cwlVersion: v1.2
class: CommandLineTool
baseCommand: clove
label: clove
doc: "CLOVE (Characterization of LOng-range Variant Evidence) is a tool for integrating
  structural variant calls from multiple algorithms.\n\nTool homepage: https://github.com/PapenfussLab/clove"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clove:0.17--py36_0
stdout: clove.out
