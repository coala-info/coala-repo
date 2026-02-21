cwlVersion: v1.2
class: CommandLineTool
baseCommand: peewee
label: peewee
doc: "The provided text does not contain help information or a description for the
  tool; it is a log showing a fatal error where the executable was not found.\n\n
  Tool homepage: https://github.com/coleifer/peewee"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peewee:2.8.0--py35_1
stdout: peewee.out
