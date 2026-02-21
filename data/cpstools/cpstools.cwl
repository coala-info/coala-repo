cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpstools
label: cpstools
doc: "The provided text does not contain help information or usage instructions for
  cpstools; it is a log of a failed container build process due to insufficient disk
  space.\n\nTool homepage: https://github.com/Xwb7533/CPStools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
stdout: cpstools.out
