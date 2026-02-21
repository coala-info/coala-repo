cwlVersion: v1.2
class: CommandLineTool
baseCommand: treesimulator
label: treesimulator
doc: "The provided text does not contain help information or usage instructions for
  the tool 'treesimulator'. It is a system error log indicating a failure to build
  or extract a container image due to insufficient disk space.\n\nTool homepage: https://github.com/evolbioinfo/treesimulator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treesimulator:0.2.27--pyhdfd78af_0
stdout: treesimulator.out
