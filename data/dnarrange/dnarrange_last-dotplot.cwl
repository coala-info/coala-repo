cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnarrange_last-dotplot
label: dnarrange_last-dotplot
doc: "The provided text contains error logs related to a container execution failure
  (no space left on device) rather than the tool's help documentation. As a result,
  no arguments or descriptions could be extracted from the input.\n\nTool homepage:
  https://github.com/mcfrith/dnarrange"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnarrange:1.6.3--pyh7e72e81_0
stdout: dnarrange_last-dotplot.out
