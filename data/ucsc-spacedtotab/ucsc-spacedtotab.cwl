cwlVersion: v1.2
class: CommandLineTool
baseCommand: spacedToTab
label: ucsc-spacedtotab
doc: "Convert fixed width space separated fields to tab separated. This requires two passes, so it cannot be done on a pipe.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input
    type: File
    doc: Input file with fixed width space separated fields
    inputBinding:
      position: 1
  - id: output_name
    type: string
    doc: Name of the output tab separated file
    inputBinding:
      position: 2
  - id: sizes
    type:
      - 'null'
      - string
    doc: Force it to have columns of the given widths (comma-separated list X,Y,Z). The final char in each column should be space or newline.
    inputBinding:
      position: 0
      prefix: -sizes=
      separate: false
outputs:
  - id: output
    type: File
    doc: Output tab separated file
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-spacedtotab:482--h0b57e2e_0
