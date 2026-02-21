cwlVersion: v1.2
class: CommandLineTool
baseCommand: sam-algorithm
label: sam-algorithm
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains container runtime log messages and a fatal error regarding
  image fetching.\n\nTool homepage: https://github.com/atarashansky/self-assembling-manifold"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sam-algorithm:1.0.2--pyhdfd78af_0
stdout: sam-algorithm.out
