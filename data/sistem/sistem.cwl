cwlVersion: v1.2
class: CommandLineTool
baseCommand: sistem
label: sistem
doc: "The provided text does not contain help information or usage instructions for
  the 'sistem' tool; it appears to be a log of a failed container build process.\n
  \nTool homepage: https://github.com/samsonweiner/sistem"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sistem:1.0.4--pyhdfd78af_0
stdout: sistem.out
