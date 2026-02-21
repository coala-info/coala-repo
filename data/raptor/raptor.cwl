cwlVersion: v1.2
class: CommandLineTool
baseCommand: raptor
label: raptor
doc: "No description available from the provided text.\n\nTool homepage: https://github.com/seqan/raptor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/raptor:3.0.1--haf24da9_4
stdout: raptor.out
