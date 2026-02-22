cwlVersion: v1.2
class: CommandLineTool
baseCommand: schavott
label: schavott
doc: "A tool for processing or analyzing data (description not provided in help text)\n\
  \nTool homepage: http://github.com/emilhaegglund/schavott"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schavott:0.5.0--py35_0
stdout: schavott.out
