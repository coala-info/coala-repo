cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vgan
  - duprm
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
    type: stdout
    doc: GAM file without duplicates, written to standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgan:3.1.0--h9ee0642_0
stdout: vgan_duprm.gam
