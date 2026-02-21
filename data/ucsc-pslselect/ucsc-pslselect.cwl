cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslSelect
label: ucsc-pslselect
doc: "Select records from a PSL file based on various criteria.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslselect:482--h0b57e2e_0
stdout: ucsc-pslselect.out
