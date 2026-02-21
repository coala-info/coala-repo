cwlVersion: v1.2
class: CommandLineTool
baseCommand: snkmt
label: snkmt
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a failed container build process for the snkmt tool.\n\nTool homepage:
  https://github.com/cademirch/snkmt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snkmt:0.2.4--pyhdfd78af_0
stdout: snkmt.out
