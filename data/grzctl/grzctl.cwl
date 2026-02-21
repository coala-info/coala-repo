cwlVersion: v1.2
class: CommandLineTool
baseCommand: grzctl
label: grzctl
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime error logs.\n\nTool homepage: https://github.com/BfArM-MVH/grz-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
stdout: grzctl.out
