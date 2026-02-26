cwlVersion: v1.2
class: CommandLineTool
baseCommand: tailLines
label: ucsc-taillines_tailLines
doc: "add tail to each line of file\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: file
    type: File
    doc: file
    inputBinding:
      position: 1
  - id: tail
    type: string
    doc: tail to add to each line
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-taillines:482--h0b57e2e_0
stdout: ucsc-taillines_tailLines.out
