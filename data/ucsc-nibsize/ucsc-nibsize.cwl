cwlVersion: v1.2
class: CommandLineTool
baseCommand: nibSize
label: ucsc-nibsize
doc: "Find the size of a .nib file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: nib_file
    type: File
    doc: The .nib file to check the size of.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-nibsize:482--h0b57e2e_0
stdout: ucsc-nibsize.out
