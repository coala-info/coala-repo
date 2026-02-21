cwlVersion: v1.2
class: CommandLineTool
baseCommand: genclust
label: genclust
doc: "A tool for genetic clustering (Note: The provided help text contains only container
  runtime error messages and does not list specific command-line arguments).\n\nTool
  homepage: http://www.math.unipa.it/~lobosco/genclust/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genclust:1.0--h470a237_0
stdout: genclust.out
