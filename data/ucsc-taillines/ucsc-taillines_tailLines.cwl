cwlVersion: v1.2
class: CommandLineTool
baseCommand: tailLines
label: ucsc-taillines_tailLines
doc: "Add tail to each line of file and print to stdout.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: file
    type: File
    doc: Input file
    inputBinding:
      position: 1
  - id: tail
    type: string
    doc: Tail to add to each line
    inputBinding:
      position: 2
outputs:
  - id: output
    type: stdout
    doc: The input lines with the tail added
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-taillines:482--h0b57e2e_0
stdout: ucsc-taillines_tailLines.out
