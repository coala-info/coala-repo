cwlVersion: v1.2
class: CommandLineTool
baseCommand: catUncomment
label: ucsc-catuncomment
doc: "Concatenate input files, removing lines that start with '#'. Output goes to
  standard output.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_files
    type:
      type: array
      items: File
    doc: Input file(s) to concatenate without comment lines
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Concatenated input without lines that start with '#'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-catuncomment:482--h0b57e2e_0
stdout: ucsc-catuncomment.out
