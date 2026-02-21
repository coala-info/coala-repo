cwlVersion: v1.2
class: CommandLineTool
baseCommand: nibSize
label: ucsc-nibsize
doc: "A tool to query the size of a .nib file. (Note: The provided help text contains
  only system error messages and no usage information.)\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-nibsize:482--h0b57e2e_0
stdout: ucsc-nibsize.out
