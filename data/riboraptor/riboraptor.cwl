cwlVersion: v1.2
class: CommandLineTool
baseCommand: riboraptor
label: riboraptor
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/saketkc/riboraptor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboraptor:0.2.2--py36_0
stdout: riboraptor.out
