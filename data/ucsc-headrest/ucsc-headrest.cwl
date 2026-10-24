cwlVersion: v1.2
class: CommandLineTool
baseCommand: headRest
label: ucsc-headrest
doc: "Return all but the first N lines of a file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: count
    type: int
    doc: Number of lines to skip at the start of the file
    inputBinding:
      position: 1
  - id: file_name
    type: File
    doc: Input file
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Input file without its first N lines
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-headrest:482--h0b57e2e_0
stdout: ucsc-headrest.out
