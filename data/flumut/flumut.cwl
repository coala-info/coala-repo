cwlVersion: v1.2
class: CommandLineTool
baseCommand: flumut
label: flumut
doc: "The provided text does not contain a description of the tool; it consists of
  container runtime error logs.\n\nTool homepage: https://github.com/izsvenezie-virology/FluMut"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flumut:0.6.4--pyhdfd78af_0
stdout: flumut.out
