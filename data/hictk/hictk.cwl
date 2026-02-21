cwlVersion: v1.2
class: CommandLineTool
baseCommand: hictk
label: hictk
doc: "A tool for processing Hi-C data (Note: The provided text contains container
  runtime errors rather than the tool's help documentation).\n\nTool homepage: https://github.com/paulsengroup/hictk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hictk:2.2.0--h75fee6f_0
stdout: hictk.out
