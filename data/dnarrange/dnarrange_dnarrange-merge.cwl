cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dnarrange
  - merge
label: dnarrange_dnarrange-merge
doc: "The provided text contains system error messages related to a container runtime
  failure and does not include the help documentation for the tool. As a result, no
  arguments could be extracted.\n\nTool homepage: https://github.com/mcfrith/dnarrange"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnarrange:1.6.3--pyh7e72e81_0
stdout: dnarrange_dnarrange-merge.out
