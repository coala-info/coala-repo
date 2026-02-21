cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyrle
label: pyrle
doc: "The provided text is a container engine log and does not contain the help documentation
  for the 'pyrle' tool. As a result, no arguments or tool descriptions could be extracted.\n
  \nTool homepage: https://github.com/endrebak/pyrle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyrle:0.0.43--py311haab0aaa_0
stdout: pyrle.out
