cwlVersion: v1.2
class: CommandLineTool
baseCommand: grz-check
label: grz-check_grz-cli
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime error logs indicating a failure to build the
  SIF format due to lack of disk space.\n\nTool homepage: https://github.com/BfArM-MVH/grz-tools/packages/grz-check"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grz-check:0.2.1--h3ec5717_0
stdout: grz-check_grz-cli.out
