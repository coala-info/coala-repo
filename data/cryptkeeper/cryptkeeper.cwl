cwlVersion: v1.2
class: CommandLineTool
baseCommand: cryptkeeper
label: cryptkeeper
doc: "The provided text is a log of a failed container build/execution and does not
  contain help information or argument definitions for the tool.\n\nTool homepage:
  https://github.com/barricklab/cryptkeeper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cryptkeeper:1.0.1--pyhdfd78af_0
stdout: cryptkeeper.out
