cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslPretty
label: ucsc-pslpretty
doc: "The provided text does not contain help information for the tool, as it consists
  of container runtime log messages and a fatal error. pslPretty is typically used
  to display PSL alignment files in a more readable format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslpretty:482--h0b57e2e_0
stdout: ucsc-pslpretty.out
