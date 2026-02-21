cwlVersion: v1.2
class: CommandLineTool
baseCommand: google-sparsehash
label: google-sparsehash
doc: "The google-sparsehash tool (Note: The provided help text contains only system
  error messages regarding container execution and does not list specific CLI arguments).\n
  \nTool homepage: https://github.com/benvanik/sparsehash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/google-sparsehash:2.0.3--1
stdout: google-sparsehash.out
