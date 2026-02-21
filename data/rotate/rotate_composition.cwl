cwlVersion: v1.2
class: CommandLineTool
baseCommand: rotate_composition
label: rotate_composition
doc: "The provided text does not contain help information or a description for the
  tool. It appears to be a log of a failed container build/execution error.\n\nTool
  homepage: https://github.com/richarddurbin/rotate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rotate:1.0--h577a1d6_1
stdout: rotate_composition.out
