cwlVersion: v1.2
class: CommandLineTool
baseCommand: skmer
label: skmer
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a container image retrieval failure.\n\nTool homepage: https://github.com/shahab-sarmashghi/Skmer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skmer:3.3.0--pyh086e186_0
stdout: skmer.out
