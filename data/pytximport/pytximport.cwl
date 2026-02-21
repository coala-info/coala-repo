cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytximport
label: pytximport
doc: "The provided text does not contain help information or usage instructions for
  pytximport; it is a log of a failed container build/fetch process.\n\nTool homepage:
  https://pytximport.readthedocs.io/en/latest/start.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytximport:0.12.0--pyhdfd78af_0
stdout: pytximport.out
