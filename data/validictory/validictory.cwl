cwlVersion: v1.2
class: CommandLineTool
baseCommand: validictory
label: validictory
doc: "A general purpose validation schema for python data structures (Note: The provided
  text contains container build logs rather than CLI help documentation, so no arguments
  could be extracted).\n\nTool homepage: https://github.com/jpmckinney/validictory"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/validictory:1.0.1--py35_0
stdout: validictory.out
