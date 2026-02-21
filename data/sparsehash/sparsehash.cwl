cwlVersion: v1.2
class: CommandLineTool
baseCommand: sparsehash
label: sparsehash
doc: "The provided text is an error log from a container build process and does not
  contain help information or usage instructions for the sparsehash tool.\n\nTool
  homepage: https://github.com/sparsehash/sparsehash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sparsehash:2.0.3--0
stdout: sparsehash.out
