cwlVersion: v1.2
class: CommandLineTool
baseCommand: vgan_duprm
label: vgan_duprm
doc: "Remove duplicates from GAM file.\n\nTool homepage: https://github.com/grenaud/vgan"
inputs:
  - id: sorted_input_gam
    type: File
    doc: Sorted input GAM file
    inputBinding:
      position: 1
outputs:
  - id: output_gam
    type: File
    doc: Output GAM file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgan:3.1.0--h9ee0642_0
