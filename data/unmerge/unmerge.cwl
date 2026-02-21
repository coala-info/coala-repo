cwlVersion: v1.2
class: CommandLineTool
baseCommand: unmerge
label: unmerge
doc: "The provided text does not contain help information or a description of the
  tool's functionality, as it appears to be a container engine error log.\n\nTool
  homepage: https://github.com/andvides/unmerge.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unmerge:1.0--h87f3376_2
stdout: unmerge.out
