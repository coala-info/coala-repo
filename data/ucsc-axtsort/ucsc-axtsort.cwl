cwlVersion: v1.2
class: CommandLineTool
baseCommand: axtSort
label: ucsc-axtsort
doc: "Sort axt files. The input axt file is sorted by the target (first) sequence
  name and then by the target start position.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input
    type: File
    doc: Input axt file to be sorted
    inputBinding:
      position: 1
outputs:
  - id: output
    type: File
    doc: Output sorted axt file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-axtsort:482--h0b57e2e_0
