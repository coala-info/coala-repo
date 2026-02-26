cwlVersion: v1.2
class: CommandLineTool
baseCommand: esimsa
label: esimsa
doc: "esimsa\n\nTool homepage: http://www.ms-utils.org/esimsa.html"
inputs:
  - id: peaklist
    type: File
    doc: peaklist
    inputBinding:
      position: 1
  - id: max_charge
    type: int
    doc: max charge
    inputBinding:
      position: 2
outputs:
  - id: output
    type: File
    doc: output
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esimsa:1.0--0
