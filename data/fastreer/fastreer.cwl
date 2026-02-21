cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastreer
label: fastreer
doc: "FastReer (Note: The provided input text contains container runtime error messages
  regarding disk space and does not contain the actual help documentation or argument
  definitions for the tool).\n\nTool homepage: https://github.com/gkanogiannis/fastreeR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastreer:2.1.3--pyhdfd78af_0
stdout: fastreer.out
