cwlVersion: v1.2
class: CommandLineTool
baseCommand: phertilizer
label: phertilizer
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime error logs.\n\nTool homepage: https://github.com/elkebir-group/phertilizer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phertilizer:0.1.0--pyhdfd78af_0
stdout: phertilizer.out
