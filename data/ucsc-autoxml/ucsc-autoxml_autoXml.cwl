cwlVersion: v1.2
class: CommandLineTool
baseCommand: autoXml
label: ucsc-autoxml_autoXml
doc: "The provided text does not contain help information for the tool. It is a system
  error log indicating a failure to build or extract the container image (no space
  left on device).\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-autoxml:482--h0b57e2e_0
stdout: ucsc-autoxml_autoXml.out
