cwlVersion: v1.2
class: CommandLineTool
baseCommand: isonclust3
label: isonclust3
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime error messages regarding a failure to build
  the SIF format due to insufficient disk space.\n\nTool homepage: https://github.com/aljpetri/isONclust3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isonclust3:0.3.0--h4349ce8_0
stdout: isonclust3.out
