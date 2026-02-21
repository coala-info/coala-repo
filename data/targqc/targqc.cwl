cwlVersion: v1.2
class: CommandLineTool
baseCommand: targqc
label: targqc
doc: "Targeted sequencing Quality Control tool\n\nTool homepage: https://github.com/vladsaveliev/TargQC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/targqc:1.8.1--py37hb3f55d8_0
stdout: targqc.out
