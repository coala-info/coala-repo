cwlVersion: v1.2
class: CommandLineTool
baseCommand: diff
label: diffutils
doc: "The diffutils package contains the diff, cmp, diff3, and sdiff utilities for
  comparing files.\n\nTool homepage: https://github.com/uutils/diffutils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diffutils:3.10
stdout: diffutils.out
