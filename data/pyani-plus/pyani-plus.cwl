cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyani-plus
label: pyani-plus
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime log messages and a fatal error regarding image
  fetching.\n\nTool homepage: https://github.com/pyani-plus/pyani-plus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyani-plus:1.0.0--pyhdfd78af_0
stdout: pyani-plus.out
