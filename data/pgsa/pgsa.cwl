cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgsa
label: pgsa
doc: "The provided text does not contain help information or usage instructions for
  the tool 'pgsa'. It consists of execution logs indicating a fatal error where the
  executable was not found.\n\nTool homepage: http://sun.aei.polsl.pl/pgsa/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgsa:1.2--hfc679d8_1
stdout: pgsa.out
