cwlVersion: v1.2
class: CommandLineTool
baseCommand: massiveqc
label: massiveqc
doc: "MassiveQC is a tool for quality control of mass spectrometry data.\n\nTool homepage:
  https://github.com/shimw6828/MassiveQC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/massiveqc:0.1.2--pyh086e186_0
stdout: massiveqc.out
