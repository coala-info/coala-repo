cwlVersion: v1.2
class: CommandLineTool
baseCommand: quasildr
label: quasildr
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container build process.\n\nTool homepage: https://github.com/jzthree/quasildr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quasildr:0.2.2--pyhdfd78af_0
stdout: quasildr.out
