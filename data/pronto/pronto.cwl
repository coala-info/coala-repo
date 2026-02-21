cwlVersion: v1.2
class: CommandLineTool
baseCommand: pronto
label: pronto
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build/fetch process.\n\nTool
  homepage: https://github.com/althonos/pronto"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pronto:2.6.0--pyhdfd78af_0
stdout: pronto.out
