cwlVersion: v1.2
class: CommandLineTool
baseCommand: headrest
label: ucsc-headrest
doc: "Copy all but the first N lines of a file.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: num_lines
    type: int
    doc: Number of lines to skip from the beginning of the file
    inputBinding:
      position: 1
  - id: files
    type:
      type: array
      items: File
    doc: Input file(s) to process
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-headrest:482--h0b57e2e_0
stdout: ucsc-headrest.out
