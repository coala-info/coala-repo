cwlVersion: v1.2
class: CommandLineTool
baseCommand: nemo-age
label: nemo-age
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains container runtime error messages related to a failure to build
  a SIF image from a Docker URI due to insufficient disk space.\n\nTool homepage:
  https://bitbucket.org/ecoevo/nemo-age-release"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nemo-age:0.30.0--h3053a90_5
stdout: nemo-age.out
