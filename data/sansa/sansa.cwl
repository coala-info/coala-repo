cwlVersion: v1.2
class: CommandLineTool
baseCommand: sansa
label: sansa
doc: "The provided text does not contain help information or a description for the
  tool 'sansa'. It appears to be a log of a failed container build/fetch process.\n
  \nTool homepage: https://github.com/dellytools/sansa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sansa:0.2.5--h4d20210_0
stdout: sansa.out
