cwlVersion: v1.2
class: CommandLineTool
baseCommand: morpheus
label: morpheus
doc: "Morpheus is a modeling and simulation framework for multiscale and multicellular
  systems. (Note: The provided text contains only system error messages and no usage
  information; therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/cwenger/Morpheus/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/morpheus:290--h9ee0642_0
stdout: morpheus.out
