cwlVersion: v1.2
class: CommandLineTool
baseCommand: methurator
label: methurator
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime error logs.\n\nTool homepage: https://github.com/VIBTOBIlab/methurator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methurator:2.1.1--pyhdfd78af_0
stdout: methurator.out
