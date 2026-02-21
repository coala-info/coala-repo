cwlVersion: v1.2
class: CommandLineTool
baseCommand: derna
label: derna
doc: "The provided text does not contain help information for the tool 'derna'. It
  contains system log messages and a fatal error regarding container image conversion
  and disk space.\n\nTool homepage: https://github.com/elkebir-group/derna"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/derna:1.0.4--h503566f_1
stdout: derna.out
