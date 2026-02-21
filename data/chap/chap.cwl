cwlVersion: v1.2
class: CommandLineTool
baseCommand: chap
label: chap
doc: "The provided text does not contain a description of the tool or its usage. It
  appears to be a log of a failed container build/execution error.\n\nTool homepage:
  https://github.com/channotation/chap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chap:0.9.1--h2df963e_2
stdout: chap.out
