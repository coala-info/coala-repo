cwlVersion: v1.2
class: CommandLineTool
baseCommand: catDir
label: ucsc-catdir
doc: "Concatenate all files in a directory (and subdirectories) to stdout.\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: directory
    type: Directory
    doc: The directory containing files to concatenate
    inputBinding:
      position: 1
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Recurse into subdirectories
    inputBinding:
      position: 102
      prefix: -r
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-catdir:482--h0b57e2e_0
stdout: ucsc-catdir.out
