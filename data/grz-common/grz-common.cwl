cwlVersion: v1.2
class: CommandLineTool
baseCommand: grz-common
label: grz-common
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime environment.\n\nTool homepage:
  https://github.com/BfArM-MVH/grz-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grz-common:1.6.1--pyhdfd78af_0
stdout: grz-common.out
