cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnabridge-denovo
label: rnabridge-denovo
doc: "Parameters Error\n\nTool homepage: https://github.com/Shao-Group/rnabridge-denovo"
inputs:
  - id: input_read1
    type: File
    doc: input read1
    inputBinding:
      position: 1
  - id: input_read2
    type: File
    doc: input read2
    inputBinding:
      position: 2
outputs:
  - id: output_bridge_sequence
    type: File
    doc: output bridge sequence
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnabridge-denovo:1.0.1--hc9558a2_0
