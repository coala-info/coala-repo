cwlVersion: v1.2
class: CommandLineTool
baseCommand: clippy
label: clippy
doc: "The provided text does not contain help information or usage instructions for
  the tool 'clippy'. It appears to be a log of a failed container build/execution
  due to insufficient disk space.\n\nTool homepage: https://github.com/ulelab/clippy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clippy:1.5.0--pyh3cd468f_1
stdout: clippy.out
