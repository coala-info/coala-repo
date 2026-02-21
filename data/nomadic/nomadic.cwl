cwlVersion: v1.2
class: CommandLineTool
baseCommand: nomadic
label: nomadic
doc: "The provided text does not contain help information or usage instructions for
  the tool 'nomadic'. It contains system log messages and a fatal error related to
  a container runtime environment.\n\nTool homepage: https://jasonahendry.github.io/nomadic/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nomadic:0.7.2--pyhdfd78af_0
stdout: nomadic.out
